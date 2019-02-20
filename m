Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCD1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3082320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX/Crxho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfBTOlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:41:49 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37647 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfBTOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:41:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so20042241edv.4;
        Wed, 20 Feb 2019 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBJ/jYcxY4IE/wR03AgMgWoxos0191S0tyXQcXmAnaE=;
        b=iX/CrxhoEfxMyxAR0b13Ce0tUr/BIRW6y9DTBFW8nYr3aw+y6g93x7OC6pEq7YlZ2c
         DKV/0OqEshJR6lHN6g4R+Ddwbi91GTa3/pV6dbYVeqpbROBsohBG+Wx0pPPEw/b13cEi
         4oxwpasJwZxM78L+6HtPXdcS830JUAOhTwYMVBEKgzbTTi4EAlLTQgcbA6rTW7wsFawt
         WXyz6J3yuEXEC4U7rZN85xKxVf0gY9vkfK1OozbYJFOc2ED39X7XMmwXrneTta4FX6QG
         e4WMARHd37UZR1fxMm0tVwS6j23YcHOSpXfLz2nDlqumLWM5mfRNr+sgnIf9Yldasacz
         BSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CBJ/jYcxY4IE/wR03AgMgWoxos0191S0tyXQcXmAnaE=;
        b=VRcg/ikoyIlHEm21rAdtObdrNmTzrnTAsUgkiPCNoBuaHP90Zli7xOmHPx+qCB9cv6
         IlwuIr3CYZYS+90WrdaNgqPb9aUoRFeLQJzIuiZDJxGyV8C0Gf0awLDo4iVnGjoNm5if
         ovbjiVQSoNcVC4HhP6qrmltFBe/oP7AhDyBzpcjoe7PFGupD/A0lOSsXYk79rWARP1ow
         +Pn8ZjeYMtU7EuJzUOBQHYw6e0qckKOiSS8wPRctUCVmlCsRu3DygX00UY0iLIgsm5Ag
         mHWS2OTOVwyM1uAiZ3GBg2Fe38XoWihUrCBuGfUcvAJsIM3/SCgYw/OekIX4nQK2BhF3
         uoow==
X-Gm-Message-State: AHQUAubJlXW05S8PfoMnwMAhUmKfX/Eh2H2Pf6GReLYaCNu2/nC14U1t
        00Yv4H3R3qQVb04RZgRyageHiRei
X-Google-Smtp-Source: AHgI3Ibod9i4kuO6cksYY8IvmPyk1/pXWjx4qlAX62qA+2LCHs1rOc2pl9jAYokr/oons5NLgy8loA==
X-Received: by 2002:a50:cdc3:: with SMTP id h3mr28160289edj.208.1550673704184;
        Wed, 20 Feb 2019 06:41:44 -0800 (PST)
Received: from ziggy.stardust ([37.223.146.9])
        by smtp.gmail.com with ESMTPSA id h44sm3913525edh.34.2019.02.20.06.41.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 06:41:43 -0800 (PST)
Subject: Re: [PATCH v4 3/3] i2c: mediatek: Add i2c support for MediaTek MT8183
To:     Qii Wang <qii.wang@mediatek.com>, wsa@the-dreams.de
Cc:     devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com,
        linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
 <1550666030-30211-4-git-send-email-qii.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <40bf7264-1fc7-320a-1122-1782b57c5b53@gmail.com>
Date:   Wed, 20 Feb 2019 15:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550666030-30211-4-git-send-email-qii.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2019 13:33, Qii Wang wrote:
> Add i2c compatible for MT8183. Compare to MT2712 i2c controller,
> MT8183 has different registers, offsets and clock.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

