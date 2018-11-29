Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48520863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnfJ8RuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D48520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeK3Kn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:43:56 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46533 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Kn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:43:56 -0500
Received: by mail-yw1-f67.google.com with SMTP id t13so1518957ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vs5wYqGleMIGcM+QIrSL1tOnHbf/faKCxKgdoycwxHc=;
        b=GnfJ8RuTYZW3nlNMQqz76+eN8xQN811sgJrXryhE/RWbdHTH6KQhV6WaTTEotZWKkC
         cFgURfohn4uBV4my9oJxEgR93C2U3f1AZoC9G+CbpvPgdHJXeA7OEgFlbJoMF+gV9JmF
         lfR1pYzYWkLPYwLPnUDPmH1VTN6vmVZZcm6XHf/edvSWEGKdy3jaYPZcIhj3yH3CHxaf
         mvem9s6o+PeySqOf89Oeoe5utLgK8BIfWpuBWEtO63kNPXJ+8Ey0JACJdFQ+M4yRsaVt
         2x8gJr5hJObh8LRaT29KdRF6rFsVOm3212ozsBWH5fx4XvsFhdXiVb1wooAS3G/krxrM
         GJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs5wYqGleMIGcM+QIrSL1tOnHbf/faKCxKgdoycwxHc=;
        b=iFtIZvuKCEY2cnSgufJ9P1ZuORXqm3clKMxzoTGc2eyGQ2RyMKGhJ1Tj7Ju6bskBwn
         pjH5IDp1OmKO78rWSHGqPNNz9T4okMzYbtQmm7C+yfWhudMIOZwJjfesfVB4eFAVJ+1/
         s/E98ldvoJm7Gqq/nMuHWLHD81ZqgoBHzO6jxS4AcWWgAejh47ysB9C6y9+AbXf7y/eJ
         O3rLC69o6aM+IUddSvpTEsEtVkF+xpDP0Tgk9XGp4LDCyzJbgt5QTphZM7rnLy7FPZ/S
         4KrB4Kv1TKx0X7Gx12PREi/ySa/jJE+A8gqTFOjoFcvDhnZCw5fNa1TOtTZH13K2MEGl
         eXmA==
X-Gm-Message-State: AA+aEWY3xMbkWEtNuV7PhkdQz49PCagpcLvPoSzHhn9Hi7wWEl2IXvGA
        YxIpp9jVqAFKgIzw2ZgOUy8sLMf1hlBd1TE4qRtr6g==
X-Google-Smtp-Source: AFSGD/WZDdSa0J+kv7dZUeJPYhnBEBnAasqzAXVxcOTbrxBjrNQtQOSJ3E9+niupdrtDdjxzWDYAQwe1kU2MPUhF+es=
X-Received: by 2002:a81:af58:: with SMTP id x24mr3669164ywj.362.1543534601067;
 Thu, 29 Nov 2018 15:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com> <20181127121849.23975-4-enric.balletbo@collabora.com>
In-Reply-To: <20181127121849.23975-4-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 29 Nov 2018 15:36:30 -0800
Message-ID: <CABXOdTc4O7BADKW7Pzs8E+-O9F5tRuf90Uz5h-EuqWB9CmUvng@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mfd / platform: cros_ec: move vbc attributes to
 its own driver.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The entire way how cros sysfs attibutes are created is broken.
