Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5471C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE4D208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2Aplpzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE4D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966285AbeFOQpo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:45:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54615 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966026AbeFOQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:45:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so4489540wmf.4;
        Fri, 15 Jun 2018 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYr78dlIKjP+IJXiFmuegAIAaR5LFN8nbW9q3SDNUDg=;
        b=F2AplpzxDxBmXE2hJGUN65xnasxYWza7JS7R+oNbXJLDopphq21CCrTNKNHbxHQ7V2
         acYk1HYNITI2buFepAT/ZveZc22p3LRbVQs/T2eAJ/wTpRRoF1KI2WzGU7hSm1DTDePr
         60xY2N78yvm5Wjz5DygPqYlNE6Vdxy83ELV20YIpbSJ441Rpd9NJKAv8ne55Y9Ea7ILb
         3JcLe0jNUd9m0zhfUMrlhXMoenzGFlAs3ZusSu9rAv0Meg5gN2BAwYkDg5/lA5w9z535
         7OkvMWZx8QK55xzQ7qO8+g4HY19H+hg/wMjIq8H83EHeig8JvhmuECZfa1bXzbP/dXNN
         mj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYr78dlIKjP+IJXiFmuegAIAaR5LFN8nbW9q3SDNUDg=;
        b=A5ankuvp86tfTl7wk9Vsy5AA9e0cLA5gxlxalCYEQt/9mvMo+4fLtVLjgLWdd9OVPk
         IRo3NQLwezKuoNsZGYVLZ4/mc3KRA3ZOnbNAquLGTKOvGr+zGI4Lk3cldVpcfsY5FZLk
         tKAMXp4kJQjgc5bdv+nGUwcQ5tngwUQDy3lzcZxtsb34SY44Lj3iTCcRV33VHA5/KmSj
         LUsLUDJ6KzI6NCM4mXrgcPWY7VIsTgbwxBY3jB8ymtoxhq1hLQquqmGsnPk7Hwql+7tR
         61Bzj7j3QGZtALBQBwvRK/0VgbOfC9wK31mVNoGGKWPeC95RHWwslJvJmGh+5gS9pI3M
         BPZg==
X-Gm-Message-State: APt69E2Ny39pe9QBGl/vvj3TBy92g/gbni8/qTGaZvYWYzIQxPDj8Iqv
        jGpxEK0b5KjJvjK5rzv7ucg=
X-Google-Smtp-Source: ADUXVKIWE53+sVVnKIKWreTPc0JxjOQs4hpxEQgDfQKHMD6ChPMgkLwEOZHQYW8BYj8arQ3RUA9aYA==
X-Received: by 2002:a1c:387:: with SMTP id 129-v6mr1855306wmd.53.1529081139578;
        Fri, 15 Jun 2018 09:45:39 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id d3-v6sm7584462wrr.90.2018.06.15.09.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 09:45:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v2 20/27] drm/sun4i: Don't change clock bits in DW HDMI PHY driver
Date:   Fri, 15 Jun 2018 18:44:33 +0200
Message-ID: <8789732.RJMkczUIGD@jernej-laptop>
In-Reply-To: <20180612200036.21483-21-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <20180612200036.21483-21-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 12. junij 2018 ob 22:00:29 CEST je Jernej Skrabec napisal(a):
> DW HDMI PHY driver and PHY clock driver share same registers. Make sure
> that DW HDMI PHY setup code doesn't change any clock related bits and
> set them to 0 during initialization.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 79154f0f674a..3ba71aff92fc
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -98,7 +98,7 @@
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
> -#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
> +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
>  #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index 966688f04741..cd07ceb71601
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi
> *hdmi, regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
>  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
> 
> -	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
> +	/*
> +	 * NOTE: We have to be careful not to overwrite PHY parent
> +	 * clock selection bit and clock divider.
> +	 */
> +	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> +			   (u32)~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> +			   pll_cfg1_init);
>  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
>  			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
>  			   pll_cfg2_init);
> @@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct
> sun8i_hdmi_phy *phy) SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
>  			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
> 
> +	/* reset PLL clock configuration */
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
> +	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, 0);
> +

For some reason, this change breaks HDMI on H3. Clearing only PLL parent 
selection bit works ok, though. I'll fix it in next revision.

Best regards,
Jernej

>  	/* set HW control of CEC pins */
>  	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG, 0);




