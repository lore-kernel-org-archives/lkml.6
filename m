Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D473C218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546460201;
	bh=Rp7ba5nntJTcYahTXtfOxRbM66APthjjVN5uXWneJwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kH3DPxATL2Cjmh9eRi/QetbrRp9bFFzqpZcQr+is3q73ZOu8VdSH68d1RME7Tfb9Z
	 zrZN2NmogKsnheuEV0iyvxa5wCE+RXwbqDvJI+YbjglIH76KaKtZ+vPW38hEQzdS+6
	 psSZ6HV/YHhVyxTDtyWWWpcVqvNMm2uPuXspCTf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfABUQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfABUQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:16:39 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE4C218DE;
        Wed,  2 Jan 2019 20:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546460196;
        bh=Rp7ba5nntJTcYahTXtfOxRbM66APthjjVN5uXWneJwk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sEnBLWvy2VQuDb1RPgRaSr82NH76YLEdRB2xzpA9xNZxUmbHpVD5tZG5Lxh3ufGTk
         2myxhxMJDMzroCwMQMQsPmN8LUQepGJFo1TPI+ARMdDjRCfroU+CUzxDaFqG7cjNwv
         cunSJ3ADlRZ6QWAZxJihRffHeqWWQbIIYKneT9Vk=
Received: by mail-wr1-f47.google.com with SMTP id 96so31704309wrb.2;
        Wed, 02 Jan 2019 12:16:35 -0800 (PST)
X-Gm-Message-State: AJcUukc1Q+ZZQQJ47Uj5MojM72NPXb8Pynxz7IIzBYc04I5lIp34L1x+
        mxybUyhYIh4PZUSKjZQ4/sI9FgwYB9AuYYtKUKI=
X-Google-Smtp-Source: ALg8bN70CWo0WOtzvD2D4J7Vb9hlpXUM8Ra9WbdQ2BNDk/LvsqyfHHL9lebRRoD0oYU7Ily4toOkLrmRr8yiqjD1jqI=
X-Received: by 2002:adf:b243:: with SMTP id y3mr41083420wra.184.1546460194158;
 Wed, 02 Jan 2019 12:16:34 -0800 (PST)
MIME-Version: 1.0
References: <1545916258-18218-1-git-send-email-shun-chih.yu@mediatek.com>
 <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com> <CAGp9Lzpg+BPTZAxzrUnELdOhO8WLkpHaY7BGeooMY1dN+7KA0A@mail.gmail.com>
In-Reply-To: <CAGp9Lzpg+BPTZAxzrUnELdOhO8WLkpHaY7BGeooMY1dN+7KA0A@mail.gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 2 Jan 2019 12:17:18 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrFjUhH6vZn+X5Hy16BtHCoGt+VPBf=iBxRVA0RE7QajQ@mail.gmail.com>
Message-ID: <CAGp9LzrFjUhH6vZn+X5Hy16BtHCoGt+VPBf=iBxRVA0RE7QajQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
To:     shun-chih.yu@mediatek.com
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srv_wsdupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

go on other parts not finished review at the last time

