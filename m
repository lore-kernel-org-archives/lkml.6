Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTV1/YJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbeFRQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:21:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36774 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754642AbeFRQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:21:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so9836563lfh.3;
        Mon, 18 Jun 2018 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlZSbV9YFzLcYGY+QHSUnTuR7e9LCsMjs+FN4ugJFP8=;
        b=kTV1/YJcga/ERSDwlZZi2LOoNC/t2x0Jsv0Akcsg2caaM8Rgy8lQFVVX03UMGMuG+F
         KAnEECizS61TLymnLSY3/M+BbW9HqqlodzaWg7krhc6BQjE5x3furdfLwMATO4k0LZS2
         Os0BEmqABMUtV1OE8PlGE+RHviA9nXj6bfo2jL4+MsKmxaSSrOHmhiIijADdjkQbTKKv
         mtE2nhmWEBERHnJpGwFxZU8VHE3/SXs95IP9Q9hNhXAaXviLGkKuf9bjjnMmAoBOHrMo
         Nj1G+f4MxtaL+yE5VDKkAw6bnchLMFLhy1KvDPDu8ExV3j+EOiqacaHYCLPK1m6aEmCk
         2cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlZSbV9YFzLcYGY+QHSUnTuR7e9LCsMjs+FN4ugJFP8=;
        b=C2QmZWSG7cRd4iftTOe+CtunOAwPqIJe4hoy2wiXvndazwW8wpeA5c6KS+sZ3uMo7f
         mpIM1tWVhMhK+StNGCZ29y4Ve7C28EfvYNI868+1LZYU7on6o+bYOBcmCXUZTWSaUKsO
         VxL6zCrj1p3MJ3OGsESTLL+fIg803jBvj4xqJ3v7/u2CqNjmlvmEjM3KOY9FHYIDuu3L
         q6tQ2nV/X5E4M3P81c0KB6Ad7BCrRCNlGX2D+TYQy28ArUFQwQZhL/B+WKUEg+HKq/7H
         YVym0dyqxlPWWKgVM8JOnBqC0+WX3fGWfo7vSpx+P1ECHr3T2p5EL6uMkeXTcCmZ0xHx
         eErw==
X-Gm-Message-State: APt69E1OM1EL88/dXHWJvaCfTy1i7IXME7+kscGnzaKrunsM8TZ20jWv
        MPt40hVw4s1/uLO5IZLflg==
X-Google-Smtp-Source: ADUXVKJMU1hI2F1qHII51mcxNi56db1qTt/zDG6YFfVBBgCROZUmfMS9kbIgHwbePlFCGZWTxX1cgQ==
X-Received: by 2002:a2e:5b95:: with SMTP id m21-v6mr8439400lje.79.1529338909505;
        Mon, 18 Jun 2018 09:21:49 -0700 (PDT)
Received: from localhost.localdomain (89-64-25-103.dynamic.chello.pl. [89.64.25.103])
        by smtp.gmail.com with ESMTPSA id h90-v6sm2761220ljf.65.2018.06.18.09.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:21:48 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
Date:   Mon, 18 Jun 2018 18:21:23 +0200
Message-Id: <20180618162124.21749-2-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618162124.21749-1-bugalski.piotr@gmail.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
New spi-mem interface allows usage also other memory types, especially
much larger NAND with SPI interface. This driver works as SPI controller
and is not related to MTD, however can work with NAND-flash or other
peripherals using spi-mem interface.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>

---
 drivers/spi/Kconfig          |   9 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-atmel-qspi.c | 480 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 490 insertions(+)
 create mode 100644 drivers/spi/spi-atmel-qspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4a77cfa3213d..4f70a7005997 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -84,6 +84,15 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT91 ARM chips.
 
