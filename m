Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6836E21A7E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iao3fUG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392716AbeLVRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:41:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392702AbeLVRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:41:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so3912852ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VuBSRvJnqiDEMW+Z1CQCS4e955HGskApAplyOTSUIJU=;
        b=iao3fUG3pWDhyZn3xwjscFVMF3DVZvxZBB64sGcPP6C35N6uhqrZg8/kvsTTubu3em
         2YQz0PNW1qOezEvwohl0FmBV1UEL4SNvipyIbFkObddcq2CkgBy6+5AKACBHB9v4qmFu
         g8VPUVqz30x5iIE6aS1fTxqbVE7v2sNFU3l5NKOgofHXEgotyR298c0UR5fHokEo8w5h
         akDsv6z6QHqhZy6yz7AmJmRMTnyhHtpSupqgxCbNhbeATmRGDGj+fS+PoQo79sANDbJ7
         mhvJzhwEKu+kVvFyDZXzLoflUPrRGo29NSRHgweG3evqPOvp4sbkFnRbeuYND2MF8ACO
         LnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuBSRvJnqiDEMW+Z1CQCS4e955HGskApAplyOTSUIJU=;
        b=DQvEbqz4N74oNVtdDomzlRwNdes1qO+Th3MMAmbQnz9zal/4pgqHxZ6hhZlFjHr2+5
         +t7lhjn1LPHWiuhL74FsvpBYF27H+uQ7EBRRL5GBC4f8NUDOgn9H/SB9xrr92pM6UMon
         EQMXSVi77cMXhcIHDDkGm1guB+qDM9Gb4SFg1Dy2rFX58hxyZWKbPOqzL6Uq4vCrjtFM
         aF9LYYR3UT7o6Ytl40/dgfOwuLxYR9/GupW5bPbSdrEvi41ia9mL6r99/LECCeVhU9S8
         d3U+1P2ju6OtS1VWUiYEUd5AlVBin0OZkxnP1fpH4XS8WXQuFgE99+QJ7rmIr56LyA56
         f4gQ==
X-Gm-Message-State: AJcUukfBbtghboRP3jpOEW8YYSeW7RZ5JIdIau+pK9g02oUlOhGg7ecq
        en1ciYgax0xM7nEK9BAiu3/Q8KOwIL0=
X-Google-Smtp-Source: ALg8bN6bBvLSVgjp1Djh6K7n0S49yjZXGPk+GeDNmbaAIE09wGuDHWMOm5j0Y0S8Oa2RzJVt61Wp3g==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr6521734plq.95.1545489687275;
        Sat, 22 Dec 2018 06:41:27 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id q187sm46842815pfq.128.2018.12.22.06.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:41:26 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:11:19 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v3 2/3] staging: greybus: arche-apb-ctrl.c: Switch to the
 gpio descriptor interface
Message-ID: <20181222144118.GB15439@nishad>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
 <9ebe2c3909643701e5936da3778bf4fab3e53036.1542898267.git.nishadkamdar@gmail.com>
 <20181218113540.GN20658@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218113540.GN20658@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:35:40PM +0100, Johan Hovold wrote:
> On Thu, Nov 22, 2018 at 10:38:18PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >  - Resolved compilation errors.
> > ---
> >  drivers/staging/greybus/arche-apb-ctrl.c | 159 +++++++++--------------
> >  1 file changed, 65 insertions(+), 94 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
> > index be5ffed90bcf..e887f6aee20b 100644
> > --- a/drivers/staging/greybus/arche-apb-ctrl.c
> > +++ b/drivers/staging/greybus/arche-apb-ctrl.c
> > @@ -8,9 +8,8 @@
> >  
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/module.h>
> >  #include <linux/pinctrl/consumer.h>
> > @@ -24,12 +23,12 @@ static void apb_bootret_deassert(struct device *dev);
> >  
> >  struct arche_apb_ctrl_drvdata {
> >  	/* Control GPIO signals to and from AP <=> AP Bridges */
> > -	int resetn_gpio;
> > -	int boot_ret_gpio;
> > -	int pwroff_gpio;
> > -	int wake_in_gpio;
> > -	int wake_out_gpio;
> > -	int pwrdn_gpio;
> > +	struct gpio_desc *resetn;
> > +	struct gpio_desc *boot_ret;
> > +	struct gpio_desc *pwroff;
> > +	struct gpio_desc *wake_in;
> > +	struct gpio_desc *wake_out;
> > +	struct gpio_desc *pwrdn;
> >  
> >  	enum arche_platform_state state;
> >  	bool init_disabled;
> > @@ -37,28 +36,28 @@ struct arche_apb_ctrl_drvdata {
> >  	struct regulator *vcore;
> >  	struct regulator *vio;
> >  
> > -	int clk_en_gpio;
> > +	struct gpio_desc *clk_en;
> >  	struct clk *clk;
> >  
> >  	struct pinctrl *pinctrl;
> >  	struct pinctrl_state *pin_default;
> >  
> >  	/* V2: SPI Bus control  */
> > -	int spi_en_gpio;
> > +	struct gpio_desc *spi_en;
> >  	bool spi_en_polarity_high;
> >  };
> >  
> >  /*
> >   * Note that these low level api's are active high
> >   */
> > -static inline void deassert_reset(unsigned int gpio)
> > +static inline void deassert_reset(struct gpio_desc *gpio)
> >  {
> > -	gpio_set_value(gpio, 1);
> > +	gpiod_set_value(gpio, 1);
> >  }
> >  
> > -static inline void assert_reset(unsigned int gpio)
> > +static inline void assert_reset(struct gpio_desc *gpio)
> >  {
> > -	gpio_set_value(gpio, 0);
> > +	gpiod_set_value(gpio, 0);
> >  }
> 
> As the comment above deassert_reset() suggests, this change will
> actually change the semantics of these calls by taking any gpio flags
> into account (e.g. ACTIVE_LOW which will invert the signals).
> 
> Perhaps you should just use gpiod_set_raw_value() for now, and this can
> be addressed later. Alternatively, drop the comment and invert the
> polarity here and any users will need to update their device trees.
> 
> Either way, mention this in the commit message.
> 
Ok, I'll use the gpiod_set_raw_value().

> >  /*
> > @@ -75,11 +74,11 @@ static int coldboot_seq(struct platform_device *pdev)
> >  		return 0;
> >  
> >  	/* Hold APB in reset state */
> > -	assert_reset(apb->resetn_gpio);
> > +	assert_reset(apb->resetn);
> >  
> >  	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
> > -	    gpio_is_valid(apb->spi_en_gpio))
> > -		devm_gpio_free(dev, apb->spi_en_gpio);
> > +	    apb->spi_en)
> 
> No need to break the line any more.
> 
Ok.

