Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D9AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC75521872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546605616;
	bh=hF2imHRmRVa4hohWZd0oeeeoZD7AkFa74s0AOUjVqHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mGzfhZZGOOrVn/SwRkwQU9Ti9gdUBFkQ7h42UFlOSF4P8GGNM9d9jIMzMA6PmpJaK
	 gPFzd/QY61ne/RCvnjBafUb5healJAcGoAKIJDg4bx6dP6YCl5JF2pKzesvd/nV/1t
	 Qcn+g6erYR2AbiQyTPth+3dlN0DfQ0Xieq6bkwFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfADMkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfADMkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:40:15 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698EA21871;
        Fri,  4 Jan 2019 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546605614;
        bh=hF2imHRmRVa4hohWZd0oeeeoZD7AkFa74s0AOUjVqHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVHBNgit3oF3Pp1nAd3FQe2IN3pMtMaQdv8osfozcqtJ47dqquyGEig8FYRw42dgz
         3d3lzosYYe7HrNJAaGo1G5Eli+69QPkoaFFn/58sd3Z9lj4hQssdWaPH9c8sYOclTq
         yQR1BOl4Xs3Yl6OL400KR/hrx7HoGfsj1mry/YHw=
Date:   Fri, 4 Jan 2019 18:08:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     shun-chih.yu@mediatek.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com
Subject: Re: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
Message-ID: <20190104123836.GB13372@vkoul-mobl.Dlink>
References: <1545916258-18218-1-git-send-email-shun-chih.yu@mediatek.com>
 <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545916258-18218-3-git-send-email-shun-chih.yu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-18, 21:10, shun-chih.yu@mediatek.com wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 

This should be v4 of the patch series, why is it not tagged so?

> MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated
> to memory-to-memory transfer through queue based descriptor management.

Have you tested this with dmatest, if so can you provide results of the
test as well.

> There are only 3 physical channels inside CQDMA, while the driver is
> extended to support 32 virtual channels for multiple dma users to issue
> dma requests onto the CQDMA simultaneously.
> 
> Change-Id: I1e8d116c5ecbbc49190ffc925cb59a0d035d886b

Please remove this from upstream, checkpatch would have warned that!

> Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

This is _WRONG_ I have never provided such tag, can you explain why this
was added without my approval?

>  	  This controller provides the channels which is dedicated to
>  	  memory-to-memory transfer to offload from CPU through ring-
>  	  based descriptor management.
> +
> +config MTK_CQDMA
> +	tristate "MediaTek Command-Queue DMA controller support"

Am not sure if I asked this earlier but, what is difference with HSDMA?

> +/**
> + * struct mtk_cqdma_pchan - The struct holding info describing physical
> + *                         channel (PC)
> + * @queue:                 Queue for the CVDs issued to this PC
> + * @base:                  The mapped register I/O base of this PC
> + * @irq:                   The IRQ that this PC are using
> + * @refcnt:                Track how many VCs are using this PC
> + * @lock:                 Lock protect agaisting multiple VCs access PC

Please maintain alignment!

> + */
> +struct mtk_cqdma_pchan {
> +	struct list_head queue;
> +	void __iomem *base;
> +	u32 irq;
> +	refcount_t refcnt;
> +
> +	/* lock to protect PC */

This is not required, you already have above !

> +	spinlock_t lock;
> +};
> +
> +/**
> + * struct mtk_cqdma_vchan - The struct holding info describing virtual
> + *                         channel (VC)
> + * @vc:                    An instance for struct virt_dma_chan
> + * @pc:                    The pointer to the underlying PC
> + * @issue_completion:	   The wait for all issued descriptors completited

typo completited , am not sure why you need this

> +static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
> +{
> +	writel_relaxed(val, pc->base + reg);

Why is it relaxed one?

> +static void mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
> +{
> +	struct mtk_cqdma_vchan *cvc;
> +	struct mtk_cqdma_vdesc *cvd;
> +	size_t tlen;
> +
> +	/* consume a CVD from PC's queue */
> +	cvd = list_first_entry_or_null(&pc->queue,
> +				       struct mtk_cqdma_vdesc, node);

