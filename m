Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeFEXKm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:10:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33382 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeFEXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:10:37 -0400
X-Google-Smtp-Source: ADUXVKKtH8P+gvhpcqISyUEn8Ema9dLHu6/9HSnK5sZdrCOg+bapufEA2ncFK9F3vrH6HTbS6WgX3A==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 04/12] mfd: da9063: Replace DA9063_NUM_IRQ with ARRAY_SIZE
Date: Wed,  6 Jun 2018 01:10:05 +0200
Message-Id: <20180605231013.1803-4-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace DA9063_NUM_IRQ macro which is not used anywhere with
plain ARRAY_SIZE().

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V4: New patch
---
 drivers/mfd/da9063-irq.c        | 2 +-
 include/linux/mfd/da9063/core.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index bd448d6cdf8b..34ea8d0334d7 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -94,7 +94,7 @@ static const struct regmap_irq da9063_irqs[] = {
 static const struct regmap_irq_chip da9063_irq_chip = {
 	.name = "da9063-irq",
 	.irqs = da9063_irqs,
-	.num_irqs = DA9063_NUM_IRQ,
+	.num_irqs = ARRAY_SIZE(da9063_irqs),
 	.num_regs = 4,
 	.status_base = DA9063_REG_EVENT_A,
 	.mask_base = DA9063_REG_IRQ_MASK_A,
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index f3ae65db4c86..2622e9822086 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -73,7 +73,6 @@ enum da9063_irqs {
 };
 
 #define DA9063_IRQ_BASE_OFFSET	0
-#define DA9063_NUM_IRQ		(DA9063_IRQ_GPI15 + 1 - DA9063_IRQ_BASE_OFFSET)
 
 struct da9063 {
 	/* Device */
-- 
2.16.2
