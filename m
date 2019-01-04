Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BC0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6398B218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546622499;
	bh=IWRxjqRZMfqkpFR+UMeB7j3ELM39V1FdMr8iK6tZ528=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vHkDmr7v50d9vpNFgiP6fHz9XxjWQcUwqByCH65lP5vOO6ywzomD0LzUNL3qFMeSf
	 jmIJ1A1JQ9YJjZehyFutvIpsOK8rD7a5sqcEB5wK2u0Ef9v3wrJ6siIGCyXvTikOKl
	 7nNP6Z7MdSAl9DPIN1hlBbavBJt88oH9o1Lt1AaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfADRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfADRVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:21:38 -0500
Received: from localhost (unknown [49.207.53.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE77A20656;
        Fri,  4 Jan 2019 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546622496;
        bh=IWRxjqRZMfqkpFR+UMeB7j3ELM39V1FdMr8iK6tZ528=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLk2stXIkhjFIstnEo966bJqc2knqjTaG8nIJ7zw7Uy7mL8GHS4AfxNlCpK3MvUBK
         5Hp4Ux6m1qUtqVZcCOunNNR/la5A94OBz/nQg7vhLcxNgc88ql9vkfkLF4fA8lwGJa
         UkI4zzs5NKZ5DdaCjsEVhRX9t4KaGsKT7T5VSbLo=
Date:   Fri, 4 Jan 2019 22:49:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190104171953.GQ13372@vkoul-mobl.Dlink>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-19, 10:12, Long Cheng wrote:
> In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> the performance, can enable the function.

Is the DMA controller UART specific, can it work with other controllers
as well, if so you should get rid of uart name in patch

> +#define MTK_UART_APDMA_CHANNELS		(CONFIG_SERIAL_8250_NR_UARTS * 2)

Why are the channels not coming from DT?

> +
> +#define VFF_EN_B		BIT(0)
> +#define VFF_STOP_B		BIT(0)
> +#define VFF_FLUSH_B		BIT(0)
> +#define VFF_4G_SUPPORT_B	BIT(0)
> +#define VFF_RX_INT_EN0_B	BIT(0)	/*rx valid size >=  vff thre*/
> +#define VFF_RX_INT_EN1_B	BIT(1)
> +#define VFF_TX_INT_EN_B		BIT(0)	/*tx left size >= vff thre*/

space around /* space */ also run checkpatch to check for style errors

> +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> +{
> +	unsigned int len, send, left, wpt, d_wpt, tmp;
> +	int ret;
> +
> +	left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> +	if (!left) {
> +		mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> +		return;
> +	}
> +
> +	/* Wait 1sec for flush,  can't sleep*/
> +	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> +			tmp != VFF_FLUSH_B, 0, 1000000);
> +	if (ret)
> +		dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> +			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> +
> +	send = min_t(unsigned int, left, c->desc->avail_len);
> +	wpt = mtk_uart_apdma_read(c, VFF_WPT);
> +	len = mtk_uart_apdma_read(c, VFF_LEN);
> +
> +	d_wpt = wpt + send;
> +	if ((d_wpt & VFF_RING_SIZE) >= len) {
> +		d_wpt = d_wpt - len;
> +		d_wpt = d_wpt ^ VFF_RING_WRAP;
> +	}
> +	mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> +
> +	c->desc->avail_len -= send;
> +
> +	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> +	if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> +		mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> +}
> +
> +static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
> +{
> +	struct mtk_uart_apdma_desc *d = c->desc;
> +	unsigned int len, wg, rg, cnt;
> +
> +	if ((mtk_uart_apdma_read(c, VFF_VALID_SIZE) == 0U) ||
> +		!d || !vchan_next_desc(&c->vc))
> +		return;
> +
> +	len = mtk_uart_apdma_read(c, VFF_LEN);
> +	rg = mtk_uart_apdma_read(c, VFF_RPT);
> +	wg = mtk_uart_apdma_read(c, VFF_WPT);
> +	if ((rg ^ wg) & VFF_RING_WRAP)
> +		cnt = (wg & VFF_RING_SIZE) + len - (rg & VFF_RING_SIZE);
> +	else
> +		cnt = (wg & VFF_RING_SIZE) - (rg & VFF_RING_SIZE);
> +
> +	c->rx_status = cnt;
> +	mtk_uart_apdma_write(c, VFF_RPT, wg);
> +
> +	list_del(&d->vd.node);
> +	vchan_cookie_complete(&d->vd);
> +}

this looks odd, why do you have different rx and tx start routines?

> +static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct mtk_uart_apdmadev *mtkd = to_mtk_uart_apdma_dev(chan->device);
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	u32 tmp;
> +	int ret;
> +
> +	pm_runtime_get_sync(mtkd->ddev.dev);
> +
> +	mtk_uart_apdma_write(c, VFF_ADDR, 0);
> +	mtk_uart_apdma_write(c, VFF_THRE, 0);
> +	mtk_uart_apdma_write(c, VFF_LEN, 0);
> +	mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);
> +
> +	ret = readx_poll_timeout(readl, c->base + VFF_EN, tmp,
> +			tmp == 0, 10, 100);
> +	if (ret) {
> +		dev_err(chan->device->dev, "dma reset: fail, timeout\n");
> +		return ret;
> +	}

