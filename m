Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6AA10C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08187208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="VdYPvybZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08187208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935577AbeFMVxB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:53:01 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:54160 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbeFMVw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:52:59 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A7D0DB007CC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 23:52:57 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1528926776; x=1529790777; bh=Pr/0YwzO3YcRzNLhSlPmFpqCBUmrbVsdjAR
        /4xoUz/k=; b=VdYPvybZBh/iwbjqBlg08IFb2LW6YnMt2siwe5tIlvQDdCYldOf
        Wf5tFOM3a/EFYlzZP3Ona6tpQF8f2PRmxTf8s+Umi62YnHX9f+1L2do9gc6+eesS
        py6y12KkIDG7Jy75x4dVs8239pKWZFjvDWFpIxOwXJ8jrlbu5MMSWk68=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0uwofeMgZG3Y for <linux-kernel@vger.kernel.org>;
        Wed, 13 Jun 2018 23:52:56 +0200 (CEST)
Received: from [192.168.2.70] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 7A3F8B00116;
        Wed, 13 Jun 2018 23:52:55 +0200 (CEST)
Subject: Re: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
Date:   Wed, 13 Jun 2018 23:52:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry for my ignorance.
I don't know the right patch workflow in the case of "revert commit".
When I fix this bug, should I have to re-submit the previous patch 
entire plus bug-fix?
Or do I have to submit patch with bug-fix only?

Thanks in advance to everybody

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

Il 13/06/2018 10:16, Paul Kocialkowski ha scritto:
> This reverts commit 2c17a4368aad2b88b68e4390c819e226cf320f70.
> 
> The offending commit triggers a run-time fault when accessing the panel
> element of the sun4i_tcon structure when no such panel is attached.
> 
> It was apparently assumed in said commit that a panel is always used with
> the TCON. Although it is often the case, this is not always true.
> For instance a bridge might be used instead of a panel.
> 
> This issue was discovered using an A13-OLinuXino, that uses the TCON
> in RGB mode for a simple DAC-based VGA bridge.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index c3d92d537240..8045871335b5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -17,7 +17,6 @@
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
>   
>   #include <uapi/drm/drm_mode.h>
>   
> @@ -350,9 +349,6 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>   static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>   				     const struct drm_display_mode *mode)
>   {
> -	struct drm_panel *panel = tcon->panel;
> -	struct drm_connector *connector = panel->connector;
> -	struct drm_display_info display_info = connector->display_info;
>   	unsigned int bp, hsync, vsync;
>   	u8 clk_delay;
>   	u32 val = 0;
> @@ -410,27 +406,6 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>   	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>   		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>   
> -	/*
> -	 * On A20 and similar SoCs, the only way to achieve Positive Edge
> -	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
> -	 * By default TCON works in Negative Edge(Falling Edge),
> -	 * this is why phase is set to 0 in that case.
> -	 * Unfortunately there's no way to logically invert dclk through
> -	 * IO_POL register.
> -	 * The only acceptable way to work, triple checked with scope,
> -	 * is using clock phase set to 0° for Negative Edge and set to 240°
> -	 * for Positive Edge.
> -	 * On A33 and similar SoCs there would be a 90° phase option,
> -	 * but it divides also dclk by 2.
> -	 * Following code is a way to avoid quirks all around TCON
> -	 * and DOTCLOCK drivers.
> -	 */
> -	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
> -		clk_set_phase(tcon->dclk, 240);
> -
> -	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
> -		clk_set_phase(tcon->dclk, 0);
> -
>   	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>   			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>   			   val);
> 

