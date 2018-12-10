Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE579C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898D72084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlaOT0kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898D72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeLJVuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:50:35 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42021 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbeLJVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:50:34 -0500
Received: by mail-yw1-f65.google.com with SMTP id x2so4600319ywc.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTVcSvhpAgwmKB1Jf/hYQbWGQNKohYq7VY90I+fEOtU=;
        b=nlaOT0khll0L8fcNRKCV3rciMRYEJ8l9HL8V+YhRVFFfi2EsZrG+/SEuspMzNLXSod
         4W0oChwRi7AVNuc3GBS+Mwo/1qh7XeNCa0RxvV7lwGb0do+jn47iNBQjaqVcMh1++oD+
         ifUD2lU9SRC/BXMSm3YxYlud118rNorHHeI6DWUORMnKnzCz6mifeXYYO7e8Z6TSv771
         bwknBmCecyAVaXGi/euKI0vJnKlx1l/X5SibsyVpGnIC/fpWHwKFCvrEgMr2lUHAU4GK
         3SfKnre5S3zAh+I9dWyIHqIxFz/nAgMGfFzlVtxmdyKYVPoNoMaKuccqw1L3aH5m4XAG
         YLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTVcSvhpAgwmKB1Jf/hYQbWGQNKohYq7VY90I+fEOtU=;
        b=Tcb4l+XpN8XORr8cPLZmUc3CpS96fdHF3XecG1qjuVI5lpQpFRR5cF1SXXH8EFKMH9
         1enPgK9sIBWcCzPxtu3gTlRbBOjJE7mRpD5aGuR+ng/eJMd5T2iCPJsLEHGYGYmlhyTu
         BBqTQ/8Ks/s7lwiF8AeeSLtULYVCg0qa5RhRdTw/94QgYlr9kx8aCu+e5LUJHd7CKkrF
         CFzn1BHlAqrmxhl47m0vlDBWfJ2VHJQSfcVJbmD+gAP/9vZPkrlXVjCddF8XZSgJEY6W
         vFfjVUl2TJZJjoAYVOjGyIKbaBIU/QMsEngizX3nms+Kwg5hnI2/JRtjZvdRRr4jK3or
         pAbw==
X-Gm-Message-State: AA+aEWYIJGWaBpd3PNSOGOCzggMqD9mmN9oEvhHrVZTqCGMs7MsDOlgn
        GXvXL0vpWjxzS0Pj4+chym7DqEmUCBXPB7t5YFtsRklRo+E=
X-Google-Smtp-Source: AFSGD/W0MFn6pj/Z+GAX0kXbvA/pXKGmVLTUB8MND+impBNDwzQ64YmoWSyRLF5LQV/ph0yoEN3aqI0s+K1I+S8nR1g=
X-Received: by 2002:a81:4853:: with SMTP id v80mr14225700ywa.266.1544478633289;
 Mon, 10 Dec 2018 13:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-6-enric.balletbo@collabora.com> <CABXOdTfxHU0ad9F0ieCLbMpxVDgdiANmu3ai35WFWUj85gvbWA@mail.gmail.com>
 <87b2e544-756d-87bb-7102-267d9babc636@collabora.com> <CABXOdTcb+D7_o0CLvuMwu1jmpVeWBS-D6Kk8R4ry_Ti5KZdycQ@mail.gmail.com>
 <CAFqH_51gYwAaw_e+ggh4+M2HU7_A73cYTAUuMnvn6Ab7K35H3g@mail.gmail.com>
In-Reply-To: <CAFqH_51gYwAaw_e+ggh4+M2HU7_A73cYTAUuMnvn6Ab7K35H3g@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 10 Dec 2018 13:50:22 -0800
Message-ID: <CABXOdTcpiVRxxr1D-vnubk-ALNrvoU0oVM7Cyr58soz_DOZPhQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mfd / platform: cros_ec: move device sysfs
 attributes to its own driver.
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
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

