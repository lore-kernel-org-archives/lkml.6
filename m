Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE2C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D5217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vm/Rftpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfBBOkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:40:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36823 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfBBOkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:07 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so14372508itj.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 06:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NGMZsZ1oErJsW92nY2QHRjIPpK2YCPhH+j5wx1Sq/mc=;
        b=vm/RftpqyDP+FDdcdd/T5+/Hml4NowjgWcbdFJqKVNdhFrYJvn9HxR9ueoGJht0Y3N
         cfUt21A0pygBpBHcSnOnU1Bmpszg3XgOtomrZbd7yiEKAcqwd6+LiSfaHqfuAsvQFLrd
         YiiTaCBtL8x+X4mqzggKbpNU6ImVp8haaXAi1rzIpSnqCjSfRY2Cob6O0NIkgg0fm2xX
         cszY/2wUDagXQtdq/FSUtOJb6OIdcDqF7bxJRrYeUb/q/XeEeolcMJ2Jtu+m3F0RZSkO
         fjco8JXTP3x8mR+LUbe6dnbkyl8AumGBPqVbB6aHuvUdbzLGeZtExZC9uNXVptcG+2RF
         wwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NGMZsZ1oErJsW92nY2QHRjIPpK2YCPhH+j5wx1Sq/mc=;
        b=CfDRYl+W3G1Adn015oezXcKQ95BLCFNVx5YuSBtKU7FDcMCfA6Th9QpmZ6RV6VZOeM
         EsvlfowrLMJB4Tofq6JTs/qlTGoV8M3d9oxAdsWMUEeDHcynLbtF/RC/ebkuDybkUIqb
         TfT0Ro6GLsnSy2s3qqalZA5WvA5Q33qcFobMjEgjlbJCOuEjvSewFWcPOPeC40w4A2wW
         T3wMH4pKdGC1PzrJP0KAMCY2f+boKKiEYtpkTrY8jgE30Eyu7fHXjhyk8/jCGyquMI5o
         xKZZTiSrKSMrxQaJhyEgeA+inIVttz+UpfzjK/f/36dC5bR/CPInOp0QHwaXSscGEI2G
         V31w==
X-Gm-Message-State: AJcUukcAIujCXVvxgcvxB/XIjH3LAtFUTVZfEpRsfUQzDBE5iGQEGpM+
        nE0/+egwv/KYZigI+scMM2DMzOaVjJZlYP1zpodHxA==
X-Google-Smtp-Source: ALg8bN4kqyXoRQSE5zPnQ15SpXAoAl9MwVHx3+xMDwSdxQ1cUbkTRQeCvpRvM0mpv15ySo5cdG4fFq86d2Md/YEZfW4=
X-Received: by 2002:a02:6f4d:: with SMTP id b13mr26305891jae.57.1549118405844;
 Sat, 02 Feb 2019 06:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-10-brgl@bgdev.pl>
 <78b99abb-f367-1533-0690-8da26957a664@gmail.com> <d86adc21-627f-0350-72e0-f6f10b023413@ti.com>
In-Reply-To: <d86adc21-627f-0350-72e0-f6f10b023413@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 2 Feb 2019 15:39:55 +0100
Message-ID: <CAMRc=McK0oc2-Cve5x6k+3TOJDF9qSxaCr9ix3=i=7Z2eDw2XQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

