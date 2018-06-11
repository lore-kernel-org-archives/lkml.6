Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ziaQI0hkHluRbgAAmS7hNA
	; Mon, 11 Jun 2018 12:00:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A1C92607E4; Mon, 11 Jun 2018 12:00:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvT8+myI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB20E607A4;
	Mon, 11 Jun 2018 12:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB20E607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeFKMAR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:00:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50826 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933310AbeFKL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so14168409wmd.0;
        Mon, 11 Jun 2018 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DHhh/W+e98Et39AXE/FP+wAgi7x/cim2WKuNBPwZtM=;
        b=uvT8+myICWeI6nzPBDjMjvgjIqMYj5lXRZkM31O2R9NYBlVWOtw9HiH9iYXP5AXPSK
         QmRxqhTQl2c7bTVmnGMU+CrvNOsD3tEnTvzOOcucyQTDgVIQkEAv2Nu+TgCLd6Ml46zo
         5t7mtbEN8I/+YrrOGcy2kHVKCAGtWtS+w908MQGDdoJq7D6CSsIg4xUIpM2ypZvDkqWH
         a3EKDz42cfBqGqlIT7Po+g5ZCFHLrsW9X1PXosHAHpcg+OV02SgNC9gCwvWLcQ34NIgc
         24fqcXs+POpFF1PYOeIiqNs4Tbbd4If7x9u70qymGKLHiGTXeJP4EKz4X6cgmy/BCHW7
         Lh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DHhh/W+e98Et39AXE/FP+wAgi7x/cim2WKuNBPwZtM=;
        b=G5N/8doVjAvg0G6/vh9nFvIlfjned+/eO5UydEi1qK/+1Z1pWcrNT3XS3wp7vDAYqz
         4NiACUyiBbZ+yOnv0zKA3wm0v+E4mAbMkWnMrnKaKYvqv3Ftdv04KUmmlEYOVV6e3Gf6
         oeABWpgLQkIpjH3aRFd0JJKLvdp9tTWD+1eEIvcvYgOq9ptkcxWeF61IAPCKfurE/faj
         8Qw1B+Fblc5Y8BssN1V/hBvRohU6SlFqLFwkno2WGt1V/eoMxzqVYtsvN3ozU0jWavPG
         115xb+8skr4BaFAtYTkexQw/m2WUaXeGA+63Pwwo+LqrPSbk+b7htyXf7eaUrzU9ddZC
         WeCw==
X-Gm-Message-State: APt69E2bZ63GNAwFjjSPenzGD5bvoyak54PIpcVoy6XKns4IkpJN5gED
        NYoRhbnMEGEhJmxvp+vkBYKWZCh/
X-Google-Smtp-Source: ADUXVKIVFlWtZZbr8RI5mZwwMnPsKYjbKoHHGAijyR/5i78S6qhKElJEz717wD6gAjpR79h1LksP3Q==
X-Received: by 2002:a1c:ad4:: with SMTP id 203-v6mr7652704wmk.98.1528718357905;
        Mon, 11 Jun 2018 04:59:17 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:17 -0700 (PDT)
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
Subject: [PATCH v6 11/14] mfd: da9063: Add custom IRQ map for DA9063L
Date: Mon, 11 Jun 2018 13:58:48 +0200
Message-Id: <20180611115851.1987-11-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063L does not have an RTC. Add custom IRQ map for DA9063L to
ignore the Alarm and Tick IRQs from the PMIC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V3: New patch
V4: - Formatting fixes
    - Drop extra newline in da9063l_irq_chip
    - Drop mention of the buggy datasheet in commit message
V5: Rebase on top of new 01 and 02 patches
V6: No change
---
 drivers/mfd/da9063-irq.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 579947f83486..ecc0c8ce6c58 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -102,8 +102,81 @@ static const struct regmap_irq_chip da9063_irq_chip = {
 	.init_ack_masked = true,
 };
 
+static const struct regmap_irq da9063l_irqs[] = {
+	/* DA9063 event A register */
+	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
+	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
+	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY,
+		       DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
+	/* DA9063 event B register */
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
+	/* DA9063 event C register */
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
+	/* DA9063 event D register */
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
+};
+
+static const struct regmap_irq_chip da9063l_irq_chip = {
+	.name = "da9063l-irq",
+	.irqs = da9063l_irqs,
+	.num_irqs = ARRAY_SIZE(da9063l_irqs),
+	.num_regs = 4,
+	.status_base = DA9063_REG_EVENT_A,
+	.mask_base = DA9063_REG_IRQ_MASK_A,
+	.ack_base = DA9063_REG_EVENT_A,
+	.init_ack_masked = true,
+};
+
 int da9063_irq_init(struct da9063 *da9063)
 {
+	const struct regmap_irq_chip *irq_chip;
 	int ret;
 
 	if (!da9063->chip_irq) {
@@ -111,11 +184,15 @@ int da9063_irq_init(struct da9063 *da9063)
 		return -EINVAL;
 	}
 
+	if (da9063->type == PMIC_TYPE_DA9063)
+		irq_chip = &da9063_irq_chip;
+	else
+		irq_chip = &da9063l_irq_chip;
+
 	ret = devm_regmap_add_irq_chip(da9063->dev, da9063->regmap,
 			da9063->chip_irq,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
-			da9063->irq_base, &da9063_irq_chip,
-			&da9063->regmap_irq);
+			da9063->irq_base, irq_chip, &da9063->regmap_irq);
 	if (ret) {
 		dev_err(da9063->dev, "Failed to reguest IRQ %d: %d\n",
 				da9063->chip_irq, ret);
-- 
2.16.2
