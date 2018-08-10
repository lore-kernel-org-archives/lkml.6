Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F53EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEC4223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEC4223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeHJE5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:57:55 -0400
Received: from mx.socionext.com ([202.248.49.38]:31486 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeHJE5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:57:55 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Aug 2018 11:30:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 2344C600AA;
        Fri, 10 Aug 2018 11:30:10 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 10 Aug 2018 11:30:10 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 5E05A40363;
        Fri, 10 Aug 2018 11:30:09 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 13DD3120415;
        Fri, 10 Aug 2018 11:30:09 +0900 (JST)
Date:   Fri, 10 Aug 2018 11:30:08 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <312d10ae-7909-bede-ea0a-5d92a497f639@ti.com>
References: <1533290045-18969-3-git-send-email-hayashi.kunihiko@socionext.com> <312d10ae-7909-bede-ea0a-5d92a497f639@ti.com>
Message-Id: <20180810113007.0746.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Thu, 9 Aug 2018 16:00:19 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Hi,
> 
> On Friday 03 August 2018 03:24 PM, Kunihiko Hayashi wrote:
> > Add a driver for PHY interface built into USB3 controller
> > implemented in UniPhier SoCs.
> > This driver supports High-Speed PHY and Super-Speed PHY.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > ---
> >  drivers/phy/Kconfig                         |   1 +
> >  drivers/phy/Makefile                        |   1 +
> >  drivers/phy/socionext/Kconfig               |  12 +
> >  drivers/phy/socionext/Makefile              |   6 +
> >  drivers/phy/socionext/phy-uniphier-usb3hs.c | 423 ++++++++++++++++++++++++++++
> >  drivers/phy/socionext/phy-uniphier-usb3ss.c | 350 +++++++++++++++++++++++
> >  6 files changed, 793 insertions(+)
> >  create mode 100644 drivers/phy/socionext/Kconfig
> >  create mode 100644 drivers/phy/socionext/Makefile
> >  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
> >  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

[snip]

> > --- /dev/null
> > +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> > +// Copyright 2015-2018 Socionext Inc.
> > +// Author:
> > +//      Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > +// Contributors:
> > +//      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > +//      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > +
> 
> I'm not sure if there is a standard format for adding SPDX identifiers. But
> other PHY drivers seems to have used single line comment style only for the
> first line. (see drivers/phy/amlogic/phy-meson-gxl-usb3.c)

Okay, I understand that the format differs depending on each sub-system so far.
I'll rewrite it according to other PHY drivers.

Same as phy-uniphier-usb3ss.c.

> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>

[snip]

> > +	phy = devm_phy_create(dev, dev->of_node, &uniphier_u3hsphy_ops);
> > +	if (IS_ERR(phy))
> > +		return PTR_ERR(phy);
> > +
> > +	phy_set_drvdata(phy, priv);
> > +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider))
> > +		return PTR_ERR(phy_provider);
> 
> return PTR_ERR_OR_ZERO()?

Indeed. I'll replace it as follows.

	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
	return PTR_ERR_OR_ZERO(phy_provider);

Same as phy-uniphier-usb3ss.c.

Thank you,

---
Best Regards,
Kunihiko Hayashi


