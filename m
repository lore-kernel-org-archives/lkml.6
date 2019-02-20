Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB51B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OobCBabl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfBTI7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:59:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39784 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfBTI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:59:34 -0500
Received: by mail-it1-f196.google.com with SMTP id l15so13733205iti.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zTxqinwPiFEffB5OvDndIF0J4McpgBvJreNSjkkT4oY=;
        b=OobCBabl6F036iVY06IUY7yLOCWkpR2rbOMnROfIxV0NOBXkrp0vRTrDwfkT+atJEC
         LAXSuKQN/4XtC/UTcow8d6vNz9h9gDVuAB6YVR8yqsg7j0FeoqdtFq8uTHsKPIiBzD/P
         JPUnFwULlwPFYcZaocz5GSh2LL+3LJX6zUWlpLUxNC50BWi81siYbzzgK5NTuPBqFYJu
         9FokOzaSN0Yybzs0Ngp+IHD3WQPXzOgAkyOM00uH1ssoidVrn12loCRp13Tmtozi6UQ0
         2wZCMJMSGBai+YsqqvLkEaVTonqCq7d43jlwqlHeOjy8dDvCjpXvkcCiOajkCLNgDrb6
         9yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zTxqinwPiFEffB5OvDndIF0J4McpgBvJreNSjkkT4oY=;
        b=CIBzXKzpKqLbWqEq9EGtLxrfb/Kmf2sKRxU3969tI7pC9AZHhVV7Yah3zEeWo6VVb3
         +2+DaHf4yII8R6SDd6hMJncEmMVFWMQejVR8f/h6S09ETUDTXpY9JGJtEfBL6Aunr6pg
         fGRBwY7EiPyU+aaiVwiFEXC8xw8KG/mLGPoNHtf8uwtlu/Lez2HerJTx4evzrAAcTAyC
         7p3OHS5ZWRIAFxtg0gFn5qETIdLOLY0SirXP3MWTy5jCSHxIx4VkPWzQjBXS04UcqFCN
         qlHbfRK1EU3HGX1yv6WvOa5XFrq5UrkbeTIWHzkpbb0nWyDrxu9Dy/YUNnL1DFvZSM5z
         bfSg==
X-Gm-Message-State: AHQUAuaFL7bGr0xVSBvb9yS9+rFaBSiEgjFaDad+H48nPbUb9x/0De/P
        0jCtfkGT5yXCHrv5KddPoMzQMpxPDjoEevzpWUtyfg==
X-Google-Smtp-Source: AHgI3IYTfBoSpOAOi4pHLd2Tpp4qo4RL2FVfaAbJjZL7HJJ9bZU99FW8Hk0Duh5bOEJVR8KqzqWPZiVHN7eqgRVEUrU=
X-Received: by 2002:a24:7284:: with SMTP id x126mr5323689itc.96.1550653172607;
 Wed, 20 Feb 2019 00:59:32 -0800 (PST)
MIME-Version: 1.0
References: <ca55f568da9a5be30700623697f7d398c149cda3.1550608440.git.sramani@mellanox.com>
In-Reply-To: <ca55f568da9a5be30700623697f7d398c149cda3.1550608440.git.sramani@mellanox.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Feb 2019 09:59:21 +0100
Message-ID: <CAMRc=MeMdcNbYuEL5Q50h=XLtd6078MauP6svCREN3rW2w0Kog@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: add driver for Mellanox BlueField GPIO controller
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

wt., 19 lut 2019 o 21:55 Shravan Kumar Ramani <sramani@mellanox.com> napisa=
=C5=82(a):
>
> This patch adds support for the GPIO controller used by Mellanox
> BlueField SOCs.
>

Thanks for addressing the issues. A couple more things I missed the
last time are below.

> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  drivers/gpio/Kconfig      |   6 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-mlxbf.c | 246 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 253 insertions(+)
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
> index 0000000..bf197aa
> --- /dev/null
> +++ b/drivers/gpio/gpio-mlxbf.c
> @@ -0,0 +1,246 @@
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
> +#include <linux/moduleparam.h>
> +#include <linux/pinctrl/consumer.h>

The two headers above are not needed - you neither define any module
params nor use any pinctrl consumer API.

> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/resource.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +/* Number of pins on BlueField */
> +#define MLXBF_GPIO_NR 54

