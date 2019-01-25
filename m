Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBABB218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAYNPI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50466 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAYNPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6D858209BE; Fri, 25 Jan 2019 14:15:06 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2A22D20397;
        Fri, 25 Jan 2019 14:14:56 +0100 (CET)
Date:   Fri, 25 Jan 2019 14:14:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: rawnand: denali: remove unused dma_addr field from
 denali_nand_info
Message-ID: <20190125141456.14222432@xps13>
In-Reply-To: <1548311337-16851-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548311337-16851-1-git-send-email-yamada.masahiro@socionext.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu, 24 Jan
2019 15:28:57 +0900:

> This is a leftover of commit 997cde2a2220 ("mtd: nand: denali: skip
> driver internal bounce buffer when possible").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mtd/nand/raw/denali.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
> index 25c0060..c8c2620 100644
> --- a/drivers/mtd/nand/raw/denali.h
> +++ b/drivers/mtd/nand/raw/denali.h
> @@ -304,7 +304,6 @@ struct denali_nand_info {
>  	u32 irq_status;			/* interrupts that have happened */
>  	int irq;
>  	void *buf;			/* for syndrome layout conversion */
> -	dma_addr_t dma_addr;
>  	int dma_avail;			/* can support DMA? */
>  	int devs_per_cs;		/* devices connected in parallel */
>  	int oob_skip_bytes;		/* number of bytes reserved for BBM */

Applied to nand/next.


Thanks,
Miquèl
