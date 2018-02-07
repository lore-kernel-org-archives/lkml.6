Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeBGKjk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:39:40 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:45692 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeBGKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:39:34 -0500
Date: Wed, 7 Feb 2018 11:39:05 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: airlied@linux.ie, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
Message-ID: <20180207103905.mtyzgu73mmifyvvj@flea>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwi6yl4ivny3nm5l"
Content-Disposition: inline
In-Reply-To: <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zwi6yl4ivny3nm5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 08:37:28PM +0100, Giulio Benetti wrote:
> > > > Also, how was it tested? This seems quite weird that we haven't cau=
ght
> > > > that one sooner, and I'm a bit worried about the possible regressio=
ns
> > > > here.
> > >=20
> > > It sounds really strange to me too,
> > > because everybody under uboot use "sync:3"(HIGH).
> > > I will retry to measure,
> > > unfortunately at home I don't have a scope,
> > > but I think I'm going to have one soon, because of this. :)
> >=20
> > Here I am with scope captures and tcon0 registers dump:
> > tcon0_regs =3D> https://pasteboard.co/H4r8Zcs.png
> > dclk_d0 =3D> https://pasteboard.co/H4r8QRe.png
> > dclk_de =3D> https://pasteboard.co/H4r8zh4R.png
> > dclk_vsnc =3D> https://pasteboard.co/H4r8Hye.png
> >=20
> > As you can see circled in reg on registers,
> > TCON0_IO_POL_REG =3D 0x00000000.
> > But on all the waveforms you can see:
> > - dclk_d0: clock phase is 0, but it starts with falling edge, otherwise
> > the rising front overlaps dclk rising edge(not good), so to me this is
> > falling, then I mean it Negative.
> > - dclk_de: de pulse is clearly negative, even if register is 0 and its'
> > polarity bit is 0.
> > - dclk_vsnc: same as dclk_de
> > - dclk_hsync: I didn't take scope screenshot but I can assure you it's
> > negative.
> >=20
> > You can also check all the other registers about TCON0.
> >=20
> > Now I proceed testing it on A33, maybe the peripheral is slightly
> > different between Axx SoCs, if I find it that way,
> > it should be only a check about SoC or peripheral ID,
> > and treat polarity as it should be done.
>=20
> Here I am with A33 waveforms:
> tcon0_regs =3D> https://pasteboard.co/H4rXfN0M.png
> dclk_d0 =3D> https://pasteboard.co/H4rVXwy.png
> dclk_de =3D> https://pasteboard.co/H4rWDt8.png
> dclk_vsnc =3D> https://pasteboard.co/H4rWRACu.png
> dclk_hsync =3D> https://pasteboard.co/H4rWK6I.png
>=20
> It behaves the same way as A20, so as I mean IO polarity,
> all signals(except D0-D23), are inverted.
> For A33 I've used A33-OLinuXino.
> For A20 our LiNova1.

If you have an A33 handy, you probably want to read that mail:
https://lists.freedesktop.org/archives/dri-devel/2017-July/147951.html

Especially the 90-phase part.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--zwi6yl4ivny3nm5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp610gACgkQ0rTAlCFN
r3R3zg/+IhsSxbY0VeF0+01TZA7vy7QmPjYZhiwZh24UX+k3ttQ8S/9nCT5CHF3u
QTWZ+RvD4M5V4a4mGBX3C+oKVLZORL0dJPHfsA3zQJ1SuSg0YrP2rqk8H3TjpLMU
U+0blVsQmKReEPJNc/q8hfeodADcl+lNDHkayt+d3aQnuBLyZNrp7aZK2v9yFk+h
V1yT73vUX/fKJte24oLnCCnoIeWW6M7TNuG8XppDj0J+XgDnCsvSqw0rmR93uXkY
0T7gx1mfrdhP0cFNHw9bdEO3FiQDwIrTXl1tVSgMfoncdkC8cjfg37t1+l4NS1lV
zr40K7o8w9MKfWO3R2dODZK8jv2reDSPxSjBmg7hh1BElhAxncQ0LiY2hETYb3IU
bLn5LWXq9wZkiIaL3LFzC7lSIZS+vF9u1keK8zTZTge9vEZhzfOHuGtRqWS5qb8M
p0dP4b6ZpcUfQfxiu2KN6BquypQISLPqLhy3qCsDvw8PQLsGweqmQF4fIhN3U7lP
wIwoZzZfJ667bRXCl67Va468nvuxEJ1oR3KhuJ/0hRNhn0/3QG0tnIDK7oHqCqDO
IcPEJiE/rLnnsSO5WxUe49BZyILP5gCXITriHehsxZSlK+GnzO7gJd98ZGOfu5BV
uu7PavKDu6uGq7/lhz1tDHhCXAUTTf2A+w3vgtFKf9Dggi4l3ds=
=knnb
-----END PGP SIGNATURE-----

--zwi6yl4ivny3nm5l--
