Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B075DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5734F22AC6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6NhRDRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5734F22AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbeFVAFJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:05:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38875 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeFVAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:05:06 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so2518406plo.5;
        Thu, 21 Jun 2018 17:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7oK9t2F3dsGOZfcb7IUaGxaob3bTdz+ztOaX/m2wKlM=;
        b=F6NhRDRtKO46Wdg5N1KQpoTt0FC6N26Scch2kKhVMnwOhdhX8HaLfMpfNc0DaMlXSJ
         5PN3nTFBC1GkXjW76D5v2l0MVpsiBsECehmPLoKgpNiUKn/VfwfTbdcaqrvbMsUoaQc8
         vbJDS4JpvN+Dak8VwWwmozWuvMT9EzaBrCbmMADGX/hWzHE5FHN/3MDuu1mPtCrQuiFR
         P0G2lBd7QBPmqdYX38MJ+jN/KmFwPBzZP/HZIDfT3DeXvZTN2+1FIabEWr08o8et5C9J
         uikdrMVJf3FpexSt6LnLf/HPdV7p7BfNETjIvtBaA7Wns/VBwDBwcjOj8BQe3FVeXKHS
         8zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7oK9t2F3dsGOZfcb7IUaGxaob3bTdz+ztOaX/m2wKlM=;
        b=oDGTUHo7d4PMhN6teG1b19HK87VdbZWXCHVOJu7JsTo6BpZeJ3kAy7VBuqpQS/Ptdb
         MtbhKoBnsfuZPaemo5YdJBo7nnbaQwpr+Gjr1yZDvSisXbVo9WNxTHrCvs5AKpbWxHnD
         iFbh7JmPV+7+F1h4sXC4lgHQGXdNj/qFlIhMnZ/vE0EBkIOfElBCzTLHJzAV3Bg6XlBN
         od4l2gYchm0hUv4o6BE8zqiNsHfqmkbdSv4an4SZOmcPCGCk1XMGlEhQW6AY5cPG8hZm
         mZ5SsrGfzz5kWfps1S21TJ10cQOzB61jp8XoxfMCExfwHPLTdiV6Swt9E5kc8AF8h/Yj
         878A==
X-Gm-Message-State: APt69E1o2HqP0z2PbVpAXMUrx4h/V/y3pwikgn14jPcThKkWtmXhRz12
        J08eTs2P/gGvik6jQdYCEZM=
X-Google-Smtp-Source: ADUXVKJXxdjnbmcO+vaHQ8XOfXfo5116f2Qzrcz+vmRryqW/62nhTKt48Vo86q0/S5h+Yoky6vSprg==
X-Received: by 2002:a17:902:7048:: with SMTP id h8-v6mr30696049plt.269.1529625905251;
        Thu, 21 Jun 2018 17:05:05 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id t68-v6sm10241636pfe.91.2018.06.21.17.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:05:04 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:05:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] Input: ams_delta_serio: convert to platform
 driver
Message-ID: <20180622000502.GA79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-2-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-2-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:20AM +0200, Janusz Krzysztofik wrote:
> Convert the driver to an "ams-delta-serio" platform driver.  For it to
> be used with Amstrad Delta, register an "ams-delta-serio" platform
> device from the board init file.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Changelog:
> v2: rebased on v4.18-rc1, no conflicts

Input bits look good to me.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
>  arch/arm/mach-omap1/board-ams-delta.c |  6 ++++++
>  drivers/input/serio/ams_delta_serio.c | 34 +++++++++++++++++++++-------------
>  2 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 18e0ff437b27..2119d2d3ba84 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -504,12 +504,18 @@ static struct platform_device cx20442_codec_device = {
>  	.id     = -1,
>  };
>  
> +static struct platform_device ams_delta_serio_device = {
> +	.name		= "ams-delta-serio",
> +	.id		= PLATFORM_DEVID_NONE,
> +};
> +
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
>  	&ams_delta_kp_device,
>  	&ams_delta_camera_device,
>  	&ams_delta_audio_device,
> +	&ams_delta_serio_device,
>  };
>  
>  static struct platform_device *late_devices[] __initdata = {
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 3df501c3421b..a2a7fa19bf49 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -22,15 +22,17 @@
>   */
>  #include <linux/gpio.h>
>  #include <linux/irq.h>
> +#include <linux/platform_device.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> -#include <asm/mach-types.h>
>  #include <mach/board-ams-delta.h>
>  
>  #include <mach/ams-delta-fiq.h>
>  
> +#define DRIVER_NAME	"ams-delta-serio"
> +
>  MODULE_AUTHOR("Matt Callow");
>  MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
>  MODULE_LICENSE("GPL");
> @@ -126,13 +128,10 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
>  	},
>  };
>  
> -static int __init ams_delta_serio_init(void)
> +static int ams_delta_serio_init(struct platform_device *pdev)
>  {
>  	int err;
>  
> -	if (!machine_is_ams_delta())
> -		return -ENODEV;
> -
>  	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!ams_delta_serio)
>  		return -ENOMEM;
> @@ -142,22 +141,22 @@ static int __init ams_delta_serio_init(void)
>  	ams_delta_serio->close = ams_delta_serio_close;
>  	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
>  			sizeof(ams_delta_serio->name));
> -	strlcpy(ams_delta_serio->phys, "GPIO/serio0",
> +	strlcpy(ams_delta_serio->phys, dev_name(&pdev->dev),
>  			sizeof(ams_delta_serio->phys));
> +	ams_delta_serio->dev.parent = &pdev->dev;
>  
>  	err = gpio_request_array(ams_delta_gpios,
>  				ARRAY_SIZE(ams_delta_gpios));
>  	if (err) {
> -		pr_err("ams_delta_serio: Couldn't request gpio pins\n");
> +		dev_err(&pdev->dev, "Couldn't request gpio pins\n");
>  		goto serio;
>  	}
>  
>  	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
>  			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
> -			"ams-delta-serio", 0);
> +			DRIVER_NAME, 0);
>  	if (err < 0) {
> -		pr_err("ams_delta_serio: couldn't request gpio interrupt %d\n",
> -				gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
> +		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
>  		goto gpio;
>  	}
>  	/*
> @@ -179,13 +178,22 @@ static int __init ams_delta_serio_init(void)
>  	kfree(ams_delta_serio);
>  	return err;
>  }
> -module_init(ams_delta_serio_init);
>  
> -static void __exit ams_delta_serio_exit(void)
> +static int ams_delta_serio_exit(struct platform_device *pdev)
>  {
>  	serio_unregister_port(ams_delta_serio);
>  	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  	gpio_free_array(ams_delta_gpios,
>  			ARRAY_SIZE(ams_delta_gpios));
> +
> +	return 0;
>  }
> -module_exit(ams_delta_serio_exit);
> +
> +static struct platform_driver ams_delta_serio_driver = {
> +	.probe	= ams_delta_serio_init,
> +	.remove	= ams_delta_serio_exit,
> +	.driver	= {
> +		.name	= DRIVER_NAME
> +	},
> +};
> +module_platform_driver(ams_delta_serio_driver);
> -- 
> 2.16.4
> 

-- 
Dmitry
