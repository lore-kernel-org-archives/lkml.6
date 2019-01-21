Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA61C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hTNe2iaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfAUKxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:53:05 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38319 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfAUKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:53:02 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so14521801ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QjbP/l1bpb8E64Mj8pu7c4+8MFTz50IsGVL9M1hDf94=;
        b=hTNe2iaROzaGIbTVNHWQa5l3fsYEtH/1w7D70biknANcS4skiETso01jf+327N6rN5
         aoMidn6A4tcn/jRI/YiWpD8R+Q+RefCkwPM7H1KNYTFY+EBp9jXlcZaaNN6E5XNrh/6Q
         WZBzVby5ozDS5NVxYRV31Hpd43GreoPHykH233hZqBvBGXqRpTdZnesdXiukk9F/EQhr
         hkJYkGJhFhn5P49RHfOK4/00sHEbiCeBXip2vWj8O9L9MtrrRoFEyu//BfaoZtt4Pu+d
         P+uSiBjlY2X4TfXQcxbYXKfy/HaPCfz2JLwjPb4sTXrU4+pNQEYhx+51y/N9t3hC1zbE
         8dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QjbP/l1bpb8E64Mj8pu7c4+8MFTz50IsGVL9M1hDf94=;
        b=ukMZQasbhuZaS4lR0gVMskJsIcZ0ajZBWU02rPA6mdjjdQzF/YTERDq5E8/ejFrJc/
         6V1vErJbfOZkDHx4NWcMfnlss5kraUvtJjLFFyXN+v8L0mwLR88FzY6R19LLOI0qRzws
         29qHx9yK5QPcTVznV9kZzjfkzvgbj5xkwUxPWsivWohaU3xdL0QkNGoNUTtV6cUAcHME
         wQdPGsYxkJynJZu4YVPf1PYMxXDQDZ5i6ZYrHQYrNIUtz5TxWMZd69XrlmQIahCOv3n4
         p/L8orUBWPyXA9v+eEpV8Hk3BK61jOdMThQobXQ2kCKyTdyRSCQ1V4oqDxcDE8I0x0EZ
         AQxg==
X-Gm-Message-State: AJcUukf3vP9PHBWyQaSVelNoVZHxRhDtrIOivrClgSSatrSv+vIl5A/5
        ZfTGGBao4CUYZ78iZI2Fgdo9mAh4nYE/aRnRlKtLsA==
X-Google-Smtp-Source: ALg8bN61FZ8TqfHJ57K6dUfe3X8uUbUi+1IyKEqN/EidNUwxUlLg536+dK4VEvBWgPp0e4Q0I6EpBp72MMpRDoO1zGo=
X-Received: by 2002:a24:f909:: with SMTP id l9mr15617474ith.74.1548067981302;
 Mon, 21 Jan 2019 02:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws>
