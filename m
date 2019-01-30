Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338F218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868817;
	bh=e1EgPBBSxkVBZIffLs813GMhAV6aodZH7KaCX9WAE4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hNHuEhsqeuhztveYnOYkHp5t9WrlhgXlRMFO6jghE12fylQRm2LRoo6V8yO8ueY9N
	 6rf4nkjNgUAtz6Yr2TC6qxymSKTwG2uGlCpheaG4dB8+Ch01SvBJTpPKU8YIPhwNpL
	 +/+eLoPoSBVL8NXrNSbjkMCZHszew/lOrkmm4no4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfA3RUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfA3RUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:20:14 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9352020855;
        Wed, 30 Jan 2019 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548868814;
        bh=e1EgPBBSxkVBZIffLs813GMhAV6aodZH7KaCX9WAE4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zws77S8+N9qMQti08li0S/tTA1HnIV0Xep42Ebch25pjgvPzkWvvORe8sc/amS6SS
         8bvLeHilIisDE2e4+xcw5S13WcQo3BRAyE/lpFtKpu2CWLlTeIjLoydBR8p35vHXaF
         3y7mcKeA+sTTD1dK88LGc2aeDZRw5gtfcWq5FG5o=
Date:   Wed, 30 Jan 2019 18:20:05 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/9] spi: atmel-quadspi: remove unnecessary cast
Message-ID: <20190130181955.48309a21@bbrezillon>
In-Reply-To: <20190130150818.24902-5-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-5-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:35 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The cast is done implicitly.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/spi/atmel-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index e156c345705b..3643f0c851b0 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -389,7 +389,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  
>  static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
>  {
> -	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
> +	struct atmel_qspi *aq = dev_id;
>  	u32 status, mask, pending;
>  
>  	status = atmel_qspi_readl(aq, QSPI_SR);

