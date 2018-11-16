Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DE3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E922087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yBnwweZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E922087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbeKPWxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389732AbeKPWxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:53:23 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED9B208E7;
        Fri, 16 Nov 2018 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372069;
        bh=Khw9FvWc+iK2qF+ZJ1LPe+611o6UTqD5tyKRi+7PJtI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yBnwweZYsPtQvzUKBmIo+nTrGfLd2VmtMj3wCoKDHK2IQf/NR7KiFarCpb5xcGFQ7
         eLpZlHFoT/pekPiAuHN72M4K31T+5my0ZwAbQcdWpHRaM2K1QKsNty4oIQFquAe6mp
         EscWFmeIpXCVz8lLei7Z0GYzEqcL+Mx+9N4nxI1M=
Received: by mail-lj1-f174.google.com with SMTP id z80-v6so20182967ljb.8;
        Fri, 16 Nov 2018 04:41:09 -0800 (PST)
X-Gm-Message-State: AGRZ1gKTOPSFZFnLN1fP65S3GdMeZ1LkM6YbfrU+iI/CmhZfZ1mppOkf
        GORyVnfauFLRhpWZnQKuk2IXXe4sdozX8ERtPAw=
X-Google-Smtp-Source: AJdET5eC7qGZEBpw7yyhQJcSNAavqxdTM7ZYE64s6g2vBh36NrvKbO0bTeoEe11ebgM8ji3jRpmbGoBapNpku+uU2O4=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr6499465ljj.161.1542372067365;
 Fri, 16 Nov 2018 04:41:07 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181115151216epcas1p3413d9586bf941aa086bfc5cd620d45d9@epcas1p3.samsung.com>
 <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com> <1542294698-17470-3-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1542294698-17470-3-git-send-email-b.zolnierkie@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Nov 2018 13:40:56 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf4DC9NaAHOcM2iW8mf622uucJ7OBjQsrR6P0rtqgJ7rA@mail.gmail.com>
Message-ID: <CAJKOXPf4DC9NaAHOcM2iW8mf622uucJ7OBjQsrR6P0rtqgJ7rA@mail.gmail.com>
Subject: Re: [PATCH 2/9] soc: samsung: add exynos chipid driver support
To:     =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Cc:     arnd@arndb.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        kgene@kernel.org, m.reichl@fivetechno.de,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, javierm@redhat.com,
        pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        grant.likely@secretlab.ca, robh+dt@kernel.org,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 at 16:12, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> Exynos SoCs have Chipid, for identification of product IDs and SoC
> revisions. This patch intends to provide initialization code for all
> these functionalities, at the same time it provides some sysfs entries
> for accessing these information to user-space.
>
> This driver uses existing binding for exynos-chipid.
>
> Changes by Bartlomiej:
> - fixed return values on errors
> - removed bogus kfree_const()
> - added missing Exynos4210 EVT0 id
> - converted code to use EXYNOS_MASK define
> - fixed np use after of_node_put()
> - fixed too early use of dev_info()
> - made driver fail for unknown SoC-s
> - added SPDX tag
> - updated Copyrights
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> [m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/soc/samsung/Kconfig         |   5 ++
>  drivers/soc/samsung/Makefile        |   1 +
>  drivers/soc/samsung/exynos-chipid.c | 111 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 2186285..2905f52 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -7,6 +7,11 @@ menuconfig SOC_SAMSUNG
>
>  if SOC_SAMSUNG
>
> +config EXYNOS_CHIPID
> +       bool "Exynos Chipid controller driver" if COMPILE_TEST
> +       depends on ARCH_EXYNOS || COMPILE_TEST
> +       select SOC_BUS
> +
>  config EXYNOS_PMU
>         bool "Exynos PMU controller driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
> index 29f294b..c2a8fbc 100644
> --- a/drivers/soc/samsung/Makefile
> +++ b/drivers/soc/samsung/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_EXYNOS_CHIPID)    += exynos-chipid.o
>  obj-$(CONFIG_EXYNOS_PMU)       += exynos-pmu.o
>
>  obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)   += exynos3250-pmu.o exynos4-pmu.o \
> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
> new file mode 100644
> index 0000000..5cb0188
> --- /dev/null
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Samsung Electronics Co., Ltd.
> + *           http://www.samsung.com/
> + *
> + * EXYNOS - CHIP ID support
> + * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
> + * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>

I think both platform headers are not used here.

Best regards,
Krzysztof

> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define EXYNOS_SUBREV_MASK     (0xF << 4)
> +#define EXYNOS_MAINREV_MASK    (0xF << 0)
> +#define EXYNOS_REV_MASK                (EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
> +#define EXYNOS_MASK            0xFFFFF000
> +
> +static const struct exynos_soc_id {
> +       const char *name;
> +       unsigned int id;
> +} soc_ids[] = {
> +       { "EXYNOS3250", 0xE3472000 },
> +       { "EXYNOS4210", 0x43200000 },   /* EVT0 revision */
> +       { "EXYNOS4210", 0x43210000 },
> +       { "EXYNOS4212", 0x43220000 },
> +       { "EXYNOS4412", 0xE4412000 },
> +       { "EXYNOS5250", 0x43520000 },
> +       { "EXYNOS5260", 0xE5260000 },
> +       { "EXYNOS5410", 0xE5410000 },
> +       { "EXYNOS5420", 0xE5420000 },
> +       { "EXYNOS5440", 0xE5440000 },
> +       { "EXYNOS5800", 0xE5422000 },
> +       { "EXYNOS7420", 0xE7420000 },
> +       { "EXYNOS5433", 0xE5433000 },
> +};
> +
> +static const char * __init product_id_to_soc_id(unsigned int product_id)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
> +               if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
> +                       return soc_ids[i].name;
> +       return NULL;
> +}
> +
> +int __init exynos_chipid_early_init(void)
> +{
> +       struct soc_device_attribute *soc_dev_attr;
> +       void __iomem *exynos_chipid_base;
> +       struct soc_device *soc_dev;
> +       struct device_node *root;
> +       struct device_node *np;
> +       u32 product_id;
> +       u32 revision;
> +
> +       /* look up for chipid node */
> +       np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
> +       if (!np)
> +               return -ENODEV;
> +
> +       exynos_chipid_base = of_iomap(np, 0);
> +       of_node_put(np);
> +
> +       if (!exynos_chipid_base) {
> +               pr_err("Failed to map SoC chipid\n");
> +               return -ENXIO;
> +       }
> +
> +       product_id = readl_relaxed(exynos_chipid_base);
> +       revision = product_id & EXYNOS_REV_MASK;
> +       iounmap(exynos_chipid_base);
> +
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (!soc_dev_attr)
> +               return -ENOMEM;
> +
> +       soc_dev_attr->family = "Samsung Exynos";
> +
> +       root = of_find_node_by_path("/");
> +       of_property_read_string(root, "model", &soc_dev_attr->machine);
> +       of_node_put(root);
> +
> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
> +       soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
> +       if (!soc_dev_attr->soc_id) {
> +               pr_err("Unknown SoC\n");
> +               return -ENODEV;
> +       }
> +
> +       /* please note that the actual registration will be deferred */
> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr->revision);
> +               kfree(soc_dev_attr);
> +               return PTR_ERR(soc_dev);
> +       }
> +
> +       /* it is too early to use dev_info() here (soc_dev is NULL) */
> +       pr_info("soc soc0: Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
> +               soc_dev_attr->soc_id, product_id, revision);
> +
> +       return 0;
> +}
> +early_initcall(exynos_chipid_early_init);
> --
> 1.9.1
>
