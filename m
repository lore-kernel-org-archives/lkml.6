Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45976C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC0207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peIbEjvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfAXNrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:47:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38702 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfAXNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:47:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3013638pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7APLEfGUyr7yurxye093lKwqBsnqEuz+LXHUBxtflBY=;
        b=peIbEjvBJRZwcGMYxSvdlJNKZVGUl869qwixNSs9Pp5T+I0RxGmB73ITEJu2nGKi0G
         f7n+6hLv3Y1I4yE68F8ir7wtFm+d8Uc/VtXJyNzI4q/cyjYLLlG/gWHoPKJXwCky0w62
         x8YMTATcC4326ZGzTvsT3U0UTtJcBRlajPNPliaW9OrFh0upCY2MzhI3e/3tEF9tudGp
         YyH6I3eVLxnk8fOxUPpMU3a92TqQYrnKzO26+rmK4SGFb9/jSh7dICl0r8wqeHzeDAiV
         d/+QXm7McN/Vtx4LWLO+TlntZce2U77cZK5IfEBwF2j2oASS3Zmxij3dMysfd63otFz/
         NLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7APLEfGUyr7yurxye093lKwqBsnqEuz+LXHUBxtflBY=;
        b=cXjurHv69QshzRTJTueldzMX9HG9j8kcXnPnm/iu6Xk1mLJ4bJQo4k7tg5B6dzBcHE
         XkmTBEb3m3UZryoLd3dbcmqybqW4/P1QB8T6YbgHN0FE3l3bZUPsWzcnbmb+Zv9eWGjz
         uRtZmstvm5wtB/fkvHuunNb86jYwCKqTHUbCGGi3mC0d8NQ9PguYDW4ktD+CNRucpi8e
         brx77BFMLUKNEhHFn7fOsAEITDTm/KKZt18I6sp8wVywB3i/cb33Sdgf3QEd727UcI2k
         /0dSjXPIANSJe7dpTxXq/jsZuL1TtbdKPL4QU+wejkB/FOIt+4IRlNkU32WD57zLJT+D
         d4dA==
X-Gm-Message-State: AJcUukdahup2sSqiwR+6KikHjHE7yKTucrcxvoPvkjtjoLbN4ve+E0dj
        3WPYumLXx8UIDwj5usUZs9B8xGOS4W1WQTsF8FU=
X-Google-Smtp-Source: ALg8bN4gfxYOHuPiI/IMhetjhiehzR3iuuURGPe4s3hfboC0GQRmH2tqmuEj94WCKsIUSS39VWgtsiQk3iRj+6jhU/Q=
X-Received: by 2002:a62:34c6:: with SMTP id b189mr6703996pfa.229.1548337639166;
 Thu, 24 Jan 2019 05:47:19 -0800 (PST)
MIME-Version: 1.0
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn> <1548348038-69560-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1548348038-69560-3-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 15:47:08 +0200
Message-ID: <CAHp75VfxSe8oO2OJ=yOKyTHXih4i7ivao533dg6P1QUbjrDAdQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/6] misc/pvpanic: Add pvpanic driver framework
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
> Add pvpanic driver framework. Follow-up patches will split the original
> pvpanic acpi/of driver as the two separate files and modify code to
> adapt the framework.
>

