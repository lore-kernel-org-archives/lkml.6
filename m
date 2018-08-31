Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F15C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D0C2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skw9KttN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D0C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIADM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34910 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so6699951wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZn6Buj0kHcSnu+emL3gCADtTNyDJCyx6DThq5zVqgw=;
        b=Skw9KttNFKgrSw9QMwx1S521guWFPSPbfyyw+PghW9+5wN+OlShpRqUrMb7Bmo7THS
         ViCDJky/hgT9GFW1CUYNOtZz89dPsMhgmmHC/741grju7v7xFylGwy3IruHxtvmpGeG1
         ImutQjjllrw3NYYyCIvFNI0Z2paFq0XjuYFgpZ19ovsmedHoVANR8pluKaUknnNF91dR
         ru+ONJVRlLeC7m/M167BhCXFi/Uebc2Aa9Uqdtf+l349+Zu59+qAxWkBRU6RYvaHc2M7
         g170P2b5hjXwF+Eh3WWUMY23s/nZsy/W0IxPywWM5kjVELAgUIKra2Y99W+36kN2XVzM
         eYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZn6Buj0kHcSnu+emL3gCADtTNyDJCyx6DThq5zVqgw=;
        b=JJyz939zA/M68VWsymHkbhgR12Wa2nrSyk50yxG+D/2TXb1PiXyWQwBBN+q8QfmPJE
         f0mLk3KklZcKWtkG6bJYTottXKrNzwku9Xjs+lSiYf8hwdx3mH6tAmVmDtI0B64Ucea0
         QqxE0QyzIefpA9NIwcRfWIU9lJRfDvddcyEZr4nQ3FtIBHnvVto8CqpN9Oas4ol8qpxd
         WGl4P/oAXI6TsKJCI1zqTxfdUFLIbEGywhEh3pfTk95eH7jVwgF3RYlStizqoZKY0VIL
         FTAu1nbjvXnkPhwylDCrQ1aoueknMPZZi0TgOLdz77v7SJ+lqLWBRIXnvBn0x3i/OC7X
         xmTA==
X-Gm-Message-State: APzg51AqlKzy87VArXpiSUTp2jJQGSbBLwc43TyUEfIAD8IZ8XeoIPZ+
        d1uVXnFPHuXo7Mwqi93pPQcj93OoBz8=
X-Google-Smtp-Source: ANB0VdZKTep71vMWud6MKvvXW1pDMjhjCHbt4vj6DXs5+KYdzLVD9ag8qOA0m+4TVZ2jgURm4zgbXA==
X-Received: by 2002:a1c:d98a:: with SMTP id q132-v6mr6287876wmg.78.1535756594649;
        Fri, 31 Aug 2018 16:03:14 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:13 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/20] staging:rtl8192u: Rename CCK_Table_length - Style
Date:   Sat,  1 Sep 2018 00:02:42 +0100
Message-Id: <20180831230250.16810-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the constant CCK_Table_length to CCK_TABLE_LENGTH, this clears
the checkpatch issue with CamelCase naming.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h    |  2 +-
 drivers/staging/rtl8192u/r8192U_dm.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 6edbc8146e82..e86a4b35a1f4 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -153,7 +153,7 @@ extern u32 rt_global_debug_component;
 #define	PHY_BEACON_RSSI_SLID_WIN_MAX		10
 /* For Tx Power Tracking */
 #define		OFDM_TABLE_LENGTH	19
-#define	CCK_Table_length	12
+#define	CCK_TABLE_LENGTH	12
 
 /* For rtl819x */
 struct tx_desc_819x_usb {
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 19b3b11c5edb..874da0620936 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -476,7 +476,7 @@ static u32 OFDMSwingTable[OFDM_TABLE_LENGTH] = {
 	0x10000040	/* 18, -12db */
 };
 
-static u8	CCKSwingTable_Ch1_Ch13[CCK_Table_length][8] = {
+static u8	CCKSwingTable_Ch1_Ch13[CCK_TABLE_LENGTH][8] = {
 	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04},	/* 0, +0db ===> CCK40M default */
 	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03},	/* 1, -1db */
 	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03},	/* 2, -2db */
@@ -491,7 +491,7 @@ static u8	CCKSwingTable_Ch1_Ch13[CCK_Table_length][8] = {
 	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01}	/* 11, -11db */
 };
 
-static u8	CCKSwingTable_Ch14[CCK_Table_length][8] = {
+static u8	CCKSwingTable_Ch14[CCK_TABLE_LENGTH][8] = {
 	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00},	/* 0, +0db  ===> CCK40M default */
 	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00},	/* 1, -1db */
 	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00},	/* 2, -2db */
@@ -682,7 +682,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 
 		/* Query CCK default setting From 0xa22 */
 		TempCCk = rtl8192_QueryBBReg(dev, rCCK0_TxFilter1, bMaskByte2);
-		for (i = 0; i < CCK_Table_length; i++) {
+		for (i = 0; i < CCK_TABLE_LENGTH; i++) {
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
 				priv->CCK_index = (u8) i;
 				RT_TRACE(COMP_POWER_TRACKING, "Initial reg0x%x = 0x%x, CCK_index=0x%x\n",
@@ -718,10 +718,10 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 		tmpCCK40Mindex = tmpCCK20Mindex - 6;
 		if (tmpOFDMindex >= OFDM_TABLE_LENGTH)
 			tmpOFDMindex = OFDM_TABLE_LENGTH - 1;
-		if (tmpCCK20Mindex >= CCK_Table_length)
-			tmpCCK20Mindex = CCK_Table_length-1;
-		if (tmpCCK40Mindex >= CCK_Table_length)
-			tmpCCK40Mindex = CCK_Table_length-1;
+		if (tmpCCK20Mindex >= CCK_TABLE_LENGTH)
+			tmpCCK20Mindex = CCK_TABLE_LENGTH - 1;
+		if (tmpCCK40Mindex >= CCK_TABLE_LENGTH)
+			tmpCCK40Mindex = CCK_TABLE_LENGTH - 1;
 	} else {
 		tmpval = (u8)tmpRegA - priv->ThermalMeter[0];
 
-- 
2.18.0

