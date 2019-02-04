Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF26C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71F92087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="QLypJWLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfBDUWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:22:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33393 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfBDUTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:32 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so12518640itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=nXElogSJfxXDiCsM3B30I0wm02vakS82aG0ktAJScis=;
        b=QLypJWLMLOhLnYVSx5E2XKPhzmj6DdRBkMXwxZk5EX/GFtGOhjZO0Wky9kSglICgLQ
         taC7D5RwM8lvwm4XLLhQ3fs+A9QZNP8DnSCq6TOp6cRAkVdiDNlqxph4YAFp/RKivApn
         fORyq3QYUnO/iI9hGUYkFLe7VodPSX69dSR6OOSagwO2j3D9AkMnOfuw7be1fvEdKpHg
         oO2/vLR8Oq9ufgWla9HGA6Dzvhvpsr5lFrDYiqnsOlozexIgQhrWTFCcPa4OKYqXvOFo
         9rU/NJSX84H+w2eB+YZm0eORLY5Si3DkN1Ki+0SBwp9QKFVAjsf7TMtGOTI0h3W4AAXH
         FJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=nXElogSJfxXDiCsM3B30I0wm02vakS82aG0ktAJScis=;
        b=XZ5aDlXE4odJxA6qTqQEakVJsoWORJkDu03dBCyOgwluhVGB4d7L/HWvpTd8ZV/A2S
         s4RTzfA7o+f8lo3T5yfVRmNVYmRUo4/OF5xA6z8117HgYtso6npDyMaepFUlr10BT9yq
         /r5ohBfwLOmVZceIwjHXj7UHG5zZAOt7V3purvcUdo2nB/42/6vmaWigw3incZqzKEff
         ornMtm36knGqpGo+VZp6DHDJUPxNxm14bP52eP4vMxFy04D64rS9IS4dTLoNVqRTbyNP
         LOUOIjIpKUJTFz+sy00M9LL7aS1ftBbJQVIh2A0aOSHQ//rMT8dmje01KrE2ykFAJ8A8
         5Y5Q==
X-Gm-Message-State: AHQUAuYdJp9JzEIjzewqGiPGWSzI981nQCMdGEGmoHePg0AHuXyD9e9U
        ARqmdaX2MQZRvad8NHIT6Fimdw==
X-Google-Smtp-Source: AHgI3IYBkfdUvhxV7oZPlkWqRxDaTqgCl+ocNyekIIsdwGqHgnCOpesWCPWMMEvr9+CfnCSvQ0f8og==
X-Received: by 2002:a6b:c9c8:: with SMTP id z191mr768514iof.13.1549311571680;
        Mon, 04 Feb 2019 12:19:31 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id x79sm470003ita.34.2019.02.04.12.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:19:31 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] hwmon: (lm85) support the LM96000
Date:   Mon,  4 Feb 2019 13:19:05 -0700
Message-Id: <20190204201906.8859-4-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204201906.8859-1-jgebben@sweptlaser.com>
References: <20190204201906.8859-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been supported as a generic lm85 for quite some time.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 Documentation/hwmon/lm85 | 6 +++++-
 drivers/hwmon/lm85.c     | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
index 7c49feaa79d2..4f531f4acc3f 100644
--- a/Documentation/hwmon/lm85
+++ b/Documentation/hwmon/lm85
@@ -3,9 +3,13 @@ Kernel driver lm85
 
 Supported chips:
   * National Semiconductor LM85 (B and C versions)
-    Prefix: 'lm85'
+    Prefix: 'lm85b' or 'lm85c'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
     Datasheet: http://www.national.com/pf/LM/LM85.html
+  * Texas Instruments LM96000
+    Prefix: 'lm9600'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.ti.com/lit/ds/symlink/lm96000.pdf
   * Analog Devices ADM1027
     Prefix: 'adm1027'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 4b15193d195c..b23cf8e4c54b 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -41,7 +41,7 @@
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 enum chips {
-	lm85,
+	lm85, lm96000,
 	adm1027, adt7463, adt7468,
 	emc6d100, emc6d102, emc6d103, emc6d103s
 };
@@ -1499,7 +1499,7 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 					"Found Winbond WPCD377I, ignoring\n");
 				return -ENODEV;
 			}
-			type_name = "lm85";
+			type_name = "lm96000";
 			break;
 		}
 	} else if (company == LM85_COMPANY_ANALOG_DEV) {
@@ -1623,6 +1623,7 @@ static const struct i2c_device_id lm85_id[] = {
 	{ "lm85", lm85 },
 	{ "lm85b", lm85 },
 	{ "lm85c", lm85 },
+	{ "lm96000", lm96000 },
 	{ "emc6d100", emc6d100 },
 	{ "emc6d101", emc6d100 },
 	{ "emc6d102", emc6d102 },
@@ -1657,6 +1658,10 @@ static const struct of_device_id lm85_of_match[] = {
 		.compatible = "national,lm85c",
 		.data = (void *)lm85
 	},
+	{
+		.compatible = "ti,lm96000",
+		.data = (void *)lm96000
+	},
 	{
 		.compatible = "smsc,emc6d100",
 		.data = (void *)emc6d100
-- 
2.17.1