you can use vchan_next_desc() and also remove your own queue as
virt-desc already implements that logic!

> +	if (unlikely(!cvd))
> +		return;
> +
> +	cvc = to_cqdma_vchan(cvd->ch);
> +
> +	tlen = (cvd->len < MTK_CQDMA_MAX_LEN) ? cvd->len : MTK_CQDMA_MAX_LEN;
> +	cvd->len -= tlen;
> +	cvd->src += tlen;
> +	cvd->dest += tlen;
> +
> +	/* check whether the CVD completed */
> +	if (!cvd->len) {
> +		/* delete CVD from PC's queue */
> +		list_del(&cvd->node);
> +
> +		spin_lock(&cvc->vc.lock);
> +
> +		/* add the VD into list desc_completed */
> +		vchan_cookie_complete(&cvd->vd);
> +
> +		/* setup completion if this VC is under synchronization */
> +		if (cvc->issue_synchronize && !mtk_cqdma_is_vchan_active(cvc)) {
> +			complete(&cvc->issue_completion);
> +			cvc->issue_synchronize = false;
> +		}

why do you need your own completion?

> +
> +		spin_unlock(&cvc->vc.lock);
> +	}
> +
> +	/* iterate on the next CVD if the current CVD completed */
> +	if (!cvd->len)
> +		cvd = list_first_entry_or_null(&pc->queue,
> +					       struct mtk_cqdma_vdesc, node);
> +
> +	/* start the next transaction */
> +	if (cvd)
> +		mtk_cqdma_start(pc, cvd);

most of this logic looks reduandant to me. Virt-dma was designed to do
exactly this, have N physical channels and share with M virt channels.
Please reuse and remove code from this driver.

> +static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
> +							dma_cookie_t cookie)
> +{
> +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cvc->pc->lock, flags);
> +	list_for_each_entry(vd, &cvc->pc->queue, node)
> +		if (vd->tx.cookie == cookie) {
> +			spin_unlock_irqrestore(&cvc->pc->lock, flags);
> +			return vd;
> +		}
> +	spin_unlock_irqrestore(&cvc->pc->lock, flags);
> +
> +	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
> +		if (vd->tx.cookie == cookie)
> +			return vd;

vchan_find_desc() ??

> +static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *txstate)
> +{
> +	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> +	struct mtk_cqdma_vdesc *cvd;
> +	struct virt_dma_desc *vd;
> +	enum dma_status ret;
> +	unsigned long flags;
> +	size_t bytes = 0;
> +
> +	ret = dma_cookie_status(c, cookie, txstate);
> +	if (ret == DMA_COMPLETE || !txstate)
> +		return ret;
> +
> +	spin_lock_irqsave(&cvc->vc.lock, flags);
> +	vd = mtk_cqdma_find_active_desc(c, cookie);
> +	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> +
> +	if (vd) {
> +		cvd = to_cqdma_vdesc(vd);
> +		bytes = cvd->len;
> +	}
> +
> +	dma_set_residue(txstate, bytes);

Have you tested this and are able to report residue properly?

> +static void mtk_cqdma_free_inactive_desc(struct dma_chan *c)
> +{
> +	struct virt_dma_chan *vc = to_virt_chan(c);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	/*
> +	 * set desc_allocated, desc_submitted,
> +	 * and desc_issued as the candicates to be freed
> +	 */
> +	spin_lock_irqsave(&vc->lock, flags);
> +	list_splice_tail_init(&vc->desc_allocated, &head);
> +	list_splice_tail_init(&vc->desc_submitted, &head);
> +	list_splice_tail_init(&vc->desc_issued, &head);

You missed completed and didnt use vchan_get_all_descriptors() ??


Looking at the driver, I feel things have been complicated a bit, you
can reuse more code and routines in vchan layer and remove driver
handling and make things with less bugs (used more tested generic code)
and simpler to review ..

Please do so in next rev and tag version properly!

-- 
~Vinod
