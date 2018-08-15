Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B713C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37694215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjUBCjHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37694215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeHOQqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:46:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36327 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbeHOQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:46:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so1213478wro.3;
        Wed, 15 Aug 2018 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X51EXRxjP0H4AD+wJYHiHZ1oc9IM78A1IK+GlljUkOw=;
        b=BjUBCjHDPBP785Ro+SrhmfdzUPBf+YXHB4G37flvJtN0YjhTrlULSwW2+LUX86+MAd
         wj2+PGjEt93BMCynZi0Z2oOrdq2iEhi3HvjcfZkwiwjOTgYAEsj9SJYW8qFclFXfbRT8
         rvAphOL5NPXB8F+jpJzZrNyjA/Gj5pcs0VEt574JoNtYkavVz9DWiuK3tLa4QBRCtMnU
         nZ4H0uiovO9y0mLG7UmO2Kds+nMxB7ocykuSF9lQR/ZVPTeSi2r0JY0VukBNEUm7ygce
         UO2MM5hqIkGgY8OPH+qxAoQOsmLgv+LTw778rLQYcooAGMX6Yv/EdBJgLHpaRYqmd0uq
         InGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X51EXRxjP0H4AD+wJYHiHZ1oc9IM78A1IK+GlljUkOw=;
        b=siPAYZvrF0c2eZf36vwXtSO1FYfUtUua4HtS4fldLHF7AlDeotdFvRvF6383QC4Tim
         THWi3rNk22evE1YgO48Oy4fe5OkLELLZyi41nkRZ47b6q9yQIuKhFoZBarAkzPVdsbKa
         +ow7t1np36xppY+9T9S4P8VRzAIVnyOrCVSe3LhaVgJ5Ygzga2z7Jh00evmiR+pW2M6Y
         IXYgwumqVQLv3YR2AXuXq/2fwlKAK9huX67EADf+yJ4ublh4/Ht3GJ9jcChjJ5pJ+Gw7
         65UhXiYArhx7IMKdVEJPuUHVxogzjY7MKdcPBTV6QIv0sX/hZnaXcMOjcIO3oZpdkUYH
         g9Fw==
X-Gm-Message-State: AOUpUlERnZLpRYKAbkCVY9VU9PEjWO8gmRkOKrpPdZ5Y5/Dk+rFMa4pt
        u7iwv3/sHyi2hh3ls1liI/M=
X-Google-Smtp-Source: AA+uWPxbkFGRhp9oLYUV5H432PBIhhtWswNs8e7wfTJXvAE/PPvgPHfpPxLiZW3424+RMFMxmHUcEA==
X-Received: by 2002:a5d:6892:: with SMTP id h18-v6mr16135799wru.108.1534341228185;
        Wed, 15 Aug 2018 06:53:48 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id 9-v6sm59465305wrb.48.2018.08.15.06.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 06:53:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH] drm: sun4i: exclusively set HDMI-related clocks for dw-hdmi
Date:   Wed, 15 Aug 2018 15:53:45 +0200
Message-ID: <4239222.d0pFiuuR7S@jernej-laptop>
In-Reply-To: <2890910B-FFBD-4B05-8275-270B2DB73DEA@aosc.io>
References: <20180815120745.36593-1-icenowy@aosc.io> <5309847.hPHKHXY3qr@jernej-laptop> <2890910B-FFBD-4B05-8275-270B2DB73DEA@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 15. avgust 2018 ob 15:43:19 CEST je Icenowy Zheng napisal(a):
> =E4=BA=8E 2018=E5=B9=B48=E6=9C=8815=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
9:39:44, "Jernej =C5=A0krabec"=20
<jernej.skrabec@gmail.com> =E5=86=99=E5=88=B0:
> >Hi!
> >
> >Dne sreda, 15. avgust 2018 ob 14:07:45 CEST je Icenowy Zheng
> >
> >napisal(a):
> >> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
> >> dw-hdmi exclusively, which will lead the display fails to initialize
> >
> >in
> >
> >> some situations.
> >>=20
> >> Add the exclusivity to sun8i-dw-hdmi and sun8i-hdmi-phy.
> >>=20
> >> Cc: stable@vger.kernel.org # v4.17+
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >
> >Given that you want this patch to be merged in stable, I have to ask
> >what kind
> >of tests did you run to prove it works as expected?
> >
> >In the past, there were some issues with TCON exclusive rate setting.
> >It turns
> >out that as many scenarios as possible have to be tested before you can
> >say
> >it's working.
> >
> >I imagine that it has to be tested on at least A83T, H3 (or H5) and R40
> >(or
> >A64). They all have their own specifics which needs to be covered.
> >
> >Tests which I remember from top of my head:
> >- run with monitor connected at boot
>=20
> BTW I think the bootloader will affect the state of displsy even
> without the patch.

I know it can be an issue. For this test I imagine you can just disable=20
display driver in U-Boot so the PLL doesn't get set.

>=20
> When could your U-Boot tweaks patchset to be done? I think they will
> be needed for a really reliable test.

I plan to do them after A64 driver is merged, so I can sync up dts files an=
d=20
switch driver to be enabled trough them. AFAIK, A64 patches are more or les=
s=20
ready and they will be merged after 4.19-rc1, right?