The naming convention for symbols is not consistent. Could you use
mlxbf_gpio_ prefix for all symbols in this driver? Uppercase for
defines and lowercase for functions and structures.

> +
> +/* Pad Electrical Controls. */
> +#define GPIO_PAD_CONTROL__FIRST_WORD 0x0700
> +#define GPIO_PAD_CONTROL_1__FIRST_WORD 0x0708
> +#define GPIO_PAD_CONTROL_2__FIRST_WORD 0x0710
> +#define GPIO_PAD_CONTROL_3__FIRST_WORD 0x0718
> +
> +#define GPIO_PIN_DIR_I 0x1040
> +#define GPIO_PIN_DIR_O 0x1048
> +#define GPIO_PIN_STATE 0x1000
> +#define GPIO_SCRATCHPAD 0x20
> +
> +#ifdef CONFIG_PM
> +struct bluefield_context_save_regs {
> +       u64 gpio_scratchpad;
> +       u64 gpio_pad_control[MLXBF_GPIO_NR];
> +       u64 gpio_pin_dir_i;
> +       u64 gpio_pin_dir_o;
> +};
> +#endif
> +
> +/* Device state structure. */
> +struct gpio_state {
> +       struct gpio_chip gc;
> +
> +       /* Must hold this lock to modify shared data. */
> +       spinlock_t lock;
> +
> +       /* Memory Address */
> +       void __iomem *dc_base;
> +
> +#ifdef CONFIG_PM
> +       struct bluefield_context_save_regs csave_regs;
> +#endif
> +};
> +
> +static int gpio_bf_set_input(struct gpio_chip *chip, unsigned int offset=
)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       out =3D readq(gs->dc_base + GPIO_PIN_DIR_O);
> +       in =3D readq(gs->dc_base + GPIO_PIN_DIR_I);
> +
> +       writeq(out & ~BIT(offset), gs->dc_base + GPIO_PIN_DIR_O);
> +       writeq(in | BIT(offset), gs->dc_base + GPIO_PIN_DIR_I);
> +
> +       return 0;
> +}
> +
> +static int gpio_bf_set_output(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       out =3D readq(gs->dc_base + GPIO_PIN_DIR_O);
> +       in =3D readq(gs->dc_base + GPIO_PIN_DIR_I);
> +
> +       writeq(out | BIT(offset), gs->dc_base + GPIO_PIN_DIR_O);
> +       writeq(in & ~BIT(offset), gs->dc_base + GPIO_PIN_DIR_I);
> +
> +       return 0;
> +}
> +
> +static int gpio_bf_set_output_lock(struct gpio_chip *chip,
> +                                  unsigned int offset, int value)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       gpio_bf_set_output(chip, offset);

There's no reason to split these functions into locked and unlocked
parts - please merge them.

> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +static int gpio_bf_set_input_lock(struct gpio_chip *chip, unsigned int o=
ffset)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       gpio_bf_set_input(chip, offset);
> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +static int gpio_bf_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u64 value;
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       value =3D readq(gs->dc_base + GPIO_PIN_STATE);

No spinlock here?

> +
> +       return (value >> offset) & 1;
> +}
> +
> +static void gpio_bf_set(struct gpio_chip *chip, unsigned int offset, int=
 value)
> +{
> +       u64 data;
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       data =3D readq(gs->dc_base + GPIO_PIN_STATE);
> +
> +       if (value)
> +               data |=3D BIT(offset);
> +       else
> +               data &=3D ~BIT(offset);
> +       writeq(data, gs->dc_base + GPIO_PIN_STATE);
> +       spin_unlock(&gs->lock);
> +}
> +
> +static int gpiodrv_probe(struct platform_device *pdev)
> +{
> +       struct gpio_state *gs;
> +       struct device *dev =3D &pdev->dev;
> +       struct gpio_chip *gc;
> +       struct resource *dc_res;
> +       int ret;
> +
> +       dc_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);

No need to check the return value - just call platform_get_resource()
and pass the return value to devm_ioremap_resource() in the next line.
Grep for devm_ioremap_resource() and you'll see how it's used.

> +       if (!dc_res)
> +               return -EINVAL;
> +
> +       gs =3D devm_kzalloc(&pdev->dev, sizeof(struct gpio_state), GFP_KE=
RNEL);

Should be sizeof(*gs).

