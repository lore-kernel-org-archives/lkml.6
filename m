Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F76BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2642084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzt3t0mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2642084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934874AbeFLWVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:21:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36123 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbeFLWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:21:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so287350plp.3;
        Tue, 12 Jun 2018 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m7K+iPuN7HMWI/Q2hEwu98irLoy95XPWUtDzK9wz4D4=;
        b=Jzt3t0mw13S4dmZrD/n+GcZhUzfR93MeNwBCOeTvVrPPQBn7ap6eies4FGOFYmk1Lb
         U/WDqqR9wQuHMvuYvok6Z4GIGp1XOOvZrHeeOkfKYXQt4y2ZZI3Pqkuc/wBn77PwVJ9L
         AG7RdukHuHquToD+zXG0VKtxUqDK+6uUBMcMF5mjOT7+m7eCwi1Jip0wrtFw0Ba+/YEo
         iI917tBoThqJO4dTwF3U48PEo5j2TW8+EDQwHWOlvjLXHU9VPgnJ07iYXk8SILQ9Aomv
         zNtlgNqj9Qwoi4W7WOP9P4NKp2f6DmaA8a4lB7woJaKDObUOLs2a+9p63qyiXl69SHH+
         ZPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m7K+iPuN7HMWI/Q2hEwu98irLoy95XPWUtDzK9wz4D4=;
        b=j+EGB1sQOPeBmgqcUGLyApKeT+Ytv3OZFeQNcsKGN4DQ+GoWqNvuBw14BGTAJ9g7rh
         MvY9PEDxrgdxu4WavO5ICOOrR8gWr/i19YFPRrGOFPnLTjKS8ziSHfbVdtrdU7cS+cuz
         j353OtYMmOMqIooaQ9+KAtX/GYqANR13GkmYw3NVRve4GlEIW8rtWyDwHlXnf8rSunEh
         z3nN0zUSeM4yjeXDxQGJFog2jpnfPtaJQawe0/o0W9mVc0IgR5mGpVKP1zHw3QWn4iQ7
         wU9UxAjmUGKWeBhTgptkCqulsMsl8jJbHfsveB0YaWjakvOip/xHAapifnbZakbqnUMo
         0LfA==
X-Gm-Message-State: APt69E1MX9PtUTyIvrxEEzlClVzp0zYFNH+7s2Xytj+AylFqOOgHlHy+
        6m6HeAg1GwaatcXASbpOecA=
X-Google-Smtp-Source: ADUXVKKBNAiSS7jpb1AYXJQr7iPl+ga8w4MMJFN3PCVYSsogW1dpt7hW/whs1SKIFjO0xW6PhXpGXA==
X-Received: by 2002:a17:902:8308:: with SMTP id bd8-v6mr2301844plb.329.1528842067956;
        Tue, 12 Jun 2018 15:21:07 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id d88-v6sm1540875pfb.43.2018.06.12.15.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:21:06 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:21:04 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] Input: ams_delta_serio: use IRQ resource
Message-ID: <20180612222104.GC38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180609140224.32606-9-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609140224.32606-9-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 04:02:23PM +0200, Janusz Krzysztofik wrote:
> The driver still obtains IRQ number from a hardcoded GPIO.  Use IRQ
> resource instead.
> 
> For this to work on Amstrad Delta, add the IRQ resource to
> ams-delta-serio platform device structure.  Obtain the IRQ number
> assigned to "keyboard_clk" GPIO pin from FIQ initialization routine.
> 
> As a benefit, the driver no longer needs to include
> <mach/board-ams-delta.h>.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  arch/arm/mach-omap1/ams-delta-fiq.c   |  8 +++++++-
>  arch/arm/mach-omap1/ams-delta-fiq.h   |  3 ++-
>  arch/arm/mach-omap1/board-ams-delta.c | 17 ++++++++++++++++-
>  drivers/input/serio/ams_delta_serio.c | 28 ++++++++++------------------
>  4 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index e72935034d42..e9d350117240 100644
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
> @@ -201,6 +203,10 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
>  	omap_writel(val, OMAP_IH1_BASE + offset);
>  
> +	/* Initialize serio device IRQ resource */
> +	serio->resource[0].start = gpiod_to_irq(clk);
> +	serio->resource[0].end = serio->resource[0].start;
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
> index 5d0bd2005648..03640b171516 100644
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
> @@ -129,9 +126,12 @@ static int ams_delta_serio_init(struct platform_device *pdev)
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
> @@ -141,14 +141,11 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	 * at FIQ level, switch back from edge to simple interrupt handler
>  	 * to avoid bad interaction.
>  	 */
> -	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> -			handle_simple_irq);
> +	irq_set_handler(irq, handle_simple_irq);

Do we still need to do this here, or it can be moved into board file?

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
> @@ -167,10 +164,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
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
> @@ -178,7 +171,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
>  	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
>  
>  	serio_unregister_port(priv->serio);
> -	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  
>  	return 0;
>  }
> -- 
> 2.16.1
> 

-- 
Dmitry