So you introduce arb clock, ltiming (what is this exactly) and the new SoC in
one commit. I'd prefer to split that up and explain shortly in the commit
message why they are needed. More comments inline.

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |   89 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 428ac99..82eedbd 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -35,6 +35,7 @@
>  #include <linux/slab.h>
>  
>  #define I2C_RS_TRANSFER			(1 << 4)
> +#define I2C_ARB_LOST			(1 << 3)
>  #define I2C_HS_NACKERR			(1 << 2)
>  #define I2C_ACKERR			(1 << 1)
>  #define I2C_TRANSAC_COMP		(1 << 0)
> @@ -76,6 +77,8 @@
>  #define I2C_CONTROL_DIR_CHANGE          (0x1 << 4)
>  #define I2C_CONTROL_ACKERR_DET_EN       (0x1 << 5)
>  #define I2C_CONTROL_TRANSFER_LEN_CHANGE (0x1 << 6)
> +#define I2C_CONTROL_DMAACK_EN           (0x1 << 8)
> +#define I2C_CONTROL_ASYNC_MODE          (0x1 << 9)
>  #define I2C_CONTROL_WRAPPER             (0x1 << 0)
>  
>  #define I2C_DRV_NAME		"i2c-mt65xx"
> @@ -130,6 +133,8 @@ enum I2C_REGS_OFFSET {
>  	OFFSET_DEBUGCTRL,
>  	OFFSET_TRANSFER_LEN_AUX,
>  	OFFSET_CLOCK_DIV,
> +	/* MT8183 only regs */
> +	OFFSET_LTIMING,
>  };
>  
>  static const u16 mt_i2c_regs_v1[] = {
> @@ -159,6 +164,32 @@ enum I2C_REGS_OFFSET {
>  	[OFFSET_CLOCK_DIV] = 0x70,
>  };
>  
> +static const u16 mt_i2c_regs_v2[] = {
> +	[OFFSET_DATA_PORT] = 0x0,
> +	[OFFSET_SLAVE_ADDR] = 0x4,
> +	[OFFSET_INTR_MASK] = 0x8,
> +	[OFFSET_INTR_STAT] = 0xc,
> +	[OFFSET_CONTROL] = 0x10,
> +	[OFFSET_TRANSFER_LEN] = 0x14,
> +	[OFFSET_TRANSAC_LEN] = 0x18,
> +	[OFFSET_DELAY_LEN] = 0x1c,
> +	[OFFSET_TIMING] = 0x20,
> +	[OFFSET_START] = 0x24,
> +	[OFFSET_EXT_CONF] = 0x28,
> +	[OFFSET_LTIMING] = 0x2c,
> +	[OFFSET_HS] = 0x30,
> +	[OFFSET_IO_CONFIG] = 0x34,
> +	[OFFSET_FIFO_ADDR_CLR] = 0x38,
> +	[OFFSET_TRANSFER_LEN_AUX] = 0x44,
> +	[OFFSET_CLOCK_DIV] = 0x48,
> +	[OFFSET_SOFTRESET] = 0x50,
> +	[OFFSET_DEBUGSTAT] = 0xe0,
> +	[OFFSET_DEBUGCTRL] = 0xe8,
> +	[OFFSET_FIFO_STAT] = 0xf4,
> +	[OFFSET_FIFO_THRESH] = 0xf8,
> +	[OFFSET_DCM_EN] = 0xf88,
> +};
> +
>  struct mtk_i2c_compatible {
>  	const struct i2c_adapter_quirks *quirks;
>  	const u16 *regs;
> @@ -168,6 +199,7 @@ struct mtk_i2c_compatible {
>  	unsigned char aux_len_reg: 1;
>  	unsigned char support_33bits: 1;
>  	unsigned char timing_adjust: 1;
> +	unsigned char dma_sync: 1;
>  };
>  
>  struct mtk_i2c {
> @@ -181,6 +213,7 @@ struct mtk_i2c {
>  	struct clk *clk_main;		/* main clock for i2c bus */
>  	struct clk *clk_dma;		/* DMA clock for i2c via DMA */
>  	struct clk *clk_pmic;		/* PMIC clock for i2c from PMIC */
> +	struct clk *clk_arb;		/* Arbitrator clock for i2c */
>  	bool have_pmic;			/* can use i2c pins from PMIC */
>  	bool use_push_pull;		/* IO config push-pull mode */
>  
> @@ -190,6 +223,7 @@ struct mtk_i2c {
>  	enum mtk_trans_op op;
>  	u16 timing_reg;
>  	u16 high_speed_reg;
> +	u16 ltiming_reg;
>  	unsigned char auto_restart;
>  	bool ignore_restart_irq;
>  	const struct mtk_i2c_compatible *dev_comp;
> @@ -216,6 +250,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 1,
>  	.timing_adjust = 1,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt6577_compat = {
> @@ -227,6 +262,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 0,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt6589_compat = {
> @@ -238,6 +274,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 0,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt7622_compat = {
> @@ -249,6 +286,7 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 0,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
>  };
>  
>  static const struct mtk_i2c_compatible mt8173_compat = {
> @@ -259,6 +297,18 @@ struct mtk_i2c {
>  	.aux_len_reg = 1,
>  	.support_33bits = 1,
>  	.timing_adjust = 0,
> +	.dma_sync = 0,
> +};
> +
> +static const struct mtk_i2c_compatible mt8183_compat = {
> +	.regs = mt_i2c_regs_v2,
> +	.pmic_i2c = 0,
> +	.dcm = 0,
> +	.auto_restart = 1,
> +	.aux_len_reg = 1,
> +	.support_33bits = 1,
> +	.timing_adjust = 1,
> +	.dma_sync = 1,
>  };
>  
>  static const struct of_device_id mtk_i2c_of_match[] = {
> @@ -267,6 +317,7 @@ struct mtk_i2c {
>  	{ .compatible = "mediatek,mt6589-i2c", .data = &mt6589_compat },
>  	{ .compatible = "mediatek,mt7622-i2c", .data = &mt7622_compat },
>  	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
> +	{ .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
> @@ -299,8 +350,18 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  		if (ret)
>  			goto err_pmic;
>  	}
> +
> +	if (i2c->clk_arb) {
> +		ret = clk_prepare_enable(i2c->clk_arb);
> +		if (ret)
> +			goto err_arb;
> +	}
> +
>  	return 0;
>  
> +err_arb:
> +	if (i2c->have_pmic)
> +		clk_disable_unprepare(i2c->clk_pmic);
>  err_pmic:
>  	clk_disable_unprepare(i2c->clk_main);
>  err_main:
> @@ -311,6 +372,9 @@ static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  
>  static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
>  {
> +	if (i2c->clk_arb)
> +		clk_disable_unprepare(i2c->clk_arb);
> +
>  	if (i2c->have_pmic)
>  		clk_disable_unprepare(i2c->clk_pmic);
>  
> @@ -338,6 +402,8 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  
>  	mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
>  	mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
> +	if (i2c->dev_comp->regs == mt_i2c_regs_v2)

I'm not really happy with this check. I personally would prefer a flag or
something which shows that we need ltiming.

> +		mtk_i2c_writew(i2c, i2c->ltiming_reg, OFFSET_LTIMING);
>  
>  	/* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
>  	if (i2c->have_pmic)
> @@ -345,6 +411,9 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  
>  	control_reg = I2C_CONTROL_ACKERR_DET_EN |
>  		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> +	if (i2c->dev_comp->dma_sync)
> +		control_reg |= I2C_CONTROL_DMAACK_EN | I2C_CONTROL_ASYNC_MODE;
> +
>  	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>  	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>  
> @@ -434,6 +503,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  	unsigned int clk_src;
>  	unsigned int step_cnt;
>  	unsigned int sample_cnt;
> +	unsigned int l_step_cnt;
> +	unsigned int l_sample_cnt;
>  	unsigned int target_speed;
>  	int ret;
>  
> @@ -443,11 +514,11 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  	if (target_speed > MAX_FS_MODE_SPEED) {
>  		/* Set master code speed register */
>  		ret = mtk_i2c_calculate_speed(i2c, clk_src, MAX_FS_MODE_SPEED,
> -					      &step_cnt, &sample_cnt);
> +					      &l_step_cnt, &l_sample_cnt);
>  		if (ret < 0)
>  			return ret;
>  
> -		i2c->timing_reg = (sample_cnt << 8) | step_cnt;
> +		i2c->timing_reg = (l_sample_cnt << 8) | l_step_cnt;
>  
>  		/* Set the high speed mode register */
>  		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
> @@ -457,6 +528,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  
>  		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
>  			(sample_cnt << 12) | (step_cnt << 8);
> +		i2c->ltiming_reg = (l_sample_cnt << 6) | l_step_cnt |
> +				   (sample_cnt << 12) | (step_cnt << 9);

IMHO setting these for all SoCs but then only using it for one makes things more
complicated. Value should only be set for SoCs that need this features.

>  	} else {
>  		ret = mtk_i2c_calculate_speed(i2c, clk_src, target_speed,
>  					      &step_cnt, &sample_cnt);
> @@ -467,6 +540,8 @@ static int mtk_i2c_set_speed(struct mtk_i2c *i2c, unsigned int parent_clk)
>  
>  		/* Disable the high speed transaction */
>  		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> +
> +		i2c->ltiming_reg = (sample_cnt << 6) | step_cnt;
>  	}
>  
>  	return 0;
> @@ -519,13 +594,13 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  
>  	/* Clear interrupt status */
>  	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> +			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_STAT);

Did you test that this works with all the old SoCs that are already supported by
this driver?

Regards,
Matthias

>  
>  	mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
>  
>  	/* Enable interrupt */
>  	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
> +			    I2C_ARB_LOST | I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
>  
>  	/* Set transfer and transaction len */
>  	if (i2c->op == I2C_MASTER_WRRD) {
> @@ -659,7 +734,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  
>  	/* Clear interrupt mask */
>  	mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
> +			    I2C_ARB_LOST | I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
>  
>  	if (i2c->op == I2C_MASTER_WR) {
>  		dma_unmap_single(i2c->dev, wpaddr,
> @@ -884,6 +959,10 @@ static int mtk_i2c_probe(struct platform_device *pdev)
>  		return PTR_ERR(i2c->clk_dma);
>  	}
>  
> +	i2c->clk_arb = devm_clk_get(&pdev->dev, "arb");
> +	if (IS_ERR(i2c->clk_arb))
> +		i2c->clk_arb = NULL;
> +
>  	clk = i2c->clk_main;
>  	if (i2c->have_pmic) {
>  		i2c->clk_pmic = devm_clk_get(&pdev->dev, "pmic");
> 
