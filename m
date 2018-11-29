Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBC20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a/dxkmTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FBC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeK3AGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:06:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39240 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeK3AGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:06:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so1813512wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 05:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGkZ2ogt+Z+KYncZ0tSHcjw5kr4Xyy4ocirZNjlVp5A=;
        b=a/dxkmTtoqxjz330PD9IpdU8bc9lYoXqSCfpcre1gnZo30rYGv/Nl+SxCUW+5yZ+RK
         yFOiP6USdammRmsiYZ+/c91BrdBKvDtJNx1rTDPsy2zBnAmtwKi3fXRGjAzglyF3LgXO
         aXUB94ege067kmz7SDpgJ4MVQP5bG9xSMJff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGkZ2ogt+Z+KYncZ0tSHcjw5kr4Xyy4ocirZNjlVp5A=;
        b=gtLPmMQ1tVslN5gevYvrWvJJ5f5iooo3oNZ3/kKvLltE0RkYoSd0URnJQHwjcv4Xu8
         klfAUm25/0Y4xvfxksueVQnXuXzhekQD/dU6JCbqgt0sY1laQ9J+XpZa+KISR0KtCl3+
         pwncE4DehWxrR6580JQKP3XvgKgXnp4/UfCHo4oVQuMM0gzVbpGbxSEe5JcIK8fCJi92
         eLp7bpqc8PHx/VKuieG/u/hn7+BaD/sTR3WFeuyp3ZMyWlWeBBUPeKntY1/+sClVfZq6
         bnQcuECVJ6Lrr1mLiIZMTSDDxhLNQhdBgnbQIXchpPfLOagM4wfYoPLgydxG9wcnSZ3U
         bx3w==
X-Gm-Message-State: AA+aEWYPvqRVRbDQwvKB6h3y7Jz5YSFLur26TLMhRQloe3jEAlt67w19
        DRpKsDcPZuM8HzoN6mPR/MdWY8w38m+MHMdyYOZGe1pa
X-Google-Smtp-Source: AFSGD/XxB6wLCK5ikh7LVg+BBIq1mBO1AXxJes70HjURu4YgUe1xOgckKEpxJBf6o4sbIrY1NBuoG25p366K39hOIPk=
X-Received: by 2002:a5d:4e4a:: with SMTP id r10mr1457092wrt.54.1543496487611;
 Thu, 29 Nov 2018 05:01:27 -0800 (PST)
MIME-Version: 1.0
References: <1542082418-16675-1-git-send-email-srinath.mannam@broadcom.com>
 <1542082418-16675-3-git-send-email-srinath.mannam@broadcom.com> <b626bff7-9228-b53f-b16a-7f6fb1f27100@ti.com>
In-Reply-To: <b626bff7-9228-b53f-b16a-7f6fb1f27100@ti.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 29 Nov 2018 18:31:16 +0530
Message-ID: <CABe79T4r-20DmQoHX5HXFU0O7KXid=JuhKVtA7+yzkrb4vafkA@mail.gmail.com>
Subject: Re: [PATCH 2/3] phy: sr-usb: Add stingray usb phy driver
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Thank you for review.. Please find my answers below in line.


