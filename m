Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE17ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB0B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2LyUvXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB0B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeJaVsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:48:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42757 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeJaVsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:48:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id z20-v6so17441595qti.9;
        Wed, 31 Oct 2018 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssxMWkxF/drzvVsLRfAv0phLCDMqExxJL2+FyRjM2ow=;
        b=b2LyUvXCki6kmep935sgbsbuUfuD6Yf4QCsW26ucSINbsmkELA93ugtowK/xBrKtud
         dbc1OCMcP4o3tudsTjRzo4ISP/OwjlgIL9DdApz2nsPOWiQd0UKIpuImpiUYwqXftU/Y
         NrFxGnLFfNDbnB6m9yxSrympR1I4jjgGOn0Mf4qqFmfT/f4HxJtH2NuzFWJtcy2fJDab
         WvKoKNiY+YY8q+vdWmd6FosAaCBFBmyOt+yNeEC4hfh6gkPpekyH6upMYFtAS34k7YNG
         I9hwgRj56kteRgeof9riwNCn7mxMhxHtkb74YW4MHB3g/2IhA5zqUb+X5k/A6dtF+Z7i
         TaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssxMWkxF/drzvVsLRfAv0phLCDMqExxJL2+FyRjM2ow=;
        b=uC8ExvMPfTMfTUd1ldCYooG9N9DhyGrCvqEZH58QnD7wzpHl4sUE3vOI5b8Lm8CgKf
         d11QuA4LR6nWgHp049uf6B7YA8IiKxkYnrIca91/bAn9bfo+DKnelpBJDu/oWohv4GeR
         09z2b64tawHQNo/YWIosd6UHnU+HRnP8AwQYIIfHGqyKxyaO6WWerQaXrTweGn6c1s40
         zQHh4kfm5QHuZWESFeSNnSY8SfsjD6sHipd4UZaXt/WAMeFF/p7YJ7Po5jkd9m4XiVJk
         GYJJnvV+nqhdPVaS5qj7g7uqrUwJDDq7+DTW4ELYM/E02rxTK/nBtgXZYSi6g0hV5j+e
         AmEQ==
X-Gm-Message-State: AGRZ1gJfKbpfEiz/9jjGDx+OliiRqS2UufeN6VAK7nEZqp3V0FemrqTR
        gLDgcQQCNnXSk/feJBeFj6OETw3KS5VyCrBeT7c=
X-Google-Smtp-Source: AJdET5fIxhaSlTBxJbfTq0Mee9vktZGCYe1NxaKZscYPJDlEBOsASXmvzKdMIT1Yx+ux14NfNLwsdEJySeV4pFPBJBU=
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr2510052qvo.26.1540990215453;
 Wed, 31 Oct 2018 05:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn> <1540993041-25611-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540993041-25611-4-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Oct 2018 14:50:04 +0200
Message-ID: <CAHp75VdmfP82hTxUjy=-4FaQCNyHdzDZx76S_Y=ovwxkyPEfuw@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] misc/pvpanic: add support to get pvpanic device
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

On Wed, Oct 31, 2018 at 7:27 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> Virt machine in qemu provides both FDT and ACPI table. This patch
> increases the way to get information through FDT.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index d0e28b2..861a0eb 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -3,15 +3,18 @@
>   *  Pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
> + *  Copyright (C) 2018 ZTE.
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/acpi.h>
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
> @@ -22,7 +25,7 @@
>
>  static const struct acpi_device_id pvpanic_device_ids[] = {
>         { "QEMU0001", 0 },
> -       { "", 0 },
> +       { "", 0 }
>  };
>  MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
>
> @@ -60,6 +63,32 @@
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
> @@ -120,4 +149,35 @@ static int pvpanic_remove(struct acpi_device *device)
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
