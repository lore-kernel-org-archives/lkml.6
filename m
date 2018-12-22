Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB97C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A831C219D6
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUroZrHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbeLVRa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:30:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38092 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733256AbeLVRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:30:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3925081plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUiUVAZX+o1L8tyb6nCCrphk9MHn36Ci/isp5wjlftk=;
        b=HUroZrHNSkRF9fGX9met09H2aZDNyOYtpWvGpGEAGB2/CHmAETJAPvVnDK8jHUnTBF
         uJ9H6NesPUzPsHhEDeSRIizUGxLkHwjeWvAIu+YhyhFQr7cv9N+ZipbQWUufPFufCp2/
         AD0s78S7G0pe5ftKHgQGsgmz0Tfh+jG9N0yVT0Lsz90H0Re0j9M9JIQZNL4w0Vm8j5fo
         3I8/AGE/eEw+CASV81KBeZRW1dyrG1CShJ43kqlOHjmuGn8jF9K+MzzzWlqEsD2iV8AM
         j2JmxKWsGHj0VkQNgU87I5vOLnfOlAz5IK+STdLweWfBGv/kEOVb0yeAK89k69CaQuhe
         VTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUiUVAZX+o1L8tyb6nCCrphk9MHn36Ci/isp5wjlftk=;
        b=m5M+74ILtsmSZ5UKCLNiZdi764VWrvQlE+IUvd11lnz+aFa81RRDwbIjKpA+cL9QEt
         GIkNeqHPZYsnXqJ+oDp5Jbqy0BSPlkK/H3e5Fv0eGcxMIQ4HOtwv4QlA11OvpQed2QP2
         IW/+nmwXheDeFQVoJKhb3nL1MrIENgpoUaFcas939F74hv/bF7yoyl7L3bV71wNq4Nny
         JRJAbtJbPNlAv6+TT+W8jKkoP4OHfq6T5Bn5n++YFUhwT0DYYOm9yndpuOW93Ajy8jvI
         SPmKABgO2fEfe8cxKJQpdTP2z4GyifDtcI8BPVd8oGsIDADkjwnESfAuNgpQuBqEkhKN
         oAxA==
X-Gm-Message-State: AJcUukeDLnnqePGNnvgS3Ti7puGz1TFj8dQ+OkR0YPGnHGUBj+VnV3++
        X71q/siTIutLKa1wv2b1BS0eGfFrXJg=
X-Google-Smtp-Source: ALg8bN7HE0IZ9EvXFhXp3JaXE4AS6L7DaHmXgGoYCzTGIwcMDTKB1CwfZzLCJ3rmaOFAcF15+3z+xg==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr6885799plf.28.1545489779976;
        Sat, 22 Dec 2018 06:42:59 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id p7sm52800993pfj.72.2018.12.22.06.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:42:59 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:12:52 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v3 3/3] staging: greybus: arche-platform: Switch to the
 gpio descriptor interface
Message-ID: <20181222144251.GC15439@nishad>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
 <2200db633d8e723b881ef355527afaef0d5ccf24.1542898267.git.nishadkamdar@gmail.com>
 <20181218115056.GO20658@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218115056.GO20658@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:50:56PM +0100, Johan Hovold wrote:
