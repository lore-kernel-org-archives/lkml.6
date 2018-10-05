Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D405C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA482084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eGiPnkRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA482084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeJFCMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:12:19 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52805 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJFCMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:12:19 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w95JBpkk021517;
        Sat, 6 Oct 2018 04:11:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w95JBpkk021517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538766712;
        bh=KSc7TSWOkX9ztUKivBZIfFSpga3HUZCKkLXoxSnZyrs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eGiPnkRCjpIuKqkD6zDKWzg2YRs4xrwAGsVieMkCVcSWDQk6soIZSwk1rFh+KdVpt
         Uz0hjIII6Sy0bqKE8nTb/8GdbU9MszofDZWSl3Knj24r/S5wpen6gHcVPAf/xyjONc
         kB9M84Bu6G98vtUM1fEGIxr5bq1X/m76NqhIQASIrSklNdgM1a8437c2+6cA2RdB5T
         uC6t115FvkQBLKxNXmJTk+ZppZwUgaMa03ZSN5embn8hvx7z+ju9WE37LAoP1vqKwB
         +jaQ034rHePuJyLslIz5mSiJBtTFDyEtdC7fR+7/04uvB6QOybl1UZ/lw8mkZYZ5KD
         0QLiUIO42Cyng==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id y5so5079370uap.4;
        Fri, 05 Oct 2018 12:11:52 -0700 (PDT)
X-Gm-Message-State: ABuFfojoEjRqv0SxhNLJAB5Ieexc0ajmIpCpbIWlXT9KDnpVFsqTx4vc
        SVmrBIuTvMYSZJ+hixI6y5mibEHvPQfiyNl/4OE=
X-Google-Smtp-Source: ACcGV638F0wcTZxJxyb6MOj4cha24W2E8JS3KZnTFwwbrFywxrQTyqVRheQpnEpMEalHGtNQiMDYoqIT5GTnHiW022c=
X-Received: by 2002:ab0:4e8b:: with SMTP id l11mr5306238uah.93.1538766711054;
 Fri, 05 Oct 2018 12:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
 <1536799869-10643-3-git-send-email-yamada.masahiro@socionext.com> <20181005145706.GM2372@vkoul-mobl>
In-Reply-To: <20181005145706.GM2372@vkoul-mobl>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 6 Oct 2018 04:11:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASF5Ct+ONWnRqZwstg+htAo0buG19HOGM-EV2EPe1NSbQ@mail.gmail.com>
Message-ID: <CAK7LNASF5Ct+ONWnRqZwstg+htAo0buG19HOGM-EV2EPe1NSbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Thanks for looking at this closely.


On Fri, Oct 5, 2018 at 11:57 PM Vinod <vkoul@kernel.org> wrote:
>
> On 13-09-18, 09:51, Masahiro Yamada wrote:
>
> > +#define UNIPHIER_MDMAC_CH_IRQ_STAT   0x010   // current hw status (RO)
> > +#define UNIPHIER_MDMAC_CH_IRQ_REQ    0x014   // latched STAT (WOC)
> > +#define UNIPHIER_MDMAC_CH_IRQ_EN     0x018   // IRQ enable mask
> > +#define UNIPHIER_MDMAC_CH_IRQ_DET    0x01c   // REQ & EN (RO)
> > +#define   UNIPHIER_MDMAC_CH_IRQ__ABORT               BIT(13)
> > +#define   UNIPHIER_MDMAC_CH_IRQ__DONE                BIT(1)
>
> why notation if UNIPHIER_MDMAC_CH_IRQ__FOO ?


Macros without double-underscore are just register offsets.

Macros with double-underscore are bit flags in
the corresponding register.


I often use this notation,
and I also see somebody else did so.

For example, see
drivers/mtd/nand/raw/denali.h


Please let me know if you do not like it.
I can adjust myself to your preference.



