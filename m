Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3973D21735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KhzkxFx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3973D21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHUNMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:12:23 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56015 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeHUNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:12:23 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7L9qk7O006602;
        Tue, 21 Aug 2018 18:52:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7L9qk7O006602
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534845167;
        bh=t/2mVuRpziQrq7idl4FVSocX1wQgASN89rFQSzwEN74=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=KhzkxFx2jgvJD5B2yl09bBByXTBXq9gHBk8r8PAYKkVk2HVIkPVy+8MpEailSrOCC
         zJOsGIVLbBr1na85Um9xI4RV8vMaeH2EA4pLNk0pvW0HoJ/W1EZQ++3zpp1oJcPv3a
         v2smKd30Hpwe0dZDVf1EHt/k1uo9QKGbJxKtL70SKPcxXjlqTs63LeDhNkoRPYPh2v
         3uEoLE9PTtwpUQ7RxtAkxcF2x1cbomhb0WLfq05M1E5G6YdBfZ3sPGrHT+6RcvUCX4
         QkcS4Gf4EDUoX1tW0MVUqZwEeyS81x6jwKHXBez8CDjzOu8FVMDrx0kk5kJGxkXxPt
         HxC9XE+pqPwhw==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id m13-v6so11452376uaq.7;
        Tue, 21 Aug 2018 02:52:47 -0700 (PDT)
X-Gm-Message-State: AOUpUlEBlSxnyRUVDv512zN8yoG08zN4evC/fg/qkYkCAh6HWsYKhxFn
        jV1tB0L7dxF0BmamY249ix1BjOzrzGvIsrdup5M=
X-Google-Smtp-Source: AA+uWPy03PJyuogQ/zry5uh8pEJYl3tkLunw0j0kqKQ+/Haxf75lktxesTQw1MEGaBxgra7sLzPTR45AFZz6+ZmarHA=
X-Received: by 2002:ab0:4ad7:: with SMTP id t23-v6mr31642869uae.35.1534845166061;
 Tue, 21 Aug 2018 02:52:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 02:52:05
 -0700 (PDT)
In-Reply-To: <1534843809-4137-3-git-send-email-yamada.masahiro@socionext.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com> <1534843809-4137-3-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 18:52:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATgpC6GJL6CnMR7JFzQkPF0tP9m74jTJrV8NYJ+aGCxtg@mail.gmail.com>
Message-ID: <CAK7LNATgpC6GJL6CnMR7JFzQkPF0tP9m74jTJrV8NYJ+aGCxtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC LKML just in case)

