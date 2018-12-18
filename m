Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B687C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4002184D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545132945;
	bh=SX2nxxtVd7991BP1v8rwJJJjYA4xC67IoJAGiaa7Ss8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N8FBoBNth++afwRtmXqQRfOBRwndf/OU7ahpxcdW/MZVlVFdKNi4aKi8EjJJMEdUI
	 59yLmGNCd26LP/H2F+vW69On4CR2JL+YjInMTVq7gQHs6D2rxk8i97WCzBa9c/686o
	 uiizxPzDA9cm1p5wNVmorm2Gli6VJvDyo4MACLUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLRLfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:35:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43740 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeLRLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:35:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so2755119lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XH9ZRCaOeLdsJZWLJEJTaoMn2AczNCZW+Di9zNqp7Qk=;
        b=lnXffSePzcRgG9S45pIT0jZA6XttRkE1O1gOvLX4V8dRvLfk6W+g/VpPX7BLeabvKd
         bZVITqxtZaRX7N0crizovVslCUmo+WTMF6x5HOxH7t/x96m4HAMWJ2C4nwFU6cTPbgiX
         Id38uuIQwSY1cGaGb7/pMFwKouEAhf6AQfYvfquLVQj2Frk/m4oZPaOuORx95jSaOcs+
         J/Q40+kj/ndyfNS9F0gaxgA9/XseKgngOnzAh286nja+Ve9057XHUGMKXW9yjdBa5B9G
         2d1omBMVc38lHqHOTfvTf/EJ8Os72MHS83lV4MEUV8j1J6XW9XT/fJYd5hO/xD6FYZ7p
         k6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XH9ZRCaOeLdsJZWLJEJTaoMn2AczNCZW+Di9zNqp7Qk=;
        b=Iq69K/QTZxST88QzpXqbed2+D522yuA/df8LwGpfhjUqg8n+ulgY+mkcSEij54egzY
         +7EBQABqMs+KSS4gM7qM1Q68AqCzME6dreibXb3oh4emEzo/MqECLR8UetWdI6wsQTXh
         igtrsbWV/VRxZVNkg+2KogokRw8M/aden4LcAdODloj6gTVjfLdyCpODlrIhI79RysYK
         6ve0NiBzHrN681fap7ScPKPxxbp6Yegwj6WF5u1xUZFCFkGhrrdGjI0q2Emvh75xkOMA
         9HgyANr+IKRJ7Dc2pzdGby6h6GNUYQme3BQ0d9WPD6l2O/nz/VAsihXd9ODV5KegskDX
         thfg==
X-Gm-Message-State: AA+aEWaM/MNEEIQZzxUXafB4v1X48Y2oJXN/Ob9EE5j9KbX5K47io4v/
        2dX85V8D4sqeTdzgbsloOTc=
X-Google-Smtp-Source: AFSGD/WfJJMPBPXmVqOrfQE38lN+cW7efBKw8Nx3IXEjLN5UQNLV9IpddO6zrvfoyby4A2WrLgkGPg==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr9691256lju.116.1545132939990;
        Tue, 18 Dec 2018 03:35:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y9sm3168588lfe.75.2018.12.18.03.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:35:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gZDf2-0004x5-U1; Tue, 18 Dec 2018 12:35:41 +0100
Date:   Tue, 18 Dec 2018 12:35:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <20181218113540.GN20658@localhost>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
 <9ebe2c3909643701e5936da3778bf4fab3e53036.1542898267.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebe2c3909643701e5936da3778bf4fab3e53036.1542898267.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:38:18PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v2:
>  - Resolved compilation errors.
> ---
>  drivers/staging/greybus/arche-apb-ctrl.c | 159 +++++++++--------------
>  1 file changed, 65 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
> index be5ffed90bcf..e887f6aee20b 100644
> --- a/drivers/staging/greybus/arche-apb-ctrl.c
> +++ b/drivers/staging/greybus/arche-apb-ctrl.c
> @@ -8,9 +8,8 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_irq.h>
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -24,12 +23,12 @@ static void apb_bootret_deassert(struct device *dev);
>  
>  struct arche_apb_ctrl_drvdata {
>  	/* Control GPIO signals to and from AP <=> AP Bridges */
> -	int resetn_gpio;
> -	int boot_ret_gpio;
> -	int pwroff_gpio;
> -	int wake_in_gpio;
> -	int wake_out_gpio;
> -	int pwrdn_gpio;
> +	struct gpio_desc *resetn;
> +	struct gpio_desc *boot_ret;
> +	struct gpio_desc *pwroff;
> +	struct gpio_desc *wake_in;
> +	struct gpio_desc *wake_out;
> +	struct gpio_desc *pwrdn;
>  
>  	enum arche_platform_state state;
>  	bool init_disabled;
> @@ -37,28 +36,28 @@ struct arche_apb_ctrl_drvdata {
>  	struct regulator *vcore;
>  	struct regulator *vio;
>  
> -	int clk_en_gpio;
> +	struct gpio_desc *clk_en;
>  	struct clk *clk;
>  
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *pin_default;
>  
>  	/* V2: SPI Bus control  */
> -	int spi_en_gpio;
> +	struct gpio_desc *spi_en;
>  	bool spi_en_polarity_high;
>  };
>  
>  /*
>   * Note that these low level api's are active high
>   */
> -static inline void deassert_reset(unsigned int gpio)
> +static inline void deassert_reset(struct gpio_desc *gpio)
>  {
> -	gpio_set_value(gpio, 1);
> +	gpiod_set_value(gpio, 1);
>  }
>  
> -static inline void assert_reset(unsigned int gpio)
> +static inline void assert_reset(struct gpio_desc *gpio)
>  {
> -	gpio_set_value(gpio, 0);
> +	gpiod_set_value(gpio, 0);
>  }

As the comment above deassert_reset() suggests, this change will
actually change the semantics of these calls by taking any gpio flags
into account (e.g. ACTIVE_LOW which will invert the signals).

Perhaps you should just use gpiod_set_raw_value() for now, and this can
be addressed later. Alternatively, drop the comment and invert the
polarity here and any users will need to update their device trees.

Either way, mention this in the commit message.

>  /*
> @@ -75,11 +74,11 @@ static int coldboot_seq(struct platform_device *pdev)
>  		return 0;
>  
>  	/* Hold APB in reset state */
> -	assert_reset(apb->resetn_gpio);
> +	assert_reset(apb->resetn);
>  
>  	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
> -	    gpio_is_valid(apb->spi_en_gpio))
> -		devm_gpio_free(dev, apb->spi_en_gpio);
> +	    apb->spi_en)

