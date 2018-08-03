Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46002170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtk3iz5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46002170D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeHCQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:10:53 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33863 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:10:53 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so2702673ybq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c8IHigpCjuZTw25NndXaxOU5kOw+gBb7rqmpJw3pEWE=;
        b=jtk3iz5u/V2DDNBIXVRiLPgaQwSbFpOu2TvOVqwoevGhf0/zW0+yP3Yyx56j/i8m6g
         1veMrGzH6ULJBpNdHMCLwSjPPRajRzFWRoQRTW/t/aT8FPJV1HGbDusfCExYhui/g8oN
         iyk5tjdOO/Zvi/bmFvCgTd/OGDCXEJsjqsKZjIx0Z+iBTBPjeaWqfydqUXjr4dmVVSry
         D1//6sQmi6DQe5Ej9PEdSzlcUM3RO/ym5iO7QNfPincg4+Q2r46QDqKiZAWRt5HK/XGv
         cAIES1yZr5lL3DF/q942L9P/70q51Kk63ifl9/65Pe1c0g3gX7mPAMAULbJ3ZFiCicfU
         u5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c8IHigpCjuZTw25NndXaxOU5kOw+gBb7rqmpJw3pEWE=;
        b=AUBzH1klCbIfRKBTQjVZ4yMi2wI4dbmTs07F4nUJONxjeJIEdrybJcdLaEyNLlvPUe
         drjF3v4I9yZm0te11VaVBGJeK4wUxzsTW3kW9qvs9uwAjRlUbRVVeXnG2oGQdYJ9ntYT
         n0+mBH3tL7XI0WxtZr6vkp6pdvCqlkhej2R8+PLdXqxjeQRqJqXdX8NzNUVsPwWvhlT8
         7wkat0fUV7mg1hrH0W4tlZgL2ETBdbg13HagqqIHbdA18likdd42Y3f59z8MhgWqN1On
         SlbSNQbZAxYs9AwmXU0sQ6WzQb3BiI/uT8CNWgp+fXQT5u+KE/07+iziQz1eNWGHRq2u
         BWcQ==
X-Gm-Message-State: AOUpUlGyid37walTnU1gwxpXsjWd5fL1IKTYphNeKoyALGdHDnrfcwqC
        61yijWdhXyQw4rWu0i8Ua+GotO/x/MC5Icpn60k=
X-Google-Smtp-Source: AAOMgpdyslFt2UiA5WOvf35CmHHVYfEH2hVjH4R+GISEBtdPFfPFGJXudlFQNxSTmDL4FYeWtm6b0Id3PKeb3oZjHPg=
X-Received: by 2002:a25:b097:: with SMTP id f23-v6mr2168285ybj.494.1533305660370;
 Fri, 03 Aug 2018 07:14:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bc1:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 07:14:19 -0700 (PDT)
In-Reply-To: <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr> <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Fri, 3 Aug 2018 22:14:19 +0800
Message-ID: <CALecT5i1mnkvi4WuL701cA+UnRL9CKmj=CMqLEWN=fpbxfi7ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: amlogic: add meson-canvas driver
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Maxime

thanks for contributing the patches ;-)

On Thu, Aug 2, 2018 at 2:51 AM, Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
> Amlogic SoCs have a repository of 256 canvas which they use to
> describe pixel buffers.
>
> They contain metadata like width, height, block mode, endianness [..]
>
> Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
> pixels.
>
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  drivers/soc/amlogic/Kconfig              |   7 +
>  drivers/soc/amlogic/Makefile             |   1 +
>  drivers/soc/amlogic/meson-canvas.c       | 182 +++++++++++++++++++++++
>  include/linux/soc/amlogic/meson-canvas.h |  37 +++++
>  4 files changed, 227 insertions(+)
>  create mode 100644 drivers/soc/amlogic/meson-canvas.c
>  create mode 100644 include/linux/soc/amlogic/meson-canvas.h
>
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index b04f6e4aedbc..5bd049899d88 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -1,5 +1,12 @@
>  menu "Amlogic SoC drivers"
>
> +config MESON_CANVAS
> +       bool "Amlogic Meson Canvas driver"
shouldn't this a 'tristate'? since you'd make the driver a kernel module..

