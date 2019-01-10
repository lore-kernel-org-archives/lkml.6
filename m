Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67478C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37494214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfAJKeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:34:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:28554 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728020AbfAJKeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:34:02 -0500
X-UUID: 1290c1a8242e4a2f9b4b354ceb789b37-20190110
X-UUID: 1290c1a8242e4a2f9b4b354ceb789b37-20190110
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 176831677; Thu, 10 Jan 2019 18:33:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 18:33:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 18:33:51 +0800
Message-ID: <1547116431.3831.43.camel@mhfsdcap03>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Date:   Thu, 10 Jan 2019 18:33:51 +0800
In-Reply-To: <20190104171953.GQ13372@vkoul-mobl.Dlink>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
         <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
         <20190104171953.GQ13372@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-04 at 22:49 +0530, Vinod Koul wrote:
> On 02-01-19, 10:12, Long Cheng wrote:
> > In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> > If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> > the performance, can enable the function.
> 
> Is the DMA controller UART specific, can it work with other controllers
> as well, if so you should get rid of uart name in patch
> 

I don't know that it can work or not on other controller. but it's for
MediaTek SOC

> > +#define MTK_UART_APDMA_CHANNELS		(CONFIG_SERIAL_8250_NR_UARTS * 2)
> 
> Why are the channels not coming from DT?
> 

i will using dma-requests install of it.

> > +
> > +#define VFF_EN_B		BIT(0)
> > +#define VFF_STOP_B		BIT(0)
> > +#define VFF_FLUSH_B		BIT(0)
> > +#define VFF_4G_SUPPORT_B	BIT(0)
> > +#define VFF_RX_INT_EN0_B	BIT(0)	/*rx valid size >=  vff thre*/
> > +#define VFF_RX_INT_EN1_B	BIT(1)
> > +#define VFF_TX_INT_EN_B		BIT(0)	/*tx left size >= vff thre*/
> 
> space around /* space */ also run checkpatch to check for style errors
> 

ok.

> > +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> > +{
> > +	unsigned int len, send, left, wpt, d_wpt, tmp;
> > +	int ret;
> > +
> > +	left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> > +	if (!left) {
> > +		mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > +		return;
> > +	}
> > +
> > +	/* Wait 1sec for flush,  can't sleep*/
> > +	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> > +			tmp != VFF_FLUSH_B, 0, 1000000);
> > +	if (ret)
> > +		dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> > +			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> > +
> > +	send = min_t(unsigned int, left, c->desc->avail_len);
> > +	wpt = mtk_uart_apdma_read(c, VFF_WPT);
> > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > +
> > +	d_wpt = wpt + send;
> > +	if ((d_wpt & VFF_RING_SIZE) >= len) {
> > +		d_wpt = d_wpt - len;
> > +		d_wpt = d_wpt ^ VFF_RING_WRAP;
> > +	}
> > +	mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> > +
> > +	c->desc->avail_len -= send;
> > +
> > +	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > +	if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> > +		mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> > +}
> > +
> > +static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
> > +{
> > +	struct mtk_uart_apdma_desc *d = c->desc;
> > +	unsigned int len, wg, rg, cnt;
> > +
> > +	if ((mtk_uart_apdma_read(c, VFF_VALID_SIZE) == 0U) ||
> > +		!d || !vchan_next_desc(&c->vc))
> > +		return;
> > +
> > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > +	rg = mtk_uart_apdma_read(c, VFF_RPT);
> > +	wg = mtk_uart_apdma_read(c, VFF_WPT);
> > +	if ((rg ^ wg) & VFF_RING_WRAP)
> > +		cnt = (wg & VFF_RING_SIZE) + len - (rg & VFF_RING_SIZE);
> > +	else
> > +		cnt = (wg & VFF_RING_SIZE) - (rg & VFF_RING_SIZE);
> > +
> > +	c->rx_status = cnt;
> > +	mtk_uart_apdma_write(c, VFF_RPT, wg);
> > +
> > +	list_del(&d->vd.node);
> > +	vchan_cookie_complete(&d->vd);
> > +}
> 
> this looks odd, why do you have different rx and tx start routines?
> 

Would you like explain it in more detail? thanks.
In tx function, will wait the last data flush done. and the count the
size that send.
In Rx function, will count the size that receive.
Any way, in rx / tx, need andle WPT or RPT.

