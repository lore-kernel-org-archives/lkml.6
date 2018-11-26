Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0442C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C9020659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHwxKvM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C9020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeK0CyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:54:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36589 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeK0CyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:54:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so19113311wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hTi60HFYJZM3T4cDqj7q3byHGTKGLyEPOibwWC6mTA=;
        b=fHwxKvM6poAsaP0bfHUIPhfTIzK5hjBGeNh9ZmVvWISrox8V2Bu2afLd+j4uT//1RM
         fELM9Yz1d/Fa7D2Srr+rZivYj3EGe5p6L9ZE7LibDKdMMgMdbEgP3rSWH9i3zF5HHLxy
         0trkK5MS+r3s9cPNaI2G4WLFtZEm0On94gKpiJruJkoP8XDBH/KOWkQxhsvszbO4eYZ7
         1HSFi3arSGMl8JTb7q10EvnIKkJzI2dKLnXTwoQAjALE+sXTTLYX/aqxJ6fJ225kXDGM
         /bT6INByhhhqPQaF9pIR+jdn5MkYOfZEmuBN3QW1LsDPaNy5ojyU3NaCBLniyrvT8vdH
         lr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hTi60HFYJZM3T4cDqj7q3byHGTKGLyEPOibwWC6mTA=;
        b=Zuhyqbx3vfSa2GYg+TtnZJkrsJ8ScCHTzcyYO2WR0C270A6MnHZ9bvU1tgNwW8rxVB
         6A7MUtnxn8GFBV9F6QRyqKCqeHm1OV4fZfogvYjbyeglVsjhFYf8oyOIurwUtSymnhlJ
         xTvojJM4InJkIIUlwPi8XO480kITQ5lE760aWCZHQJOVgj+14+h+XpXFdtjB4LEN7Qvh
         uuHFqdZ99Fgm4w09wRJ40iHdTt6eZHhzmGu02IY9Zej4rfIqLjlz9BCJTOlzSeTi+7IV
         ElI/ZqTGNi8hvmEmun45qsSty7HEQhXgb5qcGp+fgjhmmAH3CIhSl7piLLVkyId+wvTC
         4M1A==
X-Gm-Message-State: AGRZ1gKtRBBHzoKrEYh2kqVMWJZreV4J2mVywNlRQzF+LmGuqQxwGupx
        ci1L6QZ7bQYS/RmoojPoQoxODfiN2S3gnfYyKP4=
X-Google-Smtp-Source: AFSGD/WwroWtVL2nuZ74z1QBN26I7Xg6y2GJFnOisw3E/tCEBM3hH+Cg+oy5xoukm7+BbI0i8NqLy4jNN2DkakAtkxc=
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr22809688wmb.127.1543247989205;
 Mon, 26 Nov 2018 07:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20181117181131.9330-1-andrew.smirnov@gmail.com>
 <20181117181131.9330-2-andrew.smirnov@gmail.com> <1542637950.5139.12.camel@pengutronix.de>
In-Reply-To: <1542637950.5139.12.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Nov 2018 07:59:37 -0800
Message-ID: <CAHQ1cqFEKHR3VW9gfaZcp-BJeh5PTM85F1kPF0am0rmaW9HiRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] reset: imx7: Add support for i.MX8MQ
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:32 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Andrey,
>
> thank you for the patch.
>
> In general, sharing the lookup table with i.MX7 is fine iff it is a
> strict superset. But I don't think that is the case (see below).
> Even so, this will change if there ever is another i.MX7 or i.MX8M
> variant that is also a superset of i.MX7, but not a superset of
> i.MX8M. Also, just listing all resets in order of appearance would make
> review a bit easier.
>
> I don't like increasing IMX7_RESET_NUM though, i.MX8M should have its
> own nr_resets.
>
> On Sat, 2018-11-17 at 10:11 -0800, Andrey Smirnov wrote:
> > SRC IP block used in i.MX8MQ is a superset of what is found in i.MX7D,
>
> Is this true, though?
>
> i.MX7 has SRC_ERCR at offset 0x14 and HSICPHY_RCR at offset 0x1c.
> According to documentation, i.MX8M is missing those at least.
>

