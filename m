Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C4721473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548786002;
	bh=GlTXIZSKmjDAc4AIOyt5qx7R4ShMg6XUUC8pbMA9vR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TAA2mN63DgBkaBVw3YGFnT3NhUkRar6IkCWET48RfbOH6k5+01kMRZXxfKI4gTU9U
	 tkWMJK4/aSSlNzsTKHeeLsfLNBFyVtHH6KoDr7GakHHVTuzysfds4wzuJsFY2Drz28
	 bEowvmd1uvydGgQIZp+JqcliamXSV6pYYJWzjsj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfA2SUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfA2SUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:20:00 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2886320857;
        Tue, 29 Jan 2019 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548785998;
        bh=GlTXIZSKmjDAc4AIOyt5qx7R4ShMg6XUUC8pbMA9vR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R9kT53AevEO6JVaq5RlpEbRQZKThYwR18OVSSRs07qlF2pXpoEAypFOSu0ox++Rzr
         A5XDT32oOkbgrVw+a2/cyqpy0YtaVBa+QszoVQp1YIhO6xIwGcweTarmUFsSxhc7fC
         7yZWNz28dvUjcdxTCiKLjcQqjGR3DAtaijGuxMZI=
Date:   Tue, 29 Jan 2019 19:19:44 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190129191944.74e1e7fe@bbrezillon>
In-Reply-To: <20190129160743.9103-1-piotrs@cadence.com>
References: <20190129160337.24350-1-piotrs@cadence.com>
        <20190129160743.9103-1-piotrs@cadence.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 16:07:43 +0000
Piotr Sroka <piotrs@cadence.com> wrote:

> This patch adds driver for Cadence HPNFC NAND controller.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mtd/nand/raw/Kconfig        |    8 +
>  drivers/mtd/nand/raw/Makefile       |    1 +
>  drivers/mtd/nand/raw/cadence_nand.c | 2655 +++++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/raw/cadence_nand.h |  631 +++++++++
>  4 files changed, 3295 insertions(+)

I'm already afraid by the diff stat. NAND controller drivers are
usually around 2000 lines, sometimes even less. I'm sure you can
simplify this driver a bit.

>  create mode 100644 drivers/mtd/nand/raw/cadence_nand.c

I prefer - over _, and I think we should start naming NAND controller
drivers <vendor>-nand-controller.c instead of <vendor>-nand.c 

>  create mode 100644 drivers/mtd/nand/raw/cadence_nand.h

No need to add a header file if it's only used by cadence_nand.c, just
move the definitions directly in the .c file.

> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 1a55d3e3d4c5..742dcc947203 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -541,4 +541,12 @@ config MTD_NAND_TEGRA
>  	  is supported. Extra OOB bytes when using HW ECC are currently
>  	  not supported.
>  
> +config MTD_NAND_CADENCE
> +	tristate "Support Cadence NAND (HPNFC) controller"
> +	depends on OF
> +	help
> +	  Enable the driver for NAND flash on platforms using a Cadence NAND
> +	  controller.
> +
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 57159b349054..9c1301164996 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
>  obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> +obj-$(CONFIG_MTD_NAND_CADENCE)		+= cadence_nand.o
>  
>  nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_onfi.o
> diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
> new file mode 100644
> index 000000000000..c941e702d325
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/cadence_nand.c
> @@ -0,0 +1,2655 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Cadence NAND flash controller driver
> + *
> + * Copyright (C) 2019 Cadence
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>

I haven't checked, but please make sure you actually need to include
all these headers.

> +
> +#include "cadence_nand.h"
> +
> +MODULE_LICENSE("GPL v2");

Move the MODULE_LICENSE() at the end of the file next to
MODULE_AUTHOR()/MODULE_DESCRIPTION().

> +#define CADENCE_NAND_NAME    "cadence_nand"

cadence-nand-controller, and no need to use a macro for that, just put
the name directly where needed.

> +
> +#define MAX_OOB_SIZE_PER_SECTOR	32
> +#define MAX_ADDRESS_CYC		6
> +#define MAX_DATA_SIZE		0xFFFC
> +
> +static int cadence_nand_wait_for_thread(struct cdns_nand_info *cdns_nand,
> +					int8_t thread);
> +static int cadence_nand_wait_for_idle(struct cdns_nand_info *cdns_nand);
> +static int cadence_nand_cmd(struct nand_chip *chip,
> +			    const struct nand_subop *subop);
> +static int cadence_nand_waitrdy(struct nand_chip *chip,
> +				const struct nand_subop *subop);

Please avoid forward declaration unless it's really needed (which I'm
pretty sure is not the case here).

