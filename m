Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB84C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9BC20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqPI6kdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfBHOZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:25:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41079 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfBHOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:25:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id f21-v6so1712019ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDPpPAmqLIJLDsQOHA3Y3bUJVsxdT4Qe3Ggu3sfJqU4=;
        b=WqPI6kdmhkq23OVsNfSc9RblGlWgFdmU0mpgY0c7LHDuMJOFzrOYSqeXU/PCCIKDvx
         vNqoM3M8rIN16BKaOtoJrmdnwhxzhnFLxYv21h/SRAwC6LM4cEAEjllMJQmBZe9gfx87
         kXih8W0n5OuRn81KqtZJUi9UR/xMXeo8wLnnZmlvo4XipY8QNeeqvXsBdRbKmgjIEF3D
         W8+rcWbK+sjwGFo7au4Tgijym5I0ITBzvM36fkkYWrAyGeQzoEBWbmoWe0UFNnvWWW5M
         BI+wb5m6LtXSsJ1cd8j5RxIl3UsNQXY5I8KIre/Ndlx/COOqelhI8CsNRy9sEQy20dEY
         2few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDPpPAmqLIJLDsQOHA3Y3bUJVsxdT4Qe3Ggu3sfJqU4=;
        b=NzbEtl0wVyr8LG8C6J/NpDRv3eUw9f5f+CCJ2Nm1BTR4MG9kPoCgpeF6/ZGklXGGvi
         fwPiSbTZhlo3/bw4cUvvJsanzEjKEgIym9JOcWNoVGkOAdasYjc54NAFhMX0pIQwH+UI
         OMVQ2cblizXw8FIb1fgDtqGX4kmWg5n1fOXz1UHJQuVCskqNxTVt17kWX1dCxdUAIOBc
         D7MJ071T3ajveoV0/9Y7/ZozG9/g/3PIBSUGqNpU/4YVhrMe0qAuqrj6YFRyw9ZufHDE
         rCQP5MbbXec8FyeV/TcOobM9oo4QUWeViGnxE7o0M2eWH0x7qc1oVFO6yVCPSxHPrEHD
         Rn8w==
X-Gm-Message-State: AHQUAub77KAcT8T8z5tb2b0zWrEYOrfVbHMNROfPQtn6k9n77MzMv/W6
        iYMuc31UBfcLUuBBVfWsr3CTBm7/D7YDna9TvMtkQA==
X-Google-Smtp-Source: AHgI3IZ/a7XARtDN7FAnLkVZ3GK4eN+C2yCEBa8Q/kgug+kZxgQSgvJrKGeE4udqXZQ3BnZlwzqLaOhPiVhidSkOs7s=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr14299700ljc.97.1549635956929;
 Fri, 08 Feb 2019 06:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
In-Reply-To: <1549588593-4856-1-git-send-email-lkml@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:25:44 +0100
Message-ID: <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico!

Thanks for your patch! I would really like Andy to have a look at it
too, he's more on top of things in the x86 world.

On Fri, Feb 8, 2019 at 2:16 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> From: "Enrico Weigelt, metux IT consult" <info@metux.net>
>
> GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)
>
> This driver doesn't registers itself automatically, as it needs to
> be provided with platform specific configuration, provided by some
> board driver setup code.
>
> Didn't implement oftree probing yet, as it's rarely found on x86.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: linus.walleij@linaro.org
> Cc: bgolaszewski@baylibre.com
> Cc: dvhart@infradead.org
> Cc: andy@infradead.org
> Cc: platform-driver-x86@vger.kernel.org
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

(...)

> +config GPIO_AMD_FCH
> +       tristate "GPIO support for AMD Fusion Controller Hub (G-series SOCs)"
> +       select GPIO_GENERIC

You are selecting GPIO_GENERIC, is this necessary? I thought
X86 was already selecting this.

> +/*
> + * GPIO driver for the AMD G series FCH (eg. GX-412TC)
> + *
> + * Copyright (C) 2018 metux IT consult
> + * Author: Enrico Weigelt <info@metux.net>
> + *
> + * SPDX-License-Identifier: GPL+
> + */

I think checkpatch will complain on that SPDX thing.
Copy something from one of the other drivers, it should be
on the first line of the file.

> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/platform_data/x86/amd-fch-gpio-pdata.h>
> +
> +
> +#define GPIO_BIT_DIR           23
> +#define GPIO_BIT_WRITE         22
> +#define GPIO_BIT_READ          16
> +
> +

Cut down the excessive newlines.

> +static void amd_fch_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
> +{
> +       struct amd_fch_gpio_priv *priv = gpiochip_get_data(gc);
> +       (void)priv;
> +
> +       seq_printf(s, "debug info not implemented yet\n");
> +}

I think you can just skip implementing this then.

> +static int amd_fch_gpio_request(struct gpio_chip *chip, unsigned gpio_pin)
> +{
> +       if (gpio_pin < chip->ngpio)
> +               return 0;
> +
> +       return -EINVAL;
> +}

You can probably skip this too. The core already does this check.

> +       priv->gc.owner                  = THIS_MODULE;
> +       priv->gc.parent                 = &pdev->dev;
> +       priv->gc.label                  = dev_name(&pdev->dev);
> +       priv->gc.base                   = priv->pdata->gpio_base;

No please, use priv->gc.base = -1;

> +       dev_info(&pdev->dev, "initializing on my own II\n");

Drop this.

> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> +               dev_info(&pdev->dev, "enabling debugfs\n");
> +               priv->gc.dbg_show = amd_fch_gpio_dbg_show;
> +       }

I think you can drop this too.

> +       platform_set_drvdata(pdev, priv);
> +
> +       err = devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
> +       dev_info(&pdev->dev, "probe finished\n");

If you keep this info, write something more helpful.

> +/*
> + * struct amd_fch_gpio_reg - GPIO register definition
> + * @reg: register index
> + * @name: signal name
> + */
> +struct amd_fch_gpio_reg {
> +    int         reg;
> +    const char* name;
> +};

Can't you put this in the driver file?

> +struct amd_fch_gpio_pdata {
> +    struct resource          res;
> +    int                      gpio_num;
> +    struct amd_fch_gpio_reg *gpio_reg;
> +    int                      gpio_base;
> +};

Drop gpio_base. We don't hardcode the GPIO base anymore.
Use the character device instead if you want it because of
userspace thingies. (See tools/gpio/*)

Yours,
Linus Walleij
