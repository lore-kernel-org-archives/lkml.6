Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BDEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7083A20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7083A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeKFIXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:23:14 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59450 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725726AbeKFIXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:23:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E34EE207F4; Tue,  6 Nov 2018 00:01:09 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9B3892072A;
        Tue,  6 Nov 2018 00:00:59 +0100 (CET)
Date:   Tue, 6 Nov 2018 00:00:59 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Fix the return value in
 case of error in 'cqspi_direct_read_execute()'
Message-ID: <20181106000059.4cc1d10e@bbrezillon>
In-Reply-To: <20181016071346.25383-1-christophe.jaillet@wanadoo.fr>
References: <20181016071346.25383-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 09:13:46 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> We return 0 unconditionally in 'cqspi_direct_read_execute()'.
> However, 'ret' is set to some error codes in several error handling paths.
> 
> Return 'ret' instead to propagate the error code.
> 
> Fixes: ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Queued to the fixes branch after adjusting the subject to make it
shorter and adding a Cc-stable tag.

Thanks,

Boris

> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 8e714fbfa521..6e9cbd1a0b6d 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -996,7 +996,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
>  err_unmap:
>  	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,