> +
> +static const struct nand_op_parser cadence_nand_op_parser = NAND_OP_PARSER(
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd,

Since you have separate parser pattern what the point of using the same
function which then has a switch-case on the instruction type.

> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd,
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, MAX_DATA_SIZE)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_cmd,
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, MAX_DATA_SIZE)),
> +	NAND_OP_PARSER_PATTERN(
> +		cadence_nand_waitrdy,
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false))
> +	);

Are you sure you can't pack several instructions into an atomic
controller operation? I'd be surprised if that was not the case...

> +
> +static inline struct cdns_nand_info *mtd_cdns_nand_info(struct mtd_info *mtd)

Drop the inline specifier, the compiler is smart enough to figure it
out.

> +{
> +	return container_of(mtd_to_nand(mtd), struct cdns_nand_info, chip);
> +}

You should no longer need this helper since we're only passing chip
objects now.

> +
> +static inline struct
> +cdns_nand_info *chip_to_cdns_nand_info(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct cdns_nand_info, chip);
> +}

Please move this helper just after the cdns_nand_info struct definition.

> +
> +static inline bool

Drop the inline.

> +cadence_nand_dma_buf_ok(struct cdns_nand_info *cdns_nand, const void *buf,
> +			u32 buf_len)
> +{
> +	u8 data_dma_width = cdns_nand->caps.data_dma_width;
> +
> +	return buf && virt_addr_valid(buf) &&
> +		likely(IS_ALIGNED((uintptr_t)buf, data_dma_width)) &&
> +		likely(IS_ALIGNED(buf_len, data_dma_width));
> +}
> +

...

> +static int cadence_nand_set_ecc_strength(struct cdns_nand_info *cdns_nand,
> +					 u8 strength)
> +{
> +	u32 reg;
> +	u8 i, corr_str_idx = 0;
> +
> +	if (cadence_nand_wait_for_idle(cdns_nand)) {
> +		dev_err(cdns_nand->dev, "Error. Controller is busy");
> +		return -ETIMEDOUT;
> +	}
> +
> +	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
> +		if (cdns_nand->ecc_strengths[i] == strength) {
> +			corr_str_idx = i;
> +			break;
> +		}
> +	}

The index should be retrieved at init time and stored somewhere to avoid
searching it every time this function is called.

> +
> +	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
> +	reg &= ~ECC_CONFIG_0_CORR_STR;
> +	reg |= FIELD_PREP(ECC_CONFIG_0_CORR_STR, corr_str_idx);
> +	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
> +
> +	return 0;
> +}
> +

...

> +
> +static int cadence_nand_set_erase_detection(struct cdns_nand_info *cdns_nand,
> +					    bool enable,
> +					    u8 bitflips_threshold)
> +{
> +	u32 reg;
> +
> +	if (cadence_nand_wait_for_idle(cdns_nand)) {
> +		dev_err(cdns_nand->dev, "Error. Controller is busy");
> +		return -ETIMEDOUT;
> +	}
> +
> +	reg = readl(cdns_nand->reg + ECC_CONFIG_0);
> +
> +	if (enable)
> +		reg |= ECC_CONFIG_0_ERASE_DET_EN;
> +	else
> +		reg &= ~ECC_CONFIG_0_ERASE_DET_EN;
> +
> +	writel(reg, cdns_nand->reg + ECC_CONFIG_0);
> +
> +	writel(bitflips_threshold, cdns_nand->reg + ECC_CONFIG_1);

I'm curious, is the threshold defining the max number of bitflips in a 
page or in an ECC-chunk (ecc_step_size)?

> +
> +	return 0;
> +}
> +
> +static int cadence_nand_set_access_width(struct cdns_nand_info *cdns_nand,
> +					 u8 access_width)

Or you can simply pass 'bool 16bit_bus' since the bus is either 8 or 16
bits wide.

> +{
> +	u32 reg;
> +	int status;
> +
> +	status = cadence_nand_wait_for_idle(cdns_nand);
> +	if (status) {
> +		dev_err(cdns_nand->dev, "Error. Controller is busy");
> +		return status;
> +	}
> +
> +	reg = readl(cdns_nand->reg + COMMON_SET);
> +
> +	if (access_width == 8)
> +		reg &= ~COMMON_SET_DEVICE_16BIT;
> +	else
> +		reg |= COMMON_SET_DEVICE_16BIT;
> +	writel(reg, cdns_nand->reg + COMMON_SET);
> +
> +	return 0;
> +}
> +

...

