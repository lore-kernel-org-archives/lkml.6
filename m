Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeCLXSu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:18:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36653 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeCLXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:18:49 -0400
Date: Tue, 13 Mar 2018 00:18:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Message-ID: <20180312231847.GB7612@amd>
References: <20180312194715.GA3992@amd>
 <20180312194944.GA3979@amd>
 <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
 <20180312223521.vzccevf6z7ik5ysf@thinkpad>
 <20180312230407.GA7612@amd>
 <CAJZ5v0irEfMxURr2c8VZ=SZhsW+MWxRd4OwDH5bS6P=R3a0REw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irEfMxURr2c8VZ=SZhsW+MWxRd4OwDH5bS6P=R3a0REw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > >> Fully charged
> >> > >> battery shows as empty battery with red "x" in Mate desktop. After
> >> > >> reboot to recent mainline problem goes away. Tooltip says "battery
> >> > >> waiting to charge".
> >> > >>
> >>
> >> For the MATE bug see:
> >> https://github.com/mate-desktop/mate-power-manager/pull/251
> >>
> >> The problem is in the new composite battery system in UPower, it
> >> "merges" two external batteries into a single one for reporting. That
> >> battery does not understand "Not Charging" inside the MATE Power
> >> Manager. The above patch fixes that in MATE.
> >
> > Ok, so problem is 91eea70e5e5ce12eb1c7cd922e561fab43e201bd.
> >
> > And now, I see that MATE should be improved.
> >
> > But what I also see is that kernel is changing its interface in a way
> > that (while making sense) breaks existing application. And we don't
> > break existing applications.
> >
> > [Now... maybe if the fix for the application is available for long
> > long time and noone is really looking and everyone already has new
> > application version, maybe ... But pull request for MATE is 9 days
> > old, and not even merged. So there is no way this is suitable for
> > 4.17.]
>=20
> Right.
>=20
> This basically means that we will have to defer the battery changes
> until user space is ready and not just upstream, but also in distro
> packages.

Yes please.

Note that only 91eea70e5e5ce12eb1c7cd922e561fab43e201bd should break
anything, the others should be safe AFAICT?

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqnCtYACgkQMOfwapXb+vIY3wCghlVK7leroKKt/qWaiSwyyh1F
qDIAnjLq6SzoIV3sF2Hhh1+KDhVzmUz+
=O48s
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
