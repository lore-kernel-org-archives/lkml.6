Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeEWLsk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:48:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37622 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932627AbeEWLsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:48:37 -0400
Date: Wed, 23 May 2018 13:48:23 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: cmdlinepart: Update comment for introduction of
 OFFSET_CONTINUOUS
Message-ID: <20180523134823.1dffb315@bbrezillon>
In-Reply-To: <1527001673-16318-1-git-send-email-geert+renesas@glider.be>
References: <1527001673-16318-1-git-send-email-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 17:07:53 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The comment about offset zero was not updated when changing behavior:
>   - Automatic offset calculation is indicated by OFFSET_CONTINUOUS,
>   - Zero really means offset zero.
> 
> Fixes: b175d03dd2072836 ("[PATCH] mtd cmdlinepart: allow zero offset value")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/cmdlinepart.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/cmdlinepart.c b/drivers/mtd/cmdlinepart.c
> index fbd5affc0acfe3fe..3ea44cff9b759e3c 100644
> --- a/drivers/mtd/cmdlinepart.c
> +++ b/drivers/mtd/cmdlinepart.c
> @@ -190,7 +190,10 @@ static struct mtd_partition * newpart(char *s,
>  		extra_mem = (unsigned char *)(parts + *num_parts);
>  	}
>  
> -	/* enter this partition (offset will be calculated later if it is zero at this point) */
> +	/*
> +	 * enter this partition (offset will be calculated later if it is
> +	 * OFFSET_CONTINUOUS at this point)
> +	 */
>  	parts[this_part].size = size;
>  	parts[this_part].offset = offset;
>  	parts[this_part].mask_flags = mask_flags;