> cros_ec_vbc should be its own driver and its attributes should be
> associated with a vbc driver not the mfd driver. In order to retain
> the path, the vbc attributes are attached to the cros_class.
>
> The patch also adds the sysfs documentation.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Fixed build error as reported by the kbuild test robot.
>
> Changes in v2:
> - Removed unneeded check of ec_dev.
>
>  .../sysfs-class-chromeos-driver-cros-ec-vbc   |  6 +++
>  drivers/mfd/cros_ec_dev.c                     |  2 +-
>  drivers/platform/chrome/Kconfig               | 10 +++++
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_vbc.c         | 43 ++++++++++++++++++-
>  include/linux/mfd/cros_ec.h                   |  1 -
>  6 files changed, 61 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc
>
> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc
> new file mode 100644
> index 000000000000..c256a2febf37
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc
> @@ -0,0 +1,6 @@
> +What:          /sys/class/chromeos/<cros-ec>/vbc/vboot_context
> +Date:          October 2015
> +KernelVersion: 4.4
> +Description:
> +               Read/write the verified boot context data included on a
> +               small nvram space on some EC implementations.
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 614f888c9d6d..51325049690c 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -36,7 +36,6 @@ static int ec_major;
>
>  static const struct attribute_group *cros_ec_groups[] = {
>         &cros_ec_attr_group,
> -       &cros_ec_vbc_attr_group,
>         NULL,
>  };
>
> @@ -391,6 +390,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
>
>  static const struct mfd_cell cros_ec_platform_cells[] = {
>         { .name = "cros-ec-lightbar" },
> +       { .name = "cros-ec-vbc" },
>  };
>
>  static int ec_device_probe(struct platform_device *pdev)
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 05bcefbe1926..29bd9837d520 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -121,4 +121,14 @@ config CROS_EC_LIGHTBAR
>           To compile this driver as a module, choose M here: the
>           module will be called cros_ec_lightbar.
>
> +config CROS_EC_VBC
> +       tristate "ChromeOS EC vboot context support"
> +       depends on MFD_CROS_EC_CHARDEV && OF
> +       help
> +         This option exposes the ChromeOS EC vboot context nvram to
> +         userspace.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called cros_ec_vbc.
> +
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 3c29a4b405d5..4081b7179df7 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_CHROMEOS_LAPTOP)           += chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)          += chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)            += chromeos_tbmc.o
>  cros_ec_ctl-objs                       := cros_ec_sysfs.o \
> -                                          cros_ec_vbc.o cros_ec_debugfs.o
> +                                          cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
>  obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
> @@ -14,3 +14,4 @@ obj-$(CONFIG_CROS_EC_LPC)             += cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)            += cros_ec_proto.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)   += cros_kbd_led_backlight.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)         += cros_ec_lightbar.o
> +obj-$(CONFIG_CROS_EC_VBC)              += cros_ec_vbc.o
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index 5356f26bc022..da3bbf05e86f 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -22,8 +22,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
>
> +#define DRV_NAME "cros-ec-vbc"
> +
>  static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>                                   struct bin_attribute *att, char *buf,
>                                   loff_t pos, size_t count)
> @@ -132,4 +135,42 @@ struct attribute_group cros_ec_vbc_attr_group = {
>         .bin_attrs = cros_ec_vbc_bin_attrs,
>         .is_bin_visible = cros_ec_vbc_is_visible,
>  };
> -EXPORT_SYMBOL(cros_ec_vbc_attr_group);
> +
> +static int cros_ec_vbc_probe(struct platform_device *pd)
> +{
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> +       struct device *dev = &pd->dev;
> +       int ret;
> +
> +       ret = sysfs_create_group(&ec_dev->class_dev.kobj,
> +                                &cros_ec_vbc_attr_group);
> +       if (ret < 0)
> +               dev_err(dev, "failed to create %s attributes. err=%d\n",
> +                       cros_ec_vbc_attr_group.name, ret);
> +
> +       return ret;
> +}
> +
> +static int cros_ec_vbc_remove(struct platform_device *pd)
> +{
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> +
> +       sysfs_remove_group(&ec_dev->class_dev.kobj,
> +                          &cros_ec_vbc_attr_group);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver cros_ec_vbc_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +       },
> +       .probe = cros_ec_vbc_probe,
> +       .remove = cros_ec_vbc_remove,
> +};
> +
> +module_platform_driver(cros_ec_vbc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Expose the vboot context nvram to userspace");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index b6beba3031ba..bbbe416fd573 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -325,7 +325,6 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
> -extern struct attribute_group cros_ec_vbc_attr_group;
>
>  /* debugfs stuff */
>  int cros_ec_debugfs_init(struct cros_ec_dev *ec);
> --
> 2.19.1
>
