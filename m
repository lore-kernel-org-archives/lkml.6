Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4D7CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCBB20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1+euCp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCBB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934775AbeFLWRa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:17:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44219 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934314AbeFLWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:17:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so248795pfk.11;
        Tue, 12 Jun 2018 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y3W3VoKDmk6mD7Kdh8irRiR7WhP+WK1wfQiozUA53/4=;
        b=N1+euCp7GEuueG4OPpAoPx9uizlzqY0xdaMTwZEGiOgz55RhSv81NaZ3l70AQk6EuY
         nEPueuySz2Yj8lANImte3OQkriFqIT1Sct23HuSivSSNl5BpIwX9R8svsZxcX4XI6DV3
         b6pcovuLZ4tzZbZQnHb4nKbRycan9NliBhZTShxgb8Qw5LBiAe5aARuwRs+b5IQXGAs9
         12J1QxmW4CN2VdaGEjYf3vu+H4JFz2m/CMlCvNU3HVdglBOSTjKQ2t0I01NRnb1cDxWf
         AmENQJ3UFZgUZK1Oh+yKlq8nXPIooY0Ahihnvmv99O58m4EvtaE4tK8kcmDCeQ+Yxh0t
         I3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3W3VoKDmk6mD7Kdh8irRiR7WhP+WK1wfQiozUA53/4=;
        b=gkRLCP9ZNcFBJqou9czQA6WpQLnoIpC4ePToaedvP42aWE1ezS3p5ZHQa2uLzA3BW9
         BblA2jrdMOynis17+PC3AB68ozQl2P539zcwXeCSFLNO4LItuQt3oqcLkef2Sf0nxN3p
         l6+gRq9b60FGl6n8Hen7qs9NHCyd7Hz8BqoF/sJUpFkJYPwAp7NbIigSo5ByTEQnJJZz
         2LT2BW19/U8xzvgiDHTvfFlmCka39ptNTJ747pJ4NUJZD+20M6/a8qY820RRLk014U5u
         941TfMynwiQwLpBwVDU+TcwcBjBAKYx4a3RqeoZlkPL4erwchqTHcYv4yzJ9vjFJkkQo
         o1XA==
X-Gm-Message-State: APt69E0XDdbkqlJSsazhZXJzUgDBE2KBGDPQJVHtpxFJPm+3UwES8Yvi
        kOX+MgIm1ArPrI4xh5tKqiw=
X-Google-Smtp-Source: ADUXVKLlXToNpZotXsiDc6amq0NSdVn7UEdW3mKWcWuJlZBJnr87QySjvU/n6WzYZz1uBG2KPtUHRg==
X-Received: by 2002:a62:d9c5:: with SMTP id b66-v6mr2200800pfl.41.1528841847429;
        Tue, 12 Jun 2018 15:17:27 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id 68-v6sm1433976pfk.46.2018.06.12.15.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:17:26 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:17:24 -0700
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
Subject: Re: [PATCH 04/10] Input: ams_delta_serio: Replace power GPIO with
 regulator
