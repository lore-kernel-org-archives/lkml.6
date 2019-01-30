Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627AEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C74D20855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868873;
	bh=RQtcdk/R8L4tDjBvAw5e5DwzsQUK3bOrQIKxSFHlHu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RDxiuAEu49aKJOHrMgqpCouiPTV7y5AHkJZKTkZkGQg0DZwHF6oGgL/UUgTdFmiBU
	 QTO4aEyhNogBeAh9l8RR+CWbgmIBNuoNQ3zc1VrT6YLWtuiZVt/DaaslNxg2cNDqtX
	 W3b1oKhwmzh+hkQxRxPsSa0aDHOW8Vq6QBvM7ako=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfA3RVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfA3RVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:21:11 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0761F20855;
        Wed, 30 Jan 2019 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548868870;
        bh=RQtcdk/R8L4tDjBvAw5e5DwzsQUK3bOrQIKxSFHlHu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PMTX5C9QwHmQCdUbNV1tS5hkrkyl2TLbnUCvHPaqWu1H8n3ljG4z399fsxhxTKEee
         rXc+shwkMegZqMajh6yneZf6LR48ne6E0Dy8MgblH1OtaYWb7A0+EGpGnJ+sSSrhel
         b28LO+l/5kAj77HWehuXmCGELXTgwyT8oDWx1rAc=
Date:   Wed, 30 Jan 2019 18:21:00 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/9] spi: atmel-quadspi: return appropriate error code
Message-ID: <20190130182100.3429fa36@bbrezillon>
In-Reply-To: <20190130150818.24902-6-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-6-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:38 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Return -ENOTSUPP when atmel_qspi_find_mode() fails. Propagate
> the error in atmel_qspi_exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/spi/atmel-quadspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 3643f0c851b0..e6de6e3d1345 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -208,7 +208,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
>  		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
>  			return i;
>  
> -	return -1;
> +	return -ENOTSUPP;
>  }
>  
>  static bool atmel_qspi_supports_op(struct spi_mem *mem,
> @@ -239,7 +239,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
> -		return -ENOTSUPP;
> +		return mode;
>  
>  	ifr |= sama5d2_qspi_modes[mode].config;
>  