> > +#define UNIPHIER_MDMAC_CH_SRC_MODE   0x020   // mode of source
> > +#define UNIPHIER_MDMAC_CH_DEST_MODE  0x024   // mode of destination
> > +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_INC   (0 << 4)
> > +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_DEC   (1 << 4)
> > +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED (2 << 4)
> > +#define UNIPHIER_MDMAC_CH_SRC_ADDR   0x028   // source address
> > +#define UNIPHIER_MDMAC_CH_DEST_ADDR  0x02c   // destination address
> > +#define UNIPHIER_MDMAC_CH_SIZE               0x030   // transfer bytes
>
> Please use /* comment */ style for these



I just thought people are getting tolerant of C++ comments.

Linus is so:
https://lkml.org/lkml/2017/11/25/133

However, C++ is not officially allowed in the
Linux coding style.

Will fix (without odd closing */ alignment)



> > +/* mc->vc.lock must be held by caller */
> > +static struct uniphier_mdmac_desc *__uniphier_mdmac_next_desc(
> > +                                             struct uniphier_mdmac_chan *mc)
>
> this can be made to look better by:
>
> static struct uniphier_mdmac_desc *
> __uniphier_mdmac_next_desc(struct uniphier_mdmac_chan *mc)

OK.
This is not mentioned in the coding style doc at least,
but common enough.
Will fix.


> Btw why leading __ for function name here and other places?


Just a reminder of "mc->vc.lock must be held by caller".

It is common to use double-underscore prefixing
for functions that should be used with care.

However, I am happy to adjust myself to the maintainer.
Please let me know if you do not like it, then I will remove them out.




> > +{
> > +     struct virt_dma_desc *vd;
> > +
> > +     vd = vchan_next_desc(&mc->vc);
> > +     if (!vd) {
> > +             mc->md = NULL;
> > +             return NULL;
> > +     }
> > +
> > +     list_del(&vd->node);
> > +
> > +     mc->md = to_uniphier_mdmac_desc(vd);
> > +
> > +     return mc->md;
> > +}
> > +
> > +/* mc->vc.lock must be held by caller */
> > +static void __uniphier_mdmac_handle(struct uniphier_mdmac_chan *mc,
> > +                                 struct uniphier_mdmac_desc *md)
>
> please align this to previous line opening brace (hint checkpatch with
> --strict option will give you the warning)

This is already aligned.
Perhaps, due to your mailer.



> > +static irqreturn_t uniphier_mdmac_interrupt(int irq, void *dev_id)
> > +{
> > +     struct uniphier_mdmac_chan *mc = dev_id;
> > +     struct uniphier_mdmac_desc *md;
> > +     irqreturn_t ret = IRQ_HANDLED;
> > +     u32 irq_stat;
> > +
> > +     spin_lock(&mc->vc.lock);
> > +
> > +     irq_stat = readl(mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_DET);
> > +
> > +     /*
> > +      * Some channels share a single interrupt line. If the IRQ status is 0,
> > +      * this is probably triggered by a different channel.
> > +      */
> > +     if (!irq_stat) {
> > +             ret = IRQ_NONE;
> > +             goto out;
> > +     }
> > +
> > +     /* write 1 to clear */
> > +     writel(irq_stat, mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_REQ);
> > +
> > +     /*
> > +      * UNIPHIER_MDMAC_CH_IRQ__DONE interrupt is asserted even when the DMA
> > +      * is aborted.  To distinguish the normal completion and the abort,
>                      ^^^^
> double space..

OK, will fix.



> > +static int uniphier_mdmac_config(struct dma_chan *chan,
> > +                              struct dma_slave_config *config)
> > +{
> > +     /* Nothing in struct dma_slave_config is configurable. */
> > +     return 0;
> > +}
>
> I dont think config callback is mandatory, so we can drop this


Will remove.



