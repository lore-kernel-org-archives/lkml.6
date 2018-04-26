Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756775AbeDZUiQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:38:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49424 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754137AbeDZUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:38:15 -0400
Date: Thu, 26 Apr 2018 22:38:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: salyzyn@android.com, mingo@kernel.org, peterz@infradead.org,
        john.stultz@linaro.org, hpa@zytor.com, mtk.manpages@gmail.com,
        prarit@redhat.com, torvalds@linux-foundation.org, rostedt@goodmis.org,
        kevin@guarana.org, dmitry.torokhov@gmail.com, pmladek@suse.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de, corbet@lwn.net
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and
 CLOCK_BOOTTIME
Message-ID: <20180426203811.GA9975@amd>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-25 06:45:50, tip-bot for Thomas Gleixner wrote:
> Commit-ID:  757d5a9b3052a4eebd029f207f1e1df59bef7b7d
> Gitweb:     https://git.kernel.org/tip/757d5a9b3052a4eebd029f207f1e1df59b=
ef7b7d
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Wed, 25 Apr 2018 15:33:38 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 25 Apr 2018 15:35:08 +0200
>=20
> Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
>=20
> Revert commits
>=20
> 92af4dcb4e1c ("tracing: Unify the "boot" and "mono" tracing clocks")
> 127bfa5f4342 ("hrtimer: Unify MONOTONIC and BOOTTIME clock behavior")
> 7250a4047aa6 ("posix-timers: Unify MONOTONIC and BOOTTIME clock behavior")
> d6c7270e913d ("timekeeping: Remove boot time specific code")
> f2d6fdbfd238 ("Input: Evdev - unify MONOTONIC and BOOTTIME clock behavior=
")
> d6ed449afdb3 ("timekeeping: Make the MONOTONIC clock behave like the BOOT=
TIME clock")
> 72199320d49d ("timekeeping: Add the new CLOCK_MONOTONIC_ACTIVE clock")
>=20
> As stated in the pull request for the unification of CLOCK_MONOTONIC and
> CLOCK_BOOTTIME, it was clear that we might have to revert the change.
>=20
> As reported by several folks systemd and other applications rely on the
> documented behaviour of CLOCK_MONOTONIC on Linux and break with the above
> changes. After resume daemons time out and other timeout related issues a=
re
> observed.
>=20
> It's sad, that these problems were neither catched in -next nor by those
> folks who expressed interest in this change.
>=20
> Reported-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Reported-by: Genki Sky <sky@genki.is>,

Tested-by: Pavel Machek <pavel@ucw.cz>

Both screensaver problem and network problems are gone on X60 after I
applied the revert. (I did not do too many tests, but it was normally
too easy to reproduce.)

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlriOLMACgkQMOfwapXb+vITGgCgiPg7wrJ05luey+xRlRBYOvOz
T/oAnjR6xXCKQR+7GGD9PiCxxuVKCkp1
=oWTN
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