On Mon, Dec 10, 2018 at 1:27 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Missatge de Guenter Roeck <groeck@google.com> del dia dl., 10 de des.
> 2018 a les 19:34:
> >
> > On Mon, Dec 10, 2018 at 10:22 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Hi Guenter,
> > >
> > > On 10/12/18 19:13, Guenter Roeck wrote:
> > > > On Tue, Nov 27, 2018 at 4:19 AM Enric Balletbo i Serra
> > > > <enric.balletbo@collabora.com> wrote:
> > > >>
> > > >> The entire way how cros debugfs attibutes are created is broken.
> > > >> cros_ec_sysfs should be its own driver and its attributes should be
> > > >> associated with the sysfs driver not the mfd driver.
> > > >>
> > > >> The patch also adds the sysfs documentation.
> > > >>
> > > >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > >> ---
> > > >>
> > > >> Changes in v3:
> > > >> - Do not print ec_platform name as is with dev_err is enough.
> > > >>
> > > >> Changes in v2:
> > > >> - Create the attributes directly instead of use the attach/detach callbacks.
> > > >>
> > > >>  .../ABI/testing/sysfs-class-chromeos          | 32 +++++++++++++++++
> > > >>  drivers/mfd/Kconfig                           |  1 -
> > > >>  drivers/mfd/cros_ec_dev.c                     |  7 +---
> > > >>  drivers/platform/chrome/Kconfig               | 14 ++++++--
> > > >>  drivers/platform/chrome/Makefile              |  3 +-
> > > >>  drivers/platform/chrome/cros_ec_sysfs.c       | 36 ++++++++++++++++++-
> > > >>  include/linux/mfd/cros_ec.h                   |  3 --
> > > >>  7 files changed, 80 insertions(+), 16 deletions(-)
> > > >>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
> > > >>
> > > >> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
> > > >> new file mode 100644
> > > >> index 000000000000..a5399c4ca82d
> > > >> --- /dev/null
> > > >> +++ b/Documentation/ABI/testing/sysfs-class-chromeos
> > > >> @@ -0,0 +1,32 @@
> > > >> +What:          /sys/class/chromeos/<cros-ec>/flashinfo
> > > >
> > > > Why "<cros-ec>" and not "cros_ec" ?
> > > >
> > >
> > > Maybe will be more clear if I use <cros-ec-name>?
> > >
> > > Actually <cros-ec-name> can be cros_ec or cros_pd. I put between <> to indicate
> > > that is not the literal name.
> > >
> > Should that be mentioned somewhere ? Readers of this document won't
> > know what it stands for.
> >
>
> I assumed that <something> is the standard de facto, although I don't
> see that documented anywhere. If you do a grep it is extensively used.
> I.e:
>
> stable/sysfs-class-infiniband:199:What:
> /sys/class/infiniband/<device-name>/ports/<port-num>/hw_counters/lifespan
> testing/sysfs-class-power:3:What:
> /sys/class/power_supply/<supply_name>/manufacturer
> ... and many others
>
That makes sense if the name is determined by the driver, and there
are many drivers and no fixed name(s). Here we have exactly two
possible names.

> Maybe add a new entry at the beginning?
>
> What:          /sys/class/chromeos/<cros-ec-name>
> ...
> Description:
>               The cros-ec device name, i.e. cros_ec or cros_pd.
>
How about {cros_ec,cros_pd} instead of <cros-ec> ?
I see that used a few times where the names are well defined.

Thanks,
Guenter

