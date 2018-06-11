Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ElYGN6hjHlslYAAAmS7hNA
	; Mon, 11 Jun 2018 12:00:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 21280607BB; Mon, 11 Jun 2018 12:00:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6k/jqsN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5025860351;
	Mon, 11 Jun 2018 12:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5025860351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbeFKL7Q (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46420 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933189AbeFKL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so20098311wrp.13;
        Mon, 11 Jun 2018 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YdhZM+lvoIirIU1v+hsSm75GR0R7ovLGXW0oHXuKOgU=;
        b=M6k/jqsNLs9dg+0sy4YGWzPgPr+FHhZ7hvx2UtpMwSxrdfakaOMzCZI+fwdZC/k7DT
         iM8oIoAQpigPCxl4DVdafTMOYp0LFZCxjST8MuWom+VZy0y/3vzLzqdQapzLSLAasRNK
         tv7t/Bzx9Kg/PGA3T2C4ljyK8e8fKXZjXo+ugOD+O1oN1e9cTtGa6FQL33m7NTfWTajj
         X5lGOVsstgufIt9mz0M6QuvGIWGOqcL/PcGyqwjGGy3NVdNdyvJgLkjag2PM1PCSixZ5
         wDqny4+IsDgaWpsdhw8J01MnsS1Bl80FDGaL/8Ul783q1tA4UpMWjiPwN+wrkm4ibgIx
         rvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YdhZM+lvoIirIU1v+hsSm75GR0R7ovLGXW0oHXuKOgU=;
        b=FXmG4L9TNSJf8FOHHs46JvYGHJfFweaqMikqq6nekB53bXJQkt8YeDWmRgR8mYlmfR
         Pq+T4Rwq4Xw+sgGc9KaAE1wDi/krCuo/bGsFZjLdH4NGesFce5Wt+kxB6EK92x3uqg5r
         bHtI8H0Ff/NBUQdZ+7jWabr1cvKKhpwzRhzFhN1BomMJ7oifiVggUMTMFq4m5D6LEra5
         fIiRsgFq9t36Mi/DSLdPHwwaTRhsZW4YIRvAvI7/hWC3KJ4lDufAm+PChHIEEW4YcPYQ
         2urS1NpW7BGsfH7KoyE60dzMyQxXIEjWidQcRxoVBEfT4Cf7Auvw5JXwx4LsLtS82D76
         z4tA==
X-Gm-Message-State: APt69E0lZQkP0HlVKOSSNPRe4xCkosyl6qMMnKoj0f1QTJzC/UYat5At
        az6sKQlv2B5Nq9AuekMz2tYUm4jj
X-Google-Smtp-Source: ADUXVKIbl5fexOU/qEMd2j+tqUc8YPv2tnvNNwUtlAxqA1Jh6qTaRpI1ut9jbCdFcPVRYR4uiN9PFg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr10616687wrn.174.1528718347130;
        Mon, 11 Jun 2018 04:59:07 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:06 -0700 (PDT)
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
Subject: [PATCH v6 04/14] mfd: da9063: Use REGMAP_IRQ_REG
Date: Mon, 11 Jun 2018 13:58:41 +0200
Message-Id: <20180611115851.1987-4-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V3: New patch
Note: A sed oneliner was used:
      sed -i "/\[DA9063_IRQ_/ {N;N;N;s/\n//g;s/.*\[\(DA9063_IRQ_[^]]\+\)].*reg_offset = \([^,]\+\),.* = \([^,]\+\),.*/\tREGMAP_IRQ_REG(\1, \2, \3),/}" drivers/mfd/da9063-irq.c
V4: Formatting fixes with "s/,/&\r\t\t      /" on the array
    Drop extra newline in da9063_irq_chip
V5: No change
V6: No change
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
