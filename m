Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeFDOhe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:37:34 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50934 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFDOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:37:32 -0400
Message-ID: <1528123050.7898.99.camel@surriel.com>
Subject: Re: [PATCH 04/19] sched/numa: Set preferred_node based on best_cpu
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 10:37:30 -0400
In-Reply-To: <20180604125939.GB38574@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-5-git-send-email-srikar@linux.vnet.ibm.com>
         <20180604122336.GS12217@hirez.programming.kicks-ass.net>
         <20180604125939.GB38574@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yx+VoeBPYZ/jkcI2Rzj0"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yx+VoeBPYZ/jkcI2Rzj0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 05:59 -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-06-04 14:23:36]:
>=20
> > OK, the above matches the description, but I'm puzzled by the
> > remainder:
> >=20
> > >=20
> > > -		if (ng->active_nodes > 1 &&
> > > numa_is_active_node(env.dst_nid, ng))
> > > -			sched_setnuma(p, env.dst_nid);
> > > +		if (nid !=3D p->numa_preferred_nid)
> > > +			sched_setnuma(p, nid);
> > >  	}
> >=20
> > That seems to entirely loose the active_node thing, or are you
> > saying
> > best_cpu already includes that? (Changelog could use a little help
> > there
> > I suppose)
>=20
> I think checking for active_nodes before calling sched_setnuma was a
> mistake.
>=20
> Before this change, we may be retaining numa_preferred_nid to be the
> source node while we select another node with better numa affinity to
> run on.=20

Sometimes workloads are so large they get spread
around to multiple NUMA nodes.

In that case, you do NOT want all the tasks of
that workload (numa group) to try squeezing onto
the same load, only to have the load balancer
randomly move tasks off of that node again later.

How do you keep that from happening?

--=20
All Rights Reversed.
--=-yx+VoeBPYZ/jkcI2Rzj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVTqoACgkQznnekoTE
3oMv6gf/e+XjU8bS5G/mkPOc9AlMIK8KPBAMWH56QdxipZk7O8kbBOXSgMCNOcBf
l862+/CK6bTBky/Ol2ztzCVbvK0vqLHljZantJ3da5rjqq70zR45+FKmHmS67AjE
MRhUnyR0y0AU/QLJ/q5qK1F01zUColATBstisDl/qDWAarOI7Jl+fYqSKMzvjlV1
IlYbGXRybYzUj5xuCGnflGrYu1LoLvPVqFvNTdR50I1MGeGKXw9ZrW5ESo7yI9wT
w4FsCJqh+pcgvyksSrYsFzQpF3M+/2emQ+FPL6NzhVeFlR9MAbD2T4q1yvjwUZar
8MScwgjxLj8W58d6vAFDW37MFYW9fQ==
=36/e
-----END PGP SIGNATURE-----

--=-yx+VoeBPYZ/jkcI2Rzj0--