+config SPI_ATMEL_QSPI
+	tristate "Atmel QuadSPI Controller"
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on OF && HAS_IOMEM
+	help
+	  This selects a driver for the Atmel QSPI Controller on SAMA5D2.
+	  This controller does not support generic SPI, it supports only
+	  spi-mem interface.
+
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index fe54d787cf4d..6245a5693b16 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_ATMEL_QSPI)    += spi-atmel-qspi.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
 obj-$(CONFIG_SPI_AXI_SPI_ENGINE)	+= spi-axi-spi-engine.o
diff --git a/drivers/spi/spi-atmel-qspi.c b/drivers/spi/spi-atmel-qspi.c
new file mode 100644
index 000000000000..1ee626201b0d
--- /dev/null
+++ b/drivers/spi/spi-atmel-qspi.c
@@ -0,0 +1,480 @@
+/*
+ * Atmel SAMA5D2 QuadSPI driver.
+ *
+ * Copyright (C) 2018 Cryptera A/S
+ * All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 (GPL v2)
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/delay.h>
+
+#define QSPI_CR         0x0000
+#define QSPI_MR         0x0004
+#define QSPI_RDR        0x0008
+#define QSPI_TDR        0x000c
+#define QSPI_SR         0x0010
+#define QSPI_IER        0x0014
+#define QSPI_IDR        0x0018
+#define QSPI_IMR        0x001c
+#define QSPI_SCR        0x0020
+
+#define QSPI_IAR        0x0030
+#define QSPI_ICR        0x0034
+#define QSPI_IFR        0x0038
+
+#define QSPI_WPMR       0x00e4
+#define QSPI_WPSR       0x00e8
+
+/* Bitfields in QSPI_CR (Control Register) */
+#define QSPI_CR_QSPIEN                  BIT(0)
+#define QSPI_CR_QSPIDIS                 BIT(1)
+#define QSPI_CR_SWRST                   BIT(7)
+#define QSPI_CR_LASTXFER                BIT(24)
+
+/* Bitfields in QSPI_ICR (Instruction Code Register) */
+#define QSPI_ICR_INST_MASK              GENMASK(7, 0)
+#define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
+#define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
+#define QSPI_ICR_OPT(opt)               (((opt) << 16) & QSPI_ICR_OPT_MASK)
+
+/* Bitfields in QSPI_MR (Mode Register) */
+#define QSPI_MR_SMM                     BIT(0)
+#define QSPI_MR_LLB                     BIT(1)
+#define QSPI_MR_WDRBT                   BIT(2)
+#define QSPI_MR_SMRM                    BIT(3)
+#define QSPI_MR_CSMODE_MASK             GENMASK(5, 4)
+#define QSPI_MR_CSMODE_NOT_RELOADED     (0 << 4)
+#define QSPI_MR_CSMODE_LASTXFER         (1 << 4)
+#define QSPI_MR_CSMODE_SYSTEMATICALLY   (2 << 4)
+#define QSPI_MR_NBBITS_MASK             GENMASK(11, 8)
+#define QSPI_MR_NBBITS(n)               ((((n) - 8) << 8) & QSPI_MR_NBBITS_MASK)
+#define QSPI_MR_DLYBCT_MASK             GENMASK(23, 16)
+#define QSPI_MR_DLYBCT(n)               (((n) << 16) & QSPI_MR_DLYBCT_MASK)
+#define QSPI_MR_DLYCS_MASK              GENMASK(31, 24)
+#define QSPI_MR_DLYCS(n)                (((n) << 24) & QSPI_MR_DLYCS_MASK)
+
+/* Bitfields in QSPI_IFR (Instruction Frame Register) */
+#define QSPI_IFR_WIDTH_MASK             GENMASK(2, 0)
+#define QSPI_IFR_WIDTH_SINGLE_BIT_SPI   (0 << 0)
+#define QSPI_IFR_WIDTH_DUAL_OUTPUT      (1 << 0)
+#define QSPI_IFR_WIDTH_QUAD_OUTPUT      (2 << 0)
+#define QSPI_IFR_WIDTH_DUAL_IO          (3 << 0)
+#define QSPI_IFR_WIDTH_QUAD_IO          (4 << 0)
+#define QSPI_IFR_WIDTH_DUAL_CMD         (5 << 0)
+#define QSPI_IFR_WIDTH_QUAD_CMD         (6 << 0)
+#define QSPI_IFR_INSTEN                 BIT(4)
+#define QSPI_IFR_ADDREN                 BIT(5)
+#define QSPI_IFR_OPTEN                  BIT(6)
+#define QSPI_IFR_DATAEN                 BIT(7)
+#define QSPI_IFR_OPTL_MASK              GENMASK(9, 8)
+#define QSPI_IFR_OPTL_1BIT              (0 << 8)
+#define QSPI_IFR_OPTL_2BIT              (1 << 8)
+#define QSPI_IFR_OPTL_4BIT              (2 << 8)
+#define QSPI_IFR_OPTL_8BIT              (3 << 8)
+#define QSPI_IFR_ADDRL                  BIT(10)
+#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
+#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
+#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
+#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
+#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
+#define QSPI_IFR_CRM                    BIT(14)
+#define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
+#define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
+
+/* Bitfields in QSPI_SR/QSPI_IER/QSPI_IDR/QSPI_IMR  */
+#define QSPI_SR_RDRF                    BIT(0)
+#define QSPI_SR_TDRE                    BIT(1)
+#define QSPI_SR_TXEMPTY                 BIT(2)
+#define QSPI_SR_OVRES                   BIT(3)
+#define QSPI_SR_CSR                     BIT(8)
+#define QSPI_SR_CSS                     BIT(9)
+#define QSPI_SR_INSTRE                  BIT(10)
+#define QSPI_SR_QSPIENS                 BIT(24)
+
+#define QSPI_SR_CMD_COMPLETED           (QSPI_SR_INSTRE | QSPI_SR_CSR)
+
+
+/* Bitfields in QSPI_SCR (Serial Clock Register) */
+#define QSPI_SCR_CPOL                   BIT(0)
+#define QSPI_SCR_CPHA                   BIT(1)
+#define QSPI_SCR_SCBR_MASK              GENMASK(15, 8)
+#define QSPI_SCR_SCBR(n)                (((n) << 8) & QSPI_SCR_SCBR_MASK)
+#define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
+#define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK)
+
+#define QSPI_WPMR_WPKEY_PASSWD          (0x515350u << 8)
+
+struct atmel_qspi {
+	struct platform_device *pdev;
+	void __iomem *iobase;
+	void __iomem *ahb_addr;
+	int irq;
+	struct clk *clk;
+	u32 clk_rate;
+	struct completion cmd_done;
+	u32 pending;
+};
+
+struct qspi_mode {
+	u8 cmd_buswidth;
+	u8 addr_buswidth;
+	u8 data_buswidth;
+	u32 config;
+};
+
+static const struct qspi_mode sama5d2_qspi_modes[] = {
+	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
+	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
+	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
+	{ 1, 2, 2, QSPI_IFR_WIDTH_DUAL_IO },
+	{ 1, 4, 4, QSPI_IFR_WIDTH_QUAD_IO },
+	{ 2, 2, 2, QSPI_IFR_WIDTH_DUAL_CMD },
+	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
+};
+
+static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
+{
+	return readl_relaxed(aq->iobase + reg);
+}
+
+static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
+{
+	writel_relaxed(value, aq->iobase + reg);
+}
+
+static int atmel_qspi_init(struct atmel_qspi *aq)
+{
+	unsigned long rate;
+	u32 scbr;
+
+	qspi_writel(aq, QSPI_WPMR, QSPI_WPMR_WPKEY_PASSWD);
+
+	/* software reset */
+	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
+
+	/* set QSPI mode */
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+
+	rate = clk_get_rate(aq->clk);
+	if (!rate)
+		return -EINVAL;
+
+	/* set baudrate */
+	scbr = DIV_ROUND_UP(rate, aq->clk_rate);
+	if (scbr > 0)
+		scbr--;
+	qspi_writel(aq, QSPI_SCR, QSPI_SCR_SCBR(scbr));
+
+	/* enable qspi controller */
+	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
+
+	return 0;
+}
+
+static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	return 0;
+}
+
+static inline bool is_compatible(const struct spi_mem_op *op,
+				 const struct qspi_mode *mode)
+{
+	if (op->cmd.buswidth != mode->cmd_buswidth)
+		return false;
+	if (op->addr.nbytes && op->addr.buswidth != mode->addr_buswidth)
+		return false;
+	if (op->data.nbytes && op->data.buswidth != mode->data_buswidth)
+		return false;
+	return true;
+}
+
+static int find_mode(const struct spi_mem_op *op)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
+		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+			return i;
+	return -1;
+}
+
+static bool atmel_qspi_supports_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (find_mode(op) < 0)
+		return false;
+
+	// special case not supported by hardware
+	if ((op->addr.nbytes == 2) && (op->cmd.buswidth != op->addr.buswidth) &&
+		(op->dummy.nbytes == 0))
+		return false;
+
+	return true;
+}
+
+static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *ctrl = dev_id;
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	u32 status, mask, pending;
+
+	status = qspi_readl(aq, QSPI_SR);
+	mask = qspi_readl(aq, QSPI_IMR);
+	pending = status & mask;
+
+	if (!pending)
+		return IRQ_NONE;
+
+	aq->pending |= pending;
+	if ((aq->pending & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+		complete(&aq->cmd_done);
+
+	return IRQ_HANDLED;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	int mode;
+	u32 addr = 0;
+	u32 dummy_cycles = 0;
+	u32 ifr = QSPI_IFR_INSTEN;
+	u32 icr = QSPI_ICR_INST(op->cmd.opcode);
+
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+
+	mode = find_mode(op);
+	if (mode < 0)
+		return -1;
+	ifr |= sama5d2_qspi_modes[mode].config;
+
+	if (op->dummy.buswidth && op->dummy.nbytes)
+		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
+
+	if (op->addr.buswidth) {
+		switch (op->addr.nbytes) {
+		case 0:
+			break;
+		case 1:
+			ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
+			break;
+		case 2:
+			if (dummy_cycles < 8 / op->addr.buswidth) {
+				ifr &= ~QSPI_IFR_INSTEN;
+				addr = (op->cmd.opcode << 16) |
+					(op->addr.val & 0xffff);
+				ifr |= QSPI_IFR_ADDREN;
+			} else {
+				addr = (op->addr.val << 8) & 0xffffff;
+				dummy_cycles -= 8 / op->addr.buswidth;
+				ifr |= QSPI_IFR_ADDREN;
+			}
+			break;
+		case 3:
+			addr = op->addr.val & 0xffffff;
+			ifr |= QSPI_IFR_ADDREN;
+			break;
+		case 4:
+			addr = op->addr.val;
+			ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
+			break;
+		default:
+			return -1;
+		}
+	}
+	ifr |= QSPI_IFR_NBDUM(dummy_cycles);
+	if (op->data.nbytes == 0)
+		qspi_writel(aq, QSPI_IAR, addr);
+	else
+		ifr |= QSPI_IFR_DATAEN;
+
+	if ((op->data.dir == SPI_MEM_DATA_IN) && (op->data.nbytes > 0))
+		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
+	else
+		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	qspi_writel(aq, QSPI_IAR, addr);
+	qspi_writel(aq, QSPI_ICR, icr);
+	qspi_writel(aq, QSPI_IFR, ifr);
+	qspi_readl(aq, QSPI_IFR);
+
+	if (op->data.nbytes > 0) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			_memcpy_fromio(op->data.buf.in,
+				aq->ahb_addr + addr, op->data.nbytes);
+		else
+			_memcpy_toio(aq->ahb_addr + addr,
+				op->data.buf.out, op->data.nbytes);
+
+		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+	}
+
+	aq->pending = qspi_readl(aq, QSPI_SR) & QSPI_SR_CMD_COMPLETED;
+	if (aq->pending == QSPI_SR_CMD_COMPLETED)
+		return 0;
+	reinit_completion(&aq->cmd_done);
+	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	wait_for_completion(&aq->cmd_done);
+	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
+	.adjust_op_size = atmel_qspi_adjust_op_size,
+	.supports_op = atmel_qspi_supports_op,
+	.exec_op = atmel_qspi_exec_op
+};
+
+static int atmel_qspi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl;
+	struct atmel_qspi *aq;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	struct resource *res;
+	int irq, err = 0;
+
+	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
+	ctrl->bus_num = -1;
+	ctrl->mem_ops = &atmel_qspi_mem_ops;
+	ctrl->num_chipselect = 1;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	platform_set_drvdata(pdev, ctrl);
+
+	aq = spi_controller_get_devdata(ctrl);
+
+	if (of_get_child_count(np) != 1)
+		return -ENODEV;
+	child = of_get_next_child(np, NULL);
+
+	aq->pdev = pdev;
+
+	/* map registers */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
+	aq->iobase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(aq->iobase)) {
+		dev_err(&pdev->dev, "missing registers\n");
+		err = PTR_ERR(aq->iobase);
+		goto err_put_ctrl;
+	}
+
+	/* map AHB memory */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
+	aq->ahb_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(aq->ahb_addr)) {
+		dev_err(&pdev->dev, "missing AHB memory\n");
+		err = PTR_ERR(aq->ahb_addr);
+		goto err_put_ctrl;
+	}
+
+	/* get peripheral clock */
+	aq->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(aq->clk)) {
+		dev_err(&pdev->dev, "missing peripheral clock\n");
+		err = PTR_ERR(aq->clk);
+		goto err_put_ctrl;
+	}
+
+	err = clk_prepare_enable(aq->clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable peripheral clock\n");
+		goto err_put_ctrl;
+	}
+
+	/* request IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "missing IRQ\n");
+		err = irq;
+		goto disable_clk;
+	}
+	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt, 0,
+		dev_name(&pdev->dev), ctrl);
+	if (err)
+		goto disable_clk;
+
+	err = of_property_read_u32(child, "spi-max-frequency", &aq->clk_rate);
+	if (err < 0)
+		goto disable_clk;
+
+	init_completion(&aq->cmd_done);
+
+	err = atmel_qspi_init(aq);
+	if (err)
+		goto disable_clk;
+
+	of_node_put(child);
+
+	err = spi_register_controller(ctrl);
+	if (err)
+		goto disable_clk;
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(aq->clk);
+err_put_ctrl:
+	spi_controller_put(ctrl);
+	of_node_put(child);
+	return err;
+}
+
+static int atmel_qspi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl = platform_get_drvdata(pdev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+
+	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
+	clk_disable_unprepare(aq->clk);
+
+	spi_unregister_controller(ctrl);
+
+	return 0;
+}
+
+static const struct of_device_id atmel_qspi_dt_ids[] = {
+	{
+		.compatible = "atmel,sama5d2-spi-qspi"
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, atmel_qspi_dt_ids);
+
+static struct platform_driver atmel_qspi_driver = {
+	.driver = {
+		.name = "atmel_spi_qspi",
+		.of_match_table = atmel_qspi_dt_ids
+	},
+	.probe = atmel_qspi_probe,
+	.remove = atmel_qspi_remove
+};
+
+module_platform_driver(atmel_qspi_driver);
+
+
+MODULE_DESCRIPTION("Atmel SAMA5D2 QuadSPI Driver");
+MODULE_AUTHOR("Piotr Bugalski <pbu@cryptera.com");
+MODULE_LICENSE("GPL v2");
+
-- 
2.11.0

