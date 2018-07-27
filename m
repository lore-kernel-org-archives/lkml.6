Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D45DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C3A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+uQkxBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C3A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeG0GfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:35:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43823 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeG0GfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:35:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so7023319oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=95A5Ds+qNEpPyGIQZWYtyT3INtdvBQqEpzUcY11mqQg=;
        b=L+uQkxBRFtf7+AN0i6v4cMWGkKW5HE+3J0TztiS8idoeP1Waw56NBPYky8fU5GsQ4K
         rqvx5+ZMwFmNiZ7kj/klQH243b3jh89pnX+lx8P77YXGs002moFojrKV+7jzhTEiOi70
         Y2kx0fbVyFS9ogyy4T0pe/fb43Ax+roxRaPSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=95A5Ds+qNEpPyGIQZWYtyT3INtdvBQqEpzUcY11mqQg=;
        b=fssBf81D/Ow3oqU27h2qvk4yFcNOS/DJgCNOfT96CRvQnlHtTSAb2k+qa+3iWzdPFX
         zSb54LiSVwJJVWCnu4Li0FvDzmU4Tl3jihUXw79Vu5+GtTaa/mRKBhGt8BqRz3Fyj3ep
         /8AVwOzbRyiuYJYLLuyYCD6wClbc+99LRLOHQ1EsIdwXuYbEanpnRRDbLBQtgHvYdco4
         B1FS0kuT99yDj668DmwA6D292yeQapzu71Ou6v/OXcnVUux3HNbYapz0MjCus6PFxDRU
         TCx8N3cuYIh+DuhLqLtnDKG8VXMY5fiVuLaxq5RYr/76E8WJbZ9UGDAUBJfwJeMyLl8H
         fxWw==
X-Gm-Message-State: AOUpUlEzxdeGHwYtJ+IN+wgFkMWdA4k8jsApf9jDUmPeWzb4mTuyDqs5
        oxpMSzthOeIodWJpMXbsS+JC9EYapJsCCqOwpERbNw==
X-Google-Smtp-Source: AAOMgpdqKCvnLndQymTeGEOOb8mx1wZWdeL2eisBNcKnghEOYViI15xLF/kNUc0l92aeNzhClYdeeNPXwStp5xTL+cA=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr5220470oih.31.1532668503309;
 Thu, 26 Jul 2018 22:15:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 22:15:02
 -0700 (PDT)
In-Reply-To: <20180724114147.GA26036@amd>
References: <20180714223907.GB2776@amd> <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com> <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180718075637.GA10279@amd> <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
 <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com> <20180718221717.GA5451@amd>
 <20180719202005.GA7763@amd> <CAMz4kuKGcnDqyF29vGDqjRDMWmmk=c=QVQExYrx_Ymomm3qh+g@mail.gmail.com>
 <20180724114147.GA26036@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 27 Jul 2018 13:15:02 +0800
Message-ID: <CAMz4kuKbjUDvqyM3rovRmUpeSabNL6yHX1HpFUYD0pc9d4PNMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        David Lechner <david@lechnology.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 24 July 2018 at 19:41, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> > >Please keep in mind that this is ABI documentation for the pattern=
 file
>> >> > >to be exposed by LED core, and not by the pattern trigger, that, a=
s we
>> >> > >agreed, will be implemented later. In this case, I'd go for
>> >> >
>> >> > Gosh, I got completely distracted by the recent discussion about
>> >> > pattern synchronization.
>> >> >
>> >> > So, to recap, we need to decide if we are taking Baolin's solution
>> >> > or we're opting for implementing pattern trigger.
>> >> >
>> >> > If we choose the latter, then we will also need some software
>> >> > pattern engine in the trigger, to be applied as a software pattern
>> >> > fallback for the devices without hardware pattern support.
>> >> > It will certainly delay the contribution process, provided that Bao=
lin
>> >> > would find time for this work at all.
>> >>
>> >> I'd recommend the latter. Yes, software pattern as a fallback would b=
e
>> >> nice, but I have that code already... let me get it back to running
>> >> state, and figure out where to add interface for "hardware
>> >> acceleration". I'd like to have same interface to userland, whether
>> >> pattern can be done by hardware or by software.
>> >
>> > For the record, I'd like something like this. (Software pattern should
>> > work. Hardware pattern... needs more work).
>>
>> Thanks for showing your thoughts. But I failed to compile your code,
>> would you like to send out formal patches (Or only including software
>> pattern, I will help to add hardware pattern part and do some testing
>> with our driver)? Thanks.
>
> This should be a bit better. I attempted to compile it with your
> driver, but whether it works is an open question.

