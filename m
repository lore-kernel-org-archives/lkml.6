Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDWFq5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:46:57 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:6287 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeDWFqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:46:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,316,1520924400";
   d="scan'208";a="13526267"
Date: Mon, 23 Apr 2018 07:46:12 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: <dmaengine@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] dmaengine: at_hdmac: simplify getting .drvdata
Message-ID: <20180423054612.GE13305@rfolt0960.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
 <20180422091415.7587-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180422091415.7587-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 11:14:09AM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks
> ---
> 
> Build tested only. buildbot is happy. Please apply to your tree directly.
> 
>  drivers/dma/at_hdmac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index a861b5b4d443..75f38d19fcbe 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2041,8 +2041,7 @@ static void at_dma_shutdown(struct platform_device *pdev)
>  
>  static int at_dma_prepare(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct at_dma *atdma = platform_get_drvdata(pdev);
> +	struct at_dma *atdma = dev_get_drvdata(dev);
>  	struct dma_chan *chan, *_chan;
>  
>  	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
> @@ -2076,8 +2075,7 @@ static void atc_suspend_cyclic(struct at_dma_chan *atchan)
>  
>  static int at_dma_suspend_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct at_dma *atdma = platform_get_drvdata(pdev);
> +	struct at_dma *atdma = dev_get_drvdata(dev);
>  	struct dma_chan *chan, *_chan;
>  
>  	/* preserve data */
> @@ -2118,8 +2116,7 @@ static void atc_resume_cyclic(struct at_dma_chan *atchan)
>  
>  static int at_dma_resume_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct at_dma *atdma = platform_get_drvdata(pdev);
> +	struct at_dma *atdma = dev_get_drvdata(dev);
>  	struct dma_chan *chan, *_chan;
>  
>  	/* bring back DMA controller */
> -- 
> 2.11.0
> 
