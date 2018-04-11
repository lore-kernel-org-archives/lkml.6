Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeDKJTj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:19:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:48451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeDKJTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:19:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="33427317"
Date: Wed, 11 Apr 2018 14:54:03 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dan.j.williams@intel.com, eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dmaengine: sprd: Define the DMA transfer step type
Message-ID: <20180411092402.GB6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 03:46:03PM +0800, Baolin Wang wrote:
> From: Eric Long <eric.long@spreadtrum.com>
> 
> Define the DMA transfer step type to make code more readable.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/sprd-dma.c |   28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index b106e8a..af9c156 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -169,6 +169,22 @@ enum sprd_dma_int_type {
>  	SPRD_DMA_CFGERR_INT,
>  };
>  
> +/*
> + * enum sprd_dma_step: define the DMA transfer step type
> + * @SPRD_DMA_NONE_STEP: transfer do not need step
> + * @SPRD_DMA_BYTE_STEP: transfer step is one byte
> + * @SPRD_DMA_SHORT_STEP: transfer step is two bytes
> + * @SPRD_DMA_WORD_STEP: transfer step is one word
> + * @SPRD_DMA_DWORD_STEP: transfer step is double word
> + */
> +enum sprd_dma_step {

looking at bit defines, does it need to be enum? a #define would just be fine.

> +	SPRD_DMA_NONE_STEP,
> +	SPRD_DMA_BYTE_STEP = BIT(0),
> +	SPRD_DMA_SHORT_STEP = BIT(1),
> +	SPRD_DMA_WORD_STEP = BIT(2),
> +	SPRD_DMA_DWORD_STEP = BIT(3),
> +};
> +
>  /* dma channel hardware configuration */
>  struct sprd_dma_chn_hw {
>  	u32 pause;
> @@ -598,16 +614,16 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
>  
>  	if (IS_ALIGNED(len, 4)) {
>  		datawidth = 2;
> -		src_step = 4;
> -		des_step = 4;
> +		src_step = SPRD_DMA_WORD_STEP;
> +		des_step = SPRD_DMA_WORD_STEP;
>  	} else if (IS_ALIGNED(len, 2)) {
>  		datawidth = 1;
> -		src_step = 2;
> -		des_step = 2;
> +		src_step = SPRD_DMA_SHORT_STEP;
> +		des_step = SPRD_DMA_SHORT_STEP;
>  	} else {
>  		datawidth = 0;
> -		src_step = 1;
> -		des_step = 1;
> +		src_step = SPRD_DMA_BYTE_STEP;
> +		des_step = SPRD_DMA_BYTE_STEP;
>  	}
>  
>  	fragment_len = SPRD_DMA_MEMCPY_MIN_SIZE;
> -- 
> 1.7.9.5
> 

-- 
~Vinod
