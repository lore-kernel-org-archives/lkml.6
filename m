Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F5C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014B52083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXoVKo9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014B52083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIADMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37783 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so6643181wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CWn75krmwHooT4pjFCD3x30OOQnXNj/Fi4ruRVc5sCs=;
        b=aXoVKo9u48MKOmG3xyJXBs/LJBFkp+5QZBfC9YTWe67xZxwqH5K3mprp6vVPO7ZiaE
         4pDR0pC0B7rIaQBlxelaeoYS6RhEcWgbjH433mcPK5FkecGxX5sPyqkfZE/ckoqwbfTY
         IVzDtcSuqBxfYQuEfZrkJ7adDlrxilV3R+zkowRrZ90HyrngvsXhWFwH+CQ6LiL59Q9U
         FAMsL/qgmov/H37zsf5LJI0g3Bvi9tJQMhIFGInxyYcReDKgiU/qmFEWJ9cy559lwNke
         3VpjtngS3Q5jSfwUJedjpQXzvHOr8XGG0MlYjBU5KjuTvAkfAXtYWF3KPipYXh8GeA5e
         m93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CWn75krmwHooT4pjFCD3x30OOQnXNj/Fi4ruRVc5sCs=;
        b=YM5iWPHQHLGKkAtrkBDjgZ1qLw5+7LbnIff+7HofuC2DlIx4B2Cc5fVvWYGiLxfq+p
         y4b73lsR+HDvMATqMpxduydvY9gZ8SKAJwXu5t8Pys+F/q1r1N6tTH72csDvp/igT/yr
         IrM8aBviCCQrc5MsACtGXo6NIVC6NTzNwK01FodfcDErQ7MDdkPQNJ90BgNc/xYwj7nj
         QMvKYvu3SIjB77wSE1INSsbRZ7tjaAm4TEkPDn8kBKeiSVWk0ELjnDRvcw7vvS5eMoKp
         GsJjUBIiMQcZ0IjfQBQFJyT+ZPRctFh3dwaEfNnVjbhU278MKw/iZlH3c1lPQkXISoJ0
         ahXA==
X-Gm-Message-State: APzg51DYUIbsOLqrOFpK1k/MS/YzCfQtQs/5y7XnwKq/a7B63n5E/9kQ
        jPppwGSIyb0Dv0ncPd85Rf8cdCRNaMg=
X-Google-Smtp-Source: ANB0VdaVc2TNgHSfsau9xq9tTIDZc+H4rHpL63HuJQlXZSwhevGsNQcJ1pzB7P3l7maQR0Pyodgyew==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr5899992wma.63.1535756584636;
        Fri, 31 Aug 2018 16:03:04 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/20] staging:rtl8192u: Rename Rx_Smooth_Factor - Style
Date:   Sat,  1 Sep 2018 00:02:36 +0100
Message-Id: <20180831230250.16810-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the MACRO Rx_Smooth_Factor to RX_SMOOTH_FACTOR, this clears the
checkpatch issue with CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      |  2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 81a7072a6285..b5ad69af8dac 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -45,7 +45,7 @@
 #define MAX_KEY_LEN     61
 #define KEY_BUF_SIZE    5
 
-#define	Rx_Smooth_Factor		20
+#define	RX_SMOOTH_FACTOR		20
 #define DMESG(x, a...)
 #define DMESGW(x, a...)
 #define DMESGE(x, a...)
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index b3d32ea29fee..dd87cee6604b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3975,13 +3975,13 @@ static void rtl8192_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 					pprevious_stats->RxMIMOSignalStrength[rfpath];
 			if (pprevious_stats->RxMIMOSignalStrength[rfpath]  > priv->stats.rx_rssi_percentage[rfpath]) {
 				priv->stats.rx_rssi_percentage[rfpath] =
-					((priv->stats.rx_rssi_percentage[rfpath] * (Rx_Smooth_Factor - 1)) +
-					 (pprevious_stats->RxMIMOSignalStrength[rfpath])) / (Rx_Smooth_Factor);
+					((priv->stats.rx_rssi_percentage[rfpath] * (RX_SMOOTH_FACTOR - 1)) +
+					 (pprevious_stats->RxMIMOSignalStrength[rfpath])) / (RX_SMOOTH_FACTOR);
 				priv->stats.rx_rssi_percentage[rfpath] = priv->stats.rx_rssi_percentage[rfpath]  + 1;
 			} else {
 				priv->stats.rx_rssi_percentage[rfpath] =
-					((priv->stats.rx_rssi_percentage[rfpath] * (Rx_Smooth_Factor - 1)) +
-					 (pprevious_stats->RxMIMOSignalStrength[rfpath])) / (Rx_Smooth_Factor);
+					((priv->stats.rx_rssi_percentage[rfpath] * (RX_SMOOTH_FACTOR - 1)) +
+					 (pprevious_stats->RxMIMOSignalStrength[rfpath])) / (RX_SMOOTH_FACTOR);
 			}
 			RT_TRACE(COMP_DBG,
 				 "priv->stats.rx_rssi_percentage[rfPath]  = %d\n",
@@ -4026,13 +4026,13 @@ static void rtl8192_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 				pprevious_stats->RxPWDBAll;
 		if (pprevious_stats->RxPWDBAll > (u32)priv->undecorated_smoothed_pwdb) {
 			priv->undecorated_smoothed_pwdb =
-				(((priv->undecorated_smoothed_pwdb) * (Rx_Smooth_Factor - 1)) +
-				 (pprevious_stats->RxPWDBAll)) / (Rx_Smooth_Factor);
+				(((priv->undecorated_smoothed_pwdb) * (RX_SMOOTH_FACTOR - 1)) +
+				 (pprevious_stats->RxPWDBAll)) / (RX_SMOOTH_FACTOR);
 			priv->undecorated_smoothed_pwdb = priv->undecorated_smoothed_pwdb + 1;
 		} else {
 			priv->undecorated_smoothed_pwdb =
-				(((priv->undecorated_smoothed_pwdb) * (Rx_Smooth_Factor - 1)) +
-				 (pprevious_stats->RxPWDBAll)) / (Rx_Smooth_Factor);
+				(((priv->undecorated_smoothed_pwdb) * (RX_SMOOTH_FACTOR - 1)) +
+				 (pprevious_stats->RxPWDBAll)) / (RX_SMOOTH_FACTOR);
 		}
 	}
 
@@ -4075,8 +4075,8 @@ static void rtl8192_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 					if (priv->stats.rx_evm_percentage[nspatial_stream] == 0) /* initialize */
 						priv->stats.rx_evm_percentage[nspatial_stream] = pprevious_stats->RxMIMOSignalQuality[nspatial_stream];
 					priv->stats.rx_evm_percentage[nspatial_stream] =
-						((priv->stats.rx_evm_percentage[nspatial_stream] * (Rx_Smooth_Factor - 1)) +
-						 (pprevious_stats->RxMIMOSignalQuality[nspatial_stream] * 1)) / (Rx_Smooth_Factor);
+						((priv->stats.rx_evm_percentage[nspatial_stream] * (RX_SMOOTH_FACTOR - 1)) +
+						 (pprevious_stats->RxMIMOSignalQuality[nspatial_stream] * 1)) / (RX_SMOOTH_FACTOR);
 				}
 			}
 		}
-- 
2.18.0