This one has run-time bisectability issues.

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 158 +++++++----------------------------------
>  1 file changed, 27 insertions(+), 131 deletions(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 595ac06..f44a884 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -8,11 +8,9 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> -#include <linux/acpi.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>
> @@ -43,59 +41,25 @@
>         .priority = 1, /* let this called before broken drm_fb_helper */
>  };
>
> -#ifdef CONFIG_ACPI
> -static int pvpanic_add(struct acpi_device *device);
> -static int pvpanic_remove(struct acpi_device *device);
> -
> -static const struct acpi_device_id pvpanic_device_ids[] = {
> -       { "QEMU0001", 0 },
> -       { "", 0 }
> -};
> -MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
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
> -static acpi_status
> -pvpanic_walk_resources(struct acpi_resource *res, void *context)
> +static int pvpanic_platform_probe(struct platform_device *pdev)
>  {
> -       struct resource r;
> -
> -       if (acpi_dev_resource_io(res, &r)) {
> -               base = ioport_map(r.start, resource_size(&r));
> -               return AE_OK;
> -       } else if (acpi_dev_resource_memory(res, &r)) {
> -               base = ioremap(r.start, resource_size(&r));
> -               return AE_OK;
> -       }
> -
> -       return AE_ERROR;
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
> -       if (!base)
> -               return -ENODEV;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (res) {
> +               base = devm_ioremap_resource(dev, res);
> +               if (IS_ERR(base))
> +                       return -ENODEV;
> +       } else {
> +               res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +               if (!res)
> +                       return -ENODEV;
> +
> +               base = ioport_map(res->start, resource_size(res));
> +               if (!base)
> +                       return -ENODEV;
> +       }
>
>         atomic_notifier_chain_register(&panic_notifier_list,
>                                        &pvpanic_panic_nb);
> @@ -103,90 +67,22 @@ static int pvpanic_add(struct acpi_device *device)
>         return 0;
>  }
>
> -static int pvpanic_remove(struct acpi_device *device)
> +static int pvpanic_platform_remove(struct platform_device *pdev)
>  {
> -
>         atomic_notifier_chain_unregister(&panic_notifier_list,
>                                          &pvpanic_panic_nb);
> -       iounmap(base);
> -
> -       return 0;
> -}
> -
> -static int pvpanic_register_acpi_driver(void)
> -{
> -       return acpi_bus_register_driver(&pvpanic_driver);
> -}
> -
> -static void pvpanic_unregister_acpi_driver(void)
> -{
> -       acpi_bus_unregister_driver(&pvpanic_driver);
> -}
> -#else
> -static int pvpanic_register_acpi_driver(void)
> -{
> -       return -ENODEV;
> -}
>
> -static void pvpanic_unregister_acpi_driver(void) {}
> -#endif
> -
> -static int pvpanic_mmio_probe(struct platform_device *pdev)
> -{
> -       struct resource *mem;
> -
> -       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!mem)
> -               return -EINVAL;
> -
> -       base = devm_ioremap_resource(&pdev->dev, mem);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> -
> -       atomic_notifier_chain_register(&panic_notifier_list,
> -                                      &pvpanic_panic_nb);
> -
> -       return 0;
> -}
> -
> -static int pvpanic_mmio_remove(struct platform_device *pdev)
> -{
> -
> -       atomic_notifier_chain_unregister(&panic_notifier_list,
> -                                        &pvpanic_panic_nb);
> +       iounmap(base);
>
>         return 0;
>  }
>
> -static const struct of_device_id pvpanic_mmio_match[] = {
> -       { .compatible = "qemu,pvpanic-mmio", },
> -       {}
> -};
> -
> -static struct platform_driver pvpanic_mmio_driver = {
> +static struct platform_driver pvpanic_driver = {
> +       .probe = pvpanic_platform_probe,
> +       .remove = pvpanic_platform_remove,
>         .driver = {
> -               .name = "pvpanic-mmio",
> -               .of_match_table = pvpanic_mmio_match,
> -       },
> -       .probe = pvpanic_mmio_probe,
> -       .remove = pvpanic_mmio_remove,
> +               .name = "pvpanic",
> +       }
>  };
>
> -static int __init pvpanic_mmio_init(void)
> -{
> -       if (acpi_disabled)
> -               return platform_driver_register(&pvpanic_mmio_driver);
> -       else
> -               return pvpanic_register_acpi_driver();
> -}
> -
> -static void __exit pvpanic_mmio_exit(void)
> -{
> -       if (acpi_disabled)
> -               platform_driver_unregister(&pvpanic_mmio_driver);
> -       else
> -               pvpanic_unregister_acpi_driver();
> -}
> -
> -module_init(pvpanic_mmio_init);
> -module_exit(pvpanic_mmio_exit);
> +module_platform_driver(pvpanic_driver);
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
