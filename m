Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FFF22AF7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw1+u8M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FFF22AF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934007AbeFVAKJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:10:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46857 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbeFVAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:10:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so2294949pff.13;
        Thu, 21 Jun 2018 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mvw/fg7hmw0EJse7BBOVnLmNj4lIYkSTqH69Z4Xmlh0=;
        b=Fw1+u8M5mGk9KRdw5+ZsHyFNaI2nnLjgO+38PTXRerU3JrTy41C0UyV2aYQvJieL7E
         nU82jYLHDX4TKqON+SX3UW44x9KAzoet5+vZA6czcI0zEWKjo/UiWID4qaKbGhl81Vwj
         zZyTw/nFG8agwGbvQPnbP7IUaKI16/YXOD8vsb6b1RkmrQMJKDeOG0Z7//1f12Qd3UIq
         kwU20EObG8OEjqqBiZXe0nUhtmaYQHaQAbshV7wAglKKZOrZ0N/kOFIiN2SppNty4v0K
         LwcOXYAadquoup068iY2ruyNNwKT3lbAjBiUEe3QxjYb2kH7HpvrrnZWoLf6kzJ+tgq+
         28wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvw/fg7hmw0EJse7BBOVnLmNj4lIYkSTqH69Z4Xmlh0=;
        b=r4w+aasJLHsklSmMy93Bs1Sgm7tgOK/F4buH/Q/VVtngvIbWeQfXo4pxYbokvR7I7g
         Lrcg53Vd0L2rYmIOR5ZSaGX8BoVgy58lL7E1JfXR5h76N4TefB4/zv3sayb6IOZzhX5D
         eDPWlXcuPZZCY2Wf2JmFE8m2rSFM4K4Sa/CuPnY1c0eW3Oe8FDWfF+RP5AvFmQRTYCbC
         iRMnab398OdKsKehEjlw3dnQvNWXpIivizLB9w5+/94eJrYuUi/Wwl1HkNqsVjqIAn3T
         UoQOqtF/2nV6YZ2oih0Q3ilDOBE4kqOArvNdqQPEFPjUd/o18DNYY5Mg/QOY43P1Zkqe
         wrGg==
X-Gm-Message-State: APt69E0V/GTNuSPJ9RNjVccGSia/Pbmc4mnpZuOJfVuCBvZ4PFqqCQ45
        vw1o9Ji5RUq3GRKO4erex54=
X-Google-Smtp-Source: ADUXVKIM7x5FSPy4F1Pm3P+Nptpoax0N+W5S3YztM0tpZ724ymAuzIzGnOc1C2KLWPFqzxYXMnccjQ==
X-Received: by 2002:a63:6ac5:: with SMTP id f188-v6mr24029547pgc.195.1529626205790;
        Thu, 21 Jun 2018 17:10:05 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id t13-v6sm6788719pgv.43.2018.06.21.17.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:10:04 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:10:02 -0700
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
Subject: Re: [PATCH v2 07/10] ARM: OMAP1: ams-delta FIQ: Keep serio input
 GPIOs requested
