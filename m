Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA22CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932192075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="mRrWoN3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932192075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeGRPUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:20:42 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45282 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeGRPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:20:42 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 3BC20B0076D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:42:27 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1531924946; x=1532788947; bh=xiXxOJrNZqzbAYUT06Tiit1Cm5kvYYXOKkE
        dU/Wk7Hs=; b=mRrWoN3wQdhmQeQ09HJt6LyG4oK1KxVZdAHPqpd4tSkZbP09fHZ
        i70emaDLIbfrUKy8GyarDOVaW9+2cwrBO932C5JzhNXh8nmLO9Sn9QhWSzGGCVQK
        8tauqsU45UTSbV4tSDovzRPAkDThR+b2/ipFKcQeyT+2lG/8a4jqoplI=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 07Hjuq-3MuHC for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 16:42:26 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 19DFBB00049;
        Wed, 18 Jul 2018 16:42:26 +0200 (CEST)
Subject: Re: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE checking if
 panel is used.
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
 <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <e1fcedb1-64d5-24fb-ffc1-d418620ec795@micronovasrl.com>
Date:   Wed, 18 Jul 2018 16:42:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

can you give a try to this patch on A13 with VGA DAC?
Unfortunately I don't have an A13 board to test it.

Thanks in advance.

Giulio

Il 18/07/2018 16:23, Giulio Benetti ha scritto:
> Handle both positive and negative dclk polarity,
> according to bus_flags, taking care of this:
> 
> On A20 and similar SoCs, the only way to achieve Positive Edge
> (Rising Edge), is setting dclk clock phase to 2/3(240°).
> By default TCON works in Negative Edge(Falling Edge), this is why phase
> is set to 0 in that case.
> Unfortunately there's no way to logically invert dclk through IO_POL
> register.
> The only acceptable way to work, triple checked with scope,
> is using clock phase set to 0° for Negative Edge and set to 240° for
> Positive Edge.
> On A33 and similar SoCs there would be a 90° phase option, but it divides
> also dclk by 2.
> This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
> for using A33 90° phase divided by 2 and consequently increase code
> complexity.
> 
> Check if panel is used. TCON can also handle VGA DAC, then panel could
> be empty.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 8232b39e16ca..5c7d6ae53111 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -17,6 +17,7 @@
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>   
>   #include <uapi/drm/drm_mode.h>
>   
> @@ -474,6 +475,33 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>   	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>   		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>   
> +	/*
> +	 * On A20 and similar SoCs, the only way to achieve Positive Edge
> +	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
> +	 * By default TCON works in Negative Edge(Falling Edge),
> +	 * this is why phase is set to 0 in that case.
> +	 * Unfortunately there's no way to logically invert dclk through
> +	 * IO_POL register.
> +	 * The only acceptable way to work, triple checked with scope,
> +	 * is using clock phase set to 0° for Negative Edge and set to 240°
> +	 * for Positive Edge.
> +	 * On A33 and similar SoCs there would be a 90° phase option,
> +	 * but it divides also dclk by 2.
> +	 * Following code is a way to avoid quirks all around TCON
> +	 * and DOTCLOCK drivers.
> +	 */
> +	if (!IS_ERR(tcon->panel)) {
> +		struct drm_panel *panel = tcon->panel;
> +		struct drm_connector *connector = panel->connector;
> +		struct drm_display_info display_info = connector->display_info;
> +
> +		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
> +			clk_set_phase(tcon->dclk, 240);
> +
> +		if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
> +			clk_set_phase(tcon->dclk, 0);
> +	}
> +
>   	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>   			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>   			   val);
> 
