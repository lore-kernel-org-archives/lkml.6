Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeC0WAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 18:00:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58450 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0WAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 18:00:42 -0400
Message-ID: <1522188032.6308.69.camel@surriel.com>
Subject: Re: [PATCH] cpuidle: poll_state: Avoid invoking local_clock() too
 often
From: Rik van Riel <riel@surriel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 27 Mar 2018 18:00:32 -0400
In-Reply-To: <2095821.OCbkRpinqI@aspire.rjw.lan>
References: <2095821.OCbkRpinqI@aspire.rjw.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XJsuFMo3JHh7LT5idPsA"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XJsuFMo3JHh7LT5idPsA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-03-27 at 23:58 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Rik reports that he sees an increase in CPU use in one benchmark
> due to commit 612f1a22f067 "cpuidle: poll_state: Add time limit to
> poll_idle()" that caused poll_idle() to call local_clock() in every
> iteration of the loop.  Utilization increase generally means more
> non-idle time with respect to total CPU time (on the average) which
> implies reduced CPU frequency.
>=20
> Doug reports that limiting the rate of local_clock() invocations
> in there causes much less power to be drawn during a CPU-intensive
> parallel workload (with idle states 1 and 2 disabled to enforce more
> state 0 residency).
>=20
> These two reports together suggest that executing local_clock() on
> multiple CPUs in parallel at a high rate may cause chips to get hot
> and trigger thermal/power limits on them to kick in, so reduce the
> rate of local_clock() invocations in poll_idle() to avoid that issue.
>=20
> Fixes: 612f1a22f067 "cpuidle: poll_state: Add time limit to
> poll_idle()"
> Reported-by: Rik van Riel <riel@surriel.com>
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks Rafael!

Tested-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.
--=-XJsuFMo3JHh7LT5idPsA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq6vwAACgkQznnekoTE
3oMnNQf/S5PPW9YhHCQoQxSic+HG8bYUz4NH5Drdcl4fOGtDJX3mMUXnmhcE/0hO
Lkiq50x/nlO85fNKDF4xSQQ8ZIeO2KDKe0aGi8MXrrjJ2vfwtS/O9A8NObpZSKXL
pnzTek52GXi9vIenV+asBNl8HtDW/3mSPf5i17YtZ+57IoXlNInKYN4LSfW6JJWq
yg/I5QG6dJapU9OXr3vGAw1hIL61hJAxmMuDASu6rnhouhQlMCFuPFwR8lGwCIJD
EHK3ZIW43C9OjnorhfGBPik3eRIu7qbrmrFJA5VyLWEHcTE0RMaX2vsRLH5ZjUcl
o13gbrkidSBG7kL5g62rPRQaXoWlPg==
=2kTS
-----END PGP SIGNATURE-----

--=-XJsuFMo3JHh7LT5idPsA--
