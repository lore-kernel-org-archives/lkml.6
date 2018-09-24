Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B3ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C920208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ODiGpyWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C920208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeIXNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:36:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35872 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIXNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:36:35 -0400
Received: by mail-io1-f65.google.com with SMTP id q5-v6so16849030iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gd3VHdFGtD3SXNZ/JPuKB3ynXBovTsHcGRhQbuJNH6I=;
        b=ODiGpyWaHAx44wkl3UidfrwBYhwrYEPnE57MmrdLXi37TcsFHEEFkCD66cbwO00hJI
         z/Vh4XDF5zLPoJWXgyzrmzMx/rZyeRNClap9BrQP0COpcr2y/z2m3OTw+S0NJJ0fqi8Z
         swz91QpU2iWtz0fGyF2JqgVo5gWyqVneC7wTGahWLurM3VHCDTx5TnQtvRgbbt7utmFs
         pQX8mT3eSYzN5Mso1JY0My3TzRO1m0hahnIe55jeDvk1ob5d8hMrEw1RVoFpSh3W7Cnv
         7nN/GdTnIAZh1miBlrihMS1KugVaXlq9V1dFtGjg8llX0u5Ksm1YCZ0Tfzrj21TsIbR6
         6kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gd3VHdFGtD3SXNZ/JPuKB3ynXBovTsHcGRhQbuJNH6I=;
        b=ry4Tscj01HMs14f0WvoZt2HwskCNqreLSnLaWpLwuzHUSp1ZBSPIhxFJKNM7/tljZi
         9rkZpQvIfgOhs0r3n6WO2kelNJ/hX3FZoMpezALTiPLRENRijEjf+6GxsJi9ndKA25s5
         122qsta0QaMQYlFTEdtUkBI3by8+VZAHJuFTAeX5oikQvOhgzRGOvGXJZUvFmzIC8nyK
         nQtLcm80MOzYJG8dan/2KBU9nHFYXlAdOp5+ZWMih3vQMJyEHwqnYU9pdDT5ZSQ5EwOq
         qkpUTEMD4hbbTBXOJmSH4kQqDa6peGMQYmshUrrqhqAWG0jYbzeFiI2hKdXQ/+CJC/Jf
         nrLA==
X-Gm-Message-State: ABuFfog1lirT4918OtebjHXqbL1tUQ+FoRtUp4ye/ESS/V/uQ//z3QID
        l49vtErH5l7XpBUUV723jIbXsIHVfJ7gR9PGDyYXbw==
X-Google-Smtp-Source: ACcGV62vCxbaS2SQqwvk54qxpu8IO9OQuWwfus14vk6tiAj/czRQVyN/sO74NUDCg+truvfZV30bs5iEVJlOaXG1KVI=
X-Received: by 2002:a5e:9e4c:: with SMTP id j12-v6mr748677ioq.111.1537774549247;
 Mon, 24 Sep 2018 00:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180923111727.10378-1-brgl@bgdev.pl>
