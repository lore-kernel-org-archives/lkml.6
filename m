Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeC2Eb0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:31:26 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:32920 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeC2EbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:31:24 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] mfd: axp20x: Correct AXP806 POK interrupt prefix
Date: Thu, 29 Mar 2018 12:31:15 +0800
Message-Id: <20180329043115.7132-4-wens@csie.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329043115.7132-1-wens@csie.org>
References: <20180329043115.7132-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AXP806 support was added, POK was incorrectly expanded to PWROK.
However, the datasheet lists them as POK[LSNP], which is the same as
on the AXP288. Furthermore, the registers associated with POK functions
are the same as the PEK on the other AXP PMICs. This suggests that
"POK" means "Power On Key", much like "PEK" means "Power Enable Key",
instead of "Power OK".

This patch changes the "PWROK" prefix to "POK" for these interrupts.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c       | 8 ++++----
 include/linux/mfd/axp20x.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index b3051e1c3ddc..9a2ef3d9b8f8 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -450,11 +450,11 @@ static const struct regmap_irq axp806_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP806, DCDCC_V_LOW,		0, 5),
 	INIT_REGMAP_IRQ(AXP806, DCDCD_V_LOW,		0, 6),
 	INIT_REGMAP_IRQ(AXP806, DCDCE_V_LOW,		0, 7),
-	INIT_REGMAP_IRQ(AXP806, PWROK_LONG,		1, 0),
-	INIT_REGMAP_IRQ(AXP806, PWROK_SHORT,		1, 1),
+	INIT_REGMAP_IRQ(AXP806, POK_LONG,		1, 0),
+	INIT_REGMAP_IRQ(AXP806, POK_SHORT,		1, 1),
 	INIT_REGMAP_IRQ(AXP806, WAKEUP,			1, 4),
-	INIT_REGMAP_IRQ(AXP806, PWROK_FALL,		1, 5),
-	INIT_REGMAP_IRQ(AXP806, PWROK_RISE,		1, 6),
+	INIT_REGMAP_IRQ(AXP806, POK_FALL,		1, 5),
+	INIT_REGMAP_IRQ(AXP806, POK_RISE,		1, 6),
 };
 
 static const struct regmap_irq axp809_regmap_irqs[] = {
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index a2489363a998..517e60eecbcb 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -592,11 +592,11 @@ enum axp806_irqs {
 	AXP806_IRQ_DCDCC_V_LOW,
 	AXP806_IRQ_DCDCD_V_LOW,
 	AXP806_IRQ_DCDCE_V_LOW,
-	AXP806_IRQ_PWROK_LONG,
-	AXP806_IRQ_PWROK_SHORT,
+	AXP806_IRQ_POK_LONG,
+	AXP806_IRQ_POK_SHORT,
 	AXP806_IRQ_WAKEUP,
-	AXP806_IRQ_PWROK_FALL,
-	AXP806_IRQ_PWROK_RISE,
+	AXP806_IRQ_POK_FALL,
+	AXP806_IRQ_POK_RISE,
 };
 
 enum axp809_irqs {
-- 
2.16.3
