Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9CCC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072AA2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547982771;
	bh=pUOprQbOADkmOadE8UJzN9vDHOZ7uNyMZtLXB22wOk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vwOgbbWOEoVlgKdI7hCD0tH11cQG6nn9/tJZc6wv2duOHTmgRO/Uk+jjOTLH+nhlA
	 Sa1iKbWRc7cPwCKRaXQZnhg3gZ7LDAzd1+F7XkJQYUAJWDyKv6CdqTeSQg+/O7iNUT
	 wfZ5pa8WuR0qQIWQtAF5iFadEjxoSQFmZ+/VXAcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfATLMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 06:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfATLMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 06:12:50 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE7C2085B;
        Sun, 20 Jan 2019 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547982769;
        bh=pUOprQbOADkmOadE8UJzN9vDHOZ7uNyMZtLXB22wOk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sy2AlZr7qMofSZWVrStX0nB8070kOv04jM8gDama/gUmkFv7efOuw0w2VqcsUp3Lf
         b3saEyLzlpSoFyWLOZUtlbG8c0ma6O+uRdq9X09QW7iA4rda6VPVTOhzNMVlm5MtdE
         MUHKEfqjK6gjmNhbW4AbLkGFYmp/Oi+nOmpE1Lok=
Date:   Sun, 20 Jan 2019 16:41:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, Tanglei Han <hantanglei@huawei.com>
Subject: Re: [PATCH 3/8 v4] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
Message-ID: <20190120111115.GU4635@vkoul-mobl>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-4-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547658629-25378-4-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-19, 09:10, John Stultz wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> On the hi3660 hardware there are two (at least) DMA controllers,
> the DMA-P (Peripherial DMA) and the DMA-A (Audio DMA). The
                    ^^^
typo

> two blocks are similar, but have some slight differences. This
> resulted in the vendor implementing two separate drivers, which
> after review, they have been able to condense and re-use the
> existing k3dma driver.
> 
> Thus, this patch adds support for the new "hisi-pcm-asp-dma-1.0"
> compatible string in the binding.
> 
> One difference with the DMA-A controller, is that it does not
> need to initialize a clock. So we skip this by adding and using
> soc data flags.
> 
> After above this driver will support both k3 and hisi_asp dma
> hardware.

Great thanks for the effort!

> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> [jstultz: Reworked to use of_match_data, commit msg improvements]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Reworked to use of_match_data
> v3:
> * Further rework of the commit message
> ---
>  drivers/dma/k3dma.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index fdec2b6..df61406 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -116,6 +116,13 @@ struct k3_dma_dev {
>  	unsigned int		irq;
>  };
>  
> +
> +#define K3_FLAG_NOCLK  (1<<0)

why not use BIT()

space between two please

> +struct k3dma_soc_data {
> +	unsigned long flags;
> +};
> +
> +
>  #define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
>  
>  static int k3_dma_config_write(struct dma_chan *chan,
> @@ -790,8 +797,21 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
>  	return 0;
>  }
>  
> +static const struct k3dma_soc_data k3_v1_dma_data = {
> +	.flags = 0,
> +};

So basically this is default right, do we need to set dma_data and not
assume default..

> +
> +static const struct k3dma_soc_data asp_v1_dma_data = {
> +	.flags = K3_FLAG_NOCLK,
> +};
> +
>  static const struct of_device_id k3_pdma_dt_ids[] = {
> -	{ .compatible = "hisilicon,k3-dma-1.0", },
> +	{ .compatible = "hisilicon,k3-dma-1.0",
> +	  .data = &k3_v1_dma_data
> +	},
> +	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0",
> +	  .data = &asp_v1_dma_data
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> @@ -810,6 +830,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>  
>  static int k3_dma_probe(struct platform_device *op)
>  {
> +	const struct k3dma_soc_data *soc_data;
>  	struct k3_dma_dev *d;
>  	const struct of_device_id *of_id;
>  	struct resource *iores;
> @@ -823,6 +844,10 @@ static int k3_dma_probe(struct platform_device *op)
>  	if (!d)
>  		return -ENOMEM;
>  
> +	soc_data = device_get_match_data(&op->dev);
> +	if (!soc_data)
> +		return -EINVAL;

So this is not optional, either ways fine by me :)
-- 
~Vinod
