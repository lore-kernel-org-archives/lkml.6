Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbeDXMHC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:07:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43192 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeDXMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:07:01 -0400
Date: Tue, 24 Apr 2018 14:07:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: tglx@linutronix.de, dmitry.torokhov@gmail.com,
        torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: CLOCK_MONOTONIC, BOOTTIME, suspend and screensaver regression
Message-ID: <20180424120659.GA14411@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In 4.17-rc1 I have weird problems with network manager... and I also
have screensaver kicking just after resume.

Searching the git logs:

       - The most interesting change is the consolidation of clock
         MONOTONIC
	          and clock BOOTTIME.

         Clock MONOTONIC behaves now exactly like clock BOOTTIME and
         does
	          not longer ignore the time spent in suspend. A new
         clock
	          MONOTONIC_ACTIVE is provived which behaves like
         clock MONOTONIC in
	          kernels before this change. This allows applications
         to
	          programmatically check for the clock MONOTONIC
         behaviour.

         As discussed in the review thread, this has the potential of
	          breaking user space and we might have to revert
	          this. Knock on wood
		           that we can avoid that exercise.


=2E..I believe you are breaking userspace for me. How can we check that?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrfHeMACgkQMOfwapXb+vJxaQCfUXJa6CyGtTfQe76jGX0ejkBd
nqEAniT7xzWyqElQKqvfvEMJMxGrQAWo
=4BWM
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
