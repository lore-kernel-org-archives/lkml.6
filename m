Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6456C223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5DG5OE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6456C223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbeKNERd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:17:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46417 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKNERd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:17:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id s9-v6so6447991pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iZ91iAhX6/NKpiI+j8xiDxJtb/EtX2Kk+HOvLq+lOU=;
        b=M5DG5OE8sRuwe4W015A/+BEzh1xR+xtQysSNpkwxrQHoCFkzfC2DnrlJh22RvJsiGk
         no2F1zSjnHnVGgq1DB5XDWHFThKAH4IKuzUXKiWs5MUyivxirAS6Qbrwp0kzD8YBC6Xf
         DSAPsKpqNOU9Ls7PVi/cSnqqcnbUa4H9ZnGSM0QTdwFQlWTKNmfoQ996AasuPVWVYT+q
         0DYv4dvS1A5q1w59u36Yb3tfbwKvZZ7UzyBgjHKqQFwHgh2cz+x9mEym4kQfjaLOZ7r3
         WC2/hxWcfe3bf2+rPFq1Dng4yyZe3pdawlSydsB3FyiGdma38+5Ch9Y7oOWRQjZDLx0Z
         nYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iZ91iAhX6/NKpiI+j8xiDxJtb/EtX2Kk+HOvLq+lOU=;
        b=IkDsuuv2VmaBWFIjdXwYDdsVJINDZzytqxWr0px2coc6CiCGLuTlo9YYF7XoB9Pt4e
         vXJseY9vUTjB/qpbRAcVgYej6WdlmIYVwd3F6EhDaf91x3Lk1DPevw+V1qr6+wWGKr0D
         oAsMrT72nzjmLTp1rJafaxZJbzO89PNq9ff9/oLZoNIt0My30QMbnmICSjdmx7R2l67y
         hlRblCi/HLYz5GETE6XhpoCKUs4PkTpT418qVYubh8hGvW27gQeaK6NDFJC3aNS5Gqh8
         YdZKBMZMKMtI412J2aDYnh8+I4B4R1aq177oB1AJmQXC6sH59L89LzH+4rqGGWuFuSRS
         ldwA==
X-Gm-Message-State: AGRZ1gK43O1aOj6VHQQ35Z3ePacEcrLojyMsxI8/Wa9Z9q6gU7hhXaaA
        Lj6ipO+CetkGXcyGlHZxb6k=
X-Google-Smtp-Source: AJdET5cVmNMFQNdXL8LHn5xRKf1v6K9CWVpxBfOikJLcMtu+0YRdfS+4TY1Qr0VFYead0QrgYsgr/A==
X-Received: by 2002:a62:4681:: with SMTP id o1-v6mr6286690pfi.172.1542133097093;
        Tue, 13 Nov 2018 10:18:17 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l26-v6sm36973261pfg.161.2018.11.13.10.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 10:18:16 -0800 (PST)
Date:   Tue, 13 Nov 2018 23:48:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: gpio: switch GPIO portions to use
 GPIOLIB_IRQCHIP
Message-ID: <20181113181805.GA32516@nishad>
References: <20181109074735.GA5998@nishad>
 <20181112151509.GH13311@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112151509.GH13311@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:15:09PM +0100, Johan Hovold wrote:
> On Fri, Nov 09, 2018 at 01:17:41PM +0530, Nishad Kamdar wrote:
> > Convert the GPIO driver to use the GPIO irqchip library
> > GPIOLIB_IRQCHIP instead of reimplementing the same.
> 
> Thanks for picking this up. Linus W took a stab at it a couple of years
> ago, but it was never completed. You may want to take a look at that
> thread:
> 
> 	https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org

Thanks for the reference.