> +       if (!gs)
> +               return -ENOMEM;
> +
> +       gs->dc_base =3D devm_ioremap_resource(&pdev->dev, dc_res);
> +       if (!gs->dc_base)
> +               return -ENOMEM;
> +
> +       gc =3D &gs->gc;
> +       gc->direction_input =3D gpio_bf_set_input_lock;
> +       gc->get =3D gpio_bf_get;
> +       gc->direction_output =3D gpio_bf_set_output_lock;
> +       gc->set =3D gpio_bf_set;
> +       gc->label =3D dev_name(dev);
> +       gc->parent =3D &pdev->dev;
> +       gc->owner =3D THIS_MODULE;
> +       gc->base =3D 0;

Are you sure you want to enforce the base to be 0? If you want it
assigned automatically, it should be -1.

> +       gc->ngpio =3D MLXBF_GPIO_NR;
> +
> +       ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed adding memory mapped gpiochip=
\n");
> +               goto err;
> +       }
> +
> +       spin_lock_init(&gs->lock);
> +       platform_set_drvdata(pdev, gs);
> +       dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
> +       return 0;
> +
> +err:
> +       dev_err(&pdev->dev, "Probe, Failed\n");

No need for this, the device driver subsystem will log the failure.

> +       return ret;
> +}
> +
> +#ifdef CONFIG_PM
> +static int gpiodrv_suspend(struct platform_device *pdev, pm_message_t st=
ate)
> +{
> +       struct gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       gs->csave_regs.gpio_scratchpad =3D readq(gs->dc_base + GPIO_SCRAT=
CHPAD);
> +       gs->csave_regs.gpio_pad_control[0] =3D
> +               readq(gs->dc_base + GPIO_PAD_CONTROL__FIRST_WORD);
> +       gs->csave_regs.gpio_pad_control[1] =3D
> +               readq(gs->dc_base + GPIO_PAD_CONTROL_1__FIRST_WORD);
> +       gs->csave_regs.gpio_pad_control[2] =3D
> +               readq(gs->dc_base + GPIO_PAD_CONTROL_2__FIRST_WORD);
> +       gs->csave_regs.gpio_pad_control[3] =3D
> +               readq(gs->dc_base + GPIO_PAD_CONTROL_3__FIRST_WORD);
> +       gs->csave_regs.gpio_pin_dir_i =3D readq(gs->dc_base + GPIO_PIN_DI=
R_I);
> +       gs->csave_regs.gpio_pin_dir_o =3D readq(gs->dc_base + GPIO_PIN_DI=
R_O);
> +
> +       return 0;
> +}
> +
> +static int gpiodrv_resume(struct platform_device *pdev)
> +{
> +       struct gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       writeq(gs->csave_regs.gpio_scratchpad, gs->dc_base + GPIO_SCRATCH=
PAD);
> +       writeq(gs->csave_regs.gpio_pad_control[0], gs->dc_base +
> +              GPIO_PAD_CONTROL__FIRST_WORD);
> +       writeq(gs->csave_regs.gpio_pad_control[1], gs->dc_base +
> +              GPIO_PAD_CONTROL_1__FIRST_WORD);
> +       writeq(gs->csave_regs.gpio_pad_control[2], gs->dc_base +
> +              GPIO_PAD_CONTROL_2__FIRST_WORD);
> +       writeq(gs->csave_regs.gpio_pad_control[3], gs->dc_base +
> +              GPIO_PAD_CONTROL_3__FIRST_WORD);
> +       writeq(gs->csave_regs.gpio_pin_dir_i, gs->dc_base + GPIO_PIN_DIR_=
I);
> +       writeq(gs->csave_regs.gpio_pin_dir_o, gs->dc_base + GPIO_PIN_DIR_=
O);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct acpi_device_id gpiodrv_acpi_match[] =3D {
> +       { "MLNXBF02", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, gpiodrv_acpi_match);
> +
> +static struct platform_driver gpiodrv_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "gpiodrv",
> +               .acpi_match_table =3D ACPI_PTR(gpiodrv_acpi_match),
> +       },
> +       .probe    =3D gpiodrv_probe,
> +#ifdef CONFIG_PM
> +       .suspend  =3D gpiodrv_suspend,
> +       .resume   =3D gpiodrv_resume,
> +#endif
> +};
> +
> +module_platform_driver(gpiodrv_gpio_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField GPIO Driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL");
> --
> 2.1.2
>

Bart