On Thu, Nov 29, 2018 at 3:55 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 13/11/18 9:43 AM, Srinath Mannam wrote:
> > This driver supports all versions of stingray SS and HS
> > USB phys.
> > In version 1 is combo phy contain both SS and HS phys
> > in a common IO space.
> > In version 2 a single HS phy.
> > These phys support both xHCI host driver and
> > BDC Broadcom device controller driver.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > ---
> >  drivers/phy/broadcom/Kconfig          |  11 +
> >  drivers/phy/broadcom/Makefile         |   1 +
> >  drivers/phy/broadcom/phy-bcm-sr-usb.c | 367 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 379 insertions(+)
> >  create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
> >
> > diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> > index 8786a96..c1e4dd5 100644
> > --- a/drivers/phy/broadcom/Kconfig
> > +++ b/drivers/phy/broadcom/Kconfig
> > @@ -10,6 +10,17 @@ config PHY_CYGNUS_PCIE
> >         Enable this to support the Broadcom Cygnus PCIe PHY.
> >         If unsure, say N.
> >
> > +config PHY_BCM_SR_USB
> > +     tristate "Broadcom Stingray USB PHY driver"
> > +     depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
> > +     select GENERIC_PHY
> > +     default ARCH_BCM_IPROC
> > +     help
> > +       Enable this to support the Broadcom Stingray USB PHY
> > +       driver. It supports all versions of Superspeed and
> > +       Highspeed PHYs.
> > +       If unsure, say N.
> > +
> >  config BCM_KONA_USB2_PHY
> >       tristate "Broadcom Kona USB2 PHY Driver"
> >       depends on HAS_IOMEM
> > diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
> > index 0f60184..f453c7d 100644
> > --- a/drivers/phy/broadcom/Makefile
> > +++ b/drivers/phy/broadcom/Makefile
> > @@ -11,3 +11,4 @@ obj-$(CONFIG_PHY_BRCM_USB)          += phy-brcm-usb-dvr.o
> >  phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
> >
> >  obj-$(CONFIG_PHY_BCM_SR_PCIE)                += phy-bcm-sr-pcie.o
> > +obj-$(CONFIG_PHY_BCM_SR_USB)         += phy-bcm-sr-usb.o
> > diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> > new file mode 100644
> > index 0000000..99de49f
> > --- /dev/null
> > +++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> > @@ -0,0 +1,367 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2016-2018 Broadcom
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +
> > +enum bcm_usb_phy_version {
> > +     BCM_USB_PHY_V1,
> > +     BCM_USB_PHY_V2,
> > +};
> > +
> > +enum bcm_usb_phy_reg {
> > +     PLL_NDIV_FRAC,
> > +     PLL_NDIV_INT,
> > +     PLL_CTRL,
> > +     PHY_CTRL,
> > +     PHY_PLL_CTRL,
> > +};
> > +
> > +/* USB PHY registers */
> > +
> > +static const u8 bcm_usb_u3phy_v1[] = {
> > +     [PLL_CTRL]              = 0x18,
> > +     [PHY_CTRL]              = 0x14,
> > +};
> > +
> > +static const u8 bcm_usb_u2phy_v1[] = {
> > +     [PLL_NDIV_FRAC] = 0x04,
> > +     [PLL_NDIV_INT]  = 0x08,
> > +     [PLL_CTRL]      = 0x0c,
> > +     [PHY_CTRL]      = 0x10,
> > +};
> > +
> > +#define HSPLL_NDIV_INT_VAL   0x13
> > +#define HSPLL_NDIV_FRAC_VAL  0x1005
> > +
> > +static const u8 bcm_usb_u2phy_v2[] = {
> > +     [PLL_NDIV_FRAC] = 0x0,
> > +     [PLL_NDIV_INT]  = 0x4,
> > +     [PLL_CTRL]      = 0x8,
> > +     [PHY_CTRL]      = 0xc,
> > +};
> > +
> > +enum pll_ctrl_bits {
> > +     PLL_RESETB,
> > +     SSPLL_SUSPEND_EN,
> > +     PLL_SEQ_START,
> > +     PLL_LOCK,
> > +     PLL_PDIV,
> > +};
> > +
> > +static const u8 u3pll_ctrl[] = {
> > +     [PLL_RESETB]            = 0,
> > +     [SSPLL_SUSPEND_EN]      = 1,
> > +     [PLL_SEQ_START]         = 2,
> > +     [PLL_LOCK]              = 3,
> > +};
> > +
> > +#define HSPLL_PDIV_MASK              0xF
> > +#define HSPLL_PDIV_VAL               0x1
> > +
> > +static const u8 u2pll_ctrl[] = {
> > +     [PLL_PDIV]      = 1,
> > +     [PLL_RESETB]    = 5,
> > +     [PLL_LOCK]      = 6,
> > +};
> > +
> > +enum bcm_usb_phy_ctrl_bits {
> > +     CORERDY,
> > +     AFE_LDO_PWRDWNB,
> > +     AFE_PLL_PWRDWNB,
> > +     AFE_BG_PWRDWNB,
> > +     PHY_ISO,
> > +     PHY_RESETB,
> > +     PHY_PCTL,
> > +};
> > +
> > +#define PHY_PCTL_MASK        0xffff
> > +/*
> > + * 0x0806 of PCTL_VAL has below bits set
> > + * BIT-8 : refclk divider 1
> > + * BIT-3:2: device mode; mode is not effect
> > + * BIT-1: soft reset active low
> > + */
> > +#define HSPHY_PCTL_VAL       0x0806
> > +#define SSPHY_PCTL_VAL       0x0006
> > +
> > +static const u8 u3phy_ctrl[] = {
> > +     [PHY_RESETB]    = 1,
> > +     [PHY_PCTL]      = 2,
> > +};
> > +
> > +static const u8 u2phy_ctrl[] = {
> > +     [CORERDY]               = 0,
> > +     [AFE_LDO_PWRDWNB]       = 1,
> > +     [AFE_PLL_PWRDWNB]       = 2,
> > +     [AFE_BG_PWRDWNB]        = 3,
> > +     [PHY_ISO]               = 4,
> > +     [PHY_RESETB]            = 5,
> > +     [PHY_PCTL]              = 6,
> > +};
> > +
> > +struct bcm_usb_phy_cfg {
> > +     uint32_t type;
> > +     uint32_t ver;
> > +     void __iomem *regs;
> > +     struct phy *phy;
> > +     const u8 *offset;
> > +};
> > +
> > +#define PLL_LOCK_RETRY_COUNT 1000
> > +
> > +enum bcm_usb_phy_type {
> > +     USB_HS_PHY,
> > +     USB_SS_PHY,
> > +};
> > +
> > +static inline void bcm_usb_reg32_clrbits(void __iomem *addr, uint32_t clear)
> > +{
> > +     writel(readl(addr) & ~clear, addr);
> > +}
> > +
> > +static inline void bcm_usb_reg32_setbits(void __iomem *addr, uint32_t set)
> > +{
> > +     writel(readl(addr) | set, addr);
> > +}
> > +
> > +static int bcm_usb_pll_lock_check(void __iomem *addr, u32 bit)
> > +{
> > +     int retry;
> > +     u32 rd_data;
> > +
> > +     retry = PLL_LOCK_RETRY_COUNT;
> > +     do {
> > +             rd_data = readl(addr);
> > +             if (rd_data & bit)
> > +                     return 0;
> > +             udelay(1);
> > +     } while (--retry > 0);
> > +
> > +     pr_err("%s: FAIL\n", __func__);
> > +     return -ETIMEDOUT;
> > +}
> > +
> > +static int bcm_usb_ss_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
> > +{
> > +     int ret = 0;
> > +     void __iomem *regs = phy_cfg->regs;
> > +     const u8 *offset;
> > +     u32 rd_data;
> > +
> > +     offset = phy_cfg->offset;
> > +
> > +     /* Set pctl with mode and soft reset */
> > +     rd_data = readl(regs + offset[PHY_CTRL]);
> > +     rd_data &= ~(PHY_PCTL_MASK << u3phy_ctrl[PHY_PCTL]);
> > +     rd_data |= (SSPHY_PCTL_VAL << u3phy_ctrl[PHY_PCTL]);
> > +     writel(rd_data, regs + offset[PHY_CTRL]);
> > +
> > +     bcm_usb_reg32_clrbits(regs + offset[PLL_CTRL],
> > +                           BIT(u3pll_ctrl[SSPLL_SUSPEND_EN]));
> > +     bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> > +                           BIT(u3pll_ctrl[PLL_SEQ_START]));
> > +     bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> > +                           BIT(u3pll_ctrl[PLL_RESETB]));
> > +
> > +     msleep(30);
> > +
> > +     ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
> > +                                  BIT(u3pll_ctrl[PLL_LOCK]));
> > +
> > +     return ret;
> > +}
> > +
> > +static int bcm_usb_hs_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
> > +{
> > +     int ret = 0;
> > +     void __iomem *regs = phy_cfg->regs;
> > +     const u8 *offset;
> > +     u32 rd_data;
> > +
> > +     offset = phy_cfg->offset;
> > +
> > +     writel(HSPLL_NDIV_INT_VAL, regs + offset[PLL_NDIV_INT]);
> > +     writel(HSPLL_NDIV_FRAC_VAL, regs + offset[PLL_NDIV_FRAC]);
> > +
> > +     rd_data = readl(regs + offset[PLL_CTRL]);
> > +     rd_data &= ~(HSPLL_PDIV_MASK << u2pll_ctrl[PLL_PDIV]);
> > +     rd_data |= (HSPLL_PDIV_VAL << u2pll_ctrl[PLL_PDIV]);
> > +     writel(rd_data, regs + offset[PLL_CTRL]);
> > +
> > +     /* Set Core Ready high */
> > +     bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> > +                           BIT(u2phy_ctrl[CORERDY]));
> > +
> > +     msleep(100);
> > +
> > +     bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> > +                           BIT(u2pll_ctrl[PLL_RESETB]));
> > +     bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> > +                           BIT(u2phy_ctrl[PHY_RESETB]));
> > +
> > +
> > +     rd_data = readl(regs + offset[PHY_CTRL]);
> > +     rd_data &= ~(PHY_PCTL_MASK << u2phy_ctrl[PHY_PCTL]);
> > +     rd_data |= (HSPHY_PCTL_VAL << u2phy_ctrl[PHY_PCTL]);
> > +     writel(rd_data, regs + offset[PHY_CTRL]);
> > +
> > +     ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
> > +                                  BIT(u2pll_ctrl[PLL_LOCK]));
> > +
> > +     return ret;
> > +}
> > +
> > +static int bcm_usb_phy_reset(struct phy *phy)
> > +{
> > +     struct bcm_usb_phy_cfg *phy_cfg = phy_get_drvdata(phy);
> > +     void __iomem *regs = phy_cfg->regs;
> > +     const u8 *offset;
> > +
> > +     offset = phy_cfg->offset;
> > +
> > +     if (phy_cfg->type == USB_HS_PHY) {
> > +             bcm_usb_reg32_clrbits(regs + offset[PHY_CTRL],
> > +                                   BIT(u2phy_ctrl[CORERDY]));
> > +             bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> > +                                   BIT(u2phy_ctrl[CORERDY]));
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int bcm_usb_phy_init(struct phy *phy)
> > +{
> > +     struct bcm_usb_phy_cfg *phy_cfg = phy_get_drvdata(phy);
> > +
> > +     if (phy_cfg->type == USB_SS_PHY)
> > +             bcm_usb_ss_phy_init(phy_cfg);
> > +     if (phy_cfg->type == USB_HS_PHY)
> > +             bcm_usb_hs_phy_init(phy_cfg);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct phy_ops sr_phy_ops = {
> > +     .init           = bcm_usb_phy_init,
> > +     .reset          = bcm_usb_phy_reset,
> > +     .owner          = THIS_MODULE,
> > +};
> > +
> > +static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
> > +                          void __iomem *regs, uint32_t version)
> > +{
> > +     struct bcm_usb_phy_cfg *phy_cfg;
> > +     struct phy_provider *phy_provider;
> > +
> > +     phy_cfg = devm_kzalloc(dev, sizeof(struct bcm_usb_phy_cfg), GFP_KERNEL);
> > +     if (!phy_cfg)
> > +             return -ENOMEM;
> > +
> > +     phy_cfg->regs = regs;
>
> Are there any registers shared by all the PHYs?
No registers shared between phys. All phys have same type of registers
but at different address offset.
In the same way few bits in registers are same but at different
position in registers.
> > +     phy_cfg->ver = version;
> > +
> > +     if (phy_cfg->ver == BCM_USB_PHY_V1) {
> > +             unsigned int id;
> > +
> > +             if (of_property_read_u32(node, "reg", &id)) {
> > +                     dev_err(dev, "missing reg property in node %s\n",
> > +                             node->name);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (id == 0) {
> > +                     phy_cfg->offset = bcm_usb_u2phy_v1;
>
> The reg space can come from the dt itself.
This driver supports two different phys. one is combo phy which has
both USB3 and USB2 phy.
other is single phy it has only USB2 phy.
So that, from DT we passed address of either combo phy address or
single phy address.
In combo phy, USB3 phy and USB2 phy registers are at different offsets
from the base address passed through DT.
> > +                     phy_cfg->type = USB_HS_PHY;
> > +             } else if (id == 1) {
> > +                     phy_cfg->offset = bcm_usb_u3phy_v1;
> > +                     phy_cfg->type = USB_SS_PHY;
> > +             } else {
> > +                     return -ENODEV;
> > +             }
> > +     } else if (phy_cfg->ver == BCM_USB_PHY_V2) {
> > +             phy_cfg->offset = bcm_usb_u2phy_v2;
> > +             phy_cfg->type = USB_HS_PHY;
> > +     }
> > +
> > +     phy_cfg->phy = devm_phy_create(dev, node, &sr_phy_ops);
> > +     if (IS_ERR(phy_cfg->phy))
> > +             return PTR_ERR(phy_cfg->phy);
> > +
> > +     phy_set_drvdata(phy_cfg->phy, phy_cfg);
> > +     phy_provider = devm_of_phy_provider_register(&phy_cfg->phy->dev,
> > +                                                  of_phy_simple_xlate);
> > +     if (IS_ERR(phy_provider)) {
> > +             dev_err(dev, "Failed to register phy provider\n");
> > +             return PTR_ERR(phy_provider);
> > +     }
>
> No need for a separate PHY provider.
Could you please provide more details?
I thought to get phy device in the upper layer we need to register
provider. can we skip this?
In this driver, combo phy provides two usb ports to host controller,
so that I need to add separate phandlers
in host controller DT node and need to create two separate phy
devices. also phy_init and reset handlers need
to call for both phy devices separately.
>
> Thanks
> Kishon

Thank you.
Regards,
Srinath.
