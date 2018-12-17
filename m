Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A283EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B862145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OarV2RXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbeLQPvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:51:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42554 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:51:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so10506713oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PnjKIRI9nO/ZKMy80vdFqw0K0YWJlvmo7GD0kULdH1Y=;
        b=OarV2RXuX3pTTG+yMZ8+UKon3naDjPx94lf1+5e+AzDhDLk5fm0UPDkYBgDSgzoRGd
         n9J+mdXIe3UFIdQPsvb5iErWb2/Fnzml3hum2frY1CM2Vkfq+xsWLZzNcy9YWYClM2DA
         PD5/IGRDO+sxvl/1jwnCeq5Je2zdZHIEdMYPTsvGm1cWk5lcudwK3OoNFVWgJ/MGyHP0
         E91/sOaiY10coaF23vOxC28FQ49V3CyXPFeTjtL2lizbl8FYHVUrcZZR4RY/4HJR2L9/
         F0818YErKX/RsxXiD1+arrFu4cHTiFlA8zJQt/lVPRH4C8jyryr/VaH6w4YoxScmoFAz
         quvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PnjKIRI9nO/ZKMy80vdFqw0K0YWJlvmo7GD0kULdH1Y=;
        b=a+LW8nczW+3B2ikqzn0N4SipHGc9h3Q2M3XbopuB7+zj1RHvktDei7P6WqfiH6ti5W
         AbvVzn2pWljnjeproC7iJeNQOsEcglZDIEil9N8h47deMT9pUSfnTPvY6I2ScwGO9saf
         lGj/UulU4i8BSUC5soFOkEUVKsqw8UN/JHh4n2F/3v6BnN9MwvCE84jmJbfH79GFrNas
         /kc4oQjJFYPTJi/L5dg8chGMoW+369je6fN7MrbX3Nv7huSJik55th8F8NZ62YVIPH/x
         p3j5Rmi4sD6O/r1buJH6uiA71dsq/Qu8IIaEYVjRFdIuLtQpSpuAKguj2S0p+AUNyBN+
         3EqQ==
X-Gm-Message-State: AA+aEWYlWkvqawMrA2KBrWJxVEzXTMTN4+X9fuJSzev1iiOQMYeNgJlS
        yrP+etN9/tNpRf42KO3L0eE5557G6abx9tTfzQW31A==
X-Google-Smtp-Source: AFSGD/WPXoyvlSKxNBXu0uXfAQ2ljnHqiGtGHpp48FTmPTVke+JOlhp1aDqq6JU2IderoCZJu4eEXkT41MVL0EPVuX8=
X-Received: by 2002:aca:b6c3:: with SMTP id g186mr6034817oif.289.1545061896234;
 Mon, 17 Dec 2018 07:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20181217153652.20056-1-jank@cadence.com> <20181217153652.20056-3-jank@cadence.com>
