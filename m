Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC8AC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C042086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfASAZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:25:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:36942 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfASAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:25:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 16:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,493,1539673200"; 
   d="scan'208";a="268281601"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2019 16:25:20 -0800
Subject: Re: [PATCH] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc:     Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
References: <20190119001001.13087-1-logang@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <34680d2e-ec3f-7cb4-4f42-2398fc14dd5e@intel.com>
Date:   Fri, 18 Jan 2019 17:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190119001001.13087-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/19 5:10 PM, Logan Gunthorpe wrote:
> Presently, when ntb_transport is used with DMA and the IOMMU turned on,
> it fails with errors from the IOMMU such as:
> 
>   DMAR: DRHD: handling fault status reg 202
>   DMAR: [DMA Write] Request device [00:04.0] fault addr
> 	381fc0340000 [fault reason 05] PTE Write access is not set
> 
> This is because ntb_transport does not map the BAR space with the IOMMU.
> 
> To fix this, we map the entire MW region for each QP after we assign
> the DMA channel. This prevents needing an extra DMA map in the fast
> path.
> 
> Link: https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>

Nice! I actually never encountered this on the Intel NTB with IOMMU on.
It also could be that the Intel BIOS already took care of it for all
embedded device BARs on the uncore. Nevertheless it's needed. Thanks!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3bfdb4562408..526b65afc16a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -144,7 +144,9 @@ struct ntb_transport_qp {
>  	struct list_head tx_free_q;
>  	spinlock_t ntb_tx_free_q_lock;
>  	void __iomem *tx_mw;
> -	dma_addr_t tx_mw_phys;
> +	phys_addr_t tx_mw_phys;
> +	size_t tx_mw_size;
> +	dma_addr_t tx_mw_dma_addr;
>  	unsigned int tx_index;
>  	unsigned int tx_max_entry;
>  	unsigned int tx_max_frame;
> @@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	tx_size = (unsigned int)mw_size / num_qps_mw;
>  	qp_offset = tx_size * (qp_num / mw_count);
>  
> +	qp->tx_mw_size = tx_size;
>  	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
>  	if (!qp->tx_mw)
>  		return -EINVAL;
> @@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  	dma_cookie_t cookie;
>  
>  	device = chan->device;
> -	dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
> +	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
>  	buff_off = (size_t)buf & ~PAGE_MASK;
>  	dest_off = (size_t)dest & ~PAGE_MASK;
>  
> @@ -1863,6 +1866,18 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  		qp->rx_dma_chan = NULL;
>  	}
>  
> +	if (qp->tx_dma_chan) {
> +		qp->tx_mw_dma_addr =
> +			dma_map_resource(qp->tx_dma_chan->device->dev,
> +					 qp->tx_mw_phys, qp->tx_mw_size,
> +					 DMA_FROM_DEVICE, 0);
> +		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
> +				      qp->tx_mw_dma_addr)) {
> +			qp->tx_mw_dma_addr = 0;
> +			goto err1;
> +		}
> +	}
> +
>  	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
>  		qp->tx_dma_chan ? "DMA" : "CPU");
>  
> @@ -1904,6 +1919,10 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	qp->rx_alloc_entry = 0;
>  	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
>  		kfree(entry);
> +	if (qp->tx_mw_dma_addr)
> +		dma_unmap_resource(qp->tx_dma_chan->device->dev,
> +				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> +				   DMA_FROM_DEVICE, 0);
>  	if (qp->tx_dma_chan)
>  		dma_release_channel(qp->tx_dma_chan);
>  	if (qp->rx_dma_chan)
> @@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  		 */
>  		dma_sync_wait(chan, qp->last_cookie);
>  		dmaengine_terminate_all(chan);
> +
> +		dma_unmap_resource(chan->device->dev,
> +				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> +				   DMA_FROM_DEVICE, 0);
> +
>  		dma_release_channel(chan);
>  	}
>  
> 
