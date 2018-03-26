Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCZVsf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:48:35 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55426 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbeCZVse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:48:34 -0400
Message-ID: <1522100902.6308.60.camel@surriel.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
From: Rik van Riel <riel@surriel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 17:48:22 -0400
In-Reply-To: <CAJZ5v0itoXKB+46w+yb1N5zyYF4bNsZ-1dgm2KqF2oDM426M6w@mail.gmail.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
         <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>
         <5810003.D8QGLjubHr@aspire.rjw.lan> <1522081932.6308.54.camel@surriel.com>
         <CAJZ5v0itoXKB+46w+yb1N5zyYF4bNsZ-1dgm2KqF2oDM426M6w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-U3BNb7gsyiUFaRPejQ5Y"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U3BNb7gsyiUFaRPejQ5Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-26 at 23:44 +0200, Rafael J. Wysocki wrote:
> On Mon, Mar 26, 2018 at 6:32 PM, Rik van Riel <riel@surriel.com>
> wrote:
> > On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
> >=20
> > I tried that, as well, and some other variations.
> >=20
> > Every single change to poll_idle() that I tried
> > seems to result in a 9-10% relative increase in
> > CPU use during the peak load of the test.
> >=20
> > During the busiest parts of the load, every CPU
> > sees on the order of 20k context switches a second.

... and I did something wrong in the tests :/

> Hmm.  Basically, you are saying that
>=20
> while (something)
>     cpu_relax();
>=20
> is measurably less overhead than
>=20
> while (something) {
>     cpu_relax();
>     check something else;
>     cpu_relax();
> }
>=20
> which honestly makes me wonder how this is possible at all.

Part of the mystery is solved. Apparently the
control kernel was not the one I thought it
was, or the one that was printed in the=20
output messages :(

I am re-running the tests now with a few
variations, and seeing what works best.

My apologies for wasting everybody's time.

I should have valid results later tonight.
Fingers crossed.

--=20
All Rights Reversed.
--=-U3BNb7gsyiUFaRPejQ5Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq5aqYACgkQznnekoTE
3oN4VwgAtfoJxcK52dl8HW2KC+Z2Sn8ysHIVzWCk5Un8HDvveCkMY7zDLOIqrosS
DCZ/v4HY9FqtPfWv1fayKkUSvsFHpm+Rj1ATEwZLigud5vqabWkr/Sb0ysSIRoLc
2z7N5XW+p4mZeijZAxSv6iCyO3KUcPgcTS3V5P41Xll0EIqTR2upy01gpam+33bu
UBEk8omiG30xvazRbkFbtwi1NARWU2m3lezmv1i9t7PZgQ3AtfrxgpCK6JTFiC0b
VuxQi8uXJoR3dJ61jmxNS0z5LJzP8Rb76zqkX68atgKEbX/+YimmDo/uNKC10zOx
20NUirm2kZGv71qChH+ZNH939foteg==
=BtGk
-----END PGP SIGNATURE-----

--=-U3BNb7gsyiUFaRPejQ5Y--
