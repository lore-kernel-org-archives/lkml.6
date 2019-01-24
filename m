Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D776C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541782184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Aldbs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfAXNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:55:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46179 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfAXNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:55:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so3003390pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=491IvpGaSmWKa7PkGtkxFDy4NBVxanVjoKrAyDu3yOs=;
        b=N5Aldbs9inrpcC0XL16UfwNrXnwog8pLSrA8zN9HSwWMybqjTJVct/fZ1cB5Gpa5lP
         3WpmDbOJYTUKDH6EUF/YiNkoOCC5VhxZ3/+uZsCoajaO1Skc1ElISGzw08D/IYpzrgte
         P5w8a0tgzlr586G9MQhaNDx+JUqd8j0ENcowbk9797PIgQqnA5ZOBseqpxyLzDVRTJft
         DrjdFPOECx2dlrWM283kod/YU00jgMkvkvpIq70/kwANB7+rGQs41bdSruo11n0o4aIz
         GYHWRJP2omShtrjmWuZFHMWN+Y1GVtngP+tH9d0dBEp64UixdPs0Yo4/P44hWBOkNse3
         G9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=491IvpGaSmWKa7PkGtkxFDy4NBVxanVjoKrAyDu3yOs=;
        b=hXVjJYLqE5Rv1uFrBFB4Ty6UDge+ZImVoS3JWYLQp/jYYHgn8ICg3M+Yq59SNQw2mE
         N4eMk6GQoxaIsqJFcVxkmR91vrF8hdiTHsnC+lalj/qeKt/wldjPnnSTNjkk5YczBr18
         3/5P+Ls6oQODtmGNtakGLwCrsONYPxF7grrRV85jb0nHVUmuNjVeAKBcM5xDBMo3c0Qg
         r8dN3mJ2QRjIs+AzfBZrK3SkOBHcKbqt3Sqhd/TuAjVWydE2zeP6LM3SoZ2nml5WA02s
         us2s6IRwHz66v5JkpoZKKzIWZJhOHR8vJ08QDJ9eVPJbQMwMyN0TBiGu+Y+46KP65uNR
         FYKg==
X-Gm-Message-State: AJcUukeT5sgS1wsKV5UrWj9qL2xV9zQs62SgsrgQat76/xg6U0/vCFf0
        4fS/jIt6pNmbSZ2B7IPZAhlWLXU2jef6dul4Uk4=
X-Google-Smtp-Source: ALg8bN4aN21fx25jwNmKEakrqrL4TC4kPdQxNrR8YhIlFqdaeIfZO4gykmazSXINItK5ZEj5H7jh4U2EzQFJyU673sM=
X-Received: by 2002:a63:f615:: with SMTP id m21mr6117334pgh.428.1548338141318;
 Thu, 24 Jan 2019 05:55:41 -0800 (PST)
MIME-Version: 1.0
References: <1548348038-69560-1-git-send-email-peng.hao2@zte.com.cn> <1548348038-69560-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1548348038-69560-6-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 15:55:30 +0200
Message-ID: <CAHp75VdwB9+s5zDv+jpjFJAX8AXL0rTv=r19T-=ZSYtpAoYHpA@mail.gmail.com>
Subject: Re: [PATCH V4 5/6] misc/pvpanic: add pvpanic mmio driver
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
> Make pvpanic mmio driver as separate file and modify code
> in order to adapt the framework.

This should go as patch 3

>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/Kconfig      |  7 ++++++
>  drivers/misc/pvpanic/Makefile     |  1 +
>  drivers/misc/pvpanic/pvpanic-of.c | 53 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-of.c
>
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 1dcfe20..14074af 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -16,5 +16,12 @@ config PVPANIC_ACPI
>           This driver is one specific driver for pvpanic driver framework.
>           It provides an acpi device as pvpanic device.
>
> +config PVPANIC_OF
> +       tristate "pvpanic mmio driver"
> +       depends on OF
> +       help
> +         This driver is one specific driver for pvpanic driver framework.
> +         It provides a mmio device as pvpanic device.
> +
>  endif
>
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index c5b73ca..63ef0db 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -4,3 +4,4 @@
>
>  obj-$(CONFIG_PVPANIC)      += pvpanic.o
>  obj-$(CONFIG_PVPANIC_ACPI) += pvpanic-acpi.o
> +obj-$(CONFIG_PVPANIC_OF)   += pvpanic-of.o
> diff --git a/drivers/misc/pvpanic/pvpanic-of.c b/drivers/misc/pvpanic/pvpanic-of.c
> new file mode 100644
> index 0000000..73ca5f3
> --- /dev/null
> +++ b/drivers/misc/pvpanic/pvpanic-of.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  pvpanic of driver.
> + *
> + *  Copyright (C) 2019 ZTE Ltd.
> + *  Author: Peng Hao <peng.hao2@zte.com.cn>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include "pvpanic.h"
> +
> +static int pvpanic_mmio_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       int ret;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
> +       ret = pvpanic_add_device(&pdev->dev, res);
> +       if (ret)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static int pvpanic_mmio_remove(struct platform_device *pdev)
> +{
> +       pvpanic_remove_device();
> +       return 0;
> +}
> +
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
> +module_platform_driver(pvpanic_mmio_driver);
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
