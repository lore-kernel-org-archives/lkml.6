Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94752218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wh5PjhHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbeLUIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:39:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732581AbeLUIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:39:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so4322470wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D/iWBheHUBC5EEZU6E5yzFudwU+7y61AN7x2cxOztmY=;
        b=Wh5PjhHR9IEvx2PF0Vpc9sx0Y/p1Vk0xWz8xSar65KumEa+xAoEhSmlBuvtcxYPLnc
         5uTWbIDyLacj9oyBz8979tJ55KIxqAy0inf8pJUIku47li9vgWfExa5n2XSUcLuZG9wz
         71Q4ggc8HjgIsaaBl/uTTTuMjazaBgvxHFlR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D/iWBheHUBC5EEZU6E5yzFudwU+7y61AN7x2cxOztmY=;
        b=mEGkPsb8uIjX35ofU91iFtUu2EJ6SkFoiA7la99gmAFLhOtx0I+QrYs8Fbx0aK7yxA
         OjqXcHm6pQlRza/kHoI2jksIhl5kTNjjcsPwXD0dRIdSl7g3h9i1tPWJOesNxPzNOmlm
         nKAqTnSi4yhRAlkZtAdBh2rKJHC/dwxDpf9UuJJsUF5kbQAFEopoeeY2SneVkO78qBNt
         LpcQi74V7lJsKYd6grm29lGL1QtonH0fX3PFiKmk4uhi5Snnd4ZhTtQyuOuQwAESHfCi
         3CKpOjiSyMAbn6/+IVf1drw+VTCEPMzW4mQ5FYFxbIyRBirW93LprbGYhSgxRYswV4Uc
         jSOA==
X-Gm-Message-State: AJcUukdH6tdj3QiX5e03lVmfjeA6QyUTg/w3Yvp8yKhRj5cuR9zzm3WO
        xRSWDgiVlzXk2Y98Mcv6n6J8Gg==
X-Google-Smtp-Source: ALg8bN6AGXmEO9/tU3hw9d1aKGRiTA8PvoOGgj3qEHkg7G1zzKziozVOUdzF+6WBFgpdZf1Q2K8omQ==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr1457464wrj.91.1545381569436;
        Fri, 21 Dec 2018 00:39:29 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id k128sm13109833wmd.37.2018.12.21.00.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:39:28 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:39:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181221083927.GQ4497@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The current axp20x names the ramping register 'scal' which probably
> means scaling. Since the register really has nothing to do with
> scaling, but really is the voltage ramp we rename it appropriately.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/axp20x.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I've lost track of what's happening with this set now.

Mark,

Did you take this patch in the end?

> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 2302b62..a353cd2 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -35,7 +35,7 @@ enum axp20x_variants {
>  #define AXP152_ALDO_OP_MODE		0x13
>  #define AXP152_LDO0_CTRL		0x15
>  #define AXP152_DCDC2_V_OUT		0x23
> -#define AXP152_DCDC2_V_SCAL		0x25
> +#define AXP152_DCDC2_V_RAMP		0x25
>  #define AXP152_DCDC1_V_OUT		0x26
>  #define AXP152_DCDC3_V_OUT		0x27
>  #define AXP152_ALDO12_V_OUT		0x28
> @@ -53,7 +53,7 @@ enum axp20x_variants {
>  #define AXP20X_USB_OTG_STATUS		0x02
>  #define AXP20X_PWR_OUT_CTRL		0x12
>  #define AXP20X_DCDC2_V_OUT		0x23
> -#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
> +#define AXP20X_DCDC2_LDO3_V_RAMP	0x25
>  #define AXP20X_DCDC3_V_OUT		0x27
>  #define AXP20X_LDO24_V_OUT		0x28
>  #define AXP20X_LDO3_V_OUT		0x29

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
