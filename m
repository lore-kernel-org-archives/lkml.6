Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeCRVPj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:15:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39436 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754121AbeCRVPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:15:35 -0400
Date: Sun, 18 Mar 2018 22:15:23 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Peter Pan <peterpandong@micron.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd: nand: remove STANDALONE compile mode of nand_ecc
Message-ID: <20180318221523.1b47aefc@bbrezillon>
In-Reply-To: <1520600632-24955-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520600632-24955-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 22:03:52 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This file can not be built independently any more.  We would have to
> bring in more to resolve mtd_to_nand(mtd)->ecc.size, for example.
> 
> It is difficult to notice a breakage since nobody compiles this mode.
> It is not worth fixing or maintaining in my opinion.  Remove.
> 

Applied.

Thanks,

Boris

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mtd/nand/raw/nand_ecc.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
> index 3630f0f..8e132ed 100644
> --- a/drivers/mtd/nand/raw/nand_ecc.c
> +++ b/drivers/mtd/nand/raw/nand_ecc.c
> @@ -28,15 +28,6 @@
>   *
>   */
>  
> -/*
> - * The STANDALONE macro is useful when running the code outside the kernel
> - * e.g. when running the code in a testbed or a benchmark program.
> - * When STANDALONE is used, the module related macros are commented out
> - * as well as the linux include files.
> - * Instead a private definition of mtd_info is given to satisfy the compiler
> - * (the code does not use mtd_info, so the code does not care)
> - */
> -#ifndef STANDALONE
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -44,17 +35,6 @@
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/nand_ecc.h>
>  #include <asm/byteorder.h>
> -#else
> -#include <stdint.h>
> -struct mtd_info;
> -#define EXPORT_SYMBOL(x)  /* x */
> -
> -#define MODULE_LICENSE(x)	/* x */
> -#define MODULE_AUTHOR(x)	/* x */
> -#define MODULE_DESCRIPTION(x)	/* x */
> -
> -#define pr_err printf
> -#endif
>  
>  /*
>   * invparity is a 256 byte table that contains the odd parity



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
