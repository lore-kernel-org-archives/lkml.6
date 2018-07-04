Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE953C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6888F208E9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6888F208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeGDQwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:52:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36877 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeGDQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:52:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so4470853edq.4;
        Wed, 04 Jul 2018 09:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d3W+kNKfQFkcHE0IvDFWIswyD7iL7m/R52rvM46n6pk=;
        b=Wh/LMDXo4TAahYoUAziOZcJ4nYzM/66/7zODYCpC2zL8OTlVyIq8heqNquXhtwhmYh
         BvXaH4U05683bWOqu3FbPB8cnsLL18ywY1ZlFQDr5PnMIx5arciDjoiRlBK7wtsoWGL5
         20nFHxqlBITscRQ5ljL6+XY0epnfLBg94qflL4Ykf3Qr+KRBP4vY5C/h0w6jUkMmWSay
         yhcK8cNNX2L3SNIwuv8BOrA7hmJK8DU+SWEkQ7TU41O77DZjFjOHFU+g/LoitG7jXRX+
         BpoCz6ENDrxRni/AjJ7LAp12aWKkTq2yVwSQicFP8KsgvNmdNRmF15d4xWabAXHsPGg8
         gocg==
X-Gm-Message-State: APt69E0uZB8u//Qo0Eli/rsEK/LpiSpYwMNml9NBkJ1c/Qdqnc6LiV3v
        me02YujbP3CuPNi+KjA9qWQCRHgp
X-Google-Smtp-Source: AAOMgpfUyxPrSpFtbVGRxFo4WZPoFDkJgmnqwo6KQGLE5YDM4DhBZIDTdlFlf/0pvHIBVxehMx6OZg==
X-Received: by 2002:a50:ca83:: with SMTP id x3-v6mr3650626edh.100.1530723165998;
        Wed, 04 Jul 2018 09:52:45 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id i12-v6sm2222611edf.26.2018.07.04.09.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 09:52:44 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id n17-v6so6861883wmh.2;
        Wed, 04 Jul 2018 09:52:44 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr2135726wma.143.1530723164512;
 Wed, 04 Jul 2018 09:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:52:23 -0700 (PDT)
In-Reply-To: <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com> <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell> <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
 <20180703071103.GE20176@dell> <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 5 Jul 2018 00:52:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65DX5hS1c93a1ouQsi4R2xaKKkkwKfHqzE_VKPq-TwrBA@mail.gmail.com>
