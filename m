Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDCFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5AA217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266258;
	bh=sfsQgj/f/FwKcfSySP+YdzLoKmLvMpE7XUCnaYQwpoA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=C6wGLm0qDHKwGIzCKhJ7pDQGEW6hll1w63ClYcP8XEF9OLnZDIEHhIhHSs5pD4EeW
	 yBRzbu02ka+ATR1gZjsoQhocZnM09o9iQCfCDG34Q4skQmJLvGTLW6sNBtxkOZuGPh
	 hold/8iySkxomLDC5DTAnxxS3fBYYcqXTYJtT+bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAWR5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:57:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vsy18fzEufEaC8bju+1zYr4/zEc2B4pkaSQm0g51y2Q=; b=pFwLJAkjCPm1
        L5b7xfGN3AwuOEJMtpcu0ZJypTnV3TF1sa/muHadLh7xuTD6L+N4v13K+CjD25IQvCQLqehP/MUPR
        YKtLTrWULMzw5UcUfqnNHt1irgQRczDmO5ctf4pVyJxMPxroNAIP5QmtpAJkRI6X5C7yXLs0MPWBY
        cC2eE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmL-0006q3-50; Wed, 23 Jan 2019 17:57:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 298F51127ABA; Wed, 23 Jan 2019 17:57:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: regmap-irq: Add main status register support" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190123175732.298F51127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:57:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: regmap-irq: Add main status register support

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a2d21848d9211dad5e786aa7368709ca8938834e Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Tue, 22 Jan 2019 11:42:24 +0200
Subject: [PATCH] regmap: regmap-irq: Add main status register support

There is bunch of devices with multiple logical blocks which
can generate interrupts. It's not a rare case that the interrupt
reason registers are arranged so that there is own status/ack/mask
register for each logical block. In some devices there is also a
'main interrupt register(s)' which can indicate what sub blocks
have interrupts pending.

