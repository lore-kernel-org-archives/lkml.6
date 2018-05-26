Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031556AbeEZIoY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:44:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35900 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031385AbeEZInN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:43:13 -0400
Date: Sat, 26 May 2018 10:42:59 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v3 05/16] mtd: rawnand: qcom: remove dt property
 nand-ecc-step-size
Message-ID: <20180526104259.210d96fc@xps13>
In-Reply-To: <1527250904-21988-6-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-6-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Fri, 25 May 2018 17:51:33 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> QCOM NAND controller supports only one step size (512) so
> nand-ecc-step-size DT property is redundant. This property
> can be removed and ecc step size can be assigned with 512 value.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v2:
> 
>  NEW CHANGE
> 
>   1. Removed the custom logic and used the helper fuction.
>  drivers/mtd/nand/raw/qcom_nandc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index b554fb6..b538390 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2325,15 +2325,8 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
>  	bool wide_bus;
>  	int ecc_mode = 1;
>  
> -	/*
> -	 * the controller requires each step consists of 512 bytes of data.
> -	 * bail out if DT has populated a wrong step size.
> -	 */
> -	if (ecc->size != NANDC_STEP_SIZE) {
> -		dev_err(nandc->dev, "invalid ecc size\n");
> -		return -EINVAL;
> -	}
> -
> +	/* controller only supports 512 bytes of data in each step */

"512 bytes data steps"

> +	ecc->size = NANDC_STEP_SIZE;
>  	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
>  
>  	if (ecc->strength >= 8) {

Once corrected:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
