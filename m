Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56784208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWfElCBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56784208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeJEV4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeJEV4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:56:21 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5DD2087D;
        Fri,  5 Oct 2018 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538751436;
        bh=Ix187GGKnCEDlKhxWBFXrPisDyj/oL7GiNM1QlZRNUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWfElCBaHR7yMwBGMpTzjVVCQfe+MnPXcyqS+aXL10QG2Gk9rkWRSYO7NLmQF0/FO
         ZjRUUwuIvrC8UMqqqv+nI1Wl5q0p+z5kApORWuV4ZR0qqPri80XzYfporocen0bQ5M
         iGr20pQGG/hoOrNwV2+vv/z+C9v038va16LxHzKk=
Date:   Fri, 5 Oct 2018 20:27:06 +0530
From:   Vinod <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
 driver
Message-ID: <20181005145706.GM2372@vkoul-mobl>
References: <1536799869-10643-1-git-send-email-yamada.masahiro@socionext.com>
 <1536799869-10643-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536799869-10643-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-09-18, 09:51, Masahiro Yamada wrote:

> +#define UNIPHIER_MDMAC_CH_IRQ_STAT	0x010	// current hw status (RO)
> +#define UNIPHIER_MDMAC_CH_IRQ_REQ	0x014	// latched STAT (WOC)
> +#define UNIPHIER_MDMAC_CH_IRQ_EN	0x018	// IRQ enable mask
> +#define UNIPHIER_MDMAC_CH_IRQ_DET	0x01c	// REQ & EN (RO)
> +#define   UNIPHIER_MDMAC_CH_IRQ__ABORT		BIT(13)
> +#define   UNIPHIER_MDMAC_CH_IRQ__DONE		BIT(1)

why notation if UNIPHIER_MDMAC_CH_IRQ__FOO ?

> +#define UNIPHIER_MDMAC_CH_SRC_MODE	0x020	// mode of source
> +#define UNIPHIER_MDMAC_CH_DEST_MODE	0x024	// mode of destination
> +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_INC	(0 << 4)
> +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_DEC	(1 << 4)
> +#define   UNIPHIER_MDMAC_CH_MODE__ADDR_FIXED	(2 << 4)
> +#define UNIPHIER_MDMAC_CH_SRC_ADDR	0x028	// source address
> +#define UNIPHIER_MDMAC_CH_DEST_ADDR	0x02c	// destination address
> +#define UNIPHIER_MDMAC_CH_SIZE		0x030	// transfer bytes

Please use /* comment */ style for these

> +/* mc->vc.lock must be held by caller */
> +static struct uniphier_mdmac_desc *__uniphier_mdmac_next_desc(
> +						struct uniphier_mdmac_chan *mc)

this can be made to look better by:

static struct uniphier_mdmac_desc *
__uniphier_mdmac_next_desc(struct uniphier_mdmac_chan *mc)

Btw why leading __ for function name here and other places?

> +{
> +	struct virt_dma_desc *vd;
> +
> +	vd = vchan_next_desc(&mc->vc);
> +	if (!vd) {
> +		mc->md = NULL;
> +		return NULL;
> +	}
> +
> +	list_del(&vd->node);
> +
> +	mc->md = to_uniphier_mdmac_desc(vd);
> +
> +	return mc->md;
> +}
> +
> +/* mc->vc.lock must be held by caller */
> +static void __uniphier_mdmac_handle(struct uniphier_mdmac_chan *mc,
> +				    struct uniphier_mdmac_desc *md)

please align this to previous line opening brace (hint checkpatch with
--strict option will give you the warning)

> +static irqreturn_t uniphier_mdmac_interrupt(int irq, void *dev_id)
> +{
> +	struct uniphier_mdmac_chan *mc = dev_id;
> +	struct uniphier_mdmac_desc *md;
> +	irqreturn_t ret = IRQ_HANDLED;
> +	u32 irq_stat;
> +
> +	spin_lock(&mc->vc.lock);
> +
> +	irq_stat = readl(mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_DET);
> +
> +	/*
> +	 * Some channels share a single interrupt line. If the IRQ status is 0,
> +	 * this is probably triggered by a different channel.
> +	 */
> +	if (!irq_stat) {
> +		ret = IRQ_NONE;
> +		goto out;
> +	}
> +
> +	/* write 1 to clear */
> +	writel(irq_stat, mc->reg_ch_base + UNIPHIER_MDMAC_CH_IRQ_REQ);
> +
> +	/*
> +	 * UNIPHIER_MDMAC_CH_IRQ__DONE interrupt is asserted even when the DMA
> +	 * is aborted.  To distinguish the normal completion and the abort,
                     ^^^^
double space..

> +static int uniphier_mdmac_config(struct dma_chan *chan,
> +				 struct dma_slave_config *config)
> +{
> +	/* Nothing in struct dma_slave_config is configurable. */
> +	return 0;
> +}

I dont think config callback is mandatory, so we can drop this

> +static enum dma_status uniphier_mdmac_tx_status(struct dma_chan *chan,
> +						dma_cookie_t cookie,
> +						struct dma_tx_state *txstate)
> +{
> +	struct virt_dma_chan *vc;
> +	struct virt_dma_desc *vd;
> +	struct uniphier_mdmac_chan *mc;
> +	struct uniphier_mdmac_desc *md = NULL;
> +	enum dma_status stat;
> +	unsigned long flags;
> +
> +	stat = dma_cookie_status(chan, cookie, txstate);
> +	/* Return immediately if we do not need to compute the residue. */
> +	if (stat == DMA_COMPLETE || !txstate)
> +		return stat;
> +
> +	vc = to_virt_chan(chan);
> +
> +	spin_lock_irqsave(&vc->lock, flags);
> +
> +	mc = to_uniphier_mdmac_chan(vc);
> +
> +	if (mc->md && mc->md->vd.tx.cookie == cookie)
> +		md = mc->md;
> +
> +	if (!md) {
> +		vd = vchan_find_desc(vc, cookie);
> +		if (vd)
> +			md = to_uniphier_mdmac_desc(vd);
> +	}

in both of these cases you are calling __uniphier_mdmac_get_residue()
which reads the register and updates. But I think you should read
register only in the first case when descriptor is submitted and not in
latter case when descriptor is queued

> +static int uniphier_mdmac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_mdmac_device *mdev;
> +	struct dma_device *ddev;
> +	struct resource *res;
> +	int nr_chans, ret, i;
> +
> +	nr_chans = platform_irq_count(pdev);
> +	if (nr_chans < 0)
> +		return nr_chans;
> +
> +	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> +			    GFP_KERNEL);
> +	if (!mdev)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mdev->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(mdev->reg_base))
> +		return PTR_ERR(mdev->reg_base);
> +
> +	mdev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(mdev->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(mdev->clk);
> +	}
> +
> +	ret = clk_prepare_enable(mdev->clk);
> +	if (ret)
> +		return ret;
> +
> +	ddev = &mdev->ddev;
> +	ddev->dev = dev;
> +	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> +	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);

undefined?

> +static int uniphier_mdmac_remove(struct platform_device *pdev)
> +{
> +	struct uniphier_mdmac_device *mdev = platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&mdev->ddev);
> +	clk_disable_unprepare(mdev->clk);

at this point your irq is registered and can be fired, the tasklets are
not killed :(
-- 
~Vinod
