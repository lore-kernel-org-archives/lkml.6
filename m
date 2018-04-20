Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeDTTP1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:15:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42478 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeDTTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:15:25 -0400
Date: Fri, 20 Apr 2018 21:15:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com,
        Patrik Bachan <patrikbachan@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>,
        Clayton Craft <clayton@craftyguy.net>,
        Martijn Braam <martijn@brixit.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Message-ID: <20180420191523.GA28597@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Hi! Sorry I lost this email in my inbox. It seems this is specific to
> >> a particular subset of arm architectures? (My local builds of arm all
> >> succeed, for example. Can you send your failing config?) I'll take a
> >> closer look on Monday if Daniel doesn't beat me to it.
> >
> > Daniel, Kees: any news?
> >
> > I'm aware you did not specify which Monday :-).
>=20
> Hi! Sorry, I got distracted. So the .config you sent me builds fine
> with my cross compiler. I suspect this is something specific to ELDK's
> compiler. I can try some other compiler versions. What version of gcc
> is failing?

I have:

pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (GCC) 4.7.2
Copyright (C) 2012 Free Software Foundation, Inc.
pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
GNU ld (GNU Binutils) 2.23.1.20121113
Copyright 2012 Free Software Foundation, Inc.

Let me try with eldk-5.6:

pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (GCC) 4.8.2
pavel@duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
GNU ld (GNU Binutils) 2.24

make  lib/string.o

Seems to succeed, so I guess full build will succeed, too...

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

iEYEARECAAYFAlraPEsACgkQMOfwapXb+vLpqQCfZzdMweK+fBKrKopKrBXtjmJD
Ij8An2WnhrtIadKiNek3cTcgluo2hBE5
=YfGS
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
