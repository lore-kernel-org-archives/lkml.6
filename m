Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1CAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6B22083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJBBx3zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6B22083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeFSXJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:09:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34206 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFSXJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:09:08 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so653593plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQxqiJQK48OQ2W+56zci+Pi99YVmSttp7nL9arqhl2o=;
        b=FJBBx3zMIfT3HqzK+ltO4Ap8yT4E8GsulUd+FUpkJUMgf66SaXHs2kJiQ8Gf+AwYvQ
         eao2qxqZeJlc+tS4pxhYNg4gVSAS7cRXJsJ3YSL9NL9J6/bU8Ncm/wC9dagiSS/ZxhnW
         dIEmlCrhzJe9inyOmKhQb1np8ZAhNwZwNdRZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQxqiJQK48OQ2W+56zci+Pi99YVmSttp7nL9arqhl2o=;
        b=RDS+UHvB/4tTBoXt/4820TPjdeR+eJwBq9jMkWHE8Fk/uPzZNtMw79ETzyJuLqiL0P
         z7qLuxTAdUBggQFhM66ZUTTE2+rwXzdjzyRQE965EB+IiDG1r2S2X63wr8pJ6CzF68M1
         EeyZaR19uHynElAvgHtN4shMyf2uITHx5jppn77OEBuzH3a9wChuu1AlHGW6wZtlS3Zr
         7uOiHHDe+R1wFf8CiiN4ETZBz2wcnpc0XmFgJo/fsQd7bRUUGJch4QxKp99g93yUVQSz
         uMyVoTiHxcTzmszWAXz1+KLhIpXNZy3Z5wcOHV2zY2DOBJY/+upnYBpdg0HA2IocDWEs
         vPOg==
X-Gm-Message-State: APt69E2AMMVchdomFpLXskip7ki4VEA2koib95jBX8raJ4cR1JYSbhKi
        vJGA0cUfi5tNV3OLzf5qNN0nqA==
X-Google-Smtp-Source: ADUXVKL3jxKF73GpEs0I7C1BfUViTNW6olmFFYNm++TCEnfqxwIWgCbUcPXaZGKqDx0+bIhzfURqmg==
X-Received: by 2002:a17:902:b494:: with SMTP id y20-v6mr20582385plr.136.1529449748048;
        Tue, 19 Jun 2018 16:09:08 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m11-v6sm1121283pfj.25.2018.06.19.16.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 16:09:07 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:11:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH V3 4/7] backlight: qcom-wled: Rename PM8941* to WLED3
Message-ID: <20180619231126.GH15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-5-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> Rename the PM8941* references as WLED3 to make the
> driver generic and have WLED support for other PMICs.
> 

Looks good, just three minor comments below.

> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 248 ++++++++++++++++++------------------
>  1 file changed, 125 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 0b6d219..812f3cb 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -18,77 +18,79 @@
>  #include <linux/regmap.h>
>  
>  /* From DT binding */
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

These are in address order, any reason why WLED3_SINK_REG_SYNC moved
down?

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
[..]
> -struct pm8941_wled_config {
> -	u32 i_boost_limit;
> +struct wled_config {
> +	u32 boost_i_limit;
>  	u32 ovp;
>  	u32 switch_freq;
>  	u32 num_strings;
> -	u32 i_limit;
> +	u32 string_i_limit;

Changing the members in this struct seems unrelated.

>  	bool cs_out_en;
>  	bool ext_gen;
>  	bool cabc_en;
>  };
>  
[..]
> -MODULE_DESCRIPTION("pm8941 wled driver");
> +MODULE_DESCRIPTION("qcom wled driver");

I would prefer if this was "Qualcomm WLED driver".

>  MODULE_LICENSE("GPL v2");

Regards,
Bjorn
