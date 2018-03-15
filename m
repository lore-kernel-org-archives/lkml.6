Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeCOQKZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:10:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35298 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbeCOQKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:10:24 -0400
Date: Thu, 15 Mar 2018 17:10:06 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: dwmw2@infradead.org, boris.brezillon@free-electrons.com,
        richard@nod.at, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
        computersforpeace@gmail.com
Subject: Re: [PATCH 3/3] mtd: Remove print after allocation failure
Message-ID: <20180315171006.258edcca@bbrezillon>
In-Reply-To: <1521041718-32492-3-git-send-email-arushisinghal19971997@gmail.com>
References: <1521041718-32492-1-git-send-email-arushisinghal19971997@gmail.com>
        <1521041718-32492-3-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arushi,

On Wed, 14 Mar 2018 21:05:18 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> The prints after [k|v][m|z|c]alloc() functions are not needed, because
> in case of failure, allocator will print their internal error prints
> anyway.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/mtd/inftlmount.c | 6 +-----

I didn't check but I'm pretty sure you missed some of them here too.

>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
> index 8d6bb189..6b94646 100644
> --- a/drivers/mtd/inftlmount.c
> +++ b/drivers/mtd/inftlmount.c
> @@ -562,12 +562,8 @@ int INFTL_mount(struct INFTLrecord *s)
>  
>  	/* Temporary buffer to store ANAC numbers. */
>  	ANACtable = kcalloc(s->nb_blocks, sizeof(u8), GFP_KERNEL);
> -	if (!ANACtable) {
> -		printk(KERN_WARNING "INFTL: allocation of ANACtable "
> -				"failed (%zd bytes)\n",
> -				s->nb_blocks * sizeof(u8));
> +	if (!ANACtable)
>  		return -ENOMEM;
> -	}
>  
>  	/*
>  	 * First pass is to explore each physical unit, and construct the



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
