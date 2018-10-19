Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3405CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0B21477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfYorxX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE0B21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeJSRJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:09:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34366 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJSRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:09:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so30763874eds.1;
        Fri, 19 Oct 2018 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KA9htHrno3EGRIlPEMRvgY5Uk5zhK82yBy0TmVMJfZo=;
        b=NfYorxX8PqN0QC/qepN+pH52wfrrJn9htWphEy2K+vpBzdXT3LyM3Wm6DGimbtBWg+
         bZzSMKZrung7ycVxOA6mEAEafmonAGjvQjAhp9yjhddbdIGkMx4FdHgvaLk57h1tubcV
         91Wyn3cSjJgo5O2VwI2VeomQ6B9Bvuuci7aadIa0XKZOxKaWFB0xioSf2G7eq+Pdr3qB
         zhpeS6PBKBq8+I97qopOEEXJToCLrJzsbUosLnaR0EIRlEJULsQ7fghEO3up1qCXiVw+
         tgcclmxdj4m7h9oTG57861IDTnIZu3skK3u5kBH1tzUvglJrzqjYjqRQGq83qiNEiELW
         fqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KA9htHrno3EGRIlPEMRvgY5Uk5zhK82yBy0TmVMJfZo=;
        b=TLNRRRbEo2DPF0JoWESUCehq/XHSqugWwWP52CVsEugtzWZc9YlpwjTUFQN/8F5O6/
         Y0aCv8FlK0Gs5BFKgrV2nFT6jdH915K8Dc3NMQ+nWZAB/CttAIzg35274HM+87y0UO97
         Eaw0rULz/qxyOPT1YJkNJJRdZe2Xbq99171OIA3cH7/OqK1WP+Z6cQVyk3J7W+ovWVs2
         sUR9ffTXh92Way2BmjEhhs0L9EON+14s5UaoHdG3Zm+FQzkTttkvACOEa90WCVBWUGSp
         /bLt1NAT3znIsnGnsxtx6T5lC6n09M3VOJy0jc6OhdpK8M59bPdiPR5LZ7eL7Z+VYRKs
         F3jw==
X-Gm-Message-State: ABuFfojfvXiwXwf8pCE1ditYHOlrPj7PVKfjvff21aGU0LdJ6gfgQRPN
        +WAL1Y01Tarn0qzbb+92sQc=
X-Google-Smtp-Source: ACcGV62dau5NAzeyCKySp0q7j+Y1qbiDGAOo1bMiZg9477NTnSS+6peGfUCiCaY4gucUncGoNLpIYw==
X-Received: by 2002:a17:906:6c13:: with SMTP id j19-v6mr30930757ejr.41.1539939846539;
        Fri, 19 Oct 2018 02:04:06 -0700 (PDT)
Received: from ziggy.stardust ([93.176.144.101])
        by smtp.gmail.com with ESMTPSA id c11-v6sm4814611ejr.6.2018.10.19.02.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 02:04:05 -0700 (PDT)
Subject: Re: [PATCH 5/6] mmc: mediatek: add MT8183 MMC driver support
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, jjian.zhou@mediatek.com,
        wenbin.mei@mediatek.com
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
 <1539415250-32337-6-git-send-email-chaotian.jing@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <f633e2b0-39f3-288d-c5d5-2d4b27d8e824@gmail.com>
