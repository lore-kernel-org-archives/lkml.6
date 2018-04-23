Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDWFrR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:47:17 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:39543 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeDWFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:47:14 -0400
X-IronPort-AV: E=Sophos;i="5.49,316,1520924400";
   d="scan'208";a="14117867"
Date: Mon, 23 Apr 2018 07:46:31 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: <dmaengine@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] dmaengine: at_xdmac: simplify getting .drvdata
Message-ID: <20180423054631.GF13305@rfolt0960.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
 <20180422091415.7587-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180422091415.7587-3-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 11:14:10AM +0200, Wolfram Sang wrote:
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
>  drivers/dma/at_xdmac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 94236ec9d410..4bf72561667c 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1833,8 +1833,7 @@ static void at_xdmac_free_chan_resources(struct dma_chan *chan)
>  #ifdef CONFIG_PM
>  static int atmel_xdmac_prepare(struct device *dev)
>  {
> -	struct platform_device	*pdev = to_platform_device(dev);
> -	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
> +	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
>  	struct dma_chan		*chan, *_chan;
>  
>  	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
> @@ -1853,8 +1852,7 @@ static int atmel_xdmac_prepare(struct device *dev)
>  #ifdef CONFIG_PM_SLEEP
>  static int atmel_xdmac_suspend(struct device *dev)
>  {
> -	struct platform_device	*pdev = to_platform_device(dev);
> -	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
> +	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
>  	struct dma_chan		*chan, *_chan;
>  
>  	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
> @@ -1878,8 +1876,7 @@ static int atmel_xdmac_suspend(struct device *dev)
>  
>  static int atmel_xdmac_resume(struct device *dev)
>  {
> -	struct platform_device	*pdev = to_platform_device(dev);
> -	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
> +	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
>  	struct at_xdmac_chan	*atchan;
>  	struct dma_chan		*chan, *_chan;
>  	int			i;
> -- 
> 2.11.0
> 
