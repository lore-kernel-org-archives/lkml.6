Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ECB21916
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ScF44QXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391489AbfBOIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:48:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42787 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391453AbfBOIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:48:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id i5so15265053oto.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 00:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SHTHwk/rmxrdCRZ7nLB3woNxFQ4B2oI1AXAnjQe2HZ4=;
        b=ScF44QXz+BNTJd/paHd20kw0TjSCXXzWgXUZKgW7BN47DOLYuelnahJFO8EN/beYqN
         Ic/eXfLJCBJPZ843DjTCoydGlZ1qwVmBLQJEsx3IAkD0qhYQo91cC4bpq/Z+2FnE4kcE
         YWxeWIQWBzXKNjSM/GOKokz/7xac5qlfiHcLZxZzMvJ2k/mFnYzCfOB4q4pSA9qg7T8N
         nyXh4iolP2x1xzoxzLu8JBW9oaqfa/oIEPMyhvZ8DUpR0bPteSf+nBCY8mstOOD3LNRn
         7tR1LOGMcdZwjo1hEDsS/F3u9ABZ4P8Ysj968urF11+iMN1Z1kE2MF3MUtuflMWeUqgP
         N9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHTHwk/rmxrdCRZ7nLB3woNxFQ4B2oI1AXAnjQe2HZ4=;
        b=aSFhtCMvKDef0N8KtZTcQiHqBu0vkbjrleu6GG9Uf0stS+SNseqxTx8JNXLM6Ze9dq
         q+zvGwZGwusRRZ58u0E766wnxd5itDBhxjAauhCuBJGZWSKPIKkicaQj3yJ1nL2KVc2l
         kt56tzMzZEmtSTDDqhRYXflL4Cw3mRfn3cB/hQ0uq8HDtnRsarmDchiXWFr/V8a3w2vA
         4c5n+cQ3PCe4Dmr0uDAfTOhPR+c7IV/NK3W74QNgV7rRyal43G0LG4EmqinZOXD9fRJH
         yKnUFpebnfPr/6mIc8H24kb70HVrMHQvL+hYeHXGbB7HOP+qE2dnvDzJ7KB1hZoE5Uta
         yDDg==
X-Gm-Message-State: AHQUAuYLIZOSwCup43qyffegW0M1XT/yuFLQWqaFJnSZxk45xO9xT7Zi
        De3VdOwjlUD2xZiUbX69xZKAkiiTuunAusb8EVr0Gw==
X-Google-Smtp-Source: AHgI3IZ7Q9x0uw30ExXvZINysYrSfM7ExUvMVY0kbLlrYtrOpIOrIrkNLfsBideC3GiG2wDDhs/6toLjTxkvglM6/n8=
X-Received: by 2002:a05:6830:10c1:: with SMTP id z1mr5287914oto.252.1550220515719;
 Fri, 15 Feb 2019 00:48:35 -0800 (PST)
MIME-Version: 1.0
References: <db046221591c037713a7e6994798c3b01e1fca20.1550178875.git.sramani@mellanox.com>
In-Reply-To: <db046221591c037713a7e6994798c3b01e1fca20.1550178875.git.sramani@mellanox.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 15 Feb 2019 09:48:24 +0100
Message-ID: <CAMpxmJXg69ej_NcBoeW805G_5VDx7a-rMmVtQneXK2tL8i9ebw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: add driver for Mellanox BlueField GPIO controller
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 14 lut 2019 o 22:30 Shravan Kumar Ramani <sramani@mellanox.com>
napisa=C5=82(a):
>
> This patch adds support for the GPIO controller used by Mellanox
> BlueField SOCs.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  drivers/gpio/Kconfig      |   7 ++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-mlxbf.c | 287 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 295 insertions(+)
>  create mode 100644 drivers/gpio/gpio-mlxbf.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b5a2845..2bebe92 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1292,6 +1292,13 @@ config GPIO_MERRIFIELD
>         help
>           Say Y here to support Intel Merrifield GPIO.
>
> +config GPIO_MLXBF
> +       tristate "Mellanox BlueField SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
> +       select GPIO_GENERIC

You're not really depending on it.

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
> index 0000000..e5c50db
> --- /dev/null
> +++ b/drivers/gpio/gpio-mlxbf.c
> @@ -0,0 +1,287 @@
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
> +       struct list_head node;

