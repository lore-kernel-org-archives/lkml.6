Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757239AbeDXMIS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:08:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43212 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756142AbeDXMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:08:07 -0400
Date: Tue, 24 Apr 2018 14:08:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: tglx@linutronix.de, dmitry.torokhov@gmail.com,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: CLOCK_MONOTONIC, BOOTTIME, suspend and screensaver regression
Message-ID: <20180424120806.GA14523@amd>
References: <20180424120659.GA14411@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20180424120659.GA14411@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-24 14:06:59, Pavel Machek wrote:
> Hi!
>=20
> In 4.17-rc1 I have weird problems with network manager... and I also
> have screensaver kicking just after resume.
>=20
> Searching the git logs:
>=20
>        - The most interesting change is the consolidation of clock
>          MONOTONIC
> 	          and clock BOOTTIME.
>=20
>          Clock MONOTONIC behaves now exactly like clock BOOTTIME and
>          does
> 	          not longer ignore the time spent in suspend. A new
>          clock
> 	          MONOTONIC_ACTIVE is provived which behaves like
>          clock MONOTONIC in
> 	          kernels before this change. This allows applications
>          to
> 	          programmatically check for the clock MONOTONIC
>          behaviour.
>=20
>          As discussed in the review thread, this has the potential of
> 	          breaking user space and we might have to revert
> 	          this. Knock on wood
> 		           that we can avoid that exercise.
>=20
>=20
> ...I believe you are breaking userspace for me. How can we check that?

And actually... how is it supposed to work? If monotonic behaves same
way as boottime, we'll have nasty thundering herd problem after
resume, riight?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrfHiYACgkQMOfwapXb+vK9JQCfZneqtlZBeL9zVoHXZ5wP+aFM
4IgAnR6kqqUfmm00CQdkqbGGV4w+DucL
=zupL
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
