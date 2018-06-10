Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Wiq4OQI9HVvjdAAAmS7hNA
	; Sun, 10 Jun 2018 15:00:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CB47160795; Sun, 10 Jun 2018 15:00:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uO+AkcUA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3DBBA6070A;
	Sun, 10 Jun 2018 15:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DBBA6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeFJPAP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 11:00:15 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43849 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeFJPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 11:00:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so26789739lfn.10;
        Sun, 10 Jun 2018 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QEBcXQiTWq+HusXhs0l3TyoC7wzvc7Ikl0/yRgMLgY=;
        b=uO+AkcUAs9EOf0nebD9nb8SZIwGJQCDuikIn3x/CcyQ5qhxgJkGXOog/CdL69ccEVc
         oj3XFI0B++VOyOVdFgAtvqBns5cbOLZ6/oXFmMfiGuicQZzb2ec1/DqQitBexMrv+NLT
         4gxw/dhlG5LwYQyp7u76OGJ/7lj4WA8LpAlyZRNI1c+kPzjmgyAcnxisi/DVK5YMwSpW
         KkR8+e15vCiZjvCABtHxcTXh9Bi5ca4txRXQ5ZTVuTc7ELSesLSUsQIdMOqKB66iJlpr
         ucWzKEWivPfXD++PrwMMbPGih+q5xuiyRBnM9sJWH4nHdH58gsdpPL4dZ7GJdmN8YvFK
         MImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QEBcXQiTWq+HusXhs0l3TyoC7wzvc7Ikl0/yRgMLgY=;
        b=E2R2ebLprej6csggCEK6aPzdcAgTlZfYGmrJa6zMiyiZSac2BtXuirkzg3YjwyaGBl
         oTnGJTnPjPVJ90MBxsxlTWPCm3qSH53t9kZzuEwoqSHPMfmcPQeHrmzyVrXbTFSJNd/K
         Q/ZBwfdZRMIekCaCySigobnMcD2B+SUFSeRn62srffxuCfifFRkBBWzznyNZ6w2ns/Oz
         9QMEi+ebjrGAxVZRLHqlgaafj8d4DU15MMAExc4OOEfRIZXZr681s7DTVmoQZGoGG6g0
         4qtKsJHHmj6yYl3dkt3SOlJGFZozctXOj9Q64yt1Gys19QltevLRpbZxjjYrWSXuPdeQ
         gXSA==
X-Gm-Message-State: APt69E0SlJn8Y2VqPDkTTYkKSaBROPZ1uusNopES1cb8Q3JRIv6EStrJ
        Ym5pPNVIVztmeE2WlRKD0e0=
X-Google-Smtp-Source: ADUXVKKWCciNY2Ko/vwoHGWrMHTG1x3w0HGnWswM7q3z0B1OafYDeWKoAvExQKH4pR7hcDF9/iUMug==
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr5273598ljg.22.1528642810912;
        Sun, 10 Jun 2018 08:00:10 -0700 (PDT)
Received: from dimapc.localnet (109-252-91-130.nat.spd-mgts.ru. [109.252.91.130])
        by smtp.gmail.com with ESMTPSA id d5-v6sm13617997lfg.65.2018.06.10.08.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 08:00:09 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Stefan Agner <stefan@agner.ch>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