pt., 1 lut 2019 o 21:15 Dan Murphy <dmurphy@ti.com> napisa=C5=82(a):
>
> Hi
>
> On 2/1/19 1:45 PM, Jacek Anaszewski wrote:
> > Hi Bartosz,
> >
> > Thanks for the update.
> >
> > On 2/1/19 10:47 AM, Bartosz Golaszewski wrote:
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> This adds basic support for LEDs for the max77650 PMIC. The device has
> >> three current sinks for driving LEDs.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >> ---
> >>   drivers/leds/Kconfig         |   6 ++
> >>   drivers/leds/Makefile        |   1 +
> >>   drivers/leds/leds-max77650.c | 147 +++++++++++++++++++++++++++++++++=
++
> >>   3 files changed, 154 insertions(+)
> >>   create mode 100644 drivers/leds/leds-max77650.c
> >>
> >> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> >> index a72f97fca57b..6e7a8f51eccc 100644
> >> --- a/drivers/leds/Kconfig
> >> +++ b/drivers/leds/Kconfig
> >> @@ -608,6 +608,12 @@ config LEDS_TLC591XX
> >>         This option enables support for Texas Instruments TLC59108
> >>         and TLC59116 LED controllers.
> >>   +config LEDS_MAX77650
> >> +    tristate "LED support for Maxim MAX77650 PMIC"
> >> +    depends on MFD_MAX77650
> >> +    help
> >> +      LEDs driver for MAX77650 family of PMICs from Maxim Integrated.=
"
> >> +
> >>   config LEDS_MAX77693
> >>       tristate "LED support for MAX77693 Flash"
> >>       depends on LEDS_CLASS_FLASH
> >> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> >> index 4c1b0054f379..f48b2404dbb7 100644
> >> --- a/drivers/leds/Makefile
> >> +++ b/drivers/leds/Makefile
> >> @@ -61,6 +61,7 @@ obj-$(CONFIG_LEDS_MC13783)        +=3D leds-mc13783.=
o
> >>   obj-$(CONFIG_LEDS_NS2)            +=3D leds-ns2.o
> >>   obj-$(CONFIG_LEDS_NETXBIG)        +=3D leds-netxbig.o
> >>   obj-$(CONFIG_LEDS_ASIC3)        +=3D leds-asic3.o
> >> +obj-$(CONFIG_LEDS_MAX77650)        +=3D leds-max77650.o
> >>   obj-$(CONFIG_LEDS_MAX77693)        +=3D leds-max77693.o
> >>   obj-$(CONFIG_LEDS_MAX8997)        +=3D leds-max8997.o
> >>   obj-$(CONFIG_LEDS_LM355x)        +=3D leds-lm355x.o
> >> diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650=
.c
> >> new file mode 100644
> >> index 000000000000..6b74ce9cac12
> >> --- /dev/null
> >> +++ b/drivers/leds/leds-max77650.c
> >> @@ -0,0 +1,147 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +//
> >> +// Copyright (C) 2018 BayLibre SAS
> >> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >> +//
> >> +// LED driver for MAXIM 77650/77651 charger/power-supply.
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/leds.h>
> >> +#include <linux/mfd/max77650.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +#define MAX77650_LED_NUM_LEDS        3
> >> +
> >> +#define MAX77650_LED_A_BASE        0x40
> >> +#define MAX77650_LED_B_BASE        0x43
> >> +
> >> +#define MAX77650_LED_BR_MASK        GENMASK(4, 0)
> >> +#define MAX77650_LED_EN_MASK        GENMASK(7, 6)
> >> +
> >> +#define MAX77650_LED_MAX_BRIGHTNESS    MAX77650_LED_BR_MASK
> >> +
> >> +/* Enable EN_LED_MSTR. */
> >> +#define MAX77650_LED_TOP_DEFAULT    BIT(0)
> >> +
> >> +#define MAX77650_LED_ENABLE        GENMASK(7, 6)
> >> +#define MAX77650_LED_DISABLE        0x00
> >> +
> >> +#define MAX77650_LED_A_DEFAULT        MAX77650_LED_DISABLE
> >> +/* 100% on duty */
> >> +#define MAX77650_LED_B_DEFAULT        GENMASK(3, 0)
> >> +
> >> +struct max77650_led {
> >> +    struct led_classdev cdev;
> >> +    struct regmap *map;
> >> +    unsigned int regA;
> >> +    unsigned int regB;
>
> Please don't use camel case.
>

Sorry, but this is pointless nitpicking. The registers are referred to
in the manual as LED[012]_A and LED[012]_B so these variable names
reflect that. The difference between ThisKindOfCamelCase and regA/regB
is obvious. It's much more readable than for example rega or reg_a. I
also used the same approach in the regulator module and there were no
complaints.

> >> +};
> >> +
> >> +static struct max77650_led *max77650_to_led(struct led_classdev *cdev=
)
> >> +{
> >> +    return container_of(cdev, struct max77650_led, cdev);
> >> +}
> >> +
> >> +static int max77650_led_brightness_set(struct led_classdev *cdev,
> >> +                       enum led_brightness brightness)
> >> +{
> >> +    struct max77650_led *led =3D max77650_to_led(cdev);
> >> +    int val, mask;
> >> +
>
> The register value and bits are only 8 bit why an int?
>

Because regmap_update_bits() deals with 32-bit integers. There's no
hurt and it's less confusing.

> >> +    mask =3D MAX77650_LED_BR_MASK | MAX77650_LED_EN_MASK;
> >> +
> >> +    if (brightness =3D=3D LED_OFF)
> >> +        val =3D MAX77650_LED_DISABLE;
> >> +    else
> >> +        val =3D MAX77650_LED_ENABLE | brightness;
> >> +
> >> +    return regmap_update_bits(led->map, led->regA, mask, val);
> >> +}
> >> +
> >> +static int max77650_led_probe(struct platform_device *pdev)
> >> +{
> >> +    struct device_node *of_node, *child;
> >> +    struct max77650_led *leds, *led;
> >> +    struct device *parent;
> >> +    struct device *dev;
> >> +    struct regmap *map;
> >> +    const char *label;
> >> +    int rv, num_leds;
> >> +    u32 reg;
> >> +
> >> +    dev =3D &pdev->dev;
> >> +    parent =3D dev->parent;
> >> +    of_node =3D dev->of_node;
> >> +
> >> +    if (!of_node)
> >> +        return -ENODEV;
> >> +
> >> +    leds =3D devm_kcalloc(dev, sizeof(*leds),
> >> +                MAX77650_LED_NUM_LEDS, GFP_KERNEL);
> >> +    if (!leds)
> >> +        return -ENOMEM;
> >> +
> >> +    map =3D dev_get_regmap(dev->parent, NULL);
> >> +    if (!map)
> >> +        return -ENODEV;
> >> +
> >> +    num_leds =3D of_get_child_count(of_node);
> >> +    if (!num_leds || num_leds > MAX77650_LED_NUM_LEDS)
> >> +        return -ENODEV;
> >> +
> >> +    for_each_child_of_node(of_node, child) {
> >> +        rv =3D of_property_read_u32(child, "reg", &reg);
>
> Can we use the fwnode_property_read_u32 call here?
> And the same for all below as well?
>
>

Of course we can. But why? This is a low-power PMIC. Is there really a
chance that a non-DT system will want to use it? If so - we will be
able to convert it if needed. For now: I'd stick with of_* functions.

> >> +        if (rv || reg >=3D MAX77650_LED_NUM_LEDS)
> >> +            return -EINVAL;
> >> +
> >> +        led =3D &leds[reg];
> >> +        led->map =3D map;
> >> +        led->regA =3D MAX77650_LED_A_BASE + reg;
> >> +        led->regB =3D MAX77650_LED_B_BASE + reg;
> >> +        led->cdev.brightness_set_blocking =3D max77650_led_brightness=
_set;
> >> +        led->cdev.max_brightness =3D MAX77650_LED_MAX_BRIGHTNESS;
> >> +
> >> +        label =3D of_get_property(child, "label", NULL);
> >> +        if (!label) {
> >> +            led->cdev.name =3D "max77650::";
> >> +        } else {
> >> +            led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL,
> >> +                            "max77650:%s", label);
> >> +            if (!led->cdev.name)
> >> +                return -ENOMEM;
> >> +        }
> >> +
> >> +        of_property_read_string(child, "linux,default-trigger",
> >> +                    &led->cdev.default_trigger);
> >> +
> >> +        rv =3D devm_of_led_classdev_register(dev, child, &led->cdev);
> >> +        if (rv)
> >> +            return rv;
> >> +
> >> +        rv =3D regmap_write(map, led->regA, MAX77650_LED_A_DEFAULT);
> >> +        if (rv)
> >> +            return rv;
> >> +
> >> +        rv =3D regmap_write(map, led->regB, MAX77650_LED_B_DEFAULT);
> >> +        if (rv)
> >> +            return rv;
> >> +    }
> >> +
> >> +    return regmap_write(map,
> >> +                MAX77650_REG_CNFG_LED_TOP,
> >> +                MAX77650_LED_TOP_DEFAULT);
> >> +}
> >> +
> >> +static struct platform_driver max77650_led_driver =3D {
> >> +    .driver =3D {
> >> +        .name =3D "max77650-led",
> >> +    },
> >> +    .probe =3D max77650_led_probe,
> >> +};
> >> +module_platform_driver(max77650_led_driver);
> >> +
> >> +MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
> >> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> >> +MODULE_LICENSE("GPL v2");
> >>
> >
> > Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> >
>
>
> --
> ------------------
> Dan Murphy

Best regards,
Bartosz Golaszewski
