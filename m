Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB0BC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3AE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3AE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeJ2SQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:16:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56116 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbeJ2SQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:16:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A636420993; Mon, 29 Oct 2018 10:28:19 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7BA54208D9;
        Mon, 29 Oct 2018 10:27:53 +0100 (CET)
Date:   Mon, 29 Oct 2018 10:27:54 +0100
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
Subject: Re: [PATCH v3 14/25] drm/sun4i: sun6i_mipi_dsi: Increase hfp packet
 overhead
Message-ID: <20181029092754.2tl7i5k5qpbn4557@flea>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-15-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvlkcstvb3cw6o6f"
Content-Disposition: inline
In-Reply-To: <20181026144344.27778-15-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvlkcstvb3cw6o6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:13:33PM +0530, Jagan Teki wrote:
> Increase the hfp packet overhead with another 10 bytes, the extra
> 10 bytes(which is hblk packet overhead) is adding for hfp packet
> overhead since hfp depends on hblk.
>=20
> This is truely as per BSP code from BPI-M64-bsp.
> The real computation from BSP is
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_hbp =3D (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
> dsi_hact =3D x * dsi_pixel_bits[format]/8;
> dsi_hblk =3D (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
> dsi_hfp =3D dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);
>=20
> Example,
> u32 fmt =3D dsi_pixel_bits[format]/8;
> =3D> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
> =3D> (ht - hspw - x - (hbp - hspw)) * fmt - 16
> =3D> (ht - x - hbp) * fmt - 16
> =3D> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
> * fmt - 16
> =3D> (timmings->hor_total_time - x - timmings->hor_total_time +
> timmings->hor_front_porch + x) * fmt - 16
> =3D> timmings->hor_front_porch * fmt - 16
>=20
> So, increase the DSI hfp packet overhead by hblk packet overhead.
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
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 6584b51736a9..20e330186b7f 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi =
*dsi,
>  {
>  	struct mipi_dsi_device *device =3D dsi->device;
>  	unsigned int Bpp =3D mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> -	u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
> +	u16 hbp, hfp_pkt_overhead, hfp, hsa, hblk_max, hblk, vblk;
>  	size_t bytes;
>  	u8 *buffer;
> =20
> @@ -484,14 +484,6 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi=
 *dsi,
>  	hbp =3D max((unsigned int)HBP_PACKET_OVERHEAD,
>  		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
> =20
> -	/*
> -	 * The frontporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> -#define HFP_PACKET_OVERHEAD	6
> -	hfp =3D max((unsigned int)HFP_PACKET_OVERHEAD,
> -		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
> -
>  	/*
>  	 * hblk seems to be the line + porches length.
>  	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
> @@ -502,6 +494,18 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi=
 *dsi,
>  	hblk_max -=3D HBLK_PACKET_OVERHEAD;
>  	hblk =3D max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);
> =20
> +	/*
> +	 * The frontporch is set using a blanking packet (4 bytes +
> +	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +	 *
> +	 * According to BSP code, extra 10 bytes(which is hblk packet overhead)
> +	 * is adding for hfp packet overhead since hfp depends on hblk.

"According to the BSP code, another 10 bytes (the HBLK packet
overhead) need to be added to the front porch overhead."

How has this been verified? Since we have registers to set all the
parameters, this seems kind of weird.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pvlkcstvb3cw6o6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9bSmQAKCRDj7w1vZxhR
xV/4AP0X2KFZoRZDY34MgjfcorC8g1jHZPf5NyAOs2h5CtEEsQD7BSBxi7gYABgv
y2Z2cQkTC3os0qhX3cSKDQvaXAYjbQg=
=TpO6
-----END PGP SIGNATURE-----

--pvlkcstvb3cw6o6f--
