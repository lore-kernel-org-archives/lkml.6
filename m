Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096CDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDD920C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDD920C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeGQMAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:00:11 -0400
Received: from mx.socionext.com ([202.248.49.38]:10116 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730731AbeGQMAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:00:11 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 17 Jul 2018 20:27:58 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id BE0851800E5;
        Tue, 17 Jul 2018 20:27:58 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 17 Jul 2018 20:27:58 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 3BB2B40375;
        Tue, 17 Jul 2018 20:27:58 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 06D76120424;
        Tue, 17 Jul 2018 20:27:58 +0900 (JST)
Date:   Tue, 17 Jul 2018 20:27:57 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <52b96200-2234-9017-a317-f929eac9b266@ti.com>
References: <20180711210514.BB32.4A936039@socionext.com> <52b96200-2234-9017-a317-f929eac9b266@ti.com>
Message-Id: <20180717202757.858B.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Fri, 13 Jul 2018 12:45:06 +0530 <kishon@ti.com> wrote:

> Hi,
> 
> On Wednesday 11 July 2018 05:35 PM, Kunihiko Hayashi wrote:
> > On Mon, 9 Jul 2018 20:23:19 +0900 <hayashi.kunihiko@socionext.com> wrote:
> > 
> >> Hi Kishon,
> >> Thank you for your comments.
> >>
> >> On Mon, 9 Jul 2018 10:49:50 +0530 <kishon@ti.com> wrote:
> >>
> >>> Hi,
> >>>
> >>> On Friday 29 June 2018 02:08 PM, Kunihiko Hayashi wrote:
> >>>> Add a driver for PHY interface built into USB3 controller
> >>>> implemented in UniPhier SoCs.
> >>>> This driver supports High-Speed PHY and Super-Speed PHY.
> >>>>
> >>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>>> Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> >>>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> >>>> ---
> >>>>  drivers/phy/Kconfig                         |   1 +
> >>>>  drivers/phy/Makefile                        |   1 +
> >>>>  drivers/phy/socionext/Kconfig               |  12 +
> >>>>  drivers/phy/socionext/Makefile              |   6 +
> >>>>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 422 ++++++++++++++++++++++++++++
> >>>>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 369 ++++++++++++++++++++++++
> >>>>  6 files changed, 811 insertions(+)
> >>>>  create mode 100644 drivers/phy/socionext/Kconfig
> >>>>  create mode 100644 drivers/phy/socionext/Makefile
> >>>>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
> >>>>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c
> >>
> >> (snip...)
> >>
> >>>> --- /dev/null
> >>>> +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> >>>> @@ -0,0 +1,422 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> >>>> + * Copyright 2015-2018 Socionext Inc.
> >>>> + * Author:
> >>>> + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>>> + * Contributors:
> >>>> + *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> >>>> + *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> >>>> + */
> >>>> +
> >>>> +#include <linux/bitfield.h>
> >>>> +#include <linux/bitops.h>
> >>>> +#include <linux/clk.h>
> >>>> +#include <linux/io.h>
> >>>> +#include <linux/mfd/syscon.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/nvmem-consumer.h>
> >>>> +#include <linux/of.h>
> >>>> +#include <linux/of_platform.h>
> >>>> +#include <linux/phy/phy.h>
> >>>> +#include <linux/platform_device.h>
> >>>> +#include <linux/reset.h>
> >>>> +#include <linux/slab.h>
> >>>> +
> >>>> +#define HSPHY_CFG0		0x0
> >>>> +#define HSPHY_CFG0_HS_I_MASK	GENMASK(31, 28)
> >>>> +#define HSPHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
> >>>> +#define HSPHY_CFG0_SWING_MASK	GENMASK(17, 16)
> >>>> +#define HSPHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
> >>>> +#define HSPHY_CFG0_RTERM_MASK	GENMASK(7, 6)
> >>>> +#define HSPHY_CFG0_TRIMMASK	(HSPHY_CFG0_HS_I_MASK \
> >>>> +				 | HSPHY_CFG0_SEL_T_MASK \
> >>>> +				 | HSPHY_CFG0_RTERM_MASK)
> >>>> +
> >>>> +#define HSPHY_CFG1		0x4
> >>>> +#define HSPHY_CFG1_DAT_EN	BIT(29)
> >>>> +#define HSPHY_CFG1_ADR_EN	BIT(28)
> >>>> +#define HSPHY_CFG1_ADR_MASK	GENMASK(27, 16)
> >>>> +#define HSPHY_CFG1_DAT_MASK	GENMASK(23, 16)
> >>>> +
> >>>> +#define MAX_CLKS	3
> >>>> +#define MAX_RSTS	2
> >>>> +#define MAX_PHY_PARAMS	1
> >>>> +
> >>>> +struct uniphier_u3hsphy_param {
> >>>> +	u32 addr;
> >>>> +	u32 mask;
> >>>> +	u32 val;
> >>>> +};
> >>>
> >>> I'd like to avoid configure the PHY this way, since it's impossible to know
> >>> which register is being configured.
> >>
> > 
> > This way might be misunderstood.
> > These HS-PHY and SS-PHY have "internal" registers, which are not memory-mapped.
> > 
> > And to access these internal registers, we need to specify the number
> > corresponding to the register.
> > 
> > The "addr" in "uniphier_u3hsphy_param" is just the number of the register.
> > The "mask" shows a bitfield of the register, that means one of PHY parameters.
> > The "value" shows a parameter value to set to the bitfield.
> 
> What does each of these bitfields represent? Which PHY parameter does it
> configure. Are they really PHY parameters or they also configure clocks/mux
> etc? I would like the configurations to be more descriptive so that we get to
> know at least what's getting configured here.

These bitfields represent phy parameters only, not include clocks/mux etc.
We can express the register (bitfield) name with macros.

However, only recommended values are noted for the bitfields in the specsheet,
because there are the trimmed values that aren't set as power-on values,
and we should use the values for stable operation.

This driver includes only minimal parameter set, so I think it's difficult
to express them more configurable.

Thank you,

---
Best Regards,
Kunihiko Hayashi


