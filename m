Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02464C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54C027B79
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPEOEjwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54C027B79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeF2HhT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752082AbeF2HhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:37:17 -0400
Received: from localhost (unknown [122.167.66.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00F327A88;
        Fri, 29 Jun 2018 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530257836;
        bh=SKF0zyKxp2RgYDUsXa/g9yEkf9UDEEXNxyixbvib1B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPEOEjwBpYdzd6313DbHuIu9JpTbldLsLak0+LcMKDxGba+fPFRGe50rdYt76LZDW
         V+tAzl2DauNoDN0Vf+Ftep1XBXm7zQ1NgUP20uTZgmhmpk/+7fjLJ2hnYaiwoAmi5K
         NqPYjjpZUIRTMYbosmBsm6IORC6Nv5If6Rv/Iaww=
Date:   Fri, 29 Jun 2018 13:07:07 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v3 4/5] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
Message-ID: <20180629073707.GZ22377@vkoul-mobl>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180625092724.22164-4-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625092724.22164-4-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-18, 11:27, Andrea Merello wrote:
> The AXIDMA and CDMA HW can be either direct-access or scatter-gather
> version. These are SW incompatible.
> 
> The driver can handle both version: a DT property was used to
                                ^^^^
versions

> tell the driver whether to assume the HW is is scatter-gather mode.
                                           ^^^^^
is in?

> 
> This patch makes the driver to autodetect this information. The DT
> property is not required anymore.
> 
> No changes for VDMA.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- autodetect only in !VDMA case
> Changes in v3:
> 	- cc DT maintainers/ML
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 7f0ab904b749..43fcc71ff287 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -86,6 +86,7 @@
>  #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
>  #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
>  #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
> +#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
>  #define XILINX_DMA_DMASR_IDLE			BIT(1)
>  #define XILINX_DMA_DMASR_HALTED		BIT(0)
>  #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
> @@ -406,7 +407,6 @@ struct xilinx_dma_config {
>   * @dev: Device Structure
>   * @common: DMA device structure
>   * @chan: Driver specific DMA channel
> - * @has_sg: Specifies whether Scatter-Gather is present or not
>   * @mcdma: Specifies whether Multi-Channel is present or not
>   * @flush_on_fsync: Flush on frame sync
>   * @ext_addr: Indicates 64 bit addressing is supported by dma device
> @@ -426,7 +426,6 @@ struct xilinx_dma_device {
>  	struct device *dev;
>  	struct dma_device common;
>  	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
> -	bool has_sg;
>  	bool mcdma;
>  	u32 flush_on_fsync;
>  	bool ext_addr;
> @@ -2393,7 +2392,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  
>  	chan->dev = xdev->dev;
>  	chan->xdev = xdev;
> -	chan->has_sg = xdev->has_sg;
>  	chan->desc_pendingcount = 0x0;
>  	chan->ext_addr = xdev->ext_addr;
>  	/* This variable ensures that descriptors are not
> @@ -2486,6 +2484,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  		chan->stop_transfer = xilinx_dma_stop_transfer;
>  	}
>  
> +	/* check if SG is enabled (only for AXIDMA and CDMA) */
> +	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
> +		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
> +		    XILINX_DMA_DMASR_SG_MASK)

why not read this for VDMA too, will it return false?

> +			chan->has_sg = true;
> +		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
> +			chan->has_sg ? "enabled" : "disabled");

this debug print can be removed

-- 
~Vinod
