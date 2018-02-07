Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbeBGWNM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:13:12 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40796 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeBGWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:13:10 -0500
X-Google-Smtp-Source: AH8x2266XxXvkkmLxgk+FG5sHvc0hLnJCWemaigszP7F6xTho+cNjtnx1KPTXKFiFwHqoa8wMKJMew==
From: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
Subject: [PATCH] platform/x86: dell-laptop: Removed duplicates in DMI whitelist
Date: Thu,  8 Feb 2018 01:12:26 +0300
Message-Id: <20180207221226.11345-1-alexander.n.abrosimov@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a mistake in which several entries were duplicated in the DMI list
from the below commit
fe486138 platform/x86: dell-laptop: Add 2-in-1 devices to the DMI whitelist

Signed-off-by: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
---
 drivers/platform/x86/dell-laptop.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index a7b141992cb3..a66a6a6e47b9 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -125,28 +125,10 @@ static const struct dmi_system_id dell_device_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
 		},
 	},
 	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "30"), /*Tablet*/
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /*Convertible*/
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
-		},
-	},
-	{
 		.ident = "Dell Computer Corporation",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
 			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
 		},
-- 
2.13.6