> > Thanks,
> > Guenter
> >
> > > >> +Date:          August 2015
> > > >> +KernelVersion: 4.2
> > > >> +Description:
> > > >> +               Show the EC flash information.
> > > >> +
> > > >> +What:          /sys/class/chromeos/<cros-ec>/kb_wake_angle
> > > >> +Date:          March 2018
> > > >> +KernelVersion: 4.17
> > > >> +Description:
> > > >> +               Control the keyboard wake lid angle. Values are between
> > > >> +               0 and 360. This file will also show the keyboard wake lid
> > > >> +               angle by querying the hardware.
> > > >> +
> > > >> +What:          /sys/class/chromeos/<cros-ec>/reboot
> > > >> +Date:          August 2015
> > > >> +KernelVersion: 4.2
> > > >> +Description:
> > > >> +               Tell the EC to reboot in various ways. Options are:
> > > >> +               "cancel": Cancel a pending reboot.
> > > >> +               "ro": Jump to RO without rebooting.
> > > >> +               "rw": Jump to RW without rebooting.
> > > >> +               "cold": Cold reboot.
> > > >> +               "disable-jump": Disable jump until next reboot.
> > > >> +               "hibernate": Hibernate the EC.
> > > >> +               "at-shutdown": Reboot after an AP shutdown.
> > > >> +
> > > >> +What:          /sys/class/chromeos/<cros-ec>/version
> > > >> +Date:          August 2015
> > > >> +KernelVersion: 4.2
> > > >> +Description:
> > > >> +               Show the information about the EC software and hardware.
> > > >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > >> index 8c5dfdce4326..089ffb408918 100644
> > > >> --- a/drivers/mfd/Kconfig
> > > >> +++ b/drivers/mfd/Kconfig
> > > >> @@ -214,7 +214,6 @@ config MFD_CROS_EC
> > > >>  config MFD_CROS_EC_CHARDEV
> > > >>          tristate "Chrome OS Embedded Controller userspace device interface"
> > > >>          depends on MFD_CROS_EC
> > > >> -        select CROS_EC_CTL
> > > >>          ---help---
> > > >>            This driver adds support to talk with the ChromeOS EC from userspace.
> > > >>
> > > >> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > >> index 50ba8e0fb4ec..d9b16ce79319 100644
> > > >> --- a/drivers/mfd/cros_ec_dev.c
> > > >> +++ b/drivers/mfd/cros_ec_dev.c
> > > >> @@ -34,15 +34,9 @@
> > > >>  #define CROS_MAX_DEV 128
> > > >>  static int ec_major;
> > > >>
> > > >> -static const struct attribute_group *cros_ec_groups[] = {
> > > >> -       &cros_ec_attr_group,
> > > >> -       NULL,
> > > >> -};
> > > >> -
> > > >>  static struct class cros_class = {
> > > >>         .owner          = THIS_MODULE,
> > > >>         .name           = "chromeos",
> > > >> -       .dev_groups     = cros_ec_groups,
> > > >>  };
> > > >>
> > > >>  /* Basic communication */
> > > >> @@ -391,6 +385,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
> > > >>  static const struct mfd_cell cros_ec_platform_cells[] = {
> > > >>         { .name = "cros-ec-debugfs" },
> > > >>         { .name = "cros-ec-lightbar" },
> > > >> +       { .name = "cros-ec-sysfs" },
> > > >>         { .name = "cros-ec-vbc" },
> > > >>  };
> > > >>
> > > >> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> > > >> index 4e4232b47764..b709cc5173a2 100644
> > > >> --- a/drivers/platform/chrome/Kconfig
> > > >> +++ b/drivers/platform/chrome/Kconfig
> > > >> @@ -49,9 +49,6 @@ config CHROMEOS_TBMC
> > > >>           To compile this driver as a module, choose M here: the
> > > >>           module will be called chromeos_tbmc.
> > > >>
> > > >> -config CROS_EC_CTL
> > > >> -        tristate
> > > >> -
> > > >>  config CROS_EC_I2C
> > > >>         tristate "ChromeOS Embedded Controller (I2C)"
> > > >>         depends on MFD_CROS_EC && I2C
> > > >> @@ -142,4 +139,15 @@ config CROS_EC_DEBUGFS
> > > >>           To compile this driver as a module, choose M here: the
> > > >>           module will be called cros_ec_debugfs.
> > > >>
> > > >> +config CROS_EC_SYSFS
> > > >> +       tristate "ChromeOS EC control and information through sysfs"
> > > >> +       depends on MFD_CROS_EC_CHARDEV && SYSFS
> > > >> +       default y
> > > >
> > > > In practice this is limited to MFD_CROS_EC_CHARDEV, meaning it will be
> > > > set to m if MFD_CROS_EC_CHARDEV=m.
> > > > Not sure what is better here, but for consistency I would prefer
> > > > "default MFD_CROS_EC_CHARDEV" (or default y
> > > > in the entire series).
> > > >
> > >
> > > Right, makes sense that if the MFD_CROS_EC_CHARDEV is selected set also those by
> > > default. Will prepare a new version with that small change.
> > >
> > > >> +       help
> > > >> +         This option exposes some sysfs attributes to control and get
> > > >> +         information from ChromeOS EC.
> > > >> +
> > > >> +         To compile this driver as a module, choose M here: the
> > > >> +         module will be called cros_ec_sysfs.
> > > >> +
> > > >>  endif # CHROMEOS_PLATFORMS
> > > >> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> > > >> index 12a5c4d18c17..fdbee501931b 100644
> > > >> --- a/drivers/platform/chrome/Makefile
> > > >> +++ b/drivers/platform/chrome/Makefile
> > > >> @@ -3,8 +3,6 @@
> > > >>  obj-$(CONFIG_CHROMEOS_LAPTOP)          += chromeos_laptop.o
> > > >>  obj-$(CONFIG_CHROMEOS_PSTORE)          += chromeos_pstore.o
> > > >>  obj-$(CONFIG_CHROMEOS_TBMC)            += chromeos_tbmc.o
> > > >> -cros_ec_ctl-objs                       := cros_ec_sysfs.o
> > > >> -obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
> > > >>  obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
> > > >>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
> > > >>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
> > > >> @@ -15,3 +13,4 @@ obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)  += cros_kbd_led_backlight.o
> > > >>  obj-$(CONFIG_CROS_EC_LIGHTBAR)         += cros_ec_lightbar.o
> > > >>  obj-$(CONFIG_CROS_EC_VBC)              += cros_ec_vbc.o
> > > >>  obj-$(CONFIG_CROS_EC_DEBUGFS)          += cros_ec_debugfs.o
> > > >> +obj-$(CONFIG_CROS_EC_SYSFS)            += cros_ec_sysfs.o
> > > >> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> > > >> index f34a50121064..0ff5aa30c070 100644
> > > >> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> > > >> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> > > >> @@ -34,6 +34,8 @@
> > > >>  #include <linux/types.h>
> > > >>  #include <linux/uaccess.h>
> > > >>
> > > >> +#define DRV_NAME "cros-ec-sysfs"
> > > >> +
> > > >>  /* Accessor functions */
> > > >>
> > > >>  static ssize_t reboot_show(struct device *dev,
> > > >> @@ -353,7 +355,39 @@ struct attribute_group cros_ec_attr_group = {
> > > >>         .attrs = __ec_attrs,
> > > >>         .is_visible = cros_ec_ctrl_visible,
> > > >>  };
> > > >> -EXPORT_SYMBOL(cros_ec_attr_group);
> > > >> +
> > > >> +static int cros_ec_sysfs_probe(struct platform_device *pd)
> > > >> +{
> > > >> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> > > >> +       struct device *dev = &pd->dev;
> > > >> +       int ret;
> > > >> +
> > > >> +       ret = sysfs_create_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> > > >> +       if (ret < 0)
> > > >> +               dev_err(dev, "failed to create attributes. err=%d\n", ret);
> > > >> +
> > > >> +       return ret;
> > > >> +}
> > > >> +
> > > >> +static int cros_ec_sysfs_remove(struct platform_device *pd)
> > > >> +{
> > > >> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> > > >> +
> > > >> +       sysfs_remove_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> > > >> +
> > > >> +       return 0;
> > > >> +}
> > > >> +
> > > >> +static struct platform_driver cros_ec_sysfs_driver = {
> > > >> +       .driver = {
> > > >> +               .name = DRV_NAME,
> > > >> +       },
> > > >> +       .probe = cros_ec_sysfs_probe,
> > > >> +       .remove = cros_ec_sysfs_remove,
> > > >> +};
> > > >> +
> > > >> +module_platform_driver(cros_ec_sysfs_driver);
> > > >>
> > > >>  MODULE_LICENSE("GPL");
> > > >>  MODULE_DESCRIPTION("ChromeOS EC control driver");
> > > >> +MODULE_ALIAS("platform:" DRV_NAME);
> > > >> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> > > >> index 3e4401e2ceea..f718ad9c2132 100644
> > > >> --- a/include/linux/mfd/cros_ec.h
> > > >> +++ b/include/linux/mfd/cros_ec.h
> > > >> @@ -323,7 +323,4 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
> > > >>   */
> > > >>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> > > >>
> > > >> -/* sysfs stuff */
> > > >> -extern struct attribute_group cros_ec_attr_group;
> > > >> -
> > > >>  #endif /* __LINUX_MFD_CROS_EC_H */
> > > >> --
> > > >> 2.19.1
> > > >>
> > > >
