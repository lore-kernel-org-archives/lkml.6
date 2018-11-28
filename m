Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57434C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C1520832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNmLUZIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C1520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeK1XBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:01:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46594 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK1XBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:01:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so25458513qtm.13;
        Wed, 28 Nov 2018 04:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivGNUHuC5trNAf1eTFQiPK6CCegMEcteGi/avwfi/Fk=;
        b=MNmLUZInQ7SGy+4DQ0S6lTJ27nSGTq8HOLSV3bVwPCflFYTbwkE5fsZR2poTT4ukQC
         y55oq/cEjIxGB0cLGuvq0lsD37rjJvThsPxweOZ9f4yYMTeNzIui6P52OjC8l1aryjmy
         5Ew4br4gh/ruFgOXDticiHjxRWhFU/eL0Wvc8ah0cN9WBPkgdYlF8xziZc/xowlEA25I
         eysva/o8E81NR3VWovEr4He7YS3hztM+dfJxWcu4IRXMqYS9al744RnoJjc04mKmSd+F
         T8m5RZi525PH+6GLLro20/mzDNDQeSwt2YLC6m6t9BGE+xLcYFaTY1qOqgiXaZ8a9CPg
         eoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivGNUHuC5trNAf1eTFQiPK6CCegMEcteGi/avwfi/Fk=;
        b=ee7/RLddPj7/UmpzRkCL1bunExpNCra5msoq70tV85fZYn5XgNcX/dqzkZ3SX6JkLy
         Y67YehwINLpC6BR/HBvgVsfhndmBTbXL3IOCvh4iLpxvYDaO2xg7CSLQV33v3gu6kaOH
         LITp8QbPXvagnybAj+7IeDMkjSKuU8U19ZU1CLbnBQpNG6UAW245Ex8oTjRIxb4beh3M
         v4dV5OmXwsZ3UKzNLwswjjGjn8DdEW2Dahj6m4DGa2h+niwbGMBl4UFGHXxFCQk2tgwT
         LUI/0ELxC21G06c9j+HrvXb1Sannyw8ARgzKE/N8gp8O/GcLVJ2WRPYXX5L4h2VvJbxe
         +eNA==
X-Gm-Message-State: AGRZ1gJXlSYVZDahti3Psc+PJxiZKydhhDeHdO/gk1kgfv2kqPSB8OZs
        4C4MdNq3WIQ9LvgJQ650rC4C850QbYPU/D/boEY=
X-Google-Smtp-Source: AJdET5cmzbbU7Z2T4Dd9iSaM8AGe2yMRsrLflxbMkU969I6PLV1urOVGl3bZX9wmW6Z8UQYXuaDmOHkq8IP7GvTG9Uk=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr32112829qtf.99.1543406421558;
 Wed, 28 Nov 2018 04:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20181127132508.5501-1-fe@dev.tdt.de> <20181127132508.5501-2-fe@dev.tdt.de>
In-Reply-To: <20181127132508.5501-2-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Nov 2018 14:00:10 +0200
Message-ID: <CAHp75Vc0-t=nBGPbYjbaJDoPEg77xKLVDuhUtFQ6imgnkNuz-g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gpio: Add driver for PC Engines APU boards
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 3:25 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> Add a new device driver "gpio-apu" which will handle the GPIOs on APU2
> and APU3 devices from PC Engines.
>
> APU2 (https://pcengines.ch/schema/apu2c.pdf page 7):
> - G32 is "button_reset" connected to the smd-button on the frontpanel
> - G50 is "mpcie2_reset" connected to mPCIe2 reset line
> - G51 is "mpcie3_reset" connected to mPCIe3 reset line
>
> APU3 (https://pcengines.ch/schema/apu3c.pdf page 7):
> - G32 is "button_reset" connected to the smd-button on the frontpanel
> - G50 is "mpcie2_reset" connected to mPCIe2 reset line
> - G51 is "mpcie3_reset" connected to mPCIe3 reset line
> - G33 is "simswap" connected to SIM switch IC to swap the SIM between
>   mPCIe2 and mPCIe3 slot

> +/* PC Engines APU2/APU3 GPIO device driver
> + *
> + * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
> + */

/*
 * Multi-line comments
 * have this style
 */

> +#include <linux/bits.h>
> +#include <linux/dmi.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>

kbuild bot complains for absence of

#include <linux/mod_devicetable.h>

here.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>

> +static int gpio_apu_get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u32 val;
> +       struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
> +
> +       spin_lock(&apu_gpio->lock);
> +

> +       val = ~ioread32(apu_gpio->addr[offset]);

There is no need to do ~ under spin lock.

> +
> +       spin_unlock(&apu_gpio->lock);
> +
> +       return !!(val & BIT(APU_GPIO_BIT_DIR));
> +}

> +       if (dmi_check_system(apu3_gpio_dmi_table)) {

(1)

> +               apu_gpio->addr = devm_kzalloc(&pdev->dev,
> +                               sizeof(apu3_gpio_offset),
> +                               GFP_KERNEL);

> +

No need to have this blank line. Same for the other cases.

> +               if (!apu_gpio->addr)
> +                       return -ENOMEM;

> +       } else if (dmi_check_system(apu2_gpio_dmi_table)) {

(2)

I think I have already told about (1) and (2). You may create two
callbacks and utilize .callback member in DMI table.

> +       }

> +static int __init apu_gpio_init(void)
> +{

> +       if (!(dmi_check_system(apu2_gpio_dmi_table)) &&
> +               !(dmi_check_system(apu3_gpio_dmi_table))) {
> +               pr_err("No PC Engines board detected\n");
> +               return -ENODEV;
> +       }

I don't think we need this.

> +       apu_gpio_pdev = platform_device_register_simple(KBUILD_MODNAME,
> +                       -1, NULL, 0);
> +       if (IS_ERR(apu_gpio_pdev))
> +               return PTR_ERR(apu_gpio_pdev);
> +
> +
> +       return platform_driver_register(&apu_gpio_driver);
> +}
> +
> +static void __exit apu_gpio_exit(void)
> +{
> +       platform_device_unregister(apu_gpio_pdev);
> +       platform_driver_unregister(&apu_gpio_driver);
> +}
> +
> +module_init(apu_gpio_init);
> +module_exit(apu_gpio_exit);

After removing unneeded checks why not to simple use
module_platform_driver()
?

-- 
With Best Regards,
Andy Shevchenko