register read does reset?

> +
> +	if (!c->requested) {
> +		c->requested = true;
> +		ret = request_irq(mtkd->dma_irq[chan->chan_id],
> +				  mtk_uart_apdma_irq_handler, IRQF_TRIGGER_NONE,
> +				  KBUILD_MODNAME, chan);

why is the irq not requested in driver probe?

> +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	if (!txstate)
> +		return DMA_ERROR;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (ret == DMA_IN_PROGRESS) {
> +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> +		dma_set_residue(txstate, c->rx_status);
> +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {

why set reside when it is complete? also reside can be null, that should
be checked as well

> +static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
> +	(struct dma_chan *chan, struct scatterlist *sgl,
> +	unsigned int sglen, enum dma_transfer_direction dir,
> +	unsigned long tx_flags, void *context)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	struct mtk_uart_apdma_desc *d;
> +
> +	if ((dir != DMA_DEV_TO_MEM) &&
> +		(dir != DMA_MEM_TO_DEV)) {
> +		dev_err(chan->device->dev, "bad direction\n");
> +		return NULL;
> +	}

we have a macro for this

> +
> +	/* Now allocate and setup the descriptor */
> +	d = kzalloc(sizeof(*d), GFP_ATOMIC);
> +	if (!d)
> +		return NULL;
> +
> +	/* sglen is 1 */

?

> +static int mtk_uart_apdma_slave_config(struct dma_chan *chan,
> +				struct dma_slave_config *cfg)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	struct mtk_uart_apdmadev *mtkd =
> +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> +
> +	c->cfg = *cfg;
> +
> +	if (cfg->direction == DMA_DEV_TO_MEM) {

fg->direction is deprecated, in fact I have removed all users recently,
please do not use this

> +		unsigned int rx_len = cfg->src_addr_width * 1024;
> +
> +		mtk_uart_apdma_write(c, VFF_ADDR, cfg->src_addr);
> +		mtk_uart_apdma_write(c, VFF_LEN, rx_len);
> +		mtk_uart_apdma_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> +		mtk_uart_apdma_write(c, VFF_INT_EN,
> +				VFF_RX_INT_EN0_B | VFF_RX_INT_EN1_B);
> +		mtk_uart_apdma_write(c, VFF_RPT, 0);
> +		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> +		mtk_uart_apdma_write(c, VFF_EN, VFF_EN_B);

why are we writing this here, we are supposed to do that when txn
starts!

> +static int mtk_uart_apdma_device_resume(struct dma_chan *chan)
> +{
> +	/* just for check caps pass */
> +	return 0;
> +}

if you do not support this please remove this!

> +static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
> +{
> +	while (list_empty(&mtkd->ddev.channels) == 0) {
> +		struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> +			struct mtk_chan, vc.chan.device_node);
> +
> +		list_del(&c->vc.chan.device_node);
> +		tasklet_kill(&c->vc.task);
> +	}
> +}
> +
> +static const struct of_device_id mtk_uart_apdma_match[] = {
> +	{ .compatible = "mediatek,mt6577-uart-dma", },

where is the binding document for ediatek,mt6577-uart-dma ??

-- 
~Vinod
