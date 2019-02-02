Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65263C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3403520863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549091549;
	bh=1Mup6wsAELPhiC4u7D1TximLwIdAuHu1xQPH9DRuJeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=L9JQRGG/9j3AJyRdnck6H7O71/ERlNORZAMtShivrj1xtR0awSPehrNzjQibs0V8d
	 x9F8fEN8WrxeYclcQUrjd1cg+YN7aCneSrvWmxhTYd9nOCyb5I5q7RbWmte1TsVgDu
	 K+enOBPhWPXiflJBIX1w+ceE30CjwMTUyZmUKmFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfBBHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfBBHM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:12:26 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4A520863;
        Sat,  2 Feb 2019 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549091545;
        bh=1Mup6wsAELPhiC4u7D1TximLwIdAuHu1xQPH9DRuJeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qg4JB9+AmCCK7hfjoFfJ4YFHkGC2dnYt86xFl/L/XjGN0141YAeMzAWCJnyilW+8k
         rNA5CzdKs+Cf2NKL+nh3AIftptLzj4srQqkqlSAn7pmOWXZWJjJrBJi0lUJOr0O9lF
         fX/CL83UD/bOh5gRsBMWUeQ6LSbepyeNmmQdUBU8=
Date:   Sat, 2 Feb 2019 08:12:11 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 04/13] spi: atmel-quadspi: fix naming scheme
Message-ID: <20190202081211.51aabc1f@bbrezillon>
In-Reply-To: <20190202040653.1217-5-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-5-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 04:07:22 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let general names to core drivers.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: no change
> v2: update after the removing of iomem access wrappers
> 
>  drivers/spi/atmel-quadspi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 131374db0db4..47ed751a91e7 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -158,14 +158,14 @@ struct atmel_qspi {
>  	struct completion	cmd_completion;
>  };
>  
> -struct qspi_mode {
> +struct atmel_qspi_mode {
>  	u8 cmd_buswidth;
>  	u8 addr_buswidth;
>  	u8 data_buswidth;
>  	u32 config;
>  };
>  
> -static const struct qspi_mode sama5d2_qspi_modes[] = {
> +static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
>  	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
>  	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
>  	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
> @@ -175,8 +175,8 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
>  };
>  
> -static inline bool is_compatible(const struct spi_mem_op *op,
> -				 const struct qspi_mode *mode)
> +static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
> +					    const struct atmel_qspi_mode *mode)
>  {
>  	if (op->cmd.buswidth != mode->cmd_buswidth)
>  		return false;
> @@ -190,12 +190,12 @@ static inline bool is_compatible(const struct spi_mem_op *op,
>  	return true;
>  }
>  
> -static int find_mode(const struct spi_mem_op *op)
> +static int atmel_qspi_find_mode(const struct spi_mem_op *op)
>  {
>  	u32 i;
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
> -		if (is_compatible(op, &sama5d2_qspi_modes[i]))
> +		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
>  			return i;
>  
>  	return -1;
> @@ -204,7 +204,7 @@ static int find_mode(const struct spi_mem_op *op)
>  static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  				   const struct spi_mem_op *op)
>  {
> -	if (find_mode(op) < 0)
> +	if (atmel_qspi_find_mode(op) < 0)
>  		return false;
>  
>  	/* special case not supported by hardware */
> @@ -234,7 +234,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		aq->smm = QSPI_MR_SMM;
>  	}
>  
> -	mode = find_mode(op);
> +	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
>  		return -ENOTSUPP;
>  