Date: Sun, 10 Jun 2018 18:00:06 +0300
Message-ID: <1868760.y7shk6NfjH@dimapc>
In-Reply-To: <5751ef697130ba93ce9fb7722a1ce117@agner.ch>
References: <20180531221637.6017-1-stefan@agner.ch> <22478634.OSqaXHucyu@dimapc> <5751ef697130ba93ce9fb7722a1ce117@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 10 June 2018 14:09:24 MSK Stefan Agner wrote:
> On 09.06.2018 14:21, Dmitry Osipenko wrote:
> > On Saturday, 9 June 2018 00:51:01 MSK Stefan Agner wrote:
> >> On 01.06.2018 11:20, Dmitry Osipenko wrote:
> >> > On 01.06.2018 01:16, Stefan Agner wrote:
> >> >> Add support for the NAND flash controller found on NVIDIA
> >> >> Tegra 2 SoCs. This implementation does not make use of the
> >> >> command queue feature. Regular operations/data transfers are
> >> >> done in PIO mode. Page read/writes with hardware ECC make
> >> >> use of the DMA for data transfer.
> >> >> 
> >> >> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> >> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> >> ---
> >> >> 
> >> >>  MAINTAINERS                       |    7 +
> >> >>  drivers/mtd/nand/raw/Kconfig      |    6 +
> >> >>  drivers/mtd/nand/raw/Makefile     |    1 +
> >> >>  drivers/mtd/nand/raw/tegra_nand.c | 1143
> >> >>  +++++++++++++++++++++++++++++
> >> >>  4 files changed, 1157 insertions(+)
> >> >>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
> >> >> 
> >> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> >> index 58b9861ccf99..c2e5571c85d4 100644
> >> >> --- a/MAINTAINERS
> >> >> +++ b/MAINTAINERS
> >> >> @@ -13844,6 +13844,13 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
> >> >> 
> >> >>  S:	Supported
> >> >>  F:	drivers/input/keyboard/tegra-kbc.c
> >> >> 
> >> >> +TEGRA NAND DRIVER
> >> >> +M:	Stefan Agner <stefan@agner.ch>
> >> >> +M:	Lucas Stach <dev@lynxeye.de>
> >> >> +S:	Maintained
> >> >> +F:	Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
> >> >> +F:	drivers/mtd/nand/raw/tegra_nand.c
> >> >> +
> >> >> 
> >> >>  TEGRA PWM DRIVER
> >> >>  M:	Thierry Reding <thierry.reding@gmail.com>
> >> >>  S:	Supported
> >> >> 
> >> >> diff --git a/drivers/mtd/nand/raw/Kconfig
> >> >> b/drivers/mtd/nand/raw/Kconfig
> >> >> index 19a2b283fbbe..e9093f52371e 100644
> >> >> --- a/drivers/mtd/nand/raw/Kconfig
> >> >> +++ b/drivers/mtd/nand/raw/Kconfig
> >> >> @@ -534,4 +534,10 @@ config MTD_NAND_MTK
> >> >> 
> >> >>  	  Enables support for NAND controller on MTK SoCs.
> >> >>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
> >> >> 
> >> >> +config MTD_NAND_TEGRA
> >> >> +	tristate "Support for NAND controller on NVIDIA Tegra"
> >> >> +	depends on ARCH_TEGRA || COMPILE_TEST
> >> >> +	help
> >> >> +	  Enables support for NAND flash controller on NVIDIA Tegra SoC.
> >> >> +
> >> >> 
> >> >>  endif # MTD_NAND
> >> >> 
> >> >> diff --git a/drivers/mtd/nand/raw/Makefile
> >> >> b/drivers/mtd/nand/raw/Makefile
> >> >> index 165b7ef9e9a1..d5a5f9832b88 100644
> >> >> --- a/drivers/mtd/nand/raw/Makefile
> >> >> +++ b/drivers/mtd/nand/raw/Makefile
> >> >> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        +=
> >> >> hisi504_nand.o
> >> >> 
> >> >>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
> >> >>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
> >> >>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> >> >> 
> >> >> +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> >> >> 
> >> >>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
> >> >>  nand-objs += nand_amd.o
> >> >> 
> >> >> diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> >> >> b/drivers/mtd/nand/raw/tegra_nand.c new file mode 100644
> >> >> index 000000000000..e9664f2938a3
> >> >> --- /dev/null
> >> >> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> >> >> @@ -0,0 +1,1143 @@
> >> >> +// SPDX-License-Identifier: GPL-2.0
> >> >> +/*
> >> >> + * Copyright (C) 2018 Stefan Agner <stefan@agner.ch>
> >> >> + * Copyright (C) 2014-2015 Lucas Stach <dev@lynxeye.de>
> >> >> + * Copyright (C) 2012 Avionic Design GmbH
> >> >> + */
> >> >> +
> >> >> +#include <linux/clk.h>
> >> >> +#include <linux/completion.h>
> >> >> +#include <linux/delay.h>
> >> >> +#include <linux/dma-mapping.h>
> >> >> +#include <linux/err.h>
> >> >> +#include <linux/gpio/consumer.h>
> >> >> +#include <linux/interrupt.h>
> >> >> +#include <linux/io.h>
> >> >> +#include <linux/module.h>
> >> >> +#include <linux/mtd/partitions.h>
> >> >> +#include <linux/mtd/rawnand.h>
> >> >> +#include <linux/of.h>
> >> >> +#include <linux/platform_device.h>
> >> >> +#include <linux/reset.h>
> >> >> +
> >> >> +#define CMD					0x00
> >> >> +#define   CMD_GO				BIT(31)
> >> >> +#define   CMD_CLE				BIT(30)
> >> >> +#define   CMD_ALE				BIT(29)
> >> >> +#define   CMD_PIO				BIT(28)
> >> >> +#define   CMD_TX				BIT(27)
> >> >> +#define   CMD_RX				BIT(26)
> >> >> +#define   CMD_SEC_CMD				BIT(25)
> >> >> +#define   CMD_AFT_DAT				BIT(24)
> >> >> +#define   CMD_TRANS_SIZE(x)			(((x - 1) & 0xf) << 20)
> >> >> +#define   CMD_A_VALID				BIT(19)
> >> >> +#define   CMD_B_VALID				BIT(18)
> >> >> +#define   CMD_RD_STATUS_CHK			BIT(17)
> >> >> +#define   CMD_RBSY_CHK				BIT(16)
> >> >> +#define   CMD_CE(x)				BIT((8 + ((x) & 0x7)))
> >> >> +#define   CMD_CLE_SIZE(x)			(((x - 1) & 0x3) << 4)
> >> >> +#define   CMD_ALE_SIZE(x)			(((x - 1) & 0xf) << 0)
> >> >> +
> >> >> +#define STATUS					0x04
> >> >> +
> >> >> +#define ISR					0x08
> >> >> +#define   ISR_CORRFAIL_ERR			BIT(24)
> >> >> +#define   ISR_UND				BIT(7)
> >> >> +#define   ISR_OVR				BIT(6)
> >> >> +#define   ISR_CMD_DONE				BIT(5)
> >> >> +#define   ISR_ECC_ERR				BIT(4)
> >> >> +
> >> >> +#define IER					0x0c
> >> >> +#define   IER_ERR_TRIG_VAL(x)			(((x) & 0xf) << 16)
> >> >> +#define   IER_UND				BIT(7)
> >> >> +#define   IER_OVR				BIT(6)
> >> >> +#define   IER_CMD_DONE				BIT(5)
> >> >> +#define   IER_ECC_ERR				BIT(4)
> >> >> +#define   IER_GIE				BIT(0)
> >> >> +
> >> >> +#define CFG					0x10
> >> >> +#define   CFG_HW_ECC				BIT(31)
> >> >> +#define   CFG_ECC_SEL				BIT(30)
> >> >> +#define   CFG_ERR_COR				BIT(29)
> >> >> +#define   CFG_PIPE_EN				BIT(28)
> >> >> +#define   CFG_TVAL_4				(0 << 24)
> >> >> +#define   CFG_TVAL_6				(1 << 24)
> >> >> +#define   CFG_TVAL_8				(2 << 24)
> >> >> +#define   CFG_SKIP_SPARE			BIT(23)
> >> >> +#define   CFG_BUS_WIDTH_16			BIT(21)
> >> >> +#define   CFG_COM_BSY				BIT(20)
> >> >> +#define   CFG_PS_256				(0 << 16)
> >> >> +#define   CFG_PS_512				(1 << 16)
> >> >> +#define   CFG_PS_1024				(2 << 16)
> >> >> +#define   CFG_PS_2048				(3 << 16)
> >> >> +#define   CFG_PS_4096				(4 << 16)
> >> >> +#define   CFG_SKIP_SPARE_SIZE_4			(0 << 14)
> >> >> +#define   CFG_SKIP_SPARE_SIZE_8			(1 << 14)
> >> >> +#define   CFG_SKIP_SPARE_SIZE_12		(2 << 14)
> >> >> +#define   CFG_SKIP_SPARE_SIZE_16		(3 << 14)
> >> >> +#define   CFG_TAG_BYTE_SIZE(x)			((x) & 0xff)
> >> >> +
> >> >> +#define TIMING_1				0x14
> >> >> +#define   TIMING_TRP_RESP(x)			(((x) & 0xf) << 28)
> >> >> +#define   TIMING_TWB(x)				(((x) & 0xf) << 24)
> >> >> +#define   TIMING_TCR_TAR_TRR(x)			(((x) & 0xf) << 20)
> >> >> +#define   TIMING_TWHR(x)			(((x) & 0xf) << 16)
> >> >> +#define   TIMING_TCS(x)				(((x) & 0x3) << 14)
> >> >> +#define   TIMING_TWH(x)				(((x) & 0x3) << 12)
> >> >> +#define   TIMING_TWP(x)				(((x) & 0xf) <<  8)
> >> >> +#define   TIMING_TRH(x)				(((x) & 0x3) <<  4)
> >> >> +#define   TIMING_TRP(x)				(((x) & 0xf) <<  0)
> >> >> +
> >> >> +#define RESP					0x18
> >> >> +
> >> >> +#define TIMING_2				0x1c
> >> >> +#define   TIMING_TADL(x)			((x) & 0xf)
> >> >> +
> >> >> +#define CMD_1					0x20
> >> >> +#define CMD_2					0x24
> >> >> +#define ADDR_1					0x28
> >> >> +#define ADDR_2					0x2c
> >> >> +
> >> >> +#define DMA_CTRL				0x30
> >> >> +#define   DMA_CTRL_GO				BIT(31)
> >> >> +#define   DMA_CTRL_IN				(0 << 30)
> >> >> +#define   DMA_CTRL_OUT				BIT(30)
> >> >> +#define   DMA_CTRL_PERF_EN			BIT(29)
> >> >> +#define   DMA_CTRL_IE_DONE			BIT(28)
> >> >> +#define   DMA_CTRL_REUSE			BIT(27)
> >> >> +#define   DMA_CTRL_BURST_1			(2 << 24)
> >> >> +#define   DMA_CTRL_BURST_4			(3 << 24)
> >> >> +#define   DMA_CTRL_BURST_8			(4 << 24)
> >> >> +#define   DMA_CTRL_BURST_16			(5 << 24)
> >> >> +#define   DMA_CTRL_IS_DONE			BIT(20)
> >> >> +#define   DMA_CTRL_EN_A				BIT(2)
> >> >> +#define   DMA_CTRL_EN_B				BIT(1)
> >> >> +
> >> >> +#define DMA_CFG_A				0x34
> >> >> +#define DMA_CFG_B				0x38
> >> >> +
> >> >> +#define FIFO_CTRL				0x3c
> >> >> +#define   FIFO_CTRL_CLR_ALL			BIT(3)
> >> >> +
> >> >> +#define DATA_PTR				0x40
> >> >> +#define TAG_PTR					0x44
> >> >> +#define ECC_PTR					0x48
> >> >> +
> >> >> +#define DEC_STATUS				0x4c
> >> >> +#define   DEC_STATUS_A_ECC_FAIL			BIT(1)
> >> >> +#define   DEC_STATUS_ERR_COUNT_MASK		0x00ff0000
> >> >> +#define   DEC_STATUS_ERR_COUNT_SHIFT		16
> >> >> +
> >> >> +#define HWSTATUS_CMD				0x50
> >> >> +#define HWSTATUS_MASK				0x54
> >> >> +#define   HWSTATUS_RDSTATUS_MASK(x)		(((x) & 0xff) << 24)
> >> >> +#define   HWSTATUS_RDSTATUS_VALUE(x)		(((x) & 0xff) << 16)
> >> >> +#define   HWSTATUS_RBSY_MASK(x)			(((x) & 0xff) << 8)
> >> >> +#define   HWSTATUS_RBSY_VALUE(x)		(((x) & 0xff) << 0)
> >> >> +
> >> >> +#define BCH_CONFIG				0xcc
> >> >> +#define   BCH_ENABLE				BIT(0)
> >> >> +#define   BCH_TVAL_4				(0 << 4)
> >> >> +#define   BCH_TVAL_8				(1 << 4)
> >> >> +#define   BCH_TVAL_14				(2 << 4)
> >> >> +#define   BCH_TVAL_16				(3 << 4)
> >> >> +
> >> >> +#define DEC_STAT_RESULT				0xd0
> >> >> +#define DEC_STAT_BUF				0xd4
> >> >> +#define   DEC_STAT_BUF_FAIL_SEC_FLAG_MASK	0xff000000
> >> >> +#define   DEC_STAT_BUF_FAIL_SEC_FLAG_SHIFT	24
> >> >> +#define   DEC_STAT_BUF_CORR_SEC_FLAG_MASK	0x00ff0000
> >> >> +#define   DEC_STAT_BUF_CORR_SEC_FLAG_SHIFT	16
> >> >> +#define   DEC_STAT_BUF_MAX_CORR_CNT_MASK	0x00001f00
> >> >> +#define   DEC_STAT_BUF_MAX_CORR_CNT_SHIFT	8
> >> >> +
> >> >> +#define OFFSET(val, off)		((val) < (off) ? 0 : (val) - (off))
> >> >> +
> >> >> +#define SKIP_SPARE_BYTES	4
> >> >> +#define BITS_PER_STEP_RS	18
> >> >> +#define BITS_PER_STEP_BCH	13
> >> >> +
> >> >> +struct tegra_nand_controller {
> >> >> +	struct nand_hw_control controller;
> >> >> +	void __iomem *regs;
> >> >> +	struct clk *clk;
> >> >> +	struct device *dev;
> >> >> +	struct completion command_complete;
> >> >> +	struct completion dma_complete;
> >> >> +	bool last_read_error;
> >> >> +	int cur_chip;
> >> >> +	struct nand_chip *chip;
> >> >> +};
> >> >> +
> >> >> +struct tegra_nand_chip {
> >> >> +	struct nand_chip chip;
> >> >> +	struct gpio_desc *wp_gpio;
> >> >> +	struct mtd_oob_region tag;
> >> >> +};
> >> >> +
> >> >> +static inline struct tegra_nand_controller *to_tegra_ctrl(
> >> >> +						struct nand_hw_control *hw_ctrl)
> >> >> +{
> >> >> +	return container_of(hw_ctrl, struct tegra_nand_controller,
> > 
> > controller);
> > 
> >> >> +}
> >> >> +
> >> >> +static inline struct tegra_nand_chip *to_tegra_chip(struct nand_chip
> >> >> *chip) +{
> >> >> +	return container_of(chip, struct tegra_nand_chip, chip);
> >> >> +}
> >> >> +
> >> >> +static int tegra_nand_ooblayout_rs_ecc(struct mtd_info *mtd, int
> >> >> section,
> >> >> +				       struct mtd_oob_region *oobregion)
> >> >> +{
> >> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> >> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_RS *
> >> >> chip->ecc.strength,
> >> >> +					  BITS_PER_BYTE);
> >> >> +
> >> >> +	if (section > 0)
> >> >> +		return -ERANGE;
> >> >> +
> >> >> +	oobregion->offset = SKIP_SPARE_BYTES;
> >> >> +	oobregion->length = round_up(bytes_per_step * chip->ecc.steps, 
4);
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >> >> +
> >> >> +static int tegra_nand_ooblayout_rs_free(struct mtd_info *mtd, int
> >> >> section,
> >> >> +					struct mtd_oob_region *oobregion)
> >> >> +{
> >> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> >> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_RS *
> >> >> chip->ecc.strength,
> >> >> +					  BITS_PER_BYTE);
> >> >> +
> >> >> +	if (section > 0)
> >> >> +		return -ERANGE;
> >> >> +
> >> >> +	oobregion->offset = SKIP_SPARE_BYTES +
> >> >> +			    round_up(bytes_per_step * chip->ecc.steps, 4);
> >> >> +	oobregion->length = mtd->oobsize - oobregion->offset;
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >> >> +
> >> >> +static const struct mtd_ooblayout_ops tegra_nand_oob_rs_ops = {
> >> >> +	.ecc = tegra_nand_ooblayout_rs_ecc,
> >> >> +	.free = tegra_nand_ooblayout_rs_free,
> >> >> +};
> >> >> +
> >> >> +static int tegra_nand_ooblayout_bch_ecc(struct mtd_info *mtd, int
> >> >> section,
> >> >> +				       struct mtd_oob_region *oobregion)
> >> >> +{
> >> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> >> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_BCH *
> >> >> chip->ecc.strength,
> >> >> +					  BITS_PER_BYTE);
> >> >> +
> >> >> +	if (section > 0)
> >> >> +		return -ERANGE;
> >> >> +
> >> >> +	oobregion->offset = SKIP_SPARE_BYTES;
> >> >> +	oobregion->length = round_up(bytes_per_step * chip->ecc.steps, 
4);
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >> >> +
> >> >> +static int tegra_nand_ooblayout_bch_free(struct mtd_info *mtd, int
> >> >> section, +					struct mtd_oob_region *oobregion)
> >> >> +{
> >> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> >> +	int bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_BCH *
> >> >> chip->ecc.strength,
> >> >> +					  BITS_PER_BYTE);
> >> >> +
> >> >> +	if (section > 0)
> >> >> +		return -ERANGE;
> >> >> +
> >> >> +	oobregion->offset = SKIP_SPARE_BYTES +
> >> >> +			    round_up(bytes_per_step * chip->ecc.steps, 4);
> >> >> +	oobregion->length = mtd->oobsize - oobregion->offset;
> >> >> +
> >> >> +	return 0;
> >> >> +}
> >> >> +
> >> >> +/*
> >> >> + * Layout with tag bytes is
> >> >> + *
> >> >> + *
> >> >> ----------------------------------------------------------------------
> >> >> --
> >> >> -- + * | main area                       | skip bytes | tag bytes |
> >> >> parity | .. | + *
> >> >> ----------------------------------------------------------------------
> >> >> --
> >> >> -- + *
> >> >> + * If not tag bytes are written, parity moves right after skip bytes!
> >> >> + */
> >> >> +static const struct mtd_ooblayout_ops tegra_nand_oob_bch_ops = {
> >> >> +	.ecc = tegra_nand_ooblayout_bch_ecc,
> >> >> +	.free = tegra_nand_ooblayout_bch_free,
> >> >> +};
> >> >> +
> >> >> +static irqreturn_t tegra_nand_irq(int irq, void *data)
> >> >> +{
> >> >> +	struct tegra_nand_controller *ctrl = data;
> >> >> +	u32 isr, dma;
> >> >> +
> >> >> +	isr = readl_relaxed(ctrl->regs + ISR);
> >> >> +	dma = readl_relaxed(ctrl->regs + DMA_CTRL);
> >> >> +	dev_dbg(ctrl->dev, "isr %08x\n", isr);
> >> >> +
> >> >> +	if (!isr && !(dma & DMA_CTRL_IS_DONE))
> >> >> +		return IRQ_NONE;
> >> >> +
> >> >> +	/*
> >> >> +	 * The bit name is somewhat missleading: This is also set when
> >> >> +	 * HW ECC was successful. The data sheet states:
> >> >> +	 * Correctable OR Un-correctable errors occurred in the DMA
> > 
> > transfer...
> > 
> >> >> +	 */
> >> >> +	if (isr & ISR_CORRFAIL_ERR)
> >> >> +		ctrl->last_read_error = true;
> >> >> +
> >> >> +	if (isr & ISR_CMD_DONE)
> >> >> +		complete(&ctrl->command_complete);
> >> >> +
> >> >> +	if (isr & ISR_UND)
> >> >> +		dev_err(ctrl->dev, "FIFO underrun\n");
> >> >> +
> >> >> +	if (isr & ISR_OVR)
> >> >> +		dev_err(ctrl->dev, "FIFO overrun\n");
> >> >> +
> >> >> +	/* handle DMA interrupts */
> >> >> +	if (dma & DMA_CTRL_IS_DONE) {
> >> >> +		writel_relaxed(dma, ctrl->regs + DMA_CTRL);
> >> >> +		complete(&ctrl->dma_complete);
> >> >> +	}
> >> >> +
> >> >> +	/* clear interrupts */
> >> >> +	writel_relaxed(isr, ctrl->regs + ISR);
> >> >> +
> >> >> +	return IRQ_HANDLED;
> >> >> +}
> >> >> +
> >> >> +static const char * const tegra_nand_reg_names[] = {
> >> >> +	"COMMAND",
> >> >> +	"STATUS",
> >> >> +	"ISR",
> >> >> +	"IER",
> >> >> +	"CONFIG",
> >> >> +	"TIMING",
> >> >> +	NULL,
> >> >> +	"TIMING2",
> >> >> +	"CMD_REG1",
> >> >> +	"CMD_REG2",
> >> >> +	"ADDR_REG1",
> >> >> +	"ADDR_REG2",
> >> >> +	"DMA_MST_CTRL",
> >> >> +	"DMA_CFG_A",
> >> >> +	"DMA_CFG_B",
> >> >> +	"FIFO_CTRL",
> >> >> +};
> >> >> +
> >> >> +static void tegra_nand_dump_reg(struct tegra_nand_controller *ctrl)
> >> >> +{
> >> >> +	u32 reg;
> >> >> +	int i;
> >> >> +
> >> >> +	dev_err(ctrl->dev, "Tegra NAND controller register dump\n");
> >> >> +	for (i = 0; i < ARRAY_SIZE(tegra_nand_reg_names); i++) {
> >> >> +		const char *reg_name = tegra_nand_reg_names[i];
> >> >> +
> >> >> +		if (!reg_name)
> >> >> +			continue;
> >> >> +
> >> >> +		reg = readl_relaxed(ctrl->regs + (i * 4));
> >> >> +		dev_err(ctrl->dev, "%s: 0x%08x\n", reg_name, reg);
> >> >> +	}
> >> >> +}
> >> >> +
> >> >> +static int tegra_nand_cmd(struct nand_chip *chip,
> >> >> +			 const struct nand_subop *subop)
> >> >> +{
> >> >> +	const struct nand_op_instr *instr;
> >> >> +	const struct nand_op_instr *instr_data_in = NULL;
> >> >> +	struct tegra_nand_controller *ctrl =
> >> >> to_tegra_ctrl(chip->controller);
> >> >> +	unsigned int op_id, size = 0, offset = 0;
> >> >> +	bool first_cmd = true;
> >> >> +	u32 reg, cmd = 0;
> >> >> +	int ret;
> >> >> +
> >> >> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> >> >> +		unsigned int naddrs, i;
> >> >> +		const u8 *addrs;
> >> >> +		u32 addr1 = 0, addr2 = 0;
> >> >> +
> >> >> +		instr = &subop->instrs[op_id];
> >> >> +
> >> >> +		switch (instr->type) {
> >> >> +		case NAND_OP_CMD_INSTR:
> >> >> +			if (first_cmd) {
> >> >> +				cmd |= CMD_CLE;
> >> >> +				writel_relaxed(instr->ctx.cmd.opcode,
> >> >> +					       ctrl->regs + CMD_1);
> >> >> +			} else {
> >> >> +				cmd |= CMD_SEC_CMD;
> >> >> +				writel_relaxed(instr->ctx.cmd.opcode,
> >> >> +					       ctrl->regs + CMD_2);
> >> >> +			}
> >> >> +			first_cmd = false;
> >> >> +			break;
> >> >> +		case NAND_OP_ADDR_INSTR:
> >> >> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> >> >> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> >> >> +			addrs = &instr->ctx.addr.addrs[offset];
> >> >> +
> >> >> +			cmd |= CMD_ALE | CMD_ALE_SIZE(naddrs);
> >> >> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> >> >> +				addr1 |= *addrs++ << (BITS_PER_BYTE * i);
> >> >> +			naddrs -= i;
> >> >> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> >> >> +				addr2 |= *addrs++ << (BITS_PER_BYTE * i);
> >> >> +			writel_relaxed(addr1, ctrl->regs + ADDR_1);
> >> >> +			writel_relaxed(addr2, ctrl->regs + ADDR_2);
> >> >> +			break;
> >> >> +
> >> >> +		case NAND_OP_DATA_IN_INSTR:
> >> >> +			size = nand_subop_get_data_len(subop, op_id);
> >> >> +			offset = nand_subop_get_data_start_off(subop, op_id);
> >> >> +
> >> >> +			cmd |= CMD_TRANS_SIZE(size) | CMD_PIO | CMD_RX |
> >> >> +				CMD_A_VALID;
> >> >> +
> >> >> +			instr_data_in = instr;
> >> >> +			break;
> >> >> +
> >> >> +		case NAND_OP_DATA_OUT_INSTR:
> >> >> +			size = nand_subop_get_data_len(subop, op_id);
> >> >> +			offset = nand_subop_get_data_start_off(subop, op_id);
> >> >> +
> >> >> +			cmd |= CMD_TRANS_SIZE(size) | CMD_PIO | CMD_TX |
> >> >> +				CMD_A_VALID;
> >> >> +
> >> >> +			memcpy(&reg, instr->ctx.data.buf.out + offset, size);
> >> >> +			writel_relaxed(reg, ctrl->regs + RESP);
> >> >> +
> >> >> +			break;
> >> >> +		case NAND_OP_WAITRDY_INSTR:
> >> >> +			cmd |= CMD_RBSY_CHK;
> >> >> +			break;
> >> >> +
> >> >> +		}
> >> >> +	}
> >> >> +
> >> >> +	cmd |= CMD_GO | CMD_CE(ctrl->cur_chip);
> >> >> +	writel_relaxed(cmd, ctrl->regs + CMD);
> >> >> +	ret = wait_for_completion_timeout(&ctrl->command_complete,
> >> >> +					  msecs_to_jiffies(500));
> >> >> +	if (!ret) {
> >> >> +		dev_err(ctrl->dev, "CMD timeout\n");
> >> >> +		tegra_nand_dump_reg(ctrl);
> >> >> +		return -ETIMEDOUT;
> >> >> +	}
> >> > 
> >> > - wait_for_completion_timeout() could fail
> >> 
> >> Not according to:
> >> https://elixir.bootlin.com/linux/latest/source/kernel/sched/completion.c#
> >> L14 0 https://www.kernel.org/doc/Documentation/scheduler/completion.txt
> >> 
> >> Afaik, only the _interruptible variant can fail.
> > 
> > Okay.
> > 
> >> Btw, maybe we should use the _io variant?
> > 
> > Looks like the _io variant is something specific to block/FS subsys and
> > shouldn't be used by the drivers.
> > 
> >> > - HW shall be reset
> >> > - completion shall be re-inited because IRQ could fire just after the
> >> > completion timeout
> >> > 
> >> > I'd write it something like this:
> >> > 
> >> > #define INT_MASK	(IER_UND | IER_OVR | IER_CMD_DONE | IER_GIE)
> >> > 
> >> > #define HWSTATUS_MASK	(HWSTATUS_RDSTATUS_MASK(1) |		 \
> >> > 
> >> > 			 HWSTATUS_RDSTATUS_VALUE(0) |		 \
> >> > 			 HWSTATUS_RBSY_MASK(NAND_STATUS_READY) | \
> >> > 			 HWSTATUS_RBSY_VALUE(NAND_STATUS_READY))
> >> > 
> >> > #define HW_TIMEOUT	500
> >> > 
> >> > void tegra_nand_controller_reset(struct tegra_nand_controller *ctrl)
> >> > {
> >> > 
> >> > 	int err;
> >> > 	
> >> > 	disable_irq(ctrl->irq);
> >> > 	
> >> > 	err = reset_control_reset(ctrl->rst);
> >> > 	if (err) {
> >> > 	
> >> > 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
> >> > 		msleep(HW_TIMEOUT);
> >> > 	
> >> > 	}
> >> > 	
> >> > 	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
> >> > 	writel_relaxed(HWSTATUS_MASK, ctrl->regs + HWSTATUS_MASK);
> >> > 	writel_relaxed(INT_MASK, ctrl->regs + ISR);
> >> 
> >> If we do a controller reset, there is much more state than that which
> >> needs to be restored. A lot of it is not readily available currently
> >> (timing, ECC settings...)
> >> 
> >> That seems a lot of work for a code path I do not intend to ever use :-)
> > 
> > Are you sure that resetting HW resets the timing and other registers
> > configuration? Reset implementation is HW-specific, like for example in a
> > case of a video decoder the registers state is re-intialized on HW reset,
> > but registers configuration is untouched in a case of resetting GPU. I'd
> > suggest to check whether NAND controller resetting affects the HW
> > configuration.
> It seems all registers are set back to their documented reset value:
> 
> [boot loader/ROM initialized values]
> [    1.270253] tegra-nand 70008000.nand: Tegra NAND controller register
> dump
> [    1.277051] tegra-nand 70008000.nand: COMMAND: 0x66880104
> [    1.282457] tegra-nand 70008000.nand: STATUS: 0x00000101
> [    1.287763] tegra-nand 70008000.nand: ISR: 0x01000120
> [    1.292818] tegra-nand 70008000.nand: IER: 0x00000000
> [    1.297863] tegra-nand 70008000.nand: CONFIG: 0x00840000
> [    1.303181] tegra-nand 70008000.nand: TIMING: 0x05040000
> [    1.308486] tegra-nand 70008000.nand: TIMING2: 0x00000003
> [    1.313897] tegra-nand 70008000.nand: CMD_REG1: 0x00000000
> [    1.319377] tegra-nand 70008000.nand: CMD_REG2: 0x00000030
> [    1.324868] tegra-nand 70008000.nand: ADDR_REG1: 0x03000000
> [    1.330435] tegra-nand 70008000.nand: ADDR_REG2: 0x00000000
> [    1.336011] tegra-nand 70008000.nand: DMA_MST_CTRL: 0x04100004
> [    1.341838] tegra-nand 70008000.nand: DMA_CFG_A: 0x00000fff
> [    1.347415] tegra-nand 70008000.nand: DMA_CFG_B: 0x0000001b
> [    1.352991] tegra-nand 70008000.nand: FIFO_CTRL: 0x0000aa00
> [reset]
> [    1.358559] tegra-nand 70008000.nand: Tegra NAND controller register
> dump
> [    1.365352] tegra-nand 70008000.nand: COMMAND: 0x00800004
> [    1.370744] tegra-nand 70008000.nand: STATUS: 0x00000101
> [    1.376060] tegra-nand 70008000.nand: ISR: 0x00000100
> [    1.381105] tegra-nand 70008000.nand: IER: 0x00000000
> [    1.386161] tegra-nand 70008000.nand: CONFIG: 0x10030000
> [    1.391466] tegra-nand 70008000.nand: TIMING: 0x00000000
> [    1.396782] tegra-nand 70008000.nand: TIMING2: 0x00000000
> [    1.402174] tegra-nand 70008000.nand: CMD_REG1: 0x00000000
> [    1.407664] tegra-nand 70008000.nand: CMD_REG2: 0x00000000
> [    1.413156] tegra-nand 70008000.nand: ADDR_REG1: 0x00000000
> [    1.418722] tegra-nand 70008000.nand: ADDR_REG2: 0x00000000
> [    1.424297] tegra-nand 70008000.nand: DMA_MST_CTRL: 0x24000000
> [    1.430123] tegra-nand 70008000.nand: DMA_CFG_A: 0x00000000
> [    1.435698] tegra-nand 70008000.nand: DMA_CFG_B: 0x00000000
> [    1.441264] tegra-nand 70008000.nand: FIFO_CTRL: 0x0000aa00

Alright, then indeed it's not really worth to bother with HW resetting here.  
Probably only a kernel module reload or a reboot will help if HW is hung. 
Maybe NAND controller / chip recovering is something that NAND core should be 
handling in a such case by providing a nand_controller_reset() hook?