In-Reply-To: <20180923111727.10378-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 24 Sep 2018 09:35:38 +0200
Message-ID: <CAMRc=MfZ8jRZHgXBq9TeYm5VpmLzwG7gF-NMYay9Zg-iEgFQDQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: use device properties instead of platform_data
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 23 wrz 2018 o 13:17 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> Some users want to introduce device tree support to the mockup driver.
> Let's make it easier by switching to using generic device properties.
> The driver stays compatible with previous use cases and after this
> conversion there'll be no need to change the way probing of mockup
> GPIO chips works.
>
> Tested with libgpiod test suite.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpio-mockup.c | 82 ++++++++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index d66b7a768ecd..4e66bd83b76c 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -18,6 +18,7 @@
>  #include <linux/irq_sim.h>
>  #include <linux/debugfs.h>
>  #include <linux/uaccess.h>
> +#include <linux/property.h>
>
>  #include "gpiolib.h"
>
> @@ -28,6 +29,8 @@
>   * of GPIO lines.
>   */
>  #define GPIO_MOCKUP_MAX_RANGES (GPIO_MOCKUP_MAX_GC * 2)
> +/* Maximum of three properties + the sentinel. */
> +#define GPIO_MOCKUP_MAX_PROP   4
>
>  #define gpio_mockup_err(...)   pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
>
> @@ -59,13 +62,6 @@ struct gpio_mockup_dbgfs_private {
>         int offset;
>  };
>
> -struct gpio_mockup_platform_data {
> -       int base;
> -       int ngpio;
> -       int index;
> -       bool named_lines;
> -};
> -
>  static int gpio_mockup_ranges[GPIO_MOCKUP_MAX_RANGES];
>  static int gpio_mockup_num_ranges;
>  module_param_array(gpio_mockup_ranges, int, &gpio_mockup_num_ranges, 040=
0);
> @@ -255,26 +251,37 @@ static int gpio_mockup_name_lines(struct device *de=
v,
>
>  static int gpio_mockup_probe(struct platform_device *pdev)
>  {
> -       struct gpio_mockup_platform_data *pdata;
>         struct gpio_mockup_chip *chip;
>         struct gpio_chip *gc;
> -       int rv, base, ngpio;
>         struct device *dev;
> -       char *name;
> +       const char *name;
> +       int rv, base;
> +       u16 ngpio;
>
>         dev =3D &pdev->dev;
> -       pdata =3D dev_get_platdata(dev);
> -       base =3D pdata->base;
> -       ngpio =3D pdata->ngpio;
> +
> +       rv =3D device_property_read_u32(dev, "gpio-base", &base);
> +       if (rv && rv =3D=3D -ENOENT)

Linus, I just noticed that we either need to drop the check for
-ENOENT or add an else that returns on any other error. I'll need to
send a v2 but I'll let you first tell me if you like the general idea.

Bart

> +               base =3D -1;
> +
> +       rv =3D device_property_read_u16(dev, "nr-gpios", &ngpio);
> +       if (rv)
> +               return rv;
> +
> +       rv =3D device_property_read_string(dev, "chip-name", &name);
> +       if (rv)
> +               name =3D NULL;
>
>         chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
>         if (!chip)
>                 return -ENOMEM;
>
> -       name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-%c",
> -                             pdev->name, pdata->index);
> -       if (!name)
> -               return -ENOMEM;
> +       if (!name) {
> +               name =3D devm_kasprintf(dev, GFP_KERNEL,
> +                                     "%s-%c", pdev->name, pdev->id + 'A'=
);
> +               if (!name)
> +                       return -ENOMEM;
> +       }
>
>         gc =3D &chip->gc;
>         gc->base =3D base;
> @@ -295,7 +302,7 @@ static int gpio_mockup_probe(struct platform_device *=
pdev)
>         if (!chip->lines)
>                 return -ENOMEM;
>
> -       if (pdata->named_lines) {
> +       if (device_property_read_bool(dev, "named-gpio-lines")) {
>                 rv =3D gpio_mockup_name_lines(dev, chip);
>                 if (rv)
>                         return rv;
> @@ -339,9 +346,11 @@ static void gpio_mockup_unregister_pdevs(void)
>
>  static int __init gpio_mockup_init(void)
>  {
> -       int i, num_chips, err =3D 0, index =3D 'A';
> -       struct gpio_mockup_platform_data pdata;
> +       struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
> +       int i, prop, num_chips, err =3D 0, base;
> +       struct platform_device_info pdevinfo;
>         struct platform_device *pdev;
> +       u16 ngpio;
>
>         if ((gpio_mockup_num_ranges < 2) ||
>             (gpio_mockup_num_ranges % 2) ||
> @@ -371,17 +380,28 @@ static int __init gpio_mockup_init(void)
>         }
>
>         for (i =3D 0; i < num_chips; i++) {
> -               pdata.index =3D index++;
> -               pdata.base =3D gpio_mockup_range_base(i);
> -               pdata.ngpio =3D pdata.base < 0
> -                               ? gpio_mockup_range_ngpio(i)
> -                               : gpio_mockup_range_ngpio(i) - pdata.base=
;
> -               pdata.named_lines =3D gpio_mockup_named_lines;
> -
> -               pdev =3D platform_device_register_resndata(NULL,
> -                                                        GPIO_MOCKUP_NAME=
,
> -                                                        i, NULL, 0, &pda=
ta,
> -                                                        sizeof(pdata));
> +               memset(properties, 0, sizeof(properties));
> +               memset(&pdevinfo, 0, sizeof(pdevinfo));
> +               prop =3D 0;
> +
> +               base =3D gpio_mockup_range_base(i);
> +               if (base >=3D 0)
> +                       properties[prop++] =3D PROPERTY_ENTRY_U32("gpio-b=
ase",
> +                                                               base);
> +
> +               ngpio =3D base < 0 ? gpio_mockup_range_ngpio(i)
> +                                : gpio_mockup_range_ngpio(i) - base;
> +               properties[prop++] =3D PROPERTY_ENTRY_U16("nr-gpios", ngp=
io);
> +
> +               if (gpio_mockup_named_lines)
> +                       properties[prop++] =3D PROPERTY_ENTRY_BOOL(
> +                                               "named-gpio-lines");
> +
> +               pdevinfo.name =3D GPIO_MOCKUP_NAME;
> +               pdevinfo.id =3D i;
> +               pdevinfo.properties =3D properties;
> +
> +               pdev =3D platform_device_register_full(&pdevinfo);
>                 if (IS_ERR(pdev)) {
>                         gpio_mockup_err("error registering device");
>                         platform_driver_unregister(&gpio_mockup_driver);
> --
> 2.18.0
>
