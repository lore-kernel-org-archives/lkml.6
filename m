Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421CC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA0521473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhkIFqcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA0521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLCJXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:23:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38425 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLCJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:23:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so6882683qkg.5;
        Mon, 03 Dec 2018 01:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzEQLHk5lgAA5E0RyRju2SXaYKs0b2Do2xr9/bHiFoU=;
        b=bhkIFqcJ1F4hElH//yJXv5OvBG52iCdoOVV186dZWFc2YYsDUMxkJCpS2Oz+Yag4eG
         2JUtFgYUghAVwI5UhMom6tMxeio1VQmDHp8Xa999voWR1jiabRcOgzPz7/Tma8oySaxN
         HWh8ggRcyGsT4ckTKmx3TH/iQT1BfCbajVjhrkJUPwAWMSj8+OtAHHXhYt0ByuHXuLND
         Me5Fbz2zfREAjU58J3HoIdvKdCqc8N3ldc8J3/kM3glkYlYa3cpdmGvzbV0O2dfE7Jri
         fMGhf7E1Kxq2O00Gzplyx+PT50UyGrbQxR0zyNPPG6TD3NM3h13ZJZfDmcZ1DQqw8cQP
         NwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzEQLHk5lgAA5E0RyRju2SXaYKs0b2Do2xr9/bHiFoU=;
        b=MhjJldgFCXrTMqkRBwgSIbMIo4e/CmDlCDuBR1fcqq2/sH0vhnPUoq1IvVUaCiSjUG
         5bXzZugqp8AMwG8B2ZFvQf1Xm64PJ7DTELTjHHPFzEuDVNNMp/I0mrB14i+h6dP+EXpT
         3tFtyuCXQhQI3JPMchkOjgWluMIJLFMaOLB8sAhPytt9rqJUPcSZx78N1BM3umLPtQpd
         4OP3ZeRnmMC9qPf/NLoI6L1W7lT4h9LNomOMrfXExw/DpDCp1B/do+rBddIlM9nWrDUA
         Oq+0Do4hdbfpcipkzDur56E9zOtLXpLeQq3z6/eX6dWOk+IPWMU+i73+e+yGp0VLN1nN
         V2dg==
X-Gm-Message-State: AA+aEWZ00S2SRlCU7in7L4YgNOvfelaqw02EOWm5+AuwI3wLsLOr0s+6
        FsumVojMaDPPOrlKKbq7K24IcjoRfwyOkm6xSonTpWUV
X-Google-Smtp-Source: AFSGD/WhBX/i0hlTZD53FCALKwNlSm4da0MIc3YCOxvqG6PPEGosT6luTWV8bzIBdluzffL/EdEsPnwko8vaRxt3PQE=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr13988551qkl.70.1543828991816;
 Mon, 03 Dec 2018 01:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-11-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-11-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 11:23:00 +0200
Message-ID: <CAHp75VdSowHk4meQqqUamSjJJoVT59+pMZ1qjmmWd-W5nWBcUw@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] hikey960: Support usb functionality of Hikey960
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> This driver handles usb hub power on and typeC port event of HiKey960 board:
> 1)DP&DM switching between usb hub and typeC port base on typeC port
> state
> 2)Control power of usb hub on Hikey960
> 3)Control vbus of typeC port

> +config HISI_HIKEY_USB
> +       tristate "USB functionality of HiSilicon Hikey Platform"
> +       depends on GPIOLIB

> +       default n

No, Linus is not happy about this.
Default n _is_ a default.

> +       help
> +         If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hisi_hikey_usb.c
> + *
> + * Copyright (c) Hisilicon Tech. Co., Ltd. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */

Same comments to the above lines.

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/usb/role.h>
> +#include <linux/notifier.h>

Order?

> +       pr_debug("%s: set hub power %d\n", __func__, value);

Noise.

> +       pr_debug("%s: switch to %s\n", __func__, switch_to_str);

Noise.

> +       pr_debug("%s: set typec vbus gpio to %d\n", __func__, value);

Noise.

> +       if (!nb)
> +               return -EINVAL;

On which conditions this happen?

> +       pr_info("%s:set typec state to %lu\n", __func__, state);

Noise!

Guys, you perhaps can read about tracepoints and function tracer
facilities in the kernel.

> +static int hisi_hikey_usb_probe(struct platform_device *pdev)
> +{

> +               pr_info("%s: typc_vbus_enable_val can't get\n", __func__);

Noise!

> +       if (IS_ERR_OR_NULL(hisi_hikey_usb->typec_vbus)) {

So, this check is redundant. You are repeating it below.

> +               if (!hisi_hikey_usb->typec_vbus)
> +                       ret = -EINVAL;
> +               else
> +                       ret = PTR_ERR(hisi_hikey_usb->typec_vbus);
> +               return ret;
> +       }

> +       if (IS_ERR_OR_NULL(hisi_hikey_usb->role_sw)) {

> +               pr_err("%s: usb_role_switch_get failed\n", __func__);

Noise and same comment to the conditional check as above

> +               if (!hisi_hikey_usb->role_sw)
> +                       ret = -ENOENT;
> +               else
> +                       ret = PTR_ERR(hisi_hikey_usb->role_sw);
> +               return ret;
> +       }

> +               .of_match_table = of_match_ptr(id_table_hisi_hikey_usb),

Does it compiles for non-OF case? Why macro is in use?

-- 
With Best Regards,
Andy Shevchenko
