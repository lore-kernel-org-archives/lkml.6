Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF75C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD64022B1B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRezDLSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD64022B1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934064AbeFVALb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:11:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41737 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeFVAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:11:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so2300438pff.8;
        Thu, 21 Jun 2018 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jlCjZp/i2cm1KcXbxHdN94frgbbcY1KC+GY4A1Ww5AI=;
        b=sRezDLSrehXXg+scJVuwdPtNgXEDsk3feC6D7LBXHW6YFL9pNOCKN0CExkm7r/lpK3
         slwpMoQ8H23rO4B/4Awl4ALP3zS0QkB/XnNmeHjvB5WvCPGAi4GpWc1yml8qMKk7Fb+u
         Feb7gMlDWjxH+IjuDVqAO2BVpI6f5ywLvw4yqVkqE3CVXFklkBLWTOg9n5C8vxHGBY6M
         w6s09jmKg2/OlhScveEFMNO4o410Xw0KUFJbSjfkOqofFu1ND79qAUeU0X6a1+XLvZU/
         ZCnezSf/LZOGL1nU9CVwfQj75dzc43mB8dicLHY3/lqDdKlTD5WvuulFjC8YGlmNsjBh
         JoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlCjZp/i2cm1KcXbxHdN94frgbbcY1KC+GY4A1Ww5AI=;
        b=jSllnU/4EimHUkhbwTOJhKuE7LT/mXyFpnNLmPhaKtv3qNE57RFDKypc4fan+FZfnT
         +QgsnbUNXRHySaBgAOOxH3ItrMQGdAbuszzcl9RyNdGQBUvHU8SO7iJbUKqVmVlYDKG9
         icSDWr0QHg6yexbppRFIOUzNVxjIh06LwnVvzgxyhupgYwQGmjhKUOv72cvDKcrtsXlx
         nc281NYcJDg57lvfFWCZFMY+7zTBAEYb5/E+I9JXEixdrji6c60fKKnrJt6ZWLKjDAxN
         Q85IjefQYHHvzKW1H1C92cFddtiMkvmr626rwYvvZSjBBwE+D9IdU/un9JYEfoIqWcjR
         EhWQ==
X-Gm-Message-State: APt69E0L26JX2RRrUUYNks4HixP9NeBVtiUA3Fd8ROzHPTLXvvCNkMke
        56Ac3hEFYLBzNskOnyk10ug=
