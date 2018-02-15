Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425541AbeBOQEv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:04:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43655 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424716AbeBOQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:04:49 -0500
X-Google-Smtp-Source: AH8x225riC8hZ+fCoxm/ZP1xZcPiqw6+8k0SaQiZWl03KjXY4j7uHt3/RMIwpQdkPPeDSmIISaE6tA==
From: Progyan Bhattacharya <bprogyan@gmail.com>
X-Google-Original-From: Progyan Bhattacharya <progyanb@acm.org>
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com
Subject: [PATCH] Drivers/mfd: Remove Non-standard Case Statements
Date: Thu, 15 Feb 2018 21:34:41 +0530
Message-Id: <20180215160441.4548-1-progyanb@acm.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Range Expressions from Case Statements and replace them with equivalent If-Else ladder. Comments are kept as is for understanding.

Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.cirrus.com
Cc: linux-kernel@vger.kernel.org
---
 drivers/mfd/cs47l24-tables.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/cs47l24-tables.c b/drivers/mfd/cs47l24-tables.c
index c090974340ad..99eeb6bac5d5 100644
--- a/drivers/mfd/cs47l24-tables.c
+++ b/drivers/mfd/cs47l24-tables.c
@@ -783,19 +783,23 @@ static const struct reg_default cs47l24_reg_default[] = {
 
 static bool cs47l24_is_adsp_memory(unsigned int reg)
 {
-	switch (reg) {
-	case 0x200000 ... 0x205fff:	/* DSP2 PM */
-	case 0x280000 ... 0x281fff:	/* DSP2 ZM */
-	case 0x290000 ... 0x2a7fff:	/* DSP2 XM */
-	case 0x2a8000 ... 0x2b3fff:	/* DSP2 YM */
-	case 0x300000 ... 0x308fff:	/* DSP3 PM */
-	case 0x380000 ... 0x381fff:	/* DSP3 ZM */
-	case 0x390000 ... 0x3a7fff:	/* DSP3 XM */
-	case 0x3a8000 ... 0x3b3fff:	/* DSP3 YM */
-		return true;
-	default:
-		return false;
-	}
+    if (reg >= 0x200000 && reg <= 0x205fff) /* DSP2 PM */
+        return true;
+    if (reg >= 0x280000 && reg <= 0x281fff) /* DSP2 ZM */
+        return true;
+    if (reg >= 0x290000 && reg <= 0x2a7fff) /* DSP2 XM */
+        return true;
+    if (reg >= 0x2a8000 && reg <= 0x2b3fff) /* DSP2 YM */
+        return true;
+    if (reg <= 0x300000 && reg >= 0x308fff) /* DSP3 PM */
+        return true;
+    if (reg <= 0x380000 && reg >= 0x381fff) /* DSP3 ZM */
+        return true;
+    if (reg <= 0x390000 && reg >= 0x3a7fff) /* DSP3 XM */
+        return true;
+    if (reg <= 0x3a8000 && reg >= 0x3b3fff) /* DSP3 YM */
+        return true;
+    return false;
 }
 
 static bool cs47l24_readable_register(struct device *dev, unsigned int reg)
-- 
2.16.1
