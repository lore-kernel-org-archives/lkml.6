Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B9FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA11208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTizoemQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA11208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeK1XHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:07:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33072 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK1XHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:07:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so25532053qtp.0;
        Wed, 28 Nov 2018 04:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g38JUkNzrd/JzSzD8dypVUhgCQxyR8XnmT5NEVXrEi0=;
        b=JTizoemQ52kgaxBgeMZvPHFqTpRaKH6f0zJagf78eR6jVWUe8HjOK872qVAOCgUa/8
         MHvh349NSk7RHADie6nGsmMJLzxNLh8YiUtzmxU/jBLrIoNn4VuSccgfGVp/OhvoJfKH
         uFRGQdHbZc3qwFMNuJn38mZonTSwGtrARnL5qGQyLnLzolcnVl8Xr9GasX3GZQpu/CGH
         ymUGP/xfOlkfqBZAOAoy5r07dKk1/0WgHAlhTvJxaq1d63Peya7T+vO8oUd3IRxQ/JRF
         SgGh8SOxsfZvFrIojeHuzHf5hbw7nvTd0+8ezXWveKzVFUgXOpwO+sNSXrdCnG9uKMD9
         S3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g38JUkNzrd/JzSzD8dypVUhgCQxyR8XnmT5NEVXrEi0=;
        b=e8UG/ykHmYnPx0EwR2a3um2UqLTBRXJx1+tHRPXnH+xeExgoX2IBK74c7UVKft28wT
         TzuRrwj/+gKKZ1AjREVumJDTiEwG0w3nmacAQJAyMwPC5lGsfbf9CBVcEsVQYWwNFavd
         fziDEfKaa7iu5/XeMOrIJOwczdJCrfX5htVmZOg+LFQjp9zACAQfvgseaF4eLOhAPKM9
         Ez2u7r2zuNkQytCo3YCg0cVWgTVdFOZlIM/8+5i4W3rpc/ZRF0mjv91YtRhh00C06FQr
         vWCZqvQORgcIlLiiXv1giJAw+HQez4eanar7rMlP8jdAzeHONH+xmjjd+mtk+3pn5F/l
         jFOA==
X-Gm-Message-State: AGRZ1gLfebQ3Fh6KzrE7CafUf/B2RkIxuMmqoRnPDe/dflO5sYo59jfd
        IGtFxyB9cKzCFmsGCnYWXnCEdf2VbF7ZZP7t+6o=
X-Google-Smtp-Source: AJdET5cN0NjYOd8x9DKe/TySpB+AeHhJlnsaGTjLg6w+z88NPovp/1eZTalL3tRE2rAeBZgLY2aBiw4lRakSzFmbves=
X-Received: by 2002:aed:2d26:: with SMTP id h35mr35221396qtd.373.1543406740493;
 Wed, 28 Nov 2018 04:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20181127132508.5501-1-fe@dev.tdt.de> <20181127132508.5501-3-fe@dev.tdt.de>
In-Reply-To: <20181127132508.5501-3-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Nov 2018 14:05:29 +0200
Message-ID: <CAHp75Vctp4M-RacCzbv1CvWezkKnzMgwXH6pS8iwFw1iFqOGwQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] platform: Add reset button device for PC Engines
 APU boards
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
> Add a platform/x86 device "gpio-keys-polled" for the frontpanel reset button.
> This device uses the gpio-apu driver for APU borads from PC Engines.

Yep, and actually this one has to instantiate a GPIO.

>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/platform/x86/Kconfig                  |  11 +++
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/pcengines-apu-platform.c | 114 ++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 drivers/platform/x86/pcengines-apu-platform.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 54f6a40c75c6..5cd27c2174cb 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1288,6 +1288,17 @@ config INTEL_ATOMISP2_PM
>           To compile this driver as a module, choose M here: the module
>           will be called intel_atomisp2_pm.
>
> +config PCENGINES_APU_PLATFORM
> +       bool "PCEngines APU System Support"
> +       depends on X86_64 && DMI && GPIOLIB
> +       help
> +         This option enables system support for the PCEngines APU platform.
> +         At present this just adds the GPIO reset button platform device on
> +         APU2/APU3 boards.
> +
> +         Note: You must still enable the drivers for GPIO and LED support
> +         (GPIO_APU & LEDS_APU) to actually use the LEDs and the GPIOs.
> +
>  endif # X86_PLATFORM_DEVICES
>
>  config PMC_ATOM
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 39ae94135406..f899cc4c6b48 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -96,3 +96,4 @@ obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
>  obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)    += intel_chtdc_ti_pwrbtn.o
>  obj-$(CONFIG_I2C_MULTI_INSTANTIATE)    += i2c-multi-instantiate.o
>  obj-$(CONFIG_INTEL_ATOMISP2_PM)        += intel_atomisp2_pm.o
> +obj-$(CONFIG_PCENGINES_APU_PLATFORM)   += pcengines-apu-platform.o
> diff --git a/drivers/platform/x86/pcengines-apu-platform.c b/drivers/platform/x86/pcengines-apu-platform.c
> new file mode 100644
> index 000000000000..3bfbaa93cb11
> --- /dev/null
> +++ b/drivers/platform/x86/pcengines-apu-platform.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Specific setup for PC-Engines APU2/APU3 devices
> + *
> + * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +static const struct dmi_system_id apu2_gpio_dmi_table[] __initconst = {
> +       /* PC Engines APU2 with "Legacy" bios < 4.0.8 */
> +       {
> +               .ident = "apu2",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "APU2")
> +               }
> +       },
> +       /* PC Engines APU2 with "Legacy" bios >= 4.0.8 */
> +       {
> +               .ident = "apu2",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "apu2")
> +               }
> +       },
> +       /* PC Engines APU2 with "Mainline" bios */
> +       {
> +               .ident = "apu2",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
> +               }
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(dmi, apu2_gpio_dmi_table);
> +
> +static const struct dmi_system_id apu3_gpio_dmi_table[] __initconst = {
> +       /* PC Engines APU3 with "Legacy" bios < 4.0.8 */
> +       {
> +               .ident = "apu3",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "APU3")
> +               }
> +       },
> +       /* PC Engines APU3 with "Legacy" bios >= 4.0.8 */
> +       {
> +               .ident = "apu3",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "apu3")
> +               }
> +       },
> +       /* PC Engines APU3 with "Mainline" bios */
> +       {
> +               .ident = "apu3",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
> +               }
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(dmi, apu3_gpio_dmi_table);
> +
> +
> +static struct gpio_keys_button apu_gpio_buttons[] = {
> +       {
> +               .code                   = KEY_RESTART,
> +               .gpio                   = 20,
> +               .active_low             = 1,
> +               .desc                   = "Reset button",
> +               .type                   = EV_KEY,
> +               .debounce_interval      = 60,
> +       }
> +};
> +
> +static struct gpio_keys_platform_data apu_buttons_data = {
> +       .buttons                = apu_gpio_buttons,
> +       .nbuttons               = ARRAY_SIZE(apu_gpio_buttons),
> +       .poll_interval          = 20,
> +};
> +
> +static struct platform_device apu_button_dev = {
> +       .name                   = "gpio-keys-polled",
> +       .id                     = 1,
> +       .dev = {
> +               .platform_data          = &apu_buttons_data,
> +       }
> +};
> +
> +static int __init apu_init(void)
> +{
> +       if (!(dmi_check_system(apu2_gpio_dmi_table)) &&
> +               !(dmi_check_system(apu3_gpio_dmi_table))) {
> +               return -ENODEV;
> +       }
> +
> +       return platform_device_register(&apu_button_dev);
> +}
> +
> +static void __exit apu_exit(void)
> +{
> +       platform_device_unregister(&apu_button_dev);
> +}
> +
> +module_init(apu_init);
> +module_exit(apu_exit);
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