> On Thu, Nov 22, 2018 at 10:39:24PM +0530, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated
> > old non-descriptor interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >  - Move comment to the same line as to what it applies to.
> > ---
> >  drivers/staging/greybus/arche-platform.c | 119 ++++++++---------------
> >  1 file changed, 41 insertions(+), 78 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > index 4c36e88766e7..a5cea79d8e32 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -8,10 +8,9 @@
> >  
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> > @@ -45,14 +44,14 @@ enum svc_wakedetect_state {
> >  
> >  struct arche_platform_drvdata {
> >  	/* Control GPIO signals to and from AP <=> SVC */
> > -	int svc_reset_gpio;
> > +	struct gpio_desc *svc_reset;
> > +	struct gpio_desc *svc_sysboot;
> 
> Why move sysboot? The flag below is about reset (but should eventually
> go away).
> 
Ok, I'll restore its position.

> >  	bool is_reset_act_hi;
> > -	int svc_sysboot_gpio;
> > -	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
> > +	struct gpio_desc *wake_detect; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
> >  
> >  	enum arche_platform_state state;
> >  
> > -	int svc_refclk_req;
> > +	struct gpio_desc *svc_refclk_req;
> >  	struct clk *svc_ref_clk;
> >  
> >  	struct pinctrl *pinctrl;
> > @@ -85,9 +84,9 @@ static void arche_platform_set_wake_detect_state(
> >  	arche_pdata->wake_detect_state = state;
> >  }
> >  
> > -static inline void svc_reset_onoff(unsigned int gpio, bool onoff)
> > +static inline void svc_reset_onoff(struct gpio_desc *gpio, bool onoff)
> >  {
> > -	gpio_set_value(gpio, onoff);
> > +	gpiod_set_value(gpio, onoff);
> >  }
> >  
> >  static int apb_cold_boot(struct device *dev, void *data)
> > @@ -116,7 +115,6 @@ static int apb_poweroff(struct device *dev, void *data)
> >  static void arche_platform_wd_irq_en(struct arche_platform_drvdata *arche_pdata)
> >  {
> >  	/* Enable interrupt here, to read event back from SVC */
> > -	gpio_direction_input(arche_pdata->wake_detect_gpio);
> >  	enable_irq(arche_pdata->wake_detect_irq);
> >  }
> >  
> > @@ -160,7 +158,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> >  
> >  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> >  
> > -	if (gpio_get_value(arche_pdata->wake_detect_gpio)) {
> > +	if (gpiod_get_value(arche_pdata->wake_detect)) {
> >  		/* wake/detect rising */
> >  
> >  		/*
> > @@ -224,10 +222,10 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
> >  
> >  	dev_info(arche_pdata->dev, "Booting from cold boot state\n");
> >  
> > -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> > +	svc_reset_onoff(arche_pdata->svc_reset,
> 
> No need to break line here.
> 
Ok.

> >  			arche_pdata->is_reset_act_hi);
> >  
> > -	gpio_set_value(arche_pdata->svc_sysboot_gpio, 0);
> > +	gpiod_set_value(arche_pdata->svc_sysboot, 0);
> >  	usleep_range(100, 200);
> >  
> >  	ret = clk_prepare_enable(arche_pdata->svc_ref_clk);
> > @@ -238,7 +236,7 @@ arche_platform_coldboot_seq(struct arche_platform_drvdata *arche_pdata)
> >  	}
> >  
> >  	/* bring SVC out of reset */
> > -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> > +	svc_reset_onoff(arche_pdata->svc_reset,
> 
> Same here. Please check throughout.
> 
Yes.

> >  			!arche_pdata->is_reset_act_hi);
> >  
> >  	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_ACTIVE);
> > @@ -259,10 +257,10 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
> >  
> >  	dev_info(arche_pdata->dev, "Switching to FW flashing state\n");
> >  
> > -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> > +	svc_reset_onoff(arche_pdata->svc_reset,
> >  			arche_pdata->is_reset_act_hi);
> >  
> > -	gpio_set_value(arche_pdata->svc_sysboot_gpio, 1);
> > +	gpiod_set_value(arche_pdata->svc_sysboot, 1);
> >  
> >  	usleep_range(100, 200);
> >  
> > @@ -273,7 +271,7 @@ arche_platform_fw_flashing_seq(struct arche_platform_drvdata *arche_pdata)
> >  		return ret;
> >  	}
> >  
> > -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> > +	svc_reset_onoff(arche_pdata->svc_reset,
> >  			!arche_pdata->is_reset_act_hi);
> >  
> >  	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_FW_FLASHING);
> > @@ -305,7 +303,7 @@ arche_platform_poweroff_seq(struct arche_platform_drvdata *arche_pdata)
> >  	clk_disable_unprepare(arche_pdata->svc_ref_clk);
> >  
> >  	/* As part of exit, put APB back in reset state */
> > -	svc_reset_onoff(arche_pdata->svc_reset_gpio,
> > +	svc_reset_onoff(arche_pdata->svc_reset,
> >  			arche_pdata->is_reset_act_hi);
> >  
> >  	arche_platform_set_state(arche_pdata, ARCHE_PLATFORM_STATE_OFF);
> > @@ -435,6 +433,7 @@ static int arche_platform_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int ret;
> > +	unsigned int flags;
> >  
> >  	arche_pdata = devm_kzalloc(&pdev->dev, sizeof(*arche_pdata),
> >  				   GFP_KERNEL);
> > @@ -444,61 +443,33 @@ static int arche_platform_probe(struct platform_device *pdev)
> >  	/* setup svc reset gpio */
> >  	arche_pdata->is_reset_act_hi = of_property_read_bool(np,
> >  							     "svc,reset-active-high");
> 
> This should also go away eventually in favour of gpio flags in
> devicetree. Fine to keep for now, though.
>
Ok.

> > -	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
> > -							"svc,reset-gpio",
> > -							0);
> > -	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
> > -		dev_err(dev, "failed to get reset-gpio\n");
> > -		return arche_pdata->svc_reset_gpio;
> > -	}
> > -	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
> > -	if (ret) {
> > -		dev_err(dev, "failed to request svc-reset gpio:%d\n", ret);
> > -		return ret;
> > -	}
> > -	ret = gpio_direction_output(arche_pdata->svc_reset_gpio,
> > -				    arche_pdata->is_reset_act_hi);
> > -	if (ret) {
> > -		dev_err(dev, "failed to set svc-reset gpio dir:%d\n", ret);
> > +	if (arche_pdata->is_reset_act_hi)
> > +		flags = GPIOD_OUT_HIGH;
> > +	else
> > +		flags = GPIOD_OUT_LOW;
> > +
> > +	arche_pdata->svc_reset = devm_gpiod_get(dev, "svc,reset-gpio", flags);
> > +	if (IS_ERR(arche_pdata->svc_reset)) {
> > +		ret = PTR_ERR(arche_pdata->svc_reset);
> > +		dev_err(dev, "failed to request svc-reset GPIO:%d\n", ret);
> >  		return ret;
> >  	}
> 
> Thanks,
> Johan

Thanks for the review.

Regards,
Nishad