> +       depends on ARCH_MESON || COMPILE_TEST
> +       default ARCH_MESON
> +       help
> +         Say yes to support the canvas IP within Amlogic Meson Soc family.
> +
>  config MESON_GX_SOCINFO
>         bool "Amlogic Meson GX SoC Information driver"
>         depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index 8fa321893928..0ab16d35ac36 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
> new file mode 100644
> index 000000000000..671eb89c8904
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-canvas.c
> @@ -0,0 +1,182 @@
> +/*
> + * Copyright (C) 2018 Maxime Jourdan
> + * Copyright (C) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
> + * Copyright (C) 2014 Endless Mobile
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
use SPDX license header as Neil already mentioned
check doc: Documentation/process/license-rules.rst

> +
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/soc/amlogic/meson-canvas.h>
> +#include <asm/io.h>
> +
> +#define NUM_CANVAS 256
> +
> +/* DMC Registers */
> +#define DMC_CAV_LUT_DATAL      0x48 /* 0x12 offset in data sheet */
> +       #define CANVAS_WIDTH_LBIT       29
> +       #define CANVAS_WIDTH_LWID       3
> +#define DMC_CAV_LUT_DATAH      0x4c /* 0x13 offset in data sheet */
> +       #define CANVAS_WIDTH_HBIT       0
> +       #define CANVAS_HEIGHT_BIT       9
> +       #define CANVAS_BLKMODE_BIT      24
> +#define DMC_CAV_LUT_ADDR       0x50 /* 0x14 offset in data sheet */
> +       #define CANVAS_LUT_WR_EN        (0x2 << 8)
> +       #define CANVAS_LUT_RD_EN        (0x1 << 8)
> +
> +struct meson_canvas {
> +       struct device *dev;
> +       struct regmap *regmap_dmc;
> +       struct mutex lock;
> +       u8 used[NUM_CANVAS];
> +};
> +
> +static struct meson_canvas canvas = { 0 };
> +
> +static int meson_canvas_setup(uint8_t canvas_index, uint32_t addr,
> +                       uint32_t stride, uint32_t height,
> +                       unsigned int wrap,
> +                       unsigned int blkmode,
> +                       unsigned int endian)
use "./scripts/checkpatch.pl --strict" to check
you will get a few complaints..