>=20
> >- run with monitor disconnected at boot and connect it later
> >- playing with resolution switching (at least a few non-standard, e.g
> >something other than 1080p or 720p)
>=20
> How to do it without starting a X server?

libdrm has in it's source superb testing tool called modetest. It is useful=
=20
for resolution testing, plane testing (scaling, positioning, color formats,=
=20
blending, ...) and setting atomic properties (like zpos). While it doesn't=
=20
recognize sun4i-drm driver automatically, you can specify it through comman=
d=20
line parameter.

Best regards,
Jernej

>=20
> >Best regards,
> >Jernej
> >
> >> ---
> >>=20
> >>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 11 ++++++++++-
> >>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  7 +++++--
> >>  2 files changed, 15 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> >> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index
> >
> >31875b636434..a10220518548
> >
> >> 100644
> >> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> >> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> >> @@ -137,10 +137,16 @@ static int sun8i_dw_hdmi_bind(struct device
> >
> >*dev,
> >
> >> struct device *master, goto err_assert_ctrl_reset;
> >>=20
> >>  	}
> >>=20
> >> +	ret =3D clk_rate_exclusive_get(hdmi->clk_tmds);
> >> +	if (ret) {
> >> +		dev_err(dev, "Could not get exclusivity over the tmds clock\n");
> >> +		goto err_disable_clk_tmds;
> >> +	}
> >> +
> >>=20
> >>  	phy_node =3D of_parse_phandle(dev->of_node, "phys", 0);
> >>  	if (!phy_node) {
> >>  =09
> >>  		dev_err(dev, "Can't found PHY phandle\n");
> >>=20
> >> -		goto err_disable_clk_tmds;
> >> +		goto err_put_clk_tmds_exclusivity;
> >>=20
> >>  	}
> >>  =09
> >>  	ret =3D sun8i_hdmi_phy_probe(hdmi, phy_node);
> >>=20
> >> @@ -179,6 +185,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> >
> >struct
> >
> >> device *master, cleanup_encoder:
> >>  	drm_encoder_cleanup(encoder);
> >>  	sun8i_hdmi_phy_remove(hdmi);
> >>=20
> >> +err_put_clk_tmds_exclusivity:
> >> +	clk_rate_exclusive_put(hdmi->clk_tmds);
> >>=20
> >>  err_disable_clk_tmds:
> >>  	clk_disable_unprepare(hdmi->clk_tmds);
> >> =20
> >>  err_assert_ctrl_reset:
> >> @@ -194,6 +202,7 @@ static void sun8i_dw_hdmi_unbind(struct device
> >
> >*dev,
> >
> >> struct device *master,
> >>=20
> >>  	dw_hdmi_unbind(hdmi->hdmi);
> >>  	sun8i_hdmi_phy_remove(hdmi);
> >>=20
> >> +	clk_rate_exclusive_put(hdmi->clk_tmds);
> >>=20
> >>  	clk_disable_unprepare(hdmi->clk_tmds);
> >>  	reset_control_assert(hdmi->rst_ctrl);
> >> =20
> >>  }
> >>=20
> >> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> >> b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index
> >
> >82502b351aec..1e0b1d9bc0fb
> >
> >> 100644
> >> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> >> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> >> @@ -511,13 +511,14 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi
> >
> >*hdmi,
> >
> >> struct device_node *node) }
> >>=20
> >>  		clk_prepare_enable(phy->clk_phy);
> >>=20
> >> +		clk_rate_exclusive_get(phy->clk_phy);
> >>=20
> >>  	}
> >>  =09
> >>  	phy->rst_phy =3D of_reset_control_get_shared(node, "phy");
> >>  	if (IS_ERR(phy->rst_phy)) {
> >>  =09
> >>  		dev_err(dev, "Could not get phy reset control\n");
> >>  		ret =3D PTR_ERR(phy->rst_phy);
> >>=20
> >> -		goto err_disable_clk_phy;
> >> +		goto err_put_clk_phy_exclusivity;
> >>=20
> >>  	}
> >>  =09
> >>  	ret =3D reset_control_deassert(phy->rst_phy);
> >>=20
> >> @@ -548,7 +549,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi
> >
> >*hdmi,
> >
> >> struct device_node *node) reset_control_assert(phy->rst_phy);
> >>=20
> >>  err_put_rst_phy:
> >>  	reset_control_put(phy->rst_phy);
> >>=20
> >> -err_disable_clk_phy:
> >> +err_put_clk_phy_exclusivity:
> >> +	clk_rate_exclusive_put(phy->clk_phy);
> >>=20
> >>  	clk_disable_unprepare(phy->clk_phy);
> >> =20
> >>  err_put_clk_pll1:
> >>  	clk_put(phy->clk_pll1);
> >>=20
> >> @@ -568,6 +570,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi
> >
> >*hdmi)
> >
> >>  	clk_disable_unprepare(phy->clk_mod);
> >>  	clk_disable_unprepare(phy->clk_bus);
> >>=20
> >> +	clk_rate_exclusive_put(phy->clk_phy);
> >>=20
> >>  	clk_disable_unprepare(phy->clk_phy);
> >>  =09
> >>  	reset_control_assert(phy->rst_phy);




