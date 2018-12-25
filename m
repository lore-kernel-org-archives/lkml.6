Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A15C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED252177E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="xTvsvrIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbeLYPt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 10:49:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40513 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbeLYPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 10:49:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so12280235lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rG215W49zHwcElAp6dZ9fE0IBh72Qk261pFsNwoGcwE=;
        b=xTvsvrIN6baLbcL1SxpeC8ad5kx+zpGwyQ3d0ckUgrg417O8HOZVesFutNivqrSlYa
         ep328uRJCboHeMMqaz/IgtiOalkGoMkRVG0rr2+WVyafcH6gUqLa1vg4akcX3+OuTqbY
         qkJ+TEYD8ZRzwOCh5XcsbMjI7PKHJ1NbxhakZ3vSKWtN1JNmmX1FidmRDt8kAzmq5icy
         UpSt2Pqo/mv02s1Rxb2cegQzNvH0ed4mjgVbcgTJeOeHdSQ136K2Vt7fGTJ2+NFzKqrL
         4Wjn/7UHvHefAY+XNXJ6Ow7bFEZIgpuO/sJYVzyOG+5Pvq9PX7w84MXe+Xy0UvbgGUVs
         CPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rG215W49zHwcElAp6dZ9fE0IBh72Qk261pFsNwoGcwE=;
        b=DwyqNMhR5mPz8oTBNrOksvfdtDEPG0z4H5gtlCzXRUa6poJWZQeNN7htOJfYxPU9S1
         mGROFhBh+JTJHd0TVgriQZhLW6Y0ADFAqG2knNg8EjL2SrmXvJPdIy/MoLFgaFZhoDiq
         ONtIbR4xUNPNwooXVhT+sXBn+jDEBZagTjd0gmvzQftsRFQJzgnQzmDFWmlIMpUYcK5t
         VGQWnq4wVQ1nXsPaDkceSJwV29jyjVqq0MnnEslRypxp8mrpHMK0OcWhBkSu01UycMtJ
         SBjEkktM/CfR5t71tA/dG9muV8dCl6Q8gScu+s7bmsF3Nzt7jumpgE5CWJlkGhWTMZ/h
         q7+Q==
X-Gm-Message-State: AJcUukeGY5u8ihkJf561Lq1vGhQAOzEUEg8NGSZ76j8okT6v/V46C3Rj
        JKmwGjfZjbfo+YfOpO64z5zKLg==
X-Google-Smtp-Source: ALg8bN4cikb77oU4JKb2HomFXISKnw1zh421utq2dBVXvzyynpaLOIh3nelHWvlhXQBhRKpzjefgZA==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr10677010ljj.18.1545752993024;
        Tue, 25 Dec 2018 07:49:53 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.22])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7061388ljg.56.2018.12.25.07.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 07:49:52 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
 <1545634358-17485-2-git-send-email-masonccyang@mxic.com.tw>
Organization: Cogent Embedded
Message-ID: <12cb2574-8ec9-d756-756a-d7fbbd5c7069@cogentembedded.com>
Date:   Tue, 25 Dec 2018 18:49:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1545634358-17485-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/2018 09:52 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/spi/Kconfig           |   6 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-renesas-rpc.c | 788 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 795 insertions(+)
>  create mode 100644 drivers/spi/spi-renesas-rpc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 7d3a5c9..54b40f8 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -528,6 +528,12 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>  
> +config SPI_RENESAS_RPC
> +	tristate "Renesas R-Car Gen3 RPC SPI controller"

   Well, technically it's called RPC-IF in the manual, not just RPC...

> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	help
> +	  SPI driver for Renesas R-Car Gen3 RPC.
> +
>  config SPI_QCOM_QSPI
>  	tristate "QTI QSPI controller"
>  	depends on ARCH_QCOM
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..6dd739a
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,788 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2018 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC SPI/QSPI/Octa driver
> +//
> +// Authors:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define RPC_CMNCR		0x0000	/* R/W */
> +#define RPC_CMNCR_MD		BIT(31)
> +#define RPC_CMNCR_SFDE		BIT(24) /* undocumented bit but must be set */
> +#define RPC_CMNCR_MOIIO3(val)	(((val) & 0x3) << 22)
> +#define RPC_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
> +#define RPC_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
> +#define RPC_CMNCR_MOIIO0(val)	(((val) & 0x3) << 16)
> +#define RPC_CMNCR_MOIIO_HIZ	(RPC_CMNCR_MOIIO0(3) | RPC_CMNCR_MOIIO1(3) | \
> +				 RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
> +#define RPC_CMNCR_IO3FV(val)	(((val) & 0x3) << 14)
> +#define RPC_CMNCR_IO2FV(val)	(((val) & 0x3) << 12)

   Like I said, the above 2 aren't documented in the manual v1.00...

> +#define RPC_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)

   Only this one is...

[...]
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	/*
> +	 * NOTE: The 0x260 are undocumented bits, but they must be set.
> +	 *	RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	 *	0x0 : the delay is biggest,
> +	 *	0x1 : the delay is 2nd biggest,
> +	 *	On H3 ES1.x, the value should be 0, while on others,
> +	 *	the value should be 6.
> +	 */
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	/*
> +	 * NOTE: The 0x31511144 are undocumented bits, but they must be set
> +	 *       for RPC_PHYOFFSET1.
> +	 *	 The 0x31 are undocumented bits, but they must be set
> +	 *	 for RPC_PHYOFFSET2.
> +	 */
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1, 0x31511144);

  0x30000000 is documented, missed that last time...

[...]
> +static int rpc_spi_do_reset(struct rpc_spi *rpc)
> +{
> +	int ret;
> +
> +	ret = reset_control_reset(rpc->rstc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

   Like I said, this function folds to a mere reset_control_reset() call...

[...]
> +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> +			   const void *tx_buf, void *rx_buf)
> +{
> +	u32 smenr, smcr, data, pos = 0;
> +	int ret = 0;

   Looks like we don't need this variable...

> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +				  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +				  RPC_CMNCR_BSZ(0));
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> +	regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
[...]
> +	} else if (rx_buf) {
> +		smenr = rpc->smenr;

   Could be done before the *if*...

> +
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen - pos;
> +
> +			if (nbytes > 4)
> +				nbytes = 4;
> +
> +			smcr = rpc->smcr | RPC_SMCR_SPIE;
> +
> +			if (rpc->xferlen > 4 && rpc->xferlen < 8 && pos == 0)
> +				smcr |= RPC_SMCR_SSLKP;
> +
> +			regmap_write(rpc->regmap, RPC_SMENR, smenr);
> +			regmap_write(rpc->regmap, RPC_SMCR, smcr);
> +			ret = wait_msg_xfer_end(rpc);
> +			if (ret)
> +				goto out;
> +
> +			regmap_read(rpc->regmap, RPC_SMRDR0, &data);
> +			memcpy(rx_buf + pos, &data, nbytes);
> +			pos += nbytes;
> +
> +			if (rpc->xferlen > 4 && rpc->xferlen < 8 && pos == 4) {

   This looks hackish. What I think matters is whether the address bits are set or not.
Anyway, maybe it works OK for you but not for me (on V3H), the 4th byte of the JEDEC ID
is clobbered from 0 to 3... I've been working on a better workaround using Marek's
approach (reading in extended memory mode) -- should port to v4 of your patch yet...

> +				smenr = rpc->smenr & ~RPC_SMENR_CDE &
> +					~RPC_SMENR_ADE(0xf);
> +			} else {
> +				regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +				regmap_write(rpc->regmap, RPC_SMDMCR,
> +					     rpc->dummy);

   Not sure why you rewrite these regs again. Where do they change?

> +				regmap_write(rpc->regmap, RPC_SMADR,
> +					     rpc->addr + pos);
> +			}
> +		}
> +	} else {
> +		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	return ret;

   Could be *return* 0, we never get here from an error path...

> +
> +out:
> +	return rpc_spi_do_reset(rpc);
> +}
> +
> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(spi->master);
> +
> +	rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
> +	rpc->smenr = RPC_SMENR_CDE |
> +		     RPC_SMENR_CDB(ilog2(op->cmd.buswidth));
> +	rpc->totalxferlen = 1;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +	rpc->xferlen = 0;
> +	rpc->addr = 0;
> +
> +	if (op->addr.nbytes) {
> +		rpc->smenr |= RPC_SMENR_ADB(ilog2(op->addr.buswidth));
> +		if (op->addr.nbytes == 4)
> +			rpc->smenr |= RPC_SMENR_ADE(0xf);
> +		else
> +			rpc->smenr |= RPC_SMENR_ADE(0x7);
> +
> +		if (offs && len)
> +			rpc->addr = *offs;
> +		else
> +			rpc->addr = op->addr.val;
> +		rpc->totalxferlen += op->addr.nbytes;
> +	}
> +
> +	if (op->dummy.nbytes) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
> +		rpc->totalxferlen += op->dummy.nbytes;
> +	}
> +
> +	if (op->data.nbytes || (offs && len)) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			rpc->smcr = RPC_SMCR_SPIRE;
> +			rpc->xfer_dir = SPI_MEM_DATA_IN;
> +		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
> +			rpc->smcr = RPC_SMCR_SPIWE;
> +			rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +		}

   Use *switch* instead, please.

