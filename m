Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CA6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C03920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="l1SeVhTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C03920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeK0CWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:22:49 -0500
Received: from plaes.org ([188.166.43.21]:50026 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeK0CWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:22:46 -0500
Received: from localhost (85.253.196.132.cable.starman.ee [85.253.196.132])
        by plaes.org (Postfix) with ESMTPSA id 2DA2541D08;
        Mon, 26 Nov 2018 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1543246098; bh=0/zeXaRT1SuyJH/4Y5QCzpn5enDZ8JuES0L/CmDuUAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1SeVhTZSgnhef9gJqSy0auaUCZA+WWB/3kz54L/rDDvL7F20gkcB0a11x7X823wR
         p9bYNs4/xi2E+tDNIh/wbZ7RyfNDqZfH1QWfL6/vcHR4PLIPr1nKJGUfPNaG4kSi77
         CYI4cDohV39Cgs6r3U6zglTRjOgk0aaE+ptCNS/mgc3YKu5A4TjmOoZQIyEPdQ2jlF
         U2OBNNBM4Eq03oiWOHHB+nipDc9bK16313lljRbldj29VkFw8nXijWDRl3qy2haMn1
         rfxB1q8n3Wj2d3JRAwvO9QApr6PWyN2wNYdZdY8bzenGNGHInRmMCNPr+SoY57DtvQ
         4tBNtxF9vluDQ==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Priit Laes <plaes@plaes.org>, Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH 14/14] power: supply: axp288: use the BIT() macro
Date:   Mon, 26 Nov 2018 17:27:55 +0200
Message-Id: <c500c452040428a2a5fae32c48c9ba778df9fb17.1543245984.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

Make use of the recommended BIT() macro for bit defines.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/power/supply/axp288_charger.c | 35 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 735658e..f8c6da9 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
@@ -29,17 +30,17 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/extcon.h>
 
-#define PS_STAT_VBUS_TRIGGER		(1 << 0)
-#define PS_STAT_BAT_CHRG_DIR		(1 << 2)
-#define PS_STAT_VBAT_ABOVE_VHOLD	(1 << 3)
-#define PS_STAT_VBUS_VALID		(1 << 4)
-#define PS_STAT_VBUS_PRESENT		(1 << 5)
+#define PS_STAT_VBUS_TRIGGER		BIT(0)
+#define PS_STAT_BAT_CHRG_DIR		BIT(2)
+#define PS_STAT_VBAT_ABOVE_VHOLD	BIT(3)
+#define PS_STAT_VBUS_VALID		BIT(4)
+#define PS_STAT_VBUS_PRESENT		BIT(5)
 
-#define CHRG_STAT_BAT_SAFE_MODE		(1 << 3)
-#define CHRG_STAT_BAT_VALID		(1 << 4)
-#define CHRG_STAT_BAT_PRESENT		(1 << 5)
-#define CHRG_STAT_CHARGING		(1 << 6)
-#define CHRG_STAT_PMIC_OTP		(1 << 7)
+#define CHRG_STAT_BAT_SAFE_MODE		BIT(3)
+#define CHRG_STAT_BAT_VALID		BIT(4)
+#define CHRG_STAT_BAT_PRESENT		BIT(5)
+#define CHRG_STAT_CHARGING		BIT(6)
+#define CHRG_STAT_PMIC_OTP		BIT(7)
 
 #define VBUS_ISPOUT_CUR_LIM_MASK	0x03
 #define VBUS_ISPOUT_CUR_LIM_BIT_POS	0
@@ -52,33 +53,33 @@
 #define VBUS_ISPOUT_VHOLD_SET_OFFSET	4000	/* 4000mV */
 #define VBUS_ISPOUT_VHOLD_SET_LSB_RES	100	/* 100mV */
 #define VBUS_ISPOUT_VHOLD_SET_4300MV	0x3	/* 4300mV */
-#define VBUS_ISPOUT_VBUS_PATH_DIS	(1 << 7)
+#define VBUS_ISPOUT_VBUS_PATH_DIS	BIT(7)
 
 #define CHRG_CCCV_CC_MASK		0xf		/* 4 bits */
 #define CHRG_CCCV_CC_BIT_POS		0
 #define CHRG_CCCV_CC_OFFSET		200		/* 200mA */
 #define CHRG_CCCV_CC_LSB_RES		200		/* 200mA */
-#define CHRG_CCCV_ITERM_20P		(1 << 4)	/* 20% of CC */
+#define CHRG_CCCV_ITERM_20P		BIT(4)		/* 20% of CC */
 #define CHRG_CCCV_CV_MASK		0x60		/* 2 bits */
 #define CHRG_CCCV_CV_BIT_POS		5
 #define CHRG_CCCV_CV_4100MV		0x0		/* 4.10V */
 #define CHRG_CCCV_CV_4150MV		0x1		/* 4.15V */
 #define CHRG_CCCV_CV_4200MV		0x2		/* 4.20V */
 #define CHRG_CCCV_CV_4350MV		0x3		/* 4.35V */
-#define CHRG_CCCV_CHG_EN		(1 << 7)
+#define CHRG_CCCV_CHG_EN		BIT(7)
 
 #define CNTL2_CC_TIMEOUT_MASK		0x3	/* 2 bits */
 #define CNTL2_CC_TIMEOUT_OFFSET		6	/* 6 Hrs */
 #define CNTL2_CC_TIMEOUT_LSB_RES	2	/* 2 Hrs */
 #define CNTL2_CC_TIMEOUT_12HRS		0x3	/* 12 Hrs */
-#define CNTL2_CHGLED_TYPEB		(1 << 4)
-#define CNTL2_CHG_OUT_TURNON		(1 << 5)
+#define CNTL2_CHGLED_TYPEB		BIT(4)
+#define CNTL2_CHG_OUT_TURNON		BIT(5)
 #define CNTL2_PC_TIMEOUT_MASK		0xC0
 #define CNTL2_PC_TIMEOUT_OFFSET		40	/* 40 mins */
 #define CNTL2_PC_TIMEOUT_LSB_RES	10	/* 10 mins */
 #define CNTL2_PC_TIMEOUT_70MINS		0x3
 
-#define CHRG_ILIM_TEMP_LOOP_EN		(1 << 3)
+#define CHRG_ILIM_TEMP_LOOP_EN		BIT(3)
 #define CHRG_VBUS_ILIM_MASK		0xf0
 #define CHRG_VBUS_ILIM_BIT_POS		4
 #define CHRG_VBUS_ILIM_100MA		0x0	/* 100mA */
@@ -94,7 +95,7 @@
 #define CHRG_VLTFC_0C			0xA5	/* 0 DegC */
 #define CHRG_VHTFC_45C			0x1F	/* 45 DegC */
 
-#define FG_CNTL_OCV_ADJ_EN		(1 << 3)
+#define FG_CNTL_OCV_ADJ_EN		BIT(3)
 
 #define CV_4100MV			4100	/* 4100mV */
 #define CV_4150MV			4150	/* 4150mV */
-- 
git-series 0.9.1
