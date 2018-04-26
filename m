Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeDZQ1P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:27:15 -0400
Received: from www381.your-server.de ([78.46.137.84]:44603 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbeDZQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:27:08 -0400
Subject: Re: [PATCH 2/2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
To: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com
References: <20180426161239.15234-1-mdf@kernel.org>
 <20180426161239.15234-2-mdf@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ea8d2aaf-c627-9c6e-55f3-57acbfd09498@metafoo.de>
Date: Thu, 26 Apr 2018 18:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426161239.15234-2-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 06:12 PM, Moritz Fischer wrote:
> Request IRQ with IRQF_SHARED flag. This works since the interrupt
> handler already checks if there is an actual IRQ pending and returns
> IRQ_NONE otherwise.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  drivers/dma/dma-axi-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 75ccedaa96d2..2bd195532882 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -688,7 +688,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  		goto err_unregister_device;
>  
>  	ret = devm_request_irq(&pdev->dev, dmac->irq,
> -			       axi_dmac_interrupt_handler, 0,
> +			       axi_dmac_interrupt_handler, IRQF_SHARED,
>  			       dev_name(&pdev->dev), dmac);
>  	if (ret)
>  		goto err_unregister_of;
> 