[...]
> +static bool rpc_spi_mem_supports_op(struct spi_mem *mem,
> +				    const struct spi_mem_op *op)
> +{
> +	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
> +	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
> +	    op->addr.nbytes > 4)
> +		return false;

   So we support the dual mode, even though the manual doesn't say we do?

> +
> +	return true;
> +}
> +
> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +				       u64 offs, size_t len, void *buf)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +	int ret;
> +
> +	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
> +		return -EINVAL;
> +
> +	if (WARN_ON(len > 0x4000000))
> +		return -EIO;

   Why not read what can still be read and return 0x4000000?

> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_SFDE |
> +		     RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +		     RPC_CMNCR_BSZ(0));

   Why not set this in the probing time and only set/clear the MD bit?

[...]
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +	int ret;
> +
> +	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
> +		return -EINVAL;
> +
> +	if (WARN_ON(len > RPC_WBUF_SIZE))
> +		len = RPC_WBUF_SIZE;
> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +				  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +				  RPC_CMNCR_BSZ(0));
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL | 0x260 |
> +				  RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
> +
> +	memcpy_toio(rpc->base + RPC_WBUF, buf, len);
> +
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMADR, offs);
> +	regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +	regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +	ret = wait_msg_xfer_end(rpc);
> +	if (ret)
> +		goto out;
> +
> +	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(6) | 0x260);

   Whe not do read-modify-write here and above?

[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
[...]
> +	for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
> +		if (xfer[i].rx_buf) {
> +			rpc->smenr |=
> +				RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
> +				RPC_SMENR_SPIDB
> +				(ilog2((unsigned int)xfer[i].rx_nbits));

   Mhm, I would indent this contination line by 1 extra tab...

> +		} else if (xfer[i].tx_buf) {
> +			rpc->smenr |=
> +				RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
> +				RPC_SMENR_SPIDB
> +				(ilog2((unsigned int)xfer[i].tx_nbits));

   And this one...

[...]
> +#ifdef CONFIG_PM_SLEEP
> +static int rpc_spi_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);

   Ugh... not sure how i missed it the last time. :-/ Please, just do this:

	struct spi_master *master = dev_get_drvdata(dev);

> +
> +	return spi_master_suspend(master);
> +}
> +
> +static int rpc_spi_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);

   Likewise...

[...]

MBR, Sergei
