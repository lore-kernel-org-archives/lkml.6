Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbeBLVWW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:22:22 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:34559 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754067AbeBLVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:22:21 -0500
Date: Mon, 12 Feb 2018 22:22:08 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: MTD_NAND_MARVELL should depend on HAS_DMA
Message-ID: <20180212222208.39324af1@bbrezillon>
In-Reply-To: <1517318601-14793-1-git-send-email-geert@linux-m68k.org>
References: <1517318601-14793-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018 14:23:21 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> If NO_DMA=y:
> 
>     ERROR: "bad_dma_ops" [drivers/mtd/nand/marvell_nand.ko] undefined!
> 
> Add a dependency on HAS_DMA to fix this.

Applied.

Thanks,

Boris

> 
> Fixes: 02f26ecf8c772751 ("mtd: nand: add reworked Marvell NAND controller driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index e6b8c59f2c0da7c0..736ac887303c88ba 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -328,7 +328,7 @@ config MTD_NAND_MARVELL
>  	tristate "NAND controller support on Marvell boards"
>  	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
>  		   COMPILE_TEST
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && HAS_DMA
>  	help
>  	  This enables the NAND flash controller driver for Marvell boards,
>  	  including:



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
