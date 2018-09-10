Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60775C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF05D20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmVtVhaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF05D20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeIKCnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeIKCnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:43:39 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BED2087F;
        Mon, 10 Sep 2018 21:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536616055;
        bh=Wb2ZA6trJgul0u99DokoNG3u3CSaYb5tQmVN6iRQMPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZmVtVhaj8U5ip+O+zn+y6MhpxOJhztbRgIDw9jh40Fnk6E4iNtnlPcHIPw45ITeHv
         UiDUomMigVwlH2x2Kov2kmetgb0cRgjPrE0yScHDGKA8E2C8cIieFN7YIPOQk/G93/
         MV7HGVfK0CIYEqEA/3YQEoVkyV6RJF+D7GLib5Ns=
Received: by mail-qk1-f171.google.com with SMTP id b19-v6so15467184qkc.6;
        Mon, 10 Sep 2018 14:47:35 -0700 (PDT)
X-Gm-Message-State: APzg51DgFjjKnL+gxq0HXrwqsA3j8f0agvlKbDhylmXiuqGy58wXg/4v
        Ovkn7NfIoU81rRqV1KnExvPOtcq0gQg6ecWhBw==
X-Google-Smtp-Source: ANB0VdZbgQjYy826neCd4OOK8bCdQ+/YaV/bX9G9iT9jF/4u+nia2HRS2TI6Rim5mtZ8RbO/vWzTs6pNbEAqM4Vv5Gg=
X-Received: by 2002:a37:f19:: with SMTP id z25-v6mr16698999qkg.147.1536616054193;
 Mon, 10 Sep 2018 14:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180908131345.8145-1-kernel@nospam.obeliks.de> <20180908131345.8145-4-kernel@nospam.obeliks.de>
In-Reply-To: <20180908131345.8145-4-kernel@nospam.obeliks.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Sep 2018 16:47:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+CMzkyeHLxa+6xf0FkM3mSPiGvoMrRoVV-FS1Q7SQsA@mail.gmail.com>
Message-ID: <CAL_JsqL+CMzkyeHLxa+6xf0FkM3mSPiGvoMrRoVV-FS1Q7SQsA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mtd: mtdconcat: add dt driver for concat devices
To:     kernel@nospam.obeliks.de
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 8:20 AM Bernhard Frauendienst
<kernel@nospam.obeliks.de> wrote:
>
> Some mtd drivers like physmap variants have support for concatenating
> multiple mtd devices, but there is no generic way to define such a
> concat device from within the device tree.

That is the generic way, but I suppose that only works for parallel
memory mapped devices. So is it just spi-nor that you need to support?
Can we just make reg take multiple chip selects just like the existing
support takes multiple reg entries?

