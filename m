Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeA3NrB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:47:01 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:42203 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeA3Nq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:46:59 -0500
Date: Tue, 30 Jan 2018 14:46:47 +0100
From: Miquel Raynal <miquel.raynal@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: MTD_NAND_MARVELL should depend on HAS_DMA
Message-ID: <20180130144647.73a44b8d@xps13>
In-Reply-To: <1517318601-14793-1-git-send-email-geert@linux-m68k.org>
References: <1517318601-14793-1-git-send-email-geert@linux-m68k.org>
Organization: Free Electrons
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, 30 Jan 2018 14:23:21 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> If NO_DMA=y:
> 
>     ERROR: "bad_dma_ops" [drivers/mtd/nand/marvell_nand.ko] undefined!
> 
> Add a dependency on HAS_DMA to fix this.
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

I think this is more a coding issue than a Kconfig issue. AFAIR, none
of the ARCH_MVEBU SoCs use DMA in conjunction with the NAND controller.
PXA SoCs may use DMA (NFCv1 only) but this is not a hard requirement and
the driver is supposed to support PIO mode in all situations.

Can you please share your setup, the SoC, the configuration,
maybe also the DT?


Thanks,
Miquèl
