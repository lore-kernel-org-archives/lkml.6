Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EAB2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545133859;
	bh=nblaxNNHefyPhg0wrTsH682ntfwBmVfaoMWh0viGRNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HJ/pKGl+aE+xXVe51JBeOySS0VBvABKYUnYqwOtqTnQ0MenmN9tndseOBdNaZdb42
	 9RPVWaNVts3xdlH2O5x8giEFP/shMwh0T86RZDfNquaCrgec1vQ46rIEuittzgO1Qy
	 KRO6kX90kObb8Oue+vUR+Dv76gO3KeF6PKB8J2Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLRLu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:50:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40968 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:50:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so13929409ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Awg+7zbzPKI/G6OgGkKHeXqJugO2brKL/TL5CGifPg=;
        b=sKRaKByHdPKPsV9Ng2mQkY39Ck/ruWIyt8KAQo6fVgrYhpxas5EXeuSQvNrRqP0PN8
         nIhchzJstnt9g+SjjtpkT7LsUQCmqLABU2r690xoDek949yA04dDSEcwqV/TiV5Ay1Mr
         W0UUjWJbsAF306pptEcqwuZB8bkbn5h4CaXyUxuieJ7adqEqYjv2IHU02okTLb4c52vw
         oPM/bvxjf2GlLzr8uOwGGGq4TJNshIG7PDKt1AWMRMWR84gsViUTkcF+ekR/tA7abtvu
         B5w1D11deJprhDIHEc9TbhwRyZI47QHF1H+BRVhsCxHr5YqNUJGUxyhgu70SggjhQkeq
         nl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Awg+7zbzPKI/G6OgGkKHeXqJugO2brKL/TL5CGifPg=;
        b=r4UeoM+NDPSbajXOjv7+UDGClmB22VX7eu88Xm1RHYfwmn/s2SeelZw2lDT0IUnz3r
         LR+/mvhs4PM+gU6TIgrIZMMXmjy2nCKSDjGEaYE8rlCQbsL25GddAeYkTPhNN4iTdXz2
         nPmVNyMZAIkkd+RGc2YuhJ7pcl1m5msiPWm60uU3zu58afpzElHg5T2tNJtCtod9Pke2
         v9n6sG+uQc+/NtXxIotKhNm7O7ln7lDdPlZEHSJWip3+mxzfDJyhSSajATePhg9tJUsR
         aGodXlSZ9F2tkp/IqISnkUTuQG0Rvbfbgs/HceW7WIbDcC6gr170qMInBkE/utsNHdoO
         ppKQ==
X-Gm-Message-State: AA+aEWboCads8lKWTFIb47bui4qZPHk8dKXwDoJi2oyYGjcRWifUf3Lt
        y7IeCFemGLMCgFa2DaM50Es=
X-Google-Smtp-Source: AFSGD/UFfPX5cyW88UbZ9s9QT6PnURQv5cxm/zj+HfhduicJT3XbsySQvaQLuSWpBzrhl7yyH4W5Tw==
X-Received: by 2002:a2e:6a13:: with SMTP id f19-v6mr10881878ljc.41.1545133854478;
        Tue, 18 Dec 2018 03:50:54 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2953196ljc.5.2018.12.18.03.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:50:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gZDto-0005FG-QV; Tue, 18 Dec 2018 12:50:56 +0100
Date:   Tue, 18 Dec 2018 12:50:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: greybus: arche-platform: Switch to the
 gpio descriptor interface
Message-ID: <20181218115056.GO20658@localhost>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
 <2200db633d8e723b881ef355527afaef0d5ccf24.1542898267.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2200db633d8e723b881ef355527afaef0d5ccf24.1542898267.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:39:24PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated
