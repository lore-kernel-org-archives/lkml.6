Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756921AbeDZSEC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:04:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33051 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756433AbeDZSEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:04:00 -0400
Date: Thu, 26 Apr 2018 20:03:48 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Luca Ellero <luca.ellero@brickedbrain.com>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: dataflash: replace msleep with usleep_range
Message-ID: <20180426200348.7c4eef72@bbrezillon>
In-Reply-To: <1524043588-25816-1-git-send-email-luca.ellero@brickedbrain.com>
References: <1524043588-25816-1-git-send-email-luca.ellero@brickedbrain.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 11:26:26 +0200
Luca Ellero <luca.ellero@brickedbrain.com> wrote:

> Since msleep is based on jiffies, this 3 ms sleep becomes actually 20 ms.
> Worst of all, since this sleep is used in a loop when writing, a single page
> write (256 to 1024 bytes) causes 17 ms extra time.
> When writing large files (for example u-boot is usually 512 KB) this delay
> adds up to minutes.
> See Documentation/timers/timers-howto.txt "Why not msleep for (1ms - 20ms)".
> 
> Signed-off-by: Luca Ellero <luca.ellero@brickedbrain.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/devices/mtd_dataflash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
> index aaaeaae..3a6f450 100644
> --- a/drivers/mtd/devices/mtd_dataflash.c
> +++ b/drivers/mtd/devices/mtd_dataflash.c
> @@ -140,7 +140,7 @@ static int dataflash_waitready(struct spi_device *spi)
>  		if (status & (1 << 7))	/* RDY/nBSY */
>  			return status;
>  
> -		msleep(3);
> +		usleep_range(3000, 4000);
>  	}
>  }
>  
