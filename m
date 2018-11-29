Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF4C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316AD20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHjEXpIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316AD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeK3Kle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:41:34 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34094 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Kld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:41:33 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so1542081ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kos50WSSfV7GzWpJfAmvnSFnqN2xZJZ6cBfTUrhHM+s=;
        b=OHjEXpIqgO7P1b/Elvn597Njxg6oNo3WUEgHpn1nJ5hdB4XKjUUTI3BQNfYxhzZV7o
         J5lMRWjO61fftqSOiIrqZgU4EiWTH4+mqER+QAOgV5U2t5ygSgIXHGgxqKWkxraEkv7i
         b7pFnQPxEUD2Grse7+NWAsr3s1FUMCw2lSfweUMdMGsGK/2hV1JQehwtmq7ow2NXPTUz
         VwOQQRHv3CJyfQX5ZRzqzxDecmpnAwd0Wcp+FOM3147AQAs2GbDcP69YnwrGGp6qKsvv
         ZOzmN14wl+ImbFBK+5BnmPWU9ws1uWxHVBk3PnYx6GZGHuwitQ7mLJzKA4KHObuFUTbQ
         SV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kos50WSSfV7GzWpJfAmvnSFnqN2xZJZ6cBfTUrhHM+s=;
        b=hI5F6xbftMGzzbDgWacDn40tzaBk4T+pcbanzYKkkBThDiZbWfCrM6RzqGCSHUtvGU
         XvuzsUL+Mpyb2cQ4XKEAtHla06hS3PTwAf4/A/KPzBT5LjUXYqfr1DBVGkMG7LrnPbGV
         Uo7JTDm3BKCapHtsbnTgTD2Zius/iyBWwRn6qP78Igh0/ENTDUae6UcBA1AH6w46jPxu
         NzGR1rdItYBQRUfbcPDFNbWFRziZbIF1SoZ4pORBdn1XAk1Xx8AZddJ9WmGSCx22avS8
         IC1inHolwRkpbQtPnv6uhaCEqLWzLRRUG4p2PA7S1A7Hw/nIbiU4GV7k8ZwCmDFbNKE3
         v4ng==
X-Gm-Message-State: AA+aEWaLVtoOyKPM/7mdpb1nQ4hgdgYEZUe+Dr4uBhMe8FYbeoX6Abx3
        QwDGC6j43CToQxJ9l+2kT7kyb/jf+oCMAEA/eip7uw==
X-Google-Smtp-Source: AFSGD/Wl56MtKqchsQvQq4axt1q8N7w8e5CJo4F03UjsOciClKayMjwMJGi7/AauXa43zbxqmoVjqN8E7AVeBfgOUNo=
X-Received: by 2002:a81:ac1f:: with SMTP id k31mr3524313ywh.320.1543534458758;
 Thu, 29 Nov 2018 15:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com> <20181127121849.23975-3-enric.balletbo@collabora.com>
In-Reply-To: <20181127121849.23975-3-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 29 Nov 2018 15:34:07 -0800
Message-ID: <CABXOdTfXZS7-=JML6QNjrWR_vGpWWUUjwedrxBaqPtc_pLyHUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The entire way how cros sysfs attibutes are created is broken.
> cros_ec_lightbar should be its own driver and its attributes should be
> associated with a lightbar driver not the mfd driver. In order to retain
> the path, the lightbar attributes are attached to the cros_class.
>
> The patch also adds the sysfs documentation.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Removed unneded check for ec_dev.
>
> Changes in v2:
> - Removed the two exported functions to attach/detach to the cros_class.
> - Use dev_warn instead of dev_err when adding the lightbar.
>
>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
>  drivers/mfd/cros_ec_dev.h                     |  6 --
>  drivers/platform/chrome/Kconfig               | 10 ++
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
>  include/linux/mfd/cros_ec.h                   |  1 -
>  7 files changed, 172 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver=
-cros-ec-lightbar
>
> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-e=
c-lightbar b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-=
lightbar
> new file mode 100644
> index 000000000000..4893fd2e956f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-light=
bar
> @@ -0,0 +1,74 @@
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/brightness
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               Writing to this file adjusts the overall brightness of
> +               the lightbar, separate from any color intensity. The
> +               valid range is 0 (off) to 255 (maximum brightness).
> +
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/interval_msec
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               The lightbar is controlled by an embedded controller (EC)=
,
> +               which also manages the keyboard, battery charging, fans,
> +               and other system hardware. To prevent unprivileged users
> +               from interfering with the other EC functions, the rate at
> +               which the lightbar control files can be read or written i=
s
> +               limited.
> +
> +               Reading this file will return the number of milliseconds
> +               that must elapse between accessing any of the lightbar
> +               functions through this interface. Going faster will simpl=
y
> +               block until the necessary interval has lapsed. The interv=
al
> +               applies uniformly to all accesses of any kind by any user=
.
> +
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/led_rgb
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               This allows you to control each LED segment. If the
> +               lightbar is already running one of the automatic
> +               sequences, you probably won=E2=80=99t see anything change=
 because