Date:   Fri, 19 Oct 2018 11:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539415250-32337-6-git-send-email-chaotian.jing@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/10/2018 09:20, Chaotian Jing wrote:
> MT8183 puts the tune register at top layer, so need add new code
> to support it.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 283 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 233 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 09d7e44..5b26f2f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -87,6 +87,13 @@
>  #define SDC_FIFO_CFG     0x228
>  
>  /*--------------------------------------------------------------------------*/
> +/* Top Pad Register Offset                                                  */
> +/*--------------------------------------------------------------------------*/
> +#define EMMC_TOP_CONTROL	0x00
> +#define EMMC_TOP_CMD		0x04
> +#define EMMC50_PAD_DS_TUNE	0x0c
> +
> +/*--------------------------------------------------------------------------*/
>  /* Register Mask                                                            */
>  /*--------------------------------------------------------------------------*/
>  
> @@ -261,6 +268,23 @@
>  #define SDC_FIFO_CFG_WRVALIDSEL   (0x1 << 24)  /* RW */
>  #define SDC_FIFO_CFG_RDVALIDSEL   (0x1 << 25)  /* RW */
>  
> +/* EMMC_TOP_CONTROL mask */
> +#define PAD_RXDLY_SEL           (0x1 << 0)      /* RW */
> +#define DELAY_EN                (0x1 << 1)      /* RW */
> +#define PAD_DAT_RD_RXDLY2       (0x1f << 2)     /* RW */
> +#define PAD_DAT_RD_RXDLY        (0x1f << 7)     /* RW */
> +#define PAD_DAT_RD_RXDLY2_SEL   (0x1 << 12)     /* RW */
> +#define PAD_DAT_RD_RXDLY_SEL    (0x1 << 13)     /* RW */
> +#define DATA_K_VALUE_SEL        (0x1 << 14)     /* RW */
> +#define SDC_RX_ENH_EN           (0x1 << 15)     /* TW */
> +
> +/* EMMC_TOP_CMD mask */
> +#define PAD_CMD_RXDLY2          (0x1f << 0)     /* RW */
> +#define PAD_CMD_RXDLY           (0x1f << 5)     /* RW */
> +#define PAD_CMD_RD_RXDLY2_SEL   (0x1 << 10)     /* RW */
> +#define PAD_CMD_RD_RXDLY_SEL    (0x1 << 11)     /* RW */
> +#define PAD_CMD_TX_DLY          (0x1f << 12)    /* RW */
> +
>  #define REQ_CMD_EIO  (0x1 << 0)
>  #define REQ_CMD_TMO  (0x1 << 1)
>  #define REQ_DAT_ERR  (0x1 << 2)
> @@ -333,6 +357,9 @@ struct msdc_save_para {
>  	u32 emmc50_cfg0;
>  	u32 emmc50_cfg3;
>  	u32 sdc_fifo_cfg;
> +	u32 emmc_top_control;
> +	u32 emmc_top_cmd;
> +	u32 emmc50_pad_ds_tune;
>  };
>  
>  struct mtk_mmc_compatible {
> @@ -351,6 +378,8 @@ struct msdc_tune_para {
>  	u32 iocon;
>  	u32 pad_tune;
>  	u32 pad_cmd_tune;
> +	u32 emmc_top_control;
> +	u32 emmc_top_cmd;
>  };
>  
>  struct msdc_delay_phase {
> @@ -372,6 +401,7 @@ struct msdc_host {
>  	int error;
>  
>  	void __iomem *base;		/* host base address */
> +	void __iomem *top_base;		/* host top register base address */

Where do you assign a value to top_base?
I'm not familiar with the driver, but couldn't we reuse base and a flag for
example in mtk_mmc_compatible to check which tune register we need to use?

Regards,
Matthias


>  
>  	struct msdc_dma dma;	/* dma channel */
>  	u64 dma_mask;
> @@ -429,6 +459,18 @@ struct msdc_host {
>  	.support_64g = false,
>  };
>  
> +static const struct mtk_mmc_compatible mt8183_compat = {
> +	.clk_div_bits = 12,
> +	.hs400_tune = false,
> +	.pad_tune_reg = MSDC_PAD_TUNE0,
> +	.async_fifo = true,
> +	.data_tune = true,
> +	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.enhance_rx = true,
> +	.support_64g = true,
> +};
> +
>  static const struct mtk_mmc_compatible mt2701_compat = {
>  	.clk_div_bits = 12,
>  	.hs400_tune = false,
> @@ -468,6 +510,7 @@ struct msdc_host {
>  static const struct of_device_id msdc_of_ids[] = {
>  	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>  	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
>  	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>  	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
>  	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
> @@ -777,12 +820,28 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>  	 */
>  	if (host->mmc->actual_clock <= 52000000) {
>  		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
> -		writel(host->def_tune_para.pad_tune, host->base + tune_reg);
> +		if (host->top_base) {
> +			writel(host->def_tune_para.emmc_top_control,
> +			       host->top_base + EMMC_TOP_CONTROL);
> +			writel(host->def_tune_para.emmc_top_cmd,
> +			       host->top_base + EMMC_TOP_CMD);
> +		} else {
> +			writel(host->def_tune_para.pad_tune,
> +			       host->base + tune_reg);
> +		}
>  	} else {
>  		writel(host->saved_tune_para.iocon, host->base + MSDC_IOCON);
> -		writel(host->saved_tune_para.pad_tune, host->base + tune_reg);
>  		writel(host->saved_tune_para.pad_cmd_tune,
>  		       host->base + PAD_CMD_TUNE);
> +		if (host->top_base) {
> +			writel(host->saved_tune_para.emmc_top_control,
> +			       host->top_base + EMMC_TOP_CONTROL);
> +			writel(host->saved_tune_para.emmc_top_cmd,
> +			       host->top_base + EMMC_TOP_CMD);
> +		} else {
> +			writel(host->saved_tune_para.pad_tune,
> +			       host->base + tune_reg);
> +		}
>  	}
>  
>  	if (timing == MMC_TIMING_MMC_HS400 &&
> @@ -1355,7 +1414,12 @@ static void msdc_init_hw(struct msdc_host *host)
>  	val = readl(host->base + MSDC_INT);
>  	writel(val, host->base + MSDC_INT);
>  
> -	writel(0, host->base + tune_reg);
> +	if (host->top_base) {
> +		writel(0, host->top_base + EMMC_TOP_CONTROL);
> +		writel(0, host->top_base + EMMC_TOP_CMD);
> +	} else {
> +		writel(0, host->base + tune_reg);
> +	}
>  	writel(0, host->base + MSDC_IOCON);
>  	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
>  	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
> @@ -1379,8 +1443,12 @@ static void msdc_init_hw(struct msdc_host *host)
>  		sdr_set_field(host->base + MSDC_PATCH_BIT2,
>  			      MSDC_PB2_RESPWAIT, 3);
>  		if (host->dev_comp->enhance_rx) {
> -			sdr_set_bits(host->base + SDC_ADV_CFG0,
> -				     SDC_RX_ENHANCE_EN);
> +			if (host->top_base)
> +				sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +					     SDC_RX_ENH_EN);
> +			else
> +				sdr_set_bits(host->base + SDC_ADV_CFG0,
> +					     SDC_RX_ENHANCE_EN);
>  		} else {
>  			sdr_set_field(host->base + MSDC_PATCH_BIT2,
>  				      MSDC_PB2_RESPSTSENSEL, 2);
> @@ -1398,11 +1466,26 @@ static void msdc_init_hw(struct msdc_host *host)
>  		sdr_set_bits(host->base + MSDC_PATCH_BIT2,
>  			     MSDC_PB2_SUPPORT_64G);
>  	if (host->dev_comp->data_tune) {
> -		sdr_set_bits(host->base + tune_reg,
> -			     MSDC_PAD_TUNE_RD_SEL | MSDC_PAD_TUNE_CMD_SEL);
> +		if (host->top_base) {
> +			sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +				     PAD_DAT_RD_RXDLY_SEL);
> +			sdr_clr_bits(host->top_base + EMMC_TOP_CONTROL,
> +				     DATA_K_VALUE_SEL);
> +			sdr_set_bits(host->top_base + EMMC_TOP_CMD,
> +				     PAD_CMD_RD_RXDLY_SEL);
> +		} else {
> +			sdr_set_bits(host->base + tune_reg,
> +				     MSDC_PAD_TUNE_RD_SEL |
> +				     MSDC_PAD_TUNE_CMD_SEL);
> +		}
>  	} else {
>  		/* choose clock tune */
> -		sdr_set_bits(host->base + tune_reg, MSDC_PAD_TUNE_RXDLYSEL);
> +		if (host->top_base)
> +			sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +				     PAD_RXDLY_SEL);
> +		else
> +			sdr_set_bits(host->base + tune_reg,
> +				     MSDC_PAD_TUNE_RXDLYSEL);
>  	}
>  
>  	/* Configure to enable SDIO mode.
> @@ -1417,9 +1500,20 @@ static void msdc_init_hw(struct msdc_host *host)
>  	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
>  
>  	host->def_tune_para.iocon = readl(host->base + MSDC_IOCON);
> -	host->def_tune_para.pad_tune = readl(host->base + tune_reg);
>  	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
> -	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
> +	if (host->top_base) {
> +		host->def_tune_para.emmc_top_control =
> +			readl(host->top_base + EMMC_TOP_CONTROL);
> +		host->def_tune_para.emmc_top_cmd =
> +			readl(host->top_base + EMMC_TOP_CMD);
> +		host->saved_tune_para.emmc_top_control =
> +			readl(host->top_base + EMMC_TOP_CONTROL);
> +		host->saved_tune_para.emmc_top_cmd =
> +			readl(host->top_base + EMMC_TOP_CMD);
> +	} else {
> +		host->def_tune_para.pad_tune = readl(host->base + tune_reg);
> +		host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
> +	}
>  	dev_dbg(host->dev, "init hardware done!");
>  }
>  
> @@ -1587,8 +1681,12 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>  
>  	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
>  		/*
>  		 * Using the same parameters, it may sometimes pass the test,
>  		 * but sometimes it may fail. To make sure the parameters are
> @@ -1612,8 +1710,12 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>  
>  	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  	for (i = 0; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
>  		/*
>  		 * Using the same parameters, it may sometimes pass the test,
>  		 * but sometimes it may fail. To make sure the parameters are
> @@ -1637,13 +1739,23 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>  		final_maxlen = final_fall_delay.maxlen;
>  	if (final_maxlen == final_rise_delay.maxlen) {
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_rise_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> +				      final_rise_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY,
> +				      final_rise_delay.final_phase);
>  		final_delay = final_rise_delay.final_phase;
>  	} else {
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_fall_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> +				      final_fall_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY,
> +				      final_fall_delay.final_phase);
>  		final_delay = final_fall_delay.final_phase;
>  	}
>  	if (host->dev_comp->async_fifo || host->hs200_cmd_int_delay)
> @@ -1728,8 +1840,12 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			rise_delay |= (1 << i);
> @@ -1743,8 +1859,12 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
>  	for (i = 0; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			fall_delay |= (1 << i);
> @@ -1756,16 +1876,26 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	if (final_maxlen == final_rise_delay.maxlen) {
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_rise_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY,
> +				      final_rise_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY,
> +				      final_rise_delay.final_phase);
>  		final_delay = final_rise_delay.final_phase;
>  	} else {
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_fall_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY,
> +				      final_fall_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY,
> +				      final_fall_delay.final_phase);
>  		final_delay = final_fall_delay.final_phase;
>  	}
>  
> @@ -1793,10 +1923,17 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>  	sdr_clr_bits(host->base + MSDC_IOCON,
>  		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base) {
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		} else {
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
> +		}
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			rise_delay |= (1 << i);
> @@ -1811,10 +1948,17 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>  	sdr_set_bits(host->base + MSDC_IOCON,
>  		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
>  	for (i = 0; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base) {
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		} else {
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
> +		}
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			fall_delay |= (1 << i);
> @@ -1827,22 +1971,24 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  		sdr_clr_bits(host->base + MSDC_IOCON,
>  			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_rise_delay.final_phase);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_rise_delay.final_phase);
>  		final_delay = final_rise_delay.final_phase;
>  	} else {
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  		sdr_set_bits(host->base + MSDC_IOCON,
>  			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +		final_delay = final_fall_delay.final_phase;
> +	}
> +
> +	if (host->top_base) {
> +		sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +			      PAD_CMD_RXDLY, final_delay);
> +		sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +			      PAD_DAT_RD_RXDLY, final_delay);
> +	} else {
>  		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_fall_delay.final_phase);
> +			      final_delay);
>  		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_fall_delay.final_phase);
> -		final_delay = final_fall_delay.final_phase;
> +			      MSDC_PAD_TUNE_DATRRDLY, final_delay);
>  	}
>  
>  	dev_dbg(host->dev, "Final pad delay: %x\n", final_delay);
> @@ -1860,8 +2006,12 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		if (host->hs400_mode) {
>  			sdr_clr_bits(host->base + MSDC_IOCON,
>  				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> -			sdr_set_field(host->base + tune_reg,
> -				      MSDC_PAD_TUNE_DATRRDLY, 0);
> +			if (host->top_base)
> +				sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +					      PAD_DAT_RD_RXDLY, 0);
> +			else
> +				sdr_set_field(host->base + tune_reg,
> +					      MSDC_PAD_TUNE_DATRRDLY, 0);
>  		}
>  		goto tune_done;
>  	}
> @@ -1884,6 +2034,12 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
>  	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
>  	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
> +	if (host->top_base) {
> +		host->saved_tune_para.emmc_top_control = readl(host->top_base +
> +				EMMC_TOP_CONTROL);
> +		host->saved_tune_para.emmc_top_cmd = readl(host->top_base +
> +				EMMC_TOP_CMD);
> +	}
>  	return ret;
>  }
>  
> @@ -1892,7 +2048,11 @@ static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct msdc_host *host = mmc_priv(mmc);
>  	host->hs400_mode = true;
>  
> -	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
> +	if (host->top_base)
> +		writel(host->hs400_ds_delay,
> +		       host->top_base + EMMC50_PAD_DS_TUNE);
> +	else
> +		writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
>  	/* hs400 mode must set it to 0 */
>  	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
>  	/* to improve read performance, set outstanding to 2 */
> @@ -1975,6 +2135,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	host->top_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(host->top_base))
> +		host->top_base = NULL;
> +
>  	ret = mmc_regulator_get_supply(mmc);
>  	if (ret)
>  		goto host_free;
> @@ -2143,7 +2308,6 @@ static void msdc_save_reg(struct msdc_host *host)
>  	host->save_para.msdc_cfg = readl(host->base + MSDC_CFG);
>  	host->save_para.iocon = readl(host->base + MSDC_IOCON);
>  	host->save_para.sdc_cfg = readl(host->base + SDC_CFG);
> -	host->save_para.pad_tune = readl(host->base + tune_reg);
>  	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
>  	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
>  	host->save_para.patch_bit2 = readl(host->base + MSDC_PATCH_BIT2);
> @@ -2152,6 +2316,16 @@ static void msdc_save_reg(struct msdc_host *host)
>  	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
>  	host->save_para.emmc50_cfg3 = readl(host->base + EMMC50_CFG3);
>  	host->save_para.sdc_fifo_cfg = readl(host->base + SDC_FIFO_CFG);
> +	if (host->top_base) {
> +		host->save_para.emmc_top_control =
> +			readl(host->top_base + EMMC_TOP_CONTROL);
> +		host->save_para.emmc_top_cmd =
> +			readl(host->top_base + EMMC_TOP_CMD);
> +		host->save_para.emmc50_pad_ds_tune =
> +			readl(host->top_base + EMMC50_PAD_DS_TUNE);
> +	} else {
> +		host->save_para.pad_tune = readl(host->base + tune_reg);
> +	}
>  }
>  
>  static void msdc_restore_reg(struct msdc_host *host)
> @@ -2161,7 +2335,6 @@ static void msdc_restore_reg(struct msdc_host *host)
>  	writel(host->save_para.msdc_cfg, host->base + MSDC_CFG);
>  	writel(host->save_para.iocon, host->base + MSDC_IOCON);
>  	writel(host->save_para.sdc_cfg, host->base + SDC_CFG);
> -	writel(host->save_para.pad_tune, host->base + tune_reg);
>  	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
>  	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
>  	writel(host->save_para.patch_bit2, host->base + MSDC_PATCH_BIT2);
> @@ -2170,6 +2343,16 @@ static void msdc_restore_reg(struct msdc_host *host)
>  	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
>  	writel(host->save_para.emmc50_cfg3, host->base + EMMC50_CFG3);
>  	writel(host->save_para.sdc_fifo_cfg, host->base + SDC_FIFO_CFG);
> +	if (host->top_base) {
> +		writel(host->save_para.emmc_top_control,
> +		       host->top_base + EMMC_TOP_CONTROL);
> +		writel(host->save_para.emmc_top_cmd,
> +		       host->top_base + EMMC_TOP_CMD);
> +		writel(host->save_para.emmc50_pad_ds_tune,
> +		       host->top_base + EMMC50_PAD_DS_TUNE);
> +	} else {
> +		writel(host->save_para.pad_tune, host->base + tune_reg);
> +	}
>  }
>  
>  static int msdc_runtime_suspend(struct device *dev)
> 
