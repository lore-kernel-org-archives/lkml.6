Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F014C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4192220824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPn+dnPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4192220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJXVgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:36:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42211 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:36:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id j46-v6so5564893qtc.9;
        Wed, 24 Oct 2018 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQkNsb39i5oj5Nm2fLxksUT8GnTwIdar3mA2ZMpq/xU=;
        b=dPn+dnPb9qmWoy5uzzl0Pu53sYVdZ6TjbqAvqGzXSlOZu2EmS0fsnlHtKPyXdZ/1gx
         gocvMm24vfw0UMCFmLwOe7K50NMClyvqBqzHJ52wp/+RdP6cnlZp1udbgBEG7fq/InOv
         nhpynWLDc9A08KmRKjR2sdUji0BolI4FZWBeDQtC5fFO6+AC5KtJKx7QQ3ZMg0Gr/p0t
         sCOz7JjTnulC10lzLKq5PUkosvb4Rp8gu7UOfv+x7jvgN2aDs1TDoJjYBGI1YcPMx1Gf
         GqDQAIZ/EO217qQ5nSlUqV9lPH+akNfTlSHDhP8ZBhblMb96jWVemlFLFgcvXX14PZNy
         sIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQkNsb39i5oj5Nm2fLxksUT8GnTwIdar3mA2ZMpq/xU=;
        b=ZRZRizJJfz5HKsYTEkmjHRCYWJy8GI+4MWJRc08v0IkjAwEkO6ZtigJHlnvjxR95D5
         +AD7+neo2B5WJxBTa4pdnm/PIhu22ZbXwZXr1S57/0vDqt1d+p7qWA358c1KvM5cpIwL
         4bO/TIRjsHAOSH/LwlGFEU0OTZW34tySgFRHmpKXBt79UnruHdVUiNDg75N+ADyZQXD6
         nLrm0zkphMUNxyJXXFn0gIm79ZKej2T2SOCgJ5/5XWI4wBhaPAgWFnEMeZpJa9z41E2b
         1jWsZKblUOvalq0iT56XyuFyVwkP+Dg5/lsEdvI+3ehHuIRSo6A+ZyFFkOWI4vUJmN5m
         Yw9Q==
X-Gm-Message-State: AGRZ1gJBHgQLQSch6L8uT++l+TIMcCeAivN8cQqIkZfi5ehst9/0or5T
        PMsGP5sssDKsjItChpdvoiSWVs7uDe++/LoHiUM=
X-Google-Smtp-Source: AJdET5ftFkOulkjOecmRLzMR6RPwd1p/XcttzQzYsa6t0nbKaKJ8xJB12dXLrYMeTUY6QDbaa4rpT1o1lXz3LEp+G7k=
X-Received: by 2002:aed:3b4b:: with SMTP id q11-v6mr2302157qte.229.1540386522891;
 Wed, 24 Oct 2018 06:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <1540401136-78500-1-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540401136-78500-1-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Oct 2018 16:08:30 +0300
Message-ID: <CAHp75VdJ2LykRx0A8_qHFbA-RCVoeBJq7Sj_0OzVJ0jZXAXA5g@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] misc/pvpanic: move pvpanic to misc as common driver
To:     peng.hao2@zte.com.cn, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:02 PM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> move pvpanic.c from drivers/platform/x86 to drivers/misc.
> following patches will use pvpanic device in arm64.
>

-C -M usually helps in such patches.

The question is perhaps this should go under drivers/acpi?

