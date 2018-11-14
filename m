Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04FC2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04FC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbeKOAEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:04:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37531 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbeKOAEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:04:47 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C7FA20747; Wed, 14 Nov 2018 15:01:24 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4DDBC206A1;
        Wed, 14 Nov 2018 15:01:24 +0100 (CET)
Date:   Wed, 14 Nov 2018 15:01:23 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to is25lp256
Message-ID: <20181114150123.65623741@bbrezillon>
In-Reply-To: <1542200118-3024-1-git-send-email-liu.xiang6@zte.com.cn>
References: <1542200118-3024-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 20:55:18 +0800
Liu Xiang <liu.xiang6@zte.com.cn> wrote:

> The is25lp256 supports 4-byte opcodes and quad output.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

This one looks good. Tudor, can you have a look?

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 3e54e31..3eba13a 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1357,7 +1357,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256,
>  			SECT_4K | SPI_NOR_DUAL_READ) },
>  	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512,
> -			SECT_4K | SPI_NOR_DUAL_READ) },
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128,

