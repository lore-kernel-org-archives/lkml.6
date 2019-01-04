Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B57C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1BC218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546622752;
	bh=2/zq3PaqLM7AzddyYYTaIENYeh7K6nFG/+3ZibIfp/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n05vcVNrG/qOR5adXxXz33DwM/mxBnO304roIEdk2H6YNeogAGPU0mcXtDop7AmAu
	 k7fvdYRdY8h+mtlazCLlDp1lVrgkAH8e3h11uB9UX0lfeFnStS03JXAXz0sp5f7V4F
	 MmsJRCS90nqjJt2d68/aOyxbP9d8vT6x4LOMfFok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfADRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfADRZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:25:50 -0500
Received: from localhost (unknown [49.207.53.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC4020656;
        Fri,  4 Jan 2019 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546622749;
        bh=2/zq3PaqLM7AzddyYYTaIENYeh7K6nFG/+3ZibIfp/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vuoMke9HMHMhAnm/vSJOsSqo8fwvKZUmZLR1GbX8WWTtQEiOREr3LkDsE1QbzE2Le
         OS6vH8bBfxnDWTy10IX1cpQ9KUhV2w36PBrHAXIG4Zk2ZVTzQcgGVDGN0RQVatxMGx
         CuX9MvXu1skhiG2DACHZ3u4dRgsrX9KY/sTm7JJY=
Date:   Fri, 4 Jan 2019 22:54:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     h00249924 <hutenghui@huawei.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liyuequan@hisilicon.com, cash.qianli@hisilicon.com,
        huangli295@hisilicon.com, hantanglei@huawei.com,
        wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com,
        hanxiaolong3@hisilicon.com,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] k3dma: Upgrade k3dma drever to support hisi_asp_dma
 hardware
Message-ID: <20190104172405.GR13372@vkoul-mobl.Dlink>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-18, 14:36, h00249924 wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> There is an new "hisi-pcm-asp-dma-1.0" device added in
> "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> So we have to add a matching id in the driver file:
> "{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", }"
> 
> And also hisi-pcm-asp dma device needs no setting to the clock.
> So we skip this by "if" sentence on id string matching:
> "if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0)"
> 
> After above this driver will support both k3 and hisi_asp dma hardware.
> 
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/k3dma.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index fdec2b6..10eecc2 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -792,6 +792,7 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
>  
>  static const struct of_device_id k3_pdma_dt_ids[] = {
>  	{ .compatible = "hisilicon,k3-dma-1.0", },
> +	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0", },

The binding doc patch should precede this..

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> @@ -835,10 +836,12 @@ static int k3_dma_probe(struct platform_device *op)
>  				"dma-requests", &d->dma_requests);
>  	}
>  
> -	d->clk = devm_clk_get(&op->dev, NULL);
> -	if (IS_ERR(d->clk)) {
> -		dev_err(&op->dev, "no dma clk\n");
> -		return PTR_ERR(d->clk);
> +	if (strcasecmp((of_id->compatible), (k3_pdma_dt_ids[0].compatible)) == 0) {
> +		d->clk = devm_clk_get(&op->dev, NULL);

who provides clk in this case? how does this scale if you have another
compatible in future for newer version of controller?


> +		if (IS_ERR(d->clk)) {
> +			dev_err(&op->dev, "no dma clk\n");
> +			return PTR_ERR(d->clk);
> +		}
>  	}
>  
>  	irq = platform_get_irq(op, 0);
> -- 
> 1.9.1

-- 
~Vinod
