Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJuRPQiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D1C1606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeFFKCi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:02:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44970 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeFFKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:26 -0400
X-Google-Smtp-Source: ADUXVKK2zI3T/IIAQZtRvcattzEa3haG5YQRbva0AmcwgSm6bOcpub0JN0zfcDAItnYQcKa2wnQMug==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 04/14] mfd: da9063: Use REGMAP_IRQ_REG
Date: Wed,  6 Jun 2018 11:59:53 +0200
Message-Id: <20180606100003.17067-4-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regmap_irq table to use REGMAP_IRQ_REG().

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
V3: New patch
Note: A sed oneliner was used:
      sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
V4: Formatting fixes with "s/,/&\r\t\t      /" on the array
    Drop extra newline in da9063_irq_chip
V5: No change
---
 drivers/mfd/da9063-irq.c | 175 ++++++++++++++++-------------------------------
 1 file changed, 58 insertions(+), 117 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index da6ceb41f0d1..044bd867f540 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -28,132 +28,73 @@
 
 static const struct regmap_irq da9063_irqs[] = {
 	/* DA9063 event A register */
-	[DA9063_IRQ_ONKEY] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_ONKEY,
-	},
-	[DA9063_IRQ_ALARM] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_ALARM,
-	},
-	[DA9063_IRQ_TICK] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_TICK,
-	},
-	[DA9063_IRQ_ADC_RDY] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_ADC_RDY,
-	},
-	[DA9063_IRQ_SEQ_RDY] = {
-		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
-		.mask = DA9063_M_SEQ_RDY,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
+	REGMAP_IRQ_REG(DA9063_IRQ_ALARM,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ALARM),
+	REGMAP_IRQ_REG(DA9063_IRQ_TICK,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_TICK),
+	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
 	/* DA9063 event B register */
-	[DA9063_IRQ_WAKE] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_WAKE,
-	},
-	[DA9063_IRQ_TEMP] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_TEMP,
-	},
-	[DA9063_IRQ_COMP_1V2] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_COMP_1V2,
-	},
-	[DA9063_IRQ_LDO_LIM] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_LDO_LIM,
-	},
-	[DA9063_IRQ_REG_UVOV] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_UVOV,
-	},
-	[DA9063_IRQ_DVC_RDY] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_DVC_RDY,
-	},
-	[DA9063_IRQ_VDD_MON] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_VDD_MON,
-	},
-	[DA9063_IRQ_WARN] = {
-		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
-		.mask = DA9063_M_VDD_WARN,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_WAKE,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
+	REGMAP_IRQ_REG(DA9063_IRQ_TEMP,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
+	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
+	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
+	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
+	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
+	REGMAP_IRQ_REG(DA9063_IRQ_WARN,
+		       DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
 	/* DA9063 event C register */
-	[DA9063_IRQ_GPI0] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI0,
-	},
-	[DA9063_IRQ_GPI1] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI1,
-	},
-	[DA9063_IRQ_GPI2] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI2,
-	},
-	[DA9063_IRQ_GPI3] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI3,
-	},
-	[DA9063_IRQ_GPI4] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI4,
-	},
-	[DA9063_IRQ_GPI5] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI5,
-	},
-	[DA9063_IRQ_GPI6] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI6,
-	},
-	[DA9063_IRQ_GPI7] = {
-		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
-		.mask = DA9063_M_GPI7,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI0,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI0),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI1,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI1),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI2,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI2),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI3,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI3),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI4,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI4),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI5,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI5),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI6,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI6),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI7,
+		       DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI7),
 	/* DA9063 event D register */
-	[DA9063_IRQ_GPI8] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI8,
-	},
-	[DA9063_IRQ_GPI9] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI9,
-	},
-	[DA9063_IRQ_GPI10] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI10,
-	},
-	[DA9063_IRQ_GPI11] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI11,
-	},
-	[DA9063_IRQ_GPI12] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI12,
-	},
-	[DA9063_IRQ_GPI13] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI13,
-	},
-	[DA9063_IRQ_GPI14] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI14,
-	},
-	[DA9063_IRQ_GPI15] = {
-		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
-		.mask = DA9063_M_GPI15,
-	},
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI8,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI8),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI9,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI9),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI10,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI11,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI12,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI13,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI14,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
+	REGMAP_IRQ_REG(DA9063_IRQ_GPI15,
+		       DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
 };
 
 static const struct regmap_irq_chip da9063_irq_chip = {
 	.name = "da9063-irq",
 	.irqs = da9063_irqs,
 	.num_irqs = DA9063_NUM_IRQ,
-
 	.num_regs = 4,
 	.status_base = DA9063_REG_EVENT_A,
 	.mask_base = DA9063_REG_IRQ_MASK_A,
-- 
2.16.2
