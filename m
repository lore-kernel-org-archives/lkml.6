Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B32C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93DD208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="re6vlDjJ";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="re6vlDjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93DD208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeGaTbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:31:07 -0400
Received: from node.akkea.ca ([192.155.83.177]:55600 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbeGaTbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:31:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id BF082542069;
        Tue, 31 Jul 2018 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533059381; bh=Epe6Q+ttZ2ewqaZSTZlr+Qk5Mq5kQxqihMC/HRblCYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=re6vlDjJpBZTef3mwEcYxEe88U/FYuBgftelmSWHYW3DH/bX+H2NuyMD9SGV8nMR2
         ZgUS80sLS2lg4tgMyTFIwKAhoeaC6nSva93fSZztXyi5XAQ9++Y/liyoeBxeVThDKW
         pX7SfRPe8UiyCA9P6GLKT88LoRismGOwvPksczSo=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xDAzGmDUzYnt; Tue, 31 Jul 2018 17:49:41 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id ECE8954204B;
        Tue, 31 Jul 2018 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533059381; bh=Epe6Q+ttZ2ewqaZSTZlr+Qk5Mq5kQxqihMC/HRblCYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=re6vlDjJpBZTef3mwEcYxEe88U/FYuBgftelmSWHYW3DH/bX+H2NuyMD9SGV8nMR2
         ZgUS80sLS2lg4tgMyTFIwKAhoeaC6nSva93fSZztXyi5XAQ9++Y/liyoeBxeVThDKW
         pX7SfRPe8UiyCA9P6GLKT88LoRismGOwvPksczSo=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 3/4] power: bq25890_charger.c: Add the BQ25896 part
Date:   Tue, 31 Jul 2018 11:49:08 -0600
Message-Id: <20180731174909.9392-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731174909.9392-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731174909.9392-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BQ25896 is almost identical to the BQ25890.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../bindings/power/supply/bq25890.txt         |  3 +++
 drivers/power/supply/bq25890_charger.c        | 24 +++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index c9dd17d142ad..dc0568933359 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -1,5 +1,8 @@
 Binding for TI bq25890 Li-Ion Charger
 
+This driver will support the bq25896 and the bq25890. There are other ICs
+in the same family but those have not been tested.
+
 Required properties:
 - compatible: Should contain one of the following:
     * "ti,bq25890"
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index ca61278e932e..23b39da07e56 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -32,6 +32,7 @@
 #define BQ25890_IRQ_PIN			"bq25890_irq"
 
 #define BQ25890_ID			3
+#define BQ25896_ID			0
 
 enum bq25890_fields {
 	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
@@ -153,8 +154,8 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_CONV_RATE]		= REG_FIELD(0x02, 6, 6),
 	[F_BOOSTF]		= REG_FIELD(0x02, 5, 5),
 	[F_ICO_EN]		= REG_FIELD(0x02, 4, 4),
-	[F_HVDCP_EN]		= REG_FIELD(0x02, 3, 3),
-	[F_MAXC_EN]		= REG_FIELD(0x02, 2, 2),
+	[F_HVDCP_EN]		= REG_FIELD(0x02, 3, 3),  // reserved on BQ25896
+	[F_MAXC_EN]		= REG_FIELD(0x02, 2, 2),  // reserved on BQ25896
 	[F_FORCE_DPM]		= REG_FIELD(0x02, 1, 1),
 	[F_AUTO_DPDM_EN]	= REG_FIELD(0x02, 0, 0),
 	/* REG03 */
@@ -163,6 +164,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_OTG_CFG]		= REG_FIELD(0x03, 5, 5),
 	[F_CHG_CFG]		= REG_FIELD(0x03, 4, 4),
 	[F_SYSVMIN]		= REG_FIELD(0x03, 1, 3),
+	/* MIN_VBAT_SEL on BQ25896 */
 	/* REG04 */
 	[F_PUMPX_EN]		= REG_FIELD(0x04, 7, 7),
 	[F_ICHG]		= REG_FIELD(0x04, 0, 6),
@@ -181,7 +183,7 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_CHG_TMR]		= REG_FIELD(0x07, 1, 2),
 	[F_JEITA_ISET]		= REG_FIELD(0x07, 0, 0),
 	/* REG08 */
-	[F_BATCMP]		= REG_FIELD(0x08, 6, 7),
+	[F_BATCMP]		= REG_FIELD(0x08, 6, 7), // 5-7 on BQ25896
 	[F_VCLAMP]		= REG_FIELD(0x08, 2, 4),
 	[F_TREG]		= REG_FIELD(0x08, 0, 1),
 	/* REG09 */
@@ -195,12 +197,13 @@ static const struct reg_field bq25890_reg_fields[] = {
 	[F_PUMPX_DN]		= REG_FIELD(0x09, 0, 0),
 	/* REG0A */
 	[F_BOOSTV]		= REG_FIELD(0x0A, 4, 7),
+	/* PFM_OTG_DIS 3 on BQ25896 */
 	[F_BOOSTI]		= REG_FIELD(0x0A, 0, 2),
 	/* REG0B */
 	[F_VBUS_STAT]		= REG_FIELD(0x0B, 5, 7),
 	[F_CHG_STAT]		= REG_FIELD(0x0B, 3, 4),
 	[F_PG_STAT]		= REG_FIELD(0x0B, 2, 2),
-	[F_SDP_STAT]		= REG_FIELD(0x0B, 1, 1),
+	[F_SDP_STAT]		= REG_FIELD(0x0B, 1, 1), // reserved on BQ25896
 	[F_VSYS_STAT]		= REG_FIELD(0x0B, 0, 0),
 	/* REG0C */
 	[F_WD_FAULT]		= REG_FIELD(0x0C, 7, 7),
@@ -396,6 +399,16 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->strval = BQ25890_MANUFACTURER;
 		break;
 
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		if (bq->chip_id == BQ25890_ID)
+			val->strval = "BQ25890";
+		else if (bq->chip_id == BQ25896_ID)
+			val->strval = "BQ25896";
+		else
+			val->strval = "UNKNOWN";
+
+		break;
+
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = state.online;
 		break;
@@ -647,6 +660,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 
 static enum power_supply_property bq25890_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -848,7 +862,7 @@ static int bq25890_probe(struct i2c_client *client,
 		return bq->chip_id;
 	}
 
-	if (bq->chip_id != BQ25890_ID) {
+	if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25896_ID)) {
 		dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
 		return -ENODEV;
 	}
-- 
2.17.1

