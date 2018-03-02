Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422739AbeCBIMl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:12:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47787 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422701AbeCBIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:12:38 -0500
Date: Fri, 2 Mar 2018 09:12:36 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 06/16] drm/sun4i: Don't process LVDS if TCON doesn't
 support it
Message-ID: <20180302081236.zlt52z6jjsglzk3i@flea.lan>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
 <20180227222701.9716-7-jernej.skrabec@siol.net>
 <20180228073608.r2zd3qkiudm2uarm@flea>
 <5333678.QYsGi30oEL@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uk6tcwyktkcpl2dk"
Content-Disposition: inline
In-Reply-To: <5333678.QYsGi30oEL@jernej-laptop>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uk6tcwyktkcpl2dk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 10:43:30PM +0100, Jernej =C5=A0krabec wrote:
> Dne sreda, 28. februar 2018 ob 08:36:08 CET je Maxime Ripard napisal(a):
> > On Tue, Feb 27, 2018 at 11:26:51PM +0100, Jernej Skrabec wrote:
> > > TCON checks for LVDS properties even if it doesn't support it. Add a
> > > check to skip that part of the code if TCON doesn't support channel 0.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >=20
> > I have already sent a similar patch here:
> > https://lists.freedesktop.org/archives/dri-devel/2018-February/166665.h=
tml
>=20
> Right. However, check last chunk in my patch. There is no need to call=20
> sun4i_rgb_init() if TCON doesn't support channel 0. It doesn't do anythin=
g,=20
> except producing warning. Will you add that this change to your patch and=
 then=20
> I can remove this patch from next revision?

They are orthogonal to me though. Mine fixes the spurious LVDS error
messages that you were mentionning in your commit log. Your point here
is that we shouldn't need to even register the LVDS and RGB output
when there's no channel 0. This is obviously true, but it should be in
a separate patch.

> BTW, your patch won't apply cleanly, since you didn't base it on latest c=
ode=20
> (every TCON variant has at least one entry now).

I'll fix it when applying.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--uk6tcwyktkcpl2dk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqZB3MACgkQ0rTAlCFN
r3SFIw/4kQEthkhFdmX9akYCDc7An/Zq+S8g+aYhZIsoYtWscv08rurozqbjA3MI
5oSNf+mJTnpLTZX2U9BdqfVITwUqYFjNTryGvO2Tk1774Zh29dzYk4iYd4rF+ZSp
5r+ZOwE4dnbJpIwCEdc+Ni1eSssv132Rhj1O5MD8Cn+/O2xuuCAjc6Pqhrw8ww0f
SpWeCOEde/o+ZyZraUz435m2w39hXEEbDlS/tBk5K8w6fzlqaF8aBdtFYH4ADMTm
on1Vstmrn70h4gIHlW3k+GlS9NZJVBIkmB8S9JN8GdNarRWR2M8jIm0RgQuY8zbI
jiKmLcohP1gysLYwuhAP7PgEpSIOYBviRw9tcy2J6uGaoxfzZBR+kzf7Cd1o8bmb
PSNtSUHS0ZssyEzZjNVDTIcqvSxsvmVEKbDU4OsWRlcI4fVAx6/J3jFnidKrfy7H
hUGQrxc5Fh6nnTjKrRltzjaGIZnlJXbzqig+KX8i/bfFPcAXYOWNpRQF2YADomDO
UwtPPRIodzqrlAwe2gLya9XHb/FVAbG+vQTA0XBmYq6Om7aaBAi7fsjpITQeTyIT
Wr03i87WTuqC2R8SAg3JMXTDeyLakM5rKnhfrArHII3BACrzjrbUsyENabEqlb6e
wpteJQMxBJKupkVp12mNSw4KLjynS9K8z7CbASKv/603p9bDuA==
=YUqa
-----END PGP SIGNATURE-----

--uk6tcwyktkcpl2dk--
