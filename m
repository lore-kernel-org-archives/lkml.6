Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F167AECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58E420685
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58E420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbeISWBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:01:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:62177 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731866AbeISWBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:01:51 -0400
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="19844994"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Sep 2018 09:23:07 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 19 Sep 2018 09:23:07 -0700
Subject: Re: [RESEND PATCH 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <marek.vasut@gmail.com>, <frieder.schrempf@exceet.de>,
        <cyrille.pitchen@wedev4u.fr>, <computersforpeace@gmail.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537332608-19561-3-git-send-email-yogeshnarayan.gaur@nxp.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <b5858a4e-617a-4b06-8743-521e20489268@microchip.com>
Date:   Wed, 19 Sep 2018 19:23:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1537332608-19561-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/19/2018 07:50 AM, Yogesh Gaur wrote:
> Add entry for mt35xu512aba Micron NOR flash.
> This flash is having uniform sector erase size of 128KB, have
> support of FSR(flag status register), flash size is 64MB and
> supports 4-byte commands.
> 

Seems that the datasheet for mt35xu512aba is not public, I couldn't verify your
statement.

> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 33a55bc..6042df8 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1113,6 +1113,9 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>  	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>  
> +	/* Micron */
> +	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },

nitpick on style: Brian picked a style that seems reasonable for splitting up
the flags, see 9648388fc7737365be7a8092e77df78ccc2cd1a4.

Best,
ta
