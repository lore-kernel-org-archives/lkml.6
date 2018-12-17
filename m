Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B4320675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtlBk8fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbeLQSNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:13:02 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40816 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbeLQSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:13:02 -0500
Received: by mail-yw1-f67.google.com with SMTP id r130so5548228ywg.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYVM8THSz58fFBYIazl4ebAL3UKt9l1mjpjOniNt0oI=;
        b=EtlBk8fjRUGqMwWFJo/np8B3xsJ5xrEwRC44ZjBrqFhwtalpLfQjhcyLw7RJ0QOYS8
         sZL9M+njg4s/1hiP25LMMmD2vwhbwuwxJ9JoENuUr86ZodSu4jPQEluPZfWx17iptagC
         uKHaztvYleIfN/GBa4oqfymXFshcSnfSCXFabLkJYArL7zsnouhH3rLcJREEFW8VaVII
         sIqGegi1AIemdcLeF5MsA2Y+uIML5wKZym6zBgWOEZBVlsQl791YCD4RoovSKjHL3U1r
         eVWYbIigS7Jntbu/Ym7htsMi+96Csyqh3wcctCCAQFJDOLWYXUwdpY1C96aHbw0xZfDS
         UcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYVM8THSz58fFBYIazl4ebAL3UKt9l1mjpjOniNt0oI=;
        b=apgZc+XVivEm3sm/nQN1nMMipwQ8ifhXTkqZQ2s9JCFROhQDVK56krJEQ1h/9qEKEy
         X6Cq81mAPS5nyYWwXRoMet3kaDZ+AJGRtS4ibmKobbF9DS3emfn+tZ5bSToYnIbuyvzv
         eo+N/Y7lE4NQU5O0h9Y+H5icHm8sJss+qdAo17bZrHaIhpeZ0O/HgXxH9aD6efaXLG5t
         egkk4tCb4TZ53ETsm1qs8mgVbsl6CUzj5dBj7Dpgn0fQAu0EUWjJym8SORIo05QCV6gR
         5SirjLYyX0/xjN+dQy1U3IxqcckkB9gRlJoRyb/5J0GLCI/BbFwZpG6c/eAeWqP+dIV+
         V9VA==
X-Gm-Message-State: AA+aEWbtSQDBkJU5UJXQOTptGHH3CDvPTuabIXkat2vtG136fjxTR6Nd
        jk6+u97foNpzWCcJOAQQV+qRTsn8W8ZkaMeddTx/Ag==
X-Google-Smtp-Source: AFSGD/Vv9miKMOuRYMbfPTqJ0Lr780RCAGrz2tgoUqSE7lbA8vjmZHnxLTcSUx06Nx3jj4qvWp1VVqdzMfqp4CrQYvY=
X-Received: by 2002:a81:ec12:: with SMTP id j18mr4692504ywm.17.1545070380797;
 Mon, 17 Dec 2018 10:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com> <20181215001843.62404-4-ncrews@google.com>
 <CAFqH_53+14ry7swScRcyAs7128c2puyzWuMRoMtiaDVXHAGh8w@mail.gmail.com>
In-Reply-To: <CAFqH_53+14ry7swScRcyAs7128c2puyzWuMRoMtiaDVXHAGh8w@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 17 Dec 2018 10:12:49 -0800
Message-ID: <CABXOdTe2OMiuX8PmvkKE-M6Q=7gjqoff8XrQfc+p3jbQWnKSyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] CHROMIUM: wilco_ec: Add sysfs attributes
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Nick Crews <ncrews@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 8:46 AM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Nick,
>
> Many thanks for sending this upstream. Adding Guenter as also might be
> interested, and some comments and questions below.
>
> Missatge de Nick Crews <ncrews@google.com> del dia ds., 15 de des.
> 2018 a les 1:20:
> >
> > From: Duncan Laurie <dlaurie@google.com>
> >
> > Add some sample sysfs attributes for the Wilco EC that show how
> > the mailbox interface works.
> >
> > > cat /sys/bus/platform/devices/GOOG000C\:00/version
> > Label        : 99.99.99
> > SVN Revision : 738ed.99
> > Model Number : 08;8
> > Build Date   : 08/30/18
> >
> > Signed-off-by: Duncan Laurie <dlaurie@google.com>
> > Signed-off-by: Nick Crews <ncrews@google.com>
> > ---
> >
> >  drivers/platform/chrome/Makefile           |   3 +-
> >  drivers/platform/chrome/wilco_ec.h         |  14 +++
> >  drivers/platform/chrome/wilco_ec_mailbox.c |  12 ++
> >  drivers/platform/chrome/wilco_ec_sysfs.c   | 121 +++++++++++++++++++++
>
> I am wondering if this should have its own driver (like we recently
> did for cros_ec) or if it should be integrated into the wilco core.
> Also, I am wondering if this should be attached to the cros_ec_class
> or not ( /sys/class/chromeos/wilco_ec ? ). Guenter and Benson, any
> opinion here?
>
I would agree.

