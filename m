Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E8C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CD0223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CD0223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbeKOUDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:03:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34349 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbeKOUDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:03:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0926820D72; Thu, 15 Nov 2018 10:56:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id CA62C20741;
        Thu, 15 Nov 2018 10:55:51 +0100 (CET)
Date:   Thu, 15 Nov 2018 10:55:51 +0100
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix VBP size
 calculation
Message-ID: <20181115095551.uctdkfmuwlnzhjnn@flea>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cw633pztpuimj6kk"
Content-Disposition: inline
In-Reply-To: <20181113111633.20189-9-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cw633pztpuimj6kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> The horizontal and vertical back porch calculation in BSP
> code is simply following the Linux drm comment diagram, in
> include/drm/drm_modes.h which is
>=20
> [hv]back porch =3D [hv]total - [hv]sync_end
>=20
> BSP code form BPI-M64-bsp is calculating vertical back porch as
> (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
>=20
> timmings->ver_sync_time=3D panel_info->lcd_vspw;
> timmings->ver_back_porch=3D panel_info->lcd_vbp-panel_info->lcd_vspw;
>=20
> vbp =3D panel->lcd_vbp;
> vspw =3D panel->lcd_vspw;
> dsi_dev[sel]->dsi_basic_size0.bits.vbp =3D vbp-vspw;
> dsi_dev[sel]->dsi_basic_size0.bits.vbp =3D panel->lcd_vbp - panel->lcd_vs=
pw;
> =3D>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_v=
spw
> =3D>  timmings->ver_back_porch
> =3D>  mode->vtotal - mode->end
>=20
> Which evatually same as mode->vtotal - mode->vsync_end so update the
> same in SUN6I_DSI_BASIC_SIZE0_VBP
>=20
> On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> value.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

I've tested your changes on my A33 board, and this commit will break
it.

It creates vblank timeouts, and visual artifacts at the bottom of the
display.

Later commits seem to fix the issue, but will create some blanking on
the upper third of the display.

Since the documentation is quite sparse, and a MIPI-DSI analyzer is
way too expensive, I'd really like to have at least what each of these
commits are actually fixing, and what symptoms each of these were
causing, and not just "the BSP does it".

Having some datasheet for the panels you had working would help too.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cw633pztpuimj6kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+1CpwAKCRDj7w1vZxhR
xRksAP0VayJ3BucsWPpkUNCLS5uSpu0Y/UmHQJI6zYlOOw1O+QD/WG6DY2TRtgZx
SkX1FYI9osX19IGL7yPL2/NHRlTVSQo=
=zMmg
-----END PGP SIGNATURE-----

--cw633pztpuimj6kk--
