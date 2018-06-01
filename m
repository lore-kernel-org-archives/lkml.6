Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeFAJVQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:21:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45725 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFAJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:21:11 -0400
X-Google-Smtp-Source: ADUXVKKl/dSXGJuzUG7jr+MV/beGyMp8to/4Z2ILZnX8JmkescL/bMa1GtjVksu18tocHK1OodDEtg==
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
To: Stefan Agner <stefan@agner.ch>, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-5-stefan@agner.ch>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
X-Enigmail-Draft-Status: N11100
Message-ID: <cdca329f-0b8d-0604-4cfb-b95baf84c867@gmail.com>
Date: Fri, 1 Jun 2018 12:20:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180531221637.6017-5-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.2018 01:16, Stefan Agner wrote:
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
>  drivers/mtd/nand/raw/tegra_nand.c | 1143 +++++++++++++++++++++++++++++
>  4 files changed, 1157 insertions(+)
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
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_amd.o
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
> new file mode 100644
> index 000000000000..e9664f2938a3
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -0,0 +1,1143 @@
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
> +#define CMD					0x00
> +#define   CMD_GO				BIT(31)
> +#define   CMD_CLE				BIT(30)
> +#define   CMD_ALE				BIT(29)
> +#define   CMD_PIO				BIT(28)
> +#define   CMD_TX				BIT(27)
> +#define   CMD_RX				BIT(26)
> +#define   CMD_SEC_CMD				BIT(25)
> +#define   CMD_AFT_DAT				BIT(24)
> +#define   CMD_TRANS_SIZE(x)			(((x - 1) & 0xf) << 20)
> +#define   CMD_A_VALID				BIT(19)
> +#define   CMD_B_VALID				BIT(18)
> +#define   CMD_RD_STATUS_CHK			BIT(17)
> +#define   CMD_RBSY_CHK				BIT(16)
> +#define   CMD_CE(x)				BIT((8 + ((x) & 0x7)))
> +#define   CMD_CLE_SIZE(x)			(((x - 1) & 0x3) << 4)
> +#define   CMD_ALE_SIZE(x)			(((x - 1) & 0xf) << 0)
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
> +#define CFG					0x10
> +#define   CFG_HW_ECC				BIT(31)
> +#define   CFG_ECC_SEL				BIT(30)
> +#define   CFG_ERR_COR				BIT(29)
> +#define   CFG_PIPE_EN				BIT(28)
> +#define   CFG_TVAL_4				(0 << 24)
> +#define   CFG_TVAL_6				(1 << 24)
> +#define   CFG_TVAL_8				(2 << 24)
> +#define   CFG_SKIP_SPARE			BIT(23)
> +#define   CFG_BUS_WIDTH_16			BIT(21)
> +#define   CFG_COM_BSY				BIT(20)
> +#define   CFG_PS_256				(0 << 16)
> +#define   CFG_PS_512				(1 << 16)
> +#define   CFG_PS_1024				(2 << 16)
> +#define   CFG_PS_2048				(3 << 16)
> +#define   CFG_PS_4096				(4 << 16)
> +#define   CFG_SKIP_SPARE_SIZE_4			(0 << 14)
> +#define   CFG_SKIP_SPARE_SIZE_8			(1 << 14)
> +#define   CFG_SKIP_SPARE_SIZE_12		(2 << 14)
> +#define   CFG_SKIP_SPARE_SIZE_16		(3 << 14)
> +#define   CFG_TAG_BYTE_SIZE(x)			((x) & 0xff)
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
> +#define CMD_1					0x20
> +#define CMD_2					0x24
> +#define ADDR_1					0x28
> +#define ADDR_2					0x2c
> +
> +#define DMA_CTRL				0x30
> +#define   DMA_CTRL_GO				BIT(31)
> +#define   DMA_CTRL_IN				(0 << 30)
> +#define   DMA_CTRL_OUT				BIT(30)
> +#define   DMA_CTRL_PERF_EN			BIT(29)
> +#define   DMA_CTRL_IE_DONE			BIT(28)
> +#define   DMA_CTRL_REUSE			BIT(27)
> +#define   DMA_CTRL_BURST_1			(2 << 24)
> +#define   DMA_CTRL_BURST_4			(3 << 24)
> +#define   DMA_CTRL_BURST_8			(4 << 24)
> +#define   DMA_CTRL_BURST_16			(5 << 24)
> +#define   DMA_CTRL_IS_DONE			BIT(20)
> +#define   DMA_CTRL_EN_A				BIT(2)
> +#define   DMA_CTRL_EN_B				BIT(1)
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
> +#define OFFSET(val, off)		((val) < (off) ? 0 : (val) - (off))
> +
> +#define SKIP_SPARE_BYTES	4
> +#define BITS_PER_STEP_RS	18
> +#define BITS_PER_STEP_BCH	13
> +
> +struct tegra_nand_controller {
> +	struct nand_hw_control controller;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct completion command_complete;
> +	struct completion dma_complete;
> +	bool last_read_error;
> +	int cur_chip;
> +	struct nand_chip *chip;
> +};
> +
> +struct tegra_nand_chip {
> +	struct nand_chip chip;
> +	struct gpio_desc *wp_gpio;
> +	struct mtd_oob_region tag;
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
> + * --------------------------------------------------------------------------
> + * | main area                       | skip bytes | tag bytes | parity | .. |
> + * --------------------------------------------------------------------------
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
> +	dma = readl_relaxed(ctrl->regs + DMA_CTRL);
> +	dev_dbg(ctrl->dev, "isr %08x\n", isr);
> +
> +	if (!isr && !(dma & DMA_CTRL_IS_DONE))
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
> +	if (dma & DMA_CTRL_IS_DONE) {
> +		writel_relaxed(dma, ctrl->regs + DMA_CTRL);
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
> +				cmd |= CMD_CLE;
> +				writel_relaxed(instr->ctx.cmd.opcode,
> +					       ctrl->regs + CMD_1);
> +			} else {
> +				cmd |= CMD_SEC_CMD;
> +				writel_relaxed(instr->ctx.cmd.opcode,
> +					       ctrl->regs + CMD_2);
> +			}
> +			first_cmd = false;
> +			break;
> +		case NAND_OP_ADDR_INSTR:
> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs = &instr->ctx.addr.addrs[offset];
> +
> +			cmd |= CMD_ALE | CMD_ALE_SIZE(naddrs);
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				addr1 |= *addrs++ << (BITS_PER_BYTE * i);
> +			naddrs -= i;
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				addr2 |= *addrs++ << (BITS_PER_BYTE * i);
> +			writel_relaxed(addr1, ctrl->regs + ADDR_1);
> +			writel_relaxed(addr2, ctrl->regs + ADDR_2);
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			size = nand_subop_get_data_len(subop, op_id);
> +			offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +			cmd |= CMD_TRANS_SIZE(size) | CMD_PIO | CMD_RX |
> +				CMD_A_VALID;
> +
> +			instr_data_in = instr;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			size = nand_subop_get_data_len(subop, op_id);
> +			offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +			cmd |= CMD_TRANS_SIZE(size) | CMD_PIO | CMD_TX |
> +				CMD_A_VALID;
> +
> +			memcpy(&reg, instr->ctx.data.buf.out + offset, size);
> +			writel_relaxed(reg, ctrl->regs + RESP);
> +
> +			break;
> +		case NAND_OP_WAITRDY_INSTR:
> +			cmd |= CMD_RBSY_CHK;
> +			break;
> +
> +		}
> +	}
> +
> +	cmd |= CMD_GO | CMD_CE(ctrl->cur_chip);
> +	writel_relaxed(cmd, ctrl->regs + CMD);
> +	ret = wait_for_completion_timeout(&ctrl->command_complete,
> +					  msecs_to_jiffies(500));
> +	if (!ret) {
> +		dev_err(ctrl->dev, "CMD timeout\n");
> +		tegra_nand_dump_reg(ctrl);
> +		return -ETIMEDOUT;
> +	}

