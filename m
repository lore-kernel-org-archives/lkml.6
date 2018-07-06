Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F15224004
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F15224004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933069AbeGFOor (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:44:47 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33008 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeGFOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:44:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6A8A6093339;
        Fri,  6 Jul 2018 16:44:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DvSI3GZWKt_C; Fri,  6 Jul 2018 16:44:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 72558609333C;
        Fri,  6 Jul 2018 16:44:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uRjBrUWut8Pc; Fri,  6 Jul 2018 16:44:45 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 49DE66093339;
        Fri,  6 Jul 2018 16:44:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] mtd: stm32-quadspi: replace "%p" with "%pK"
Date:   Fri, 06 Jul 2018 16:44:44 +0200
Message-ID: <32602293.7BQn8HeLUA@blindfold>
In-Reply-To: <20180706130525.22223-1-benjamin.gaignard@st.com>
References: <20180706130525.22223-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Juli 2018, 15:05:25 CEST schrieb Benjamin Gaignard:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

Does %pK really make sense for dev_dbg()?
When the driver is being debugged "leaking" is on purpose. :)

Thanks,
//richard
 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/mtd/spi-nor/stm32-quadspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
> index 72553506a00b..13e9fc961d3b 100644
> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
> @@ -355,7 +355,7 @@ static int stm32_qspi_read_reg(struct spi_nor *nor,
>  	struct device *dev = flash->qspi->dev;
>  	struct stm32_qspi_cmd cmd;
>  
> -	dev_dbg(dev, "read_reg: cmd:%#.2x buf:%p len:%#x\n", opcode, buf, len);
> +	dev_dbg(dev, "read_reg: cmd:%#.2x buf:%pK len:%#x\n", opcode, buf, len);
>  
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.opcode = opcode;
> @@ -376,7 +376,7 @@ static int stm32_qspi_write_reg(struct spi_nor *nor, u8 opcode,
>  	struct device *dev = flash->qspi->dev;
>  	struct stm32_qspi_cmd cmd;
>  
> -	dev_dbg(dev, "write_reg: cmd:%#.2x buf:%p len:%#x\n", opcode, buf, len);
> +	dev_dbg(dev, "write_reg: cmd:%#.2x buf:%pK len:%#x\n", opcode, buf, len);
>  
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.opcode = opcode;
> @@ -398,7 +398,7 @@ static ssize_t stm32_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
>  	struct stm32_qspi_cmd cmd;
>  	int err;
>  
> -	dev_dbg(qspi->dev, "read(%#.2x): buf:%p from:%#.8x len:%#zx\n",
> +	dev_dbg(qspi->dev, "read(%#.2x): buf:%pK from:%#.8x len:%#zx\n",
>  		nor->read_opcode, buf, (u32)from, len);
>  
>  	memset(&cmd, 0, sizeof(cmd));
> 