X-Google-Smtp-Source: ADUXVKJrlFnt2Qa6jr+iRs0SAjZupc+oJNI1AL+1Bf6/hyssOdyXJ7RR0NovAeKVfr8oVKQl2OJH6g==
X-Received: by 2002:a62:d97:: with SMTP id 23-v6mr29675852pfn.202.1529626288108;
        Thu, 21 Jun 2018 17:11:28 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id l11-v6sm8789014pff.50.2018.06.21.17.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:11:26 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:11:24 -0700
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
Subject: Re: [PATCH v2 09/10] Input: ams_delta_serio: use IRQ resource
Message-ID: <20180622001124.GF79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-9-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-9-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:27AM +0200, Janusz Krzysztofik wrote:
> The driver still obtains IRQ number from a hardcoded GPIO.  Use IRQ
> resource instead.
> 
> For this to work on Amstrad Delta, add the IRQ resource to
> ams-delta-serio platform device structure.  Obtain the IRQ number
> assigned to "keybrd_clk" GPIO pin from FIQ initialization routine.
> 
> As a benefit, the driver no longer needs to include
> <mach/board-ams-delta.h>.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Input bits look good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changelog:
> v2: - obsolete assignment of handle_simple_irq() removed from the driver
>       and replaced with a comment in the FIQ init file,
>     - rebased on v4.18-rc1, no conflicts.
> 
>  arch/arm/mach-omap1/ams-delta-fiq.c   | 20 +++++++++++++++++++-
>  arch/arm/mach-omap1/ams-delta-fiq.h   |  3 ++-
>  arch/arm/mach-omap1/board-ams-delta.c | 17 ++++++++++++++++-
>  drivers/input/serio/ams_delta_serio.c | 32 +++++++++-----------------------
>  4 files changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index e72935034d42..82ca4246a5e4 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/platform_data/ams-delta-fiq.h>
> +#include <linux/platform_device.h>
>  
>  #include <mach/board-ams-delta.h>
>  
> @@ -84,7 +85,8 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -void __init ams_delta_init_fiq(struct gpio_chip *chip)
> +void __init ams_delta_init_fiq(struct gpio_chip *chip,
> +			       struct platform_device *serio)
>  {
>  	struct gpio_desc *gpiod, *data = NULL, *clk = NULL;
>  	void *fiqhandler_start;
> @@ -201,6 +203,22 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
>  	omap_writel(val, OMAP_IH1_BASE + offset);
>  
> +	/* Initialize serio device IRQ resource */
> +	serio->resource[0].start = gpiod_to_irq(clk);
> +	serio->resource[0].end = serio->resource[0].start;
> +
> +	/*
> +	 * Since FIQ handler performs handling of GPIO registers for
> +	 * "keybrd_clk" IRQ pin, ams_delta_serio driver used to set
> +	 * handle_simple_irq() as active IRQ handler for that pin to avoid
> +	 * bad interaction with gpio-omap driver.  This is no longer needed
> +	 * as handle_simple_irq() is now the default handler for OMAP GPIO
> +	 * edge interrupts.
> +	 * This comment replaces the obsolete code which has been removed
> +	 * from the ams_delta_serio driver and stands here only as a reminder
> +	 * of that dependency on gpio-omap driver behavior.
> +	 */
> +
>  	return;
>  
>  out_gpio:
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.h b/arch/arm/mach-omap1/ams-delta-fiq.h
> index 3f691d68aa62..fd76df3cce37 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.h
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.h
> @@ -35,7 +35,8 @@
>  #ifndef __ASSEMBLER__
>  extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
>  
> -extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
> +extern void __init ams_delta_init_fiq(struct gpio_chip *chip,
> +				      struct platform_device *pdev);
>  #endif
>  
>  #endif
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index fe9a3e7cbfeb..84177ba3e39a 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -504,9 +504,24 @@ static struct platform_device cx20442_codec_device = {
>  	.id     = -1,
>  };
>  
> +static struct resource ams_delta_serio_resources[] = {
> +	{
> +		.flags	= IORESOURCE_IRQ,
> +		/*
> +		 * Initialize IRQ resource with invalid IRQ number.
> +		 * It will be replaced with dynamically allocated GPIO IRQ
> +		 * obtained from GPIO chip as soon as the chip is available.
> +		 */
> +		.start	= -EINVAL,
> +		.end	= -EINVAL,
> +	},
> +};
> +
>  static struct platform_device ams_delta_serio_device = {
>  	.name		= "ams-delta-serio",
>  	.id		= PLATFORM_DEVID_NONE,
> +	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
> +	.resource	= ams_delta_serio_resources,
>  };
>  
>  static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
> @@ -615,7 +630,7 @@ static void __init omap_gpio_deps_init(void)
>  		return;
>  	}
>  
> -	ams_delta_init_fiq(chip);
> +	ams_delta_init_fiq(chip, &ams_delta_serio_device);
>  }
>  
>  static void __init ams_delta_init(void)
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 2602f7cff5ae..c1f8226f172e 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -20,7 +20,6 @@
>   * However, when used with the E3 mailboard that producecs non-standard
>   * scancodes, a custom key table must be prepared and loaded from userspace.
>   */
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/platform_data/ams-delta-fiq.h>
>  #include <linux/platform_device.h>
> @@ -29,8 +28,6 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> -#include <mach/board-ams-delta.h>
> -
>  #define DRIVER_NAME	"ams-delta-serio"
>  
>  MODULE_AUTHOR("Matt Callow");
> @@ -113,7 +110,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  {
>  	struct ams_delta_serio *priv;
>  	struct serio *serio;
> -	int err;
> +	int irq, err;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -139,26 +136,20 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> -			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
> -			DRIVER_NAME, priv);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENXIO;
> +
> +	err = devm_request_irq(&pdev->dev, irq, ams_delta_serio_interrupt,
> +			       IRQ_TYPE_EDGE_RISING, DRIVER_NAME, priv);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
>  		return err;
>  	}
> -	/*
> -	 * Since GPIO register handling for keyboard clock pin is performed
> -	 * at FIQ level, switch back from edge to simple interrupt handler
> -	 * to avoid bad interaction.
> -	 */
> -	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> -			handle_simple_irq);
>  
>  	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
> -	if (!serio) {
> -		err = -ENOMEM;
> -		goto irq;
> -	}
> +	if (!serio)
> +		return -ENOMEM;
>  
>  	priv->serio = serio;
>  
> @@ -177,10 +168,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	dev_info(&serio->dev, "%s\n", serio->name);
>  
>  	return 0;
> -
> -irq:
> -	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
> -	return err;
>  }
>  
>  static int ams_delta_serio_exit(struct platform_device *pdev)
> @@ -188,7 +175,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
>  	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
>  
>  	serio_unregister_port(priv->serio);
> -	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  
>  	return 0;
>  }
> -- 
> 2.16.4
> 

-- 
Dmitry
