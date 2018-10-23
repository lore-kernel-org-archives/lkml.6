Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA7BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458AE20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458AE20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeJXBa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:30:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53576 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeJXBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:30:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NH6Zxp056817;
        Tue, 23 Oct 2018 12:06:35 -0500
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NH6Z9P127603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 12:06:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 12:06:35 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 12:06:35 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NH6YZ1005566;
        Tue, 23 Oct 2018 12:06:34 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.171.190])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9NH6Yx15370;
        Tue, 23 Oct 2018 12:06:34 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <lee.jones@linaro.org>,
        <tony@atomide.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 6/7] mfd: ti-lmu: Remove support for LM3633
Date:   Tue, 23 Oct 2018 12:06:22 -0500
Message-ID: <20181023170623.31820-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181023170623.31820-1-dmurphy@ti.com>
References: <20181023170623.31820-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for the LM3633 from the ti-lmu
driver in favor of a dedicated LED driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/mfd/Kconfig  |  2 +-
 drivers/mfd/ti-lmu.c | 21 ---------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 9b04dd527c68..225cb3be350c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1293,7 +1293,7 @@ config MFD_TI_LMU
 	help
 	  Say yes here to enable support for TI LMU chips.
 
-	  TI LMU MFD supports LM3532, LM3631, LM3632, LM3633, and LM3695.
+	  TI LMU MFD supports LM3532, LM3631, LM3632, and LM3695.
 	  It consists of backlight, LED and regulator driver.
 	  It provides consistent device controls for lighting functions.
 
diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index b6bfa99a29dd..2cf8a23cba52 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -102,24 +102,6 @@ static struct mfd_cell lm3632_devices[] = {
 	},
 };
 
-static struct mfd_cell lm3633_devices[] = {
-	{
-		.name          = "ti-lmu-backlight",
-		.id            = LM3633,
-		.of_compatible = "ti,lm3633-backlight",
-	},
-	{
-		.name          = "lm3633-leds",
-		.of_compatible = "ti,lm3633-leds",
-	},
-	/* Monitoring driver for open/short circuit detection */
-	{
-		.name          = "ti-lmu-fault-monitor",
-		.id            = LM3633,
-		.of_compatible = "ti,lm3633-fault-monitor",
-	},
-};
-
 static struct mfd_cell lm3695_devices[] = {
 	{
 		.name          = "ti-lmu-backlight",
@@ -139,14 +121,12 @@ static const struct ti_lmu_data chip##_data =	\
 TI_LMU_DATA(lm3532, LM3532_MAX_REG);
 TI_LMU_DATA(lm3631, LM3631_MAX_REG);
 TI_LMU_DATA(lm3632, LM3632_MAX_REG);
-TI_LMU_DATA(lm3633, LM3633_MAX_REG);
 TI_LMU_DATA(lm3695, LM3695_MAX_REG);
 
 static const struct of_device_id ti_lmu_of_match[] = {
 	{ .compatible = "ti,lm3532", .data = &lm3532_data },
 	{ .compatible = "ti,lm3631", .data = &lm3631_data },
 	{ .compatible = "ti,lm3632", .data = &lm3632_data },
-	{ .compatible = "ti,lm3633", .data = &lm3633_data },
 	{ .compatible = "ti,lm3695", .data = &lm3695_data },
 	{ }
 };
@@ -219,7 +199,6 @@ static const struct i2c_device_id ti_lmu_ids[] = {
 	{ "lm3532", LM3532 },
 	{ "lm3631", LM3631 },
 	{ "lm3632", LM3632 },
-	{ "lm3633", LM3633 },
 	{ "lm3695", LM3695 },
 	{ }
 };
-- 
2.19.0

