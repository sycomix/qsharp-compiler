﻿// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Testing.QIR
{
    operation Empty (qs : Qubit[]) : Unit is Adj + Ctl {
    }

    operation DoNothing (qs : Qubit[]) : Unit is Adj + Ctl {
        let dummy = 1;
    }

    function ReturnDoNothing () : (Qubit[] => Unit is Adj + Ctl)
    {
        return DoNothing;
    }

    operation X (q : Qubit) : Unit is Adj + Ctl {
        body intrinsic;
    }

    operation CNOT (control : Qubit, target : Qubit) : Unit
    is Adj + Ctl {

        body (...) {
            Controlled X([control], target);
        }
        
        adjoint self;
    }

    @EntryPoint()
    operation GetEnergyHydrogenVQE() : Unit {

        let doNothing = ReturnDoNothing();
        using (aux = Qubit())
        {
            CNOT(aux, aux);
            Empty([aux]);
            doNothing([aux]);
            Controlled DoNothing([aux], [aux]);
        }
    }
}
