Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeDPM5G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:57:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43740 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeDPM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:57:03 -0400
X-Google-Smtp-Source: AIpwx48RhBi2kvG5uL66djp/iAtwdrHkJsrqLPHtEiINKVC5D6GLeA+w3EUWuT/8mtZBOD8OAYQvcA==
From: Lee Jones <lee.jones@linaro.org>
To: linus.walleij@linaro.org, ldewangan@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/3] mfd: ab8500: Example using new OF_MFD_CELL MACRO
Date: Mon, 16 Apr 2018 13:56:26 +0100
Message-Id: <20180416125627.22156-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416125627.22156-1-lee.jones@linaro.org>
References: <20180416125627.22156-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... with and without platform ID.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab8500-core.c | 138 ++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 96 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 30d09d177171..38b6b34165d1 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -610,107 +610,53 @@ int ab8500_suspend(struct ab8500 *ab8500)
 }
 
 static const struct mfd_cell ab8500_bm_devs[] = {
-	{
-		.name = "ab8500-charger",
-		.of_compatible = "stericsson,ab8500-charger",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
-	{
-		.name = "ab8500-btemp",
-		.of_compatible = "stericsson,ab8500-btemp",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
-	{
-		.name = "ab8500-fg",
-		.of_compatible = "stericsson,ab8500-fg",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
-	{
-		.name = "ab8500-chargalg",
-		.of_compatible = "stericsson,ab8500-chargalg",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
+	OF_MFD_CELL("ab8500-charger", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-charger"),
+	OF_MFD_CELL("ab8500-btemp", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-btemp"),
+	OF_MFD_CELL("ab8500-fg", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-fg"),
+	OF_MFD_CELL("ab8500-chargalg", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-chargalg"),
 };
 
 static const struct mfd_cell ab8500_devs[] = {
 #ifdef CONFIG_DEBUG_FS
-	{
-		.name = "ab8500-debug",
-		.of_compatible = "stericsson,ab8500-debug",
-	},
+	OF_MFD_CELL("ab8500-debug",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-debug"),
 #endif
-	{
-		.name = "ab8500-sysctrl",
-		.of_compatible = "stericsson,ab8500-sysctrl",
-	},
-	{
-		.name = "ab8500-ext-regulator",
-		.of_compatible = "stericsson,ab8500-ext-regulator",
-	},
-	{
-		.name = "ab8500-regulator",
-		.of_compatible = "stericsson,ab8500-regulator",
-	},
-	{
-		.name = "ab8500-clk",
-		.of_compatible = "stericsson,ab8500-clk",
-	},
-	{
-		.name = "ab8500-gpadc",
-		.of_compatible = "stericsson,ab8500-gpadc",
-	},
-	{
-		.name = "ab8500-rtc",
-		.of_compatible = "stericsson,ab8500-rtc",
-	},
-	{
-		.name = "ab8500-acc-det",
-		.of_compatible = "stericsson,ab8500-acc-det",
-	},
-	{
-
-		.name = "ab8500-poweron-key",
-		.of_compatible = "stericsson,ab8500-poweron-key",
-	},
-	{
-		.name = "ab8500-pwm",
-		.of_compatible = "stericsson,ab8500-pwm",
-		.id = 1,
-	},
-	{
-		.name = "ab8500-pwm",
-		.of_compatible = "stericsson,ab8500-pwm",
-		.id = 2,
-	},
-	{
-		.name = "ab8500-pwm",
-		.of_compatible = "stericsson,ab8500-pwm",
-		.id = 3,
-	},
-	{
-		.name = "ab8500-denc",
-		.of_compatible = "stericsson,ab8500-denc",
-	},
-	{
-		.name = "pinctrl-ab8500",
-		.of_compatible = "stericsson,ab8500-gpio",
-	},
-	{
-		.name = "abx500-temp",
-		.of_compatible = "stericsson,abx500-temp",
-	},
-	{
-		.name = "ab8500-usb",
-		.of_compatible = "stericsson,ab8500-usb",
-	},
-	{
-		.name = "ab8500-codec",
-		.of_compatible = "stericsson,ab8500-codec",
-	},
+	OF_MFD_CELL("ab8500-sysctrl",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-sysctrl"),
+	OF_MFD_CELL("ab8500-ext-regulator",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-ext-regulator"),
+	OF_MFD_CELL("ab8500-regulator",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-regulator"),
+	OF_MFD_CELL("abx500-clk",
+		    NULL, NULL, 0, 0, "stericsson,abx500-clk"),
+	OF_MFD_CELL("ab8500-gpadc",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-gpadc"),
+	OF_MFD_CELL("ab8500-rtc",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-rtc"),
+	OF_MFD_CELL("ab8500-acc-det",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-acc-det"),
+	OF_MFD_CELL("ab8500-poweron-key",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-poweron-key"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-denc",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-denc"),
+	OF_MFD_CELL("pinctrl-ab8500",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-gpio"),
+	OF_MFD_CELL("abx500-temp",
+		    NULL, NULL, 0, 0, "stericsson,abx500-temp"),
+	OF_MFD_CELL("ab8500-usb",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-usb"),
+	OF_MFD_CELL("ab8500-codec",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-codec"),
 };
 
 static const struct mfd_cell ab9540_devs[] = {
-- 
2.14.1
