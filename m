Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE515C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C61521473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x5MasOaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfA2Njl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:39:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50259 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfA2Njl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:39:41 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so4532367iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ciQrQo5dneEBU578U/ZVBeH2EFuzFoYU65pfqZEyink=;
        b=x5MasOaUZ23St6PiWPCR1yGNvagl2ElNpOzj9FvYj7RMK8A54Kdm9z0cJHXgR/oJxV
         ZKca7rPK5hYrP70+6xSwGEpJNVCw5vuMPuCrFrAxOuM17tXzBUdtPclqQ5JD5y2r3Hdx
         7PRs+/ZBHJg72U09+rakTOM0CYDbixt7J2fmTa7//TW/84lfjGpIAxVTob89+HnRT1jj
         Vo6rmi9fV4TtkoLxoaxJ+epMC9SmAqp30X6hgBtUomBomOw69KuXB3HCF01DROEeT+ds
         JqyA5kTKSo8rpHGrI+LgkKv0UyVmzVtsw+bdZ8iuAoY/IAI2BuSw0KN9+3oFkQXiCzKJ
         Ap2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ciQrQo5dneEBU578U/ZVBeH2EFuzFoYU65pfqZEyink=;
        b=gsxlLzOCCDiiYbzV7n43W+2s0xxPUSaGYSeDnuEinFE9NkRRA5/zE0ji8v21jnibwD
         M89MmKnToyAE5A7OeCMoLF4ToRWhxuhqkbXXj82YpMk+bZp9GCvHYTIo8f6VwFmPC00S
         7DMplkJPnniTIdVmarbCIjJzd5cdgRloa1Blf9vEHSa4GP+aL6/gqmhYIqdieZwqrpmu
         M76012KMzjhPx6M3uiFvN4hdE6/ztztKyRz2vYt054OEv482ZIgZCg77zD4wU7JRm0pH
         9rJRh18e3QZaGkGaN3X5Xm5S4lwz0GPl13v/CRkXqSgtW60F9HivfrQuZl5eM3CyC+8E
         wQjA==
X-Gm-Message-State: AJcUukcVu3qObfSt9IBIpFj208/e5mKsqv5Wg0bk52wJHsJ9Qn6YsPdT
        dhXER3GwhQL428WMzGbT99jCbaC4dVwX6EoS+E+1gw==
X-Google-Smtp-Source: ALg8bN7gSvz3O9y1/JuT9V4b59HEIuEMjocMl7O7LHG+8hKGigAyKbmzyvlve2+XeMUf7lZ1Ymj1EZoDe4jgpH70CVY=
X-Received: by 2002:a24:f909:: with SMTP id l9mr12170846ith.74.1548769178857;
 Tue, 29 Jan 2019 05:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-3-brgl@bgdev.pl>