In-Reply-To: <20181217153652.20056-3-jank@cadence.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 17 Dec 2018 16:51:25 +0100
Message-ID: <CAMpxmJXrjyK3m4JwgkxwkHjSj-ugb7UzwNrYcBwYjWwj+JBNxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
To:     Jan Kotas <jank@cadence.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 gru 2018 o 16:37 Jan Kotas <jank@cadence.com> napisa=C5=82(a):
>
> This patch adds a driver for Cadence GPIO controller.
>
> It can be enabled with GPIO_CADENCE Kconfig option.
> It uses generic GPIO infrastructure and works
> as an interrupt controller.
> At the moment it only supports level sensitive irqs.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  drivers/gpio/Kconfig        |   8 ++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-cadence.c | 275 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 284 insertions(+)
>  create mode 100644 drivers/gpio/gpio-cadence.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 833a1b51c..8259f8f25 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -160,6 +160,14 @@ config GPIO_BRCMSTB
>         help
>           Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) =
SoCs.
>
> +config GPIO_CADENCE
> +       tristate "Cadence GPIO support"
> +       depends on OF_GPIO
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say yes here to enable support for Cadence GPIO controller.
> +
>  config GPIO_CLPS711X
>         tristate "CLPS711X GPIO support"
>         depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 671c4477c..5fce8634a 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_BCM_KONA)   +=3D gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BD9571MWV)   +=3D gpio-bd9571mwv.o
>  obj-$(CONFIG_GPIO_BRCMSTB)     +=3D gpio-brcmstb.o
>  obj-$(CONFIG_GPIO_BT8XX)       +=3D gpio-bt8xx.o
> +obj-$(CONFIG_GPIO_CADENCE)     +=3D gpio-cadence.o
>  obj-$(CONFIG_GPIO_CLPS711X)    +=3D gpio-clps711x.o
>  obj-$(CONFIG_GPIO_CS5535)      +=3D gpio-cs5535.o
>  obj-$(CONFIG_GPIO_CRYSTAL_COVE)        +=3D gpio-crystalcove.o
> diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
> new file mode 100644
> index 000000000..16cc9f50f
> --- /dev/null
> +++ b/drivers/gpio/gpio-cadence.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2017-2018 Cadence
> + *
> + * Authors:
> + *  Jan Kotas <jank@cadence.com>
> + *  Boris Brezillon <boris.brezillon@free-electrons.com>
> + */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define CDNS_GPIO_BYPASS_MODE          0x00
> +#define CDNS_GPIO_DIRECTION_MODE       0x04
> +#define CDNS_GPIO_OUTPUT_EN            0x08
> +#define CDNS_GPIO_OUTPUT_VALUE         0x0c
> +#define CDNS_GPIO_INPUT_VALUE          0x10
> +#define CDNS_GPIO_IRQ_MASK             0x14
> +#define CDNS_GPIO_IRQ_EN               0x18
> +#define CDNS_GPIO_IRQ_DIS              0x1c
> +#define CDNS_GPIO_IRQ_STATUS           0x20
> +#define CDNS_GPIO_IRQ_TYPE             0x24
> +#define CDNS_GPIO_IRQ_VALUE            0x28
> +#define CDNS_GPIO_IRQ_ANY_EDGE         0x2c
> +
> +struct cdns_gpio_chip {
> +       struct gpio_chip gc;
> +       struct clk *pclk;
> +       void __iomem *regs;
> +       u32 bypass_orig;
> +};
> +
> +static int cdns_gpio_request(struct gpio_chip *chip, unsigned int offset=
)
> +{
> +       struct cdns_gpio_chip *cgpio =3D gpiochip_get_data(chip);
> +
> +       iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) & ~BIT(of=
fset),
> +                 cgpio->regs + CDNS_GPIO_BYPASS_MODE);
> +
> +       return 0;
> +}
> +
> +static void cdns_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct cdns_gpio_chip *cgpio =3D gpiochip_get_data(chip);
> +
> +       iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) |
> +                 (BIT(offset) & cgpio->bypass_orig),
> +                 cgpio->regs + CDNS_GPIO_BYPASS_MODE);
> +}
> +
> +static void cdns_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct cdns_gpio_chip *cgpio =3D gpiochip_get_data(chip);
> +
> +       iowrite32(BIT(d->hwirq), cgpio->regs + CDNS_GPIO_IRQ_DIS);
> +}
> +
> +static void cdns_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct cdns_gpio_chip *cgpio =3D gpiochip_get_data(chip);
> +
> +       iowrite32(BIT(d->hwirq), cgpio->regs + CDNS_GPIO_IRQ_EN);
> +}
> +
> +static int cdns_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> +       struct cdns_gpio_chip *cgpio =3D gpiochip_get_data(chip);
> +       u32 int_value =3D ioread32(cgpio->regs + CDNS_GPIO_IRQ_VALUE);
> +       u32 int_type =3D ioread32(cgpio->regs + CDNS_GPIO_IRQ_TYPE);
> +       u32 mask =3D BIT(d->hwirq);
> +
> +       int_value &=3D ~mask;
> +       int_type &=3D ~mask;
> +
> +       /*
> +        * The GPIO controller doesn't have an ACK register.
> +        * All interrupt statuses are cleared on a status register read.
> +        * Don't support edge interrupts for now.
> +        */
> +
> +       if (type =3D=3D IRQ_TYPE_LEVEL_HIGH) {
> +               int_type |=3D mask;
> +               int_value |=3D mask;
> +       } else if (type =3D=3D IRQ_TYPE_LEVEL_LOW) {
> +               int_type |=3D mask;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       iowrite32(int_value, cgpio->regs + CDNS_GPIO_IRQ_VALUE);
> +       iowrite32(int_type, cgpio->regs + CDNS_GPIO_IRQ_TYPE);
> +
> +       return 0;
> +}
> +
> +static void cdns_gpio_irq_handler(struct irq_desc *desc)
> +{
> +       struct gpio_chip *chip =3D irq_desc_get_handler_data(desc);
> +       struct cdns_gpio_chip *cgpio =3D gpiochip_get_data(chip);
> +       struct irq_chip *irqchip =3D irq_desc_get_chip(desc);
> +       unsigned long status;
> +       int hwirq;
> +
> +       chained_irq_enter(irqchip, desc);
> +
> +       status =3D ioread32(cgpio->regs + CDNS_GPIO_IRQ_STATUS) &
> +               ~ioread32(cgpio->regs + CDNS_GPIO_IRQ_MASK);
> +
> +       for_each_set_bit(hwirq, &status, chip->ngpio)
> +               generic_handle_irq(irq_find_mapping(chip->irq.domain, hwi=
rq));
> +
> +       chained_irq_exit(irqchip, desc);
> +}
> +
> +static struct irq_chip cdns_gpio_irqchip =3D {
> +       .name           =3D "cdns-gpio",
> +       .irq_mask       =3D cdns_gpio_irq_mask,
> +       .irq_unmask     =3D cdns_gpio_irq_unmask,
> +       .irq_set_type   =3D cdns_gpio_irq_set_type
> +};
> +
> +static int cdns_gpio_probe(struct platform_device *pdev)
> +{
> +       struct cdns_gpio_chip *cgpio;
> +       struct resource *res;
> +       int ret, irq;
> +       u32 dir_prev;
> +       u32 num_gpios =3D 32;
> +
> +       cgpio =3D devm_kzalloc(&pdev->dev, sizeof(*cgpio), GFP_KERNEL);
> +       if (!cgpio)
> +               return -ENOMEM;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       cgpio->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(cgpio->regs))
> +               return PTR_ERR(cgpio->regs);
> +
> +       of_property_read_u32(pdev->dev.of_node, "ngpios", &num_gpios);
> +
> +       if (num_gpios > 32) {
> +               dev_err(&pdev->dev, "ngpios must be less or equal 32\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Set all pins as inputs by default, otherwise:
> +        * gpiochip_lock_as_irq:
> +        * tried to flag a GPIO set as output for IRQ
> +        * Generic GPIO driver stores the direction value internally,
> +        * so it needs to be changed before bgpio_init() is called.
> +        */
> +       dir_prev =3D ioread32(cgpio->regs + CDNS_GPIO_DIRECTION_MODE);
> +       iowrite32(GENMASK(num_gpios - 1, 0),
> +                 cgpio->regs + CDNS_GPIO_DIRECTION_MODE);
> +
> +       ret =3D bgpio_init(&cgpio->gc, &pdev->dev, 4,
> +                        cgpio->regs + CDNS_GPIO_INPUT_VALUE,
> +                        cgpio->regs + CDNS_GPIO_OUTPUT_VALUE,
> +                        NULL,
> +                        NULL,
> +                        cgpio->regs + CDNS_GPIO_DIRECTION_MODE,
> +                        BGPIOF_READ_OUTPUT_REG_SET);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register generic gpio, %d\=
n",
> +                       ret);
> +               goto err_revert_dir;
> +       }
> +
> +       cgpio->gc.label =3D dev_name(&pdev->dev);
> +       cgpio->gc.ngpio =3D num_gpios;
> +       cgpio->gc.parent =3D &pdev->dev;
> +       cgpio->gc.base =3D -1;
> +       cgpio->gc.owner =3D THIS_MODULE;
> +       cgpio->gc.request =3D cdns_gpio_request;
> +       cgpio->gc.free =3D cdns_gpio_free;
> +
> +       cgpio->pclk =3D devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(cgpio->pclk)) {
> +               ret =3D PTR_ERR(cgpio->pclk);
> +               dev_err(&pdev->dev,
> +                       "Failed to retrieve peripheral clock, %d\n", ret)=
;
> +               goto err_revert_dir;
> +       }
> +
> +       ret =3D clk_prepare_enable(cgpio->pclk);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "Failed to enable the peripheral clock, %d\n", re=
t);
> +               goto err_revert_dir;
> +       }
> +
> +       ret =3D devm_gpiochip_add_data(&pdev->dev, &cgpio->gc, cgpio);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "Could not register gpiochip, %d\n", =
ret);
> +               goto err_disable_clk;
> +       }
> +
> +       /*
> +        * irq_chip support
> +        */
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq >=3D 0) {
> +               ret =3D gpiochip_irqchip_add(&cgpio->gc, &cdns_gpio_irqch=
ip,
> +                                          0, handle_level_irq,
> +                                          IRQ_TYPE_NONE);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Could not add irqchip, %d\n"=
,
> +                               ret);
> +                       goto err_disable_clk;
> +               }
> +               gpiochip_set_chained_irqchip(&cgpio->gc, &cdns_gpio_irqch=
ip,
> +                                            irq, cdns_gpio_irq_handler);
> +       }
> +
> +       cgpio->bypass_orig =3D ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MO=
DE);
> +
> +       /*
> +        * Enable gpio outputs, ignored for input direction
> +        */
> +       iowrite32(GENMASK(num_gpios - 1, 0),
> +                 cgpio->regs + CDNS_GPIO_OUTPUT_EN);
> +       iowrite32(0, cgpio->regs + CDNS_GPIO_BYPASS_MODE);
> +
> +       platform_set_drvdata(pdev, cgpio);
> +       return 0;
> +
> +err_disable_clk:
> +       clk_disable_unprepare(cgpio->pclk);
> +
> +err_revert_dir:
> +       iowrite32(dir_prev, cgpio->regs + CDNS_GPIO_DIRECTION_MODE);
> +
> +       return ret;
> +}
> +
> +static int cdns_gpio_remove(struct platform_device *pdev)
> +{
> +       struct cdns_gpio_chip *cgpio =3D platform_get_drvdata(pdev);
> +
> +       iowrite32(cgpio->bypass_orig, cgpio->regs + CDNS_GPIO_BYPASS_MODE=
);
> +       clk_disable_unprepare(cgpio->pclk);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id cdns_of_ids[] =3D {
> +       { .compatible =3D "cdns,gpio-r1p02" },
> +       { /* sentinel */ },
> +};
> +
> +static struct platform_driver cdns_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "cdns-gpio",
> +               .of_match_table =3D cdns_of_ids,
> +       },
> +       .probe =3D cdns_gpio_probe,
> +       .remove =3D cdns_gpio_remove,
> +};
> +module_platform_driver(cdns_gpio_driver);
> +
> +MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
> +MODULE_DESCRIPTION("Cadence GPIO driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:cdns-gpio");
> --
> 2.15.0
>

The driver looks good but is there any particular reason not to use
regmap for register IO?

Bart