No need to break the line any more.

> +		devm_gpiod_put(dev, apb->spi_en);
>  
>  	/* Enable power to APB */
>  	if (!IS_ERR(apb->vcore)) {
> @@ -101,13 +100,13 @@ static int coldboot_seq(struct platform_device *pdev)
>  	apb_bootret_deassert(dev);
>  
>  	/* On DB3 clock was not mandatory */
> -	if (gpio_is_valid(apb->clk_en_gpio))
> -		gpio_set_value(apb->clk_en_gpio, 1);
> +	if (apb->clk_en)
> +		gpiod_set_value(apb->clk_en, 1);
>  
>  	usleep_range(100, 200);
>  
>  	/* deassert reset to APB : Active-low signal */
> -	deassert_reset(apb->resetn_gpio);
> +	deassert_reset(apb->resetn);
>  
>  	apb->state = ARCHE_PLATFORM_STATE_ACTIVE;
>  
> @@ -119,6 +118,7 @@ static int fw_flashing_seq(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct arche_apb_ctrl_drvdata *apb = platform_get_drvdata(pdev);
>  	int ret;
> +	unsigned long flags;
>  
>  	if (apb->init_disabled ||
>  	    apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING)
> @@ -136,25 +136,20 @@ static int fw_flashing_seq(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (gpio_is_valid(apb->spi_en_gpio)) {

spi_en_gpio is currently optional, so cannot just drop the check.

> -		unsigned long flags;
> +	if (apb->spi_en_polarity_high)
> +		flags = GPIOD_OUT_HIGH;
> +	else
> +		flags = GPIOD_OUT_LOW;

This should probably also be converted to honouring the gpio flags, but
perhaps better to do in a later patch.

>  
> -		if (apb->spi_en_polarity_high)
> -			flags = GPIOF_OUT_INIT_HIGH;
> -		else
> -			flags = GPIOF_OUT_INIT_LOW;
> -
> -		ret = devm_gpio_request_one(dev, apb->spi_en_gpio,
> -					    flags, "apb_spi_en");
> -		if (ret) {
> -			dev_err(dev, "Failed requesting SPI bus en gpio %d\n",
> -				apb->spi_en_gpio);
> -			return ret;
> -		}
> +	apb->spi_en = devm_gpiod_get(dev, "gb,spi-en-gpio", flags);
> +	if (IS_ERR(apb->spi_en)) {
> +		ret = PTR_ERR(apb->spi_en);
> +		dev_err(dev, "Failed requesting SPI bus en GPIO: %d\n", ret);
> +		return ret;
>  	}
>  
>  	/* for flashing device should be in reset state */
> -	assert_reset(apb->resetn_gpio);
> +	assert_reset(apb->resetn);
>  	apb->state = ARCHE_PLATFORM_STATE_FW_FLASHING;
>  
>  	return 0;
> @@ -177,8 +172,8 @@ static int standby_boot_seq(struct platform_device *pdev)
>  		return 0;
>  
>  	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
> -	    gpio_is_valid(apb->spi_en_gpio))
> -		devm_gpio_free(dev, apb->spi_en_gpio);
> +	    apb->spi_en)

No line break. Check this throughout.

> +		devm_gpiod_put(dev, apb->spi_en);
>  
>  	/*
>  	 * As per WDM spec, do nothing

> @@ -404,12 +379,8 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
>  	}
>  
>  	/* Only applicable for platform >= V2 */
> -	apb->spi_en_gpio = of_get_named_gpio(np, "spi-en-gpio", 0);
> -	if (apb->spi_en_gpio >= 0) {
> -		if (of_property_read_bool(pdev->dev.of_node,
> -					  "spi-en-active-high"))
> -			apb->spi_en_polarity_high = true;
> -	}
> +	if (of_property_read_bool(pdev->dev.of_node, "gb,spi-en-active-high"))
> +		apb->spi_en_polarity_high = true;

Guess it's fine to drop the spi_en check here though.

Johan