> +{
> +       struct regmap *regmap = canvas.regmap_dmc;
> +       u32 val;
> +
> +       mutex_lock(&canvas.lock);
> +
> +       if (!canvas.used[canvas_index]) {
> +               dev_err(canvas.dev,
> +                       "Trying to setup non allocated canvas %u\n",
> +                       canvas_index);
> +               mutex_unlock(&canvas.lock);
> +               return -EINVAL;
> +       }
> +
> +       regmap_write(regmap, DMC_CAV_LUT_DATAL,
> +               ((addr + 7) >> 3) |
> +               (((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
> +
> +       regmap_write(regmap, DMC_CAV_LUT_DATAH,
> +               ((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
> +                                               CANVAS_WIDTH_HBIT) |
> +               (height << CANVAS_HEIGHT_BIT) |
> +               (wrap << 22) |
> +               (blkmode << CANVAS_BLKMODE_BIT) |
> +               (endian << 26));
> +
> +       regmap_write(regmap, DMC_CAV_LUT_ADDR,
> +               CANVAS_LUT_WR_EN | canvas_index);
> +
> +       /* Force a read-back to make sure everything is flushed. */
> +       regmap_read(regmap, DMC_CAV_LUT_DATAH, &val);
> +       mutex_unlock(&canvas.lock);
> +
> +       return 0;
> +}
> +
> +static int meson_canvas_alloc(uint8_t *canvas_index)
> +{
> +       int i;
> +
> +       mutex_lock(&canvas.lock);
> +       for (i = 0; i < NUM_CANVAS; ++i) {
> +               if (!canvas.used[i]) {
> +                       canvas.used[i] = 1;
> +                       mutex_unlock(&canvas.lock);
> +                       *canvas_index = i;
> +                       return 0;
> +               }
> +       }
> +       mutex_unlock(&canvas.lock);
> +       dev_err(canvas.dev, "No more canvas available\n");
> +
> +       return -ENODEV;
> +}
> +
> +static int meson_canvas_free(uint8_t canvas_index)
> +{
> +       mutex_lock(&canvas.lock);
> +       if (!canvas.used[canvas_index]) {
> +               dev_err(canvas.dev,
> +                       "Trying to free unused canvas %u\n", canvas_index);
> +               mutex_unlock(&canvas.lock);
> +               return -EINVAL;
> +       }
> +       canvas.used[canvas_index] = 0;
> +       mutex_unlock(&canvas.lock);
> +
> +       return 0;
> +}
> +
> +static struct meson_canvas_platform_data canvas_platform_data = {
> +       .alloc = meson_canvas_alloc,
> +       .free = meson_canvas_free,
> +       .setup = meson_canvas_setup,
> +};
> +
> +static int meson_canvas_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap_dmc;
> +       struct device *dev;
> +
> +       dev = &pdev->dev;
you could fold into one if you like(may save a few lines), so something like:

struct device *dev = &pdev->dev;

> +
> +       regmap_dmc = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +       if (IS_ERR(regmap_dmc)) {
> +               dev_err(&pdev->dev, "failed to get DMC regmap\n");
> +               return PTR_ERR(regmap_dmc);
> +       }
> +
> +       canvas.dev = dev;
> +       canvas.regmap_dmc = regmap_dmc;
> +       mutex_init(&canvas.lock);
> +
> +       dev->platform_data = &canvas_platform_data;
> +
> +       return 0;
> +}
> +
> +static int meson_canvas_remove(struct platform_device *pdev)
> +{
> +       mutex_destroy(&canvas.lock);
> +       return 0;
> +}
> +
> +static const struct of_device_id canvas_dt_match[] = {
> +       { .compatible = "amlogic,meson-canvas" },
drop "meson-" prefix, already comment in another thread

> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, canvas_dt_match);
> +
> +static struct platform_driver meson_canvas_driver = {
> +       .probe = meson_canvas_probe,
> +       .remove = meson_canvas_remove,
> +       .driver = {
> +               .name = "meson-canvas",
> +               .of_match_table = canvas_dt_match,
> +       },
> +};
> +module_platform_driver(meson_canvas_driver);
> +
> +MODULE_ALIAS("platform:meson-canvas");
> +MODULE_DESCRIPTION("AMLogic Meson Canvas driver");
Jerome complained several times about the camel expression,
so just use "Amlogic" ;-)

> +MODULE_AUTHOR("Maxime Jourdan <maxi.jourdan@wanadoo.fr>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
> new file mode 100644
> index 000000000000..af9e2415056a
> --- /dev/null
> +++ b/include/linux/soc/amlogic/meson-canvas.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (c) 2018 Maxime Jourdan
> + * Author: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef MESON_CANVAS_H
> +#define MESON_CANVAS_H
> +
> +#include <linux/kernel.h>
> +
> +#define MESON_CANVAS_WRAP_NONE 0x00
> +#define MESON_CANVAS_WRAP_X    0x01
> +#define MESON_CANVAS_WRAP_Y    0x02
> +
> +#define MESON_CANVAS_BLKMODE_LINEAR    0x00
> +#define MESON_CANVAS_BLKMODE_32x32     0x01
> +#define MESON_CANVAS_BLKMODE_64x64     0x02
> +
> +struct meson_canvas_platform_data {
> +       int (*alloc)(uint8_t *canvas_index);
> +       int (*free) (uint8_t canvas_index);
> +       int (*setup)(uint8_t canvas_index, uint32_t addr,
> +                       uint32_t stride, uint32_t height,
> +                       unsigned int wrap,
> +                       unsigned int blkmode,
> +                       unsigned int endian);
> +};
> +
> +#endif
> --
> 2.17.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
