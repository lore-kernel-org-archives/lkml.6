Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A468C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC6621783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="NkXqZC8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfAISry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:47:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfAISrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:47:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so7415215ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZzUeTH3aKEy/Kko/t/IzP8y/JriD9Xgf/NsDi8JA0wM=;
        b=NkXqZC8US7CpV6pM+SZDXnnHQLrILNUcTnNiedZysakkK5hiOJiyFx+eU9XnseRe3Q
         8fq5vYLL0MEt7PMjnpmveyBltoz+y2w59OBRtbTC0FW5v/D17k6/PFKP4hSfZ4bqmi8O
         Gn9cDk2sHwl83Kg5bIYDY0GEW0g9wccl8biMg/R6S6dX8TcDMQGqBs4ChUbR05+w2BfN
         GlwnoI+d8Gs2RVKljfcIO5TAgeZdfHRnmmXsDcNOjWY2I2mxYpheeNvE4MgX3xa53Iiu
         S7+QGEF+YkJChQ1nnTMuKIlCoe5i4721eh/QmwcGt5mr0WQshQgQdIdOgXP9V020Emf5
         ObqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZzUeTH3aKEy/Kko/t/IzP8y/JriD9Xgf/NsDi8JA0wM=;
        b=jt6Tc+hBX5UVtxfOvEmLFr6WVUrc3QRNjWZBMPzy+KopdDQGEP2M3xMxLb27gHuYj1
         IJNr5pPZKoSRyL+W1VjNKbuRHVYV+SZ22Jrdr9tNb05i0oeTff4XVFKy7MQSbGDOUH42
         K/F6toyMbcwWeU7vSYQ19ss48D7GVGbiLsJcecjAbpECljjdXi/+01QVIQXKBQz3V21Y
         z+ucqLGDVJfbBhYzipL2DX5x63YZ/QXWe1I0UX9+MB9kBRJxfooC44FWa4W6Fz82uPwP
         W5NPGMRTsmZRgkiVavmOABuUuf3f8XHR0Vi5CSAip+Rjh9GMbOzF1VsOi2it2m4bxBik
         kksg==
X-Gm-Message-State: AJcUukdadagbmtYfEcQevv/Ia+xfjyx2SeGtr87ozrJ3wvyUf90y3HVu
        HDc2bABkn+rdaQdP/pC0vSeUCQ==
X-Google-Smtp-Source: ALg8bN4cGyZNiGDlhEkviPwI1xy16pk9JEqySwi4MTYvWXqcCEQ3yTWwP9ykGzjjH6OzvrhCo0QIQQ==
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr3982308ljc.131.1547059670703;
        Wed, 09 Jan 2019 10:47:50 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.211])
        by smtp.gmail.com with ESMTPSA id d2sm14072864lfg.16.2019.01.09.10.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 10:47:49 -0800 (PST)
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
Date:   Wed, 9 Jan 2019 21:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/08/2019 07:16 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

   You now need to add:

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>  drivers/spi/Kconfig           |   6 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-renesas-rpc.c | 787 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 794 insertions(+)
>  create mode 100644 drivers/spi/spi-renesas-rpc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9f89cb1..81b4e04 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -544,6 +544,12 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>  
> +config SPI_RENESAS_RPC_IF

   Since the driver is called without -IF suffix, I wouldn't use it in the
Kconfig name either, the following is enough:

> +	tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST

   Judging on the compilation error reported by the 0-day bot about readq(),
we now need to depend on 64BIT or something...

[...]
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f296270..3f2b2f9 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..1e57eb1
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,787 @@
[...]
> +#define RPC_CMNCR		0x0000	// R/W
> +#define RPC_CMNCR_MD		BIT(31)
> +#define RPC_CMNCR_SFDE		BIT(24) // undocumented bit but must be set
> +#define RPC_CMNCR_MOIIO3(val)	(((val) & 0x3) << 22)
> +#define RPC_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
> +#define RPC_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
> +#define RPC_CMNCR_MOIIO0(val)	(((val) & 0x3) << 16)
> +#define RPC_CMNCR_MOIIO_HIZ	(RPC_CMNCR_MOIIO0(3) | RPC_CMNCR_MOIIO1(3) | \
> +				 RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
> +#define RPC_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) // undocumented bit
> +#define RPC_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) // undocumented bit

   Those are not exactly bits. I'd be happy with just // undocumented...

[...]
> +#define RPC_WBUF		0x8000	// Write Buffer
> +#define RPC_WBUF_SIZE		256	// Write Buffer size

   I wonder if the write buffer should be in a separate "reg" prop tuple...
Have you considered that?

[...]
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	//
> +	// NOTE: The 0x260 are undocumented bits, but they must be set.
> +	//	RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	//	0x0 : the delay is biggest,
> +	//	0x1 : the delay is 2nd biggest,
> +	//	On H3 ES1.x, the value should be 0, while on others,
> +	//	the value should be 6.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +		     RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	//
> +	// NOTE: The 0x1511144 are undocumented bits, but they must be set
> +	//       for RPC_PHYOFFSET1.
> +	//	 The 0x31 are undocumented bits, but they must be set
> +	//	 for RPC_PHYOFFSET2.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1,
> +		     RPC_PHYOFFSET1_DDRTMG(3) | 0x1511144);
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> +		     RPC_PHYOFFSET2_OCTTMG(4));

   I still would have preferred using regmap_update_bits() here...

[...]
> +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> +			   const void *tx_buf, void *rx_buf)
> +{
[...]
> +	} else if (rx_buf) {
> +		//
> +		// RPC-IF spoils the data for the commands without an address
> +		// phase (like RDID) in the manual mode, so we'll have to work
> +		// around this issue by using the external address space read
> +		// mode instead; we seem to be able to read 8 bytes at most in
> +		// this mode though...
> +		//
> +		if (!(smenr & RPC_SMENR_ADE(0xf))) {
> +			u32 nbytes = rpc->xferlen - pos;
> +			u64 tmp;
> +
> +			if (nbytes > 8)
> +				nbytes = 8;
> +
> +			regmap_update_bits(rpc->regmap, RPC_CMNCR,
> +					   RPC_CMNCR_MD, 0);
> +			regmap_write(rpc->regmap, RPC_DRCR, 0);
> +			regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
> +			regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
> +			regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
> +			regmap_write(rpc->regmap, RPC_DROPR, 0);
> +			regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr &
> +				     ~RPC_SMENR_SPIDE(0xf));

   The 'smenr' filed needs a more universal name -- it's written to both SMENR and DRENR?

> +	} else {
> +		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	return ret;

   We always return 0 here...

> +
> +out:

   I'd call this label error, since this is our error path...

> +	return reset_control_reset(rpc->rstc);
> +}
> +
> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
[...]
> +	if (op->data.nbytes || (offs && len)) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			rpc->smcr = RPC_SMCR_SPIRE;
> +			rpc->xfer_dir = SPI_MEM_DATA_IN;
> +		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
> +			rpc->smcr = RPC_SMCR_SPIWE;
> +			rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +		}

   I asked for *switch* above...

[...]
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
[...]
> +	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
> +
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL | 0x260 |
> +				  RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);

   regmap_update_bits()?

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

  Same here...

> +
> +	return len;
> +
> +out:

error:

> +	return reset_control_reset(rpc->rstc);
> +}
[...]

MBR, Sergei