Why do you need that? You're not using it anywhere AFAICT.

> +       struct platform_device *pdev;

You're not using this either.

> +
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
> +/* GPIO driver set input pins */
> +static int gpio_bf_set_input(struct gpio_chip *chip, unsigned int offset=
)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       if (offset > MLXBF_GPIO_NR - 1) {
> +               dev_err(chip->parent, "gpio input pins: Invalid offset %d=
\n",
> +                       offset);
> +               return -EINVAL;
> +       }

You don't need that, the subsystem makes sure this doesn't happen.
Same elsewhere.

> +
> +       out =3D readq(gs->dc_base + GPIO_PIN_DIR_O);
> +       in =3D readq(gs->dc_base + GPIO_PIN_DIR_I);
> +
> +       writeq(out & ~BIT(offset), gs->dc_base + GPIO_PIN_DIR_O);
> +       writeq(in | BIT(offset), gs->dc_base + GPIO_PIN_DIR_I);
> +

If you used the mmio regmap in this driver you could avoid both the
locking (regmap uses a spinlock if fast_io is set to true) and manual
bit updating here. You would do something like:
regmap_update_bits(map, gs->dc_base + GPIO_PIN_DIR_O, out &
BIT(offset), ~BIT(offset)).

> +       return 0;
> +}
> +
> +/* GPIO driver set output pins */
> +static int gpio_bf_set_output(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +       u64 in;
> +       u64 out;
> +
> +       if (offset > MLXBF_GPIO_NR - 1) {
> +               dev_err(chip->parent, "gpio output pins: Invalid offset %=
d\n",
> +                       offset);
> +               return -EINVAL;
> +       }
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
> +/* GPIO driver output direction */
> +static int gpio_bf_set_output_lock(struct gpio_chip *chip,
> +                                  unsigned int offset, int value)
> +{
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       spin_lock(&gs->lock);
> +       gpio_bf_set_output(chip, offset);
> +       spin_unlock(&gs->lock);
> +
> +       return 0;
> +}
> +
> +/* GPIO driver input direction */
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
> +/* GPIO driver read routine. */
> +static int gpio_bf_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u64 value;
> +       struct gpio_state *gs =3D gpiochip_get_data(chip);
> +
> +       value =3D readq(gs->dc_base + GPIO_PIN_STATE);
> +
> +       return (value >> offset) & 1;
> +}
> +
> +/* GPIO driver write routine. */
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
> +/* GPIO driver initialization routine. */

These comments are obsolete to me. Everyone knows that probe, set,
get, output and input functions do. It's clear from their names.

> +static int gpiodrv_probe(struct platform_device *pdev)
> +{
> +       struct gpio_state *gs;
> +       struct device *dev =3D &pdev->dev;
> +       struct gpio_chip *gc;
> +       struct resource *dc_res;
> +       int ret;
> +
> +       dc_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!dc_res)
> +               return -EINVAL;
> +
> +       if (devm_request_mem_region(&pdev->dev, dc_res->start,
> +                                   resource_size(dc_res), "gpiodrv") =3D=
=3D NULL)
> +               return -EBUSY;
> +

Please use devm_ioremap_resource() here to save some code.

> +       gs =3D devm_kzalloc(&pdev->dev, sizeof(struct gpio_state), GFP_KE=
RNEL);
> +       if (!gs)
> +               return -ENOMEM;
> +
> +       gs->dc_base =3D devm_ioremap(&pdev->dev, dc_res->start,
> +                                  resource_size(dc_res));
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
> +       gc->ngpio =3D MLXBF_GPIO_NR;
> +
> +       ret =3D gpiochip_add_data(&gs->gc, gs);

Why not the resource managed version?

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
> +       return ret;
> +}
> +
> +#ifdef CONFIG_PM
> +/* GPIO driver suspend routine. */
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
> +/* GPIO driver resume routine. */
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
> +/* GPIO driver exit routine. */
> +static int gpiodrv_remove(struct platform_device *pdev)
> +{
> +       struct gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       gpiochip_remove(&gs->gc);
> +       iounmap(gs->dc_base);
> +
> +       return 0;
> +}

The entire function is unnecessary - use devm_ where possible: both
when mapping memory and adding the gpio chip.

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
> +       .remove   =3D gpiodrv_remove,
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

Best regards,
Bartosz Golaszewski
