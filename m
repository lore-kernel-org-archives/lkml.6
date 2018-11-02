Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035042082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnxHJHRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035042082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeKBSpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:45:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44029 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeKBSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:45:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id r71so2006685qkr.10;
        Fri, 02 Nov 2018 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdrzAsYOblILXnc0WReZ2X/iIk4eTAjTltRqBA9jMWs=;
        b=fnxHJHRyDLfB6zmQpdg7gK/mN2glCsfwo96wCVC9M4sO6+Zzg9sbu+85JCukTR70vL
         LvUAb7mGBzAd2awvgfYjJf7X/0CXkGpRJKlouHZGexhkoQnLqQ68+yGha9XOPmGgXdaO
         9yRq+v7g8Bh72Kq7SgOuJeGBGKHgM9ydRw5inflWteOtxB/ZNIWS1ARLr2brIqzmnrHR
         cNXdsSfFTMDxyYfiB8iIfk3T53v0yAf9uAoIGmTYJnB2uCeRcWFQvRUQCNc8ttzVybxH
         zfui2Qb6Wpzr8VvHa2B6GsdQ4VnkkTF/yfpml+HiO3d4b7oJIoPrzwnb7a3kskZC/M9H
         w6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdrzAsYOblILXnc0WReZ2X/iIk4eTAjTltRqBA9jMWs=;
        b=HA4RqMMlqk9Qu2EvaUjAu4KFxsBTVWwQNVbc8CgtMiRdYCy/5FQgmPfChAULQnrZSo
         rFk9/T1iEMxF5q1+RqLRnU7i9JXC/ZDA2lfsD7ZzdRfCMjhFo1fklY6TXksXrL0JOOkD
         t//8ZGDZd7K1zUMYUPs9ZD6+hTlC7jSwegKnTgijpjgvQUncra6giJa/cQGYvqSksVFO
         tej9xMW1nnR4K/9hO0ovkEodSmduQjDgwSFSkODz2XhjptGCxOeK18VvjNx33T2rjOJw
         oNqEpZIl9ngGkABSEvRn3hK6E7qICu7L9owB82qNVl5PyafLYRdA7IxDcnlT1zLdRGiP
         cPRA==
X-Gm-Message-State: AGRZ1gLAryGJ/BmNQQrCRA7O8FLsgmYjeRzx121WSqDoVwyeD4A8TOeQ
        zzkWThLHXpXvOWu0tJsB+GBnNvIuQwVJGM60WoA=
X-Google-Smtp-Source: AJdET5ef4EahZh3iOj9Zz3V0z0zqQL8CKq9DNDl9KVELUHCuSjPfP/uOm4otvaJDQtTjZX3g0tDg3Go/xt00hPbxxvA=
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr10139443qvo.26.1541151555576;
 Fri, 02 Nov 2018 02:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <1541163378-54047-1-git-send-email-peng.hao2@zte.com.cn> <1541163378-54047-5-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541163378-54047-5-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 11:39:04 +0200
Message-ID: <CAHp75VegH6fZi5cpoRERga+Z-rv=ahfTpvy-Fbu_bwX99gsZVw@mail.gmail.com>
Subject: Re: [PATCH V6 5/8] misc/pvpanic: add support to get pvpanic device
 info by FDT
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:46 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> Virt machine in qemu provides both FDT and ACPI table. Increases the
> way to get information through FDT.
>

so OF dependency in Kconfig is a matter of this patch.
Since 0day bot complain you might need to add

#include <linux/mod_devicetable.h>

as well.

> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 22fb487..5378d5f 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -2,6 +2,7 @@
>   *  pvpanic.c - pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
> + *  Copyright (C) 2018 ZTE.
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by
> @@ -20,11 +21,14 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/acpi.h>
> +#include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/types.h>
> -#include <linux/acpi.h>
>
>  MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>  MODULE_DESCRIPTION("pvpanic device driver");
> @@ -73,6 +77,32 @@
>         .priority = 1, /* let this called before broken drm_fb_helper */
>  };
>
> +static int pvpanic_mmio_probe(struct platform_device *pdev)
> +{
> +       struct resource *mem;
> +
> +       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!mem)
> +               return -EINVAL;
> +
> +       base = devm_ioremap_resource(&pdev->dev, mem);
> +       if (base == NULL)
> +               return -EFAULT;
> +
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +                                      &pvpanic_panic_nb);
> +
> +       return 0;
> +}
> +
> +static int pvpanic_mmio_remove(struct platform_device *pdev)
> +{
> +
> +       atomic_notifier_chain_unregister(&panic_notifier_list,
> +                                        &pvpanic_panic_nb);
> +
> +       return 0;
> +}
>
>  static acpi_status
>  pvpanic_walk_resources(struct acpi_resource *res, void *context)
> @@ -124,4 +154,35 @@ static int pvpanic_remove(struct acpi_device *device)
>         return 0;
>  }
>
> -module_acpi_driver(pvpanic_driver);
> +static const struct of_device_id pvpanic_mmio_match[] = {
> +       { .compatible = "qemu,pvpanic-mmio", },
> +       {}
> +};
> +
> +static struct platform_driver pvpanic_mmio_driver = {
> +       .driver = {
> +               .name = "pvpanic-mmio",
> +               .of_match_table = pvpanic_mmio_match,
> +       },
> +       .probe = pvpanic_mmio_probe,
> +       .remove = pvpanic_mmio_remove,
> +};
> +
> +static int __init pvpanic_mmio_init(void)
> +{
> +       if (acpi_disabled)
> +               return platform_driver_register(&pvpanic_mmio_driver);
> +       else
> +               return acpi_bus_register_driver(&pvpanic_driver);
> +}
> +
> +static void __exit pvpanic_mmio_exit(void)
> +{
> +       if (acpi_disabled)
> +               platform_driver_unregister(&pvpanic_mmio_driver);
> +       else
> +               acpi_bus_unregister_driver(&pvpanic_driver);
> +}
> +
> +module_init(pvpanic_mmio_init);
> +module_exit(pvpanic_mmio_exit);
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
