Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164EF2414E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164EF2414E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeFVLhQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:37:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50325 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeFVLhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:37:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB4D420719; Fri, 22 Jun 2018 13:37:12 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7BB6E20012;
        Fri, 22 Jun 2018 13:37:02 +0200 (CEST)
Date:   Fri, 22 Jun 2018 13:37:02 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: dataflash: Use ULL suffix for 64-bit constants
Message-ID: <20180622133702.73698862@bbrezillon>
In-Reply-To: <20180622070425.26573-1-geert@linux-m68k.org>
References: <20180622070425.26573-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 09:04:25 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> With gcc 4.1.2 when compiling for 32-bit:
> 
>     drivers/mtd/devices/mtd_dataflash.c:736: warning: integer constant is too large for ‘long’ type
>     drivers/mtd/devices/mtd_dataflash.c:737: warning: integer constant is too large for ‘long’ type
> 
> Add the missing "ULL" suffixes to fix this.
> 
> Fixes: 67e4145ebf2c161d ("mtd: dataflash: Add flash_info for AT45DB641E")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied.

Thanks,

Boris

> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/mtd/devices/mtd_dataflash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
> index 3a6f450d1093c4c5..53febe8a68c3cdfa 100644
> --- a/drivers/mtd/devices/mtd_dataflash.c
> +++ b/drivers/mtd/devices/mtd_dataflash.c
> @@ -733,8 +733,8 @@ static struct flash_info dataflash_data[] = {
>  	{ "AT45DB642x",  0x1f2800, 8192, 1056, 11, SUP_POW2PS},
>  	{ "at45db642d",  0x1f2800, 8192, 1024, 10, SUP_POW2PS | IS_POW2PS},
>  
> -	{ "AT45DB641E",  0x1f28000100, 32768, 264, 9, SUP_EXTID | SUP_POW2PS},
> -	{ "at45db641e",  0x1f28000100, 32768, 256, 8, SUP_EXTID | SUP_POW2PS | IS_POW2PS},
> +	{ "AT45DB641E",  0x1f28000100ULL, 32768, 264, 9, SUP_EXTID | SUP_POW2PS},
> +	{ "at45db641e",  0x1f28000100ULL, 32768, 256, 8, SUP_EXTID | SUP_POW2PS | IS_POW2PS},
>  };
>  
>  static struct flash_info *jedec_lookup(struct spi_device *spi,

