Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14020862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHcjTSKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F14020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeKGQYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:24:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44965 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeKGQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:24:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so687389lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n7YmFmMhwKN3HitKa2oMmkPfCTbCwS3iVMKO3y+M99M=;
        b=aHcjTSKMSHsjBIoSFfbSza08XfFiBn/ksALb7TsQtZXRAk0tEhtWQ84hnFK6MOkV43
         pCuajoo956eSerLrqdsJaqRTjaHV8MQgjJukNwIJzCDorUtBxFNBYGgpgwh8tKlDT27P
         Qt44wqZcaVsll+7ECGIRYyz5dyQHGK9TbZFVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n7YmFmMhwKN3HitKa2oMmkPfCTbCwS3iVMKO3y+M99M=;
        b=PW3Y/1rvu3NHee10N5C/vlU8zGJ8JQbA+ngJfLr7y/4Aqe0awqzluicd5wQpF7M3T/
         Ud9NS9y33r2yPhiPkCN5hd/vS/eiV1RGQ5D9gV+7p68ianqFaKbDsOoTxZqkUh2wmmOO
         +wY6FkMZDg0BQo/zFNRXWehfHteRMoW5H++2PrX1perPoRCVn5jLIPmBk5ZaaP7DNNeB
         9BO7KPBoZePP6orWqPXFnDJd0llRJ4hA80AxAf6uaTeEms0zuxftlsHwvu3uP75aqseh
         jvC6MxH5S8uwplw2QLKdwgPzCVKeNoiNd00FXQ8cKcN1QKcptVUayd42Ym6J/pSjVZr4
         C2DQ==
X-Gm-Message-State: AGRZ1gIFF/h1BX3Fgd4n2wrwfsNA+vhuepEiCBwFyyNLXzUKMMAm3Y09
        gWBh8Bfa3aUVHQ7cB2QYfqc3bNDhHqPZYdQ+x7Cizw==
X-Google-Smtp-Source: AJdET5fVt24wHnHhAJySqF3DXk++5d3VwEvbjaOI6mTlnxVyGeD/jRQNP0W9AvJaEJBRC0yaPrRQjoEKARdJ4TI7zZM=
X-Received: by 2002:a19:1901:: with SMTP id 1mr342421lfz.99.1541573728039;
 Tue, 06 Nov 2018 22:55:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:95ca:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 22:55:27 -0800 (PST)
