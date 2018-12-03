Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2420851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeLCIas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:30:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbeLCIar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:30:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF67723CD3B2F;
        Mon,  3 Dec 2018 16:30:41 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 16:30:33 +0800
CC:     <wangbinghui@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 04/12] usb: dwc3: dwc3-hisi: Add code for dwc3 of
 Hisilicon Soc Platform
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-5-chenyu56@huawei.com>
 <CAHp75VcdbJ9KV2Xr9mQsAcODMCJUMXz0OY0t_FSJgZ6dXx2fYQ@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <2b46d6fc-a132-40fa-6f15-78e84a4d3b01@huawei.com>
Date:   Mon, 3 Dec 2018 16:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcdbJ9KV2Xr9mQsAcODMCJUMXz0OY0t_FSJgZ6dXx2fYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/12/3 16:12, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 5:48 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> This driver handles the poweron and shutdown of dwc3 core
>> on Hisilicon Soc Platform.
> 
>> +config USB_DWC3_HISI
>> +       tristate "HiSilicon Kirin Platforms"
>> +       depends on ((ARCH_HISI && ARM64) || COMPILE_TEST) && OF
> 
> It would be easy to read if
> depends on OF
> would be on a separate line
> 
>> +       default USB_DWC3
>> +       help
>> +         Support USB2/3 functionality in HiSilicon Kirin platforms.
>> +         Say 'Y' or 'M' if you have one such device.
> 
>> +++ b/drivers/usb/dwc3/dwc3-hisi.c
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> You need to talk to your manager and fix License correspondingly.
> Currently there is an ambigous reading.
> 
>> +/**
> 
> Why /** ?
> 
>> + * dwc3-hisi.c - Support for dwc3 platform devices on HiSilicon platforms
> 
> Usually put filename in the file is not the best idea.
> 
>> + *
>> + * Copyright (C) 2017-2018 Hilisicon Electronics Co., Ltd.
>> + *             http://www.huawei.com
>> + *
>> + * Authors: Yu Chen <chenyu56@huawei.com>
> 
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2  of
>> + * the License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
> 
> The idea of SPDX is exactly to remove the above boilerplate text.
> 
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/extcon.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/pinctrl/consumer.h>
> 
> It would be easy to maintain ordered list in the future.
> 
>> +                       while (--i >= 0)
> 
> while (i--)
> 
>> +                       while (--i >= 0)
> 
> while (i--)
> 
>> +                       while (--i >= 0)
> 
> while (i--)
> 
>> +                       while (--i >= 0)
> 
> while (i--)
> 
>> +                       while (--i >= 0)
> 
>> +static int dwc3_hisi_probe(struct platform_device *pdev)
>> +{
>> +       struct dwc3_hisi        *dwc3_hisi;
>> +       struct device           *dev = &pdev->dev;
>> +       struct device_node      *np = dev->of_node;
> 
>> +
> 
> Redundant blank line
> 
>> +       int                     ret;
>> +       int                     i;
> 
>> +}
> 
>> +#ifdef CONFIG_PM_SLEEP
>> +static int dwc3_hisi_suspend(struct device *dev)
> 
> Don't know the usual practice here, but you can just use
> __maybe_unused and remove this #ifdef.
> 
>> +{
>> +       struct dwc3_hisi *dwc3_hisi = dev_get_drvdata(dev);
>> +       int ret;
>> +
> 
>> +       dev_info(dev, "%s\n", __func__);
> 
> Noise
> 
>> +}
> 
>> +static int dwc3_hisi_resume(struct device *dev)
> 
> __maybe_unused ?
> 
>> +{
> 
>> +       dev_info(dev, "%s\n", __func__);
> 
> Noise.
> 
>> +       /* Wait for clock stable */
>> +       msleep(100);
> 
> Don't you have any hardware notification that clocks are stable?
> (Something like PLL locked?)
> 
>> +
>> +       return 0;
>> +}
>> +#endif /* CONFIG_PM_SLEEP */
> 
>> +static const struct of_device_id dwc3_hisi_match[] = {
>> +       { .compatible = "hisilicon,hi3660-dwc3" },
>> +       { /* sentinel */ },
> 
> No need comma for terminator line.
> 
>> +};
> 

Thanks a lot for your advice! I will check and fix the patch.

Chen Yu

