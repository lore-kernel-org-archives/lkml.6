Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A283C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D510214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QQLed+li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfBUJdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:33:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54681 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:33:11 -0500
Received: by mail-it1-f193.google.com with SMTP id f10so21433297ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrmhEtKv/lhYR2KCk/YKbqFuxahsT7Ps/lhhFw8A9LA=;
        b=QQLed+liBUBnRsUJvcC9A4oL2HAs3bhypNnW+sSx/NwYpBEqUxBonctykABQi1sPsC
         33UXsLE4GyIZzdrddSJhORfLYjS3faxZU2l+M/8boO0EkqmpafZtN7DzTC7n9lEkG9cJ
         VSRx1ObcT+VfG1gtdhXHHBZbpFIqgcyq3IsuvrmR8832zwjuOFt8PHiyufi29FbS8VWs
         WZhz11onW0s5rWAYbE+Rog1EEEoKyYLPId+wCGGhe2WX+lxkHSTnz9uCvNyRN0W+Qf1f
         zeqdcWHXHmL55NQQdsPcxrqIjwZAhQEhtak28UmC0Q1AV+i2XklJr2QwrkZ4guChY9ba
         8tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrmhEtKv/lhYR2KCk/YKbqFuxahsT7Ps/lhhFw8A9LA=;
        b=EPHiBmw7iuAoUamNBlT5Iolz/xfhUaGKs3gy8wHCKwRwfYoCd6gO5/0lBbP94SdkVB
         wHp1fc0bkNXHU+YLLtywQ4i1qfp6f4FzYH5CQlytQORGJh9C16F9A4HaVCnoXzZppjkT
         qrjxcZWeU6GibvJtPmeeQJV8cjpkOVer9qfTbpx5ts3bRg29MbBcVaV8loE99aYO2ErD
         ySMh53KLIQfRGvTYgQhjDcKx/bqYR2BOk31qmCPZnryV32Nx55KUUA+aniWAD8GRFs36
         Py+w5S1iCTRGHmxqi3t0hRgRXkFqBuhQmxeAH8HBVbWpd/G482/9QfA+RafkNzG32m69
         LHqA==
X-Gm-Message-State: AHQUAuZyHkh2JhgYYqGmuHDzF6mfKN30ybeJzdkyM04d7Cm+haNGsN5S
        oBni1GDkkgywhwif5SPzjSC4ffK17v4rvcXLNbeGnQ==
X-Google-Smtp-Source: AHgI3IYgmqrElm2EHOTb6Ygds8pjKn67J1Daxy8PBklKjQpwcAHCYs4CB1rFJrI9sYJ1pbBD88sQoEfMGwzLTwEnQ3w=
X-Received: by 2002:a02:1185:: with SMTP id 127mr13693893jaf.136.1550741589638;
 Thu, 21 Feb 2019 01:33:09 -0800 (PST)
MIME-Version: 1.0
References: <f6452e87ce2e1709e99b8f99cef1c49f0abfae0b.1550699918.git.sramani@mellanox.com>
In-Reply-To: <f6452e87ce2e1709e99b8f99cef1c49f0abfae0b.1550699918.git.sramani@mellanox.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 21 Feb 2019 10:32:58 +0100
Message-ID: <CAMRc=McNS=hKGMqxsjSn9_fqfJUh=psEiu-D1T0_Gfp_YHSDbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] gpio: add driver for Mellanox BlueField GPIO controller
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 20 lut 2019 o 23:07 Shravan Kumar Ramani <sramani@mellanox.com> n=
apisa=C5=82(a):
>
> This patch adds support for the GPIO controller used by Mellanox
> BlueField SOCs.
>

Starts to look good. Just some minor points.

First: when submitting new versions - please list the changes from the
last one (or even better: all changes between all versions). This is a
small driver, but with bigger patches it's important to know what
changed.

> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  drivers/gpio/Kconfig      |   6 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-mlxbf.c | 222 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 229 insertions(+)
>  create mode 100644 drivers/gpio/gpio-mlxbf.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b5a2845..c950fe8 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1292,6 +1292,12 @@ config GPIO_MERRIFIELD
>         help
>           Say Y here to support Intel Merrifield GPIO.
>
> +config GPIO_MLXBF
> +       tristate "Mellanox BlueField SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
> +       help
> +         Say Y here if you want GPIO support on Mellanox BlueField SoC.
> +
>  config GPIO_ML_IOH
>         tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
>         depends on X86 || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 37628f8..8d54279 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_GPIO_MENZ127)    +=3D gpio-menz127.o
>  obj-$(CONFIG_GPIO_MERRIFIELD)  +=3D gpio-merrifield.o
>  obj-$(CONFIG_GPIO_MC33880)     +=3D gpio-mc33880.o
>  obj-$(CONFIG_GPIO_MC9S08DZ60)  +=3D gpio-mc9s08dz60.o
> +obj-$(CONFIG_GPIO_MLXBF)       +=3D gpio-mlxbf.o
>  obj-$(CONFIG_GPIO_ML_IOH)      +=3D gpio-ml-ioh.o
>  obj-$(CONFIG_GPIO_MM_LANTIQ)   +=3D gpio-mm-lantiq.o
>  obj-$(CONFIG_GPIO_MOCKUP)      +=3D gpio-mockup.o
> diff --git a/drivers/gpio/gpio-mlxbf.c b/drivers/gpio/gpio-mlxbf.c
> new file mode 100644
> index 0000000..c0f21f4
> --- /dev/null
> +++ b/drivers/gpio/gpio-mlxbf.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/resource.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +/* Number of pins on BlueField */
> +#define MLXBF_GPIO_NR 54
> +
> +/* Pad Electrical Controls. */
> +#define MLXBF_GPIO_PAD_CONTROL__FIRST_WORD 0x0700
> +#define MLXBF_GPIO_PAD_CONTROL_1__FIRST_WORD 0x0708
> +#define MLXBF_GPIO_PAD_CONTROL_2__FIRST_WORD 0x0710
> +#define MLXBF_GPIO_PAD_CONTROL_3__FIRST_WORD 0x0718
> +

Why the double underscores? Maybe let's make it
MLXBF_GPIO_PADCTRL_FIRST_WORD and so on.

