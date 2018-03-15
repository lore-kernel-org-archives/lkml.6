Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbeCOQCB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:02:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34387 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932475AbeCOQB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:01:56 -0400
Date: Thu, 15 Mar 2018 17:01:37 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org, boris.brezillon@free-electrons.com,
        richard@nod.at, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
        computersforpeace@gmail.com
Subject: Re: [PATCH 1/3] mtd: nand: Remove print after allocation failure
Message-ID: <20180315170137.403af265@bbrezillon>
In-Reply-To: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018 21:05:16 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> The prints after [k|v][m|z|c]alloc() functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/mtd/nand/ams-delta.c | 1 -

You miss quite a few of them (atmel, nandsim, sunxi_nand at least,
there might be others).

>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
> index 9de6572..6e7f6e0 100644
> --- a/drivers/mtd/nand/ams-delta.c
> +++ b/drivers/mtd/nand/ams-delta.c
> @@ -185,7 +185,6 @@ static int ams_delta_init(struct platform_device *pdev)
>  	/* Allocate memory for MTD device structure and private data */
>  	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
>  	if (!this) {
> -		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
>  		err = -ENOMEM;
>  		goto out;
>  	}



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
