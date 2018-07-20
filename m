Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C49ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0785820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZreAdlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0785820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGTOLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:11:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbeGTOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:11:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so11319979wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OKErOTZSFNtGboCrtmUypycGl2RsE/fgOak/lzZYshI=;
        b=UZreAdlu5zfGoVYeeqqIk6M+7EnFoY2qJx2RSWBskxogimTUD1Ezy34eLl/0If/20K
         Un88bgWWlwByxGXjU1DHpYQT0ejuz1eHJPUHbdBprLkxjOWbAS8Rryeex9SL6XV2jDno
         DnJDC3L/a8jvv50XwN+31Mw8wRVFa98j2nInQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKErOTZSFNtGboCrtmUypycGl2RsE/fgOak/lzZYshI=;
        b=b3nQHRDLAGgtxqXnwQ2hALfGoXwqAMoL2gEi8+E0HgAFPdwjdAxJif87PwjkSM6CF3
         shLvr/MBrtRBU/8EaR+PHMRapyrNA/tJCJJa++e19Y4PomKN9fQWvb4RxBaCK/STXSaX
         TOJG5Dp9zy8jGTPK516QnNthw0gRluMz3GZVk2vphAiSKX2Uk2Fj8CUIVLaIZAYQCHkG
         NjOZrp/JX0rn/KMWP3o6vk6zTO9pKAqhzW8ZB5oq64LjLSerd10DK5ZVXko6py80Ef6a
         kxMgvduuRxfdP72MTGTMEz1v44ARXF6TYfKzSyHGiuAb5o7T4sz1M0x8w2jKkUlL4YOg
         rOtw==
X-Gm-Message-State: AOUpUlFSspm6DLHxho26HVwIX8oqQeZWpDvFt3Qyyn93b9d5kRk3qZml
        6q1MYFzDi6QRNbG7/9wbg/THjA==
X-Google-Smtp-Source: AAOMgpc1yUI59SrAVhWEF083a7bupO+qa9jyLZASpEfVjdMQSoglj1XvcLx9qlWCO4Z5PVDxJ3CIuA==
X-Received: by 2002:adf:8503:: with SMTP id 3-v6mr1564416wrh.100.1532092999629;
        Fri, 20 Jul 2018 06:23:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id x7-v6sm2447000wrr.95.2018.07.20.06.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:23:18 -0700 (PDT)
