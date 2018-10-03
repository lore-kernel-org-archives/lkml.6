Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3F2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6DC2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6DC2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJDCUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:20:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48069 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbeJDCUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:20:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 41788207F0; Wed,  3 Oct 2018 21:30:22 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB5CB2071E;
        Wed,  3 Oct 2018 21:30:11 +0200 (CEST)
Date:   Wed, 3 Oct 2018 21:30:12 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, michals@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh12@gmail.com
Subject: Re: [LINUX PATCH v11 2/3] mtd: rawnand: Add an option to get sdr
 timing mode number
Message-ID: <20181003213012.021cebed@bbrezillon>
In-Reply-To: <1537878031-22253-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1537878031-22253-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 17:50:30 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> Some NAND controllers needs sdr timing mode value, instead of

			^need SDR

> timings parameters. i.e the NAND controller will change its operating

	  s/parameters//

> mode by just configuring the sdr timing mode number. so add mode parameter

							^ So, add a mode field 

> in struct nand_sdr_timings.

  ^ to ...

> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v11:
>  - None
> ---
>  drivers/mtd/nand/raw/nand_timings.c | 6 ++++++
>  include/linux/mtd/rawnand.h         | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
> index ebc7b5f..1ec7a28 100644
> --- a/drivers/mtd/nand/raw/nand_timings.c
> +++ b/drivers/mtd/nand/raw/nand_timings.c
> @@ -56,6 +56,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
>  			.tWHR_min = 120000,
>  			.tWP_min = 50000,
>  			.tWW_min = 100000,
> +			.mode = 0,
>  		},
>  	},
>  	/* Mode 1 */
> @@ -98,6 +99,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
>  			.tWHR_min = 80000,
>  			.tWP_min = 25000,
>  			.tWW_min = 100000,
> +			.mode = 1,
>  		},
>  	},
>  	/* Mode 2 */
> @@ -140,6 +142,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
>  			.tWHR_min = 80000,
>  			.tWP_min = 17000,
>  			.tWW_min = 100000,
> +			.mode = 2,
>  		},
>  	},
>  	/* Mode 3 */
> @@ -182,6 +185,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
>  			.tWHR_min = 80000,
>  			.tWP_min = 15000,
>  			.tWW_min = 100000,
> +			.mode = 3,
>  		},
>  	},
>  	/* Mode 4 */
> @@ -224,6 +228,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
>  			.tWHR_min = 80000,
>  			.tWP_min = 12000,
>  			.tWW_min = 100000,
> +			.mode = 4,
>  		},
>  	},
>  	/* Mode 5 */
> @@ -266,6 +271,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
>  			.tWHR_min = 80000,
>  			.tWP_min = 10000,
>  			.tWW_min = 100000,
> +			.mode = 5,
>  		},
>  	},
>  };
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index efb2345..3bf2cea 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -723,6 +723,7 @@ struct nand_ecc_ctrl {
>   * @tWHR_min: WE# high to RE# low
>   * @tWP_min: WE# pulse width
>   * @tWW_min: WP# transition to WE# low
> + * @mode: sdr timing mode value

      @mode: ONFI timing mode

>   */
>  struct nand_sdr_timings {
>  	u64 tBERS_max;
> @@ -763,6 +764,7 @@ struct nand_sdr_timings {
>  	u32 tWHR_min;
>  	u32 tWP_min;
>  	u32 tWW_min;
> +	u8 mode;
>  };
>  
>  /**

With this addressed, you can add

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
