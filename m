Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C09EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBBC20883
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBBC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeKET5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:57:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:32778 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeKET5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:57:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA3D6207CF; Mon,  5 Nov 2018 11:38:01 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id B48E72072A;
        Mon,  5 Nov 2018 11:38:01 +0100 (CET)
Date:   Mon, 5 Nov 2018 11:38:01 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 01/10] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop
 N1 instruction delay
Message-ID: <20181105103801.r6fo2qvmx6erx3zf@flea>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n27jowqdf6ximj23"
Content-Disposition: inline
In-Reply-To: <20181103100900.30313-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n27jowqdf6ximj23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 03, 2018 at 03:38:51PM +0530, Jagan Teki wrote:
> Loop N1 instruction delay for burst mode lcd panel are
> computed as per BSP code.
>=20
> Reference code is available in BSP
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=3D
> (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> =3D> (((mode->htotal - mode->hdisplay) * 150) / ((mode->clock / 1000) * 8=
)) - 50;
>=20
> So use the similar computation for loop N1 delay.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 86430efd9054..da152c21ec62 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -394,7 +394,14 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *=
dsi,
>  static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
>  				      struct drm_display_mode *mode)
>  {
> -	u16 delay =3D 50 - 1;
> +	struct mipi_dsi_device *device =3D dsi->device;
> +	u16 delay;
> +
> +	if (device->mode_flags =3D=3D MIPI_DSI_MODE_VIDEO_BURST)
> +		delay =3D (((mode->htotal - mode->hdisplay) * 150) /
> +			((mode->clock / 1000) * 8)) - 50;
> +	else
> +		delay =3D 50 - 1;

Apart from the other comments, I'd really prefer to have a function
here that would take the mipi_dsi_device and compute the delay.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n27jowqdf6ximj23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AdiQAKCRDj7w1vZxhR
xd1YAP0cc9SnJCCXSZG4yz5aGofn50wsdg4Wkja5/L2Cd2biggD/fV6c3VB/MrXU
t7mqkUsZuu/XYLFpu3BRprxhDSqNKgk=
=ux8o
-----END PGP SIGNATURE-----

--n27jowqdf6ximj23--
