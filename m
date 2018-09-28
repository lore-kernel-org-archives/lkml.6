Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E944C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E042073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u97iCebQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E042073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeI2A4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:56:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39310 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeI2AzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:55:06 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SIU0fb105742;
        Fri, 28 Sep 2018 13:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538159400;
        bh=OtCiIwkynXOu9gjT1n1TJgIb45eFR7aChLIQ5ojHiko=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=u97iCebQgGeO7clanCyI9giIP5d8sdSW1t5prbPsl+jNpP2jEcC/DCEAx1BLLjt23
         nVdJ/rlWwWOAo0CqiHCXsjpZttgxi0aD1ZdiH/VsRiRn1i8CgcRwjAwZyXMk/RWWf5
         /VDvF9JCrAUnHRp9MiHtNaPbLFg8Be6OTQTl1oik=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SIU0ic001805;
        Fri, 28 Sep 2018 13:30:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 13:30:00 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 13:30:00 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SIU0HG001405;
        Fri, 28 Sep 2018 13:30:00 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.149.181])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8SITxx27706;
        Fri, 28 Sep 2018 13:29:59 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 3/9] mfd: ti-lmu: Remove support for LM3697
Date:   Fri, 28 Sep 2018 13:29:48 -0500
Message-ID: <20180928182954.25446-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180928182954.25446-1-dmurphy@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for the LM3697 from the ti-lmu
driver in favor of a dedicated LED driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/mfd/Kconfig                 |  2 +-
 drivers/mfd/ti-lmu.c                | 17 -----------
 include/linux/mfd/ti-lmu-register.h | 44 -----------------------------
 include/linux/mfd/ti-lmu.h          |  1 -
 4 files changed, 1 insertion(+), 63 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 11841f4b7b2b..9b04dd527c68 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1293,7 +1293,7 @@ config MFD_TI_LMU
 	help
 	  Say yes here to enable support for TI LMU chips.
 
-	  TI LMU MFD supports LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
+	  TI LMU MFD supports LM3532, LM3631, LM3632, LM3633, and LM3695.
 	  It consists of backlight, LED and regulator driver.
 	  It provides consistent device controls for lighting functions.
 
diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index cfb411cde51c..b6bfa99a29dd 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -128,20 +128,6 @@ static struct mfd_cell lm3695_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3697_devices[] = {
-	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3697,
-		.of_compatible = "ti,lm3697-backlight",
-	},
-	/* Monitoring driver for open/short circuit detection */
-	{
-		.name          = "ti-lmu-fault-monitor",
-		.id            = LM3697,
-		.of_compatible = "ti,lm3697-fault-monitor",
-	},
-};
-
 #define TI_LMU_DATA(chip, max_reg)		\
 static const struct ti_lmu_data chip##_data =	\
 {						\
@@ -155,7 +141,6 @@ TI_LMU_DATA(lm3631, LM3631_MAX_REG);
 TI_LMU_DATA(lm3632, LM3632_MAX_REG);
 TI_LMU_DATA(lm3633, LM3633_MAX_REG);
 TI_LMU_DATA(lm3695, LM3695_MAX_REG);
-TI_LMU_DATA(lm3697, LM3697_MAX_REG);
 
 static const struct of_device_id ti_lmu_of_match[] = {
 	{ .compatible = "ti,lm3532", .data = &lm3532_data },
@@ -163,7 +148,6 @@ static const struct of_device_id ti_lmu_of_match[] = {
 	{ .compatible = "ti,lm3632", .data = &lm3632_data },
 	{ .compatible = "ti,lm3633", .data = &lm3633_data },
 	{ .compatible = "ti,lm3695", .data = &lm3695_data },
-	{ .compatible = "ti,lm3697", .data = &lm3697_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
@@ -237,7 +221,6 @@ static const struct i2c_device_id ti_lmu_ids[] = {
 	{ "lm3632", LM3632 },
 	{ "lm3633", LM3633 },
 	{ "lm3695", LM3695 },
-	{ "lm3697", LM3697 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ti_lmu_ids);
diff --git a/include/linux/mfd/ti-lmu-register.h b/include/linux/mfd/ti-lmu-register.h
index 2125c7c02818..99711ff4b809 100644
--- a/include/linux/mfd/ti-lmu-register.h
+++ b/include/linux/mfd/ti-lmu-register.h
@@ -233,48 +233,4 @@
 #define LM3695_REG_BRT_MSB			0x14
 
 #define LM3695_MAX_REG				0x14
-
-/* LM3697 */
-#define LM3697_REG_HVLED_OUTPUT_CFG		0x10
-#define LM3697_HVLED1_CFG_MASK			BIT(0)
-#define LM3697_HVLED2_CFG_MASK			BIT(1)
-#define LM3697_HVLED3_CFG_MASK			BIT(2)
-#define LM3697_HVLED1_CFG_SHIFT			0
-#define LM3697_HVLED2_CFG_SHIFT			1
-#define LM3697_HVLED3_CFG_SHIFT			2
-
-#define LM3697_REG_BL0_RAMP			0x11
-#define LM3697_REG_BL1_RAMP			0x12
-#define LM3697_RAMPUP_MASK			0xF0
-#define LM3697_RAMPUP_SHIFT			4
-#define LM3697_RAMPDN_MASK			0x0F
-#define LM3697_RAMPDN_SHIFT			0
-
-#define LM3697_REG_RAMP_CONF			0x14
-#define LM3697_RAMP_MASK			0x0F
-#define LM3697_RAMP_EACH			0x05
-
-#define LM3697_REG_PWM_CFG			0x1C
-#define LM3697_PWM_A_MASK			BIT(0)
-#define LM3697_PWM_B_MASK			BIT(1)
-
-#define LM3697_REG_IMAX_A			0x17
-#define LM3697_REG_IMAX_B			0x18
-
-#define LM3697_REG_FEEDBACK_ENABLE		0x19
-
-#define LM3697_REG_BRT_A_LSB			0x20
-#define LM3697_REG_BRT_A_MSB			0x21
-#define LM3697_REG_BRT_B_LSB			0x22
-#define LM3697_REG_BRT_B_MSB			0x23
-
-#define LM3697_REG_ENABLE			0x24
-
-#define LM3697_REG_OPEN_FAULT_STATUS		0xB0
-
-#define LM3697_REG_SHORT_FAULT_STATUS		0xB2
-
-#define LM3697_REG_MONITOR_ENABLE		0xB4
-
-#define LM3697_MAX_REG				0xB4
 #endif
diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
index 09d5f30384e5..bc9272f08f47 100644
--- a/include/linux/mfd/ti-lmu.h
+++ b/include/linux/mfd/ti-lmu.h
@@ -26,7 +26,6 @@ enum ti_lmu_id {
 	LM3632,
 	LM3633,
 	LM3695,
-	LM3697,
 	LMU_MAX_ID,
 };
 
-- 
2.19.0

