Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A77CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B6E2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMLHjyyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404799AbeLVAbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:31:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33296 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbeLVAbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:31:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so4196121qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 16:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fw6KSKC9utOhtabpKAhBkW73wfRGpPx1HvCrekdUbxM=;
        b=jMLHjyyW48Zolw/C1d2bD6lkbYg8pSaAsFJhCpYx8KYWQHml6iblx6A+WOlcQRpeaH
         zgWNNoylVNs2BNkPSz4WRnzqCamM5/aaGNQ8Pv8Wv9zCV5J7wvI7t1X02S5q+/TTkBPE
         KUrDY2J5UFOxAC35MCHBEARYQisiZtnC3P9XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fw6KSKC9utOhtabpKAhBkW73wfRGpPx1HvCrekdUbxM=;
        b=qixOZHoiandjOsxYfFGht87qoTij+/iC4juZXiJ/HFryHkMfLKB9lS9y78bSMNers8
         yZ4H0BpV/2CHgv/OMdKXqz7aJz7Nu4ZH6jv5Z2Uk+FD294ieOGkKkmN46aq/VRZfNf7F
         MFjmMePPz9X86FmwPJNd1UqQ2Vtru3AOzu01AJ+d7zLll5vr1mnJ6rbh6wj9+8ONdwgs
         hEghD6EOH2xFlsRnxYG5Fc0KxzACQhz/fm5Ct3G0J2M9BRg+0o2xSluauphJ9R+JeLqt
         1niJPDnf32u3Z06fDbdMctw3ub2IpA91WlCNqvgtDtnNAdnsmAh/RWqt6Hw4XytbLVc1
         ek6w==
X-Gm-Message-State: AJcUukdaMEZhRO79ZTUmouQEiaQ4pJHjX0yxDWs0t6Ryc9Vl6x4Bgx8A
        DMbdnKjy/G21mOSiIyqK8C5hri/tTSApw82anqo4Ww==
X-Google-Smtp-Source: ALg8bN5lM6Dsz8j/gCUoawconycXriunMBfghDSBY4CUHC5ymImkL8oTraieVmXLjrrN99xR2WrQyXeE3wlmgMfoxTM=
X-Received: by 2002:a37:5107:: with SMTP id f7mr4481973qkb.124.1545438703724;
 Fri, 21 Dec 2018 16:31:43 -0800 (PST)
MIME-Version: 1.0
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-11-git-send-email-yong.wu@mediatek.com> <CANMq1KBMWM8BhMDJo1paVbToibsZGYVOCWBOua81w7fnTCO-bw@mail.gmail.com>
 <1545379358.29587.51.camel@mhfsdcap03>
In-Reply-To: <1545379358.29587.51.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 22 Dec 2018 08:31:32 +0800
Message-ID: <CANMq1KDz5kja9BLuuDZer1eGPqOhhcAg3oPt85jE=XOuqaExcg@mail.gmail.com>
Subject: Re: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 4:02 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Fri, 2018-12-21 at 12:43 +0800, Nicolas Boichat wrote:
> > On Sat, Dec 8, 2018 at 4:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> > > the ARM Short-descriptor like mt8173, and most of the HW registers
> > > are the same.
> > >
> > > Here list main differences between mt8183 and mt8173/mt2712:
> > > 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> > > 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> > > 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> > > mode".
> > > 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> > > the bit[33:32] in the physical address of the pgtable base, But the
> > > standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> > > we add a mask.
> > > 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> > > 6) the larb-id in smi-common is remapped. M4U should enable
> > > larbid_remapped support.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 31 ++++++++++++++++++++++---------
> > >  drivers/iommu/mtk_iommu.h |  1 +
> > >  drivers/memory/mtk-smi.c  | 19 +++++++++++++++++++
> > >  3 files changed, 42 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 8ab3b69..d91a554 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -36,6 +36,7 @@
> > >  #include "mtk_iommu.h"
> > >
> > >  #define REG_MMU_PT_BASE_ADDR                   0x000
> > > +#define MMU_PT_ADDR_MASK                       GENMASK(31, 7)
> > >
> > >  #define REG_MMU_INVALIDATE                     0x020
> > >  #define F_ALL_INVLD                            0x2
> > > @@ -54,7 +55,7 @@
> > >  #define REG_MMU_CTRL_REG                       0x110
> > >  #define F_MMU_PREFETCH_RT_REPLACE_MOD          BIT(4)
> > >  #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> > > -       ((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> > > +       ((data)->plat_data->m4u_plat == M4U_MT8173 ? 5 : 4)
> >
> > Should the shift value be a member of plat_data instead?
>
> It's also ok.
> This TF_PROTECT_SEL MACRO looks a bit complex. I can use a new patch to
> refactor it.

SGTM.

