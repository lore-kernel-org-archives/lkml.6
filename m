Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF70C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349F62089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349F62089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJPTuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:50:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPTuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:50:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 895C02079D; Tue, 16 Oct 2018 13:59:53 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 42E91206A1;
        Tue, 16 Oct 2018 13:59:43 +0200 (CEST)
Date:   Tue, 16 Oct 2018 13:59:43 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: denali: include <linux/bits.h> instead of
 <linux/bitops.h>
Message-ID: <20181016135943.75655316@bbrezillon>
In-Reply-To: <1539664401-17651-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539664401-17651-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 13:33:21 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> The reason of including <linux/bitops.h> here is just for BIT() and
> GENMASK macros.
> 
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> 
>  drivers/mtd/nand/raw/denali.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
> index 57a5498..25c0060 100644
> --- a/drivers/mtd/nand/raw/denali.h
> +++ b/drivers/mtd/nand/raw/denali.h
> @@ -7,7 +7,7 @@
>  #ifndef __DENALI_H__
>  #define __DENALI_H__
>  
> -#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/completion.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/spinlock_types.h>

