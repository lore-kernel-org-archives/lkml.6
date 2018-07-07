Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1D223B8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D1D223B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753810AbeGGKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:09:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51926 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbeGGKJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:09:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CBEA7207AB; Sat,  7 Jul 2018 12:09:01 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7909320741;
        Sat,  7 Jul 2018 12:09:01 +0200 (CEST)
Date:   Sat, 7 Jul 2018 12:09:02 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] mtd: stm32-quadspi: replace "%p" with "%pK"
Message-ID: <20180707120902.0ae0b881@bbrezillon>
In-Reply-To: <20180706130525.22223-1-benjamin.gaignard@st.com>
References: <20180706130525.22223-1-benjamin.gaignard@st.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 15:05:25 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Applied.

Thanks,

Boris

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