> > +		devm_gpiod_put(dev, apb->spi_en);
> >  
> >  	/* Enable power to APB */
> >  	if (!IS_ERR(apb->vcore)) {
> > @@ -101,13 +100,13 @@ static int coldboot_seq(struct platform_device *pdev)
> >  	apb_bootret_deassert(dev);
> >  
> >  	/* On DB3 clock was not mandatory */
> > -	if (gpio_is_valid(apb->clk_en_gpio))
> > -		gpio_set_value(apb->clk_en_gpio, 1);
> > +	if (apb->clk_en)
> > +		gpiod_set_value(apb->clk_en, 1);
> >  
> >  	usleep_range(100, 200);
> >  
> >  	/* deassert reset to APB : Active-low signal */
> > -	deassert_reset(apb->resetn_gpio);
> > +	deassert_reset(apb->resetn);
> >  
> >  	apb->state = ARCHE_PLATFORM_STATE_ACTIVE;
> >  
> > @@ -119,6 +118,7 @@ static int fw_flashing_seq(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct arche_apb_ctrl_drvdata *apb = platform_get_drvdata(pdev);
> >  	int ret;
> > +	unsigned long flags;
> >  
> >  	if (apb->init_disabled ||
> >  	    apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING)
> > @@ -136,25 +136,20 @@ static int fw_flashing_seq(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	if (gpio_is_valid(apb->spi_en_gpio)) {
> 
> spi_en_gpio is currently optional, so cannot just drop the check.
>
Ok, I'll restore it.

> > -		unsigned long flags;
> > +	if (apb->spi_en_polarity_high)
> > +		flags = GPIOD_OUT_HIGH;
> > +	else
> > +		flags = GPIOD_OUT_LOW;
> 
> This should probably also be converted to honouring the gpio flags, but
> perhaps better to do in a later patch.
> 
Ok.

> >  
> > -		if (apb->spi_en_polarity_high)
> > -			flags = GPIOF_OUT_INIT_HIGH;
> > -		else
> > -			flags = GPIOF_OUT_INIT_LOW;
> > -
> > -		ret = devm_gpio_request_one(dev, apb->spi_en_gpio,
> > -					    flags, "apb_spi_en");
> > -		if (ret) {
> > -			dev_err(dev, "Failed requesting SPI bus en gpio %d\n",
> > -				apb->spi_en_gpio);
> > -			return ret;
> > -		}
> > +	apb->spi_en = devm_gpiod_get(dev, "gb,spi-en-gpio", flags);
> > +	if (IS_ERR(apb->spi_en)) {
> > +		ret = PTR_ERR(apb->spi_en);
> > +		dev_err(dev, "Failed requesting SPI bus en GPIO: %d\n", ret);
> > +		return ret;
> >  	}
> >  
> >  	/* for flashing device should be in reset state */
> > -	assert_reset(apb->resetn_gpio);
> > +	assert_reset(apb->resetn);
> >  	apb->state = ARCHE_PLATFORM_STATE_FW_FLASHING;
> >  
> >  	return 0;
> > @@ -177,8 +172,8 @@ static int standby_boot_seq(struct platform_device *pdev)
> >  		return 0;
> >  
> >  	if (apb->state == ARCHE_PLATFORM_STATE_FW_FLASHING &&
> > -	    gpio_is_valid(apb->spi_en_gpio))
> > -		devm_gpio_free(dev, apb->spi_en_gpio);
> > +	    apb->spi_en)
> 
> No line break. Check this throughout.
>
Yes.

> > +		devm_gpiod_put(dev, apb->spi_en);
> >  
> >  	/*
> >  	 * As per WDM spec, do nothing
> 
> > @@ -404,12 +379,8 @@ static int apb_ctrl_get_devtree_data(struct platform_device *pdev,
> >  	}
> >  
> >  	/* Only applicable for platform >= V2 */
> > -	apb->spi_en_gpio = of_get_named_gpio(np, "spi-en-gpio", 0);
> > -	if (apb->spi_en_gpio >= 0) {
> > -		if (of_property_read_bool(pdev->dev.of_node,
> > -					  "spi-en-active-high"))
> > -			apb->spi_en_polarity_high = true;
> > -	}
> > +	if (of_property_read_bool(pdev->dev.of_node, "gb,spi-en-active-high"))
> > +		apb->spi_en_polarity_high = true;
> 
> Guess it's fine to drop the spi_en check here though.
>
Ok.
Thanks for the review.
regards,
Nishad

> Johan
