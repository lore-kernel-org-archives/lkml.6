Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeFDRAX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:00:23 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53552 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:00:22 -0400
Message-ID: <1528131620.7898.110.camel@surriel.com>
Subject: Re: [PATCH 09/19] sched/numa: Modify migrate_swap to accept
 additional params
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 13:00:20 -0400
In-Reply-To: <1528106428-19992-10-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-10-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jYRyRmgmsi2ZX1t/i1ZQ"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jYRyRmgmsi2ZX1t/i1ZQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> There are checks in migrate_swap_stop that check if the task/cpu
> combination is as per migrate_swap_arg before migrating.
>=20
> However atleast one of the two tasks to be swapped by migrate_swap
> could
> have migrated to a completely different cpu before updating the
> migrate_swap_arg. The new cpu where the task is currently running
> could
> be a different node too. If the task has migrated, numa balancer
> might
> end up placing a task in a wrong node.  Instead of achieving node
> consolidation, it may end up spreading the load across nodes.
>=20
> To avoid that pass the cpus as additional parameters.
>=20
> While here, place migrate_swap under CONFIG_NUMA_BALANCING.
>=20
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-jYRyRmgmsi2ZX1t/i1ZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVcCQACgkQznnekoTE
3oNvxAf6AiMtSlu6lzTuqMHvyKC2NN1CCwcnOXPXqzIjNXoNgB5I0nVYwHgBZF7t
DA1dRgZ1sk74Dt9ioBmLd22C/sT7j9XdFZQEpsKICXyQWDVhr1oscr9A0AZqY3Kq
81PBXda4AHKkMb/Fs0qUxu0c72rKFdE4a4l6uD/cTL9D6ik1lV3zBIVBYI/zuZpp
ZBmm+osc4n9sWvriHatys1kiFGWN/DQFNW5hbzjd2fTsK+wGo1FUxoPnfCvybOPd
GolajRKcC8R7XrHOHsvnUtD5d4SUpeMQtkaMvJOpW1QVPFE/Pz5ANSpNLMaLqT7K
j5gyRnQiy+KmzDhW4G+DaWjGlGYY2Q==
=vBkF
-----END PGP SIGNATURE-----

--=-jYRyRmgmsi2ZX1t/i1ZQ--
