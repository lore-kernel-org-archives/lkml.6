Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFAH0F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:26:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42709 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeFAH0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:26:03 -0400
Date: Fri, 1 Jun 2018 09:26:00 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org,
        krzk@kernel.org, jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org,
        digetx@gmail.com
Subject: Re: [PATCH v3 1/6] mtd: rawnand: add Reed-Solomon error correction
 algorithm
Message-ID: <20180601092600.03c14f53@bbrezillon>
In-Reply-To: <20180531221637.6017-2-stefan@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch>
        <20180531221637.6017-2-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 00:16:32 +0200
Stefan Agner <stefan@agner.ch> wrote:

> Add Reed-Solomon (RS) to the enumeration of ECC algorithms.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/nand_base.c | 1 +
>  include/linux/mtd/rawnand.h      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index f28c3a555861..9eb5678dd6d0 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5744,6 +5744,7 @@ static int of_get_nand_ecc_mode(struct device_node *np)
>  static const char * const nand_ecc_algos[] = {
>  	[NAND_ECC_HAMMING]	= "hamming",
>  	[NAND_ECC_BCH]		= "bch",
> +	[NAND_ECC_RS]		= "rs",
>  };
>  
>  static int of_get_nand_ecc_algo(struct device_node *np)
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 5dad59b31244..6a82da8c44ce 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -114,6 +114,7 @@ enum nand_ecc_algo {
>  	NAND_ECC_UNKNOWN,
>  	NAND_ECC_HAMMING,
>  	NAND_ECC_BCH,
> +	NAND_ECC_RS,
>  };
>  
>  /*