- wait_for_completion_timeout() could fail
- HW shall be reset
- completion shall be re-inited because IRQ could fire just after the completion
timeout

I'd write it something like this:

#define INT_MASK	(IER_UND | IER_OVR | IER_CMD_DONE | IER_GIE)

#define HWSTATUS_MASK	(HWSTATUS_RDSTATUS_MASK(1) |		 \
			 HWSTATUS_RDSTATUS_VALUE(0) |		 \
			 HWSTATUS_RBSY_MASK(NAND_STATUS_READY) | \
			 HWSTATUS_RBSY_VALUE(NAND_STATUS_READY))

#define HW_TIMEOUT	500	

void tegra_nand_controller_reset(struct tegra_nand_controller *ctrl)
{
	int err;

	disable_irq(ctrl->irq);

	err = reset_control_reset(ctrl->rst);
	if (err) {
		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
		msleep(HW_TIMEOUT);
	}

	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
	writel_relaxed(HWSTATUS_MASK, ctrl->regs + HWSTATUS_MASK);
	writel_relaxed(INT_MASK, ctrl->regs + ISR);

	reinit_completion(&ctrl->command_complete);
	reinit_completion(&ctrl->dma_complete);

	enable_irq(ctrl->irq);
}

...

	ret = wait_for_completion_timeout(&ctrl->command_complete,
					  msecs_to_jiffies(HW_TIMEOUT));
	if (ret <= 0) {
		if (ret == 0) {
			dev_err(ctrl->dev, "CMD timeout\n");
			tegra_nand_dump_reg(ctrl);
			ret = -ETIMEDOUT;
		} else {
			dev_err(ctrl->dev,
				"Failed to wait for CMD completion: %d\n",
				ret);
		}

		tegra_nand_controller_reset(ctrl);
		return ret;
	}

