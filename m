Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937ABC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C93F20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXaPBH1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C93F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeIADMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so12536114wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBNacEyfC2sxQkTUsbgz9G/Ps6i0fcLICjDHv6f9edM=;
        b=aXaPBH1UiJGthBKvZ8n5FnwQOJESgSI4nV5coJS00Gw4oOmrDh3rWjiSrAAYG84wpR
         71HVgEze4TsK6Q7a3Rf/5Q/gAaE/+MXM/NxQh3XufYo0vaRfk/MOlZRlAY/8HA3FnHh4
         fbaErCmua71GJcoOVN22mHJ18ZgLrvjFpUcXOfGIUUwSkovJMyq5WXD3h0WyM2qaMzsT
         kzCzIlg3n5bW376fW0Zw+lsAKexw+8IJHtCWR9C5I2MGRTwNbcxs8rignfbe+r4KJGSQ
         iopZ7Hqh62436hJ1YlOkHsvc2SjtB+IZAOb/5FTucUj2/YH5vjCu2jEJ857AwyC3ZhfH
         xzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBNacEyfC2sxQkTUsbgz9G/Ps6i0fcLICjDHv6f9edM=;
        b=PT8Mg3Fyg43gWgHSf9+SgYWecoTQn+Ij8sOFx1sb+lONRNgqG+fd+YBfoT0P2cGpeV
         CmPz7VeYHe0qPcp5U8yTmX+NvSuXQ7FgAmv8OADrMDonxfSzv5ogwJsqoYpPLybx+NE0
         SXuW8ig3BtFFsZOPZM8vPtGNnlukhYsgjFffGzOmyMAxUHZ1pO5Pe12Yaq0h6ewC/qfR
         O3DuXAQv5C38uGJBcgr1cQ9ri7BRAsmoXjG4/7BFB2p64r11A3CrA1dP+mXIB87HEB8C
         xL5JCK1uEmvHrpIlqibdOzFUR0+y1k46a7irhK9JnIY7OdgcSrWj2W6fTDo0KNTyhbRp
         wv/A==
X-Gm-Message-State: APzg51Cd4g0ct+MikU8B9i7rfJKRCNrBKXIfe++T0Wha3LpQxxzcD7sz
        Kei/5jDSwKI34BDznE0rLiWYhn8p25o=
X-Google-Smtp-Source: ANB0VdaRlIruVgYVlrjvbQkJEoaOVke7eCPu4q4hKHYkHf99f9swykTvlZvJXiZO82gJ84RkeKdn1A==
X-Received: by 2002:adf:c890:: with SMTP id k16-v6mr12598218wrh.6.1535756592623;
        Fri, 31 Aug 2018 16:03:12 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/20] staging:rtl8192u: Rename OFDM_Table_Length - Style
Date:   Sat,  1 Sep 2018 00:02:41 +0100
Message-Id: <20180831230250.16810-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the defined constant OFDM_Table_Length to OFDM_TABLE_LENGTH,
this clears the checkpatch issue with CamelCase naming.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h    | 2 +-
 drivers/staging/rtl8192u/r8192U_dm.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 87c1a69b2e1c..6edbc8146e82 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -152,7 +152,7 @@ extern u32 rt_global_debug_component;
 #define IEEE80211_WATCH_DOG_TIME    2000
 #define	PHY_BEACON_RSSI_SLID_WIN_MAX		10
 /* For Tx Power Tracking */
-#define		OFDM_Table_Length	19
+#define		OFDM_TABLE_LENGTH	19
 #define	CCK_Table_length	12
 
 /* For rtl819x */
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 5fb5f583f703..19b3b11c5edb 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -454,7 +454,7 @@ static void dm_bandwidth_autoswitch(struct net_device *dev)
 }	/* dm_BandwidthAutoSwitch */
 
 /* OFDM default at 0db, index=6. */
-static u32 OFDMSwingTable[OFDM_Table_Length] = {
+static u32 OFDMSwingTable[OFDM_TABLE_LENGTH] = {
 	0x7f8001fe,	/* 0, +6db */
 	0x71c001c7,	/* 1, +5db */
 	0x65400195,	/* 2, +4db */
@@ -672,7 +672,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 	if (!priv->btxpower_trackingInit) {
 		/* Query OFDM default setting */
 		tmpRegA = rtl8192_QueryBBReg(dev, rOFDM0_XATxIQImbalance, bMaskDWord);
-		for (i = 0; i < OFDM_Table_Length; i++) { /* find the index */
+		for (i = 0; i < OFDM_TABLE_LENGTH; i++) { /* find the index */
 			if (tmpRegA == OFDMSwingTable[i]) {
 				priv->OFDM_index = (u8)i;
 				RT_TRACE(COMP_POWER_TRACKING, "Initial reg0x%x = 0x%x, OFDM_index=0x%x\n",
@@ -716,8 +716,8 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 	if (priv->ThermalMeter[0] >= (u8)tmpRegA) {	/* lower temperature */
 		tmpOFDMindex = tmpCCK20Mindex = 6+(priv->ThermalMeter[0]-(u8)tmpRegA);
 		tmpCCK40Mindex = tmpCCK20Mindex - 6;
-		if (tmpOFDMindex >= OFDM_Table_Length)
-			tmpOFDMindex = OFDM_Table_Length-1;
+		if (tmpOFDMindex >= OFDM_TABLE_LENGTH)
+			tmpOFDMindex = OFDM_TABLE_LENGTH - 1;
 		if (tmpCCK20Mindex >= CCK_Table_length)
 			tmpCCK20Mindex = CCK_Table_length-1;
 		if (tmpCCK40Mindex >= CCK_Table_length)
-- 
2.18.0