Message-ID: <20180622001002.GD79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-7-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-7-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:25AM +0200, Janusz Krzysztofik wrote:
> From the very beginning, input GPIO pins of ams-delta serio port have
> been used by FIQ handler, not serio driver.
> 
> Don't request those pins from the ams-delta-serio driver any longer,
> instead keep them requested and initialized by the FIQ initialization
> routine which already requests them and releases while identifying GPIO
> IRQs.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Input bits look good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changelog:
> v2: rebased on v4.18-rc1, no conflicts
> 
>  arch/arm/mach-omap1/ams-delta-fiq.c   | 42 ++++++++++++++++++++++++++++++-----
>  drivers/input/serio/ams_delta_serio.c | 30 ++-----------------------
>  2 files changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index 1d54a6177f14..5a6c59ac9b5f 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -45,6 +45,11 @@ static struct irq_chip *irq_chip;
>  static struct irq_data *irq_data[16];
>  static unsigned int irq_counter[16];
>  
> +static const char *pin_name[16] __initconst = {
> +	[AMS_DELTA_GPIO_PIN_KEYBRD_DATA]	= "keybrd_data",
> +	[AMS_DELTA_GPIO_PIN_KEYBRD_CLK]		= "keybrd_clk",
> +};
> +
>  static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  {
>  	struct irq_data *d;
> @@ -80,7 +85,7 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
>  
>  void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  {
> -	struct gpio_desc *gpiod;
> +	struct gpio_desc *gpiod, *data = NULL, *clk = NULL;
>  	void *fiqhandler_start;
>  	unsigned int fiqhandler_length;
>  	struct pt_regs FIQ_regs;
> @@ -96,7 +101,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(irq_data); i++) {
> -		gpiod = gpiochip_request_own_desc(chip, i, NULL);
> +		gpiod = gpiochip_request_own_desc(chip, i, pin_name[i]);
>  		if (IS_ERR(gpiod)) {
>  			pr_err("%s: failed to get GPIO pin %d (%ld)\n",
>  			       __func__, i, PTR_ERR(gpiod));
> @@ -105,8 +110,27 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  		/* Store irq_data location for IRQ handler use */
>  		irq_data[i] = irq_get_irq_data(gpiod_to_irq(gpiod));
>  
> -		gpiochip_free_own_desc(gpiod);
> +		/*
> +		 * FIQ handler takes full control over serio data and clk GPIO
> +		 * pins.  Initiaize them and keep requested so nobody can
> +		 * interfere.  Fail if any of those two couldn't be requested.
> +		 */
> +		switch (i) {
> +		case AMS_DELTA_GPIO_PIN_KEYBRD_DATA:
> +			data = gpiod;
> +			gpiod_direction_input(data);
> +			break;
> +		case AMS_DELTA_GPIO_PIN_KEYBRD_CLK:
> +			clk = gpiod;
> +			gpiod_direction_input(clk);
> +			break;
> +		default:
> +			gpiochip_free_own_desc(gpiod);
> +			break;
> +		}
>  	}
> +	if (!data || !clk)
> +		goto out_gpio;
>  
>  	fiqhandler_start = &qwerty_fiqin_start;
>  	fiqhandler_length = &qwerty_fiqin_end - &qwerty_fiqin_start;
> @@ -117,7 +141,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	if (retval) {
>  		pr_err("ams_delta_init_fiq(): couldn't claim FIQ, ret=%d\n",
>  				retval);
> -		return;
> +		goto out_gpio;
>  	}
>  
>  	retval = request_irq(INT_DEFERRED_FIQ, deferred_fiq,
> @@ -125,7 +149,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	if (retval < 0) {
>  		pr_err("Failed to get deferred_fiq IRQ, ret=%d\n", retval);
>  		release_fiq(&fh);
> -		return;
> +		goto out_gpio;
>  	}
>  	/*
>  	 * Since no set_type() method is provided by OMAP irq chip,
> @@ -175,4 +199,12 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
>  	offset = IRQ_ILR0_REG_OFFSET + (INT_GPIO_BANK1 - NR_IRQS_LEGACY) * 0x4;
>  	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
>  	omap_writel(val, OMAP_IH1_BASE + offset);
> +
> +	return;
> +
> +out_gpio:
> +	if (data)
> +		gpiochip_free_own_desc(data);
> +	if (clk)
> +		gpiochip_free_own_desc(clk);
>  }
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index b955c6a72e99..7952a29f9540 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -110,19 +110,6 @@ static void ams_delta_serio_close(struct serio *serio)
>  	regulator_disable(priv->vcc);
>  }
>  
> -static const struct gpio ams_delta_gpios[] __initconst_or_module = {
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
> -		.flags	= GPIOF_DIR_IN,
> -		.label	= "serio-data",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
> -		.flags	= GPIOF_DIR_IN,
> -		.label	= "serio-clock",
> -	},
> -};
> -
>  static int ams_delta_serio_init(struct platform_device *pdev)
>  {
>  	struct ams_delta_serio *priv;
> @@ -133,13 +120,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	err = gpio_request_array(ams_delta_gpios,
> -				ARRAY_SIZE(ams_delta_gpios));
> -	if (err) {
> -		dev_err(&pdev->dev, "Couldn't request gpio pins\n");
> -		goto serio;
> -	}
> -
>  	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
>  	if (IS_ERR(priv->vcc)) {
>  		err = PTR_ERR(priv->vcc);
> @@ -157,7 +137,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  		 */
>  		if (err == -ENODEV)
>  			err = -EPROBE_DEFER;
> -		goto gpio;
> +		return err;
>  	}
>  
>  	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
> @@ -165,7 +145,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  			DRIVER_NAME, priv);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
> -		goto gpio;
> +		return err;
>  	}
>  	/*
>  	 * Since GPIO register handling for keyboard clock pin is performed
> @@ -201,10 +181,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  
>  irq:
>  	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
> -gpio:
> -	gpio_free_array(ams_delta_gpios,
> -			ARRAY_SIZE(ams_delta_gpios));
> -serio:
>  	return err;
>  }
>  
> @@ -214,8 +190,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
>  
>  	serio_unregister_port(priv->serio);
>  	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
> -	gpio_free_array(ams_delta_gpios,
> -			ARRAY_SIZE(ams_delta_gpios));
>  
>  	return 0;
>  }
> -- 
> 2.16.4
> 

-- 
Dmitry