On Sat, Dec 29, 2018 at 3:03 AM Sean Wang <sean.wang@kernel.org> wrote:
>
> The version looks like better than the earlier version, but there are
> still a few nitpicks I post at the inline.
>
> On Thu, Dec 27, 2018 at 5:11 AM <shun-chih.yu@mediatek.com> wrote:
> >
> > From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> >
> > MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated
> > to memory-to-memory transfer through queue based descriptor management.
> >
> > There are only 3 physical channels inside CQDMA, while the driver is
> > extended to support 32 virtual channels for multiple dma users to issue
> > dma requests onto the CQDMA simultaneously.
> >
> > Change-Id: I1e8d116c5ecbbc49190ffc925cb59a0d035d886b
>
> should be more careful drop the change-id every time
>
> > Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> >
> > ---
> >  drivers/dma/mediatek/Kconfig     |   12 +
> >  drivers/dma/mediatek/Makefile    |    1 +
> >  drivers/dma/mediatek/mtk-cqdma.c |  867 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 880 insertions(+)
> >  create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
> >
> > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > index 27bac0b..4a1582d 100644
> > --- a/drivers/dma/mediatek/Kconfig
> > +++ b/drivers/dma/mediatek/Kconfig
> > @@ -11,3 +11,15 @@ config MTK_HSDMA
> >           This controller provides the channels which is dedicated to
> >           memory-to-memory transfer to offload from CPU through ring-
> >           based descriptor management.
> > +
> > +config MTK_CQDMA
> > +       tristate "MediaTek Command-Queue DMA controller support"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       select DMA_ENGINE
> > +       select DMA_VIRTUAL_CHANNELS
> > +       help
> > +         Enable support for Command-Queue DMA controller on MediaTek
> > +         SoCs.
> > +
> > +         This controller provides the channels which is dedicated to
> > +         memory-to-memory transfer to offload from CPU.
> > diff --git a/drivers/dma/mediatek/Makefile b/drivers/dma/mediatek/Makefile
> > index 6e778f8..41bb381 100644
> > --- a/drivers/dma/mediatek/Makefile
> > +++ b/drivers/dma/mediatek/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
> > +obj-$(CONFIG_MTK_CQDMA) += mtk-cqdma.o
> > diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
> > new file mode 100644
> > index 0000000..304eb0a
> > --- /dev/null
> > +++ b/drivers/dma/mediatek/mtk-cqdma.c
> > @@ -0,0 +1,867 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2018-2019 MediaTek Inc.
> > +
> > +/*
> > + * Driver for MediaTek Command-Queue DMA Controller
> > + *
> > + * Author: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> > + *
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/refcount.h>
> > +#include <linux/slab.h>
> > +
> > +#include "../virt-dma.h"
> > +
> > +#define MTK_CQDMA_USEC_POLL            10
> > +#define MTK_CQDMA_TIMEOUT_POLL         1000
> > +#define MTK_CQDMA_DMA_BUSWIDTHS                BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)
> > +#define MTK_CQDMA_ALIGN_SIZE           1
> > +
> > +/* The default number of virtual channel */
> > +#define MTK_CQDMA_NR_VCHANS            32
> > +
> > +/* The default number of physical channel */
> > +#define MTK_CQDMA_NR_PCHANS            3
> > +
> > +/* Registers for underlying dma manipulation */
> > +#define MTK_CQDMA_INT_FLAG             0x0
> > +#define MTK_CQDMA_INT_EN               0x4
> > +#define MTK_CQDMA_EN                   0x8
> > +#define MTK_CQDMA_RESET                        0xc
> > +#define MTK_CQDMA_FLUSH                        0x14
> > +#define MTK_CQDMA_SRC                  0x1c
> > +#define MTK_CQDMA_DST                  0x20
> > +#define MTK_CQDMA_LEN1                 0x24
> > +#define MTK_CQDMA_LEN2                 0x28
>
> drop unused macro and check if it happens at other places
>
> > +#define MTK_CQDMA_SRC2                 0x60
> > +#define MTK_CQDMA_DST2                 0x64
> > +
> > +/* Registers setting */
> > +#define MTK_CQDMA_EN_BIT               BIT(0)
> > +#define MTK_CQDMA_INT_FLAG_BIT         BIT(0)
> > +#define MTK_CQDMA_INT_EN_BIT           BIT(0)
> > +#define MTK_CQDMA_FLUSH_BIT            BIT(0)
> > +
> > +#define MTK_CQDMA_WARM_RST_BIT         BIT(0)
> > +#define MTK_CQDMA_HARD_RST_BIT         BIT(1)
> > +
> > +#define MTK_CQDMA_MAX_LEN              GENMASK(27, 0)
> > +#define MTK_CQDMA_ADDR_LIMIT           GENMASK(31, 0)
> > +#define MTK_CQDMA_ADDR2_SHFIT          (32)
> > +
> > +/**
> > + * struct mtk_cqdma_vdesc - The struct holding info describing virtual
> > + *                         descriptor (CVD)
> > + * @vd:                    An instance for struct virt_dma_desc
> > + * @len:                   The total data size device wants to move
> > + * @dest:                  The destination address device wants to move to
> > + * @src:                   The source address device wants to move from
> > + * @ch:                    The pointer to the corresponding dma channel
> > + * @node:                  To build linked-list for PC queue
> > + */
> > +struct mtk_cqdma_vdesc {
> > +       struct virt_dma_desc vd;
> > +       size_t len;
> > +       dma_addr_t dest;
> > +       dma_addr_t src;
> > +       struct dma_chan *ch;
> > +
> > +       /* protected by pc.lock */
> > +       struct list_head node;
> > +};
> > +
> > +/**
> > + * struct mtk_cqdma_pchan - The struct holding info describing physical
> > + *                         channel (PC)
> > + * @queue:                 Queue for the CVDs issued to this PC
> > + * @base:                  The mapped register I/O base of this PC
> > + * @irq:                   The IRQ that this PC are using
> > + * @refcnt:                Track how many VCs are using this PC
> > + * @lock:                 Lock protect agaisting multiple VCs access PC
> > + */
> > +struct mtk_cqdma_pchan {
> > +       struct list_head queue;
> > +       void __iomem *base;
> > +       u32 irq;
> > +       refcount_t refcnt;
> > +
> > +       /* lock to protect PC */
> > +       spinlock_t lock;
> > +};
> > +
> > +/**
> > + * struct mtk_cqdma_vchan - The struct holding info describing virtual
> > + *                         channel (VC)
> > + * @vc:                    An instance for struct virt_dma_chan
> > + * @pc:                    The pointer to the underlying PC
> > + * @issue_completion:     The wait for all issued descriptors completited
> > + * @issue_synchronize:    Bool indicating channel synchronization starts
> > + */
> > +struct mtk_cqdma_vchan {
> > +       struct virt_dma_chan vc;
> > +       struct mtk_cqdma_pchan *pc;
> > +       struct completion issue_completion;
> > +       bool issue_synchronize;
> > +       /* protected by vc.lock */
>
> the line should be dropped
>
> > +};
> > +
> > +/**
> > + * struct mtk_cqdma_device - The struct holding info describing CQDMA
> > + *                          device
> > + * @ddev:                   An instance for struct dma_device
> > + * @clk:                    The clock that device internal is using
> > + * @dma_requests:           The number of VCs the device supports to
> > + * @dma_channels:           The number of PCs the device supports to
> > + * @vc:                     The pointer to all available VCs
> > + * @pc:                     The pointer to all the underlying PCs
> > + */
> > +struct mtk_cqdma_device {
> > +       struct dma_device ddev;
> > +       struct clk *clk;
> > +
> > +       u32 dma_requests;
> > +       u32 dma_channels;
> > +       struct mtk_cqdma_vchan *vc;
> > +       struct mtk_cqdma_pchan **pc;
> > +};
> > +
> > +static struct mtk_cqdma_device *to_cqdma_dev(struct dma_chan *chan)
> > +{
> > +       return container_of(chan->device, struct mtk_cqdma_device, ddev);
> > +}
> > +
> > +static struct mtk_cqdma_vchan *to_cqdma_vchan(struct dma_chan *chan)
> > +{
> > +       return container_of(chan, struct mtk_cqdma_vchan, vc.chan);
> > +}
> > +
> > +static struct mtk_cqdma_vdesc *to_cqdma_vdesc(struct virt_dma_desc *vd)
> > +{
> > +       return container_of(vd, struct mtk_cqdma_vdesc, vd);
> > +}
> > +
> > +static struct device *cqdma2dev(struct mtk_cqdma_device *cqdma)
> > +{
> > +       return cqdma->ddev.dev;
> > +}
> > +
> > +static u32 mtk_dma_read(struct mtk_cqdma_pchan *pc, u32 reg)
> > +{
> > +       return readl(pc->base + reg);
> > +}
> > +
> > +static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> > +{
> > +       writel_relaxed(val, pc->base + reg);
>
> what is the reason register write using relaxed version not consistent
> with register read?
>
> > +}
> > +
> > +static void mtk_dma_rmw(struct mtk_cqdma_pchan *pc, u32 reg,
> > +                       u32 mask, u32 set)
> > +{
> > +       u32 val;
> > +
> > +       val = mtk_dma_read(pc, reg);
> > +       val &= ~mask;
> > +       val |= set;
> > +       mtk_dma_write(pc, reg, val);
> > +}
> > +
> > +static void mtk_dma_set(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> > +{
> > +       mtk_dma_rmw(pc, reg, 0, val);
> > +}
> > +
> > +static void mtk_dma_clr(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> > +{
> > +       mtk_dma_rmw(pc, reg, val, 0);
> > +}
> > +
> > +static void mtk_cqdma_vdesc_free(struct virt_dma_desc *vd)
> > +{
> > +       kfree(to_cqdma_vdesc(vd));
> > +}
> > +
> > +static int mtk_cqdma_poll_engine_done(struct mtk_cqdma_pchan *pc, bool atomic)
> > +{
> > +       u32 status = 0;
> > +
> > +       if (!atomic)
> > +               return readl_poll_timeout(pc->base + MTK_CQDMA_EN,
> > +                                         status,
> > +                                         !(status & MTK_CQDMA_EN_BIT),
> > +                                         MTK_CQDMA_USEC_POLL,
> > +                                         MTK_CQDMA_TIMEOUT_POLL);
> > +
> > +       return readl_poll_timeout_atomic(pc->base + MTK_CQDMA_EN,
> > +                                        status,
> > +                                        !(status & MTK_CQDMA_EN_BIT),
> > +                                        MTK_CQDMA_USEC_POLL,
> > +                                        MTK_CQDMA_TIMEOUT_POLL);
>
> it seems we can use macro in_task to check the current context and
> drop the variable atomic passing.
>
> > +}
> > +
> > +static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
> > +{
> > +       mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
> > +       mtk_dma_clr(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
> > +
> > +       return mtk_cqdma_poll_engine_done(pc, false);
> > +}
> > +
> > +static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
> > +                           struct mtk_cqdma_vdesc *cvd)
> > +{
> > +       /* wait for the previous transaction done */
> > +       if (mtk_cqdma_poll_engine_done(pc, true) < 0)
> > +               dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)),
> > +                       "cqdma wait transaction timeout\n");
>
> I thought the poll can be dropped since the irq fire and then next
> transaction starts guarantees the previous transaction was already
> finished.
>
> > +
> > +       /* warm reset the dma engine for the new transaction */
> > +       mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_WARM_RST_BIT);
> > +       if (mtk_cqdma_poll_engine_done(pc, true) < 0)
> > +               dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)),
> > +                       "cqdma warm reset timeout\n");
> > +
>
> In general, warm reset is only present at the beginning setup or at a
> necessary time such as hardware fault happens, and not blindly done
> for each descriptor. Otherwise, it will hide some errors from hardware
> and can't be found in time and fixed on the next version.
>
> > +       /* setup the source */
> > +       mtk_dma_set(pc, MTK_CQDMA_SRC, cvd->src & MTK_CQDMA_ADDR_LIMIT);
> > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +       mtk_dma_set(pc, MTK_CQDMA_SRC2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
> > +#else
> > +       mtk_dma_set(pc, MTK_CQDMA_SRC2, 0);
> > +#endif
> > +
> > +       /* setup the destination */
> > +       mtk_dma_set(pc, MTK_CQDMA_DST, cvd->dest & MTK_CQDMA_ADDR_LIMIT);
> > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +       mtk_dma_set(pc, MTK_CQDMA_DST2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
> > +#else
> > +       mtk_dma_set(pc, MTK_CQDMA_SRC2, 0);
> > +#endif
> > +
> > +       /* setup the length */
> > +       mtk_dma_set(pc, MTK_CQDMA_LEN1,
> > +                   (cvd->len < MTK_CQDMA_MAX_LEN) ?
> > +                   cvd->len : MTK_CQDMA_MAX_LEN);
>
> it can be close to 80 chars wrap as much as possible
>
> > +
> > +       /* start dma engine */
> > +       mtk_dma_set(pc, MTK_CQDMA_EN, MTK_CQDMA_EN_BIT);
> > +}
> > +
> > +static void mtk_cqdma_issue_vchan_pending(struct mtk_cqdma_vchan *cvc)
> > +{
> > +       struct virt_dma_desc *vd, *vd2;
> > +       struct mtk_cqdma_pchan *pc = cvc->pc;
> > +       struct mtk_cqdma_vdesc *cvd;
> > +       bool trigger_engine = false;
> > +
> > +       lockdep_assert_held(&cvc->vc.lock);
> > +       lockdep_assert_held(&pc->lock);
> > +
> > +       list_for_each_entry_safe(vd, vd2, &cvc->vc.desc_issued, node) {
> > +               /* need to trigger dma engine if PC's queue is empty */
> > +               if (list_empty(&pc->queue))
> > +                       trigger_engine = true;
> > +
> > +               cvd = to_cqdma_vdesc(vd);
> > +
> > +               /* add VD into PC's queue */
> > +               list_add_tail(&cvd->node, &pc->queue);
> > +
> > +               /* start the dma engine */
> > +               if (trigger_engine)
> > +                       mtk_cqdma_start(pc, cvd);
> > +
> > +               /* remove VD from list desc_issued */
> > +               list_del(&vd->node);
>
> it is unnecessary to use an additional pc->queue because the hardware
> only can handle most up to one descriptor at a time.
>
> Instead, it would make more sense to only use a pointer
> pc->active_vdesc pointing to the descriptor at the head of list
> desc_issued indicates the descriptor the hardware is processing, then
> delete the head, then still leave other pending descriptors in the
> list desc_issued until the irq fire and then determine if go on the
> current uncompleted or load the next descriptor from the list
> desc_issued.
>
> > +       }
> > +}
> > +
> > +/*
> > + * return true if this VC is active,
> > + * meaning that there are VDs under processing by the PC
> > + */
> > +static bool mtk_cqdma_is_vchan_active(struct mtk_cqdma_vchan *cvc)
> > +{
> > +       struct mtk_cqdma_vdesc *cvd;
> > +
> > +       list_for_each_entry(cvd, &cvc->pc->queue, node)
> > +               if (cvc == to_cqdma_vchan(cvd->ch))
> > +                       return true;
>
> Similar to the above, it would be simple if we can add a variable in
> pc called pc->active_vchan and just return pc->active_vchan == cvc
> instead of a loop searching.
>
> pc->active_vchan can be determined at mtk_cqdma_issue_vchan_pending
>
> > +
> > +       return false;
> > +}
> > +
> > +/*
> > + * return the pointer of the CVD that is just consumed by the PC
> > + */
> > +static void mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
> > +{
> > +       struct mtk_cqdma_vchan *cvc;
> > +       struct mtk_cqdma_vdesc *cvd;
> > +       size_t tlen;
> > +
> > +       /* consume a CVD from PC's queue */
> > +       cvd = list_first_entry_or_null(&pc->queue,
> > +                                      struct mtk_cqdma_vdesc, node);
> > +       if (unlikely(!cvd))
> > +               return;
> > +
> > +       cvc = to_cqdma_vchan(cvd->ch);
> > +
> > +       tlen = (cvd->len < MTK_CQDMA_MAX_LEN) ? cvd->len : MTK_CQDMA_MAX_LEN;
> > +       cvd->len -= tlen;
> > +       cvd->src += tlen;
> > +       cvd->dest += tlen;
> > +
> > +       /* check whether the CVD completed */
> > +       if (!cvd->len) {
> > +               /* delete CVD from PC's queue */
> > +               list_del(&cvd->node);
> > +
> > +               spin_lock(&cvc->vc.lock);
> > +
> > +               /* add the VD into list desc_completed */
> > +               vchan_cookie_complete(&cvd->vd);
> > +
> > +               /* setup completion if this VC is under synchronization */
> > +               if (cvc->issue_synchronize && !mtk_cqdma_is_vchan_active(cvc)) {
> > +                       complete(&cvc->issue_completion);
> > +                       cvc->issue_synchronize = false;
> > +               }
> > +
> > +               spin_unlock(&cvc->vc.lock);
> > +       }
> > +

Below code snippet that can call mtk_cqdma_issue_vchan_pending to
share same code involved from the user context.

If you really want to schedule virtual channels on the same physical
channel on the first-issued and first-served basis, we can use
pc->sched_vdesc (I would like the naming instead of pc->queue for
being a little straightforward read the code) for the purpose and put
the issued descriptors at the tail of pc->sched_vdesc at
mtk_cqdma_issue_pending at a time by
list_splice_tail_init(&vc->desc_issued, &pc->sched_vdesc) by the
issuing order of each virtual channel. Finally, pc->active_vdesc
requires being got from the head of pc->sched_vdesc in
mtk_cqdma_issue_vchan_pending.

The extra pc->sched_vdesc and pc->active_vdesc can help split the
channel schedule and hardware real work into a separate logic that
would allow people to know the scheduling policy and what setup the
hardware really must do.

> > +       /* iterate on the next CVD if the current CVD completed */
> > +       if (!cvd->len)
> > +               cvd = list_first_entry_or_null(&pc->queue,
> > +                                              struct mtk_cqdma_vdesc, node);
> > +
> > +       /* start the next transaction */
> > +       if (cvd)
> > +               mtk_cqdma_start(pc, cvd);
> > +}
> > +
> > +static irqreturn_t mtk_cqdma_irq(int irq, void *devid)
> > +{
> > +       struct mtk_cqdma_device *cqdma = devid;
> > +       irqreturn_t ret = IRQ_NONE;
> > +       u32 i;
> > +
> > +       /* clear interrupt flags for each PC */
> > +       for (i = 0; i < cqdma->dma_channels; ++i) {
> > +               spin_lock(&cqdma->pc[i]->lock);
> > +               if (mtk_dma_read(cqdma->pc[i],
> > +                                MTK_CQDMA_INT_FLAG) & MTK_CQDMA_INT_FLAG_BIT) {
> > +                       /* clear interrupt */
> > +                       mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_FLAG,
> > +                                   MTK_CQDMA_INT_FLAG_BIT);
> > +
> > +                       mtk_cqdma_consume_work_queue(cqdma->pc[i]);
> > +
> > +                       ret = IRQ_HANDLED;
> > +               }
> > +               spin_unlock(&cqdma->pc[i]->lock);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
> > +                                                       dma_cookie_t cookie)
> > +{
> > +       struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +       struct virt_dma_desc *vd;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&cvc->pc->lock, flags);
> > +       list_for_each_entry(vd, &cvc->pc->queue, node)
> > +               if (vd->tx.cookie == cookie) {
> > +                       spin_unlock_irqrestore(&cvc->pc->lock, flags);
> > +                       return vd;
> > +               }
> > +       spin_unlock_irqrestore(&cvc->pc->lock, flags);
> > +
> > +       list_for_each_entry(vd, &cvc->vc.desc_issued, node)
> > +               if (vd->tx.cookie == cookie)
> > +                       return vd;
> > +

sure, we should look for cvc->active_vdesc, cvc->pc->sched_vdesc and
cvc->vc.desc_issued that all should be protected by a proper lock.

> > +       return NULL;
> > +}
> > +
> > +static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
> > +                                          dma_cookie_t cookie,
> > +                                          struct dma_tx_state *txstate)
> > +{
> > +       struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +       struct mtk_cqdma_vdesc *cvd;
> > +       struct virt_dma_desc *vd;
> > +       enum dma_status ret;
> > +       unsigned long flags;
> > +       size_t bytes = 0;
> > +
> > +       ret = dma_cookie_status(c, cookie, txstate);
> > +       if (ret == DMA_COMPLETE || !txstate)
> > +               return ret;
> > +
> > +       spin_lock_irqsave(&cvc->vc.lock, flags);
> > +       vd = mtk_cqdma_find_active_desc(c, cookie);
> > +       spin_unlock_irqrestore(&cvc->vc.lock, flags);
> > +
> > +       if (vd) {
> > +               cvd = to_cqdma_vdesc(vd);
> > +               bytes = cvd->len;
>
> we can consider register MTK_CQDMA_LEN1 to know what left data the
> hardware not finished on the fly.
>
> > +       }
> > +
> > +       dma_set_residue(txstate, bytes);
> > +
> > +       return ret;
> > +}
> > +
> > +static void mtk_cqdma_issue_pending(struct dma_chan *c)
> > +{
> > +       struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +       unsigned long pc_flags;
> > +       unsigned long vc_flags;
> > +
> > +       /* acquire PC's lock before VS's lock for lock dependency in ISR */
> > +       spin_lock_irqsave(&cvc->pc->lock, pc_flags);
> > +       spin_lock_irqsave(&cvc->vc.lock, vc_flags);
> > +
> > +       if (vchan_issue_pending(&cvc->vc))
> > +               mtk_cqdma_issue_vchan_pending(cvc);

we can queue the waiting list at a time by
list_splice_tail_init(&vc->desc_issued, &pc->sched_vdesc) instead of
one by one and then call mtk_cqdma_issue_vchan_pending to determine
active_vdesc and active_vchan the hardware should be working at in the
current run.

> > +
> > +       spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
> > +       spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
> > +}
> > +
> > +static struct dma_async_tx_descriptor *
> > +mtk_cqdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
> > +                         dma_addr_t src, size_t len, unsigned long flags)
> > +{
> > +       struct mtk_cqdma_vdesc *cvd;
> > +
> > +       cvd = kzalloc(sizeof(*cvd), GFP_NOWAIT);
> > +       if (!cvd)
> > +               return NULL;
> > +
> > +       /* setup dma channel */
> > +       cvd->ch = c;
> > +
> > +       /* setup sourece, destination, and length */
> > +       cvd->len = len;
> > +       cvd->src = src;
> > +       cvd->dest = dest;
> > +
> > +       return vchan_tx_prep(to_virt_chan(c), &cvd->vd, flags);
> > +}
> > +
> > +static void mtk_cqdma_free_inactive_desc(struct dma_chan *c)
> > +{
> > +       struct virt_dma_chan *vc = to_virt_chan(c);
> > +       unsigned long flags;
> > +       LIST_HEAD(head);
> > +
> > +       /*
> > +        * set desc_allocated, desc_submitted,
> > +        * and desc_issued as the candicates to be freed
> > +        */
> > +       spin_lock_irqsave(&vc->lock, flags);
> > +       list_splice_tail_init(&vc->desc_allocated, &head);
> > +       list_splice_tail_init(&vc->desc_submitted, &head);
> > +       list_splice_tail_init(&vc->desc_issued, &head);
> > +       spin_unlock_irqrestore(&vc->lock, flags);
> > +

sched_vdesc also should be free up here by
list_splice_tail_init(&pc->sched_vdesc, &head); with a proper lock

> > +       /* free descriptor lists */
> > +       vchan_dma_desc_free_list(vc, &head);
> > +}
> > +
> > +static void mtk_cqdma_free_active_desc(struct dma_chan *c)
> > +{
> > +       struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +       bool sync_needed = false;
> > +       unsigned long pc_flags;
> > +       unsigned long vc_flags;
> > +
> > +       /* acquire PC's lock first due to lock dependency in dma ISR */
> > +       spin_lock_irqsave(&cvc->pc->lock, pc_flags);
> > +       spin_lock_irqsave(&cvc->vc.lock, vc_flags);
> > +
> > +       /* synchronization is required if this VC is active */
> > +       if (mtk_cqdma_is_vchan_active(cvc)) {
> > +               cvc->issue_synchronize = true;
> > +               sync_needed = true;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
> > +       spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
> > +
> > +       /* waiting for the completion of this VC */
> > +       if (sync_needed)
> > +               wait_for_completion(&cvc->issue_completion);
> > +
> > +       /* free all descriptors in list desc_completed */
> > +       vchan_synchronize(&cvc->vc);
> > +
> > +       WARN_ONCE(!list_empty(&cvc->vc.desc_completed),
> > +                 "Desc pending still in list desc_completed\n");
> > +}
> > +
> > +static int mtk_cqdma_terminate_all(struct dma_chan *c)
> > +{
> > +       /* free descriptors not processed yet by hardware */
> > +       mtk_cqdma_free_inactive_desc(c);
> > +
> > +       /* free descriptors being processed by hardware */
> > +       mtk_cqdma_free_active_desc(c);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mtk_cqdma_alloc_chan_resources(struct dma_chan *c)
> > +{
> > +       struct mtk_cqdma_device *cqdma = to_cqdma_dev(c);
> > +       struct mtk_cqdma_vchan *vc = to_cqdma_vchan(c);
> > +       struct mtk_cqdma_pchan *pc = NULL;
> > +       u32 i, min_refcnt = U32_MAX, refcnt;
> > +       unsigned long flags;
> > +
> > +       /* allocate PC with the minimum refcount */
> > +       for (i = 0; i < cqdma->dma_channels; ++i) {
> > +               refcnt = refcount_read(&cqdma->pc[i]->refcnt);
> > +               if (refcnt < min_refcnt) {
> > +                       pc = cqdma->pc[i];
> > +                       min_refcnt = refcnt;
> > +               }
> > +       }
> > +
> > +       if (!pc)
> > +               return -ENOSPC;
> > +
> > +       spin_lock_irqsave(&pc->lock, flags);
> > +
> > +       if (!refcount_read(&pc->refcnt)) {
> > +               /* allocate PC when the refcount is zero */
> > +               mtk_cqdma_hard_reset(pc);
> > +
> > +               /* enable interrupt for this PC */
> > +               mtk_dma_set(pc, MTK_CQDMA_INT_EN, MTK_CQDMA_INT_EN_BIT);
> > +
> > +               /*
> > +                * refcount_inc would complain increment on 0; use-after-free.
> > +                * Thus, we need to explicitly set it as 1 initially.
> > +                */
> > +               refcount_set(&pc->refcnt, 1);
> > +       } else {
> > +               refcount_inc(&pc->refcnt);
> > +       }
> > +
> > +       spin_unlock_irqrestore(&pc->lock, flags);
> > +
> > +       vc->pc = pc;
> > +
> > +       return 0;
> > +}
> > +
> > +static void mtk_cqdma_free_chan_resources(struct dma_chan *c)
> > +{
> > +       struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > +       unsigned long flags;
> > +
> > +       /* free all descriptors in all lists on the VC */
> > +       mtk_cqdma_terminate_all(c);
> > +
> > +       spin_lock_irqsave(&cvc->pc->lock, flags);
> > +
> > +       /* PC is not freed until there is no VC mapped to it */
> > +       if (refcount_dec_and_test(&cvc->pc->refcnt)) {
> > +               /* start the flush operation and stop the engine */
> > +               mtk_dma_set(cvc->pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
> > +
> > +               /* wait for the completion of flush operation */
> > +               if (mtk_cqdma_poll_engine_done(cvc->pc, false) < 0)
> > +                       dev_err(cqdma2dev(to_cqdma_dev(c)),
> > +                               "cqdma flush timeout\n");
> > +
> > +               /* clear the flush bit and interrupt flag */
> > +               mtk_dma_clr(cvc->pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
> > +               mtk_dma_clr(cvc->pc, MTK_CQDMA_INT_FLAG,
> > +                           MTK_CQDMA_INT_FLAG_BIT);
> > +
> > +               /* disable interrupt for this PC */
> > +               mtk_dma_clr(cvc->pc, MTK_CQDMA_INT_EN, MTK_CQDMA_INT_EN_BIT);
> > +       }
> > +
> > +       spin_unlock_irqrestore(&cvc->pc->lock, flags);
> > +}
> > +
> > +static int mtk_cqdma_hw_init(struct mtk_cqdma_device *cqdma)
> > +{
> > +       unsigned long flags;
> > +       int err;
> > +       u32 i;
> > +
> > +       pm_runtime_enable(cqdma2dev(cqdma));
> > +       pm_runtime_get_sync(cqdma2dev(cqdma));
> > +
> > +       err = clk_prepare_enable(cqdma->clk);
> > +
> > +       if (err) {
> > +               pm_runtime_put_sync(cqdma2dev(cqdma));
> > +               pm_runtime_disable(cqdma2dev(cqdma));

use goto clk_err; something like to have an error path.

> > +               return err;
> > +       }
> > +
> > +       /* reset all PCs */
> > +       for (i = 0; i < cqdma->dma_channels; ++i) {
> > +               spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
> > +               if (mtk_cqdma_hard_reset(cqdma->pc[i]) < 0) {
> > +                       dev_err(cqdma2dev(cqdma), "cqdma hard reset timeout\n");
> > +                       spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
> > +
> > +                       clk_disable_unprepare(cqdma->clk);
> > +                       pm_runtime_put_sync(cqdma2dev(cqdma));
> > +                       pm_runtime_disable(cqdma2dev(cqdma));
> > +                       return -EINVAL;

use goto reset_err; something like to have an error path.

> > +               }
> > +               spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void mtk_cqdma_hw_deinit(struct mtk_cqdma_device *cqdma)
> > +{
> > +       unsigned long flags;
> > +       u32 i;
> > +
> > +       /* reset all PCs */
> > +       for (i = 0; i < cqdma->dma_channels; ++i) {
> > +               spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
> > +               if (mtk_cqdma_hard_reset(cqdma->pc[i]) < 0)
> > +                       dev_err(cqdma2dev(cqdma), "cqdma hard reset timeout\n");
> > +               spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
> > +       }
> > +
> > +       clk_disable_unprepare(cqdma->clk);
> > +
> > +       pm_runtime_put_sync(cqdma2dev(cqdma));
> > +       pm_runtime_disable(cqdma2dev(cqdma));
> > +}
> > +
> > +static const struct of_device_id mtk_cqdma_match[] = {
> > +       { .compatible = "mediatek,mt6765-cqdma" },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
> > +
> > +static int mtk_cqdma_probe(struct platform_device *pdev)
> > +{
> > +       struct mtk_cqdma_device *cqdma;
> > +       struct mtk_cqdma_vchan *vc;
> > +       struct dma_device *dd;
> > +       struct resource *res;
> > +       int err;
> > +       u32 i;
> > +
> > +       cqdma = devm_kzalloc(&pdev->dev, sizeof(*cqdma), GFP_KERNEL);
> > +       if (!cqdma)
> > +               return -ENOMEM;
> > +
> > +       dd = &cqdma->ddev;
> > +
> > +       cqdma->clk = devm_clk_get(&pdev->dev, "cqdma");
> > +       if (IS_ERR(cqdma->clk)) {
> > +               dev_err(&pdev->dev, "No clock for %s\n",
> > +                       dev_name(&pdev->dev));
> > +               return PTR_ERR(cqdma->clk);
> > +       }
> > +
> > +       dma_cap_set(DMA_MEMCPY, dd->cap_mask);
> > +
> > +       dd->copy_align = MTK_CQDMA_ALIGN_SIZE;
> > +       dd->device_alloc_chan_resources = mtk_cqdma_alloc_chan_resources;
> > +       dd->device_free_chan_resources = mtk_cqdma_free_chan_resources;
> > +       dd->device_tx_status = mtk_cqdma_tx_status;
> > +       dd->device_issue_pending = mtk_cqdma_issue_pending;
> > +       dd->device_prep_dma_memcpy = mtk_cqdma_prep_dma_memcpy;
> > +       dd->device_terminate_all = mtk_cqdma_terminate_all;
> > +       dd->src_addr_widths = MTK_CQDMA_DMA_BUSWIDTHS;
> > +       dd->dst_addr_widths = MTK_CQDMA_DMA_BUSWIDTHS;
> > +       dd->directions = BIT(DMA_MEM_TO_MEM);
> > +       dd->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +       dd->dev = &pdev->dev;
> > +       INIT_LIST_HEAD(&dd->channels);
> > +
> > +       if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
> > +                                                     "dma-requests",
> > +                                                     &cqdma->dma_requests)) {
>
> pdev->dev.of_node can be dropped if the driver is of based
>
> > +               dev_dbg(&pdev->dev,
> > +                       "Using %u as missing dma-requests property\n",
> > +                       MTK_CQDMA_NR_VCHANS);
> > +
> > +               cqdma->dma_requests = MTK_CQDMA_NR_VCHANS;
> > +       }
> > +
> > +       if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
> > +                                                     "dma-channels",
> > +                                                     &cqdma->dma_channels)) {
>
> pdev->dev.of_node can be dropped if the driver is of based
>
> > +               dev_dbg(&pdev->dev,
> > +                       "Using %u as missing dma-channels property\n",
> > +                       MTK_CQDMA_NR_PCHANS);
> > +
> > +               cqdma->dma_channels = MTK_CQDMA_NR_PCHANS;
> > +       }
> > +
> > +       cqdma->pc = devm_kcalloc(&pdev->dev, cqdma->dma_channels,
> > +                                sizeof(*cqdma->pc), GFP_KERNEL);
> > +       if (!cqdma->pc)
> > +               return -ENOMEM;
> > +
> > +       /* initialization for PCs */
> > +       for (i = 0; i < cqdma->dma_channels; ++i) {
> > +               cqdma->pc[i] = devm_kcalloc(&pdev->dev, 1,
> > +                                           sizeof(**cqdma->pc), GFP_KERNEL);
> > +               if (!cqdma->pc[i])
> > +                       return -ENOMEM;
> > +
> > +               INIT_LIST_HEAD(&cqdma->pc[i]->queue);
> > +               spin_lock_init(&cqdma->pc[i]->lock);
> > +               refcount_set(&cqdma->pc[i]->refcnt, 0);
> > +
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> > +               if (!res) {
> > +                       dev_err(&pdev->dev, "No mem resource for %s\n",
> > +                               dev_name(&pdev->dev));
> > +                       return -EINVAL;
> > +               }
> > +
> > +               cqdma->pc[i]->base = devm_ioremap_resource(&pdev->dev, res);
> > +               if (IS_ERR(cqdma->pc[i]->base))
> > +                       return PTR_ERR(cqdma->pc[i]->base);
> > +
> > +               /* allocate IRQ resource */
> > +               res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> > +               if (!res) {
> > +                       dev_err(&pdev->dev, "No irq resource for %s\n",
> > +                               dev_name(&pdev->dev));
> > +                       return -EINVAL;
> > +               }
> > +               cqdma->pc[i]->irq = res->start;
> > +
> > +               err = devm_request_irq(&pdev->dev, cqdma->pc[i]->irq,
> > +                                      mtk_cqdma_irq, 0, dev_name(&pdev->dev),
> > +                                      cqdma);
> > +               if (err) {
> > +                       dev_err(&pdev->dev,
> > +                               "request_irq failed with err %d\n", err);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       /* allocate resource for VCs */
> > +       cqdma->vc = devm_kcalloc(&pdev->dev, cqdma->dma_requests,
> > +                                sizeof(*cqdma->vc), GFP_KERNEL);
> > +       if (!cqdma->vc)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < cqdma->dma_requests; i++) {
> > +               vc = &cqdma->vc[i];
> > +               vc->vc.desc_free = mtk_cqdma_vdesc_free;
> > +               vchan_init(&vc->vc, dd);
> > +               init_completion(&vc->issue_completion);
> > +       }
> > +
> > +       err = dma_async_device_register(dd);
> > +       if (err)
> > +               return err;
> > +
> > +       err = of_dma_controller_register(pdev->dev.of_node,
> > +                                        of_dma_xlate_by_chan_id, cqdma);
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "MediaTek CQDMA OF registration failed %d\n", err);
> > +               goto err_unregister;
> > +       }
> > +
> > +       err = mtk_cqdma_hw_init(cqdma);
> > +       if (err) {
> > +               dev_err(&pdev->dev,
> > +                       "MediaTek CQDMA HW initialization failed %d\n", err);
> > +               goto err_unregister;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, cqdma);
> > +
> > +       dev_dbg(&pdev->dev, "MediaTek CQDMA driver registered\n");
> > +
> > +       return 0;
> > +
> > +err_unregister:
> > +       dma_async_device_unregister(dd);
> > +
> > +       return err;
> > +}
> > +
> > +static int mtk_cqdma_remove(struct platform_device *pdev)
> > +{
> > +       struct mtk_cqdma_device *cqdma = platform_get_drvdata(pdev);
> > +       struct mtk_cqdma_vchan *vc;
> > +       unsigned long flags;
> > +       int i;
> > +
> > +       /* kill VC task */
> > +       for (i = 0; i < cqdma->dma_requests; i++) {
> > +               vc = &cqdma->vc[i];
> > +
> > +               list_del(&vc->vc.chan.device_node);
> > +               tasklet_kill(&vc->vc.task);
> > +       }
> > +
> > +       /* disable interrupt */
> > +       for (i = 0; i < cqdma->dma_channels; i++) {
> > +               spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
> > +               mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_EN,
> > +                           MTK_CQDMA_INT_EN_BIT);
> > +               spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
> > +
> > +               /* Waits for any pending IRQ handlers to complete */
> > +               synchronize_irq(cqdma->pc[i]->irq);
> > +       }
> > +
> > +       /* disable hardware */
> > +       mtk_cqdma_hw_deinit(cqdma);
> > +
> > +       dma_async_device_unregister(&cqdma->ddev);
> > +       of_dma_controller_free(pdev->dev.of_node);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver mtk_cqdma_driver = {
> > +       .probe = mtk_cqdma_probe,
> > +       .remove = mtk_cqdma_remove,
> > +       .driver = {
> > +               .name           = KBUILD_MODNAME,
> > +               .of_match_table = mtk_cqdma_match,
> > +       },
> > +};
> > +module_platform_driver(mtk_cqdma_driver);
> > +
> > +MODULE_DESCRIPTION("MediaTek CQDMA Controller Driver");
> > +MODULE_AUTHOR("Shun-Chih Yu <shun-chih.yu@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