> +#define MLXBF_GPIO_PIN_DIR_I 0x1040
> +#define MLXBF_GPIO_PIN_DIR_O 0x1048
> +#define MLXBF_GPIO_PIN_STATE 0x1000
> +#define MLXBF_GPIO_SCRATCHPAD 0x20
> +
> +#ifdef CONFIG_PM
> +struct mlxbf_gpio_context_save_regs {
> +       u64 scratchpad;
> +       u64 pad_control[MLXBF_GPIO_NR];
> +       u64 pin_dir_i;
> +       u64 pin_dir_o;
> +};
> +#endif
> +
> +/* Device state structure. */
> +struct mlxbf_gpio_state {
> +       struct gpio_chip gc;
> +
> +       /* Must hold this lock to modify shared data. */
> +       spinlock_t lock;
> +
> +       /* Memory Address */
> +       void __iomem *dc_base;
> +
> +#ifdef CONFIG_PM
> +       struct mlxbf_gpio_context_save_regs csave_regs;
> +#endif
> +};
> +
> +static int mlxbf_gpio_set_input(struct gpio_chip *chip, unsigned int off=
set)
> +{
> +       struct mlxbf_gpio_state *gs =3D gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       out =3D readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       in =3D readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +

Please protect the entire read/modify operations. Same below. What if
someone was writing to the registers while we're reading them here?

> +       spin_lock(&gs->lock);
> +       writeq(out & ~BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       writeq(in | BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +static int mlxbf_gpio_set_output(struct gpio_chip *chip, unsigned int of=
fset,
> +                                int value)
> +{
> +       struct mlxbf_gpio_state *gs =3D gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       out =3D readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       in =3D readq(gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +
> +       spin_lock(&gs->lock);
> +       writeq(out | BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_O);
> +       writeq(in & ~BIT(offset), gs->dc_base + MLXBF_GPIO_PIN_DIR_I);
> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +static int mlxbf_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u64 value;
> +       struct mlxbf_gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       value =3D readq(gs->dc_base + MLXBF_GPIO_PIN_STATE);
> +       spin_unlock(&gs->lock);
> +
> +       return (value >> offset) & 1;
> +}
> +
> +static void mlxbf_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +                          int value)
> +{
> +       u64 data;
> +       struct mlxbf_gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       data =3D readq(gs->dc_base + MLXBF_GPIO_PIN_STATE);
> +
> +       if (value)
> +               data |=3D BIT(offset);
> +       else
> +               data &=3D ~BIT(offset);
> +       writeq(data, gs->dc_base + MLXBF_GPIO_PIN_STATE);
> +       spin_unlock(&gs->lock);
> +}
> +
> +static int mlxbf_gpio_probe(struct platform_device *pdev)
> +{
> +       struct mlxbf_gpio_state *gs;
> +       struct device *dev =3D &pdev->dev;
> +       struct gpio_chip *gc;
> +       struct resource *dc_res;

This is a minor nit: why do you use the dc_ prefix? Maybe let's use
more standard names for these variables like "base", "res" etc.? If
there is a valid reason - feel free to ignore it.

> +       int ret;
> +
> +       gs =3D devm_kzalloc(&pdev->dev, sizeof(*gs), GFP_KERNEL);
> +       if (!gs)
> +               return -ENOMEM;
> +
> +       dc_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       gs->dc_base =3D devm_ioremap_resource(&pdev->dev, dc_res);
> +       if (IS_ERR(gs->dc_base))
> +               return PTR_ERR(gs->dc_base);
> +
> +       gc =3D &gs->gc;
> +       gc->direction_input =3D mlxbf_gpio_set_input;
> +       gc->direction_output =3D mlxbf_gpio_set_output;
> +       gc->get =3D mlxbf_gpio_get;
> +       gc->set =3D mlxbf_gpio_set;
> +       gc->label =3D dev_name(dev);
> +       gc->parent =3D &pdev->dev;
> +       gc->owner =3D THIS_MODULE;
> +       gc->base =3D -1;
> +       gc->ngpio =3D MLXBF_GPIO_NR;
> +
> +       ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed adding memory mapped gpiochip=
\n");
> +               return ret;
> +       }
> +
> +       spin_lock_init(&gs->lock);
> +       platform_set_drvdata(pdev, gs);
> +       dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int mlxbf_gpio_suspend(struct platform_device *pdev, pm_message_t=
 state)
> +{
> +       struct mlxbf_gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       gs->csave_regs.scratchpad =3D readq(gs->dc_base + MLXBF_GPIO_SCRA=
TCHPAD);
> +       gs->csave_regs.pad_control[0] =3D
> +               readq(gs->dc_base + MLXBF_GPIO_PAD_CONTROL__FIRST_WORD);
> +       gs->csave_regs.pad_control[1] =3D
> +               readq(gs->dc_base + MLXBF_GPIO_PAD_CONTROL_1__FIRST_WORD)=
;
> +       gs->csave_regs.pad_control[2] =3D
> +               readq(gs->dc_base + MLXBF_GPIO_PAD_CONTROL_2__FIRST_WORD)=
;
> +       gs->csave_regs.pad_control[3] =3D
> +               readq(gs->dc_base + MLXBF_GPIO_PAD_CONTROL_3__FIRST_WORD)=
;
> +       gs->csave_regs.pin_dir_i =3D readq(gs->dc_base + MLXBF_GPIO_PIN_D=
IR_I);
> +       gs->csave_regs.pin_dir_o =3D readq(gs->dc_base + MLXBF_GPIO_PIN_D=
IR_O);
> +
> +       return 0;
> +}
> +
> +static int mlxbf_gpio_resume(struct platform_device *pdev)
> +{
> +       struct mlxbf_gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       writeq(gs->csave_regs.scratchpad, gs->dc_base + MLXBF_GPIO_SCRATC=
HPAD);
> +       writeq(gs->csave_regs.pad_control[0],
> +              gs->dc_base + MLXBF_GPIO_PAD_CONTROL__FIRST_WORD);
> +       writeq(gs->csave_regs.pad_control[1],
> +              gs->dc_base + MLXBF_GPIO_PAD_CONTROL_1__FIRST_WORD);
> +       writeq(gs->csave_regs.pad_control[2],
> +              gs->dc_base + MLXBF_GPIO_PAD_CONTROL_2__FIRST_WORD);
> +       writeq(gs->csave_regs.pad_control[3],
> +              gs->dc_base + MLXBF_GPIO_PAD_CONTROL_3__FIRST_WORD);
> +       writeq(gs->csave_regs.pin_dir_i, gs->dc_base + MLXBF_GPIO_PIN_DIR=
_I);
> +       writeq(gs->csave_regs.pin_dir_o, gs->dc_base + MLXBF_GPIO_PIN_DIR=
_O);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct acpi_device_id mlxbf_gpio_acpi_match[] =3D {
> +       { "MLNXBF02", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, mlxbf_gpio_acpi_match);
> +
> +static struct platform_driver mlxbf_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "mlxbf_gpio",
> +               .acpi_match_table =3D ACPI_PTR(mlxbf_gpio_acpi_match),
> +       },
> +       .probe    =3D mlxbf_gpio_probe,
> +#ifdef CONFIG_PM
> +       .suspend  =3D mlxbf_gpio_suspend,
> +       .resume   =3D mlxbf_gpio_resume,
> +#endif
> +};
> +
> +module_platform_driver(mlxbf_gpio_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField GPIO Driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL");
> --
> 2.1.2
>

Best regards,
Bartosz Golaszewski