Message-ID: <20180612221724.GB38773@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180609140224.32606-4-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609140224.32606-4-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 04:02:18PM +0200, Janusz Krzysztofik wrote:
> Modify the driver so it no longer requests and manipulates the
> "keybrd_pwr" GPIO pin but a "vcc" regulator supply instead.
> 
> For this to work with Amstrad Delta, define a regulator over the
> "keybrd_pwr" GPIO pin with the "vcc" supply for ams-delta-serio device
> and register it from the board file.  Both assign an absulute GPIO
> number to the soon depreciated .gpio member of the regulator config
> structure, and also build and register a GPIO lookup table so it is
> ready for use by the regulator driver as soon as its upcoming update
> is applied.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 63 +++++++++++++++++++++++++++++++++--
>  drivers/input/serio/ams_delta_serio.c | 27 ++++++++++-----
>  2 files changed, 79 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index 2119d2d3ba84..706eb2f9301d 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -509,6 +509,46 @@ static struct platform_device ams_delta_serio_device = {
>  	.id		= PLATFORM_DEVID_NONE,
>  };
>  
> +static struct regulator_consumer_supply keybrd_pwr_consumers[] = {
> +	/*
> +	 * Initialize supply .dev_name with NULL.  It will be replaced
> +	 * with serio dev_name() as soon as the serio device is registered.
> +	 */
> +	REGULATOR_SUPPLY("vcc", NULL),
> +};
> +
> +static struct regulator_init_data keybrd_pwr_initdata = {
> +	.constraints		= {
> +		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(keybrd_pwr_consumers),
> +	.consumer_supplies	= keybrd_pwr_consumers,
> +};
> +
> +static struct fixed_voltage_config keybrd_pwr_config = {
> +	.supply_name		= "keybrd_pwr",
> +	.microvolts		= 5000000,
> +	.gpio			= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
> +	.enable_high		= 1,
> +	.init_data		= &keybrd_pwr_initdata,
> +};
> +
> +static struct platform_device keybrd_pwr_device = {
> +	.name	= "reg-fixed-voltage",
> +	.id	= PLATFORM_DEVID_AUTO,
> +	.dev	= {
> +		.platform_data	= &keybrd_pwr_config,
> +	},
> +};
> +
> +static struct gpiod_lookup_table keybrd_pwr_gpio_table = {
> +	.table = {
> +		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR, NULL,
> +			    GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +
>  static struct platform_device *ams_delta_devices[] __initdata = {
>  	&latch1_gpio_device,
>  	&latch2_gpio_device,
> @@ -526,6 +566,7 @@ static struct platform_device *late_devices[] __initdata = {
>  
>  static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
>  	&ams_delta_audio_gpio_table,
> +	&keybrd_pwr_gpio_table,
>  };
>  
>  static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
> @@ -566,12 +607,30 @@ static void __init ams_delta_init(void)
>  	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
>  
>  	/*
> -	 * As soon as devices have been registered, assign their dev_names
> -	 * to respective GPIO lookup tables before they are added.
> +	 * As soon as regulator consumers have been registered, assign their
> +	 * dev_names to consumer supply entries of respective regulators.
> +	 */
> +	keybrd_pwr_consumers[0].dev_name =
> +			dev_name(&ams_delta_serio_device.dev);
> +
> +	/*
> +	 * Once consumer supply entries are populated with dev_names,
> +	 * register regulator devices.  At this stage only the keyboard
> +	 * power regulator has its consumer supply table fully populated.
> +	 */
> +	platform_device_register(&keybrd_pwr_device);
> +
> +	/*
> +	 * As soon as GPIO consumers have been registered, assign
> +	 * their dev_names to respective GPIO lookup tables.
>  	 */
>  	ams_delta_audio_gpio_table.dev_id =
>  			dev_name(&ams_delta_audio_device.dev);
> +	keybrd_pwr_gpio_table.dev_id = dev_name(&keybrd_pwr_device.dev);
>  
> +	/*
> +	 * Once GPIO lookup tables are populated with dev_names, register them.
> +	 */
>  	gpiod_add_lookup_tables(ams_delta_gpio_tables,
>  				ARRAY_SIZE(ams_delta_gpio_tables));
>  
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index 551a4fa73fe4..d48beab1d00d 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -23,6 +23,7 @@
>  #include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/serio.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -39,6 +40,7 @@ MODULE_LICENSE("GPL");
>  
>  struct ams_delta_serio {
>  	struct serio *serio;
> +	struct regulator *vcc;
>  };
>  
>  static int check_data(struct serio *serio, int data)
> @@ -94,16 +96,18 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
>  
>  static int ams_delta_serio_open(struct serio *serio)
>  {
> -	/* enable keyboard */
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 1);
> +	struct ams_delta_serio *priv = serio->port_data;
>  
> -	return 0;
> +	/* enable keyboard */
> +	return regulator_enable(priv->vcc);
>  }
>  
>  static void ams_delta_serio_close(struct serio *serio)
>  {
> +	struct ams_delta_serio *priv = serio->port_data;
> +
>  	/* disable keyboard */
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 0);
> +	regulator_disable(priv->vcc);
>  }
>  
>  static const struct gpio ams_delta_gpios[] __initconst_or_module = {
> @@ -117,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
>  		.flags	= GPIOF_DIR_IN,
>  		.label	= "serio-clock",
>  	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
> -		.flags	= GPIOF_OUT_INIT_LOW,
> -		.label	= "serio-power",
> -	},
>  	{
>  		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
>  		.flags	= GPIOF_OUT_INIT_LOW,
> @@ -146,6 +145,16 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  		goto serio;
>  	}
>  
> +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(priv->vcc)) {
> +		err = PTR_ERR(priv->vcc);
> +		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
> +		/* Fail softly if the regulator is not available yet */
> +		if (err == -ENODEV)
> +			err = -EPROBE_DEFER;

Hmm, if regulator is not ready yet, devm_regulator_get() should be
returning -EPROBE_DEFER already, we should not have to convert -ENODEV
to -EPROBE_DEFER...

Is it because we have_full_constraints() returns false? You might need
to add call to regulator_has_full_constraints() to your board file.

> +		goto gpio;
> +	}
> +
>  	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
>  			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
>  			DRIVER_NAME, priv);
> -- 
> 2.16.1
> 

Thanks.

-- 
Dmitry
