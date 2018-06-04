Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeFDR7c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:59:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53672 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeFDR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:59:31 -0400
Message-ID: <1528135170.7898.113.camel@surriel.com>
Subject: Re: [PATCH 11/19] sched/numa: Restrict migrating in parallel to the
 same node.
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 13:59:30 -0400
In-Reply-To: <1528106428-19992-12-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-12-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-M9gQjdaWU+P8s3O/lyZE"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M9gQjdaWU+P8s3O/lyZE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> Since task migration under numa balancing can happen in parallel,
> more
> than one task might choose to move to the same node at the same time.
> This can cause load imbalances at the node level.
>=20
> The problem is more likely if there are more cores per node or more
> nodes in system.
>=20
> Use a per-node variable to indicate if task migration
> to the node under numa balance is currently active.
> This per-node variable will not track swapping of tasks.

> The commit does cause some performance regression but is needed from
> a fairness/correctness perspective.

Does it help any "real workloads", even simple things
like SpecJBB2005?

If this patch only causes regressions, and does not help
any workloads, I would argue that it is not in fact needed.

--=20
All Rights Reversed.
--=-M9gQjdaWU+P8s3O/lyZE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVfgIACgkQznnekoTE
3oPMvwgAkzjioIrsHYjus5SI4uFsOza1t5Nub0dXNfyxikjymRWDzCNeDgLOiuY2
m1wMnplkuwMqrrWtJcIEzQDIuHGTc/w7W63WKt4jQDT7oWYY5/gkHqbamQvxDryK
WkZFS4WXrO25zycqlBCkvuVo4vkhckS03mJ0G/QZLvVW3pLMTV+i+rpnVH9NToXY
sH/wCdZ7BxgNp1bFjT4g68Rg64NHSmCwCozuAMXxnneJLmvoo+uSbpA62xKp5TE0
3NN1rFE+ytRPijXPbr/MgnN6ozh2YxpmsyxBJ4HF4OPmF/i6vOUpxNd0YT45TY4g
xHn+cOxVFUPjynValYUUq0CQNT0Y7g==
=Y12M
-----END PGP SIGNATURE-----

--=-M9gQjdaWU+P8s3O/lyZE--
