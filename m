Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F691C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0172173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5quR2WF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBGSHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:07:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42787 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:07:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so278125plp.9;
        Thu, 07 Feb 2019 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8UTByPwRQpyFeCK0nJeiR6DiH4YW3WAv6Slzxa/qIQ=;
        b=W5quR2WF/c/3GwvjKAhyhUb9XtMv0NvAyobtoir2NwbJo1SBV/F5/4Jxm/tmz2Bz2n
         5rmyn5cIsjH1VQM18A27iHMXQ7R/hQjUI75sNdPGnVruhgL1VP98BKrVbuGaF3qBL4ZY
         0b67v+QU7yMAiIBRJwr42YyFaJEKMZO2tzLy0mGYvcWfSoVwEk0AZYEXcbXpOilrA30R
         hqkmviQusfeyo+xQQAE8mQVOGN0M57wEk5BCW9yYaZbuLXxWPuQpL34sXUn1DnXkYSak
         sRBOo/2nMJOxd+XRu6AXrNLWjMzLpwIcnDyqeGAePogDGcSPMeMoIqmQOQWHbd6hPaEk
         vxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8UTByPwRQpyFeCK0nJeiR6DiH4YW3WAv6Slzxa/qIQ=;
        b=kX0VlTcQcJwa4Acv6HGUo4FW6my5JI2H+xd7kOU/njTwjZ+4lX/dD0GvpfNCnf9Yw2
         nxP0/d53FCGm6TpWxj9RWaipRqE7pcIHN3/zp4tc40gQWjif7Rqbu7PVChbGIs5LbsUh
         Y8csyZu3cfq+zJm6kv8NJ531XjnB4X5pCWEzLBeH4un1DrKfq7mpzojirvX4Evpiojqs
         DlhWp1aYLqJsRxhDafxhpSJMUSQZk4Ut+YvUUkSyhuI87W0h4+gH1QwTgREtaUFF3Cvl
         NIcncRX6WDG6YwNi0EaqIYzOAPL/UHeu2oKJ6B6DtldErJRM0mxVTJ+Pbf1UoSUQVAFi
         r/OQ==
X-Gm-Message-State: AHQUAuYP3K5ZQnKraSuJAQ+8eOaTdM4bkmqpPIPk2p9qxWvV1sNQl6n2
        Uj8Mwo6n2pfAWZANnwnBTDKjtC1FRPONgRPsx38=
X-Google-Smtp-Source: AHgI3IbtJIACW+juDGDIrnb+P6KxaVyL3WDFavRvZ4ySYgHqHGsyhv76C2UnUF4mIPGhm4+WiH5bzbgD5zwV4YnDJOw=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr17274451pla.144.1549562821204;
 Thu, 07 Feb 2019 10:07:01 -0800 (PST)
MIME-Version: 1.0
References: <1549559639-9447-1-git-send-email-info@metux.net>
In-Reply-To: <1549559639-9447-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Feb 2019 20:06:49 +0200
Message-ID: <CAHp75Vdn-3aBOMo1yzGVS-rWOdgiYasK++yfvzi3iSyOL4Mtqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 7:14 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)
>
> This driver doesn't registers itself automatically, as it needs to
> be provided with platform specific configuration, provided by some
> board driver setup code.
>
> Didn't implement oftree probing yet, as it's rarely found on x86.

Thanks for the patch, see my comments below.

Overall I have a feeling that this driver can be replaced with
existing generic one where one register per pin is allocated.
Unfortunately, I didn't look deep into this and hope Linus will help
to figure this out.

> @@ -0,0 +1,171 @@
> +/*
> + * GPIO driver for the AMD G series FCH (eg. GX-412TC)
> + *
> + * Copyright (C) 2018 metux IT consult
> + * Author: Enrico Weigelt <info@metux.net>
> + *

> + * SPDX-License-Identifier: GPL+

SPDX should go as a separate first line in a proper format.

> + */

> +// FIXME: add spinlocks

Then fix them and come again.

> +#include <linux/init.h>
> +#include <linux/module.h>

One of them should be present, another one dropped.

> +#define GPIO_BIT_DIR           23
> +#define GPIO_BIT_WRITE         22
> +#define GPIO_BIT_READ          16