> +
> +	if (instr_data_in) {
> +		reg = readl_relaxed(ctrl->regs + RESP);
> +		memcpy(instr_data_in->ctx.data.buf.in + offset, &reg, size);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser tegra_nand_op_parser = NAND_OP_PARSER(
> +	NAND_OP_PARSER_PATTERN(tegra_nand_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN(tegra_nand_cmd,
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 4)),
> +	NAND_OP_PARSER_PATTERN(tegra_nand_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 4)),
> +	);
> +
> +static int tegra_nand_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			     bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &tegra_nand_op_parser, op,
> +				      check_only);
> +}
> +static void tegra_nand_select_chip(struct mtd_info *mtd, int chip_nr)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> +
> +	ctrl->cur_chip = chip_nr;
> +}
> +
> +static void tegra_nand_hw_ecc(struct tegra_nand_controller *ctrl,
> +			      struct nand_chip *chip, bool enable)
> +{
> +	u32 reg;
> +
> +	switch (chip->ecc.algo) {
> +	case NAND_ECC_RS:
> +		reg = readl_relaxed(ctrl->regs + CFG);
> +		if (enable)
> +			reg |= CFG_HW_ECC | CFG_ERR_COR;
> +		else
> +			reg &= ~(CFG_HW_ECC | CFG_ERR_COR);
> +		writel_relaxed(reg, ctrl->regs + CFG);
> +		break;
> +	case NAND_ECC_BCH:
> +		reg = readl_relaxed(ctrl->regs + BCH_CONFIG);
> +		if (enable)
> +			reg |= BCH_ENABLE;
> +		else
> +			reg &= ~BCH_ENABLE;
> +		writel_relaxed(reg, ctrl->regs + BCH_CONFIG);
> +		break;
> +	default:
> +		dev_err(ctrl->dev, "Unsupported hardware ECC algorithm\n");
> +		break;
> +	}
> +}
> +
> +static int tegra_nand_page_xfer(struct mtd_info *mtd, struct nand_chip *chip,
> +				void *buf, int oob_required, int page,
> +				bool read)
> +{
> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> +	struct tegra_nand_chip *nand = to_tegra_chip(chip);
> +	enum dma_data_direction dir = read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +	dma_addr_t dma_addr;
> +	u32 cmd, dma_ctrl;
> +	int ret, dma_len;
> +
> +	if (read) {
> +		writel_relaxed(NAND_CMD_READ0, ctrl->regs + CMD_1);
> +		writel_relaxed(NAND_CMD_READSTART, ctrl->regs + CMD_2);
> +	} else {
> +		writel_relaxed(NAND_CMD_SEQIN, ctrl->regs + CMD_1);
> +		writel_relaxed(NAND_CMD_PAGEPROG, ctrl->regs + CMD_2);
> +	}
> +	cmd = CMD_CLE | CMD_SEC_CMD;
> +
> +	/* Lower 16-bits are column, always 0 */
> +	writel_relaxed(page << 16, ctrl->regs + ADDR_1);
> +
> +	if (chip->options & NAND_ROW_ADDR_3) {
> +		writel_relaxed(page >> 16, ctrl->regs + ADDR_2);
> +		cmd |= CMD_ALE | CMD_ALE_SIZE(5);
> +	} else {
> +		cmd |= CMD_ALE | CMD_ALE_SIZE(4);
> +	}
> +
> +	dma_len = mtd->writesize + (oob_required ? mtd->oobsize : 0);
> +	dma_addr = dma_map_single(ctrl->dev, buf, dma_len, dir);
> +	ret = dma_mapping_error(ctrl->dev, dma_addr);
> +	if (ret) {
> +		dev_err(ctrl->dev, "dma mapping error\n");
> +		return -EINVAL;
> +	}
> +
> +	writel_relaxed(mtd->writesize - 1, ctrl->regs + DMA_CFG_A);
> +	writel_relaxed(dma_addr, ctrl->regs + DATA_PTR);
> +
> +	if (oob_required) {
> +		dma_addr_t dma_addr_tag = dma_addr + mtd->writesize;
> +
> +		writel_relaxed(nand->tag.length - 1, ctrl->regs + DMA_CFG_B);
> +		writel_relaxed(dma_addr_tag + nand->tag.offset,
> +			       ctrl->regs + TAG_PTR);
> +	} else {
> +		writel_relaxed(0, ctrl->regs + DMA_CFG_B);
> +		writel_relaxed(0, ctrl->regs + TAG_PTR);
> +	}
> +
> +	dma_ctrl = DMA_CTRL_GO | DMA_CTRL_PERF_EN |
> +		   DMA_CTRL_IE_DONE | DMA_CTRL_IS_DONE |
> +		   DMA_CTRL_BURST_16 | DMA_CTRL_EN_A;
> +	if (oob_required)
> +		dma_ctrl |= DMA_CTRL_EN_B;
> +	if (read)
> +		dma_ctrl |= DMA_CTRL_IN | DMA_CTRL_REUSE;
> +	else
> +		dma_ctrl |= DMA_CTRL_OUT;
> +
> +	writel_relaxed(dma_ctrl, ctrl->regs + DMA_CTRL);
> +
> +	cmd |= CMD_GO | CMD_RBSY_CHK | CMD_TRANS_SIZE(9) |
> +	       CMD_CE(ctrl->cur_chip) | CMD_A_VALID;
> +	if (oob_required)
> +		cmd |= CMD_B_VALID;
> +	if (read)
> +		cmd |= CMD_RX;
> +	else
> +		cmd |= CMD_TX | CMD_AFT_DAT;
> +
> +	writel_relaxed(cmd, ctrl->regs + CMD);
> +
> +	ret = wait_for_completion_timeout(&ctrl->command_complete,
> +					  msecs_to_jiffies(500));
> +	if (!ret) {
> +		dev_err(ctrl->dev, "CMD timeout\n");
> +		tegra_nand_dump_reg(ctrl);
> +		ret = -ETIMEDOUT;
> +		goto err_unmap_dma;
> +	}
> +
> +	ret = wait_for_completion_timeout(&ctrl->dma_complete,
> +					  msecs_to_jiffies(500));
> +	if (!ret) {
> +		dev_err(ctrl->dev, "DMA timeout\n");
> +		tegra_nand_dump_reg(ctrl);
> +		ret = -ETIMEDOUT;
> +		goto err_unmap_dma;
> +	}
> +	ret = 0;

Same as the above comment regarding the wait_for_completion_timeout().

> +
> +err_unmap_dma:
> +	dma_unmap_single(ctrl->dev, dma_addr, dma_len, dir);
> +
> +	return ret;
> +}
> +
> +static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
> +				      struct nand_chip *chip,
> +				      uint8_t *buf, int oob_required, int page)
> +{
> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> +	u32 dec_stat, max_corr_cnt;
> +	unsigned long fail_sec_flag;
> +	int ret;
> +
> +	tegra_nand_hw_ecc(ctrl, chip, true);
> +	ret = tegra_nand_page_xfer(mtd, chip, buf, oob_required, page, true);
> +	tegra_nand_hw_ecc(ctrl, chip, false);
> +	if (ret)
> +		return ret;
> +
> +	/* No correctable or un-correctable errors, page must have 0 bitflips */
> +	if (!ctrl->last_read_error)
> +		return 0;
> +
> +	/*
> +	 * Correctable or un-correctable errors occurred. Use DEC_STAT_BUF
> +	 * which contains information for all ECC selections.
> +	 *
> +	 * Note that since we do not use Command Queues DEC_RESULT does not
> +	 * state the number of pages we can read from the DEC_STAT_BUF. But
> +	 * since CORRFAIL_ERR did occur during page read we do have a valid
> +	 * result in DEC_STAT_BUF.
> +	 */
> +	ctrl->last_read_error = false;
> +	dec_stat = readl_relaxed(ctrl->regs + DEC_STAT_BUF);
> +
> +	fail_sec_flag = (dec_stat & DEC_STAT_BUF_FAIL_SEC_FLAG_MASK) >>
> +			DEC_STAT_BUF_FAIL_SEC_FLAG_SHIFT;
> +
> +	max_corr_cnt = (dec_stat & DEC_STAT_BUF_MAX_CORR_CNT_MASK) >>
> +		       DEC_STAT_BUF_MAX_CORR_CNT_SHIFT;
> +
> +	if (fail_sec_flag) {
> +		int bit, max_bitflips = 0;
> +
> +		/*
> +		 * Check if all sectors in a page failed. If only some failed
> +		 * its definitly not an erased page and we can return error
> +		 * stats right away.
> +		 *
> +		 * E.g. controller might return fail_sec_flag with 0x4, which
> +		 * would mean only the third sector failed to correct.
> +		 */
> +		if (fail_sec_flag ^ GENMASK(chip->ecc.steps - 1, 0)) {
> +			mtd->ecc_stats.failed += hweight8(fail_sec_flag);
> +			return max_corr_cnt;
> +		}
> +
> +		/*
> +		 * All sectors failed to correct, but the ECC isn't smart
> +		 * enough to figure out if a page is really completely erased.
> +		 * We check the read data here to figure out if it's a
> +		 * legitimate ECC error or only an erased page.
> +		 */
> +		for_each_set_bit(bit, &fail_sec_flag, chip->ecc.steps) {
> +			u8 *data = buf + (chip->ecc.size * bit);
> +
> +			ret = nand_check_erased_ecc_chunk(data, chip->ecc.size,
> +							  NULL, 0,
> +							  NULL, 0,
> +							  chip->ecc.strength);
> +			if (ret < 0)
> +				mtd->ecc_stats.failed++;
> +			else
> +				max_bitflips = max(ret, max_bitflips);
> +		}
> +
> +		return max_t(unsigned int, max_corr_cnt, max_bitflips);
> +	} else {
> +		int corr_sec_flag;
> +
> +		corr_sec_flag = (dec_stat & DEC_STAT_BUF_CORR_SEC_FLAG_MASK) >>
> +				DEC_STAT_BUF_CORR_SEC_FLAG_SHIFT;
> +
> +		/*
> +		 * The value returned in the register is the maximum of
> +		 * bitflips encountered in any of the ECC regions. As there is
> +		 * no way to get the number of bitflips in a specific regions
> +		 * we are not able to deliver correct stats but instead
> +		 * overestimate the number of corrected bitflips by assuming
> +		 * that all regions where errors have been corrected
> +		 * encountered the maximum number of bitflips.
> +		 */
> +		mtd->ecc_stats.corrected += max_corr_cnt * hweight8(corr_sec_flag);
> +
> +		return max_corr_cnt;
> +	}
> +
> +}
> +
> +static int tegra_nand_write_page_hwecc(struct mtd_info *mtd,
> +				       struct nand_chip *chip,
> +				       const uint8_t *buf, int oob_required,
> +				       int page)
> +{
> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> +	int ret;
> +
> +	tegra_nand_hw_ecc(ctrl, chip, true);
> +	ret = tegra_nand_page_xfer(mtd, chip, (void *)buf, oob_required, page,
> +				   false);
> +	tegra_nand_hw_ecc(ctrl, chip, false);
> +
> +	return ret;
> +}
> +
> +static void tegra_nand_setup_timing(struct tegra_nand_controller *ctrl,
> +				    const struct nand_sdr_timings *timings)
> +{
> +	/*
> +	 * The period (and all other timings in this function) is in ps,
> +	 * so need to take care here to avoid integer overflows.
> +	 */
> +	unsigned int rate = clk_get_rate(ctrl->clk) / 1000000;
> +	unsigned int period = DIV_ROUND_UP(1000000, rate);
> +	u32 val, reg = 0;
> +
> +	val = DIV_ROUND_UP(max3(timings->tAR_min, timings->tRR_min,
> +				timings->tRC_min), period);
> +	reg |= TIMING_TCR_TAR_TRR(OFFSET(val, 3));
> +
> +	val = DIV_ROUND_UP(max(max(timings->tCS_min, timings->tCH_min),
> +			       max(timings->tALS_min, timings->tALH_min)),
> +			   period);
> +	reg |= TIMING_TCS(OFFSET(val, 2));
> +
> +	val = DIV_ROUND_UP(max(timings->tRP_min, timings->tREA_max) + 6000,
> +			   period);
> +	reg |= TIMING_TRP(OFFSET(val, 1)) | TIMING_TRP_RESP(OFFSET(val, 1));
> +
> +	reg |= TIMING_TWB(OFFSET(DIV_ROUND_UP(timings->tWB_max, period), 1));
> +	reg |= TIMING_TWHR(OFFSET(DIV_ROUND_UP(timings->tWHR_min, period), 1));
> +	reg |= TIMING_TWH(OFFSET(DIV_ROUND_UP(timings->tWH_min, period), 1));
> +	reg |= TIMING_TWP(OFFSET(DIV_ROUND_UP(timings->tWP_min, period), 1));
> +	reg |= TIMING_TRH(OFFSET(DIV_ROUND_UP(timings->tREH_min, period), 1));
> +
> +	writel_relaxed(reg, ctrl->regs + TIMING_1);
> +
> +	val = DIV_ROUND_UP(timings->tADL_min, period);
> +	reg = TIMING_TADL(OFFSET(val, 3));
> +
> +	writel_relaxed(reg, ctrl->regs + TIMING_2);
> +}
> +
> +static int tegra_nand_setup_data_interface(struct mtd_info *mtd, int csline,
> +					   const struct nand_data_interface *conf)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
> +	const struct nand_sdr_timings *timings;
> +
> +	timings = nand_get_sdr_timings(conf);
> +	if (IS_ERR(timings))
> +		return PTR_ERR(timings);
> +
> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;
> +
> +	tegra_nand_setup_timing(ctrl, timings);
> +
> +	return 0;
> +}
> +
> +
> +const int rs_strength_bootable[] = { 4 };
> +const int rs_strength[] = { 4, 6, 8 };
> +const int bch_strength_bootable[] = { 8, 16 };
> +const int bch_strength[] = { 4, 8, 14, 16 };