2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
> Pro4, and sLD8 SoCs.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  MAINTAINERS                  |   1 +
>  drivers/dma/Kconfig          |  11 +
>  drivers/dma/Makefile         |   1 +
>  drivers/dma/uniphier-mdmac.c | 484 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 497 insertions(+)
>  create mode 100644 drivers/dma/uniphier-mdmac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8838bf1..c15a024 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2171,6 +2171,7 @@ F:        arch/arm/mm/cache-uniphier.c
>  F:     arch/arm64/boot/dts/socionext/uniphier*
>  F:     drivers/bus/uniphier-system-bus.c
>  F:     drivers/clk/uniphier/
> +F:     drivers/dmaengine/uniphier-mdmac.c
>  F:     drivers/gpio/gpio-uniphier.c
>  F:     drivers/i2c/busses/i2c-uniphier*
>  F:     drivers/irqchip/irq-uniphier-aidet.c
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index dacf3f4..8b8c7f0 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -576,6 +576,17 @@ config TIMB_DMA
>         help
>           Enable support for the Timberdale FPGA DMA engine.
>
> +config UNIPHIER_MDMAC
> +       tristate "UniPhier MIO DMAC"
> +       depends on ARCH_UNIPHIER || COMPILE_TEST
> +       depends on OF
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         Enable support for the MIO DMAC (Media I/O DMA controller) on the
> +         UniPhier platform.  This DMA controller is used as the external
> +         DMA engine of the SD/eMMC controllers of the LD4, Pro4, sLD8 SoCs.
> +
>  config XGENE_DMA
>         tristate "APM X-Gene DMA support"
>         depends on ARCH_XGENE || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index c91702d..973a170 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
>  obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
>  obj-$(CONFIG_TIMB_DMA) += timb_dma.o
> +obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
>  obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ZX_DMA) += zx_dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
> diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
> new file mode 100644
> index 0000000..d558851
> --- /dev/null
> +++ b/drivers/dma/uniphier-mdmac.c
> @@ -0,0 +1,484 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 Socionext Inc.
> +//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "virt-dma.h"
> +
> +/* registers common for all channels */
> +#define UNIPHIER_MDMAC_CMD             0x000   // issue DMA start/abort
> +#define   UNIPHIER_MDMAC_CMD_ABORT             BIT(31) // 1: abort, 0: start
> +
> +/* per-channel registers */
> +#define UNIPHIER_MDMAC_CH_OFFSET       0x100
> +#define UNIPHIER_MDMAC_CH_STRIDE       0x040
> +
> +#define UNIPHIER_MDMAC_CH_IRQ_STAT     0x010   // current hw status (RO)
> +#define UNIPHIER_MDMAC_CH_IRQ_REQ      0x014   // latched STAT (WOC)
> +#define UNIPHIER_MDMAC_CH_IRQ_EN       0x018   // IRQ enable mask
> +#define UNIPHIER_MDMAC_CH_IRQ_DET      0x01c   // REQ & EN (RO)
> +#define   UNIPHIER_MDMAC_CH_IRQ__ABORT         BIT(13)
> +#define   UNIPHIER_MDMAC_CH_IRQ__DONE          BIT(1)
> +#define UNIPHIER_MDMAC_CH_SRC_MODE     0x020   // mode of source
> +#define UNIPHIER_MDMAC_CH_DEST_MODE    0x024   // mode of destination
> +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_INC     (0 << 4)
> +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_DEC     (1 << 4)
> +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED   (2 << 4)
> +#define UNIPHIER_MDMAC_CH_SRC_ADDR     0x028   // source address
> +#define UNIPHIER_MDMAC_CH_DEST_ADDR    0x02c   // destination address
> +#define UNIPHIER_MDMAC_CH_SIZE         0x030   // transfer bytes
> +
> +struct uniphier_mdmac_desc {
> +       struct virt_dma_desc vd;
> +       struct scatterlist *sgl;
> +       unsigned int sg_len;
> +       unsigned int sg_cur;
> +       enum dma_transfer_direction dir;
> +};
> +
> +struct uniphier_mdmac_chan {
> +       struct virt_dma_chan vc;
> +       struct uniphier_mdmac_device *mdev;
> +       struct uniphier_mdmac_desc *md;
> +       void __iomem *reg_ch_base;
> +       unsigned int chan_id;
> +};
> +
> +struct uniphier_mdmac_device {
> +       struct dma_device ddev;
> +       struct clk *clk;
> +       void __iomem *reg_base;
> +       struct uniphier_mdmac_chan channels[0];
> +};
> +
> +static struct uniphier_mdmac_chan *to_uniphier_mdmac_chan(
> +                                               struct virt_dma_chan *vc)
> +{
> +       return container_of(vc, struct uniphier_mdmac_chan, vc);
> +}
> +
> +static struct uniphier_mdmac_desc *to_uniphier_mdmac_desc(
> +                                               struct virt_dma_desc *vd)
> +{
> +       return container_of(vd, struct uniphier_mdmac_desc, vd);
> +}
> +
> +/* mc->vc.lock must be held by caller */
> +static struct uniphier_mdmac_desc *__uniphier_mdmac_next_desc(
> +                                               struct uniphier_mdmac_chan *mc)
> +{
> +       struct virt_dma_desc *vd;
> +
> +       vd = vchan_next_desc(&mc->vc);
> +       if (!vd) {
> +               mc->md = NULL;
> +               return NULL;
> +       }
> +
> +       list_del(&vd->node);
> +
> +       mc->md = to_uniphier_mdmac_desc(vd);
> +
> +       return mc->md;
> +}
> +
> +/* mc->vc.lock must be held by caller */
> +static void __uniphier_mdmac_handle(struct uniphier_mdmac_chan *mc,
> +                                   struct uniphier_mdmac_desc *md)
> +{
> +       struct uniphier_mdmac_device *mdev = mc->mdev;
> +       struct scatterlist *sg;
> +       u32 irq_flag = UNIPHIER_MDMAC_CH_IRQ__DONE;
> +       u32 src_mode, src_addr, dest_mode, dest_addr, chunk_size;
> +
> +       sg = &md->sgl[md->sg_cur];
> +
> +       if (md->dir == DMA_MEM_TO_DEV) {
> +               src_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_INC;
> +               src_addr = sg_dma_address(sg);
> +               dest_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED;
> +               dest_addr = 0;
> +       } else {
> +               src_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED;
> +               src_addr = 0;
> +               dest_mode = UNIPHIER_MDMAC_CH_MODE__ADDR_INC;
> +               dest_addr = sg_dma_address(sg);
> +       }
> +
> +       chunk_size = sg_dma_len(sg);
> +
> +       writel(src_mode, mc->reg_ch_base + UNIPHIER_MDMAC_CH_SRC_MODE);
> +       writel(dest_mode, mc->reg_ch_base + UNIPHIER_MDMAC_CH_DEST_MODE);
> +       writel(src_addr, mc->reg_ch_base + UNIPHIER_MDMAC_CH_SRC_ADDR);
> +       writel(dest_addr, mc->reg_ch_base + UNIPHIER_MDMAC_CH_DEST_ADDR);
> +       writel(chunk_size, mc->reg_ch_base + UNIPHIER_MDMAC_CH_SIZE);
> +
> +       /* write 1 to clear */
> +       writel(irq_flag, mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_REQ);
> +
> +       writel(irq_flag, mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_EN);
> +
> +       writel(BIT(mc->chan_id), mdev->reg_base + UNIPHIER_MDMAC_CMD);
> +}
> +
> +/* mc->vc.lock must be held by caller */
> +static void __uniphier_mdmac_start(struct uniphier_mdmac_chan *mc)
> +{
> +       struct uniphier_mdmac_desc *md;
> +
> +       md = __uniphier_mdmac_next_desc(mc);
> +       if (md)
> +               __uniphier_mdmac_handle(mc, md);
> +}
> +
> +/* mc->vc.lock must be held by caller */
> +static int __uniphier_mdmac_abort(struct uniphier_mdmac_chan *mc)
> +{
> +       struct uniphier_mdmac_device *mdev = mc->mdev;
> +       u32 irq_flag = UNIPHIER_MDMAC_CH_IRQ__ABORT;
> +       u32 val;
> +
> +       /* write 1 to clear */
> +       writel(irq_flag, mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_REQ);
> +
> +       writel(UNIPHIER_MDMAC_CMD_ABORT | BIT(mc->chan_id),
> +              mdev->reg_base + UNIPHIER_MDMAC_CMD);
> +
> +       /*
> +        * Abort should be accepted soon. We poll the bit here instead of
> +        * waiting for the interrupt.
> +        */
> +       return readl_poll_timeout(mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_REQ,
> +                                 val, val & irq_flag, 0, 20);
> +}
> +
> +/* mc->vc.lock must be held by caller */
> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
> +{
> +       u32 residue = 0;
> +       int i;
> +
> +       for (i = md->sg_cur; i < md->sg_len; i++)
> +               residue += sg_dma_len(&md->sgl[i]);
> +
> +       return residue;
> +}
> +
> +static irqreturn_t uniphier_mdmac_interrupt(int irq, void *dev_id)
> +{
> +       struct uniphier_mdmac_chan *mc = dev_id;
> +       struct uniphier_mdmac_desc *md;
> +       irqreturn_t ret = IRQ_HANDLED;
> +       u32 irq_stat;
> +
> +       spin_lock(&mc->vc.lock);
> +
> +       irq_stat = readl(mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_DET);
> +
> +       /*
> +        * Some channels share a single interrupt line. If the IRQ status is 0,
> +        * this is probably triggered by a different channel.
> +        */
> +       if (!irq_stat) {
> +               ret = IRQ_NONE;
> +               goto out;
> +       }
> +
> +       /* write 1 to clear */
> +       writel(irq_stat, mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_REQ);
> +
> +       /*
> +        * UNIPHIER_MDMAC_CH_IRQ__DONE interrupt is asserted even when the DMA
> +        * is aborted.  To distinguish the normal completion and the abort,
> +        * check mc->md.  If it is NULL, we are aborting.
> +        */
> +       md = mc->md;
> +       if (!md)
> +               goto out;
> +
> +       md->sg_cur++;
> +
> +       if (md->sg_cur >= md->sg_len) {
> +               vchan_cookie_complete(&md->vd);
> +               md = __uniphier_mdmac_next_desc(mc);
> +               if (!md)
> +                       goto out;
> +       }
> +
> +       __uniphier_mdmac_handle(mc, md);
> +
> +out:
> +       spin_unlock(&mc->vc.lock);
> +
> +       return ret;
> +}
> +
> +static struct dma_async_tx_descriptor *uniphier_mdmac_prep_slave_sg(
> +                                       struct dma_chan *chan,
> +                                       struct scatterlist *sgl,
> +                                       unsigned int sg_len,
> +                                       enum dma_transfer_direction direction,
> +                                       unsigned long flags, void *context)
> +{
> +       struct virt_dma_chan *vc = to_virt_chan(chan);
> +       struct uniphier_mdmac_desc *md;
> +
> +       if (!is_slave_direction(direction))
> +               return NULL;
> +
> +       md = kzalloc(sizeof(*md), GFP_KERNEL);
> +       if (!md)
> +               return NULL;
> +
> +       md->sgl = sgl;
> +       md->sg_len = sg_len;
> +       md->dir = direction;
> +
> +       return vchan_tx_prep(vc, &md->vd, flags);
> +}
> +
> +static int uniphier_mdmac_terminate_all(struct dma_chan *chan)
> +{
> +       struct virt_dma_chan *vc = to_virt_chan(chan);
> +       struct uniphier_mdmac_chan *mc = to_uniphier_mdmac_chan(vc);
> +       unsigned long flags;
> +       int ret = 0;
> +       LIST_HEAD(head);
> +
> +       spin_lock_irqsave(&vc->lock, flags);
> +
> +       if (mc->md) {
> +               vchan_terminate_vdesc(&mc->md->vd);
> +               mc->md = NULL;
> +               ret = __uniphier_mdmac_abort(mc);
> +       }
> +       vchan_get_all_descriptors(vc, &head);
> +
> +       spin_unlock_irqrestore(&vc->lock, flags);
> +
> +       vchan_dma_desc_free_list(vc, &head);
> +
> +       return ret;
> +}
> +
> +static void uniphier_mdmac_synchronize(struct dma_chan *chan)
> +{
> +       vchan_synchronize(to_virt_chan(chan));
> +}
> +
> +static enum dma_status uniphier_mdmac_tx_status(struct dma_chan *chan,
> +                                               dma_cookie_t cookie,
> +                                               struct dma_tx_state *txstate)
> +{
> +       struct virt_dma_chan *vc;
> +       struct virt_dma_desc *vd;
> +       struct uniphier_mdmac_chan *mc;
> +       struct uniphier_mdmac_desc *md = NULL;
> +       enum dma_status stat;
> +       unsigned long flags;
> +
> +       stat = dma_cookie_status(chan, cookie, txstate);
> +       if (stat == DMA_COMPLETE)
> +               return stat;
> +
> +       vc = to_virt_chan(chan);
> +
> +       spin_lock_irqsave(&vc->lock, flags);
> +
> +       mc = to_uniphier_mdmac_chan(vc);
> +
> +       if (mc->md && mc->md->vd.tx.cookie == cookie)
> +               md = mc->md;
> +
> +       if (!md) {
> +               vd = vchan_find_desc(vc, cookie);
> +               if (vd)
> +                       md = to_uniphier_mdmac_desc(vd);
> +       }
> +
> +       if (md)
> +               txstate->residue = __uniphier_mdmac_get_residue(md);
> +
> +       spin_unlock_irqrestore(&vc->lock, flags);
> +
> +       return stat;
> +}
> +
> +static void uniphier_mdmac_issue_pending(struct dma_chan *chan)
> +{
> +       struct virt_dma_chan *vc = to_virt_chan(chan);
> +       struct uniphier_mdmac_chan *mc = to_uniphier_mdmac_chan(vc);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&vc->lock, flags);
> +
> +       if (vchan_issue_pending(vc) && !mc->md)
> +               __uniphier_mdmac_start(mc);
> +
> +       spin_unlock_irqrestore(&vc->lock, flags);
> +}
> +
> +static void uniphier_mdmac_desc_free(struct virt_dma_desc *vd)
> +{
> +       kfree(to_uniphier_mdmac_desc(vd));
> +}
> +
> +static int uniphier_mdmac_chan_init(struct platform_device *pdev,
> +                                   struct uniphier_mdmac_device *mdev,
> +                                   int chan_id)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct uniphier_mdmac_chan *mc = &mdev->channels[chan_id];
> +       char *irq_name;
> +       int irq, ret;
> +
> +       irq = platform_get_irq(pdev, chan_id);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
> +                       chan_id);
> +               return irq;
> +       }
> +
> +       irq_name = devm_kasprintf(dev, GFP_KERNEL, "uniphier-mio-dmac-ch%d",
> +                                 chan_id);
> +       if (!irq_name)
> +               return -ENOMEM;
> +
> +       ret = devm_request_irq(dev, irq, uniphier_mdmac_interrupt,
> +                              IRQF_SHARED, irq_name, mc);
> +       if (ret)
> +               return ret;
> +
> +       mc->mdev = mdev;
> +       mc->reg_ch_base = mdev->reg_base + UNIPHIER_MDMAC_CH_OFFSET +
> +                                       UNIPHIER_MDMAC_CH_STRIDE * chan_id;
> +       mc->chan_id = chan_id;
> +       mc->vc.desc_free = uniphier_mdmac_desc_free;
> +       vchan_init(&mc->vc, &mdev->ddev);
> +
> +       return 0;
> +}
> +
> +static int uniphier_mdmac_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct uniphier_mdmac_device *mdev;
> +       struct dma_device *ddev;
> +       struct resource *res;
> +       u32 nr_chans;
> +       int ret, i;
> +
> +       ret = of_property_read_u32(dev->of_node, "dma-channels", &nr_chans);
> +       if (ret) {
> +               dev_err(dev, "failed to read dma-channels property\n");
> +               return ret;
> +       }
> +
> +       ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +       if (ret)
> +               return ret;
> +
> +       mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> +                           GFP_KERNEL);
> +       if (!mdev)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       mdev->reg_base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(mdev->reg_base))
> +               return PTR_ERR(mdev->reg_base);
> +
> +       mdev->clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(mdev->clk)) {
> +               dev_err(dev, "failed to get clock\n");
> +               return PTR_ERR(mdev->clk);
> +       }
> +
> +       ret = clk_prepare_enable(mdev->clk);
> +       if (ret)
> +               return ret;
> +
> +       ddev = &mdev->ddev;
> +       ddev->dev = dev;
> +       dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +       ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> +       ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> +       ddev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> +       ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +       ddev->device_prep_slave_sg = uniphier_mdmac_prep_slave_sg;
> +       ddev->device_terminate_all = uniphier_mdmac_terminate_all;
> +       ddev->device_synchronize = uniphier_mdmac_synchronize;
> +       ddev->device_tx_status = uniphier_mdmac_tx_status;
> +       ddev->device_issue_pending = uniphier_mdmac_issue_pending;
> +       INIT_LIST_HEAD(&ddev->channels);
> +
> +       for (i = 0; i < nr_chans; i++) {
> +               ret = uniphier_mdmac_chan_init(pdev, mdev, i);
> +               if (ret)
> +                       goto disable_clk;
> +       }
> +
> +       ret = dma_async_device_register(ddev);
> +       if (ret)
> +               goto disable_clk;
> +
> +       ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id,
> +                                        ddev);
> +       if (ret)
> +               goto unregister_dmac;
> +
> +       platform_set_drvdata(pdev, mdev);
> +
> +       return 0;
> +
> +unregister_dmac:
> +       dma_async_device_unregister(ddev);
> +disable_clk:
> +       clk_disable_unprepare(mdev->clk);
> +
> +       return ret;
> +}
> +
> +static int uniphier_mdmac_remove(struct platform_device *pdev)
> +{
> +       struct uniphier_mdmac_device *mdev = platform_get_drvdata(pdev);
> +
> +       of_dma_controller_free(pdev->dev.of_node);
> +       dma_async_device_unregister(&mdev->ddev);
> +       clk_disable_unprepare(mdev->clk);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id uniphier_mdmac_match[] = {
> +       { .compatible = "socionext,uniphier-mio-dmac" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_mdmac_match);
> +
> +static struct platform_driver uniphier_mdmac_driver = {
> +       .probe = uniphier_mdmac_probe,
> +       .remove = uniphier_mdmac_remove,
> +       .driver = {
> +               .name = "uniphier-mio-dmac",
> +               .of_match_table = uniphier_mdmac_match,
> +       },
> +};
> +module_platform_driver(uniphier_mdmac_driver);
> +
> +MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
> +MODULE_DESCRIPTION("UniPhier MIO DMAC driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