In-Reply-To: <1541542052-10081-2-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com> <1541542052-10081-2-git-send-email-jacek.anaszewski@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 7 Nov 2018 14:55:27 +0800
Message-ID: <CAMz4kuJrfCfe7xJptVU_EGa-GM0-pfMaH2xb8+BksEia9W=bEw@mail.gmail.com>
Subject: Re: [PATCH 01/24] leds: class: Improve LED and LED flash class
 registration API
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 7 November 2018 at 06:07, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Replace of_led_classdev_register() with led_classdev_register_ext(), which
> accepts easily extendable struct led_init_data, instead of the fixed
> struct device_node argument. The latter can be now passed in a fwnode
> property of the struct led_init_data.
>
> The modification is driven by the need for passing another argument
> to the LED class initialization function - a LED class device name.
> Currently it is conveyed in the "name" char pointer property of
> struct led_classdev, which is semantically and functionally incorrect
> since it is needed only on LED class device registration, but persists
> in system memory throughout the whole LED class device lifetime.
>
> Whereas in case of the name strings coming from DT "label" property or
> statically initialized ones the cost is only the pointer size, it grows
> to LED_MAX_NAME_SIZE (64) with the advent of a new LED class device naming
> scheme, where color and function properties come from separate board
> firmware properties and the name needs to be constructed in a new buffer.
>
> The change will not break any existing clients since the patch alters
> also existing led_classdev{_flash}_register() macro wrappers, that pass
> NULL in place of init_data, which leads to using legacy name
> initialization path basing on the struct led_classdev's "name" property.
>
> Two existing users of devm_of_led_classdev_registers() are modified
> to use devm_led_classdev_register(), which will not impact their
> operation since they in fact didn't need to pass struct device_node on
> registration from the beginning.
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> ---
>  drivers/leds/led-class-flash.c  |  9 +++++----
>  drivers/leds/led-class.c        | 34 ++++++++++++++++++++++------------
>  drivers/leds/leds-cr0014114.c   |  3 +--
>  drivers/leds/leds-gpio.c        |  2 +-
>  include/linux/led-class-flash.h | 13 +++++++++----
>  include/linux/leds.h            | 29 +++++++++++++++++++----------
>  6 files changed, 57 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
> index cf39827..8d1c117 100644
> --- a/drivers/leds/led-class-flash.c
> +++ b/drivers/leds/led-class-flash.c
> @@ -285,8 +285,9 @@ static void led_flash_init_sysfs_groups(struct led_classdev_flash *fled_cdev)
>         led_cdev->groups = flash_groups;
>  }
>
> -int led_classdev_flash_register(struct device *parent,
> -                               struct led_classdev_flash *fled_cdev)
> +int led_classdev_flash_register_ext(struct device *parent,
> +                                   struct led_classdev_flash *fled_cdev,
> +                                   struct led_init_data *init_data)
>  {
>         struct led_classdev *led_cdev;
>         const struct led_flash_ops *ops;
> @@ -312,13 +313,13 @@ int led_classdev_flash_register(struct device *parent,
>         }
>
>         /* Register led class device */
> -       ret = led_classdev_register(parent, led_cdev);
> +       ret = led_classdev_register_ext(parent, led_cdev, init_data);
>         if (ret < 0)
>                 return ret;
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(led_classdev_flash_register);
> +EXPORT_SYMBOL_GPL(led_classdev_flash_register_ext);
>
>  void led_classdev_flash_unregister(struct led_classdev_flash *fled_cdev)
>  {
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 3c7e348..8c80763 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -17,6 +17,7 @@
>  #include <linux/leds.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
> @@ -244,18 +245,25 @@ static int led_classdev_next_name(const char *init_name, char *name,
>  }
>
>  /**
> - * of_led_classdev_register - register a new object of led_classdev class.
> + * led_classdev_register_ext - register a new object of led_classdev class.
>   *
>   * @parent: parent of LED device
>   * @led_cdev: the led_classdev structure for this device.
> - * @np: DT node describing this LED
> + * @init_data: LED class device initialization data
>   */
> -int of_led_classdev_register(struct device *parent, struct device_node *np,
> -                           struct led_classdev *led_cdev)
> +int led_classdev_register_ext(struct device *parent,
> +                             struct led_classdev *led_cdev,
> +                             struct led_init_data *init_data)
>  {
>         char name[LED_MAX_NAME_SIZE];
>         int ret;
>
> +       if (init_data && init_data->name) {
> +               led_cdev->name = init_data->name;
> +       } else {
> +               dev_info(parent, "init_data not available");
> +       }
> +
>         ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
>         if (ret < 0)
>                 return ret;
> @@ -268,7 +276,8 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>                 mutex_unlock(&led_cdev->led_access);
>                 return PTR_ERR(led_cdev->dev);
>         }
> -       led_cdev->dev->of_node = np;
> +       if (init_data && init_data->fwnode)
> +               led_cdev->dev->of_node = to_of_node(init_data->fwnode);
>
>         if (ret)
>                 dev_warn(parent, "Led %s renamed to %s due to name collision",
> @@ -313,7 +322,7 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(of_led_classdev_register);
> +EXPORT_SYMBOL_GPL(led_classdev_register_ext);
>
>  /**
>   * led_classdev_unregister - unregisters a object of led_properties class.
> @@ -358,14 +367,15 @@ static void devm_led_classdev_release(struct device *dev, void *res)
>  }
>
>  /**
> - * devm_of_led_classdev_register - resource managed led_classdev_register()
> + * devm_led_classdev_register_ext - resource managed led_classdev_register_ext()
>   *
>   * @parent: parent of LED device
>   * @led_cdev: the led_classdev structure for this device.
> + * @init_data: LED class device initialization data
>   */
> -int devm_of_led_classdev_register(struct device *parent,
> -                                 struct device_node *np,
> -                                 struct led_classdev *led_cdev)
> +int devm_led_classdev_register_ext(struct device *parent,
> +                                  struct led_classdev *led_cdev,
> +                                  struct led_init_data *init_data)
>  {
>         struct led_classdev **dr;
>         int rc;
> @@ -374,7 +384,7 @@ int devm_of_led_classdev_register(struct device *parent,
>         if (!dr)
>                 return -ENOMEM;
>
> -       rc = of_led_classdev_register(parent, np, led_cdev);
> +       rc = led_classdev_register_ext(parent, led_cdev, init_data);
>         if (rc) {
>                 devres_free(dr);
>                 return rc;
> @@ -385,7 +395,7 @@ int devm_of_led_classdev_register(struct device *parent,
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(devm_of_led_classdev_register);
> +EXPORT_SYMBOL_GPL(devm_led_classdev_register_ext);
>
>  static int devm_led_classdev_match(struct device *dev, void *res, void *data)
>  {
> diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
> index 0e42624..1c82152 100644
> --- a/drivers/leds/leds-cr0014114.c
> +++ b/drivers/leds/leds-cr0014114.c
> @@ -207,8 +207,7 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
>                 led->ldev.max_brightness          = CR_MAX_BRIGHTNESS;
>                 led->ldev.brightness_set_blocking = cr0014114_set_sync;
>
> -               ret = devm_of_led_classdev_register(priv->dev, np,
> -                                                   &led->ldev);
> +               ret = devm_led_classdev_register(priv->dev, &led->ldev);
>                 if (ret) {
>                         dev_err(priv->dev,
>                                 "failed to register LED device %s, err %d",
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 32fa752..c87fbd3 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -112,7 +112,7 @@ static int create_gpio_led(const struct gpio_led *template,
>         if (ret < 0)
>                 return ret;
>
> -       return devm_of_led_classdev_register(parent, np, &led_dat->cdev);
> +       return devm_led_classdev_register(parent, &led_dat->cdev);
>  }
>
>  struct gpio_leds_priv {
> diff --git a/include/linux/led-class-flash.h b/include/linux/led-class-flash.h
> index 700efaa..28a73d0 100644
> --- a/include/linux/led-class-flash.h
> +++ b/include/linux/led-class-flash.h
> @@ -90,15 +90,20 @@ static inline struct led_classdev_flash *lcdev_to_flcdev(
>  }
>
>  /**
> - * led_classdev_flash_register - register a new object of led_classdev class
> - *                              with support for flash LEDs
> + * fwnode_led_classdev_flash_register - register a new object of led_classdev

s/fwnode_led_classdev_flash_register/led_classdev_flash_register_ext

> + *                                     class with support for flash LEDs
>   * @parent: the flash LED to register
> + * @fwnode: the flash LED fwnode handle

s/fwnode/init_data

>   * @fled_cdev: the led_classdev_flash structure for this device
>   *
>   * Returns: 0 on success or negative error value on failure
>   */
> -extern int led_classdev_flash_register(struct device *parent,
> -                               struct led_classdev_flash *fled_cdev);
> +extern int led_classdev_flash_register_ext(struct device *parent,
> +                                       struct led_classdev_flash *fled_cdev,
> +                                       struct led_init_data *init_data);
> +
> +#define led_classdev_flash_register(parent, fled_cdev)         \
> +       led_classdev_flash_register_ext(parent, fled_cdev, NULL)
>
>  /**
>   * led_classdev_flash_unregister - unregisters an object of led_classdev class
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 834683d..646c49a 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -20,6 +20,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/uleds.h>
>
>  struct device;
>  /*
> @@ -33,6 +34,13 @@ enum led_brightness {
>         LED_FULL        = 255,
>  };
>
> +struct led_init_data {
> +       /* Device fwnode handle */
> +       struct fwnode_handle *fwnode;
> +       /* Requested LED class device name */
> +       char name[LED_MAX_NAME_SIZE];
> +};
> +
>  struct led_classdev {
>         const char              *name;
>         enum led_brightness      brightness;
> @@ -73,6 +81,7 @@ struct led_classdev {
>          */
>         int (*brightness_set_blocking)(struct led_classdev *led_cdev,
>                                        enum led_brightness brightness);
> +

Unrelated change.

>         /* Get LED brightness level */
>         enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
>
> @@ -123,16 +132,16 @@ struct led_classdev {
>         struct mutex            led_access;
>  };
>
> -extern int of_led_classdev_register(struct device *parent,
> -                                   struct device_node *np,
> -                                   struct led_classdev *led_cdev);
> -#define led_classdev_register(parent, led_cdev)                                \
> -       of_led_classdev_register(parent, NULL, led_cdev)
> -extern int devm_of_led_classdev_register(struct device *parent,
> -                                        struct device_node *np,
> -                                        struct led_classdev *led_cdev);
> -#define devm_led_classdev_register(parent, led_cdev)                   \
> -       devm_of_led_classdev_register(parent, NULL, led_cdev)
> +extern int led_classdev_register_ext(struct device *parent,
> +                                    struct led_classdev *led_cdev,
> +                                    struct led_init_data *init_data);
> +#define led_classdev_register(parent, led_cdev)                        \
> +       led_classdev_register_ext(parent, led_cdev, NULL)
> +extern int devm_led_classdev_register_ext(struct device *parent,
> +                                         struct led_classdev *led_cdev,
> +                                         struct led_init_data *init_data);
> +#define devm_led_classdev_register(parent, led_cdev)           \
> +       devm_led_classdev_register_ext(parent, led_cdev, NULL)
>  extern void led_classdev_unregister(struct led_classdev *led_cdev);
>  extern void devm_led_classdev_unregister(struct device *parent,
>                                          struct led_classdev *led_cdev);
> --
> 2.1.4
>

It can work well for SC27XX LED, FWIW you can add my tested tag.
Tested-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
