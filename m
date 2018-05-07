Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeEGHa3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:30:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43390 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbeEGHa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:30:26 -0400
Date: Mon, 7 May 2018 09:30:13 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
Message-ID: <20180507073013.dvtbmwi4ora6tdj2@flea>
References: <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
 <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
 <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
 <20180504080652.dniwaqqhbeuknp7y@flea>
 <afc78821-2d08-3f4f-d008-5b2d216e96c0@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o7fuc4npexahvokm"
Content-Disposition: inline
In-Reply-To: <afc78821-2d08-3f4f-d008-5b2d216e96c0@micronovasrl.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o7fuc4npexahvokm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 11:52:59PM +0200, Giulio Benetti wrote:
> Hi Maxime!
>=20
> Il 04/05/2018 10:06, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Wed, May 02, 2018 at 06:41:34PM +0200, Giulio Benetti wrote:
> > > > > You don't have to handcode the fragments anymore with the new syn=
tax,
> > > > > and U-Boot makes it really trivial to use if you use the FIT image
> > > > > format to have multiple overlays bundled in the same image. You c=
an
> > > > > choose to apply them dynamically, for example based on an EEPROM =
or
> > > > > some other metric to see which combination you have.
> > > >=20
> > > > Ah, this is interesting. I'm going to experiment with that.
> > > >=20
> > >=20
> > > I'm struggling against this, I don't really know how to proceed,
> > > except keeping monolithic dts files including other dtsi files.
> > >=20
> > > About dt-overlays I've tried to look around lot of time,
> > > but the only thing I've found is this:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers=
=2Egit/tree/arch/arm/boot/dts?h=3Dtopic/renesas-overlays
> > >=20
> > > where they use .dtso tagging them as "/plugin/;"
> > > and compile all .dtso found in dts folder.
> > > Then they obtain .dtbo files that should be the dt-overlays we have s=
poken
> > > about right?
> >=20
> > Yes. You don't have to do that though, you can just rely on dtc to
> > compile them, outside of the linux build system.
> >=20
> > > What I can't understand is if there's a real standard at this time to
> > > follow, because on renesas-driver they use their way to handle all .d=
tso
> > > files, but on mainline there seems to be nothing about that.
> >=20
> > I'm not sure what you mean here. It's just fragments of device tree,
> > that have to be compiled using dtc, that's it. You can use the Linux
> > build system infrastructure to do that, or you can build your own
> > simpler one. That's really up to you. See for example
> > https://github.com/NextThingCo/CHIP-dt-overlays/blob/master/Makefile
> >=20
> > (even though the overlays themselves use the legacy syntax and
> > shouldn't really be used an examples)
>=20
> Everything works now!
> Thank you very much!
> I've setted up a Repo on Github to give an example on how make it work wi=
th
> no pain:
> https://github.com/micronovasrl/linova-dtoverlays
>=20
> At the moment it's a mess all around, but it's working and give an idea on
> how to make it work. Though I'm going to clean it up well as a base for
> linova dtoverlays.
>=20
> Ah, btw, can you confirm me that base dts file must be compiled outside
> kernel with:
> dtc -@ ....
> Otherwise as in-tree dts with make dtbs "-@" argument is not passed.
> Right?

You should use DTC_FLAGS=3D'-@'

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--o7fuc4npexahvokm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrwAIQACgkQ0rTAlCFN
r3SVLw/+LDFHwA0c8/mSHzlpzdmP/6fgR7yVzo0kZSEglnGdAdT6w1VeAQR18wNS
Zlce+zpJPayARbe3Srp4Sm2epC6CeS0m2hEClrvuOT3tEJP9MNTsOwFm2KlHPg0Y
ZZiq2A/LM11cOCZNg6K5KZyskOzd4LAO9ssmeDtKDd8bxzfU0M5P53qNuTwK7AJ4
64Ih0sKM9pCiY4bnj9TOoFJF90he6ofSyXYVCe20d7m6FU2vl1L1fT0fKk1ovOS5
Ugvw+Fg2/63SQXsOGvmQW7OWSGD+mRiqXunwfkxgvfo/rOpBZMSpbUYvbgCp52Hc
i1kvvX3cdaQuJw9dpnvpuxpfMkB7oRjlNpuP1SXDSjVCYvtya6vuzXJC+b5WCWhD
77gVxs5Sf0kwpo0hJw8OMwW1IlFv7e+DQr1vseE06PEN2NXhNfOXhwHLQES7sQTc
o/j3KiGUiTIqcXfdo1tt10T9Yk1LQaVDq8tA/2LXoPQH+FL+kdZQqYBT5TYAIn+M
NbnuaPcBQSNNM3pkJtW3aO8ehFG3/010nsCDMejCVK1XNjI1GlXguoDsrI0OGHoU
D4GyA8zUNruqB5z3788YDD/1Xph3Gil/AXJefT2yGrnvesmSJD+7MPOLuNO6vCVh
Isx3ruQNTU4B5lXGlNCK8DJqUytZNH2LllceQBR1tAmqBFkaG7A=
=20SU
-----END PGP SIGNATURE-----

--o7fuc4npexahvokm--