> This is useful for some SoC boards that use multiple flash chips as
> memory banks of a single mtd device, with partitions spanning chip
> borders.
>
> This commit adds a driver for creating virtual mtd-concat devices. They
> must have a compatible = "mtd-concat" line, and define a list of devices
> to concat in the 'devices' property, for example:
>
> flash {
>   compatible = "mtd-concat";
>
>   devices = <&flash0 &flash1>;
>
>   partitions {
>     ...
>   };
> };
>
> The driver is added to the very end of the mtd Makefile to increase the
> likelyhood of all child devices already being loaded at the time of
> probing, preventing unnecessary deferred probes.
>
> Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> ---
>  drivers/mtd/Kconfig                 |   2 +
>  drivers/mtd/Makefile                |   3 +
>  drivers/mtd/composite/Kconfig       |  12 +++
>  drivers/mtd/composite/Makefile      |   7 ++
>  drivers/mtd/composite/virt_concat.c | 128 ++++++++++++++++++++++++++++
>  5 files changed, 152 insertions(+)
>  create mode 100644 drivers/mtd/composite/Kconfig
>  create mode 100644 drivers/mtd/composite/Makefile
>  create mode 100644 drivers/mtd/composite/virt_concat.c
>
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index c77f537323ec..6345d886d458 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -339,4 +339,6 @@ source "drivers/mtd/spi-nor/Kconfig"
>
>  source "drivers/mtd/ubi/Kconfig"
>
> +source "drivers/mtd/composite/Kconfig"
> +
>  endif # MTD
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 93473d215a38..57af7190b063 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -36,3 +36,6 @@ obj-y         += chips/ lpddr/ maps/ devices/ nand/ tests/
>
>  obj-$(CONFIG_MTD_SPI_NOR)      += spi-nor/
>  obj-$(CONFIG_MTD_UBI)          += ubi/
> +
> +# Composite drivers must be loaded last
> +obj-y          += composite/
> diff --git a/drivers/mtd/composite/Kconfig b/drivers/mtd/composite/Kconfig
> new file mode 100644
> index 000000000000..0490fc0284bb
> --- /dev/null
> +++ b/drivers/mtd/composite/Kconfig
> @@ -0,0 +1,12 @@
> +menu "Composite MTD device drivers"
> +       depends on MTD!=n
> +
> +config MTD_VIRT_CONCAT
> +       tristate "Virtual concat MTD device"
> +       help
> +         This driver allows creation of a virtual MTD concat device, which
> +         concatenates multiple underlying MTD devices to a single device.
> +         This is required by some SoC boards where multiple memory banks are
> +         used as one device with partitions spanning across device boundaries.
> +
> +endmenu
> diff --git a/drivers/mtd/composite/Makefile b/drivers/mtd/composite/Makefile
> new file mode 100644
> index 000000000000..8421a0a30606
> --- /dev/null
> +++ b/drivers/mtd/composite/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# linux/drivers/mtd/composite/Makefile
> +#
> +
> +obj-$(CONFIG_MTD_VIRT_CONCAT)   += virt_concat.o
> diff --git a/drivers/mtd/composite/virt_concat.c b/drivers/mtd/composite/virt_concat.c
> new file mode 100644
> index 000000000000..76918d4ef07f
> --- /dev/null
> +++ b/drivers/mtd/composite/virt_concat.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Virtual concat MTD device driver
> + *
> + * Copyright (C) 2018 Bernhard Frauendienst
> + * Author: Bernhard Frauendienst, kernel@nospam.obeliks.de
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/mtd/concat.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +/*
> + * struct of_virt_concat - platform device driver data.
> + * @cmtd the final mtd_concat device
> + * @num_devices the number of devices in @devices
> + * @devices points to an array of devices already loaded
> + */
> +struct of_virt_concat {
> +       struct mtd_info *cmtd;
> +       int num_devices;
> +       struct mtd_info **devices;
> +};
> +
> +static int virt_concat_remove(struct platform_device *pdev)
> +{
> +       struct of_virt_concat *info;
> +       int i;
> +
> +       info = platform_get_drvdata(pdev);
> +       if (!info)
> +               return 0;
> +
> +       // unset data for when this is called after a probe error
> +       platform_set_drvdata(pdev, NULL);
> +
> +       if (info->cmtd) {
> +               mtd_device_unregister(info->cmtd);
> +               mtd_concat_destroy(info->cmtd);
> +       }
> +
> +       if (info->devices) {
> +               for (i = 0; i < info->num_devices; i++)
> +                       put_mtd_device(info->devices[i]);
> +       }
> +
> +       return 0;
> +}
> +
> +static int virt_concat_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct of_phandle_iterator it;
> +       struct of_virt_concat *info;
> +       struct mtd_info *mtd;
> +       int err = 0, count;
> +
> +       count = of_count_phandle_with_args(node, "devices", NULL);
> +       if (count <= 0)
> +               return -EINVAL;
> +
> +       info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +       info->devices = devm_kcalloc(&pdev->dev, count,
> +                                    sizeof(*(info->devices)), GFP_KERNEL);
> +       if (!info->devices) {
> +               err = -ENOMEM;
> +               goto err_remove;
> +       }
> +
> +       platform_set_drvdata(pdev, info);
> +
> +       of_for_each_phandle(&it, err, node, "devices", NULL, 0) {
> +               mtd = get_mtd_device_by_node(it.node);
> +               if (IS_ERR(mtd)) {
> +                       of_node_put(it.node);
> +                       err = -EPROBE_DEFER;
> +                       goto err_remove;
> +               }
> +
> +               info->devices[info->num_devices++] = mtd;
> +       }
> +
> +       info->cmtd = mtd_concat_create(info->devices, info->num_devices,
> +                                      dev_name(&pdev->dev));
> +       if (!info->cmtd) {
> +               err = -ENXIO;
> +               goto err_remove;
> +       }
> +
> +       info->cmtd->dev.parent = &pdev->dev;
> +       mtd_set_of_node(info->cmtd, node);
> +       mtd_device_register(info->cmtd, NULL, 0);
> +
> +       return 0;
> +
> +err_remove:
> +       virt_concat_remove(pdev);
> +
> +       return err;
> +}
> +
> +static const struct of_device_id virt_concat_of_match[] = {
> +       { .compatible = "mtd-concat", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, virt_concat_of_match);
> +
> +static struct platform_driver virt_concat_driver = {
> +       .probe = virt_concat_probe,
> +       .remove = virt_concat_remove,
> +       .driver  = {
> +               .name   = "virt-mtdconcat",
> +               .of_match_table = virt_concat_of_match,
> +       },
> +};
> +
> +module_platform_driver(virt_concat_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Bernhard Frauendienst <kernel@nospam.obeliks.de>");
> +MODULE_DESCRIPTION("Virtual concat MTD device driver");
> --
> 2.18.0
>
