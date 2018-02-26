Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeBZJjp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:39:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42112 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeBZJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:39:42 -0500
Date: Mon, 26 Feb 2018 10:39:30 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 08/15] drm/sun4i: Fix polarity configuration for DW HDMI
 PHY
Message-ID: <20180226093930.mipjyr6sr35ldkw6@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-9-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jbsyumb6moo5q7gr"
Content-Disposition: inline
In-Reply-To: <20180224214545.3740-9-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jbsyumb6moo5q7gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 24, 2018 at 10:45:38PM +0100, Jernej Skrabec wrote:
> Current polarity configuration code is cleary wrong since it compares
> same flag two times. However, even if flag name is fixed, it won't work
> well for resolutions which have one polarity positive and another
> negative.
>=20
> Fix that by properly set each bit according to each polarity. Since
> those two bits are not described in any documentation, relationships
> were obtained by experimentation.
>=20
> Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
> index e5bfcdd43ec9..f48e8b70fabe 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -35,10 +35,11 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi=
, void *data,
>  	struct sun8i_hdmi_phy *phy =3D (struct sun8i_hdmi_phy *)data;
>  	u32 val =3D 0;
> =20
> -	if ((mode->flags & DRM_MODE_FLAG_NHSYNC) &&
> -	    (mode->flags & DRM_MODE_FLAG_NHSYNC)) {
> -		val =3D 0x03;
> -	}
> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +		val |=3D 0x01;
> +
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +		val |=3D 0x02;

Can you introduce defines for those?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jbsyumb6moo5q7gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT1dEACgkQ0rTAlCFN
r3QV0RAAk2oUI5W3p9KMroT8DQt380PYBKasEzmuk7wCqvcnea6uMZ/xF1v2NCcT
uODf4PrsgIdKhhY7ODhJsh/wbAhtHuVFzKyNbENZLWKqFVG669RX5ZqdQ2dU+rmZ
tPbPfEPFmGETHJ2Mw15r9dNJZNO8jTBoeeUhChZ46AeVAN7vuB/AYxAj8Wf3RSlb
3PS9foTcRRmYHF4L+98aQj4S8snuf6w5FF6tP8KqSthdrg6EYy3TfhyIJiV2HvjO
CwFFDzF38xAW3TZ1wQZP2Pq5eaC5BFdbbDqnnshZ4gurPyiG+9GjH3xEAlYYUcBU
verXqRsv12Sf/7UpnFFXjsSxCW5eFSiPUbJcGLJ4x/O3WLBpKnRrNAmoLsHiFUK7
rN6jhPevrJ2UGhklDJA4yKrb2Q5vpTstmBGkyUEy4GDYF9IfT7RhJyL2zHPfS2QR
CpY6lPDNi6o4ggmAgzjWU9jTrxmuXDFFyhTVhDMHJCWNBA3xUgBl4zzRguvr1pIP
x7cefwu8GxcxicBcAVQsB9rWXdpeuY8zWeMzk1tpZoIM1J1HjrJsVJFgDuoCRdr5
OLacN9FEN80Og957ZMVpoRSXl++a119JtI1dnIqvWY6IfWd7MDadjG8r+/ZhrT04
vmQKzeJV/HOsU2Aui0ux03s/rqZEGLm3nYR8py/GjIM6z2qyOXg=
=oG2/
-----END PGP SIGNATURE-----

--jbsyumb6moo5q7gr--