> 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/greybus/Kconfig |   1 +
> >  drivers/staging/greybus/gpio.c  | 123 ++++++--------------------------
> >  2 files changed, 21 insertions(+), 103 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
> > index ab096bcef98c..b571e4e8060b 100644
> > --- a/drivers/staging/greybus/Kconfig
> > +++ b/drivers/staging/greybus/Kconfig
> > @@ -148,6 +148,7 @@ if GREYBUS_BRIDGED_PHY
> >  config GREYBUS_GPIO
> >  	tristate "Greybus GPIO Bridged PHY driver"
> >  	depends on GPIOLIB
> > +	select GPIOLIB_IRQCHIP
> >  	---help---
> >  	  Select this option if you have a device that follows the
> >  	  Greybus GPIO Bridged PHY Class specification.
> > diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
> > index b1d4698019a1..32c228bad33a 100644
> > --- a/drivers/staging/greybus/gpio.c
> > +++ b/drivers/staging/greybus/gpio.c
> > @@ -9,9 +9,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > -#include <linux/gpio.h>
> > -#include <linux/irq.h>
> 
> I think you should keep irq.h even if the gpio header currently provides
> it.
> 
> > -#include <linux/irqdomain.h>
> 
> Similarly for this one, if you still rely on it.
>

Ok i'll do that.

