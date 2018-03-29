Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeC2Eb1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:31:27 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:32910 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbeC2EbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:31:24 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] mfd: axp20x: Use DEFINE_RES_IRQ to declare resources for mfd_cells
Date: Thu, 29 Mar 2018 12:31:14 +0800
Message-Id: <20180329043115.7132-3-wens@csie.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329043115.7132-1-wens@csie.org>
References: <20180329043115.7132-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we were open coding the interrupts for the various mfd
cells. This made the code somewhat long due to pretty-formatting.

This patch convert those into one-line declarations with DEFINE_RES_IRQ,
making the code shorter and easier to read.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 187 +++++++++------------------------------------------
 1 file changed, 30 insertions(+), 157 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 14be0f658d74..b3051e1c3ddc 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -181,17 +181,8 @@ static const struct resource axp20x_ac_power_supply_resources[] = {
 };
 
 static const struct resource axp20x_pek_resources[] = {
-	{
-		.name	= "PEK_DBR",
-		.start	= AXP20X_IRQ_PEK_RIS_EDGE,
-		.end	= AXP20X_IRQ_PEK_RIS_EDGE,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.name	= "PEK_DBF",
-		.start	= AXP20X_IRQ_PEK_FAL_EDGE,
-		.end	= AXP20X_IRQ_PEK_FAL_EDGE,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
 static const struct resource axp20x_usb_power_supply_resources[] = {
@@ -207,93 +198,32 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
 };
 
 static const struct resource axp22x_pek_resources[] = {
-	{
-		.name   = "PEK_DBR",
-		.start  = AXP22X_IRQ_PEK_RIS_EDGE,
-		.end    = AXP22X_IRQ_PEK_RIS_EDGE,
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.name   = "PEK_DBF",
-		.start  = AXP22X_IRQ_PEK_FAL_EDGE,
-		.end    = AXP22X_IRQ_PEK_FAL_EDGE,
-		.flags  = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
 static const struct resource axp288_power_button_resources[] = {
-	{
-		.name	= "PEK_DBR",
-		.start	= AXP288_IRQ_POKP,
-		.end	= AXP288_IRQ_POKP,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "PEK_DBF",
-		.start	= AXP288_IRQ_POKN,
-		.end	= AXP288_IRQ_POKN,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(AXP288_IRQ_POKP, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP288_IRQ_POKN, "PEK_DBF"),
 };
 
 static const struct resource axp288_fuel_gauge_resources[] = {
-	{
-		.start = AXP288_IRQ_QWBTU,
-		.end   = AXP288_IRQ_QWBTU,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_WBTU,
-		.end   = AXP288_IRQ_WBTU,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_QWBTO,
-		.end   = AXP288_IRQ_QWBTO,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_WBTO,
-		.end   = AXP288_IRQ_WBTO,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_WL2,
-		.end   = AXP288_IRQ_WL2,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_WL1,
-		.end   = AXP288_IRQ_WL1,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(AXP288_IRQ_QWBTU),
+	DEFINE_RES_IRQ(AXP288_IRQ_WBTU),
+	DEFINE_RES_IRQ(AXP288_IRQ_QWBTO),
+	DEFINE_RES_IRQ(AXP288_IRQ_WBTO),
+	DEFINE_RES_IRQ(AXP288_IRQ_WL2),
+	DEFINE_RES_IRQ(AXP288_IRQ_WL1),
 };
 
 static const struct resource axp803_pek_resources[] = {
-	{
-		.name   = "PEK_DBR",
-		.start  = AXP803_IRQ_PEK_RIS_EDGE,
-		.end    = AXP803_IRQ_PEK_RIS_EDGE,
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.name   = "PEK_DBF",
-		.start  = AXP803_IRQ_PEK_FAL_EDGE,
-		.end    = AXP803_IRQ_PEK_FAL_EDGE,
-		.flags  = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
 static const struct resource axp809_pek_resources[] = {
-	{
-		.name   = "PEK_DBR",
-		.start  = AXP809_IRQ_PEK_RIS_EDGE,
-		.end    = AXP809_IRQ_PEK_RIS_EDGE,
-		.flags  = IORESOURCE_IRQ,
-	}, {
-		.name   = "PEK_DBF",
-		.start  = AXP809_IRQ_PEK_FAL_EDGE,
-		.end    = AXP809_IRQ_PEK_FAL_EDGE,
-		.flags  = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
 static const struct regmap_config axp152_regmap_config = {
@@ -738,83 +668,26 @@ static const struct mfd_cell axp152_cells[] = {
 };
 
 static const struct resource axp288_adc_resources[] = {
-	{
-		.name  = "GPADC",
-		.start = AXP288_IRQ_GPADC,
-		.end   = AXP288_IRQ_GPADC,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(AXP288_IRQ_GPADC, "GPADC"),
 };
 
 static const struct resource axp288_extcon_resources[] = {
-	{
-		.start = AXP288_IRQ_VBUS_FALL,
-		.end   = AXP288_IRQ_VBUS_FALL,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_VBUS_RISE,
-		.end   = AXP288_IRQ_VBUS_RISE,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_MV_CHNG,
-		.end   = AXP288_IRQ_MV_CHNG,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_BC_USB_CHNG,
-		.end   = AXP288_IRQ_BC_USB_CHNG,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(AXP288_IRQ_VBUS_FALL),
+	DEFINE_RES_IRQ(AXP288_IRQ_VBUS_RISE),
+	DEFINE_RES_IRQ(AXP288_IRQ_MV_CHNG),
+	DEFINE_RES_IRQ(AXP288_IRQ_BC_USB_CHNG),
 };
 
 static const struct resource axp288_charger_resources[] = {
-	{
-		.start = AXP288_IRQ_OV,
-		.end   = AXP288_IRQ_OV,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_DONE,
-		.end   = AXP288_IRQ_DONE,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_CHARGING,
-		.end   = AXP288_IRQ_CHARGING,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_SAFE_QUIT,
-		.end   = AXP288_IRQ_SAFE_QUIT,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_SAFE_ENTER,
-		.end   = AXP288_IRQ_SAFE_ENTER,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_QCBTU,
-		.end   = AXP288_IRQ_QCBTU,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_CBTU,
-		.end   = AXP288_IRQ_CBTU,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_QCBTO,
-		.end   = AXP288_IRQ_QCBTO,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.start = AXP288_IRQ_CBTO,
-		.end   = AXP288_IRQ_CBTO,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(AXP288_IRQ_OV),
+	DEFINE_RES_IRQ(AXP288_IRQ_DONE),
+	DEFINE_RES_IRQ(AXP288_IRQ_CHARGING),
+	DEFINE_RES_IRQ(AXP288_IRQ_SAFE_QUIT),
+	DEFINE_RES_IRQ(AXP288_IRQ_SAFE_ENTER),
+	DEFINE_RES_IRQ(AXP288_IRQ_QCBTU),
+	DEFINE_RES_IRQ(AXP288_IRQ_CBTU),
+	DEFINE_RES_IRQ(AXP288_IRQ_QCBTO),
+	DEFINE_RES_IRQ(AXP288_IRQ_CBTO),
 };
 
 static const struct mfd_cell axp288_cells[] = {
-- 
2.16.3