> >
> > >  /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
> > >  #define F_MMU_TF_PROTECT_SEL(prot, data) \
> > >         (((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> > > @@ -347,7 +348,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
> > >         /* Update the pgtable base address register of the M4U HW */
> > >         if (!data->m4u_dom) {
> > >                 data->m4u_dom = dom;
> > > -               writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> > > +               writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
> > >                        data->base + REG_MMU_PT_BASE_ADDR);
> > >         }
> > >
> > > @@ -510,6 +511,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> > >
> > >  static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > >  {
> > > +       enum mtk_iommu_plat m4u_plat = data->plat_data->m4u_plat;
> > >         u32 regval;
> > >         int ret;
> > >
> > > @@ -520,7 +522,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > >         }
> > >
> > >         regval = F_MMU_TF_PROTECT_SEL(2, data);
> > > -       if (data->plat_data->m4u_plat == M4U_MT8173)
> > > +       if (m4u_plat == M4U_MT8173)
> > >                 regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
> > >         writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
> > >
> > > @@ -541,14 +543,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > >                 F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> > >         writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
> > >
> > > -       if (data->plat_data->m4u_plat == M4U_MT8173)
> > > +       if (m4u_plat == M4U_MT8173)
> > >                 regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
> > >         else
> > >                 regval = lower_32_bits(data->protect_base) |
> > >                          upper_32_bits(data->protect_base);
> > >         writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> > >
> > > -       if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> > > +       if (data->enable_4GB && m4u_plat == M4U_MT2712) {
> > >                 /*
> > >                  * If 4GB mode is enabled, the validate PA range is from
> > >                  * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> > > @@ -558,8 +560,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > >         }
> > >         writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> > >
> > > -       /* It's MISC control register whose default value is ok except mt8173.*/
> > > -       if (data->plat_data->m4u_plat == M4U_MT8173)
> > > +       /*
> > > +        * It's MISC control register whose default value is ok
> > > +        * except mt8173 and mt8183.
> > > +        */
> > > +       if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)
> >
> > Again, should this be a field in plat_data?
>
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while it's
> MMU_MISC_CTRL which contain this STANDARD_AXI_MODE bit and some other
> bits in the other SoCs.
>
> The register name and meaning are not the same. I guess I can not use a
> value like reg_0x48 in plat_data. I'd like to keep the current way. is
> it ok?

What I mean is to add a "reset_axi" (or something) field in plat_data, and do:
if (plat_data->reset_axi)
instead of
 if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)

My main concern is that the test will grow bigger and bigger as we add
support for more SoCs (similarly to your F_MMU_TF_PROTECT_SEL_SHIFT
test above, where you are lucky because only one of the SoC requires a
shift of 5 bits, and the 2 others require 4).

Thanks,

> >
> > >                 writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
> > >
> > >         if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> > > @@ -713,6 +718,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > >  {
> > >         struct mtk_iommu_data *data = dev_get_drvdata(dev);
> > >         struct mtk_iommu_suspend_reg *reg = &data->reg;
> > > +       struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
> > >         void __iomem *base = data->base;
> > >         int ret;
> > >
> > > @@ -728,8 +734,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > >         writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
> > >         writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
> > >         writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> > > -       if (data->m4u_dom)
> > > -               writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
> > > +       if (m4u_dom)
> > > +               writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
> > >                        base + REG_MMU_PT_BASE_ADDR);
> > >         return 0;
> > >  }
> > > @@ -750,9 +756,16 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
> > >         .has_bclk     = true,
> > >  };
> > >
> > > +static const struct mtk_iommu_plat_data mt8183_data = {
> > > +       .m4u_plat            = M4U_MT8183,
> > > +       .larbid_remap_enable = true,
> > > +       .larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},
> > > +};
> > > +
> > >  static const struct of_device_id mtk_iommu_of_ids[] = {
> > >         { .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
> > >         { .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> > > +       { .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> > >         {}
> > >  };
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > > index 3877050..6385dec 100644
> > > --- a/drivers/iommu/mtk_iommu.h
> > > +++ b/drivers/iommu/mtk_iommu.h
> > > @@ -39,6 +39,7 @@ enum mtk_iommu_plat {
> > >         M4U_MT2701,
> > >         M4U_MT2712,
> > >         M4U_MT8173,
> > > +       M4U_MT8183,
> > >  };
> > >
> > >  struct mtk_iommu_plat_data {
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index 3720c77..bced778 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -285,6 +285,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> > >         .larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
> > >  };
> > >
> > > +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> > > +       .has_gals          = true,
> > > +       .config_port       = mtk_smi_larb_config_port_gen2_general,
> > > +       .larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> > > +};
> > > +
> > >  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> > >         {
> > >                 .compatible = "mediatek,mt8173-smi-larb",
> > > @@ -298,6 +304,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> > >                 .compatible = "mediatek,mt2712-smi-larb",
> > >                 .data = &mtk_smi_larb_mt2712
> > >         },
> > > +       {
> > > +               .compatible = "mediatek,mt8183-smi-larb",
> > > +               .data = &mtk_smi_larb_mt8183
> > > +       },
> > >         {}
> > >  };
> > >
> > > @@ -391,6 +401,11 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
> > >         .gen = MTK_SMI_GEN2,
> > >  };
> > >
> > > +static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> > > +       .gen      = MTK_SMI_GEN2,
> > > +       .has_gals = true,
> > > +};
> > > +
> > >  static const struct of_device_id mtk_smi_common_of_ids[] = {
> > >         {
> > >                 .compatible = "mediatek,mt8173-smi-common",
> > > @@ -404,6 +419,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
> > >                 .compatible = "mediatek,mt2712-smi-common",
> > >                 .data = &mtk_smi_common_gen2,
> > >         },
> > > +       {
> > > +               .compatible = "mediatek,mt8183-smi-common",
> > > +               .data = &mtk_smi_common_mt8183,
> > > +       },
> > >         {}
> > >  };
> > >
> > > --
> > > 1.9.1
> > >
>
>
