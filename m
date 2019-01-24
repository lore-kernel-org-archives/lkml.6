Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69215C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373722184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBYF/Ca3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAXNzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:55:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43781 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfAXNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:55:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so3009370pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbTS8gtA6QW4i2cki4shNKVbxPliEiep2OQfHxht0vU=;
        b=IBYF/Ca31TPPYXP5VdmFCpGG36O38zp44Oc4Ak6qI7r2l51loPB/+v4WAdYxXakMwS
         VqxVNSexJvEZxStYby2QgoFL3xjU9GH7F8UmAHqHGYOpgVNQ8ykPUm+cJ6Mseu6QR28q
         sXUlNF9OIlUFggKoAwFuLuuSvNtwprQBIpriAM6zEUUIu1bhsyqd0SRyWWrVT7N9Le2r
         LcFLRka9uqyytdjaErYYmYYuRkx3XDlRt211h3Yx1/a8KiAw4CKSqoNHStq2TSEFTe9B
         Ht2GYiCOEWeT/Wh/nBRl2MqnPpX/j0tnLTxmipCc5yey+A+tYCaH1E8pbm890MmJLs+e
         J9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbTS8gtA6QW4i2cki4shNKVbxPliEiep2OQfHxht0vU=;
        b=iXqMVYyGjA7rq1egmSHPA0HmOsd/Fso8hl29mRhOMMh2tZ82cbhAfSLMiTo5qh4VUj
         3265RhIbJ187fHWpIIcoQnVPA5mKnvf3iITueapsrNeBmmuYo1eNn0Tgw/5M6TmExYWM
         6vAjKxVwZVOXJbFsIHfLZ1MWaMfN+uZmEZg/hGU+P2w0E963mq1AI8oGhZP3pXOV8uHy
         RnVBtEf7JP59fBH7ysOHna/dfKya6JHV6lVTqWgPTb3eHvaZzf4wzUYniK3sf+KXHNCM
         3cmLqU5iCFB8TPr/4tr0ZYCgV4rPiRur338sGRgwT37Om7yKSJeqi8FR98lVvc7U+Mto
         74TQ==
X-Gm-Message-State: AJcUukceyMPn7FMF5QnVMeWc7YdWHPNe7AbJSrO1ZD4iJrWC0Fh3fYc4
        D+VtqUBLWnlnxsai6e18JOVeyzD2+D9UXbjQuW4=
X-Google-Smtp-Source: ALg8bN4BI+LMTuRPjJc4xA/YcXuC8q1Tb5OjopOYxsKbn0WEpAe3WAyppp8MbeVZUXuDYLPkkVrjUlFB/09Q0EF8p40=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr6724933pfa.229.1548338103400;
 Thu, 24 Jan 2019 05:55:03 -0800 (PST)
MIME-Version: 1.0
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn> <1548348038-69560-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1548348038-69560-5-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 15:54:52 +0200
Message-ID: <CAHp75Vc-GTs-Hb3n3aV6ZrsMzU7xnmdOsa+nOYnkQpznTgSC3g@mail.gmail.com>
Subject: Re: [PATCH V4 4/6] misc/pvpanic: add pvpanic acpi driver
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:17 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Make pvpanic acpi driver as separate file and modify code
> in order to adapt the framework.

This should be patch 2 in this series to avoid run-time bisectability issues.

>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/Kconfig        | 13 +++++++
>  drivers/misc/pvpanic/Makefile       |  1 +
>  drivers/misc/pvpanic/pvpanic-acpi.c | 77 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
>
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 3e612c6..1dcfe20 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -5,3 +5,16 @@ config PVPANIC
>           This driver provides support for the pvpanic device.  pvpanic is
>           a paravirtualized device provided by QEMU; it lets a virtual machine
>           (guest) communicate panic events to the host.
> +
> +if PVPANIC
> +
> +config PVPANIC_ACPI
> +       tristate "pvpanic acpi driver"
> +       depends on ACPI
> +       default PVPANIC
> +       help
> +         This driver is one specific driver for pvpanic driver framework.
> +         It provides an acpi device as pvpanic device.
> +
> +endif
> +
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index 6394224..c5b73ca 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -3,3 +3,4 @@
>  # Copyright (c) 2018 ZTE Ltd.
>
>  obj-$(CONFIG_PVPANIC)      += pvpanic.o
> +obj-$(CONFIG_PVPANIC_ACPI) += pvpanic-acpi.o
> diff --git a/drivers/misc/pvpanic/pvpanic-acpi.c b/drivers/misc/pvpanic/pvpanic-acpi.c
> new file mode 100644
> index 0000000..8d10924
> --- /dev/null
> +++ b/drivers/misc/pvpanic/pvpanic-acpi.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  pvpanic acpi driver.
> + *
> + *  Copyright (C) 2019 ZTE Ltd.
> + *  Author: Peng Hao
> + */
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include "pvpanic.h"
> +
> +static int pvpanic_add(struct acpi_device *device);
> +static int pvpanic_remove(struct acpi_device *device);
> +
> +static const struct acpi_device_id pvpanic_device_ids[] = {
> +       { "QEMU0001", 0 },
> +       { "", 0 }
> +};
> +MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
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
> +static acpi_status
> +pvpanic_walk_resources(struct acpi_resource *res, void *context)
> +{
> +       struct resource r;
> +       int ret = 0;
> +       struct device *dev = context;
> +
> +       memset(&r, 0, sizeof(r));
> +       if (acpi_dev_resource_io(res, &r) || acpi_dev_resource_memory(res, &r))
> +               ret = pvpanic_add_device(dev, &r);
> +
> +       if (!ret)
> +               return AE_OK;
> +
> +       return AE_ERROR;
> +}
> +static int pvpanic_add(struct acpi_device *device)
> +{
> +       int ret;
> +       acpi_status status;
> +
> +       ret = acpi_bus_get_status(device);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!device->status.enabled || !device->status.functional)
> +               return -ENODEV;
> +
> +       status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +                                    pvpanic_walk_resources, &device->dev);
> +
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static int pvpanic_remove(struct acpi_device *device)
> +{
> +       pvpanic_remove_device();
> +       return 0;
> +}
> +
> +module_acpi_driver(pvpanic_driver);
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