Rafael, what do you think?

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/Kconfig           |   7 +++
>  drivers/misc/Makefile          |   1 +
>  drivers/misc/pvpanic.c         | 124 +++++++++++++++++++++++++++++++++++++++++
>  drivers/platform/Kconfig       |   3 +
>  drivers/platform/Makefile      |   1 +
>  drivers/platform/x86/Kconfig   |   8 ---
>  drivers/platform/x86/Makefile  |   1 -
>  drivers/platform/x86/pvpanic.c | 124 -----------------------------------------
>  8 files changed, 136 insertions(+), 133 deletions(-)
>  create mode 100644 drivers/misc/pvpanic.c
>  delete mode 100644 drivers/platform/x86/pvpanic.c
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 5d71300..ca55c94 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -499,6 +499,13 @@ config MISC_RTSX
>         tristate
>         default MISC_RTSX_PCI || MISC_RTSX_USB
>
> +config PVPANIC
> +       tristate "pvpanic device support"
> +       help
> +          This driver provides support for the pvpanic device.  pvpanic is
> +          a paravirtualized device provided by QEMU; it lets a virtual machine
> +          (guest) communicate panic events to the host.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 20be70c..39dc005 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)        += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
>  obj-$(CONFIG_MISC_RTSX)                += cardreader/
> +obj-$(CONFIG_PVPANIC)                  += pvpanic.o
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> new file mode 100644
> index 0000000..fd86dab
> --- /dev/null
> +++ b/drivers/misc/pvpanic.c
> @@ -0,0 +1,124 @@
> +/*
> + *  pvpanic.c - pvpanic Device Support
> + *
> + *  Copyright (C) 2013 Fujitsu.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/acpi.h>
> +
> +MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
> +MODULE_DESCRIPTION("pvpanic device driver");
> +MODULE_LICENSE("GPL");
> +
> +static int pvpanic_add(struct acpi_device *device);
> +static int pvpanic_remove(struct acpi_device *device);
> +
> +static const struct acpi_device_id pvpanic_device_ids[] = {
> +       { "QEMU0001", 0 },
> +       { "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
> +
> +#define PVPANIC_PANICKED       (1 << 0)
> +
> +static u16 port;
> +
> +static struct acpi_driver pvpanic_driver = {
> +       .name =         "pvpanic",
> +       .class =        "QEMU",
> +       .ids =          pvpanic_device_ids,
> +       .ops =          {
> +                               .add =          pvpanic_add,
> +                               .remove =       pvpanic_remove,
> +                       },
> +       .owner =        THIS_MODULE,
> +};
> +
> +static void
> +pvpanic_send_event(unsigned int event)
> +{
> +       outb(event, port);
> +}
> +
> +static int
> +pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
> +                    void *unused)
> +{
> +       pvpanic_send_event(PVPANIC_PANICKED);
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pvpanic_panic_nb = {
> +       .notifier_call = pvpanic_panic_notify,
> +       .priority = 1, /* let this called before broken drm_fb_helper */
> +};
> +
> +
> +static acpi_status
> +pvpanic_walk_resources(struct acpi_resource *res, void *context)
> +{
> +       switch (res->type) {
> +       case ACPI_RESOURCE_TYPE_END_TAG:
> +               return AE_OK;
> +
> +       case ACPI_RESOURCE_TYPE_IO:
> +               port = res->data.io.minimum;
> +               return AE_OK;
> +
> +       default:
> +               return AE_ERROR;
> +       }
> +}
> +
> +static int pvpanic_add(struct acpi_device *device)
> +{
> +       int ret;
> +
> +       ret = acpi_bus_get_status(device);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!device->status.enabled || !device->status.functional)
> +               return -ENODEV;
> +
> +       acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +                           pvpanic_walk_resources, NULL);
> +
> +       if (!port)
> +               return -ENODEV;
> +
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +                                      &pvpanic_panic_nb);
> +
> +       return 0;
> +}
> +
> +static int pvpanic_remove(struct acpi_device *device)
> +{
> +
> +       atomic_notifier_chain_unregister(&panic_notifier_list,
> +                                        &pvpanic_panic_nb);
> +       return 0;
> +}
> +
> +module_acpi_driver(pvpanic_driver);
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index d4c2e42..8b64b78 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,3 +1,6 @@
> +if ARM64
> +source "drivers/platform/arm/Kconfig"
> +endif
>  if X86
>  source "drivers/platform/x86/Kconfig"
>  endif
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 4b2ce58..232231c 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for linux/drivers/platform
>  #
>
> +obj-$(CONFIG_ARM64)               += arm/
>  obj-$(CONFIG_X86)              += x86/
>  obj-$(CONFIG_MELLANOX_PLATFORM)        += mellanox/
>  obj-$(CONFIG_MIPS)             += mips/
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ef016e4..a6b412e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1119,14 +1119,6 @@ config INTEL_SMARTCONNECT
>           This driver checks to determine whether the device has Intel Smart
>           Connect enabled, and if so disables it.
>
> -config PVPANIC
> -       tristate "pvpanic device support"
> -       depends on ACPI
> -       ---help---
> -         This driver provides support for the pvpanic device.  pvpanic is
> -         a paravirtualized device provided by QEMU; it lets a virtual machine
> -         (guest) communicate panic events to the host.
> -
>  config INTEL_PMC_IPC
>         tristate "Intel PMC IPC Driver"
>         depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2ba6cb7..a4ec299 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -75,7 +75,6 @@ obj-$(CONFIG_APPLE_GMUX)      += apple-gmux.o
>  obj-$(CONFIG_INTEL_RST)                += intel-rst.o
>  obj-$(CONFIG_INTEL_SMARTCONNECT)       += intel-smartconnect.o
>
> -obj-$(CONFIG_PVPANIC)           += pvpanic.o
>  obj-$(CONFIG_ALIENWARE_WMI)    += alienware-wmi.o
>  obj-$(CONFIG_INTEL_PMC_IPC)    += intel_pmc_ipc.o
>  obj-$(CONFIG_SILEAD_DMI)       += silead_dmi.o
> diff --git a/drivers/platform/x86/pvpanic.c b/drivers/platform/x86/pvpanic.c
> deleted file mode 100644
> index fd86dab..0000000
> --- a/drivers/platform/x86/pvpanic.c
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -/*
> - *  pvpanic.c - pvpanic Device Support
> - *
> - *  Copyright (C) 2013 Fujitsu.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/types.h>
> -#include <linux/acpi.h>
> -
> -MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
> -MODULE_DESCRIPTION("pvpanic device driver");
> -MODULE_LICENSE("GPL");
> -
> -static int pvpanic_add(struct acpi_device *device);
> -static int pvpanic_remove(struct acpi_device *device);
> -
> -static const struct acpi_device_id pvpanic_device_ids[] = {
> -       { "QEMU0001", 0 },
> -       { "", 0 },
> -};
> -MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
> -
> -#define PVPANIC_PANICKED       (1 << 0)
> -
> -static u16 port;
> -
> -static struct acpi_driver pvpanic_driver = {
> -       .name =         "pvpanic",
> -       .class =        "QEMU",
> -       .ids =          pvpanic_device_ids,
> -       .ops =          {
> -                               .add =          pvpanic_add,
> -                               .remove =       pvpanic_remove,
> -                       },
> -       .owner =        THIS_MODULE,
> -};
> -
> -static void
> -pvpanic_send_event(unsigned int event)
> -{
> -       outb(event, port);
> -}
> -
> -static int
> -pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
> -                    void *unused)
> -{
> -       pvpanic_send_event(PVPANIC_PANICKED);
> -       return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block pvpanic_panic_nb = {
> -       .notifier_call = pvpanic_panic_notify,
> -       .priority = 1, /* let this called before broken drm_fb_helper */
> -};
> -
> -
> -static acpi_status
> -pvpanic_walk_resources(struct acpi_resource *res, void *context)
> -{
> -       switch (res->type) {
> -       case ACPI_RESOURCE_TYPE_END_TAG:
> -               return AE_OK;
> -
> -       case ACPI_RESOURCE_TYPE_IO:
> -               port = res->data.io.minimum;
> -               return AE_OK;
> -
> -       default:
> -               return AE_ERROR;
> -       }
> -}
> -
> -static int pvpanic_add(struct acpi_device *device)
> -{
> -       int ret;
> -
> -       ret = acpi_bus_get_status(device);
> -       if (ret < 0)
> -               return ret;
> -
> -       if (!device->status.enabled || !device->status.functional)
> -               return -ENODEV;
> -
> -       acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> -                           pvpanic_walk_resources, NULL);
> -
> -       if (!port)
> -               return -ENODEV;
> -
> -       atomic_notifier_chain_register(&panic_notifier_list,
> -                                      &pvpanic_panic_nb);
> -
> -       return 0;
> -}
> -
> -static int pvpanic_remove(struct acpi_device *device)
> -{
> -
> -       atomic_notifier_chain_unregister(&panic_notifier_list,
> -                                        &pvpanic_panic_nb);
> -       return 0;
> -}
> -
> -module_acpi_driver(pvpanic_driver);
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
