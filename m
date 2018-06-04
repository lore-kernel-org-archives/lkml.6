Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeFDR5f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:57:35 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53658 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeFDR5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:57:32 -0400
Message-ID: <1528135046.7898.111.camel@surriel.com>
Subject: Re: [PATCH 10/19] sched/numa: Stop multiple tasks from moving to
 the cpu at the same time
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 13:57:26 -0400
In-Reply-To: <1528106428-19992-11-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-11-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NxKfD/2Y+rhlAfibarDd"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NxKfD/2Y+rhlAfibarDd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> Task migration under numa balancing can happen in parallel. More than
> one task might choose to migrate to the same cpu at the same time.
> This
> can result in
> - During task swap, choosing a task that was not part of the
> evaluation.
> - During task swap, task which just got moved into its preferred
> node,
>   moving to a completely different node.
> - During task swap, task failing to move to the preferred node, will
> have
>   to wait an extra interval for the next migrate opportunity.
> - During task movement, multiple task movements can cause load
> imbalance.
>=20
> This problem is more likely if there are more cores per node or more
> nodes in the system.
>=20
> Use a per run-queue variable to check if numa-balance is active on
> the
> run-queue.

> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>=20

Reviewed-by: Rik van Riel <riel@surriel.com>
--=20
All Rights Reversed.
--=-NxKfD/2Y+rhlAfibarDd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVfYYACgkQznnekoTE
3oORwQf9HinMxuLzwEr+rQosWD7nhA08dAWtHbKMtJw+HJqs254cIKwjb54vqzgz
POShG1qGKkEis34DSfiVwFH+SCIvBPrOFK0kBR4Jg7diu26Rv+QrdMnxSASvZNlr
hd41tMxCzEkPrdfh0hRwI1j4DFRprChJnQ33PWAjGEkyN4YPYdt+pS09hcURkFIZ
Vu5JU7UmtSM2gePkHQiQ2eNdTOzvQUUjuKZPWThkJpv6KJKt9xgn2MYmIjqMsRj9
iKom7sP7O7ArvWVaQd5MN2Fdp5k6CkFyX2ObMGXeQSSrDE8+gA8jxQAl1M3+dBvm
68IHC1qeYQmM+HQmx4Ty6xGf6thiKA==
=zGt/
-----END PGP SIGNATURE-----

--=-NxKfD/2Y+rhlAfibarDd--