Sorry for late reply. I've compiled and tested this version on my
platform, the hardware pattern can work with one small fix as below.

 if (led_cdev->pattern_set && !led_cdev->pattern_set(led_cdev,
data->steps, data->nsteps)) {
        return;
 }

But I saw there are lots coding style issues and something can be
improved in this patch, so will you send out one clean patch (I will
help to test the hardware pattern support)? Or I can help to improve
this code and try to upstream it again?

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
>
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-b=
ltc.c
> index 9d9b7aa..898f92d 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -6,6 +6,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/slab.h>
>  #include <uapi/linux/uleds.h>
>
>  /* PMIC global control register definition */
> @@ -32,8 +33,13 @@
>  #define SC27XX_DUTY_MASK       GENMASK(15, 0)
>  #define SC27XX_MOD_MASK                GENMASK(7, 0)
>
> +#define SC27XX_CURVE_SHIFT     8
> +#define SC27XX_CURVE_L_MASK    GENMASK(7, 0)
> +#define SC27XX_CURVE_H_MASK    GENMASK(15, 8)
> +
>  #define SC27XX_LEDS_OFFSET     0x10
>  #define SC27XX_LEDS_MAX                3
> +#define SC27XX_LEDS_PATTERN_CNT        4
>
>  struct sc27xx_led {
>         char name[LED_MAX_NAME_SIZE];
> @@ -122,6 +128,157 @@ static int sc27xx_led_set(struct led_classdev *ldev=
, enum led_brightness value)
>         return err;
>  }
>
> +static int sc27xx_led_pattern_clear(struct led_classdev *ldev)
> +{
> +       struct sc27xx_led *leds =3D to_sc27xx_led(ldev);
> +       struct regmap *regmap =3D leds->priv->regmap;
> +       u32 base =3D sc27xx_led_get_offset(leds);
> +       u32 ctrl_base =3D leds->priv->base + SC27XX_LEDS_CTRL;
> +       u8 ctrl_shift =3D SC27XX_CTRL_SHIFT * leds->line;
> +       int err;
> +
> +       mutex_lock(&leds->priv->lock);
> +
> +       /* Reset the rise, high, fall and low time to zero. */
> +       regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
> +       regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
> +
> +       err =3D regmap_update_bits(regmap, ctrl_base,
> +                       (SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift,=
 0);
> +
> +       mutex_unlock(&leds->priv->lock);
> +
> +       return err;
> +}
> +
> +static int sc27xx_led_pattern_set(struct led_classdev *ldev,
> +                                 struct led_pattern *pattern,
> +                                 int len)
> +{
> +       struct sc27xx_led *leds =3D to_sc27xx_led(ldev);
> +       u32 base =3D sc27xx_led_get_offset(leds);
> +       u32 ctrl_base =3D leds->priv->base + SC27XX_LEDS_CTRL;
> +       u8 ctrl_shift =3D SC27XX_CTRL_SHIFT * leds->line;
> +       struct regmap *regmap =3D leds->priv->regmap;
> +       int err;
> +
> +       /*
> +        * Must contain 4 patterns to configure the rise time, high time,=
 fall
> +        * time and low time to enable the breathing mode.
> +        */
> +       if (len !=3D SC27XX_LEDS_PATTERN_CNT)
> +               return -EINVAL;
> +
> +       mutex_lock(&leds->priv->lock);
> +
> +       err =3D regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +                                SC27XX_CURVE_L_MASK, pattern[0].delta_t)=
;
> +       if (err)
> +               goto out;
> +
> +       err =3D regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +                                SC27XX_CURVE_L_MASK, pattern[1].delta_t)=
;
> +       if (err)
> +               goto out;
> +
> +       err =3D regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +                                SC27XX_CURVE_H_MASK,
> +                                pattern[2].delta_t << SC27XX_CURVE_SHIFT=
);
> +       if (err)
> +               goto out;
> +
> +
> +       err =3D regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +                                SC27XX_CURVE_H_MASK,
> +                                pattern[3].delta_t << SC27XX_CURVE_SHIFT=
);
> +       if (err)
> +               goto out;
> +
> +
> +       err =3D regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
> +                                SC27XX_DUTY_MASK,
> +                                (pattern[0].brightness << SC27XX_DUTY_SH=
IFT) |
> +                                SC27XX_MOD_MASK);
> +       if (err)
> +               goto out;
> +
> +       /* Enable the LED breathing mode */
> +       err =3D regmap_update_bits(regmap, ctrl_base,
> +                                SC27XX_LED_RUN << ctrl_shift,
> +                                SC27XX_LED_RUN << ctrl_shift);
> +
> +out:
> +       mutex_unlock(&leds->priv->lock);
> +
> +       return err;
> +}
> +
> +static struct led_pattern *sc27xx_led_pattern_get(struct led_classdev *l=
dev,
> +                                                 int *len)
> +{
> +       struct sc27xx_led *leds =3D to_sc27xx_led(ldev);
> +       u32 base =3D sc27xx_led_get_offset(leds);
> +       struct regmap *regmap =3D leds->priv->regmap;
> +       struct led_pattern *pattern;
> +       int i, err;
> +       u32 val;
> +
> +       /*
> +        * Must allocate 4 patterns to show the rise time, high time, fal=
l time
> +        * and low time.
> +        */
> +       pattern =3D kcalloc(SC27XX_LEDS_PATTERN_CNT, sizeof(*pattern),
> +                         GFP_KERNEL);
> +       if (!pattern)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_lock(&leds->priv->lock);
> +
> +       err =3D regmap_read(regmap, base + SC27XX_LEDS_CURVE0, &val);
> +       if (err)
> +               goto out;
> +
> +       pattern[0].delta_t =3D val & SC27XX_CURVE_L_MASK;
> +
> +       err =3D regmap_read(regmap, base + SC27XX_LEDS_CURVE1, &val);
> +       if (err)
> +               goto out;
> +
> +       pattern[1].delta_t =3D val & SC27XX_CURVE_L_MASK;
> +
> +       err =3D regmap_read(regmap, base + SC27XX_LEDS_CURVE0, &val);
> +       if (err)
> +               goto out;
> +
> +       pattern[2].delta_t =3D (val & SC27XX_CURVE_H_MASK) >> SC27XX_CURV=
E_SHIFT;
> +
> +       err =3D regmap_read(regmap, base + SC27XX_LEDS_CURVE1, &val);
> +       if (err)
> +               goto out;
> +
> +       pattern[3].delta_t =3D (val & SC27XX_CURVE_H_MASK) >> SC27XX_CURV=
E_SHIFT;
> +
> +       err =3D regmap_read(regmap, base + SC27XX_LEDS_DUTY, &val);
> +       if (err)
> +               goto out;
> +
> +       mutex_unlock(&leds->priv->lock);
> +
> +       val =3D (val & SC27XX_DUTY_MASK) >> SC27XX_DUTY_SHIFT;
> +       for (i =3D 0; i < SC27XX_LEDS_PATTERN_CNT; i++)
> +               pattern[i].brightness =3D val;
> +
> +       *len =3D SC27XX_LEDS_PATTERN_CNT;
> +
> +       return pattern;
> +
> +out:
> +       mutex_unlock(&leds->priv->lock);
> +       kfree(pattern);
> +
> +       return ERR_PTR(err);
> +}
> +
>  static int sc27xx_led_register(struct device *dev, struct sc27xx_led_pri=
v *priv)
>  {
>         int i, err;
> @@ -140,6 +297,9 @@ static int sc27xx_led_register(struct device *dev, st=
ruct sc27xx_led_priv *priv)
>                 led->priv =3D priv;
>                 led->ldev.name =3D led->name;
>                 led->ldev.brightness_set_blocking =3D sc27xx_led_set;
> +               led->ldev.pattern_set =3D sc27xx_led_pattern_set;
> +               led->ldev.pattern_get =3D sc27xx_led_pattern_get;
> +               led->ldev.pattern_clear =3D sc27xx_led_pattern_clear;
>
>                 err =3D devm_led_classdev_register(dev, &led->ldev);
>                 if (err)
> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
> index a2559b4..91ae5b0 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -125,6 +125,16 @@ config LEDS_TRIGGER_CAMERA
>           This enables direct flash/torch on/off by the driver, kernel sp=
ace.
>           If unsure, say Y.
>
> +config LEDS_TRIGGER_PATTERN
> +       tristate "LED Pattern Trigger"
> +       depends on LEDS_TRIGGERS
> +       help
> +         This allows LEDs blinking with an arbitrary pattern. Can be use=
ful
> +         on embedded systems with no screen to give out a status code to
> +         a human.
> +
> +         If unsure, say N
> +
>  config LEDS_TRIGGER_PANIC
>         bool "LED Panic Trigger"
>         depends on LEDS_TRIGGERS
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefil=
e
> index f3cfe19..ba6f3b9 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -11,5 +11,6 @@ obj-$(CONFIG_LEDS_TRIGGER_ACTIVITY)   +=3D ledtrig-acti=
vity.o
>  obj-$(CONFIG_LEDS_TRIGGER_DEFAULT_ON)  +=3D ledtrig-default-on.o
>  obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)   +=3D ledtrig-transient.o
>  obj-$(CONFIG_LEDS_TRIGGER_CAMERA)      +=3D ledtrig-camera.o
> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)     +=3D ledtrig-pattern.o
>  obj-$(CONFIG_LEDS_TRIGGER_PANIC)       +=3D ledtrig-panic.o
>  obj-$(CONFIG_LEDS_TRIGGER_NETDEV)      +=3D ledtrig-netdev.o
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigge=
r/ledtrig-pattern.c
> new file mode 100644
> index 0000000..3dab050
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,395 @@
> +/*
> + * Arbitrary pattern trigger
> + *
> + * Copyright 2015, Epsiline
> + *
> + * Author : Rapha=C3=ABl Teysseyre <rteysseyre@gmail.com>
> + *
> + * Idea discussed with Pavel Machek <pavel@ucw.cz> on
> + * <linux-leds@vger.kernel.org> (march 2015, thread title
> + * [PATCH RFC] leds: Add status code trigger)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/timer.h>
> +#include "../leds.h"
> +
> +struct pattern_trig_data {
> +       struct led_classdev *led_cdev;
> +
> +       struct led_pattern *steps; /* Array describing the pattern */
> +       struct mutex lock;
> +       char is_sane;
> +       struct led_pattern *curr;
> +       struct led_pattern *next;
> +       int delta_t; /* Time in current step */
> +       int nsteps;  /* Number of steps */
> +       int repeat;  /* < 0 means repeat indefinitely */
> +       struct timer_list timer;
> +};
> +
> +#define MAX_NSTEPS (PAGE_SIZE/4)
> +/* The "pattern" attribute contains at most PAGE_SIZE characters.
> +   Each line in this attribute is at least 4 characters long
> +   (a 1-digit number for the led brighntess, a space,
> +   a 1-digit number for the time, a semi-colon).
> +   Therefore, there is at most PAGE_SIZE/4 steps. */
> +
> +#define UPDATE_INTERVAL 50
> +/* When doing gradual dimming, the led brightness
> +   will be updated every UPDATE_INTERVAL milliseconds */
> +
> +#define PATTERN_SEPARATOR ","
> +
> +static int pattern_trig_initialize_data(struct pattern_trig_data *data)
> +{
> +       mutex_init(&data->lock);
> +       mutex_lock(&data->lock);
> +
> +       data->is_sane =3D 0;
> +       data->steps =3D kzalloc(MAX_NSTEPS*sizeof(struct led_pattern),
> +                       GFP_KERNEL);
> +       if (!data->steps)
> +               return -ENOMEM;
> +
> +       data->curr =3D NULL;
> +       data->next =3D NULL;
> +       data->delta_t =3D 0;
> +       data->nsteps =3D 0;
> +       data->repeat =3D -1;
> +       //data->timer =3D __TIMER_INITIALIZER(NULL, 0);
> +
> +       mutex_unlock(&data->lock);
> +       return 0;
> +}
> +
> +static void pattern_trig_clear_data(struct pattern_trig_data *data)
> +{
> +       data->is_sane =3D 0;
> +       kfree(data->steps);
> +}
> +
> +/*
> + *  is_sane : pattern checking.
> + *  A pattern satisfying these three conditions is reported as sane :
> + *    - At least two steps
> + *    - At least one step with time >=3D UPDATE_INTERVAL
> + *    - At least two steps with differing brightnesses
> + *  When @data isn't sane, a sensible brightness
> + *  default is suggested in @brightness
> + *
> + * DO NOT call pattern_trig_update on a not-sane pattern,
> + * you'll be punished with an infinite loop in the kernel.
> + */
> +static int is_sane(struct pattern_trig_data *data, int *brightness)
> +{
> +       int i;
> +       char stept_ok =3D 0;
> +       char stepb_ok =3D 0;
> +
> +       *brightness =3D 0;
> +       if (data->nsteps < 1)
> +               return 0;
> +
> +       *brightness =3D data->steps[0].brightness;
> +       if (data->nsteps < 2)
> +               return 0;
> +
> +       for (i =3D 0; i < data->nsteps; i++) {
> +               if (data->steps[i].delta_t >=3D UPDATE_INTERVAL) {
> +                       /* FIXME: this is wrong */
> +                       if (stepb_ok)
> +                               return 1;
> +                       stept_ok =3D 1;
> +               }
> +               if (data->steps[i].brightness !=3D data->steps[0].brightn=
ess) {
> +                       if (stept_ok)
> +                               return 1;
> +                       stepb_ok =3D 1;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void reset_pattern(struct pattern_trig_data *data,
> +                       struct led_classdev *led_cdev)
> +{
> +       int brightness;
> +
> +       if (led_cdev->pattern_clear) {
> +               led_cdev->pattern_clear(led_cdev);
> +       }
> +
> +       del_timer_sync(&data->timer);
> +
> +       if (led_cdev->pattern_set && led_cdev->pattern_set(led_cdev, data=
->steps, data->nsteps)) {
> +               return;
> +       }
> +
> +       if (!is_sane(data, &brightness)) {
> +               led_set_brightness(led_cdev, brightness);
> +               return;
> +       }
> +
> +       data->curr =3D data->steps;
> +       data->next =3D data->steps + 1;
> +       data->delta_t =3D 0;
> +       data->is_sane =3D 1;
> +
> +       data->timer.expires =3D jiffies;
> +       add_timer(&data->timer);
> +}
> +
> +/* --- Sysfs handling --- */
> +
> +static ssize_t pattern_trig_show_repeat(
> +       struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> +       struct pattern_trig_data *data =3D led_cdev->trigger_data;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", data->repeat);
> +}
> +
> +static ssize_t pattern_trig_store_repeat(
> +       struct device *dev, struct device_attribute *attr,
> +       const char *buf, size_t count)
> +{
> +       struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> +       struct pattern_trig_data *data =3D led_cdev->trigger_data;
> +       long res;
> +       int err;
> +
> +       err =3D kstrtol(buf, 10, &res);
> +       if (err)
> +               return err;
> +
> +       data->repeat =3D res < 0 ? -1 : res;
> +       reset_pattern(data, led_cdev);
> +
> +       return count;
> +}
> +
> +DEVICE_ATTR(repeat, S_IRUGO | S_IWUSR,
> +       pattern_trig_show_repeat, pattern_trig_store_repeat);
> +
> +static ssize_t pattern_trig_show_pattern(
> +       struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> +       struct pattern_trig_data *data =3D led_cdev->trigger_data;
> +       ssize_t count =3D 0;
> +       int i;
> +
> +       if (!data->steps || !data->nsteps)
> +               return 0;
> +
> +       for (i =3D 0; i < data->nsteps; i++)
> +               count +=3D scnprintf(buf + count, PAGE_SIZE - count,
> +                               "%d %d" PATTERN_SEPARATOR,
> +                               data->steps[i].brightness,
> +                               data->steps[i].delta_t);
> +       buf[count - 1] =3D '\n';
> +       buf[count] =3D '\0';
> +
> +       return count + 1;
> +}
> +
> +static ssize_t pattern_trig_store_pattern(
> +       struct device *dev, struct device_attribute *attr,
> +       const char *buf, size_t count)
> +{
> +       struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> +       struct pattern_trig_data *data =3D led_cdev->trigger_data;
> +       int cr =3D 0; /* Characters read on one conversion */
> +       int tcr =3D 0; /* Total characters read */
> +       int ccount; /* Number of successful conversions */
> +
> +       mutex_lock(&data->lock);
> +       data->is_sane =3D 0;
> +
> +       for (data->nsteps =3D 0; data->nsteps < MAX_NSTEPS; data->nsteps+=
+) {
> +               cr =3D 0;
> +               ccount =3D sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "=
%n",
> +                       &data->steps[data->nsteps].brightness,
> +                       &data->steps[data->nsteps].delta_t, &cr);
> +
> +               if (!cr) { /* Invalid syntax or end of pattern */
> +                       if (ccount =3D=3D 2)
> +                               data->nsteps++;
> +                       mutex_unlock(&data->lock);
> +                       reset_pattern(data, led_cdev);
> +                       return count;
> +               }
> +
> +               tcr +=3D cr;
> +       }
> +
> +       /* Shouldn't reach that */
> +       WARN(1, "MAX_NSTEP too small. Please report\n");
> +       mutex_unlock(&data->lock);
> +       return count;
> +}
> +
> +DEVICE_ATTR(pattern, S_IRUGO | S_IWUSR,
> +       pattern_trig_show_pattern, pattern_trig_store_pattern);
> +
> +static int pattern_trig_create_sysfs_files(struct device *dev)
> +{
> +       int err;
> +
> +       err =3D device_create_file(dev, &dev_attr_repeat);
> +       if (err)
> +               return err;
> +
> +       err =3D device_create_file(dev, &dev_attr_pattern);
> +       if (err)
> +               device_remove_file(dev, &dev_attr_repeat);
> +
> +       return err;
> +}
> +
> +static void pattern_trig_remove_sysfs_files(struct device *dev)
> +{
> +       device_remove_file(dev, &dev_attr_pattern);
> +       device_remove_file(dev, &dev_attr_repeat);
> +}
> +
> +/* --- Led intensity updating --- */
> +
> +static int compute_brightness(struct pattern_trig_data *data)
> +{
> +       if (data->delta_t =3D=3D 0)
> +               return data->curr->brightness;
> +
> +       if (data->curr->delta_t =3D=3D 0)
> +               return data->next->brightness;
> +
> +       return data->curr->brightness + data->delta_t
> +               * (data->next->brightness - data->curr->brightness)
> +               / data->curr->delta_t;
> +}
> +
> +static void update_to_next_step(struct pattern_trig_data *data)
> +{
> +       data->curr =3D data->next;
> +       if (data->curr =3D=3D data->steps)
> +               data->repeat--;
> +
> +       if (data->next =3D=3D data->steps + data->nsteps - 1)
> +               data->next =3D data->steps;
> +       else
> +               data->next++;
> +
> +       data->delta_t =3D 0;
> +}
> +
> +static void pattern_trig_update(struct timer_list *t)
> +{
> +       struct pattern_trig_data *data =3D from_timer(data, t, timer);
> +
> +       mutex_lock(&data->lock);
> +
> +       if (!data->is_sane || !data->repeat) {
> +               mutex_unlock(&data->lock);
> +               return;
> +       }
> +
> +       if (data->delta_t > data->curr->delta_t)
> +               update_to_next_step(data);
> +
> +       /* is_sane() checked that there is at least
> +          one step with delta_t >=3D UPDATE_INTERVAL
> +          so we won't go in an infinite loop */
> +       while (data->curr->delta_t < UPDATE_INTERVAL)
> +               update_to_next_step(data);
> +
> +       if (data->next->brightness =3D=3D data->curr->brightness) {
> +               /* Constant brightness for this step */
> +               led_set_brightness(data->led_cdev, data->curr->brightness=
);
> +               mod_timer(&data->timer, jiffies
> +                       + msecs_to_jiffies(data->curr->delta_t));
> +               update_to_next_step(data);
> +       } else {
> +               /* Gradual dimming */
> +               led_set_brightness(data->led_cdev, compute_brightness(dat=
a));
> +               data->delta_t +=3D UPDATE_INTERVAL;
> +               mod_timer(&data->timer, jiffies
> +                       + msecs_to_jiffies(UPDATE_INTERVAL));
> +       }
> +
> +       mutex_unlock(&data->lock);
> +}
> +
> +/* --- Trigger activation --- */
> +
> +static void pattern_trig_activate(struct led_classdev *led_cdev)
> +{
> +       struct pattern_trig_data *data =3D NULL;
> +       int err;
> +
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return;
> +
> +       err =3D pattern_trig_initialize_data(data);
> +       if (err) {
> +               kfree(data);
> +               return;
> +       }
> +
> +       data->led_cdev =3D led_cdev;
> +       led_cdev->trigger_data =3D data;
> +       timer_setup(&data->timer, pattern_trig_update, 0);
> +       pattern_trig_create_sysfs_files(led_cdev->dev);
> +}
> +
> +static void pattern_trig_deactivate(struct led_classdev *led_cdev)
> +{
> +       struct pattern_trig_data *data =3D led_cdev->trigger_data;
> +
> +       if (data) {
> +               pattern_trig_remove_sysfs_files(led_cdev->dev);
> +               del_timer_sync(&data->timer);
> +               led_set_brightness(led_cdev, LED_OFF);
> +               pattern_trig_clear_data(data);
> +               kfree(data);
> +               led_cdev->trigger_data =3D NULL;
> +       }
> +}
> +
> +static struct led_trigger pattern_led_trigger =3D {
> +       .name =3D "pattern",
> +       .activate =3D pattern_trig_activate,
> +       .deactivate =3D pattern_trig_deactivate,
> +};
> +
> +/* --- Module loading/unloading --- */
> +
> +static int __init pattern_trig_init(void)
> +{
> +       return led_trigger_register(&pattern_led_trigger);
> +}
> +
> +static void __exit pattern_trig_exit(void)
> +{
> +       led_trigger_unregister(&pattern_led_trigger);
> +}
> +
> +module_init(pattern_trig_init);
> +module_exit(pattern_trig_exit);
> +
> +MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
> +MODULE_DESCRIPTION("Pattern LED trigger");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 2fce962..39908ba 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -22,6 +22,7 @@
>  #include <linux/workqueue.h>
>
>  struct device;
> +struct led_pattern;
>  /*
>   * LED Core
>   */
> @@ -91,6 +92,14 @@ struct led_classdev {
>                                      unsigned long *delay_on,
>                                      unsigned long *delay_off);
>
> +       int (*pattern_set)(struct led_classdev *led_cdev,
> +                          struct led_pattern *pattern, int len);
> +
> +       int (*pattern_clear)(struct led_classdev *led_cdev);
> +
> +       struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
> +                                          int *len);
> +
>         struct device           *dev;
>         const struct attribute_group    **groups;
>
> @@ -104,7 +113,7 @@ struct led_classdev {
>         void                    (*flash_resume)(struct led_classdev *led_=
cdev);
>
>         struct work_struct      set_brightness_work;
> -       int                     delayed_set_value;
> +       enum led_brightness     delayed_set_value;
>
>  #ifdef CONFIG_LEDS_TRIGGERS
>         /* Protects the trigger data below */
> @@ -471,4 +480,14 @@ static inline void led_classdev_notify_brightness_hw=
_changed(
>         struct led_classdev *led_cdev, enum led_brightness brightness) { =
}
>  #endif
>
> +/**
> + * struct led_pattern - brightness value in a pattern
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time =3D 0
> + */
> +struct led_pattern {
> +       int delta_t;
> +       int brightness;
> +};
> +
>  #endif         /* __LINUX_LEDS_H_INCLUDED */
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--=20
Baolin Wang
Best Regards
