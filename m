Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC2C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC7620841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgy1fD1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC7620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeIADMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34687 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so12552609wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v0EdwK4sfwOYrCIfogHGj+bPWOcMFcxLEavpzHboyRE=;
        b=Wgy1fD1Ssdj9vA0d6D1taBSILAn0cT3QJ3cGKDvKOKleAZDB7F/fGpDzsgHFO0EeDk
         CUVNB2DMpbJxEhGeo+4WJWTHo3WR51sEWTpwN9TmBlMXWyn/o9itm16u9IR221C6TKtc
         AoTuyarQ+HlnJKNliPRTcQqZorBHkQ6dsvDqFpD+sMkJt84UcCKPHRBfH8upte0DjYTK
         f1Mq0uXtHYFAaxrefKjRBSR5+kbC+71Q3jfoWNZQgg/m2C1NllHR7X4taf90/9O3uCSC
         QTj984DW169blex/Lc+3PQcNwCIwkCn74zVH77wjNlSmYgJjd4QQSCDTnIVdkwUepb3k
         DCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0EdwK4sfwOYrCIfogHGj+bPWOcMFcxLEavpzHboyRE=;
        b=S3ks/Ah1S5RjxyvcmEN64S2h0MDyOOGj80CjvxEgMkd3n48iovyzWuLPlUWPXpUwgG
         WH63j5p81ITwVMYCxpc2KkfFmYK5vFCVsm0qREqOxBW215lJCr4ncVhu7mDZjQauJVA5
         DMOIBtTFpjvwj+oFfZR+BWA1IK+xD8toJNqYSSt6VDchqOUhHumH6Xw/i/uBWTo9C7q8
         mCSpYZpTqLL3qj4Fb70sNtLWWJtoGTO69aXDi3jfLp/T7A2tSh/RvjGmSK69on7uelDU
         QgsL3ZDQvRxY581wwTGn89qPyGE+bCicnydrZhVRLCMSk99ckfNWb2ONAsX+3osNVHAf
         6NVA==
X-Gm-Message-State: APzg51A+LJIxiGynnIh1f1l8utPWAH0ENY2M9+8eyTacUzHz9g5pUp1M
        ffNYDa+Zd9MTFp73S9DvVNI2cjYjIok=
X-Google-Smtp-Source: ANB0VdbBV4T+Podd7us12dVsC5kTonzQAzw4OxNKI1lejIPoGv/Qfd4OQoQl8pKwoMtr3K1U2ACERg==
X-Received: by 2002:adf:9404:: with SMTP id 4-v6mr12887885wrq.129.1535756590573;
        Fri, 31 Aug 2018 16:03:10 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/20] staging:rtl8192u: Rename PHY_Beacon_RSSI_SLID_WIN_MAX - Style
Date:   Sat,  1 Sep 2018 00:02:40 +0100
Message-Id: <20180831230250.16810-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the Macro PHY_Beacon_RSSI_SLID_WIN_MAX to
PHY_BEACON_RSSI_SLID_WIN_MAX, this clears the checkpatch issue with
CamelCase naming.

This is purely a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 528c50be3894..87c1a69b2e1c 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -150,7 +150,7 @@ extern u32 rt_global_debug_component;
 #define RTL819X_DEFAULT_RF_TYPE RF_1T2R
 
 #define IEEE80211_WATCH_DOG_TIME    2000
-#define		PHY_Beacon_RSSI_SLID_WIN_MAX		10
+#define	PHY_BEACON_RSSI_SLID_WIN_MAX		10
 /* For Tx Power Tracking */
 #define		OFDM_Table_Length	19
 #define	CCK_Table_length	12
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index dd87cee6604b..4d43176bdb6c 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3997,15 +3997,15 @@ static void rtl8192_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 
 	if (pprevious_stats->bPacketBeacon) {
 		/* record the beacon pwdb to the sliding window. */
-		if (slide_beacon_adc_pwdb_statistics++ >= PHY_Beacon_RSSI_SLID_WIN_MAX) {
-			slide_beacon_adc_pwdb_statistics = PHY_Beacon_RSSI_SLID_WIN_MAX;
+		if (slide_beacon_adc_pwdb_statistics++ >= PHY_BEACON_RSSI_SLID_WIN_MAX) {
+			slide_beacon_adc_pwdb_statistics = PHY_BEACON_RSSI_SLID_WIN_MAX;
 			last_beacon_adc_pwdb = priv->stats.Slide_Beacon_pwdb[slide_beacon_adc_pwdb_index];
 			priv->stats.Slide_Beacon_Total -= last_beacon_adc_pwdb;
 		}
 		priv->stats.Slide_Beacon_Total += pprevious_stats->RxPWDBAll;
 		priv->stats.Slide_Beacon_pwdb[slide_beacon_adc_pwdb_index] = pprevious_stats->RxPWDBAll;
 		slide_beacon_adc_pwdb_index++;
-		if (slide_beacon_adc_pwdb_index >= PHY_Beacon_RSSI_SLID_WIN_MAX)
+		if (slide_beacon_adc_pwdb_index >= PHY_BEACON_RSSI_SLID_WIN_MAX)
 			slide_beacon_adc_pwdb_index = 0;
 		pprevious_stats->RxPWDBAll = priv->stats.Slide_Beacon_Total / slide_beacon_adc_pwdb_statistics;
 		if (pprevious_stats->RxPWDBAll >= 3)
-- 
2.18.0

