Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F761C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3151020851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3151020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeJ2SKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:10:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55897 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbeJ2SKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:10:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D6435208CE; Mon, 29 Oct 2018 10:22:26 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id A7C85208B0;
        Mon, 29 Oct 2018 10:22:26 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:22:27 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 12/25] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet
 overhead
Message-ID: <20181029092227.mdxgvg5aqzh22j72@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-13-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lllrmm6ipxhi4upc"
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-13-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lllrmm6ipxhi4upc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:13:31PM +0530, Jagan Teki wrote:
> Add 10 bytes packet overhead for hblk where blank is set using
> a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)
>=20
> This is according to BSP code from BPI-M64-bsp
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_hblk =3D (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
>=20
> So, add 10 bytes packet overhead for DSI hblk.
>=20
> Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
>=20
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 596e560263bf..cf42be1f1ba1 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi =
*dsi,
>  {
>  	struct mipi_dsi_device *device =3D dsi->device;
>  	unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> -	u16 hbp, hfp, hsa, hblk, vblk;
> +	u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
>  	size_t bytes;
>  	u8 *buffer;
> =20
> @@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi=
 *dsi,
> =20
>  	/*
>  	 * hblk seems to be the line + porches length.
> +	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
> +	 * payload + 2 bytes). So minimal size is 10 bytes
>  	 */
> -	hblk =3D (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
> +#define HBLK_PACKET_OVERHEAD	10
> +	hblk_max =3D (mode->htotal - (mode->hsync_end - mode->hsync_start)) * B=
pp;
> +	hblk_max -=3D HBLK_PACKET_OVERHEAD;
> +	hblk =3D max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);

I'd rather use the same convention than the other assignments done
before in that function.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lllrmm6ipxhi4upc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bRUwAKCRDj7w1vZxhR
xToJAP42zwMlUWetjTpxDylXTsNHV59JrZ091p3KqQ63YbmrugD/WWdKcs1Po0kx
ijDFy7H+IgWHuPQLm9SshyJ5x+vBsQw=
=WVlR
-----END PGP SIGNATURE-----

--lllrmm6ipxhi4upc--
