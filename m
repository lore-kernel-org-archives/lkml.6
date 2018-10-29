Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3672C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D212084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZbg2Z42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D212084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeJ2UZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:25:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45337 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJ2UZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:25:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so8679639qtj.12;
        Mon, 29 Oct 2018 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOey68p+bCclncRW5uWoj17oJk/hPNZcZRoALlviw0U=;
        b=DZbg2Z42Yi9lG6TtvWRPmOb44GS0/dmLVzNrW4vhrd7wBa0IQwYIgNLYo/IQ6xEg2Q
         MIc9rYX0RSxctNMjiVtpU4dbhsvD6p3TWgeSnLIy53oNoNvG/h5jIVp//Z3FDMIeNovI
         FpZi2GlOTA6s9xbgDXcz6AOjeyXW6wGIbJaS51h92HaE6cQm1+NT0b2lM2uLg1v1Kwua
         4MwBxU+aUgm71E+kwOJG5QWHcntlZYvte4szO/MdM3Nb1j11M5W4SqYkEeY6wSWuPknw
         GJREF96kCm+mkKAYMpRkkB2xDtCp9jug8+mWiaecX+zl6DqJZLKJaZTSKOiDR8Ghi76d
         guBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOey68p+bCclncRW5uWoj17oJk/hPNZcZRoALlviw0U=;
        b=ri0UWeINgzG0mM1IVfG2p9iD+NSLfSz/5+PcW63UGP990FXYogm0pkI33c/RkqWteD
         b1su/TenU1O9T8fMljyfy0YhndNrBJq86ZEsyxM2yah4B6Dqyi4MPaHN+i/YqemXtBZA
         OGTacXniJIMzTsgBG0VYnNK5/OC2zfVOuO3G2FFFwVgY5Fiss49/7sLAXZgyNagn1RF+
         gYx4rN2A8YSLznmT9XZWrXxza9Z8FCdLfAkKBl+ykT3lStWTxxFB8o6G5EhytLhAO4cI
         N9gqmR30WAhYLpiPEyNC4QBvWcoe+zXNBTFsTsMWWSdMbaZfERFYEFOsQnSuHNo3unck
         5H4w==
X-Gm-Message-State: AGRZ1gIOaqJtRYKUOHvJPhl91TrxW0+Rca5NswgiNjfbgrtCGi10xzfl
        v/9DKN3QRsVEMOGvS2YfpX4/bYb3DEdaCSBHwus=
X-Google-Smtp-Source: AJdET5dChYIjQduVjRMgsR/QrulN6UrT0rBw8P1MIN765jqoZ4sm36ApUCzjkHtvRqaCTpDEpZYVMXD6PSjPUA6Zkes=
X-Received: by 2002:aed:3b4b:: with SMTP id q11-v6mr12367946qte.229.1540813050473;
 Mon, 29 Oct 2018 04:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1540812743-1825-1-git-send-email-peng.hao2@zte.com.cn> <1540812743-1825-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540812743-1825-4-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 13:37:18 +0200
Message-ID: <CAHp75Vcz04Y7zakgYsV8VK566qbMgL6yVXCw9YH=0bnu6BWN6Q@mail.gmail.com>
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

On Mon, Oct 29, 2018 at 5:22 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> Virt machine in qemu provides both FDT and ACPI table. This patch
> increases the way to get information through FDT.
>

This one looks good to me!
Though, see one comment below.

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index cfd7fef..eb1ed0f 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -3,15 +3,19 @@
>   *  Pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
> + *  Copyright (C) 2018 ZTE.
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
>  #include <linux/kernel.h>

>  #include <linux/module.h>
>  #include <linux/init.h>

Side note: one of the above is redundant (either it can be built as
module -> module.h or not -> init.h)

>  #include <linux/types.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>

I think alphabetical order is slightly better, though there are
developers who think differently.

>
>  MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>  MODULE_DESCRIPTION("pvpanic device driver");
> @@ -60,6 +64,32 @@
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
> @@ -118,4 +148,35 @@ static int pvpanic_remove(struct acpi_device *device)
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
