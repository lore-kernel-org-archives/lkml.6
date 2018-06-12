Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3FCC1C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80BA208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+qxsoMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80BA208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeFLAD0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:03:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44817 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933367AbeFLADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:03:24 -0400
Received: by mail-lf0-f68.google.com with SMTP id 36-v6so33189080lfr.11;
        Mon, 11 Jun 2018 17:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1ck/l+fuCfBMy1BRgTKZ4SSGKNKqxw4iFX4+RwlvUI=;
        b=X+qxsoMpu84R/0O67BMqdt4HKJsZXmj44BbkswRgMHPC1/fXqbkKHC0jukohIU5NHQ
         hX93MlrE1roGboQPkNNISq07Or687JSKNHEj0sZFXU349y3us0n+/1aIkWVYaWcPcZ/X
         v1wCBWI3a63p2y13Lu+2XbLvvh7JGkUz/42r/AUTqs2wXA0+bi2fY4zYVSXx7EEFNPhD
         b5+UxNVqEXMZdFaXKndBcT6WUTGu4Zwf+hVlEiKMt+sepZwV/k6Snzg6s+mRFX4VgcpL
         0Fmot94D/fjISsHsn2Y5B26VC+N865zeMblGYgWfXXmOJ8r7fomYI5fMpsX7ZDKD8Q8W
         kQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1ck/l+fuCfBMy1BRgTKZ4SSGKNKqxw4iFX4+RwlvUI=;
        b=GNpS+UPchu7jCG4kFDzfyw9btxrZXALxL72MlnURbsWGZLFqbUZJR5lK5biTHpfmjE
         E/YaNcPr5VFMJ/bkHP3V4FvPmiKFapovst7wu0vlPI/1EYQP5S6BnDC2ROyaNjjZmi2H
         cXFmCSJ1TLgqIEbpwk0M/M8ngKm/g7E2+LBrP7BGvc5+LvdyDs58B3n4zntxQnBe8jVh
         sKbL1zkDWbrqbf4L+GGjtUixmJ98UBUef8vLw5wT6FS0BQ0BmwZ1O4OTPx4uQY81Wvx9
         EuDiolSZcQQItZvvWGsBhFUHvUQYZcEmogZtXnMFqieD9iGwK26OD7/pbmjCA7Xk2J+u
         91fQ==
X-Gm-Message-State: APt69E21t77Wp986wpIUQfVrzwK9y+4QG+y01MG4K6968EEPZWvbQLhs
        yUV0757QGMk0ILkVlD3Bi+Y=
X-Google-Smtp-Source: ADUXVKL6aHvN78DCB2dLkS3lQAX9LUsCIklCjmqbkMtKCzh2khejBvpDj6nHz9ZEjEI7FAJpcY3reg==
X-Received: by 2002:a19:cc4b:: with SMTP id c72-v6mr718096lfg.30.1528761802045;
        Mon, 11 Jun 2018 17:03:22 -0700 (PDT)