These const's shall be 'static'.

> +
> +static int tegra_nand_get_strength(struct nand_chip *chip, const int *strength,
> +				   int strength_len, int oobsize)
> +{
> +	bool maximize = chip->ecc.options & NAND_ECC_MAXIMIZE;
> +	int i;
> +
> +	/*
> +	 * Loop through available strengths. Backwards in case we try to
> +	 * maximize the BCH strength.
> +	 */
> +	for (i = 0; i < strength_len; i++) {
> +		int strength_sel, bytes_per_step, bytes_per_page;
> +
> +		if (maximize) {
> +			strength_sel = strength[strength_len - i - 1];
> +		} else {
> +			strength_sel = strength[i];
> +
> +			if (strength_sel < chip->ecc_strength_ds)
> +				continue;
> +		}
> +
> +		bytes_per_step = DIV_ROUND_UP(BITS_PER_STEP_BCH * strength_sel,
> +					      BITS_PER_BYTE);
> +		bytes_per_page = round_up(bytes_per_step * chip->ecc.steps, 4);
> +
> +		/* Check whether strength fits OOB */
> +		if (bytes_per_page < (oobsize - SKIP_SPARE_BYTES))
> +			return strength_sel;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int tegra_nand_select_strength(struct nand_chip *chip, int oobsize)
> +{
> +	const int *strength;
> +	int strength_len;
> +
> +	switch (chip->ecc.algo) {
> +	case NAND_ECC_RS:
> +		if (chip->options & NAND_IS_BOOT_MEDIUM) {
> +			strength = rs_strength_bootable;
> +			strength_len = ARRAY_SIZE(rs_strength_bootable);
> +		} else {
> +			strength = rs_strength;
> +			strength_len = ARRAY_SIZE(rs_strength);
> +		}
> +		break;
> +	case NAND_ECC_BCH:
> +		if (chip->options & NAND_IS_BOOT_MEDIUM) {
> +			strength = bch_strength_bootable;
> +			strength_len = ARRAY_SIZE(bch_strength_bootable);
> +		} else {
> +			strength = bch_strength;
> +			strength_len = ARRAY_SIZE(bch_strength);
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return tegra_nand_get_strength(chip, strength, strength_len, oobsize);
> +}
> +
> +static int tegra_nand_chips_init(struct device *dev,
> +				 struct tegra_nand_controller *ctrl)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *np_nand;
> +	int nchips = of_get_child_count(np);
> +	struct tegra_nand_chip *nand;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	unsigned long config, bch_config = 0;
> +	int bits_per_step;
> +	int ret;
> +
> +	if (nchips != 1) {
> +		dev_err(dev, "Currently only one NAND chip supported\n");
> +		return -EINVAL;
> +	}
> +
> +	np_nand = of_get_next_child(np, NULL);
> +
> +	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
> +
> +	if (IS_ERR(nand->wp_gpio)) {
> +		ret = PTR_ERR(nand->wp_gpio);
> +		dev_err(dev, "Failed to request WP GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	chip = &nand->chip;
> +	chip->controller = &ctrl->controller;
> +
> +	mtd = nand_to_mtd(chip);
> +
> +	mtd->dev.parent = dev;
> +	if (!mtd->name)
> +		mtd->name = "tegra_nand";
> +	mtd->owner = THIS_MODULE;
> +
> +	nand_set_flash_node(chip, np_nand);
> +
> +	chip->options = NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;
> +	chip->exec_op = tegra_nand_exec_op;
> +	chip->select_chip = tegra_nand_select_chip;
> +	chip->setup_data_interface = tegra_nand_setup_data_interface;
> +
> +	ret = nand_scan_ident(mtd, 1, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	chip->ecc.mode = NAND_ECC_HW;
> +	chip->ecc.size = 512;
> +	chip->ecc.steps = mtd->writesize / chip->ecc.size;
> +	if (chip->ecc_step_ds != 512) {
> +		dev_err(dev, "Unsupported step size %d\n", chip->ecc_step_ds);
> +		return -EINVAL;
> +	}
> +
> +	chip->ecc.read_page = tegra_nand_read_page_hwecc;
> +	chip->ecc.write_page = tegra_nand_write_page_hwecc;
> +
> +	config = readl_relaxed(ctrl->regs + CFG);
> +	config |= CFG_PIPE_EN | CFG_SKIP_SPARE | CFG_SKIP_SPARE_SIZE_4;
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		config |= CFG_BUS_WIDTH_16;
> +
> +	if (chip->ecc.algo == NAND_ECC_UNKNOWN) {
> +		if (mtd->writesize < 2048)
> +			chip->ecc.algo = NAND_ECC_RS;
> +		else
> +			chip->ecc.algo = NAND_ECC_BCH;
> +	}
> +
> +	if (chip->ecc.algo == NAND_ECC_BCH && mtd->writesize < 2048) {
> +		dev_err(dev, "BCH supportes 2K or 4K page size only\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!chip->ecc.strength) {
> +		ret = tegra_nand_select_strength(chip, mtd->oobsize);
> +		if (ret < 0) {
> +			dev_err(dev, "No valid strenght found, minimum %d\n",
> +				chip->ecc_strength_ds);
> +			return ret;
> +		}
> +
> +		chip->ecc.strength = ret;
> +	}
> +
> +	switch (chip->ecc.algo) {
> +	case NAND_ECC_RS:
> +		bits_per_step = BITS_PER_STEP_RS * chip->ecc.strength;
> +		mtd_set_ooblayout(mtd, &tegra_nand_oob_rs_ops);
> +		switch (chip->ecc.strength) {
> +		case 4:
> +			config |= CFG_ECC_SEL | CFG_TVAL_4;
> +			break;
> +		case 6:
> +			config |= CFG_ECC_SEL | CFG_TVAL_6;
> +			break;
> +		case 8:
> +			config |= CFG_ECC_SEL | CFG_TVAL_8;
> +			break;
> +		default:
> +			dev_err(dev, "ECC strength %d not supported\n",
> +				chip->ecc.strength);
> +			return -EINVAL;
> +		}
> +		break;
> +	case NAND_ECC_BCH:
> +		bits_per_step = BITS_PER_STEP_BCH * chip->ecc.strength;
> +		mtd_set_ooblayout(mtd, &tegra_nand_oob_bch_ops);
> +		switch (chip->ecc.strength) {
> +		case 4:
> +			bch_config = BCH_TVAL_4;
> +			break;
> +		case 8:
> +			bch_config = BCH_TVAL_8;
> +			break;
> +		case 14:
> +			bch_config = BCH_TVAL_14;
> +			break;
> +		case 16:
> +			bch_config = BCH_TVAL_16;
> +			break;
> +		default:
> +			dev_err(dev, "ECC strength %d not supported\n",
> +				chip->ecc.strength);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		dev_err(dev, "ECC algorithm not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "Using %s with strength %d per 512 byte step\n",
> +			chip->ecc.algo == NAND_ECC_BCH ? "BCH" : "RS",
> +			chip->ecc.strength);
> +
> +	chip->ecc.bytes = DIV_ROUND_UP(bits_per_step, BITS_PER_BYTE);
> +
> +	switch (mtd->writesize) {
> +	case 256:
> +		config |= CFG_PS_256;
> +		break;
> +	case 512:
> +		config |= CFG_PS_512;
> +		break;
> +	case 1024:
> +		config |= CFG_PS_1024;
> +		break;
> +	case 2048:
> +		config |= CFG_PS_2048;
> +		break;
> +	case 4096:
> +		config |= CFG_PS_4096;
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported writesize %d\n", mtd->writesize);
> +		return -ENODEV;
> +	}
> +
> +	writel_relaxed(config, ctrl->regs + CFG);
> +	writel_relaxed(bch_config, ctrl->regs + BCH_CONFIG);
> +
> +	ret = nand_scan_tail(mtd);
> +	if (ret)
> +		return ret;
> +
> +	mtd_ooblayout_free(mtd, 0, &nand->tag);
> +
> +	config |= CFG_TAG_BYTE_SIZE(nand->tag.length - 1);
> +	writel_relaxed(config, ctrl->regs + CFG);
> +
> +	ret = mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "Failed to register mtd device: %d\n", ret);
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	ctrl->chip = chip;
> +
> +	return 0;
> +}
> +
> +static int tegra_nand_probe(struct platform_device *pdev)
> +{
> +	struct reset_control *rst;
> +	struct tegra_nand_controller *ctrl;
> +	struct resource *res;
> +	unsigned long reg;
> +	int irq, err = 0;
> +
> +	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	ctrl->dev = &pdev->dev;
> +	nand_hw_control_init(&ctrl->controller);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctrl->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctrl->regs))
> +		return PTR_ERR(ctrl->regs);
> +
> +	rst = devm_reset_control_get(&pdev->dev, "nand");
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	ctrl->clk = devm_clk_get(&pdev->dev, "nand");
> +	if (IS_ERR(ctrl->clk))
> +		return PTR_ERR(ctrl->clk);
> +
> +	err = clk_prepare_enable(ctrl->clk);
> +	if (err)
> +		return err;
> +
> +	err = reset_control_reset(rst);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	reg = HWSTATUS_RDSTATUS_MASK(1) | HWSTATUS_RDSTATUS_VALUE(0) |
> +		HWSTATUS_RBSY_MASK(NAND_STATUS_READY) |
> +		HWSTATUS_RBSY_VALUE(NAND_STATUS_READY);
> +	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
> +	writel_relaxed(reg, ctrl->regs + HWSTATUS_MASK);
> +
> +	init_completion(&ctrl->command_complete);
> +	init_completion(&ctrl->dma_complete);
> +
> +	/* clear interrupts */
> +	reg = readl_relaxed(ctrl->regs + ISR);
> +	writel_relaxed(reg, ctrl->regs + ISR);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	err = devm_request_irq(&pdev->dev, irq, tegra_nand_irq, 0,
> +			       dev_name(&pdev->dev), ctrl);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	writel_relaxed(DMA_CTRL_IS_DONE, ctrl->regs + DMA_CTRL);
> +
> +	/* enable interrupts */
> +	reg = IER_UND | IER_OVR | IER_CMD_DONE | IER_GIE;
> +	writel_relaxed(reg, ctrl->regs + IER);
> +
> +	/* reset config */
> +	writel_relaxed(0, ctrl->regs + CFG);
> +
> +	err = tegra_nand_chips_init(ctrl->dev, ctrl);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	platform_set_drvdata(pdev, ctrl);
> +
> +	return 0;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(ctrl->clk);
> +	return err;
> +}
> +
> +static int tegra_nand_remove(struct platform_device *pdev)
> +{
> +	struct tegra_nand_controller *ctrl = platform_get_drvdata(pdev);
> +
> +	nand_release(nand_to_mtd(ctrl->chip));
> +
> +	clk_disable_unprepare(ctrl->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tegra_nand_of_match[] = {
> +	{ .compatible = "nvidia,tegra20-nand" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver tegra_nand_driver = {
> +	.driver = {
> +		.name = "tegra-nand",
> +		.of_match_table = tegra_nand_of_match,
> +	},
> +	.probe = tegra_nand_probe,
> +	.remove = tegra_nand_remove,
> +};
> +module_platform_driver(tegra_nand_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA Tegra NAND driver");
> +MODULE_AUTHOR("Thierry Reding <thierry.reding@nvidia.com>");
> +MODULE_AUTHOR("Lucas Stach <dev@lynxeye.de>");
> +MODULE_AUTHOR("Stefan Agner <stefan@agner.ch>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(of, tegra_nand_of_match);
> 
