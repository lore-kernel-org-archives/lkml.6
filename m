Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCJKiP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 05:38:15 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:56244 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCJKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 05:38:13 -0500
X-Google-Smtp-Source: AG47ELvYFIdmoNDz0gq3wwiQy7ysS29Z6zXTNVmMCwB5neY30KZboCFDFsG5F/nQh+9Y/SThvoYOPA==
Date: Sat, 10 Mar 2018 11:38:09 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: kai.heng.feng@canonical.com, mjg59@srcf.ucam.org, dvhart@infradead.org,
        andy@infradead.org, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180310103809.5nnwoulua2u64rku@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
 <20180309094600.m24d3zbzdsmls7aw@pali>
 <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xmle47knctbp44v4"
Content-Disposition: inline
In-Reply-To: <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xmle47knctbp44v4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 09 March 2018 09:59:39 Mario.Limonciello@dell.com wrote:
> > > Pali is your concern that this code for matching vendor/subsystem is =
running
> > > on non-Dell too?  The only other recommendation I think that can be t=
o restrict
> > > to matching Dell OEM strings in SMBIOS table, but I don't think that'=
s any better
> > > than the matching for VID/SSVID.
> >=20
> > My concern is about adding a new machine specific code into generic
> > driver, which check is done just by PCI vendor and subvendor.
> >=20
> > In future there can be new models or other PCI devices which matches
> > above condition even they would not have any switchable graphics, nor
> > they would manufactured by Dell.
>=20
> Uh Dell subsystem ID means it's Dell no?

What would prevent you to take PCI device marked with Dell ID and put it
into non-Dell computer? I do not believe that Dell PCI devices are
configured to work only in Dell branded devices and refuse to power up
in others.

If there is Dell ID then it just means that PCI device itself is Dell's.
And not that machine in which that device is plugged is also Dell.

> > Also I can imagine that in future (or maybe already now?) it is possible
> > to find PCI device which pass above checks and connect this PCI device
> > into desktop /server / any non-laptop device.
> >=20
> > If this switchable graphics solution is specific to dell laptops, then
> > rather checking for PCI vendor/subvevendor main check, there should be
> > main check via DMI strings.
>=20
> Right now this is affected to both AIO desktop and laptops.
>=20
> IIRC you won't end up with switchable graphics in traditional desktop tha=
t you
> can remove PCI card.  If this code was run on a traditional desktop with =
a=20
> AMD PCI card that BIOS query result should be invalid token (which will i=
nfer
> switchable off to this routine).
>=20
> >=20
> > Hardware is changing relatively quickly and there is absolutely no
> > guarantee that e.g. NVIDIA would not start providing audio controller in
> > similar like AMD and it would be put in those Dell machines.
>=20
> Kai Heng can explain exactly why NVIDIA isn't affected.
> This is probably good information to include in the commit message too.

Yes, extending commit message is a good idea.

But here I'm talking about future, NVIDIA cards could be in future.

I still think that whitelisting devices based on vendor ID by some
measurements at one time is a bad idea. It is fragile which can stop
working in the future.

> >=20
> > > > >
> > > > > Interesting question would be, how handle this situation Windows?
> > > >
> > > > I don't know how this platform handles this on Windows, I guess we =
need
> > > > Mario to shed some lights here.
> > >
> > > Sorry I don't have this information to share.   I don't think it's to=
o useful here
> > > anyway though because Windows driver architecture is much different i=
n this
> > > area.
> > >
> > >
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xmle47knctbp44v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqO1jwAKCRCL8Mk9A+RD
UjWiAJoC8sd+feNPyg2NBQm6WK3W1QAW0QCgk2dEp4gnIcfgUOUIm84cFuuYfXQ=
=mCrW
-----END PGP SIGNATURE-----

--xmle47knctbp44v4--