In-Reply-To: <20190129133545.1931-3-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Jan 2019 14:39:27 +0100
Message-ID: <CAMRc=Md4iTPi_i3EO5QT2SW1S2__8mMe22+9tcO7VUE2_hPNiw@mail.gmail.com>
Subject: Re: [PATCH] gpio fixup domain
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 29 sty 2019 o 14:35 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi |   4 +
>  drivers/gpio/gpio-max77650.c              | 138 +++++++++++++++++++++-
>  2 files changed, 136 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dt=
s/am335x-bone-common.dtsi
> index 62f7f2ac191c..320b4c21fdf3 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -276,6 +276,10 @@
>
>                         gpio-controller;
>                         #gpio-cells =3D <2>;
> +
> +                       interrupt-parent =3D <&pmic>;
> +                       interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +                       interrupt-names =3D "GPI";
>                 };
>
>                 leds {
> diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
> index 3f03f4e8956c..03a5a2ed07f8 100644
> --- a/drivers/gpio/gpio-max77650.c
> +++ b/drivers/gpio/gpio-max77650.c
> @@ -9,6 +9,7 @@
>  #include <linux/i2c.h>
>  #include <linux/mfd/max77650.h>
>  #include <linux/module.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>
> @@ -34,7 +35,8 @@
>  struct max77650_gpio_chip {
>         struct regmap *map;
>         struct gpio_chip gc;
> -       int irq;
> +       struct fwnode_handle *fwnode;
> +       struct irq_domain *domain;
>  };
>
>  static int max77650_gpio_direction_input(struct gpio_chip *gc,
> @@ -130,20 +132,114 @@ static int max77650_gpio_set_config(struct gpio_ch=
ip *gc,
>         }
>  }
>
> +static struct irq_chip max77650_gpio_irq_chip =3D {
> +       .name =3D "max77650-gpio",
> +       .irq_ack =3D irq_chip_ack_parent,
> +       .irq_mask =3D irq_chip_mask_parent,
> +       .irq_unmask =3D irq_chip_unmask_parent,
> +       .irq_set_type =3D irq_chip_set_type_parent,
> +};
> +
> +static int max77650_gpio_irq_domain_activate(struct irq_domain *domain,
> +                                            struct irq_data *data,
> +                                            bool reserve)
> +{
> +       struct max77650_gpio_chip *chip =3D domain->host_data;
> +
> +       return gpiochip_lock_as_irq(&chip->gc, data->hwirq);
> +}
> +
> +static void max77650_gpio_irq_domain_deactivate(struct irq_domain *domai=
n,
> +                                               struct irq_data *data)
> +{
> +       struct max77650_gpio_chip *chip =3D domain->host_data;
> +
> +       return gpiochip_unlock_as_irq(&chip->gc, data->hwirq);
> +}
> +
> +static int max77650_gpio_domain_translate(struct irq_domain *domain,
> +                                         struct irq_fwspec *fwspec,
> +                                         unsigned long *hwirq,
> +                                         unsigned int *type)
> +{
> +       struct max77650_gpio_chip *chip =3D domain->host_data;
> +
> +       if (fwspec->param_count !=3D 2 || fwspec->param[0] >=3D chip->gc.=
ngpio)
> +               return -EINVAL;
> +
> +       *hwirq =3D fwspec->param[0];
> +       *type =3D fwspec->param[1];
> +
> +       return 0;
> +}
> +
> +static int max77650_gpio_domain_alloc(struct irq_domain *domain,
> +                                     unsigned int virq,
> +                                     unsigned int nr_irqs, void *data)
> +{
> +       struct max77650_gpio_chip *chip =3D domain->host_data;
> +       struct irq_fwspec *fwspec =3D data;
> +       struct irq_fwspec parent_fwspec;
> +       irq_hw_number_t hwirq;
> +       unsigned int type;
> +       int ret;
> +
> +       if (nr_irqs !=3D 1)
> +               return -EINVAL;
> +
> +       ret =3D max77650_gpio_domain_translate(domain, fwspec, &hwirq, &t=
ype);
> +       if (ret)
> +               return ret;
> +
> +       irq_domain_set_info(domain, virq, hwirq,
> +                           &max77650_gpio_irq_chip, chip,
> +                           handle_level_irq, NULL, NULL);
> +
> +       parent_fwspec.fwnode =3D domain->parent->fwnode;
> +       parent_fwspec.param_count =3D 4;
> +       parent_fwspec.param[0] =3D 0;
> +       parent_fwspec.param[1] =3D hwirq;
> +       parent_fwspec.param[2] =3D 0;
> +       parent_fwspec.param[3] =3D fwspec->param[1];
> +
> +       return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> +                                           &parent_fwspec);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops max77650_gpio_irq_domain_ops =3D {
> +       .activate =3D max77650_gpio_irq_domain_activate,
> +       .deactivate =3D max77650_gpio_irq_domain_deactivate,
> +       .alloc =3D max77650_gpio_domain_alloc,
> +       .free =3D irq_domain_free_irqs_common,
> +       .translate =3D max77650_gpio_domain_translate,
> +};
> +
>  static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offse=
t)
>  {
>         struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       struct irq_fwspec fwspec;
> +
> +       fwspec.fwnode =3D chip->fwnode;
> +       fwspec.param_count =3D 2;
> +       fwspec.param[0] =3D 0;
> +       fwspec.param[1] =3D IRQ_TYPE_LEVEL_LOW;
>
> -       return chip->irq;
> +       return irq_create_fwspec_mapping(&fwspec);
>  }
>
>  static int max77650_gpio_probe(struct platform_device *pdev)
>  {
> +       struct device_node *of_node, *parent_node;
> +       struct irq_domain *parent_domain;
>         struct max77650_gpio_chip *chip;
>         struct device *dev, *parent;
>         struct i2c_client *i2c;
> +       int rv;
>
>         dev =3D &pdev->dev;
> +       of_node =3D dev->of_node;
>         parent =3D dev->parent;
>         i2c =3D to_i2c_client(parent);
>
> @@ -151,13 +247,29 @@ static int max77650_gpio_probe(struct platform_devi=
ce *pdev)
>         if (!chip)
>                 return -ENOMEM;
>
> +       chip->fwnode =3D dev->fwnode;
> +       platform_set_drvdata(pdev, chip);
> +
>         chip->map =3D dev_get_regmap(parent, NULL);
>         if (!chip->map)
>                 return -ENODEV;
>
> -       chip->irq =3D platform_get_irq_byname(pdev, "GPI");
> -       if (chip->irq < 0)
> -               return chip->irq;
> +       parent_node =3D of_irq_find_parent(of_node);
> +       if (!parent_node)
> +               return -ENXIO;
> +
> +       parent_domain =3D irq_find_host(parent_node);
> +       of_node_put(parent_node);
> +       if (!parent_domain)
> +               return -ENXIO;
> +
> +       chip->fwnode =3D of_node_to_fwnode(of_node);
> +       chip->domain =3D irq_domain_create_hierarchy(parent_domain, 0, 1,
> +                                               chip->fwnode,
> +                                               &max77650_gpio_irq_domain=
_ops,
> +                                               chip);
> +       if (!chip->domain)
> +               return -ENODEV;
>
>         chip->gc.base =3D -1;
>         chip->gc.ngpio =3D 1;
> @@ -174,7 +286,20 @@ static int max77650_gpio_probe(struct platform_devic=
e *pdev)
>         chip->gc.set_config =3D max77650_gpio_set_config;
>         chip->gc.to_irq =3D max77650_gpio_to_irq;
>
> -       return devm_gpiochip_add_data(dev, &chip->gc, chip);
> +       rv =3D devm_gpiochip_add_data(dev, &chip->gc, chip);
> +       if (rv)
> +               irq_domain_remove(chip->domain);
> +
> +       return rv;
> +}
> +
> +static int max77650_gpio_remove(struct platform_device *pdev)
> +{
> +       struct max77650_gpio_chip *chip =3D platform_get_drvdata(pdev);
> +
> +       irq_domain_remove(chip->domain);
> +
> +       return 0;
>  }
>
>  static struct platform_driver max77650_gpio_driver =3D {
> @@ -182,6 +307,7 @@ static struct platform_driver max77650_gpio_driver =
=3D {
>                 .name =3D "max77650-gpio",
>         },
>         .probe =3D max77650_gpio_probe,
> +       .remove =3D max77650_gpio_remove,
>  };
>  module_platform_driver(max77650_gpio_driver);
>
> --
> 2.20.1
>

Please ignore this one, it got lost on the way. It was just experimentation=
.

Bart
