Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3925620883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949556;
	bh=92dGd4BTjHd8o5nMwNGjN6iDJZsPHaA8RH2zOSuB1kM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=okg/L214I6GkSWhhMMYjY/ula3ynXYmaNJQSG0HbMxBTdVuCuTDP0B5HRb4Cd4H/2
	 o87mW+8fDDDDnjQDj9Ea28YC0ZQ98/UqXigqlt1uWgq1yErQZeErUxKLP+M4QD4Spf
	 oG8yeH/AHNAnodhHNjYDuXb4vtxRHe4YGkii901c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfAHMMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHMMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:12:19 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451A22087F;
        Tue,  8 Jan 2019 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949538;
        bh=92dGd4BTjHd8o5nMwNGjN6iDJZsPHaA8RH2zOSuB1kM=;
        h=From:To:Cc:Subject:Date:From;
        b=gSH3cbJJIPYvBAFtZDf8/jUR86nKPdTF7SYCwA9mjIC0OvGXA76sm/93sVYFXqDe5
         8Ahjt2jYlvUp4O//0qEelDs4oFzTPfnnml4502XJf48j1OxacCvFckvJL+KIq5b0mk
         hep91VTTLn1Ld8x9aMGotlWXhPIgbkVyuykobWd4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] power: supply: charger-manager: Fix trivial language typos
Date:   Tue,  8 Jan 2019 13:12:12 +0100
Message-Id: <1546949532-30150-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix few trivial language typos.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/charger-manager.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 38be91f21cc4..2e8db5e6de0b 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -4,7 +4,7 @@
  *
  * This driver enables to monitor battery health and control charger
  * during suspend-to-mem.
- * Charger manager depends on other devices. register this later than
+ * Charger manager depends on other devices. Register this later than
  * the depending devices.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -29,7 +29,7 @@
 #include <linux/thermal.h>
 
 /*
- * Default termperature threshold for charging.
+ * Default temperature threshold for charging.
  * Every temperature units are in tenth of centigrade.
  */
 #define CM_DEFAULT_RECHARGE_TEMP_DIFF	50
@@ -356,7 +356,7 @@ static bool is_polling_required(struct charger_manager *cm)
  * Note that Charger Manager keeps the charger enabled regardless whether
  * the charger is charging or not (because battery is full or no external
  * power source exists) except when CM needs to disable chargers forcibly
- * bacause of emergency causes; when the battery is overheated or too cold.
+ * because of emergency causes; when the battery is overheated or too cold.
  */
 static int try_charger_enable(struct charger_manager *cm, bool enable)
 {
@@ -643,7 +643,7 @@ static int cm_check_thermal_status(struct charger_manager *cm)
 	if (ret) {
 		/* FIXME:
 		 * No information of battery temperature might
-		 * occur hazadous result. We have to handle it
+		 * occur hazardous result. We have to handle it
 		 * depending on battery type.
 		 */
 		dev_err(cm->dev, "Failed to get battery temperature\n");
@@ -693,7 +693,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 			uevent_notify(cm, default_event_names[temp_alrt]);
 
 	/*
-	 * Check whole charging duration and discharing duration
+	 * Check whole charging duration and discharging duration
 	 * after full-batt.
 	 */
 	} else if (!cm->emergency_stop && check_charging_duration(cm)) {
@@ -866,7 +866,7 @@ static void battout_handler(struct charger_manager *cm)
 }
 
 /**
- * misc_event_handler - Handler for other evnets
+ * misc_event_handler - Handler for other events
  * @cm: the Charger Manager representing the battery.
  * @type: the Charger Manager representing the battery.
  */
@@ -1218,7 +1218,7 @@ static int charger_extcon_init(struct charger_manager *cm,
 }
 
 /**
- * charger_manager_register_extcon - Register extcon device to recevie state
+ * charger_manager_register_extcon - Register extcon device to receive state
  *				     of charger cable.
  * @cm: the Charger Manager representing the battery.
  *
@@ -1538,7 +1538,7 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	of_property_read_u32(np, "cm-discharging-max",
 				&desc->discharging_max_duration_ms);
 
-	/* battery charger regualtors */
+	/* battery charger regulators */
 	desc->num_charger_regulators = of_get_child_count(np);
 	if (desc->num_charger_regulators) {
 		struct charger_regulator *chg_regs;
@@ -1801,7 +1801,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	/*
 	 * Charger-manager have to check the charging state right after
-	 * tialization of charger-manager and then update current charging
+	 * initialization of charger-manager and then update current charging
 	 * state.
 	 */
 	cm_monitor();
-- 
2.7.4

