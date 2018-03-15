Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeCOQHW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:07:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOQHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:07:20 -0400
Date: Thu, 15 Mar 2018 17:07:02 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org, boris.brezillon@free-electrons.com,
        richard@nod.at, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
        computersforpeace@gmail.com
Subject: Re: [PATCH 2/3] mtd: maps: Remove print after allocation failure
Message-ID: <20180315170702.552c4756@bbrezillon>
In-Reply-To: <1521041718-32492-2-git-send-email-arushisinghal19971997@gmail.com>
References: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
        <1521041718-32492-2-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arushi,

On Wed, 14 Mar 2018 21:05:17 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> The prints after [k|v][m|z|c]alloc() functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/mtd/maps/sun_uflash.c | 4 +---

And here as well some of the drivers are still printing error messages
after mem allocation failures (amd76xrom, ck804xrom, esb2rom, ichxrom,
vmu-flash).

Regards,

Boris

>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
> index 1e73bba..80a253c 100644
> --- a/drivers/mtd/maps/sun_uflash.c
> +++ b/drivers/mtd/maps/sun_uflash.c
> @@ -62,10 +62,8 @@ int uflash_devinit(struct platform_device *op, struct device_node *dp)
>  	}
>  
>  	up = kzalloc(sizeof(struct uflash_dev), GFP_KERNEL);
> -	if (!up) {
> -		printk(KERN_ERR PFX "Cannot allocate struct uflash_dev\n");
> +	if (!up)
>  		return -ENOMEM;
> -	}
>  
>  	/* copy defaults and tweak parameters */
>  	memcpy(&up->map, &uflash_map_templ, sizeof(uflash_map_templ));



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