> +               your color setting will be almost immediately replaced.
> +               To get useful results, you should stop the lightbar
> +               sequence first.
> +
> +               The values written to this file are sets of four integers=
,
> +               indicating LED, RED, GREEN, BLUE. The LED number is 0 to =
3
> +               to select a single segment, or 4 to set all four segments
> +               to the same value at once. The RED, GREEN, and BLUE
> +               numbers should be in the range 0 (off) to 255 (maximum).
> +               You can update more than one segment at a time by writing
> +               more than one set of four integers.
> +
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/program
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               This allows you to upload and run custom lightbar sequenc=
es.
> +
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/sequence
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               The Pixel lightbar has a number of built-in sequences
> +               that it displays under various conditions, such as at
> +               power on, shut down, or while running. Reading from this
> +               file displays the current sequence that the lightbar is
> +               displaying. Writing to this file allows you to change the
> +               sequence.
> +
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/userspace_control
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               This allows you to take the control of the lightbar. This
> +               prevents the kernel from going through its normal
> +               sequences.
> +
> +What:          /sys/class/chromeos/<cros-ec>/lightbar/version
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               Show the information about the lightbar version.
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index ff788d3e6d5f..614f888c9d6d 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -36,7 +36,6 @@ static int ec_major;
>
>  static const struct attribute_group *cros_ec_groups[] =3D {
>         &cros_ec_attr_group,
> -       &cros_ec_lightbar_attr_group,
>         &cros_ec_vbc_attr_group,
>         NULL,
>  };
> @@ -390,6 +389,10 @@ static const struct mfd_cell cros_usbpd_charger_cell=
s[] =3D {
>         { .name =3D "cros-usbpd-charger" }
>  };
>
> +static const struct mfd_cell cros_ec_platform_cells[] =3D {
> +       { .name =3D "cros-ec-lightbar" },
> +};
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>         int retval =3D -ENOMEM;
> @@ -464,9 +467,6 @@ static int ec_device_probe(struct platform_device *pd=
ev)
>                                 retval);
>         }
>
> -       /* Take control of the lightbar from the EC. */
> -       lb_manual_suspend_ctrl(ec, 1);
> -
>         /* We can now add the sysfs class, we know which parameter to sho=
w */
>         retval =3D cdev_device_add(&ec->cdev, &ec->class_dev);
>         if (retval) {
> @@ -474,6 +474,15 @@ static int ec_device_probe(struct platform_device *p=
dev)
>                 goto failed;
>         }
>
> +       retval =3D mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> +                                cros_ec_platform_cells,
> +                                ARRAY_SIZE(cros_ec_platform_cells),
> +                                NULL, 0, NULL);
> +       if (retval)
> +               dev_warn(ec->dev,
> +                        "failed to add cros-ec platform devices: %d\n",
> +                        retval);
> +
>         if (cros_ec_debugfs_init(ec))
>                 dev_warn(dev, "failed to create debugfs directory\n");
>
> @@ -488,9 +497,6 @@ static int ec_device_remove(struct platform_device *p=
dev)
>  {
>         struct cros_ec_dev *ec =3D dev_get_drvdata(&pdev->dev);
>
> -       /* Let the EC take over the lightbar again. */
> -       lb_manual_suspend_ctrl(ec, 0);
> -
>         cros_ec_debugfs_remove(ec);
>
>         mfd_remove_devices(ec->dev);
> @@ -519,8 +525,6 @@ static __maybe_unused int ec_device_suspend(struct de=
vice *dev)
>
>         cros_ec_debugfs_suspend(ec);
>
> -       lb_suspend(ec);
> -
>         return 0;
>  }
>
> @@ -530,8 +534,6 @@ static __maybe_unused int ec_device_resume(struct dev=
ice *dev)
>
>         cros_ec_debugfs_resume(ec);
>
> -       lb_resume(ec);
> -
>         return 0;
>  }
>
> diff --git a/drivers/mfd/cros_ec_dev.h b/drivers/mfd/cros_ec_dev.h
> index 978d836a0248..ec750433455a 100644
> --- a/drivers/mfd/cros_ec_dev.h
> +++ b/drivers/mfd/cros_ec_dev.h
> @@ -44,10 +44,4 @@ struct cros_ec_readmem {
>  #define CROS_EC_DEV_IOCXCMD   _IOWR(CROS_EC_DEV_IOC, 0, struct cros_ec_c=
ommand)
>  #define CROS_EC_DEV_IOCRDMEM  _IOWR(CROS_EC_DEV_IOC, 1, struct cros_ec_r=
eadmem)
>
> -/* Lightbar utilities */
> -extern bool ec_has_lightbar(struct cros_ec_dev *ec);
> -extern int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable=
);
> -extern int lb_suspend(struct cros_ec_dev *ec);
> -extern int lb_resume(struct cros_ec_dev *ec);
> -
>  #endif /* _CROS_EC_DEV_H_ */
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index 16b1615958aa..05bcefbe1926 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -111,4 +111,14 @@ config CROS_KBD_LED_BACKLIGHT
>           To compile this driver as a module, choose M here: the
>           module will be called cros_kbd_led_backlight.
>
> +config CROS_EC_LIGHTBAR
> +       tristate "Chromebook Pixel's lightbar support"
> +       depends on MFD_CROS_EC_CHARDEV
> +       help
> +         This option exposes the Chromebook Pixel's lightbar to
> +         userspace.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called cros_ec_lightbar.
> +
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index cd591bf872bb..3c29a4b405d5 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -3,7 +3,7 @@
>  obj-$(CONFIG_CHROMEOS_LAPTOP)          +=3D chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)          +=3D chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)            +=3D chromeos_tbmc.o
> -cros_ec_ctl-objs                       :=3D cros_ec_sysfs.o cros_ec_ligh=
tbar.o \
> +cros_ec_ctl-objs                       :=3D cros_ec_sysfs.o \
>                                            cros_ec_vbc.o cros_ec_debugfs.=
o
>  obj-$(CONFIG_CROS_EC_CTL)              +=3D cros_ec_ctl.o
>  obj-$(CONFIG_CROS_EC_I2C)              +=3D cros_ec_i2c.o
> @@ -13,3 +13,4 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)        +=3D cros=
_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              +=3D cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)            +=3D cros_ec_proto.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)   +=3D cros_kbd_led_backlight.o
> +obj-$(CONFIG_CROS_EC_LIGHTBAR)         +=3D cros_ec_lightbar.o
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platfor=
m/chrome/cros_ec_lightbar.c
> index 68193bb53383..80eed6317570 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -33,6 +33,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
>
> +#define DRV_NAME "cros-ec-lightbar"
> +
>  /* Rate-limit the lightbar interface to prevent DoS. */
>  static unsigned long lb_interval_jiffies =3D 50 * HZ / 1000;
>
> @@ -373,7 +375,7 @@ static int lb_send_empty_cmd(struct cros_ec_dev *ec, =
uint8_t cmd)
>         return ret;
>  }
>
> -int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
> +static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable=
)
>  {
>         struct ec_params_lightbar *param;
>         struct cros_ec_command *msg;
> @@ -408,25 +410,6 @@ int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, u=
int8_t enable)
>
>         return ret;
>  }
> -EXPORT_SYMBOL(lb_manual_suspend_ctrl);
> -
> -int lb_suspend(struct cros_ec_dev *ec)
> -{
> -       if (userspace_control || ec !=3D ec_with_lightbar)
> -               return 0;
> -
> -       return lb_send_empty_cmd(ec, LIGHTBAR_CMD_SUSPEND);
> -}
> -EXPORT_SYMBOL(lb_suspend);
> -
> -int lb_resume(struct cros_ec_dev *ec)
> -{
> -       if (userspace_control || ec !=3D ec_with_lightbar)
> -               return 0;
> -
> -       return lb_send_empty_cmd(ec, LIGHTBAR_CMD_RESUME);
> -}
> -EXPORT_SYMBOL(lb_resume);
>
>  static ssize_t sequence_store(struct device *dev, struct device_attribut=
e *attr,
>                               const char *buf, size_t count)
> @@ -584,7 +567,7 @@ static struct attribute *__lb_cmds_attrs[] =3D {
>         NULL,
>  };
>
> -bool ec_has_lightbar(struct cros_ec_dev *ec)
> +static bool ec_has_lightbar(struct cros_ec_dev *ec)
>  {
>         return !!get_lightbar_version(ec, NULL, NULL);
>  }
> @@ -616,4 +599,72 @@ struct attribute_group cros_ec_lightbar_attr_group =
=3D {
>         .attrs =3D __lb_cmds_attrs,
>         .is_visible =3D cros_ec_lightbar_attrs_are_visible,
>  };
> -EXPORT_SYMBOL(cros_ec_lightbar_attr_group);
> +
> +static int cros_ec_lightbar_probe(struct platform_device *pd)
> +{
> +       struct cros_ec_dev *ec_dev =3D dev_get_drvdata(pd->dev.parent);
> +       struct device *dev =3D &pd->dev;
> +       int ret;
> +
> +       /* Take control of the lightbar from the EC. */
> +       lb_manual_suspend_ctrl(ec_dev, 1);
> +
> +       ret =3D sysfs_create_group(&ec_dev->class_dev.kobj,
> +                                &cros_ec_lightbar_attr_group);
> +       if (ret < 0)
> +               dev_err(dev, "failed to create %s attributes. err=3D%d\n"=
,
> +                       cros_ec_lightbar_attr_group.name, ret);
> +
> +       return ret;
> +}
> +
> +static int cros_ec_lightbar_remove(struct platform_device *pd)
> +{
> +       struct cros_ec_dev *ec_dev =3D dev_get_drvdata(pd->dev.parent);
> +
> +       sysfs_remove_group(&ec_dev->class_dev.kobj,
> +                          &cros_ec_lightbar_attr_group);
> +
> +       /* Let the EC take over the lightbar again. */
> +       lb_manual_suspend_ctrl(ec_dev, 0);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
> +{
> +       struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev);
> +
> +       if (userspace_control || ec_dev !=3D ec_with_lightbar)
> +               return 0;
> +
> +       return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
> +}
> +
> +static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
> +{
> +       struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev);
> +
> +       if (userspace_control || ec_dev !=3D ec_with_lightbar)
> +               return 0;
> +
> +       return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_lightbar_pm_ops,
> +                        cros_ec_lightbar_suspend, cros_ec_lightbar_resum=
e);
> +
> +static struct platform_driver cros_ec_lightbar_driver =3D {
> +       .driver =3D {
> +               .name =3D DRV_NAME,
> +               .pm =3D &cros_ec_lightbar_pm_ops,
> +       },
> +       .probe =3D cros_ec_lightbar_probe,
> +       .remove =3D cros_ec_lightbar_remove,
> +};
> +
> +module_platform_driver(cros_ec_lightbar_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Expose the Chromebook Pixel's lightbar to userspace"=
);
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 706dd724de52..b6beba3031ba 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -325,7 +325,6 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_=
dev);
>
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
> -extern struct attribute_group cros_ec_lightbar_attr_group;
>  extern struct attribute_group cros_ec_vbc_attr_group;
>
>  /* debugfs stuff */
> --
> 2.19.1
>