> Anyway, you should add the documentation of the sysfs entries, please.
>
> >  4 files changed, 148 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/platform/chrome/wilco_ec_sysfs.c
> >
> > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> > index b132ba5b3e3d..e8603bc5b095 100644
> > --- a/drivers/platform/chrome/Makefile
> > +++ b/drivers/platform/chrome/Makefile
> > @@ -13,6 +13,5 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)        += cros_ec_lpc_mec.o
> >  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
> >  obj-$(CONFIG_CROS_EC_PROTO)            += cros_ec_proto.o
> >
> > -obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)   += cros_kbd_led_backlight.o
>
> I guess that you don't want to do this :)
>
> > -wilco_ec-objs                          := wilco_ec_mailbox.o
> > +wilco_ec-objs                          := wilco_ec_mailbox.o wilco_ec_sysfs.o
> >  obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
> > diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome/wilco_ec.h
> > index ba16fcff87c4..699f4cf744dc 100644
> > --- a/drivers/platform/chrome/wilco_ec.h
> > +++ b/drivers/platform/chrome/wilco_ec.h
> > @@ -94,4 +94,18 @@ struct wilco_ec_message {
> >   */
> >  int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
> >
> > +/**
> > + * wilco_ec_sysfs_init() - Create sysfs attributes.
> > + * @ec: EC device.
> > + *
> > + * Return: 0 for success or negative error code on failure.
> > + */
> > +int wilco_ec_sysfs_init(struct wilco_ec_device *ec);
> > +
> > +/**
> > + * wilco_ec_sysfs_remove() - Remove sysfs attributes.
> > + * @ec: EC device.
> > + */
> > +void wilco_ec_sysfs_remove(struct wilco_ec_device *ec);
> > +
> >  #endif /* WILCO_EC_H */
> > diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platform/chrome/wilco_ec_mailbox.c
> > index 6613c18c2a82..414ea0a8ad03 100644
> > --- a/drivers/platform/chrome/wilco_ec_mailbox.c
> > +++ b/drivers/platform/chrome/wilco_ec_mailbox.c
> > @@ -361,11 +361,23 @@ static int wilco_ec_probe(struct platform_device *pdev)
> >         cros_ec_lpc_mec_init(ec->io_packet->start,
> >                              ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
> >
> > +       /* Create sysfs attributes for userspace interaction */
> > +       if (wilco_ec_sysfs_init(ec) < 0) {
> > +               dev_err(dev, "Failed to create sysfs attributes\n");
> > +               cros_ec_lpc_mec_destroy();
> > +               return -ENODEV;
> > +       }
> > +
> >         return 0;
> >  }
> >
> >  static int wilco_ec_remove(struct platform_device *pdev)
> >  {
> > +       struct wilco_ec_device *ec = platform_get_drvdata(pdev);
> > +
> > +       /* Remove sysfs attributes */
> > +       wilco_ec_sysfs_remove(ec);
> > +
> >         /* Teardown cros_ec interface */
> >         cros_ec_lpc_mec_destroy();
> >
> > diff --git a/drivers/platform/chrome/wilco_ec_sysfs.c b/drivers/platform/chrome/wilco_ec_sysfs.c
> > new file mode 100644
> > index 000000000000..f9ae6cef6169
> > --- /dev/null
> > +++ b/drivers/platform/chrome/wilco_ec_sysfs.c
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * wilco_ec_sysfs - Sysfs attributes for Wilco Embedded Controller
>
> Remove 'wilco_ec_sysfs -'.
>
> > + *
> > + * Copyright 2018 Google LLC
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
>
> Remove the license boiler-plate.
>
> > + */
> > +
> > +#include <linux/ctype.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sysfs.h>
> > +#include "wilco_ec.h"
> > +
> > +#define EC_COMMAND_EC_INFO             0x38
> > +#define EC_INFO_SIZE                    9
> > +#define EC_COMMAND_STEALTH_MODE                0xfc
> > +
> > +struct ec_info {
> > +       u8 index;
> > +       const char *label;
> > +};
> > +
> > +static ssize_t wilco_ec_show_info(struct wilco_ec_device *ec, char *buf,
> > +                                 ssize_t count, struct ec_info *info)
> > +{
> > +       char result[EC_INFO_SIZE];
> > +       struct wilco_ec_message msg = {
> > +               .type = WILCO_EC_MSG_LEGACY,
> > +               .command = EC_COMMAND_EC_INFO,
> > +               .request_data = &info->index,
> > +               .request_size = sizeof(info->index),
> > +               .response_data = result,
> > +               .response_size = EC_INFO_SIZE,
> > +       };
> > +       int ret;
> > +
> > +       ret = wilco_ec_mailbox(ec, &msg);
> > +       if (ret != EC_INFO_SIZE)
> > +               return scnprintf(buf + count, PAGE_SIZE - count,
> > +                                "%-12s : ERROR %d\n", info->label, ret);
> > +
> > +       return scnprintf(buf + count, PAGE_SIZE - count,
> > +                        "%-12s : %s\n", info->label, result);
> > +}
> > +
> > +static ssize_t version_show(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
> > +       struct ec_info wilco_ec_info[] = {
> > +               { 0, "Label" },
> > +               { 1, "SVN Revision" },
> > +               { 2, "Model Number" },
> > +               { 3, "Build Date" },
> > +               { 0xff, NULL },
> > +       };

sysfs conventions ask for separate attributes for each of those.

> > +       struct ec_info *info = wilco_ec_info;
> > +       ssize_t c = 0;
> > +
> > +       for (info = wilco_ec_info; info->label; info++)
> > +               c += wilco_ec_show_info(ec, buf, c, info);
> > +
> > +       return c;
> > +}
> > +
> > +static ssize_t stealth_mode_store(struct device *dev,
> > +                                 struct device_attribute *attr,
> > +                                 const char *buf, size_t count)
> > +{
> > +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
> > +       u8 param;
> > +       struct wilco_ec_message msg = {
> > +               .type = WILCO_EC_MSG_LEGACY,
> > +               .command = EC_COMMAND_STEALTH_MODE,
> > +               .request_data = &param,
> > +               .request_size = sizeof(param),
> > +       };
> > +       int ret;
> > +       bool enable;
> > +
> > +       ret = kstrtobool(buf, &enable);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Invert input parameter, EC expects 0=on and 1=off */
> > +       param = enable ? 0 : 1;

Why not just !enable ?

> > +
> > +       ret = wilco_ec_mailbox(ec, &msg);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return count;
> > +}
> > +
> > +static DEVICE_ATTR_RO(version);
> > +static DEVICE_ATTR_WO(stealth_mode);
> > +
> > +static struct attribute *wilco_ec_attrs[] = {
> > +       &dev_attr_version.attr,
> > +       &dev_attr_stealth_mode.attr,
> > +       NULL
> > +};
> > +ATTRIBUTE_GROUPS(wilco_ec);
> > +
> > +int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
> > +{
> > +       return sysfs_create_groups(&ec->dev->kobj, wilco_ec_groups);
> > +}
> > +
> > +void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
> > +{
> > +       sysfs_remove_groups(&ec->dev->kobj, wilco_ec_groups);
> > +}
> > --
> > 2.20.0.405.gbc1bbc6f85-goog
> >
>
> Thanks,
>   Enric
