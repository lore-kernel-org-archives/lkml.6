Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeFDUIS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:08:18 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53954 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:08:17 -0400
Message-ID: <1528142892.7898.124.camel@surriel.com>
Subject: Re: [PATCH 18/19] sched/numa: Reset scan rate whenever task moves
 across nodes
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 04 Jun 2018 16:08:12 -0400
In-Reply-To: <1528106428-19992-19-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-19-git-send-email-srikar@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-N5LzdW7ax8pySuo7Sqxj"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N5LzdW7ax8pySuo7Sqxj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-04 at 15:30 +0530, Srikar Dronamraju wrote:
> Currently task scan rate is reset when numa balancer migrates the
> task
> to a different node. If numa balancer initiates a swap, reset is only
> applicable to the task that initiates the swap. Similarly no scan
> rate
> reset is done if the task is migrated across nodes by traditional
> load
> balancer.
>=20
> Instead move the scan reset to the migrate_task_rq. This ensures the
> task moved out of its preferred node, either gets back to its
> preferred
> node quickly or finds a new preferred node. Doing so, would be fair
> to
> all tasks migrating across nodes.

How does this impact performance of benchmarks
closer to real world workloads?

Not just the test cases measuring NUMA convergence.

--=20
All Rights Reversed.
--=-N5LzdW7ax8pySuo7Sqxj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsVnCwACgkQznnekoTE
3oPRhggAn8cEETy6e+AhFcWGL2Jlnzp68NkKgD9U1BLT+lj5ZPSvWUoenfg0pbuK
vLeNoxtjb+4TtT0O+LO+P64xuBksrbmtU+Dr5dTskDcvEF6DBSfZQICZw8b7tAdq
GyHBZwnRkloKlfl8YIox1qCX5c6A2hEgmJM03pI+S0OIz8x4vN4iFlkSlBGfek33
Y5byKSeod3O4WyeZ0kymbbDB73yKmU2rerShWppbufVH+LkX2jS8zNUiekqJk+BJ
7PU6GsqOAUS07l3pt/VB0o4UjKv50ZuevFfOGadHc/lxTpSTm7XFiA07Ejg9lqfB
CsCAAct3rW1o4YIQXy2PdfqOseIA8A==
=4+Gb
-----END PGP SIGNATURE-----

--=-N5LzdW7ax8pySuo7Sqxj--