> > +static enum dma_status uniphier_mdmac_tx_status(struct dma_chan *chan,
> > +                                             dma_cookie_t cookie,
> > +                                             struct dma_tx_state *txstate)
> > +{
> > +     struct virt_dma_chan *vc;
> > +     struct virt_dma_desc *vd;
> > +     struct uniphier_mdmac_chan *mc;
> > +     struct uniphier_mdmac_desc *md = NULL;
> > +     enum dma_status stat;
> > +     unsigned long flags;
> > +
> > +     stat = dma_cookie_status(chan, cookie, txstate);
> > +     /* Return immediately if we do not need to compute the residue. */
> > +     if (stat == DMA_COMPLETE || !txstate)
> > +             return stat;
> > +
> > +     vc = to_virt_chan(chan);
> > +
> > +     spin_lock_irqsave(&vc->lock, flags);
> > +
> > +     mc = to_uniphier_mdmac_chan(vc);
> > +
> > +     if (mc->md && mc->md->vd.tx.cookie == cookie)
> > +             md = mc->md;
> > +
> > +     if (!md) {
> > +             vd = vchan_find_desc(vc, cookie);
> > +             if (vd)
> > +                     md = to_uniphier_mdmac_desc(vd);
> > +     }
>
> in both of these cases you are calling __uniphier_mdmac_get_residue()
> which reads the register and updates. But I think you should read
> register only in the first case when descriptor is submitted and not in
> latter case when descriptor is queued

Good catch!
Will fix.



> > +static int uniphier_mdmac_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct uniphier_mdmac_device *mdev;
> > +     struct dma_device *ddev;
> > +     struct resource *res;
> > +     int nr_chans, ret, i;
> > +
> > +     nr_chans = platform_irq_count(pdev);
> > +     if (nr_chans < 0)
> > +             return nr_chans;
> > +
> > +     ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> > +     if (ret)
> > +             return ret;
> > +
> > +     mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> > +                         GFP_KERNEL);
> > +     if (!mdev)
> > +             return -ENOMEM;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     mdev->reg_base = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(mdev->reg_base))
> > +             return PTR_ERR(mdev->reg_base);
> > +
> > +     mdev->clk = devm_clk_get(dev, NULL);
> > +     if (IS_ERR(mdev->clk)) {
> > +             dev_err(dev, "failed to get clock\n");
> > +             return PTR_ERR(mdev->clk);
> > +     }
> > +
> > +     ret = clk_prepare_enable(mdev->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ddev = &mdev->ddev;
> > +     ddev->dev = dev;
> > +     dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> > +     ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> > +     ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
>
> undefined?

Precisely, I do not know the *_addr_widths.

As far as I read dmaengine/provider.rst
this represents the data bytes that are read/written at a time.

Really I do not know (care about) the transfer width.

As I commented in v2, the connection of the device side is hard-wired.
The transfer width cannot be observed from SW view.

What should I do?


> > +static int uniphier_mdmac_remove(struct platform_device *pdev)
> > +{
> > +     struct uniphier_mdmac_device *mdev = platform_get_drvdata(pdev);
> > +
> > +     of_dma_controller_free(pdev->dev.of_node);
> > +     dma_async_device_unregister(&mdev->ddev);
> > +     clk_disable_unprepare(mdev->clk);
>
> at this point your irq is registered and can be fired, the tasklets are
> not killed :(


Please let me clarify the concerns here.

Before the .remove hook is called, all the consumers should
have already put the dma channels.
So, no new descriptor is coming in.

However,

Some already-issued descriptors might be remaining, and being processed.

[1] This DMA engine might be still running
    when clk_disable_unprepare() is being called.
    The register access with its clock disabled
    would cause the system crash.

[2] vchan_cookie_complete() might being called at this point
    and schedule the tasklet.
    It might call uniphier_mdmac_desc_free() after
    the reference disapperrs.

Is this correct?

Do you have recommendation
for module removal guideline?



--
Best Regards
Masahiro Yamada