OK, I'll convert the patch to use separate LUTs in v2.

> > so add all of the definitions necessary to support both.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/Kconfig                   |  2 +-
> >  drivers/reset/reset-imx7.c              | 66 ++++++++++++++++++++++++-
> >  include/dt-bindings/reset/imx7-reset.h  | 15 +++++-
> >  include/dt-bindings/reset/imx8m-reset.h | 47 ++++++++++++++++++
> >  4 files changed, 127 insertions(+), 3 deletions(-)
> >  create mode 100644 include/dt-bindings/reset/imx8m-reset.h
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index c21da9fe51ec..4909aab7401b 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -50,7 +50,7 @@ config RESET_HSDK
> >  config RESET_IMX7
> >       bool "i.MX7 Reset Driver" if COMPILE_TEST
> >       depends on HAS_IOMEM
> > -     default SOC_IMX7D
> > +     default SOC_IMX7D || SOC_IMX8MQ
> >       select MFD_SYSCON
> >       help
> >         This enables the reset controller driver for i.MX7 SoCs.
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index 77911fa8f31d..dffad618f805 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -21,14 +21,16 @@
> >  #include <linux/reset-controller.h>
> >  #include <linux/regmap.h>
> >  #include <dt-bindings/reset/imx7-reset.h>
> > +#include <dt-bindings/reset/imx8m-reset.h>
> >
> >  struct imx7_src {
> >       struct reset_controller_dev rcdev;
> >       struct regmap *regmap;
> >  };
> >
> > -enum imx7_src_registers {
> > +enum imx_src_registers {
> >       SRC_A7RCR0              = 0x0004,
> > +     SRC_A53RCR0             = 0x0004,
> >       SRC_M4RCR               = 0x000c,
> >       SRC_ERCR                = 0x0014,
> >       SRC_HSICPHY_RCR         = 0x001c,
> > @@ -36,7 +38,9 @@ enum imx7_src_registers {
> >       SRC_USBOPHY2_RCR        = 0x0024,
> >       SRC_MIPIPHY_RCR         = 0x0028,
> >       SRC_PCIEPHY_RCR         = 0x002c,
>
> These aren't complete. I see at least SRC_HDMI_RCR, SRC_DISP_RCR,
> SRC_GPU_RCR, and SRC_VPU_RCR missing.
>
> > +     SRC_PCIE2PHY_RCR        = 0x0048,
>
> And SRC_MIPIPHY1_RCR, SRC_MIPIPHY2_RCR. Please check the reference
> manual and complete the list of registers that contain resets.
>
> >       SRC_DDRC_RCR            = 0x1000,
> > +
>
> Whitespace.
>
> >  };
> >
> >  struct imx7_src_signal {
> > @@ -67,11 +71,67 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
> >       [IMX7_RESET_PCIEPHY]            = { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
> >       [IMX7_RESET_PCIEPHY_PERST]      = { SRC_PCIEPHY_RCR, BIT(3) },
> >       [IMX7_RESET_PCIE_CTRL_APPS_EN]  = { SRC_PCIEPHY_RCR, BIT(6) },
> > +     [IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ] = { SRC_PCIEPHY_RCR, BIT(4) },
>
> Now I feel like CTRL_APPS_EN shouldn't have been added here either. But
> while there I wasn't really sure about whether that is actually a valid
> reset, I'm pretty sure that this one isn't.
> I think that i.MX8M either needs a clock driver to control this bit and
> the corresponding IOMUXC GPR bit to enable the PCIe refclk, or the PCIe
> driver has to access this register via syscon. I really don't want to
> see a clock enable signal described in the device tree as a reset.
>

OK, will drop in v2.

> >       [IMX7_RESET_PCIE_CTRL_APPS_TURNOFF] = { SRC_PCIEPHY_RCR, BIT(11) },
> >       [IMX7_RESET_DDRC_PRST]          = { SRC_DDRC_RCR, BIT(0) },
> >       [IMX7_RESET_DDRC_CORE_RST]      = { SRC_DDRC_RCR, BIT(1) },
> > +
> > +     [IMX8M_RESET_A53_CORE_POR_RESET2] = { SRC_A53RCR0, BIT(2) },
> > +     [IMX8M_RESET_A53_CORE_POR_RESET3] = { SRC_A53RCR0, BIT(3) },
> > +     [IMX8M_RESET_A53_CORE_RESET2]     = { SRC_A53RCR0, BIT(6) },
> > +     [IMX8M_RESET_A53_CORE_RESET3]     = { SRC_A53RCR0, BIT(7) },
>
> Missing IMX8M_RESET_A53_DBG_RESET2,3.
>
> > +     [IMX8M_RESET_A53_ETM_RESET2]      = { SRC_A53RCR0, BIT(14) },
> > +     [IMX8M_RESET_A53_ETM_RESET3]      = { SRC_A53RCR0, BIT(15) },
>
> Missing some reset registers here.
>
> > +     [IMX8M_RESET_PCIE2PHY]          = { SRC_PCIEPHY_RCR, BIT(2) | BIT(1) },
> > +     [IMX8M_RESET_PCIE2PHY_PERST]      = { SRC_PCIE2PHY_RCR, BIT(3) },
> > +     [IMX8M_RESET_PCIE2_CTRL_APPS_EN]  = { SRC_PCIE2PHY_RCR, BIT(6) },
> > +     [IMX8M_RESET_PCIE2_CTRL_APPS_CLK_REQ] = { SRC_PCIE2PHY_RCR, BIT(4) },
>
> See above.
>
> > +     [IMX8M_RESET_PCIE2_CTRL_APPS_TURNOFF] = { SRC_PCIE2PHY_RCR, BIT(11) },
>
> Missing some reset registers here.
>
> >  };
> >
> > +static inline void imx7_src_check_definitions(void)
> > +{
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_CORE_POR_RESET0 !=
> > +                  IMX7_RESET_A7_CORE_POR_RESET0);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_CORE_POR_RESET1 !=
> > +                  IMX7_RESET_A7_CORE_POR_RESET1);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_CORE_RESET0 !=
> > +                  IMX7_RESET_A7_CORE_RESET0);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_CORE_RESET1 !=
> > +                  IMX7_RESET_A7_CORE_RESET1);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_DBG_RESET0 !=
> > +                  IMX7_RESET_A7_DBG_RESET0);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_DBG_RESET1 !=
> > +                  IMX7_RESET_A7_DBG_RESET1);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_ETM_RESET0 !=
> > +                  IMX7_RESET_A7_ETM_RESET0);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_ETM_RESET1 !=
> > +                  IMX7_RESET_A7_ETM_RESET1);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_SOC_DBG_RESET !=
> > +                  IMX7_RESET_A7_SOC_DBG_RESET);
> > +     BUILD_BUG_ON(IMX8M_RESET_A53_L2RESET != IMX7_RESET_A7_L2RESET);
> > +     BUILD_BUG_ON(IMX8M_RESET_SW_M4C_RST != IMX7_RESET_SW_M4C_RST);
> > +     BUILD_BUG_ON(IMX8M_RESET_SW_M4P_RST != IMX7_RESET_SW_M4P_RST);
> > +     BUILD_BUG_ON(IMX8M_RESET_EIM_RST != IMX7_RESET_EIM_RST);
> > +     BUILD_BUG_ON(IMX8M_RESET_HSICPHY_PORT_RST !=
> > +                  IMX7_RESET_HSICPHY_PORT_RST);
> > +     BUILD_BUG_ON(IMX8M_RESET_USBPHY1_POR != IMX7_RESET_USBPHY1_POR);
> > +     BUILD_BUG_ON(IMX8M_RESET_USBPHY1_PORT_RST !=
> > +                  IMX7_RESET_USBPHY1_PORT_RST);
> > +     BUILD_BUG_ON(IMX8M_RESET_USBPHY2_POR != IMX7_RESET_USBPHY2_POR);
> > +     BUILD_BUG_ON(IMX8M_RESET_USBPHY2_PORT_RST !=
> > +                  IMX7_RESET_USBPHY2_PORT_RST);
> > +     BUILD_BUG_ON(IMX8M_RESET_MIPI_PHY_MRST != IMX7_RESET_MIPI_PHY_MRST);
> > +     BUILD_BUG_ON(IMX8M_RESET_MIPI_PHY_SRST != IMX7_RESET_MIPI_PHY_SRST);
> > +     BUILD_BUG_ON(IMX8M_RESET_PCIEPHY != IMX7_RESET_PCIEPHY);
> > +     BUILD_BUG_ON(IMX8M_RESET_PCIE_CTRL_APPS_EN !=
> > +                  IMX7_RESET_PCIE_CTRL_APPS_EN);
> > +     BUILD_BUG_ON(IMX8M_RESET_PCIE_CTRL_APPS_TURNOFF !=
> > +                  IMX7_RESET_PCIE_CTRL_APPS_TURNOFF);
> > +     BUILD_BUG_ON(IMX8M_RESET_DDRC_PRST != IMX7_RESET_DDRC_PRST);
> > +     BUILD_BUG_ON(IMX8M_RESET_DDRC_CORE_RST != IMX7_RESET_DDRC_CORE_RST);
> > +}
>
> This won't be necessary with a separate lookup table.
>
> >  static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
> >  {
> >       return container_of(rcdev, struct imx7_src, rcdev);
> > @@ -85,6 +145,7 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
> >       unsigned int value = assert ? signal->bit : 0;
> >
> >       switch (id) {
> > +     case IMX8M_RESET_PCIE2PHY: /* FALLTHROUGH */
>
> I'd prefer lowercase /* fallthrough */.
>
> >       case IMX7_RESET_PCIEPHY:
> >               /*
> >                * wait for more than 10us to release phy g_rst and
> > @@ -94,6 +155,7 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
> >                       udelay(10);
> >               break;
> >
> > +     case IMX8M_RESET_PCIE2_CTRL_APPS_EN: /* FALLTHROUGH */
>
> And here.
>
> >       case IMX7_RESET_PCIE_CTRL_APPS_EN:
> >               value = (assert) ? 0 : signal->bit;
> >               break;
> > @@ -126,6 +188,8 @@ static int imx7_reset_probe(struct platform_device *pdev)
> >       struct device *dev = &pdev->dev;
> >       struct regmap_config config = { .name = "src" };
> >
> > +     imx7_src_check_definitions();
> > +
> >       imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
> >       if (!imx7src)
> >               return -ENOMEM;
> > diff --git a/include/dt-bindings/reset/imx7-reset.h b/include/dt-bindings/reset/imx7-reset.h
> > index 31b3f87dde9a..8fefd694d481 100644
> > --- a/include/dt-bindings/reset/imx7-reset.h
> > +++ b/include/dt-bindings/reset/imx7-reset.h
> > @@ -57,8 +57,21 @@
> >  #define IMX7_RESET_DDRC_CORE_RST     24
> >
> >  #define IMX7_RESET_PCIE_CTRL_APPS_TURNOFF 25
> > +#define IMX7_RESET_PCIE_CTRL_APPS_CLK_REQ 26
>
> See above.
>
> > -#define IMX7_RESET_NUM                       26
>
> Please leave this at 26.
>
> > +#define      IMX8M_RESET_A53_CORE_POR_RESET2 27
> > +#define IMX8M_RESET_A53_CORE_POR_RESET3      28
> > +#define IMX8M_RESET_A53_CORE_RESET2  29
> > +#define      IMX8M_RESET_A53_CORE_RESET3     30
> > +#define IMX8M_RESET_A53_ETM_RESET2   31
> > +#define IMX8M_RESET_A53_ETM_RESET3   32
> > +#define IMX8M_RESET_PCIE2PHY         33
> > +#define IMX8M_RESET_PCIE2PHY_PERST   34
> > +#define IMX8M_RESET_PCIE2_CTRL_APPS_EN       35
> > +#define IMX8M_RESET_PCIE2_CTRL_APPS_CLK_REQ 36
>
> See above.
>
> > +#define IMX8M_RESET_PCIE2_CTRL_APPS_TURNOFF 37
>
> Move these into imx8m-reset.h
>
> > +
> > +#define IMX7_RESET_NUM                       38
>
> And add a separate IMX8M_RESET_NUM.
>
> >
> >  #endif
> >
> > diff --git a/include/dt-bindings/reset/imx8m-reset.h b/include/dt-bindings/reset/imx8m-reset.h
> > new file mode 100644
> > index 000000000000..8fa840354723
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/imx8m-reset.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 Zodiac Inflight Innovations
> > + *
> > + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> > + */
> > +
> > +#ifndef DT_BINDING_RESET_IMX8M_H
> > +#define DT_BINDING_RESET_IMX8M_H
> > +
> > +#include "imx7-reset.h"
> > +
> > +#define IMX8M_RESET_A53_CORE_POR_RESET0 IMX7_RESET_A7_CORE_POR_RESET0
> > +#define IMX8M_RESET_A53_CORE_POR_RESET1 IMX7_RESET_A7_CORE_POR_RESET1
> > +
> > +#define IMX8M_RESET_A53_CORE_RESET0     IMX7_RESET_A7_CORE_RESET0
> > +#define IMX8M_RESET_A53_CORE_RESET1     IMX7_RESET_A7_CORE_RESET1
> > +
> > +#define IMX8M_RESET_A53_DBG_RESET0   IMX7_RESET_A7_DBG_RESET0
> > +#define IMX8M_RESET_A53_DBG_RESET1   IMX7_RESET_A7_DBG_RESET1
> > +
> > +#define IMX8M_RESET_A53_ETM_RESET0   IMX7_RESET_A7_ETM_RESET0
> > +#define IMX8M_RESET_A53_ETM_RESET1   IMX7_RESET_A7_ETM_RESET1
> > +
> > +#define IMX8M_RESET_A53_SOC_DBG_RESET   IMX7_RESET_A7_SOC_DBG_RESET
> > +#define IMX8M_RESET_A53_L2RESET         IMX7_RESET_A7_L2RESET
> > +#define IMX8M_RESET_SW_M4C_RST          IMX7_RESET_SW_M4C_RST
> > +#define IMX8M_RESET_SW_M4P_RST          IMX7_RESET_SW_M4P_RST
>
> > +#define IMX8M_RESET_EIM_RST             IMX7_RESET_EIM_RST
> > +#define IMX8M_RESET_HSICPHY_PORT_RST    IMX7_RESET_HSICPHY_PORT_RST
>
> These two don't exist according to the reference manual.
>
> > +#define IMX8M_RESET_USBPHY1_POR         IMX7_RESET_USBPHY1_POR
> > +#define IMX8M_RESET_USBPHY1_PORT_RST    IMX7_RESET_USBPHY1_PORT_RST
>
> These two don't seem to exist either. I only see a single OTG1_PHY_RESET
> bit in that register.
>
> > +#define IMX8M_RESET_USBPHY2_POR         IMX7_RESET_USBPHY2_POR
> > +#define IMX8M_RESET_USBPHY2_PORT_RST    IMX7_RESET_USBPHY2_PORT_RST
>
> Same here.
>
> > +#define IMX8M_RESET_MIPI_PHY_MRST       IMX7_RESET_MIPI_PHY_MRST
> > +#define IMX8M_RESET_MIPI_PHY_SRST       IMX7_RESET_MIPI_PHY_SRST
>
> These don't exist either. The MIPIPHY_RCR register instead has 5
> different _RESET_N bits.
>

OK, I'll incorporate all of the feedback above in v2 as well.

Thanks,
Andrey Smirnov
