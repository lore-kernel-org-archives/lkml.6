Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E967BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA8221974
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKTb6uph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392427AbeLVRWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:22:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33974 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391348AbeLVRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:22:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so4066545pfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IoP9BZUUkX40ga4hEgLLURPEq+vTNeu97J4sJh8y7kY=;
        b=dKTb6uphuQC8KSPX6Ew7qCLEW73g6ftbMNcgv6piP0YVwX1t79CbJaH9cSI2fqQhsj
         gOULzzHGLgPIDH+0xB03aEe6/NJ2N40iSMoUCJ1XOrh/9KpbTZridhwlAxOtYgdnc9GW
         Je8pH+7/WBy4LU6L9Prr5a5ULdU/ZpSHOEpJyRYpsXth4VaQsHR3rwAMFs2z0/+ZAkOh
         gJItJytZoSas9atwaGcbHmSecUc7qaMNfr1zxnp0agUG5vslAZ0qYc+6qemrqMma7xCS
         nEA701Pz6OYg5sAporr8V3ggSEgmIWUZe/cHxjoxv+qO9BNEwYVFWVcIhQ9ZJcwF4ryM
         LlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IoP9BZUUkX40ga4hEgLLURPEq+vTNeu97J4sJh8y7kY=;
        b=baxnOJvwwfNVwkBXsYROaFuEmNgfA7P7BzUxXp/R+V/AlSxt+PDb1Jd4BKPbFzABSb
         80/Zldi8ajlpCCAx3+b+EcLFJDASu2fsdAGm9IdEFeoLErkFH+M+CviYqVFExnW+r6xP
         9BRNY9vEDAElEIE5G85Fd/QLs58RSKRcvbgASfOUiB/Qzyh49huiP84wDFQFB3JjBVRD
         CZ0Zt+IKTNnvqOdH9YthuAXZORqYEAarXeDsy1Fj3KwEXTpJrRCDpgqTf2OSwjbTMlEQ
         7BcH9fCBplROd9gpzOSjet5bhJD+RaV80a4OSOp6Hf7Xf5j8figf3yERHV1iIQbH7SO6
         JEPQ==
X-Gm-Message-State: AJcUukeXscT7cn0kNYY47kOsME84tuFYe2vBcXR4novJH2Et2JL8HdrH
        Wr2KYIq7XZixzxjS+WWG6HRl0tQtjtM=
X-Google-Smtp-Source: ALg8bN43biplRxGOdRtxEEPDK2ijYoJIrlQtZFX6rZ7tYazbOBXBZG7euXeaLnPNhesxb88+e7fi7Q==
X-Received: by 2002:a65:584e:: with SMTP id s14mr6360864pgr.142.1545489564373;
        Sat, 22 Dec 2018 06:39:24 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id 202sm49692361pfy.87.2018.12.22.06.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:39:23 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:09:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v3 1/3] staging: greybus: gpio: switch GPIO portions to
 use GPIOLIB_IRQCHIP
Message-ID: <20181222143914.GA15439@nishad>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
 <e12d2f21115c71820d4d68168181e5ebe4340f0f.1542898267.git.nishadkamdar@gmail.com>
 <20181218111034.GM20658@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218111034.GM20658@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:10:34PM +0100, Johan Hovold wrote:
> On Thu, Nov 22, 2018 at 10:37:16PM +0530, Nishad Kamdar wrote:
> > Convert the GPIO driver to use the GPIO irqchip library
> > GPIOLIB_IRQCHIP instead of reimplementing the same.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >  - Retained irq.h and irqdomain.h headers.
> >  - Dropped function gb_gpio_irqchip_add() and
> >    called gpiochip_irqchip_add() from probe().
> >  - Referred https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org.
> 
> Thanks for the update, and sorry about the late review. This looks
> mostly good now, except for a couple minor things pointed out below.
> 
> You also included the conversion to gpiochip_get_data() (as Linus also
> did in his patch) although that's really a separate change and should go
> in its own patch. Please break that bit out in a follow-up patch.
> 
> Also note that someone did a bunch random white space changes to this
> file in the staging tree, so it will not apply cleanly any more.
> 
> > ---
> >  drivers/staging/greybus/Kconfig |   1 +
> >  drivers/staging/greybus/gpio.c  | 184 ++++----------------------------
> >  2 files changed, 24 insertions(+), 161 deletions(-)
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
> > index b1d4698019a1..2ec54744171d 100644
> > --- a/drivers/staging/greybus/gpio.c
> > +++ b/drivers/staging/greybus/gpio.c
> > @@ -9,9 +9,9 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > -#include <linux/gpio.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/mutex.h>
> >  
> >  #include "greybus.h"
> > @@ -39,15 +39,8 @@ struct gb_gpio_controller {
> >  
> >  	struct gpio_chip	chip;
> >  	struct irq_chip		irqc;
> 
> Turns out struct gpio_chip will have an irqchip whenever
> CONFIG_GPIOLIB_IRQCHIP is selected so you can drop this one too.
> 
Ok, I'll do that.
> > -	struct irq_chip		*irqchip;
> > -	struct irq_domain	*irqdomain;
> > -	unsigned int		irq_base;
> > -	irq_flow_handler_t	irq_handler;
> > -	unsigned int		irq_default_type;
> >  	struct mutex		irq_lock;
> >  };
> > -#define gpio_chip_to_gb_gpio_controller(chip) \
> > -	container_of(chip, struct gb_gpio_controller, chip)
> >  #define irq_data_to_gpio_chip(d) (d->domain->host_data)
> >  
> >  static int gb_gpio_line_count_operation(struct gb_gpio_controller *ggc)
> > @@ -276,7 +269,7 @@ static void _gb_gpio_irq_set_type(struct gb_gpio_controller *ggc,
> >  static void gb_gpio_irq_mask(struct irq_data *d)
> >  {
> >  	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
> > -	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
> > +	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
> 
> So please split these changes into a separate patch as they are not
> related to the irqchip changes.
> 
> Oh, and don't forget to update the TODO file now that the conversion is
> done. :)
> 
Sure, I'll do that.

Thanks for the review.
regards,
Nishad

> Thanks,
> Johan
