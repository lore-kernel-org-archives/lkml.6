Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AD82184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545131436;
	bh=2HGD8MI5ioJhJYUpwHis9FGuNZENSUGMQ7noMzYWIkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2o2/NwO2YqJwNaRBQtymgGQw4F6ImPnetN3f5M45VnPmhshtV2z4O7kPvVu84VH4v
	 CRcnFkomwjY6z+tKYhIiJcWHgzzCZIFars3xoqIpwejJS9lh/6VWgd8LSbOK2fyfxp
	 rVpIGeBk4uMt1MC7ilaqrmiV0zg2+NtI5GA14wog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLRLKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:10:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34560 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:10:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so3141321lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8pX42wrj24jWbglSgaxkOqshMnKp4WI7Qxnj5pOWP4=;
        b=tBTKpk2mg1ln0dcLMUFI+wPLSUtDBSK7csd1pYID6yZHKrerUxBiRDpxxvRb+PzBud
         2iPGaQ3f5wgk1EXHm8JvwE1N0cmoccpswFqFMTg1cdxn1gYBbIuLHAlFVfT1+FSxFgeW
         uyWpoxGJZZhwmtFwJ6iHtHVvrZGt2UckclUBLWs8a8C3HtdYvvHZ/t79rQR2oBlib4Dd
         y2veaMf3RqbUFrEkVvybhLi/SKty2n6UerFOIlksAhC2q4BYuEvNj+wFzU38zYhoMW5M
         3CGxggLJn+pXIpSGClqx9kzKgcy6/IRqhvOtRkUhnCDVe4NQmLdf6L4gFt9k34YAlgMP
         2MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8pX42wrj24jWbglSgaxkOqshMnKp4WI7Qxnj5pOWP4=;
        b=G8w4rsytLKsLbpg9Hr8ID7fP3D/e8GG0WsIzUH1HaTWqt202j/dMHae0fkrliizAKa
         NtEpvcG+mmkYer1Pvp9Y1jUgyTVI+CjBO/2SJuDN8/w51itWLnuKfqgBYaaV5zyxDYAh
         7qAkP947RgewfhQ0BLrEP4bTLyvSBe9pFXB/jM9I6xbq7RKzFmyxENnfnh1yHUpnpTzn
         3s6VrNdLFcVwY3ycGBBdioR6nh1T7LgvkdZZ9gyfTnT1erlSxn+8ezYJqCD6ziYpRIwN
         63AZgJf9PHW8dZ0V6RrGqOrwAIsqAEOS44QAKbM8Pita8jHBQy9FxH+dgnF7K1dG0ECB
         1cOg==
X-Gm-Message-State: AA+aEWaOOr3+DqlYdqLXaUlklBVCjqF5XpeSlB3bMCgrc/zJt10BKxix
        Cp9uXu3nrMVWUHvz8G6xYBE=
X-Google-Smtp-Source: AFSGD/VuDlEeYfsl8vZfelAP3YzgrqoQoiBL40ZYmRaCL1CkxsoJIBzD165s3tlGCNTxRQawG/Sjsg==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr4172069ljk.114.1545131432116;
        Tue, 18 Dec 2018 03:10:32 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id s24sm3047342lfc.30.2018.12.18.03.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:10:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gZDGk-000402-Gm; Tue, 18 Dec 2018 12:10:34 +0100
Date:   Tue, 18 Dec 2018 12:10:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: greybus: gpio: switch GPIO portions to
 use GPIOLIB_IRQCHIP
Message-ID: <20181218111034.GM20658@localhost>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
 <e12d2f21115c71820d4d68168181e5ebe4340f0f.1542898267.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12d2f21115c71820d4d68168181e5ebe4340f0f.1542898267.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:37:16PM +0530, Nishad Kamdar wrote:
> Convert the GPIO driver to use the GPIO irqchip library
> GPIOLIB_IRQCHIP instead of reimplementing the same.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v2:
>  - Retained irq.h and irqdomain.h headers.
>  - Dropped function gb_gpio_irqchip_add() and
>    called gpiochip_irqchip_add() from probe().
>  - Referred https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org.

Thanks for the update, and sorry about the late review. This looks
mostly good now, except for a couple minor things pointed out below.

You also included the conversion to gpiochip_get_data() (as Linus also
did in his patch) although that's really a separate change and should go
in its own patch. Please break that bit out in a follow-up patch.

Also note that someone did a bunch random white space changes to this
file in the staging tree, so it will not apply cleanly any more.

> ---
>  drivers/staging/greybus/Kconfig |   1 +
>  drivers/staging/greybus/gpio.c  | 184 ++++----------------------------
>  2 files changed, 24 insertions(+), 161 deletions(-)
> 
> diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
> index ab096bcef98c..b571e4e8060b 100644
> --- a/drivers/staging/greybus/Kconfig
> +++ b/drivers/staging/greybus/Kconfig
> @@ -148,6 +148,7 @@ if GREYBUS_BRIDGED_PHY
>  config GREYBUS_GPIO
>  	tristate "Greybus GPIO Bridged PHY driver"
>  	depends on GPIOLIB
> +	select GPIOLIB_IRQCHIP
>  	---help---
>  	  Select this option if you have a device that follows the
>  	  Greybus GPIO Bridged PHY Class specification.
> diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
> index b1d4698019a1..2ec54744171d 100644
> --- a/drivers/staging/greybus/gpio.c
> +++ b/drivers/staging/greybus/gpio.c
> @@ -9,9 +9,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/mutex.h>
>  
>  #include "greybus.h"
> @@ -39,15 +39,8 @@ struct gb_gpio_controller {
>  
>  	struct gpio_chip	chip;
>  	struct irq_chip		irqc;

Turns out struct gpio_chip will have an irqchip whenever
CONFIG_GPIOLIB_IRQCHIP is selected so you can drop this one too.

> -	struct irq_chip		*irqchip;
> -	struct irq_domain	*irqdomain;
> -	unsigned int		irq_base;
> -	irq_flow_handler_t	irq_handler;
> -	unsigned int		irq_default_type;
>  	struct mutex		irq_lock;
>  };
> -#define gpio_chip_to_gb_gpio_controller(chip) \
> -	container_of(chip, struct gb_gpio_controller, chip)
>  #define irq_data_to_gpio_chip(d) (d->domain->host_data)
>  
>  static int gb_gpio_line_count_operation(struct gb_gpio_controller *ggc)
> @@ -276,7 +269,7 @@ static void _gb_gpio_irq_set_type(struct gb_gpio_controller *ggc,
>  static void gb_gpio_irq_mask(struct irq_data *d)
>  {
>  	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
> -	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
> +	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);

So please split these changes into a separate patch as they are not
related to the irqchip changes.

Oh, and don't forget to update the TODO file now that the conversion is
done. :)

Thanks,
Johan
