Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeD0FGg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:06:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:47403 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeD0FGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:06:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="36819403"
Date: Fri, 27 Apr 2018 10:41:15 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, lars@metafoo.de
Subject: Re: [PATCH v2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
Message-ID: <20180427051115.GX6014@localhost>
References: <20180426174000.12008-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426174000.12008-1-mdf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:40:00AM -0700, Moritz Fischer wrote:
> Request IRQ with IRQF_SHARED flag. This works since the interrupt
> handler already checks if there is an actual IRQ pending and returns
> IRQ_NONE otherwise.

hmmm what are we trying to fix here? Is your device on a shared line or not?

> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> Changes from v1:
> - Added Lars' Acked-by
> - Dropped patch [1/2] and changed accordingly
> ---
>  drivers/dma/dma-axi-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 2419fe524daa..15b2453d2647 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -687,7 +687,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_device;
>  
> -	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, 0,
> +	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, IRQF_SHARED,
>  		dev_name(&pdev->dev), dmac);
>  	if (ret)
>  		goto err_unregister_of;
> -- 
> 2.17.0
> 

-- 
~Vinod
