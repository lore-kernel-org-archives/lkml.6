Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeC2UZV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:25:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50575 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2UZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:25:19 -0400
Date: Thu, 29 Mar 2018 22:25:17 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: Use DIV_ROUND_UP()
Message-ID: <20180329222517.44e560d9@bbrezillon>
In-Reply-To: <20180325153743.GA16063@seema-Inspiron-15-3567>
References: <20180325153743.GA16063@seema-Inspiron-15-3567>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2018 21:07:43 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> The kernel.h macro DIV_ROUND_UP performs the computation
> (((n) + (d) - 1) / (d)) but is perhaps more readable.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/ftl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
> index a048429..61d5cf8 100644
> --- a/drivers/mtd/ftl.c
> +++ b/drivers/mtd/ftl.c
> @@ -425,8 +425,8 @@ static int prepare_xfer(partition_t *part, int i)
>      }
>  
>      /* Write the BAM stub */
> -    nbam = (part->BlocksPerUnit * sizeof(uint32_t) +
> -	    le32_to_cpu(part->header.BAMOffset) + SECTOR_SIZE - 1) / SECTOR_SIZE;
> +    nbam = DIV_ROUND_UP(part->BlocksPerUnit * sizeof(uint32_t) +
> +			le32_to_cpu(part->header.BAMOffset), SECTOR_SIZE);
>  
>      offset = xfer->Offset + le32_to_cpu(part->header.BAMOffset);
>      ctl = cpu_to_le32(BLOCK_CONTROL);



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