Subject: Re: [PATCH V4 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
To:     Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org,
        jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-5-git-send-email-kgunda@codeaurora.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <9aff8c23-7c72-eaee-9d59-424cd34be4ac@linaro.org>
Date:   Fri, 20 Jul 2018 14:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531131741-19971-5-git-send-email-kgunda@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> Rename the PM8941* references as WLED3 to make the
> driver generic and have WLED support for other PMICs.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
> Changes from V3:
> 	- Changed the MODULE_DESCRIPTION
> 	
>   drivers/video/backlight/qcom-wled.c | 248 ++++++++++++++++++------------------
>   1 file changed, 125 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 0b6d219..3cd6e75 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -18,77 +18,79 @@
>   #include <linux/regmap.h>
>   
>   /* From DT binding */
> -#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
> +#define WLED_DEFAULT_BRIGHTNESS				2048
>   
> -#define PM8941_WLED_REG_VAL_BASE		0x40
> -#define  PM8941_WLED_REG_VAL_MAX		0xFFF
> +#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
> +#define WLED3_CTRL_REG_VAL_BASE				0x40
>   
> -#define PM8941_WLED_REG_MOD_EN			0x46
> -#define  PM8941_WLED_REG_MOD_EN_BIT		BIT(7)
> -#define  PM8941_WLED_REG_MOD_EN_MASK		BIT(7)
> +/* WLED3 control registers */
> +#define WLED3_CTRL_REG_MOD_EN				0x46
> +#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
> +#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>   
> -#define PM8941_WLED_REG_SYNC			0x47
> -#define  PM8941_WLED_REG_SYNC_MASK		0x07
> -#define  PM8941_WLED_REG_SYNC_LED1		BIT(0)
> -#define  PM8941_WLED_REG_SYNC_LED2		BIT(1)
> -#define  PM8941_WLED_REG_SYNC_LED3		BIT(2)
> -#define  PM8941_WLED_REG_SYNC_ALL		0x07
> -#define  PM8941_WLED_REG_SYNC_CLEAR		0x00
> +#define WLED3_CTRL_REG_FREQ				0x4c
> +#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
>   
> -#define PM8941_WLED_REG_FREQ			0x4c
> -#define  PM8941_WLED_REG_FREQ_MASK		0x0f
> +#define WLED3_CTRL_REG_OVP				0x4d
> +#define  WLED3_CTRL_REG_OVP_MASK			0x03
>   
> -#define PM8941_WLED_REG_OVP			0x4d
> -#define  PM8941_WLED_REG_OVP_MASK		0x03
> +#define WLED3_CTRL_REG_ILIMIT				0x4e
> +#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
>   
> -#define PM8941_WLED_REG_BOOST			0x4e
> -#define  PM8941_WLED_REG_BOOST_MASK		0x07
> +/* WLED3 sink registers */
> +#define WLED3_SINK_REG_SYNC				0x47
> +#define  WLED3_SINK_REG_SYNC_MASK			0x07
> +#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
> +#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
> +#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
> +#define  WLED3_SINK_REG_SYNC_ALL			0x07
> +#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>   
> -#define PM8941_WLED_REG_SINK			0x4f
> -#define  PM8941_WLED_REG_SINK_MASK		0xe0
> -#define  PM8941_WLED_REG_SINK_SHFT		0x05
> +#define WLED3_SINK_REG_CURR_SINK			0x4f
> +#define  WLED3_SINK_REG_CURR_SINK_MASK			0xe0
> +#define  WLED3_SINK_REG_CURR_SINK_SHFT			0x05
>   
> -/* Per-'string' registers below */
> -#define PM8941_WLED_REG_STR_OFFSET		0x10
> +/* WLED3 per-'string' registers below */
> +#define WLED3_SINK_REG_STR_OFFSET			0x10
>   
> -#define PM8941_WLED_REG_STR_MOD_EN_BASE		0x60
> -#define  PM8941_WLED_REG_STR_MOD_MASK		BIT(7)
> -#define  PM8941_WLED_REG_STR_MOD_EN		BIT(7)
> +#define WLED3_SINK_REG_STR_MOD_EN_BASE			0x60
> +#define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
> +#define  WLED3_SINK_REG_STR_MOD_EN			BIT(7)
>   
> -#define PM8941_WLED_REG_STR_SCALE_BASE		0x62
> -#define  PM8941_WLED_REG_STR_SCALE_MASK		0x1f
> +#define WLED3_SINK_REG_STR_FULL_SCALE_CURR		0x62
> +#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	0x1f
>   
> -#define PM8941_WLED_REG_STR_MOD_SRC_BASE	0x63
> -#define  PM8941_WLED_REG_STR_MOD_SRC_MASK	0x01
> -#define  PM8941_WLED_REG_STR_MOD_SRC_INT	0x00
> -#define  PM8941_WLED_REG_STR_MOD_SRC_EXT	0x01
> +#define WLED3_SINK_REG_STR_MOD_SRC_BASE			0x63
> +#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		0x01
> +#define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
> +#define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
>   
> -#define PM8941_WLED_REG_STR_CABC_BASE		0x66
> -#define  PM8941_WLED_REG_STR_CABC_MASK		BIT(7)
> -#define  PM8941_WLED_REG_STR_CABC_EN		BIT(7)
> +#define WLED3_SINK_REG_STR_CABC_BASE			0x66
> +#define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
> +#define  WLED3_SINK_REG_STR_CABC_EN			BIT(7)
>   
> -struct pm8941_wled_config {
> -	u32 i_boost_limit;
> +struct wled_config {
> +	u32 boost_i_limit;
>   	u32 ovp;
>   	u32 switch_freq;
>   	u32 num_strings;
> -	u32 i_limit;
> +	u32 string_i_limit;

This patch implements a grand renaming and I have no objections to 
including change for boost_i_limit and string_i_limit in it. I'd prefer 
it to be mentioned in the patch header though.

Once that is done:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