Received: from dimapc.localnet ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id f63-v6sm3666869lje.79.2018.06.11.17.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:03:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
Date:   Tue, 12 Jun 2018 03:03:19 +0300
Message-ID: <4258393.O1xtUOGbca@dimapc>
In-Reply-To: <20180611205224.23340-5-stefan@agner.ch>
References: <20180611205224.23340-1-stefan@agner.ch> <20180611205224.23340-5-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 June 2018 23:52:22 MSK Stefan Agner wrote:
> Add support for the NAND flash controller found on NVIDIA
> Tegra 2 SoCs. This implementation does not make use of the
> command queue feature. Regular operations/data transfers are
> done in PIO mode. Page read/writes with hardware ECC make
> use of the DMA for data transfer.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  MAINTAINERS                       |    7 +
>  drivers/mtd/nand/raw/Kconfig      |    6 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/tegra_nand.c | 1248 +++++++++++++++++++++++++++++
>  4 files changed, 1262 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58b9861ccf99..c2e5571c85d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13844,6 +13844,13 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
>  S:	Supported
>  F:	drivers/input/keyboard/tegra-kbc.c
> 
> +TEGRA NAND DRIVER
> +M:	Stefan Agner <stefan@agner.ch>
> +M:	Lucas Stach <dev@lynxeye.de>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> +F:	drivers/mtd/nand/raw/tegra_nand.c
> +
>  TEGRA PWM DRIVER
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  S:	Supported
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 19a2b283fbbe..e9093f52371e 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -534,4 +534,10 @@ config MTD_NAND_MTK
>  	  Enables support for NAND controller on MTK SoCs.
>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
> 
> +config MTD_NAND_TEGRA
> +	tristate "Support for NAND controller on NVIDIA Tegra"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	help
> +	  Enables support for NAND flash controller on NVIDIA Tegra SoC.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 165b7ef9e9a1..d5a5f9832b88 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += 
hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> 
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_amd.o
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> b/drivers/mtd/nand/raw/tegra_nand.c new file mode 100644
> index 000000000000..dd23a5eb6af3
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -0,0 +1,1248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Stefan Agner <stefan@agner.ch>
> + * Copyright (C) 2014-2015 Lucas Stach <dev@lynxeye.de>
> + * Copyright (C) 2012 Avionic Design GmbH
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#define COMMAND					0x00
> +#define   COMMAND_GO				BIT(31)
> +#define   COMMAND_CLE				BIT(30)
> +#define   COMMAND_ALE				BIT(29)
> +#define   COMMAND_PIO				BIT(28)
> +#define   COMMAND_TX				BIT(27)
> +#define   COMMAND_RX				BIT(26)
> +#define   COMMAND_SEC_CMD			BIT(25)
> +#define   COMMAND_AFT_DAT			BIT(24)
> +#define   COMMAND_TRANS_SIZE(x)			(((x - 1) & 0xf) << 20)
> +#define   COMMAND_A_VALID			BIT(19)
> +#define   COMMAND_B_VALID			BIT(18)
> +#define   COMMAND_RD_STATUS_CHK			BIT(17)
> +#define   COMMAND_RBSY_CHK			BIT(16)
> +#define   COMMAND_CE(x)				BIT(8 + ((x) & 0x7))
> +#define   COMMAND_CLE_SIZE(x)			(((x - 1) & 0x3) << 4)
> +#define   COMMAND_ALE_SIZE(x)			(((x - 1) & 0xf) << 0)
> +
> +#define STATUS					0x04
> +
> +#define ISR					0x08
> +#define   ISR_CORRFAIL_ERR			BIT(24)
> +#define   ISR_UND				BIT(7)
> +#define   ISR_OVR				BIT(6)
> +#define   ISR_CMD_DONE				BIT(5)
> +#define   ISR_ECC_ERR				BIT(4)
> +
> +#define IER					0x0c
> +#define   IER_ERR_TRIG_VAL(x)			(((x) & 0xf) << 16)
> +#define   IER_UND				BIT(7)
> +#define   IER_OVR				BIT(6)
> +#define   IER_CMD_DONE				BIT(5)
> +#define   IER_ECC_ERR				BIT(4)
> +#define   IER_GIE				BIT(0)
> +
> +#define CONFIG					0x10
> +#define   CONFIG_HW_ECC				BIT(31)
> +#define   CONFIG_ECC_SEL			BIT(30)
> +#define   CONFIG_ERR_COR			BIT(29)
> +#define   CONFIG_PIPE_EN			BIT(28)
> +#define   CONFIG_TVAL_4				(0 << 24)
> +#define   CONFIG_TVAL_6				(1 << 24)
> +#define   CONFIG_TVAL_8				(2 << 24)
> +#define   CONFIG_SKIP_SPARE			BIT(23)
> +#define   CONFIG_BUS_WIDTH_16			BIT(21)
> +#define   CONFIG_COM_BSY			BIT(20)
> +#define   CONFIG_PS_256				(0 << 16)
> +#define   CONFIG_PS_512				(1 << 16)
> +#define   CONFIG_PS_1024			(2 << 16)
> +#define   CONFIG_PS_2048			(3 << 16)
> +#define   CONFIG_PS_4096			(4 << 16)
> +#define   CONFIG_SKIP_SPARE_SIZE_4		(0 << 14)
> +#define   CONFIG_SKIP_SPARE_SIZE_8		(1 << 14)
> +#define   CONFIG_SKIP_SPARE_SIZE_12		(2 << 14)
> +#define   CONFIG_SKIP_SPARE_SIZE_16		(3 << 14)
> +#define   CONFIG_TAG_BYTE_SIZE(x)			((x) & 0xff)
> +
> +#define TIMING_1				0x14
> +#define   TIMING_TRP_RESP(x)			(((x) & 0xf) << 28)
> +#define   TIMING_TWB(x)				(((x) & 0xf) << 24)
> +#define   TIMING_TCR_TAR_TRR(x)			(((x) & 0xf) << 20)
> +#define   TIMING_TWHR(x)			(((x) & 0xf) << 16)
> +#define   TIMING_TCS(x)				(((x) & 0x3) << 14)
> +#define   TIMING_TWH(x)				(((x) & 0x3) << 12)
> +#define   TIMING_TWP(x)				(((x) & 0xf) <<  8)
> +#define   TIMING_TRH(x)				(((x) & 0x3) <<  4)
> +#define   TIMING_TRP(x)				(((x) & 0xf) <<  0)
> +
> +#define RESP					0x18
> +
> +#define TIMING_2				0x1c
> +#define   TIMING_TADL(x)			((x) & 0xf)
> +
> +#define CMD_REG1				0x20
> +#define CMD_REG2				0x24
> +#define ADDR_REG1				0x28
> +#define ADDR_REG2				0x2c
> +
> +#define DMA_MST_CTRL				0x30
> +#define   DMA_MST_CTRL_GO			BIT(31)
> +#define   DMA_MST_CTRL_IN			(0 << 30)
> +#define   DMA_MST_CTRL_OUT			BIT(30)
> +#define   DMA_MST_CTRL_PERF_EN			BIT(29)
> +#define   DMA_MST_CTRL_IE_DONE			BIT(28)
> +#define   DMA_MST_CTRL_REUSE			BIT(27)
> +#define   DMA_MST_CTRL_BURST_1			(2 << 24)
> +#define   DMA_MST_CTRL_BURST_4			(3 << 24)
> +#define   DMA_MST_CTRL_BURST_8			(4 << 24)
> +#define   DMA_MST_CTRL_BURST_16			(5 << 24)
> +#define   DMA_MST_CTRL_IS_DONE			BIT(20)
> +#define   DMA_MST_CTRL_EN_A			BIT(2)
> +#define   DMA_MST_CTRL_EN_B			BIT(1)
> +
> +#define DMA_CFG_A				0x34
> +#define DMA_CFG_B				0x38
> +
> +#define FIFO_CTRL				0x3c
> +#define   FIFO_CTRL_CLR_ALL			BIT(3)
> +
> +#define DATA_PTR				0x40
> +#define TAG_PTR					0x44
> +#define ECC_PTR					0x48
> +
> +#define DEC_STATUS				0x4c
> +#define   DEC_STATUS_A_ECC_FAIL			BIT(1)
> +#define   DEC_STATUS_ERR_COUNT_MASK		0x00ff0000
> +#define   DEC_STATUS_ERR_COUNT_SHIFT		16
> +
> +#define HWSTATUS_CMD				0x50
> +#define HWSTATUS_MASK				0x54
> +#define   HWSTATUS_RDSTATUS_MASK(x)		(((x) & 0xff) << 24)
> +#define   HWSTATUS_RDSTATUS_VALUE(x)		(((x) & 0xff) << 16)
> +#define   HWSTATUS_RBSY_MASK(x)			(((x) & 0xff) << 8)
> +#define   HWSTATUS_RBSY_VALUE(x)		(((x) & 0xff) << 0)
> +
> +#define BCH_CONFIG				0xcc
> +#define   BCH_ENABLE				BIT(0)
> +#define   BCH_TVAL_4				(0 << 4)
> +#define   BCH_TVAL_8				(1 << 4)
> +#define   BCH_TVAL_14				(2 << 4)
> +#define   BCH_TVAL_16				(3 << 4)
> +
> +#define DEC_STAT_RESULT				0xd0
> +#define DEC_STAT_BUF				0xd4
> +#define   DEC_STAT_BUF_FAIL_SEC_FLAG_MASK	0xff000000
> +#define   DEC_STAT_BUF_FAIL_SEC_FLAG_SHIFT	24
> +#define   DEC_STAT_BUF_CORR_SEC_FLAG_MASK	0x00ff0000
> +#define   DEC_STAT_BUF_CORR_SEC_FLAG_SHIFT	16
> +#define   DEC_STAT_BUF_MAX_CORR_CNT_MASK	0x00001f00
> +#define   DEC_STAT_BUF_MAX_CORR_CNT_SHIFT	8
> +
> +#define OFFSET(val, off)	((val) < (off) ? 0 : (val) - (off))
> +
> +#define SKIP_SPARE_BYTES	4
> +#define BITS_PER_STEP_RS	18
> +#define BITS_PER_STEP_BCH	13
> +
> +#define INT_MASK		(IER_UND | IER_OVR | IER_CMD_DONE | IER_GIE)
> +#define HWSTATUS_CMD_DEFAULT	NAND_STATUS_READY
> +#define HWSTATUS_MASK_DEFAULT	(HWSTATUS_RDSTATUS_MASK(1) | \
> +				HWSTATUS_RDSTATUS_VALUE(0) | \
> +				HWSTATUS_RBSY_MASK(NAND_STATUS_READY) | \
> +				HWSTATUS_RBSY_VALUE(NAND_STATUS_READY))
> +
> +struct tegra_nand_controller {
> +	struct nand_hw_control controller;
> +	struct device *dev;
> +	void __iomem *regs;
> +	int irq;
> +	struct clk *clk;
> +	struct completion command_complete;
> +	struct completion dma_complete;
> +	bool last_read_error;
> +	int cur_cs;
> +	struct nand_chip *chip;
> +};
> +
> +struct tegra_nand_chip {
> +	struct nand_chip chip;
> +	struct gpio_desc *wp_gpio;
> +	struct mtd_oob_region tag;
> +	u32 config;
> +	u32 config_ecc;
> +	u32 bch_config;
> +	int cs[1];
> +};
> +
> +static inline struct tegra_nand_controller *to_tegra_ctrl(
> +						struct nand_hw_control *hw_ctrl)
> +{
> +	return container_of(hw_ctrl, struct tegra_nand_controller, controller);
> +}
> +
> +static inline struct tegra_nand_chip *to_tegra_chip(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct tegra_nand_chip, chip);
> +}
> +
> +static int tegra_nand_ooblayout_rs_ecc(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_RS * chip->ecc.strength,
> +					  BITS_PER_BYTE);
> +
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = SKIP_SPARE_BYTES;
> +	oobregion->length = round_up(bytes_per_step * chip->ecc.steps, 4);
> +
> +	return 0;
> +}
> +
> +static int tegra_nand_ooblayout_rs_free(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_RS * chip->ecc.strength,
> +					  BITS_PER_BYTE);
> +
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = SKIP_SPARE_BYTES +
> +			    round_up(bytes_per_step * chip->ecc.steps, 4);
> +	oobregion->length = mtd->oobsize - oobregion->offset;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops tegra_nand_oob_rs_ops = {
> +	.ecc = tegra_nand_ooblayout_rs_ecc,
> +	.free = tegra_nand_ooblayout_rs_free,
> +};
> +
> +static int tegra_nand_ooblayout_bch_ecc(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_BCH * chip->ecc.strength,
> +					  BITS_PER_BYTE);
> +
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = SKIP_SPARE_BYTES;
> +	oobregion->length = round_up(bytes_per_step * chip->ecc.steps, 4);
> +
> +	return 0;
> +}
> +
> +static int tegra_nand_ooblayout_bch_free(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_BCH * chip->ecc.strength,
> +					  BITS_PER_BYTE);
> +
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = SKIP_SPARE_BYTES +
> +			    round_up(bytes_per_step * chip->ecc.steps, 4);
> +	oobregion->length = mtd->oobsize - oobregion->offset;
> +
> +	return 0;
> +}
> +
> +/*
> + * Layout with tag bytes is
> + *
> + *
> --------------------------------------------------------------------------
> + * | main area                       | skip bytes | tag bytes | parity |
> .. | + *
> --------------------------------------------------------------------------
> + *
> + * If not tag bytes are written, parity moves right after skip bytes!
> + */
> +static const struct mtd_ooblayout_ops tegra_nand_oob_bch_ops = {
> +	.ecc = tegra_nand_ooblayout_bch_ecc,
> +	.free = tegra_nand_ooblayout_bch_free,
> +};
> +
> +static irqreturn_t tegra_nand_irq(int irq, void *data)
> +{
> +	struct tegra_nand_controller *ctrl = data;
> +	u32 isr, dma;
> +
> +	isr = readl_relaxed(ctrl->regs + ISR);
> +	dma = readl_relaxed(ctrl->regs + DMA_MST_CTRL);
> +	dev_dbg(ctrl->dev, "isr %08x\n", isr);
> +
> +	if (!isr && !(dma & DMA_MST_CTRL_IS_DONE))
> +		return IRQ_NONE;
> +
> +	/*
> +	 * The bit name is somewhat missleading: This is also set when
> +	 * HW ECC was successful. The data sheet states:
> +	 * Correctable OR Un-correctable errors occurred in the DMA transfer...
> +	 */
> +	if (isr & ISR_CORRFAIL_ERR)
> +		ctrl->last_read_error = true;
> +
> +	if (isr & ISR_CMD_DONE)
> +		complete(&ctrl->command_complete);
> +
> +	if (isr & ISR_UND)
> +		dev_err(ctrl->dev, "FIFO underrun\n");
> +
> +	if (isr & ISR_OVR)
> +		dev_err(ctrl->dev, "FIFO overrun\n");
> +
> +	/* handle DMA interrupts */
> +	if (dma & DMA_MST_CTRL_IS_DONE) {
> +		writel_relaxed(dma, ctrl->regs + DMA_MST_CTRL);
> +		complete(&ctrl->dma_complete);
> +	}
> +
> +	/* clear interrupts */
> +	writel_relaxed(isr, ctrl->regs + ISR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const char * const tegra_nand_reg_names[] = {
> +	"COMMAND",
> +	"STATUS",
> +	"ISR",
> +	"IER",
> +	"CONFIG",
> +	"TIMING",
> +	NULL,
> +	"TIMING2",
> +	"CMD_REG1",
> +	"CMD_REG2",
> +	"ADDR_REG1",
> +	"ADDR_REG2",
> +	"DMA_MST_CTRL",
> +	"DMA_CFG_A",
> +	"DMA_CFG_B",
> +	"FIFO_CTRL",
> +};
> +
> +static void tegra_nand_dump_reg(struct tegra_nand_controller *ctrl)
> +{
> +	u32 reg;
> +	int i;
> +
> +	dev_err(ctrl->dev, "Tegra NAND controller register dump\n");
> +	for (i = 0; i < ARRAY_SIZE(tegra_nand_reg_names); i++) {
> +		const char *reg_name = tegra_nand_reg_names[i];
> +
> +		if (!reg_name)
> +			continue;
> +
> +		reg = readl_relaxed(ctrl->regs + (i * 4));
> +		dev_err(ctrl->dev, "%s: 0x%08x\n", reg_name, reg);
> +	}
> +}
> +
> +static void tegra_nand_controller_abort(struct tegra_nand_controller *ctrl)
> +{
> +	u32 isr, dma;
> +
> +	disable_irq(ctrl->irq);
> +
> +	/* Abort current command/DMA operation */
> +	writel_relaxed(0, ctrl->regs + DMA_MST_CTRL);
> +	writel_relaxed(0, ctrl->regs + COMMAND);
> +
> +	/* clear interrupts */
> +	isr = readl_relaxed(ctrl->regs + ISR);
> +	writel_relaxed(isr, ctrl->regs + ISR);
> +	dma = readl_relaxed(ctrl->regs + DMA_MST_CTRL);
> +	writel_relaxed(dma, ctrl->regs + DMA_MST_CTRL);
> +
> +	reinit_completion(&ctrl->command_complete);
> +	reinit_completion(&ctrl->dma_complete);
> +
> +	enable_irq(ctrl->irq);
> +}
> +
> +static int tegra_nand_cmd(struct nand_chip *chip,
> +			 const struct nand_subop *subop)
> +{
> +	const struct nand_op_instr *instr;
> +	const struct nand_op_instr *instr_data_in = NULL;
> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> +	unsigned int op_id, size = 0, offset = 0;
> +	bool first_cmd = true;
> +	u32 reg, cmd = 0;
> +	int ret;
> +
> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> +		unsigned int naddrs, i;
> +		const u8 *addrs;
> +		u32 addr1 = 0, addr2 = 0;
> +
> +		instr = &subop->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			if (first_cmd) {
> +				cmd |= COMMAND_CLE;
> +				writel_relaxed(instr->ctx.cmd.opcode,
> +					       ctrl->regs + CMD_REG1);
> +			} else {
> +				cmd |= COMMAND_SEC_CMD;
> +				writel_relaxed(instr->ctx.cmd.opcode,
> +					       ctrl->regs + CMD_REG2);
> +			}
> +			first_cmd = false;
> +			break;
> +		case NAND_OP_ADDR_INSTR:
> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs = &instr->ctx.addr.addrs[offset];
> +
> +			cmd |= COMMAND_ALE | COMMAND_ALE_SIZE(naddrs);
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				addr1 |= *addrs++ << (BITS_PER_BYTE * i);
> +			naddrs -= i;
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				addr2 |= *addrs++ << (BITS_PER_BYTE * i);
> +			writel_relaxed(addr1, ctrl->regs + ADDR_REG1);
> +			writel_relaxed(addr2, ctrl->regs + ADDR_REG2);
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			size = nand_subop_get_data_len(subop, op_id);
> +			offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
> +				COMMAND_RX | COMMAND_A_VALID;
> +
> +			instr_data_in = instr;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			size = nand_subop_get_data_len(subop, op_id);
> +			offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +			cmd |= COMMAND_TRANS_SIZE(size) | COMMAND_PIO |
> +				COMMAND_TX | COMMAND_A_VALID;
> +
> +			memcpy(&reg, instr->ctx.data.buf.out + offset, size);
> +			writel_relaxed(reg, ctrl->regs + RESP);
> +
> +			break;
> +		case NAND_OP_WAITRDY_INSTR:
> +			cmd |= COMMAND_RBSY_CHK;
> +			break;
> +
> +		}
> +	}
> +
> +	cmd |= COMMAND_GO | COMMAND_CE(ctrl->cur_cs);
> +	writel_relaxed(cmd, ctrl->regs + COMMAND);
> +	ret = wait_for_completion_io_timeout(&ctrl->command_complete,
> +					     msecs_to_jiffies(500));

It's not obvious to me whether _io_ variant is appropriate to use here, would 
be nice if somebody could clarify that. Maybe block/ already does the IO 
accounting itself and hence the IO time would be counted twice in that case.


