Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeEGU22 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:28:28 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39149 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:28:26 -0400
X-Google-Smtp-Source: AB8JxZqJzus41ginWn31Ui+NKAoSPfJyTnscmShDtBleWWBQwCeDBIQcbklyVUnHpPaBr0v8EAA18w==
Date: Mon, 7 May 2018 22:28:22 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
Message-ID: <20180507202822.usgjneo7m35bsait@pali>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <20180506134733.zttaitnf6ej4tith@pali>
 <20180507084431.r2dipv32wt3vbx3k@pali>
 <20180507193306.GA31301@dtor-ws>
 <147aa25ad2d14bad975731a6c9cf9281@ausx13mpc124.AMER.DELL.COM>
 <20180507200733.s43zd2hfzw4f4wr2@pali>
 <6825f48ea6da41799979d83ed37adf73@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nuccfinepqjjvuie"
Content-Disposition: inline
In-Reply-To: <6825f48ea6da41799979d83ed37adf73@ausx13mpc124.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nuccfinepqjjvuie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 07 May 2018 20:18:30 Mario.Limonciello@dell.com wrote:
> > > > So I guess you could write a platform driver that would install i80=
42
> > > > filter on Dell laptops/portables, monitor keyboard data stream and =
kick
> > > > of rescans on serio ports. The problem is filter gets "serio" so yo=
u do
> > > > not really know whether ACK is spurious or not. And I would really
> > > > prefer keeping this crap out of atkbd proper... And all of this is =
racy
> > > > as hell. What happens if we get keyboard reconnected as we reinitia=
lize
> > > > it?
> > >
> > > If it's done as a platform driver I would suspect it's possible to te=
ll whether
> > > a dock is connected to at least give you some heuristic here to have =
a better
> > > guess whether it's spurious.
> >=20
> > Apparently checking for docking station is not enough. There are also
> > Dell Legacy Extenders (or how it is called) which exports internal PS/2,
> > Parallel and Serial Ports. It is also connecting to bottom of laptop.
> > But currently I do not have them for testing.
> >=20
> > > Pali on your system that supports this dock, check and see how many
> > > System Enclosure SMBIOS tables (structure type 03) are present.
> >=20
> > Do you mean DMI type 3 structure? Here is something from dmidecode:
> >=20
> > Handle 0x0003, DMI type 3, 22 bytes
> > Chassis Information
> >         Manufacturer: Dell Inc.
> >         Type: Laptop
> >         Lock: Not Present
> >         Version: Not Specified
> >         Serial Number: --REMOVED--
> >         Asset Tag: Not Specified
> >         Boot-up State: Safe
> >         Power Supply State: Safe
> >         Thermal State: Safe
> >         Security Status: None
> >         OEM Information: 0x00000000
> >         Height: Unspecified
> >         Number Of Power Cords: 1
> >         Contained Elements: 0
> >         SKU Number: To be filled by O.E.M.
> >=20
> > But probably you mean something different?
>=20
> Plug in your dock before you boot up and see if you have a second structu=
re like
> that type produced.

I already started docked laptop via dock power button. And in dmidecode
output is only one DMI type 3 block.

> If not, then I guess this isn't a reliable way to find the dock
> on that system and I'll have to see if there is another.

Seems not. Also detection of dock should work also when you connect
laptop at system runtime, not only when connected prior to booting.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nuccfinepqjjvuie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWvC25AAKCRCL8Mk9A+RD
UvuUAJ9lDC5yCUZrFXWXvOwFmW9h0q2UFgCgnJMVQVz2xux8mGavOauF9Q8Vlcs=
=NAGw
-----END PGP SIGNATURE-----

--nuccfinepqjjvuie--