> +static void
> +cadence_nand_wait_for_irq(struct cdns_nand_info *cdns_nand,
> +			  struct cadence_nand_irq_status *irq_mask,
> +			  struct cadence_nand_irq_status *irq_status)
> +{
> +	unsigned long timeout = msecs_to_jiffies(10000);
> +	unsigned long comp_res;
> +
> +	do {
> +		comp_res = wait_for_completion_timeout(&cdns_nand->complete,
> +						       timeout);
> +		spin_lock_irq(&cdns_nand->irq_lock);
> +		*irq_status = cdns_nand->irq_status;
> +
> +		if ((irq_status->status & irq_mask->status) ||
> +		    (irq_status->trd_status & irq_mask->trd_status) ||
> +		    (irq_status->trd_error & irq_mask->trd_error)) {
> +			cdns_nand->irq_status.status &= ~irq_mask->status;
> +			cdns_nand->irq_status.trd_status &=
> +				~irq_mask->trd_status;
> +			cdns_nand->irq_status.trd_error &= ~irq_mask->trd_error;
> +			spin_unlock_irq(&cdns_nand->irq_lock);
> +			/* our interrupt was detected */
> +			break;
> +		}
> +
> +		/*
> +		 * these are not the interrupts you are looking for;
> +		 * need to wait again
> +		 */
> +		spin_unlock_irq(&cdns_nand->irq_lock);
> +	} while (comp_res != 0);
> +
> +	if (comp_res == 0) {
> +		/* timeout */
> +		dev_err(cdns_nand->dev, "timeout occurred:\n");
> +		dev_err(cdns_nand->dev, "\tstatus = 0x%x, mask = 0x%x\n",
> +			irq_status->status, irq_mask->status);
> +		dev_err(cdns_nand->dev,
> +			"\ttrd_status = 0x%x, trd_status mask = 0x%x\n",
> +			irq_status->trd_status, irq_mask->trd_status);
> +		dev_err(cdns_nand->dev,
> +			"\t trd_error = 0x%x, trd_error mask = 0x%x\n",
> +			irq_status->trd_error, irq_mask->trd_error);
> +
> +		memset(irq_status, 0, sizeof(struct cadence_nand_irq_status));
> +	}

Can't we simplify that by enabling interrupts on demand and adding a
logic to complete() the completion obj only when all expected events are
received.

> +}
> +
> +static void
> +cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_info *cdns_nand)
> +{
> +	/* disable interrupts */
> +	writel(INTR_ENABLE_INTR_EN, cdns_nand->reg + INTR_ENABLE);
> +	free_irq(irqnum, cdns_nand);

You don't need that if you use devm_request_irq(), do you?

> +}
> +
> +/* wait until NAND flash device is ready */
> +static int wait_for_rb_ready(struct cdns_nand_info *cdns_nand,
> +			     unsigned int timeout_ms)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	u32 reg;
> +
> +	do {
> +		reg = readl(cdns_nand->reg + RBN_SETINGS);
> +		reg = (reg >> cdns_nand->chip.cur_cs) & 0x01;
> +		cpu_relax();
> +	} while ((reg == 0) && time_before(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		dev_err(cdns_nand->dev,
> +			"Timeout while waiting for flash device %d ready\n",
> +			cdns_nand->chip.cur_cs);
> +		return -ETIMEDOUT;
> +	}

Please use readl_poll_timeout() instead of open-coding it.

> +	return 0;
> +}
> +
> +static int
> +cadence_nand_wait_for_thread(struct cdns_nand_info *cdns_nand, int8_t thread)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +	u32 reg;
> +
> +	do {
> +		/* get busy status of all threads */
> +		reg = readl(cdns_nand->reg + TRD_STATUS);
> +		/* mask all threads but selected */
> +		reg &=	(1 << thread);
> +	} while (reg && time_before(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		dev_err(cdns_nand->dev,
> +			"Timeout while waiting for thread  %d\n",
> +			thread);
> +		return -ETIMEDOUT;
> +	}

Same here, and you can probably use a common helper where you'll pass
the regs and events you're waiting for instead of duplicating the
function.

> +
> +	return 0;
> +}
> +
> +static int cadence_nand_wait_for_idle(struct cdns_nand_info *cdns_nand)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +	u32 reg;
> +
> +	do {
> +		reg = readl(cdns_nand->reg + CTRL_STATUS);
> +	} while ((reg & CTRL_STATUS_CTRL_BUSY) &&
> +		 time_before(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		dev_err(cdns_nand->dev, "Timeout while waiting for controller idle\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +/*  This function waits for device initialization */
> +static int wait_for_init_complete(struct cdns_nand_info *cdns_nand)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10000);
> +	u32 reg;
> +
> +	do {/* get ctrl status register */
> +		reg = readl(cdns_nand->reg + CTRL_STATUS);
> +	} while (((reg & CTRL_STATUS_INIT_COMP) == 0) &&
> +		 time_before(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		dev_err(cdns_nand->dev,
> +			"Timeout while waiting for controller init complete\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +

Same goes for the above 2 funcs.

> +/* execute generic command on NAND controller */
> +static int cadence_nand_generic_cmd_send(struct cdns_nand_info *cdns_nand,
> +					 u8 thread_nr,
> +					 u64 mini_ctrl_cmd,
> +					 u8 use_intr)
> +{
> +	u32 mini_ctrl_cmd_l = mini_ctrl_cmd & 0xFFFFFFFF;
> +	u32 mini_ctrl_cmd_h = mini_ctrl_cmd >> 32;
> +	u32 reg = 0;
> +	u8 status;
> +
> +	status = cadence_nand_wait_for_thread(cdns_nand, thread_nr);
> +	if (status) {
> +		dev_err(cdns_nand->dev,
> +			"controller thread is busy cannot execute command\n");
> +		return status;
> +	}
> +
> +	cadence_nand_reset_irq(cdns_nand);
> +
> +	writel(mini_ctrl_cmd_l, cdns_nand->reg + CMD_REG2);
> +	writel(mini_ctrl_cmd_h, cdns_nand->reg + CMD_REG3);
> +
> +	/* select generic command */
> +	reg |= FIELD_PREP(CMD_REG0_CT, CMD_REG0_CT_GEN);
> +	/* thread number */
> +	reg |= FIELD_PREP(CMD_REG0_TN, thread_nr);
> +	if (use_intr)
> +		reg |= CMD_REG0_INT;
> +
> +	/* issue command */
> +	writel(reg, cdns_nand->reg + CMD_REG0);
> +
> +	return 0;
> +}
> +
> +/* wait for data on slave dma interface */
> +static int cadence_nand_wait_on_sdma(struct cdns_nand_info *cdns_nand,
> +				     u8 *out_sdma_trd,
> +				     u32 *out_sdma_size)
> +{
> +	struct cadence_nand_irq_status irq_mask, irq_status;
> +
> +	irq_mask.trd_status = 0;
> +	irq_mask.trd_error = 0;
> +	irq_mask.status = INTR_STATUS_SDMA_TRIGG
> +		| INTR_STATUS_SDMA_ERR
> +		| INTR_STATUS_UNSUPP_CMD;
> +
> +	cadence_nand_wait_for_irq(cdns_nand, &irq_mask, &irq_status);
> +	if (irq_status.status == 0) {
> +		dev_err(cdns_nand->dev, "Timeout while waiting for SDMA\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (irq_status.status & INTR_STATUS_SDMA_TRIGG) {
> +		*out_sdma_size = readl(cdns_nand->reg + SDMA_SIZE);
> +		*out_sdma_trd  = readl(cdns_nand->reg + SDMA_TRD_NUM);
> +		*out_sdma_trd =
> +			FIELD_GET(SDMA_TRD_NUM_SDMA_TRD, *out_sdma_trd);
> +	} else {
> +		dev_err(cdns_nand->dev, "SDMA error - irq_status %x\n",
> +			irq_status.status);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +

...

> +/* ECC size depends on configured ECC strength and on maximum supported

Please use C-ctyle comments:

/*
 * blabla.
 */

> + * ECC step size
> + */
> +static int cadence_nand_calc_ecc_bytes(int max_step_size, int strength)
> +{
> +	u32 result;
> +	u8 mult;
> +
> +	switch (max_step_size) {
> +	case 256:
> +		mult = 12;
> +		break;
> +	case 512:
> +		mult = 13;
> +		break;
> +	case 1024:
> +		mult = 14;
> +		break;
> +	case 2048:
> +		mult = 15;
> +		break;
> +	case 4096:
> +		mult = 16;
> +		break;
> +	default:
> +		pr_err("%s: max_step_size %d\n", __func__, max_step_size);
> +		return -EINVAL;
> +	}
> +
> +	result = (mult * strength) / 16;
> +	/* round up */
> +	if ((result * 16) < (mult * strength))
> +		result++;
> +
> +	/* check bit size per one sector */
> +	result = 2 * result;
> +
> +	return result;
> +}

This can be simplified into

static int cadence_nand_calc_ecc_bytes(int step_size, int strength)
{
	int nbytes = DIV_ROUND_UP(fls(8 * step_size) * strength, 8);

	return ALIGN(nbytes, 2);
}

> +
> +static int cadence_nand_calc_ecc_bytes_256(int step_size, int strength)
> +{
> +	return cadence_nand_calc_ecc_bytes(256, strength);
> +}
> +
> +static int cadence_nand_calc_ecc_bytes_512(int step_size, int strength)
> +{
> +	return cadence_nand_calc_ecc_bytes(512, strength);
> +}
> +
> +static int cadence_nand_calc_ecc_bytes_1024(int step_size, int strength)
> +{
> +	return cadence_nand_calc_ecc_bytes(1024, strength);
> +}
> +
> +static int cadence_nand_calc_ecc_bytes_2048(int step_size, int strength)
> +{
> +	return  cadence_nand_calc_ecc_bytes(2048, strength);
> +}
> +
> +static int cadence_nand_calc_ecc_bytes_4096(int step_size, int strength)
> +{
> +	return  cadence_nand_calc_ecc_bytes(4096, strength);
> +}

And you absolutely don't need those wrappers, just use
cadence_nand_calc_ecc_bytes() directly.

> +
> +/* function reads BCH configuration  */
> +static int cadence_nand_read_bch_cfg(struct cdns_nand_info *cdns_nand)
> +{
> +	struct nand_ecc_caps *ecc_caps = &cdns_nand->ecc_caps;
> +	int max_step_size = 0;
> +	int nstrengths;
> +	u32 reg;
> +	int i;
> +
> +	reg = readl(cdns_nand->reg + BCH_CFG_0);
> +	cdns_nand->ecc_strengths[0] = FIELD_GET(BCH_CFG_0_CORR_CAP_0, reg);
> +	cdns_nand->ecc_strengths[1] = FIELD_GET(BCH_CFG_0_CORR_CAP_1, reg);
> +	cdns_nand->ecc_strengths[2] = FIELD_GET(BCH_CFG_0_CORR_CAP_2, reg);
> +	cdns_nand->ecc_strengths[3] = FIELD_GET(BCH_CFG_0_CORR_CAP_3, reg);
> +
> +	reg = readl(cdns_nand->reg + BCH_CFG_1);
> +	cdns_nand->ecc_strengths[4] = FIELD_GET(BCH_CFG_1_CORR_CAP_4, reg);
> +	cdns_nand->ecc_strengths[5] = FIELD_GET(BCH_CFG_1_CORR_CAP_5, reg);
> +	cdns_nand->ecc_strengths[6] = FIELD_GET(BCH_CFG_1_CORR_CAP_6, reg);
> +	cdns_nand->ecc_strengths[7] = FIELD_GET(BCH_CFG_1_CORR_CAP_7, reg);
> +
> +	reg = readl(cdns_nand->reg + BCH_CFG_2);
> +	cdns_nand->ecc_stepinfos[0].stepsize =
> +		FIELD_GET(BCH_CFG_2_SECT_0, reg);
> +
> +	cdns_nand->ecc_stepinfos[1].stepsize =
> +		FIELD_GET(BCH_CFG_2_SECT_1, reg);
> +
> +	nstrengths = 0;
> +	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
> +		if (cdns_nand->ecc_strengths[i] != 0)
> +			nstrengths++;
> +	}
> +
> +	ecc_caps->nstepinfos = 0;
> +	for (i = 0; i < BCH_MAX_NUM_SECTOR_SIZES; i++) {
> +		/* ECC strengths are common for all step infos */
> +		cdns_nand->ecc_stepinfos[i].nstrengths = nstrengths;
> +		cdns_nand->ecc_stepinfos[i].strengths =
> +			cdns_nand->ecc_strengths;
> +
> +		if (cdns_nand->ecc_stepinfos[i].stepsize != 0)
> +			ecc_caps->nstepinfos++;
> +
> +		if (cdns_nand->ecc_stepinfos[i].stepsize > max_step_size)
> +			max_step_size = cdns_nand->ecc_stepinfos[i].stepsize;
> +	}
> +
> +	ecc_caps->stepinfos = &cdns_nand->ecc_stepinfos[0];
> +
> +	switch (max_step_size) {
> +	case 256:
> +		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_256;
> +		break;
> +	case 512:
> +		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_512;
> +		break;
> +	case 1024:
> +		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_1024;
> +		break;
> +	case 2048:
> +		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_2048;
> +		break;
> +	case 4096:
> +		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_4096;
> +		break;
> +	default:
> +		dev_err(cdns_nand->dev,
> +			"Unsupported sector size(ecc step size) %d\n",
> +			max_step_size);
> +		return -EIO;
> +	}

Which in turns simplify this function.

> +
> +	return 0;
> +}

I'm stopping here, but I think you got the idea: there's a lot of
duplicated code in this driver, try to factor this out or simplify the
logic.

Regards,

Boris