In-Reply-To: <20190119090318.GB187380@dtor-ws>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Jan 2019 11:52:50 +0100
Message-ID: <CAMRc=MfOWWK+nfYLt03EFe-ekTnbDr6oCoqd=n3dpMjz1sELMQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 19 sty 2019 o 10:03 Dmitry Torokhov <dmitry.torokhov@gmail.com>
napisa=C5=82(a):
>
> Hi Bartosz,
>
> On Fri, Jan 18, 2019 at 02:42:43PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add support for the push- and slide-button events for max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/input/misc/Kconfig          |   9 ++
> >  drivers/input/misc/Makefile         |   1 +
> >  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
> >  3 files changed, 145 insertions(+)
> >  create mode 100644 drivers/input/misc/max77650-onkey.c
> >
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index ca59a2be9bc5..bb9c45c1269e 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -180,6 +180,15 @@ config INPUT_M68K_BEEP
> >       tristate "M68k Beeper support"
> >       depends on M68K
> >
> > +config INPUT_MAX77650_ONKEY
> > +     tristate "Maxim MAX77650 ONKEY support"
> > +     depends on MFD_MAX77650
> > +     help
> > +       Support the ONKEY of the MAX77650 PMIC as an input device.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called max77650-onkey.
> > +
> >  config INPUT_MAX77693_HAPTIC
> >       tristate "MAXIM MAX77693/MAX77843 haptic controller support"
> >       depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 9d0f9d1ff68f..5bd53590ce60 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)   +=3D ixp4xx-beepe=
r.o
> >  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)   +=3D keyspan_remote.o
> >  obj-$(CONFIG_INPUT_KXTJ9)            +=3D kxtj9.o
> >  obj-$(CONFIG_INPUT_M68K_BEEP)                +=3D m68kspkr.o
> > +obj-$(CONFIG_INPUT_MAX77650_ONKEY)   +=3D max77650-onkey.o
> >  obj-$(CONFIG_INPUT_MAX77693_HAPTIC)  +=3D max77693-haptic.o
> >  obj-$(CONFIG_INPUT_MAX8925_ONKEY)    +=3D max8925_onkey.o
> >  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)   +=3D max8997_haptic.o
> > diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/m=
ax77650-onkey.c
> > new file mode 100644
> > index 000000000000..cc7e83f589cd
> > --- /dev/null
> > +++ b/drivers/input/misc/max77650-onkey.c
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + *
> > + * ONKEY driver for MAXIM 77650/77651 charger/power-supply.
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/max77650.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define MAX77650_ONKEY_MODE_MASK     BIT(3)
> > +#define MAX77650_ONKEY_MODE_PUSH     0x00
> > +#define MAX77650_ONKEY_MODE_SLIDE    BIT(3)
> > +
> > +struct max77650_onkey {
> > +     struct input_dev *input;
> > +     unsigned int code;
> > +};
> > +
> > +static irqreturn_t
> > +max77650_onkey_report(struct max77650_onkey *onkey, int value)
> > +{
> > +     input_report_key(onkey->input, onkey->code, value);
> > +     input_sync(onkey->input);
> > +
> > +     return IRQ_HANDLED;
>
> It is weird that report function returns irqreturn_t. I'd simply moved
> input_report_key()/input_sync() into real IRQ handlers.
>
> > +}
> > +
> > +static irqreturn_t max77650_onkey_falling(int irq, void *data)
> > +{
> > +     struct max77650_onkey *onkey =3D data;
> > +
> > +     return max77650_onkey_report(onkey, 0);
> > +}
> > +
> > +static irqreturn_t max77650_onkey_rising(int irq, void *data)
> > +{
> > +     struct max77650_onkey *onkey =3D data;
> > +
> > +     return max77650_onkey_report(onkey, 1);
> > +}
> > +
> > +static int max77650_onkey_probe(struct platform_device *pdev)
> > +{
> > +     struct regmap_irq_chip_data *irq_data;
> > +     struct max77650_onkey *onkey;
> > +     struct device *dev, *parent;
> > +     int irq_r, irq_f, rv, mode;
>
> Please call "rv" "error".
>
> > +     struct i2c_client *i2c;
> > +     const char *mode_prop;
> > +     struct regmap *map;
> > +
> > +     dev =3D &pdev->dev;
> > +     parent =3D dev->parent;
> > +     i2c =3D to_i2c_client(parent);
> > +     irq_data =3D i2c_get_clientdata(i2c);
> > +
> > +     map =3D dev_get_regmap(parent, NULL);
> > +     if (!map)
> > +             return -ENODEV;
> > +
> > +     onkey =3D devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
> > +     if (!onkey)
> > +             return -ENOMEM;
> > +
> > +     rv =3D device_property_read_u32(dev, "linux,code", &onkey->code);
> > +     if (rv)
> > +             onkey->code =3D KEY_POWER;
> > +
> > +     rv =3D device_property_read_string(dev, "maxim,onkey-mode", &mode=
_prop);
> > +     if (rv)
> > +             mode_prop =3D "push";
> > +
> > +     if (strcmp(mode_prop, "push") =3D=3D 0)
> > +             mode =3D MAX77650_ONKEY_MODE_PUSH;
> > +     else if (strcmp(mode_prop, "slide") =3D=3D 0)
> > +             mode =3D MAX77650_ONKEY_MODE_SLIDE;
> > +     else
> > +             return -EINVAL;
> > +
> > +     rv =3D regmap_update_bits(map, MAX77650_REG_CNFG_GLBL,
> > +                             MAX77650_ONKEY_MODE_MASK, mode);
> > +     if (rv)
> > +             return rv;
> > +
> > +     irq_f =3D regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> > +     if (irq_f <=3D 0)
> > +             return -EINVAL;
> > +
> > +     irq_r =3D regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> > +     if (irq_r <=3D 0)
> > +             return -EINVAL;
>
> Ugh, it would be better if you handled IRQ mapping in the MFD piece and
> passed it as resources of platform device. Then you'd simply call
> platform_get_irq() here and did not have to reach into parent device for
> "irq_dara".
>
> > +
> > +     onkey->input =3D devm_input_allocate_device(dev);
> > +     if (!onkey->input)
> > +             return -ENOMEM;
> > +
> > +     onkey->input->name =3D "max77650_onkey";
> > +     onkey->input->phys =3D "max77650_onkey/input0";
> > +     onkey->input->id.bustype =3D BUS_I2C;
> > +     onkey->input->dev.parent =3D dev;
>
> Not needed since devm_input_allocate_device sets parent for you.
>
> > +     input_set_capability(onkey->input, EV_KEY, onkey->code);
> > +
> > +     rv =3D devm_request_threaded_irq(dev, irq_f, NULL,
>
> Why threaded interrupt with only hard interrupt handler? If parent
> interrupt is threaded use "any_context_irq" here.
>

Hi Dmitry,

actually it's the other way around. Take a look at the function
prototype for  devm_request_threaded_irq()[1].

The third parameter is the hard-irq handler (NULL in my patch), the
fourth is the thread function. Actually even if I did what you're
saying - it would never work as this is a nested irq for which the
hard-irq handler is never called.

For the rest: I'll fix it in v2.

Best regards,
Bartosz Golaszewski

[1] https://elixir.bootlin.com/linux/latest/source/kernel/irq/devres.c#L52

> > +                                    max77650_onkey_falling,
> > +                                    IRQF_ONESHOT, "onkey-down", onkey)=
;
>
> Why do you need oneshot with interrupt that is essentially not threaded?
>
> > +     if (rv)
> > +             return rv;
> > +
> > +     rv =3D devm_request_threaded_irq(dev, irq_r, NULL,
> > +                                    max77650_onkey_rising,
> > +                                    IRQF_ONESHOT, "onkey-up", onkey);
> > +     if (rv)
> > +             return rv;
> > +
> > +     return input_register_device(onkey->input);
> > +}
> > +
> > +static struct platform_driver max77650_onkey_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "max77650-onkey",
> > +     },
> > +     .probe =3D max77650_onkey_probe,
> > +};
> > +module_platform_driver(max77650_onkey_driver);
> > +
> > +MODULE_DESCRIPTION("MAXIM 77650/77651 ONKEY driver");
> > +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> > +MODULE_LICENSE("GPL");
>
> SPDX header say GPL-2.0 so please "GPL v2" here as "GPL" means v2 and
> later.
>
> Thanks.
>
> --
> Dmitry