Oh, namespace issues.
What about using BIT() macro?

> +
> +

Why two blank lines?

> +static uint32_t *amd_fch_gpio_addr(struct gpio_chip *gc, unsigned gpio)
> +{
> +       struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
> +

> +       if (gpio > priv->pdata->gpio_num) {
> +               dev_err(&priv->pdev->dev, "gpio number %d out of range\n", gpio);
> +               return NULL;
> +       }

On which circumstances it may happen?

> +
> +       return priv->base + priv->pdata->gpio_reg[gpio].reg*sizeof(u32);
> +}
> +
> +static int amd_fch_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
> +{

> +       volatile uint32_t *ptr = amd_fch_gpio_addr(gc, offset);

volatile?!

I think you need to use readl()/writel() (or their _relaxed variants) instead.
Same applies for entire code.

> +       if (!ptr) return -EINVAL;

This code has style issues.
Check your entire file.

> +
> +       *ptr &= ~(1 << GPIO_BIT_DIR);
> +       return 0;
> +}

> +static void amd_fch_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
> +{
> +       struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
> +       (void)priv;
> +
> +       seq_printf(s, "debug info not implemented yet\n");
> +}

Remove whatever is not implemented and not required to have a stub.

> +static int amd_fch_gpio_request(struct gpio_chip *chip, unsigned gpio_pin)
> +{

> +       if (gpio_pin < chip->ngpio)
> +               return 0;

Is it even possible?

> +
> +       return -EINVAL;
> +}


> +
> +static int amd_fch_gpio_probe(struct platform_device *pdev)
> +{
> +       struct amd_fch_gpio_priv *priv;

> +       struct amd_fch_gpio_pdata *pdata = pdev->dev.platform_data;

We have a helper to get this. platform_get_data() IIRC.

> +       int err;
> +
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "no platform_data\n");
> +               return -ENOENT;
> +       }
> +

> +       if (!(priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL))) {

Should be two lines.

> +               dev_err(&pdev->dev, "failed to allocate priv struct\n");

Noise.

> +               return -ENOMEM;
> +       }
> +

> +       if (IS_ERR(priv->base = devm_ioremap_resource(&pdev->dev, &priv->pdata->res))) {

> +               dev_err(&pdev->dev, "failed to map iomem\n");

Noise (that function will print a message)

> +               return -ENXIO;

Shadowed error code.

> +       }
> +

> +       dev_info(&pdev->dev, "initializing on my own II\n");

Noise.

> +

> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {

Do you really care?

> +               dev_info(&pdev->dev, "enabling debugfs\n");

Noise.

> +               priv->gc.dbg_show = amd_fch_gpio_dbg_show;
> +       }
> +
> +       platform_set_drvdata(pdev, priv);
> +

> +       err = devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
> +       dev_info(&pdev->dev, "probe finished\n");
> +       return err;

return devm_gpiochip_add_data(...);

> +}

> +MODULE_LICENSE("GPL");

License mismatch. I really don't look what 'GPL+' means. OTOH I know
this one corresponds to GPL-2.0+.

> +++ b/include/linux/platform_data/x86/amd-fch-gpio-pdata.h
> @@ -0,0 +1,41 @@
> +/*
> + * AMD FCH gpio driver platform-data
> + *
> + * Copyright (C) 2018 metux IT consult
> + * Author: Enrico Weigelt <info@metux.net>
> + *

> + * SPDX-License-Identifier: GPL

Same comments.

> + */

> +/*

It's not marked as kernel doc.

> + * struct amd_fch_gpio_reg - GPIO register definition
> + * @reg: register index
> + * @name: signal name
> + */
> +struct amd_fch_gpio_reg {
> +    int         reg;
> +    const char* name;
> +};

Isn't this provided by GPIO library? We have so called labels.

> +/*
> + * struct amd_fch_gpio_pdata - GPIO chip platform data
> + * @resource: iomem range
> + * @gpio_reg: array of gpio registers
> + * @gpio_num: number of entries
> + */
> +struct amd_fch_gpio_pdata {
> +    struct resource          res;
> +    int                      gpio_num;
> +    struct amd_fch_gpio_reg *gpio_reg;
> +    int                      gpio_base;
> +};

-- 
With Best Regards,
Andy Shevchenko
