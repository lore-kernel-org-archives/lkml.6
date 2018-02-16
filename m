Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBPTef (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:34:35 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:60211 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753722AbeBPTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:26 -0500
Date: Fri, 16 Feb 2018 20:19:23 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/6] nand: davinci: rename the platform driver
Message-ID: <20180216201923.16bfca7f@bbrezillon>
In-Reply-To: <20180216164712.25898-2-brgl@bgdev.pl>
References: <20180216164712.25898-1-brgl@bgdev.pl>
        <20180216164712.25898-2-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 17:47:07 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
> lookup table") broke the nand support in board file mode for
> da850-based boards. Instead of reverting it and breaking the DT users
> in the process (due to clock lookup), rename the driver to match the
> clock table before renaming the users.
> 
> Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/mtd/nand/davinci_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> index ccc8c43abcff..4fb143bf1872 100644
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
> @@ -865,7 +865,7 @@ static struct platform_driver nand_davinci_driver = {
>  	.probe		= nand_davinci_probe,
>  	.remove		= nand_davinci_remove,
>  	.driver		= {
> -		.name	= "davinci_nand",
> +		.name	= "davinci-nand",

Another side-effect of this change you should be aware of: by doing
that you also break all users that were defining partitions through the
cmdline using mtdparts=davinci_nand.0:<part-layout>.

Not sure this is a good idea ;-).

>  		.of_match_table = of_match_ptr(davinci_nand_of_match),
>  	},
>  };



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
