Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A427C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5522082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8LRO5j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5522082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLCIMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:12:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44966 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:12:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so6769724qkh.11;
        Mon, 03 Dec 2018 00:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qspya8dh5+ebOlFOu/8GB96erVZgWOJVqFzzVQ+vDGw=;
        b=K8LRO5j8Z4WVWuUY+pXBPNFu2Qd6jZ1BNbjFvEw+tjYnjha1gmdH39Edbd26aEKLmC
         mPGjisj+99pToGxX5hYYWQ7CQwscgm6xGklyn9NzHGCg3PsKBNQ3jcVJYyogRPeakGa1
         yU1lFR0n0UagAwI09hKzh30Jcm3MoRF1rlspM51z+6LEiuPWF02/2h6QNVo7q4DPALbb
         ETNTb9oSf2rmWw+uB2JJ8mze2un+GMzexxxnJeXZ2JXZ7ktiZpwKlkpp92+6j64Qo6o9
         yYtEpiwZzTJ3O3/W/0cvBGfnL1rivsIA408vHq9JnK5pG/poWKhIVGeRg5y5ll4e1zeO
         A8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qspya8dh5+ebOlFOu/8GB96erVZgWOJVqFzzVQ+vDGw=;
        b=MW0Dg7wIhXWFaNL2JuIPSZlhEgN1VbSQJq+sGrgqilMglS/b54pTy9bERsWTyZUKL3
         AEIv2UcM0AcTlu1HCCHxfcqIR0lCkUPYpQ52LJHTWB1SpK9geklhIlFPkbp58WonlpIG
         O89hlLDnirHyEng8y/oYiMkf7Gjn+OwmaPrSfP9bbRIjYHKE+HIa9YJikhTuZB68MHoQ
         lZ+Q5y+//t/9lV0eTDA3G/iaC3PtWfXh+BFekr9fpGi8lalWehskDUsIDfWwbdHfwVdq
         HbThJyDibJMzQa3Hrqx+3ctdk9dJB1gB9Uclq2IxRzYGWx+JDtINJTPUVnLFxNkI1XuG
         lc5A==
X-Gm-Message-State: AA+aEWbL/+Dea4dwLRVKAMskgeLJj3ZLknIixKmtgVS7EGcdi2+2vf3X
        m5huKldB7YnGBhtoQ1c4gR7MT1/iXeN0c33j25o=
X-Google-Smtp-Source: AFSGD/XxYmvYTj02I7CtbLXV7bvlcxfqX18wGLgaScvWGso6yUkB49zukmne4Y31f8tXVzFx0Q8VgjQDHj4j+xiECvQ=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr13409898qkf.33.1543824732395;
 Mon, 03 Dec 2018 00:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-5-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-5-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 10:12:01 +0200
Message-ID: <CAHp75VcdbJ9KV2Xr9mQsAcODMCJUMXz0OY0t_FSJgZ6dXx2fYQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] usb: dwc3: dwc3-hisi: Add code for dwc3 of
 Hisilicon Soc Platform
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:48 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> This driver handles the poweron and shutdown of dwc3 core
> on Hisilicon Soc Platform.

> +config USB_DWC3_HISI
> +       tristate "HiSilicon Kirin Platforms"
> +       depends on ((ARCH_HISI && ARM64) || COMPILE_TEST) && OF

It would be easy to read if
depends on OF
would be on a separate line

> +       default USB_DWC3
> +       help
> +         Support USB2/3 functionality in HiSilicon Kirin platforms.
> +         Say 'Y' or 'M' if you have one such device.

> +++ b/drivers/usb/dwc3/dwc3-hisi.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0+

You need to talk to your manager and fix License correspondingly.
Currently there is an ambigous reading.

> +/**

Why /** ?

> + * dwc3-hisi.c - Support for dwc3 platform devices on HiSilicon platforms

Usually put filename in the file is not the best idea.

> + *
> + * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
> + *             http://www.huawei.com
> + *
> + * Authors: Yu Chen <chenyu56@huawei.com>

> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2  of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

The idea of SPDX is exactly to remove the above boilerplate text.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/extcon.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pinctrl/consumer.h>

It would be easy to maintain ordered list in the future.

> +                       while (--i >= 0)

while (i--)

> +                       while (--i >= 0)

while (i--)

> +                       while (--i >= 0)

while (i--)

> +                       while (--i >= 0)

while (i--)

> +                       while (--i >= 0)

> +static int dwc3_hisi_probe(struct platform_device *pdev)
> +{
> +       struct dwc3_hisi        *dwc3_hisi;
> +       struct device           *dev = &pdev->dev;
> +       struct device_node      *np = dev->of_node;

> +

Redundant blank line

> +       int                     ret;
> +       int                     i;

> +}

> +#ifdef CONFIG_PM_SLEEP
> +static int dwc3_hisi_suspend(struct device *dev)

Don't know the usual practice here, but you can just use
__maybe_unused and remove this #ifdef.

> +{
> +       struct dwc3_hisi *dwc3_hisi = dev_get_drvdata(dev);
> +       int ret;
> +

> +       dev_info(dev, "%s\n", __func__);

Noise

> +}

> +static int dwc3_hisi_resume(struct device *dev)

__maybe_unused ?

> +{

> +       dev_info(dev, "%s\n", __func__);

Noise.

> +       /* Wait for clock stable */
> +       msleep(100);

Don't you have any hardware notification that clocks are stable?
(Something like PLL locked?)

> +
> +       return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */

> +static const struct of_device_id dwc3_hisi_match[] = {
> +       { .compatible = "hisilicon,hi3660-dwc3" },
> +       { /* sentinel */ },

No need comma for terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko
