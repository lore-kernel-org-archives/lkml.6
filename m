Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1EC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658F720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsdlF5TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658F720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeFSWwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:52:16 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43672 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbeFSWwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:52:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id a14-v6so522380pgw.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/FpeW9pdydHAPmF0Dy5xddgnfcfs/lvQw3zwwY8dns=;
        b=ZsdlF5TDz7tw2+47Hfe8euObw/PeAdwIIl+u6jiO+wcxUq6w1oQG62Js5edmOLjtkp
         nqv5Qx2svZ5qbnhMV6Pd6qMe0LYFO1SnxFhYox/Mb4+b5gUGyOetCL7vENQiEBfFYKbN
         GbGgmyaWXezpJvL4yiUqGMHeMyUNmBPjWANWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/FpeW9pdydHAPmF0Dy5xddgnfcfs/lvQw3zwwY8dns=;
        b=eR05b/lXa7boa0ULHvOKvoChEBeerFfIfsoUwGDd00SDgx2sfiNE1pSo6DaGjYjoL5
         BXxV6naqGrV84YwV8+yzuSqdO50fxLsksoWwm9iQxJw2YIV1P9cC4PEHoIfzOAdTjNfY
         X/ZKckPfij2XEFvtdMMuPdQ1skQF7e78F7TWJ/oyhpv8PqQqQXaajZqU2MFDcyVbgR0Y
         tyh3ApnI5WS+35JkAYPjwspuQwEREiQHMUZ78zH41s35WpCuoIYZnnGmnpVJZznnjUnY
         f6UHkKLX0HcAZdX+3LLn/sfw6zqcVFiP9ztgAyaafBztQYKpXzgAFrucctvtMtLHyCde
         fsdQ==
X-Gm-Message-State: APt69E1SJ8glJ3PUkbEm0Xeds70w/gtoUbrMD7jDDm8ZzibJuanv6EDa
        toxm9YF85t4vf8Pj9Ir9BDLXeg==
X-Google-Smtp-Source: ADUXVKKa19Bhf9L+jTzGUTVILHVYM7yufbQu6QywMHfYRSGM0GG5uDquLmwv7UpdLgTyJwWjUC2MUg==
X-Received: by 2002:a62:121a:: with SMTP id a26-v6mr20114149pfj.104.1529448723152;
        Tue, 19 Jun 2018 15:52:03 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j3-v6sm875873pff.35.2018.06.19.15.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 15:52:02 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:54:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 1/7] backlight: qcom-wled: Rename pm8941-wled.c to
 qcom-wled.c
Message-ID: <20180619225421.GE15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-2-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Please carry any tags acquired when reposting patches without changes
and please add a "Changes since v???:" list below the --- to expedite
the review process.


This is still 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-
>  drivers/video/backlight/Kconfig                                   | 8 ++++----
>  drivers/video/backlight/Makefile                                  | 2 +-
>  drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
>  rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> similarity index 95%
> rename from Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> rename to Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> index e5b294d..fb39e32 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> @@ -1,4 +1,4 @@
> -Binding for Qualcomm PM8941 WLED driver
> +Binding for Qualcomm Technologies, Inc. WLED driver
>  
>  Required properties:
>  - compatible: should be "qcom,pm8941-wled"
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 4e1d2ad..8c095e3 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -299,12 +299,12 @@ config BACKLIGHT_TOSA
>  	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
>  	  for its backlight
>  
> -config BACKLIGHT_PM8941_WLED
> -	tristate "Qualcomm PM8941 WLED Driver"
> +config BACKLIGHT_QCOM_WLED
> +	tristate "Qualcomm PMIC WLED Driver"
>  	select REGMAP
>  	help
> -	  If you have the Qualcomm PM8941, say Y to enable a driver for the
> -	  WLED block.
> +	  If you have the Qualcomm PMIC, say Y to enable a driver for the
> +	  WLED block. Currently it supports PM8941 and PMI8998.
>  
>  config BACKLIGHT_SAHARA
>  	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index 5e28f01..6fd76ef 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -49,8 +49,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
>  obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
>  obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
>  obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
> -obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
>  obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
> +obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
>  obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
>  obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
>  obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/qcom-wled.c
> similarity index 100%
> rename from drivers/video/backlight/pm8941-wled.c
> rename to drivers/video/backlight/qcom-wled.c
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 