> old non-descriptor interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v2:
>  - Move comment to the same line as to what it applies to.
> ---
>  drivers/staging/greybus/arche-platform.c | 119 ++++++++---------------
>  1 file changed, 41 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 4c36e88766e7..a5cea79d8e32 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -8,10 +8,9 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> @@ -45,14 +44,14 @@ enum svc_wakedetect_state {
>  
>  struct arche_platform_drvdata {
>  	/* Control GPIO signals to and from AP <=> SVC */
> -	int svc_reset_gpio;
> +	struct gpio_desc *svc_reset;
> +	struct gpio_desc *svc_sysboot;

Why move sysboot? The flag below is about reset (but should eventually
go away).

>  	bool is_reset_act_hi;
> -	int svc_sysboot_gpio;
> -	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
> +	struct gpio_desc *wake_detect; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
>  
>  	enum arche_platform_state state;
>  
> -	int svc_refclk_req;
> +	struct gpio_desc *svc_refclk_req;
>  	struct clk *svc_ref_clk;
>  
>  	struct pinctrl *pinctrl;
> @@ -85,9 +84,9 @@ static void arche_platform_set_wake_detect_state(
>  	arche_pdata->wake_detect_state = state;
>  }
>  
> -static inline void svc_reset_onoff(unsigned int gpio, bool onoff)
> +static inline void svc_reset_onoff(struct gpio_desc *gpio, bool onoff)
>  {
> -	gpio_set_value(gpio, onoff);
> +	gpiod_set_value(gpio, onoff);
>  }
>  
>  static int apb_cold_boot(struct device *dev, void *data)
> @@ -116,7 +115,6 @@ static int apb_poweroff(struct device *dev, void *data)
>  static void arche_platform_wd_irq_en(struct arche_platform_drvdata *arche_pdata)
>  {
>  	/* Enable interrupt here, to read event back from SVC */
> -	gpio_direction_input(arche_pdata->wake_detect_gpio);
>  	enable_irq(arche_pdata->wake_detect_irq);
>  }
>  
> @@ -160,7 +158,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  
>  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
>  
> -	if (gpio_get_value(arche_pdata->wake_detect_gpio)) {
> +	if (gpiod_get_value(arche_pdata->wake_detect)) {
>  		/* wake/detect rising */
>  
>  		/*
> @@ -224,10 +222,10 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
>  
>  	dev_info(arche_pdata->dev, "Booting from cold boot state\n");
>  
> -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> +	svc_reset_onoff(arche_pdata->svc_reset,

No need to break line here.

>  			arche_pdata->is_reset_act_hi);
>  
> -	gpio_set_value(arche_pdata->svc_sysboot_gpio, 0);
> +	gpiod_set_value(arche_pdata->svc_sysboot, 0);
>  	usleep_range(100, 200);
>  
>  	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
> @@ -238,7 +236,7 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
>  	}
>  
>  	/* bring SVC out of reset */
> -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> +	svc_reset_onoff(arche_pdata->svc_reset,

Same here. Please check throughout.

>  			!arche_pdata->is_reset_act_hi);
>  
>  	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_ACTIVE);
> @@ -259,10 +257,10 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
>  
>  	dev_info(arche_pdata->dev, "Switching to FW flashing state\n");
>  
> -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> +	svc_reset_onoff(arche_pdata->svc_reset,
>  			arche_pdata->is_reset_act_hi);
>  
> -	gpio_set_value(arche_pdata->svc_sysboot_gpio, 1);
> +	gpiod_set_value(arche_pdata->svc_sysboot, 1);
>  
>  	usleep_range(100, 200);
>  
> @@ -273,7 +271,7 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
>  		return ret;
>  	}
>  
> -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> +	svc_reset_onoff(arche_pdata->svc_reset,
>  			!arche_pdata->is_reset_act_hi);
>  
>  	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_FW_FLASHING);
> @@ -305,7 +303,7 @@ arche_platform_poweroff_seq(struct arche_platform_drvdata *arche_pdata)
>  	clk_disable_unprepare(arche_pdata->svc_ref_clk);
>  
>  	/* As part of exit, put APB back in reset state */
> -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> +	svc_reset_onoff(arche_pdata->svc_reset,
>  			arche_pdata->is_reset_act_hi);
>  
>  	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
> @@ -435,6 +433,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	int ret;
> +	unsigned int flags;
>  
>  	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
>  				   GFP_KERNEL);
> @@ -444,61 +443,33 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	/* setup svc reset gpio */
>  	arche_pdata->is_reset_act_hi = of_property_read_bool(np,
>  							     "svc,reset-active-high");

This should also go away eventually in favour of gpio flags in
devicetree. Fine to keep for now, though.

> -	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
> -							"svc,reset-gpio",
> -							0);
> -	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
> -		dev_err(dev, "failed to get reset-gpio\n");
> -		return arche_pdata->svc_reset_gpio;
> -	}
> -	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
> -	if (ret) {
> -		dev_err(dev, "failed to request svc-reset gpio:%d\n", ret);
> -		return ret;
> -	}
> -	ret = gpio_direction_output(arche_pdata->svc_reset_gpio,
> -				    arche_pdata->is_reset_act_hi);
> -	if (ret) {
> -		dev_err(dev, "failed to set svc-reset gpio dir:%d\n", ret);
> +	if (arche_pdata->is_reset_act_hi)
> +		flags = GPIOD_OUT_HIGH;
> +	else
> +		flags = GPIOD_OUT_LOW;
> +
> +	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset-gpio", flags);
> +	if (IS_ERR(arche_pdata->svc_reset)) {
> +		ret = PTR_ERR(arche_pdata->svc_reset);
> +		dev_err(dev, "failed to request svc-reset GPIO:%d\n", ret);
>  		return ret;
>  	}

Thanks,
Johan