> > +static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +	struct mtk_uart_apdmadev *mtkd = to_mtk_uart_apdma_dev(chan->device);
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	pm_runtime_get_sync(mtkd->ddev.dev);
> > +
> > +	mtk_uart_apdma_write(c, VFF_ADDR, 0);
> > +	mtk_uart_apdma_write(c, VFF_THRE, 0);
> > +	mtk_uart_apdma_write(c, VFF_LEN, 0);
> > +	mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);
> > +
> > +	ret = readx_poll_timeout(readl, c->base + VFF_EN, tmp,
> > +			tmp == 0, 10, 100);
> > +	if (ret) {
> > +		dev_err(chan->device->dev, "dma reset: fail, timeout\n");
> > +		return ret;
> > +	}
> 
> register read does reset?
> 

'mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);' is reset. resd just
poll reset done.

> > +
> > +	if (!c->requested) {
> > +		c->requested = true;
> > +		ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > +				  mtk_uart_apdma_irq_handler, IRQF_TRIGGER_NONE,
> > +				  KBUILD_MODNAME, chan);
> 
> why is the irq not requested in driver probe?
> 

I have explained in below,
http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016418.html

> > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > +					 dma_cookie_t cookie,
> > +					 struct dma_tx_state *txstate)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +
> > +	if (!txstate)
> > +		return DMA_ERROR;
> > +
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	spin_lock_irqsave(&c->vc.lock, flags);
> > +	if (ret == DMA_IN_PROGRESS) {
> > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > +		dma_set_residue(txstate, c->rx_status);
> > +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
> 
> why set reside when it is complete? also reside can be null, that should
> be checked as well
> 
In different status, set different reside.

> > +static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
> > +	(struct dma_chan *chan, struct scatterlist *sgl,
> > +	unsigned int sglen, enum dma_transfer_direction dir,
> > +	unsigned long tx_flags, void *context)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	struct mtk_uart_apdma_desc *d;
> > +
> > +	if ((dir != DMA_DEV_TO_MEM) &&
> > +		(dir != DMA_MEM_TO_DEV)) {
> > +		dev_err(chan->device->dev, "bad direction\n");
> > +		return NULL;
> > +	}
> 
> we have a macro for this

Thanks for your suggestion. i will modify it.
> 
> > +
> > +	/* Now allocate and setup the descriptor */
> > +	d = kzalloc(sizeof(*d), GFP_ATOMIC);
> > +	if (!d)
> > +		return NULL;
> > +
> > +	/* sglen is 1 */
> 
> ?
> 
> > +static int mtk_uart_apdma_slave_config(struct dma_chan *chan,
> > +				struct dma_slave_config *cfg)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	struct mtk_uart_apdmadev *mtkd =
> > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > +
> > +	c->cfg = *cfg;
> > +
> > +	if (cfg->direction == DMA_DEV_TO_MEM) {
> 
> fg->direction is deprecated, in fact I have removed all users recently,
> please do not use this

You will remove 'direction' in 'struct dma_slave_config'? if remove, how
do confirm direction?

> 
> > +		unsigned int rx_len = cfg->src_addr_width * 1024;
> > +
> > +		mtk_uart_apdma_write(c, VFF_ADDR, cfg->src_addr);
> > +		mtk_uart_apdma_write(c, VFF_LEN, rx_len);
> > +		mtk_uart_apdma_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> > +		mtk_uart_apdma_write(c, VFF_INT_EN,
> > +				VFF_RX_INT_EN0_B | VFF_RX_INT_EN1_B);
> > +		mtk_uart_apdma_write(c, VFF_RPT, 0);
> > +		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> > +		mtk_uart_apdma_write(c, VFF_EN, VFF_EN_B);
> 
> why are we writing this here, we are supposed to do that when txn
> starts!
> 

also you can review the link
http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016418.html

> > +static int mtk_uart_apdma_device_resume(struct dma_chan *chan)
> > +{
> > +	/* just for check caps pass */
> > +	return 0;
> > +}
> 
> if you do not support this please remove this!
> 
> > +static void mtk_uart_apdma_free(struct mtk_uart_apdmadev *mtkd)
> > +{
> > +	while (list_empty(&mtkd->ddev.channels) == 0) {
> > +		struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> > +			struct mtk_chan, vc.chan.device_node);
> > +
> > +		list_del(&c->vc.chan.device_node);
> > +		tasklet_kill(&c->vc.task);
> > +	}
> > +}
> > +
> > +static const struct of_device_id mtk_uart_apdma_match[] = {
> > +	{ .compatible = "mediatek,mt6577-uart-dma", },
> 
> where is the binding document for ediatek,mt6577-uart-dma ??
> 

http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016154.html


