Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C3C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7741E216F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by0xBr/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7741E216F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeHOQcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:32:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36222 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbeHOQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:32:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so1175009wro.3;
        Wed, 15 Aug 2018 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJJb0O5e+RMzNKTTQt4G1MiuOATGwHnZUlxA28EeFbk=;
        b=by0xBr/q8J/VeLFMbWY2e3jonkDDcFwsal12OHNv1pKnLKUjZEFPhtQOHPuAV52BJ9
         lX0d/ITq2maj9XDhSgtIfIGUhTbdrNcaEJdpxBZkq1E/nUiPa/Mp71k7L1YfX7718PpU
         78CSmNC6O+kiBEU+HMS/6eR8PCWrHhnhwpJ2EnrFmv+R7aOyG4roIp2U1jqwPG+l7ibL
         t4t32I+HNzJSuSJLlhQ1G24VO/cr7xo5hULwmKG+0Sl11uO1eOgOWMUpyvkZjXuIBkw+
         8hP32hjhqqJ7HQlucQBxZ8yZ7eqiEcKuRaZMOB9jy6PPn3c3KRyY0HE/OCphY+p4lrKw
         6bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJJb0O5e+RMzNKTTQt4G1MiuOATGwHnZUlxA28EeFbk=;
        b=k18QlJpawtb7V7puTgcg8EPqu7vj/kGqQOdHjtHyx5pSMU5IoPG01sZNhxELwsvDSY
         jpiNX2dUXABNEczTaUlOJ/Gx+pn6lyEp4BgX1v/jWUAlzlDffF70e1wXfdLYQ6eYXeMP
         820JhTZj2WC+OorD+b6lQIDFfR9ITTsXBHVPPOo1EdyfXFiTZ0n8a8eHiBJMecw4jKQ5
         KcqonNl0UdQUl9Uqgq6hkodBX8jr8SU4KCyuee0BTlvQ4XcrjLDCKhdO9LSMhjrHiCIJ
         oqJmnD163hc4CLdia9kJtZUX7o+6gwXQnKe3lbDwx8ahUEp/aChuTMBvE7d2/Km+uX+U
         fo+Q==
X-Gm-Message-State: AOUpUlEYYps3iT4UWnSbvWpMd+pB+8Vg9tfPlS69mMSyg2CvV/1DKfth
        4PJdJCZwHo6Rj7W3f3grE4k=
X-Google-Smtp-Source: AA+uWPw6Xh9s/baRCoeuNdiIwatWMccJQyK9eBEL3VMio+myM/IEi4KmqlpvkMfNeQL/VyQo8YOOoA==
X-Received: by 2002:adf:b786:: with SMTP id s6-v6mr16573762wre.247.1534340387212;
        Wed, 15 Aug 2018 06:39:47 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id w3-v6sm17917925wrn.16.2018.08.15.06.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 06:39:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH] drm: sun4i: exclusively set HDMI-related clocks for dw-hdmi
Date:   Wed, 15 Aug 2018 15:39:44 +0200
Message-ID: <5309847.hPHKHXY3qr@jernej-laptop>
In-Reply-To: <20180815120745.36593-1-icenowy@aosc.io>
References: <20180815120745.36593-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 15. avgust 2018 ob 14:07:45 CEST je Icenowy Zheng napisal(a):
> The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
> dw-hdmi exclusively, which will lead the display fails to initialize in
> some situations.
> 
> Add the exclusivity to sun8i-dw-hdmi and sun8i-hdmi-phy.
> 
> Cc: stable@vger.kernel.org # v4.17+
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Given that you want this patch to be merged in stable, I have to ask what kind 
of tests did you run to prove it works as expected?

In the past, there were some issues with TCON exclusive rate setting. It turns 
out that as many scenarios as possible have to be tested before you can say 
it's working.

I imagine that it has to be tested on at least A83T, H3 (or H5) and R40 (or 
A64). They all have their own specifics which needs to be covered.

Tests which I remember from top of my head:
- run with monitor connected at boot
- run with monitor disconnected at boot and connect it later
- playing with resolution switching (at least a few non-standard, e.g 
something other than 1080p or 720p)

Best regards,
Jernej


> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 11 ++++++++++-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  7 +++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index 31875b636434..a10220518548
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -137,10 +137,16 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> struct device *master, goto err_assert_ctrl_reset;
>  	}
> 
> +	ret = clk_rate_exclusive_get(hdmi->clk_tmds);
> +	if (ret) {
> +		dev_err(dev, "Could not get exclusivity over the tmds clock\n");
> +		goto err_disable_clk_tmds;
> +	}
> +
>  	phy_node = of_parse_phandle(dev->of_node, "phys", 0);
>  	if (!phy_node) {
>  		dev_err(dev, "Can't found PHY phandle\n");
> -		goto err_disable_clk_tmds;
> +		goto err_put_clk_tmds_exclusivity;
>  	}
> 
>  	ret = sun8i_hdmi_phy_probe(hdmi, phy_node);
> @@ -179,6 +185,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct
> device *master, cleanup_encoder:
>  	drm_encoder_cleanup(encoder);
>  	sun8i_hdmi_phy_remove(hdmi);
> +err_put_clk_tmds_exclusivity:
> +	clk_rate_exclusive_put(hdmi->clk_tmds);
>  err_disable_clk_tmds:
>  	clk_disable_unprepare(hdmi->clk_tmds);
>  err_assert_ctrl_reset:
> @@ -194,6 +202,7 @@ static void sun8i_dw_hdmi_unbind(struct device *dev,
> struct device *master,
> 
>  	dw_hdmi_unbind(hdmi->hdmi);
>  	sun8i_hdmi_phy_remove(hdmi);
> +	clk_rate_exclusive_put(hdmi->clk_tmds);
>  	clk_disable_unprepare(hdmi->clk_tmds);
>  	reset_control_assert(hdmi->rst_ctrl);
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index 82502b351aec..1e0b1d9bc0fb
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -511,13 +511,14 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi,
> struct device_node *node) }
> 
>  		clk_prepare_enable(phy->clk_phy);
> +		clk_rate_exclusive_get(phy->clk_phy);
>  	}
> 
>  	phy->rst_phy = of_reset_control_get_shared(node, "phy");
>  	if (IS_ERR(phy->rst_phy)) {
>  		dev_err(dev, "Could not get phy reset control\n");
>  		ret = PTR_ERR(phy->rst_phy);
> -		goto err_disable_clk_phy;
> +		goto err_put_clk_phy_exclusivity;
>  	}
> 
>  	ret = reset_control_deassert(phy->rst_phy);
> @@ -548,7 +549,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi,
> struct device_node *node) reset_control_assert(phy->rst_phy);
>  err_put_rst_phy:
>  	reset_control_put(phy->rst_phy);
> -err_disable_clk_phy:
> +err_put_clk_phy_exclusivity:
> +	clk_rate_exclusive_put(phy->clk_phy);
>  	clk_disable_unprepare(phy->clk_phy);
>  err_put_clk_pll1:
>  	clk_put(phy->clk_pll1);
> @@ -568,6 +570,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
> 
>  	clk_disable_unprepare(phy->clk_mod);
>  	clk_disable_unprepare(phy->clk_bus);
> +	clk_rate_exclusive_put(phy->clk_phy);
>  	clk_disable_unprepare(phy->clk_phy);
> 
>  	reset_control_assert(phy->rst_phy);