When such a device is connected via slow bus like i2c the main
part of interrupt handling latency can be caused by bus accesses.
On systems where it is expected that only one (or few) sub blocks
have active interrupts we can reduce the latency by only reading
the main register and those sub registers which have active
interrupts. Support this with regmap-irq for simple cases where
main register does not require acking or masking.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 99 ++++++++++++++++++++++++++++++--
 include/linux/regmap.h           | 31 ++++++++++
 2 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 1bd1145ad8b5..22778e9501ff 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -35,6 +35,7 @@ struct regmap_irq_chip_data {
 	int wake_count;
 
 	void *status_reg_buf;
+	unsigned int *main_status_buf;
 	unsigned int *status_buf;
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
@@ -326,6 +327,33 @@ static const struct irq_chip regmap_irq_chip = {
 	.irq_set_wake		= regmap_irq_set_wake,
 };
 
+static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
+					   unsigned int b)
+{
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	struct regmap_irq_sub_irq_map *subreg;
+	int i, ret = 0;
+
+	if (!chip->sub_reg_offsets) {
+		/* Assume linear mapping */
+		ret = regmap_read(map, chip->status_base +
+				  (b * map->reg_stride * data->irq_reg_stride),
+				   &data->status_buf[b]);
+	} else {
+		subreg = &chip->sub_reg_offsets[b];
+		for (i = 0; i < subreg->num_regs; i++) {
+			unsigned int offset = subreg->offset[i];
+
+			ret = regmap_read(map, chip->status_base + offset,
+					  &data->status_buf[offset]);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
+}
+
 static irqreturn_t regmap_irq_thread(int irq, void *d)
 {
 	struct regmap_irq_chip_data *data = d;
@@ -349,11 +377,65 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 	}
 
 	/*
-	 * Read in the statuses, using a single bulk read if possible
-	 * in order to reduce the I/O overheads.
+	 * Read only registers with active IRQs if the chip has 'main status
+	 * register'. Else read in the statuses, using a single bulk read if
+	 * possible in order to reduce the I/O overheads.
 	 */
-	if (!map->use_single_read && map->reg_stride == 1 &&
-	    data->irq_reg_stride == 1) {
+
+	if (chip->num_main_regs) {
+		unsigned int max_main_bits;
+		unsigned long size;
+
+		size = chip->num_regs * sizeof(unsigned int);
+
+		max_main_bits = (chip->num_main_status_bits) ?
+				 chip->num_main_status_bits : chip->num_regs;
+		/* Clear the status buf as we don't read all status regs */
+		memset(data->status_buf, 0, size);
+
+		/* We could support bulk read for main status registers
+		 * but I don't expect to see devices with really many main
+		 * status registers so let's only support single reads for the
+		 * sake of simplicity. and add bulk reads only if needed
+		 */
+		for (i = 0; i < chip->num_main_regs; i++) {
+			ret = regmap_read(map, chip->main_status +
+				  (i * map->reg_stride
+				   * data->irq_reg_stride),
+				  &data->main_status_buf[i]);
+			if (ret) {
+				dev_err(map->dev,
+					"Failed to read IRQ status %d\n",
+					ret);
+				goto exit;
+			}
+		}
+
+		/* Read sub registers with active IRQs */
+		for (i = 0; i < chip->num_main_regs; i++) {
+			unsigned int b;
+			const unsigned long mreg = data->main_status_buf[i];
+
+			for_each_set_bit(b, &mreg, map->format.val_bytes * 8) {
+				if (i * map->format.val_bytes * 8 + b >
+				    max_main_bits)
+					break;
+				ret = read_sub_irq_data(data, b);
+
+				if (ret != 0) {
+					dev_err(map->dev,
+						"Failed to read IRQ status %d\n",
+						ret);
+					if (chip->runtime_pm)
+						pm_runtime_put(map->dev);
+					goto exit;
+				}
+			}
+
+		}
+	} else if (!map->use_single_read && map->reg_stride == 1 &&
+		   data->irq_reg_stride == 1) {
+
 		u8 *buf8 = data->status_reg_buf;
 		u16 *buf16 = data->status_reg_buf;
 		u32 *buf32 = data->status_reg_buf;
@@ -518,6 +600,15 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	if (!d)
 		return -ENOMEM;
 
+	if (chip->num_main_regs) {
+		d->main_status_buf = kcalloc(chip->num_main_regs,
+					     sizeof(unsigned int),
+					     GFP_KERNEL);
+
+		if (!d->main_status_buf)
+			goto err_alloc;
+	}
+
 	d->status_buf = kcalloc(chip->num_regs, sizeof(unsigned int),
 				GFP_KERNEL);
 	if (!d->status_buf)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 1781b6cb793c..daeec7dbd65c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1131,11 +1131,37 @@ struct regmap_irq {
 		.reg_offset = (_id) / (_reg_bits),	\
 	}
 
+#define REGMAP_IRQ_MAIN_REG_OFFSET(arr)				\
+	{ .num_regs = ARRAY_SIZE((arr)), .offset = &(arr)[0] }
+
+struct regmap_irq_sub_irq_map {
+	unsigned int num_regs;
+	unsigned int *offset;
+};
+
 /**
  * struct regmap_irq_chip - Description of a generic regmap irq_chip.
  *
  * @name:        Descriptive name for IRQ controller.
  *
+ * @main_status: Base main status register address. For chips which have
+ *		 interrupts arranged in separate sub-irq blocks with own IRQ
+ *		 registers and which have a main IRQ registers indicating
+ *		 sub-irq blocks with unhandled interrupts. For such chips fill
+ *		 sub-irq register information in status_base, mask_base and
+ *		 ack_base.
+ * @num_main_status_bits: Should be given to chips where number of meaningfull
+ *			  main status bits differs from num_regs.
+ * @sub_reg_offsets: arrays of mappings from main register bits to sub irq
+ *		     registers. First item in array describes the registers
+ *		     for first main status bit. Second array for second bit etc.
+ *		     Offset is given as sub register status offset to
+ *		     status_base. Should contain num_regs arrays.
+ *		     Can be provided for chips with more complex mapping than
+ *		     1.st bit to 1.st sub-reg, 2.nd bit to 2.nd sub-reg, ...
+ * @num_main_regs: Number of 'main status' irq registers for chips which have
+ *		   main_status set.
+ *
  * @status_base: Base status register address.
  * @mask_base:   Base mask register address.
  * @mask_writeonly: Base mask register is write only.
@@ -1181,6 +1207,11 @@ struct regmap_irq {
 struct regmap_irq_chip {
 	const char *name;
 
+	unsigned int main_status;
+	unsigned int num_main_status_bits;
+	struct regmap_irq_sub_irq_map *sub_reg_offsets;
+	int num_main_regs;
+
 	unsigned int status_base;
 	unsigned int mask_base;
 	unsigned int unmask_base;
-- 
2.20.1