> > +#include <linux/gpio/driver.h>
> >  #include <linux/mutex.h>
> >  
> >  #include "greybus.h"
> > @@ -40,8 +38,6 @@ struct gb_gpio_controller {
> >  	struct gpio_chip	chip;
> >  	struct irq_chip		irqc;
> >  	struct irq_chip		*irqchip;
> 
> This should not be needed any more either.
>

Just to confirm, by thism you mean only 
struct irq_chip	*irqchip; right?

> > -	struct irq_domain	*irqdomain;
> > -	unsigned int		irq_base;
> >  	irq_flow_handler_t	irq_handler;
> >  	unsigned int		irq_default_type;
> 
> Neither should these two.
> 

Ok.

> >  	struct mutex		irq_lock;
> > @@ -365,6 +361,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
> >  {
> >  	struct gb_connection *connection = op->connection;
> >  	struct gb_gpio_controller *ggc = gb_connection_get_data(connection);
> > +	struct gpio_chip *gc = &ggc->chip;
> 
> Please name the pointer 'chip' as in the rest of the driver to avoid
> confusion with 'ggc'. But looks like you don't need it at all.
>

Yes.

> >  	struct device *dev = &ggc->gbphy_dev->dev;
> >  	struct gb_message *request;
> >  	struct gb_gpio_irq_event_request *event;
> > @@ -391,7 +388,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
> >  		return -EINVAL;
> >  	}
> >  
> > -	irq = irq_find_mapping(ggc->irqdomain, event->which);
> > +	irq = irq_find_mapping(gc->irq.domain, event->which);
> >  	if (!irq) {
> >  		dev_err(dev, "failed to find IRQ\n");
> >  		return -EINVAL;
> > @@ -506,68 +503,6 @@ static int gb_gpio_controller_setup(struct gb_gpio_controller *ggc)
> >  	return ret;
> >  }
> 
> > -/**
> > - * gb_gpio_irqchip_remove() - removes an irqchip added to a gb_gpio_controller
> > - * @ggc: the gb_gpio_controller to remove the irqchip from
> > - *
> > - * This is called only from gb_gpio_remove()
> > - */
> > -static void gb_gpio_irqchip_remove(struct gb_gpio_controller *ggc)
> > -{
> > -	unsigned int offset;
> > -
> > -	/* Remove all IRQ mappings and delete the domain */
> > -	if (ggc->irqdomain) {
> > -		for (offset = 0; offset < (ggc->line_max + 1); offset++)
> > -			irq_dispose_mapping(irq_find_mapping(ggc->irqdomain,
> > -							     offset));
> > -		irq_domain_remove(ggc->irqdomain);
> > -	}
> > -
> > -	if (ggc->irqchip)
> > -		ggc->irqchip = NULL;
> > -}
> > -
> >  /**
> >   * gb_gpio_irqchip_add() - adds an irqchip to a gpio chip
> >   * @chip: the gpio chip to add the irqchip to
> > @@ -595,8 +530,7 @@ static int gb_gpio_irqchip_add(struct gpio_chip *chip,
> >  			 unsigned int type)
> >  {
> >  	struct gb_gpio_controller *ggc;
> > -	unsigned int offset;
> > -	unsigned int irq_base;
> > +	unsigned int err;
> >  
> >  	if (!chip || !irqchip)
> >  		return -EINVAL;
> > @@ -606,35 +540,21 @@ static int gb_gpio_irqchip_add(struct gpio_chip *chip,
> >  	ggc->irqchip = irqchip;
> >  	ggc->irq_handler = handler;
> >  	ggc->irq_default_type = type;
> > -	ggc->irqdomain = irq_domain_add_simple(NULL,
> > -					ggc->line_max + 1, first_irq,
> > -					&gb_gpio_domain_ops, chip);
> > -	if (!ggc->irqdomain) {
> > -		ggc->irqchip = NULL;
> > -		return -EINVAL;
> > -	}
> >  
> > -	/*
> > -	 * Prepare the mapping since the irqchip shall be orthogonal to
> > -	 * any gpio calls. If the first_irq was zero, this is
> > -	 * necessary to allocate descriptors for all IRQs.
> > -	 */
> > -	for (offset = 0; offset < (ggc->line_max + 1); offset++) {
> > -		irq_base = irq_create_mapping(ggc->irqdomain, offset);
> > -		if (offset == 0)
> > -			ggc->irq_base = irq_base;
> > +	err = gpiochip_irqchip_add(chip,
> > +				   irqchip,
> > +				   first_irq,
> > +				   ggc->irq_handler,
> > +				   type
> 
> Don't break the line here.
> 

Ok.

> > +				   );
> > +	if (err) {
> > +		ggc->irqchip = NULL;
> > +		return err;
> >  	}
> >  
> >  	return 0;
> >  }
> 
> Drop this function as well and call gpiochip_irqchip_add() from probe().
>

Ok. I'll do that.

> > -static int gb_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
> > -{
> > -	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
> > -
> > -	return irq_find_mapping(ggc->irqdomain, offset);
> > -}
> > -
> >  static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
> >  			 const struct gbphy_device_id *id)
> >  {
> > @@ -693,7 +613,6 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
> >  	gpio->get = gb_gpio_get;
> >  	gpio->set = gb_gpio_set;
> >  	gpio->set_config = gb_gpio_set_config;
> > -	gpio->to_irq = gb_gpio_to_irq;
> >  	gpio->base = -1;		/* Allocate base dynamically */
> >  	gpio->ngpio = ggc->line_max + 1;
> >  	gpio->can_sleep = true;
> > @@ -702,24 +621,23 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
> >  	if (ret)
> >  		goto exit_line_free;
> >  
> > -	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
> > -				   handle_level_irq, IRQ_TYPE_NONE);
> > +	ret = gpiochip_add(gpio);
> >  	if (ret) {
> > -		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
> > +		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
> >  		goto exit_line_free;
> >  	}
> >  
> > -	ret = gpiochip_add(gpio);
> > +	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
> > +				  handle_level_irq, IRQ_TYPE_NONE);
> 
> As you may have noted, we had the registration order reversed here to
> handle a (theoretical) race, which may or may not only have been an
> issue for the old 3.10 vendor kernel this was developed against. I've
> forgotten the details, but see:
> 
> 	88f6ba61f25b ("greybus: gpio: create irqdomain before registering gpio controller")
> 
> It's possibly an issue also for mainline, but this is indeed the
> registration order all other drivers use (even if they tend not to be
> hotpluggable).
> 

Yes, I noted that while taking reference of some of the existing
drivers. Thanks for the explanation though.

> >  	if (ret) {
> > -		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
> > -		goto exit_gpio_irqchip_remove;
> > +		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
> > +		gpiochip_remove(gpio);
> 
> Please use an error label for this.
> 

Ok. I'll do that.

> > +		goto exit_line_free;
> >  	}
> >  
> >  	gbphy_runtime_put_autosuspend(gbphy_dev);
> >  	return 0;
> >  
> > -exit_gpio_irqchip_remove:
> > -	gb_gpio_irqchip_remove(ggc);
> >  exit_line_free:
> >  	kfree(ggc->lines);
> >  exit_connection_disable:
> 
> Thanks,
> Johan

Thanks a lot for the review comments.

Regards,
Nishad