Message-ID: <CAGb2v65DX5hS1c93a1ouQsi4R2xaKKkkwKfHqzE_VKPq-TwrBA@mail.gmail.com>
Subject: Re: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>, ck.hu@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Miller <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 12:17 AM, Matthias Brugger <mbrugger@suse.com> wrote:
>
>
> On 03/07/18 09:11, Lee Jones wrote:
>> On Mon, 25 Jun 2018, Matthias Brugger wrote:
>>> On 30/04/18 12:18, Lee Jones wrote:
>>>> On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
>>>>
>>>>> From: Matthias Brugger <mbrugger@suse.com>
>>>>>
>>>>> The MMSYS subsystem includes clocks and drm components.
>>>>> This patch adds a MFD device to probe both drivers from the same
>>>>> device tree compatible.
>>>>>
>>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>>> ---
>>>>>  drivers/mfd/Kconfig     |  9 ++++++
>>>>>  drivers/mfd/Makefile    |  2 ++
>>>>>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 90 insertions(+)
>>>>>  create mode 100644 drivers/mfd/mtk-mmsys.c
>>>>>
>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>> index b860eb5aa194..d23a3b9a2c58 100644
>>>>> --- a/drivers/mfd/Kconfig
>>>>> +++ b/drivers/mfd/Kconfig
>>>>> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
>>>>>    help
>>>>>      Select this if your MC13xxx is connected via an I2C bus.
>>>>>
>>>>> +config MFD_MEDIATEK_MMSYS
>>>>> +  tristate "Mediatek MMSYS interface"
>>>>> +  select MFD_CORE
>>>>> +  select REGMAP_MMIO
>>>>> +  help
>>>>> +    Select this if you have a MMSYS subsystem in your SoC. The
>>>>> +    MMSYS subsystem has at least a clock driver part and some
>>>>> +    DRM components.
>>>>> +
>>>>>  config MFD_MXS_LRADC
>>>>>    tristate "Freescale i.MX23/i.MX28 LRADC"
>>>>>    depends on ARCH_MXS || COMPILE_TEST
>>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>>> index d9d2cf0d32ef..b96118bd68d9 100644
>>>>> --- a/drivers/mfd/Makefile
>>>>> +++ b/drivers/mfd/Makefile
>>>>> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)        += mc13xxx-core.o
>>>>>  obj-$(CONFIG_MFD_MC13XXX_SPI)     += mc13xxx-spi.o
>>>>>  obj-$(CONFIG_MFD_MC13XXX_I2C)     += mc13xxx-i2c.o
>>>>>
>>>>> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
>>>>> +
>>>>>  obj-$(CONFIG_MFD_CORE)            += mfd-core.o
>>>>>
>>>>>  obj-$(CONFIG_EZX_PCAP)            += ezx-pcap.o
>>>>> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
>>>>> new file mode 100644
>>>>> index 000000000000..c802343fb1c6
>>>>> --- /dev/null
>>>>> +++ b/drivers/mfd/mtk-mmsys.c
>>>>> @@ -0,0 +1,79 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +
>>>>> +/*
>>>>> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
>>>>> + *
>>>>> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
>>>>> + *
>>>>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
>>>>> + */
>>>>> +
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/mfd/core.h>
>>>>> +#include <linux/of.h>
>>>>> +#include <linux/of_address.h>
>>>>> +#include <linux/of_device.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/regmap.h>
>>>>> +
>>>>> +enum {
>>>>> +  MMSYS_MT2701 = 1,
>>>>> +};
>>>>> +
>>>>> +static const struct mfd_cell mmsys_mt2701_devs[] = {
>>>>> +  { .name = "clk-mt2701-mm", },
>>>>> +  { .name = "drm-mt2701-mm", },
>>>>> +};
>>>>> +
>>>>> +static int mmsys_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +  const struct mfd_cell *mmsys_cells;
>>>>> +  int nr_cells;
>>>>> +  long id;
>>>>> +  int ret;
>>>>> +
>>>>> +  id = (long) of_device_get_match_data(&pdev->dev);
>>>>> +  if (!id) {
>>>>> +          dev_err(&pdev->dev, "of_device_get match_data() failed\n");
>>>>> +          return -EINVAL;
>>>>> +  }
>>>>> +
>>>>> +  switch (id) {
>>>>> +  case MMSYS_MT2701:
>>>>> +          mmsys_cells = mmsys_mt2701_devs;
>>>>> +          nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
>>>>> +          break;
>>>>> +  default:
>>>>> +          return -ENODEV;
>>>>> +  }
>>>>> +
>>>>> +  ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
>>>>> +                                  NULL, 0, NULL);
>>>>> +  if (ret) {
>>>>> +          dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
>>>>> +          return ret;
>>>>> +  }
>>>>> +
>>>>> +  return 0;
>>>>> +};
>>>>
>>>> This driver is pretty pointless.  It doesn't actually do anything.
>>>>
>>>> I think you just want to use "simple-mfd" instead.
>>>>
>>>
>>> I think the problem is, that right now we have two drivers which use the same
>>> devicetree binding, which are clk and drm driver. With a simple-mfd we would
>>> need two compatibles, and this would break backwards compatibility.
>>
>> So what functionality does this driver provide you with that you do
>> not have currently?
>>
>
> I'm not sure if I get your question. Point is, that the MMSYS implementation for
> mt8173 is broken, as it assumes that we can probe two drivers with the
> mediatek,mt8173-mmsys compatible. Somehow it used to work, but from what I
> understand it was a bug. So older devicetrees use just on mt8173-mmsys
> compatible in ther DTB.

This works probably because the clk driver is using CLK_OF_DECLARE, which
does not use the device model (i.e. no attached struct dev). So later on,
when the device model scans and adds this device, it's considered not
probed yet, and the drm driver will probe.

This breaks horribly if you try to move the clk driver to a platform
device driver based implementation. On the other hand, if you need the
clk in early init, you can't use a platform or mfd device.

Regards
ChenYu

>
> I would like to keep backwards compatibility for the device tree, that's why I
> was searching for a solution where we can probe two drivers and came up with
> this mfd solution.
>
> So no new functionality, the clk driver provides the clock the drm components need.
>
> Regards,
> Matthias
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
