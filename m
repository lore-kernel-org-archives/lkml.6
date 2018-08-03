Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404ABC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE5C21708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiRNuPqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE5C21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeHCB4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41186 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so1558975edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J6f2GHlcM/fSN5vSjX3QUZN5McRMOOr8YvEck1oNmk4=;
        b=OiRNuPqCEdGpF3Y1VHK7kZ+YrsfSZy4cQXGU/Z+HtQXAKZINx3vwHd2q4KYGaw+Vcx
         sqnALBisVSwoCJB4chbr3WDczUT3iKPi/Cz5nFWuLDUFljMQ/NO6BOwqT++UoV7l+WYs
         H2CqBY+xHZDVgY67C4ATs0VuhP2SQZHWthd39GSteyWWZsUVeiaSQ1Xbqlgi8W+Bk4TB
         dwm0zQOuUg0fllIfTPyNSPPbzlTb29zoy+17NfVCQw/k/mgD/Zc1UicdwGrcno36QJkM
         kznD0z2opdJa3OW/5MuwSqWWMtCbKBOXwRvfFu7SR4Fr9oOigPKg06eEOe4F7JXoLe+I
         wVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J6f2GHlcM/fSN5vSjX3QUZN5McRMOOr8YvEck1oNmk4=;
        b=NlOJJ1OLDA8GNTt7AYWuwTRE0LhW1TQltW9A0g/40FIXctmlinzOCHIzJq6Ge2EQxW
         ovaNFEGbjorFiIUPUelST1pVv49Vek+aN6B0Z2EFIZRwoihqRWIfne3/dT4Ni9sJ0ejq
         3rDESLvUmiK9U7gnsz6F74q9ZGyRP4odz8dUn29m5tBkO5AE/Y5U6tUkjUNhd35ZEWuz
         88ypN01iYd7xrg/oEKlzWR6I/r6ImeDbCsjtBn2QjdUkKbHO6IIO7AO/uNqizzzmzbuk
         ZZPyeDE3Fz4nKBgQqCXbOI5QcSJXiqs05v/4Zno/gtZjMg1NsVj78QEvSPFytr41J7pi
         0tbg==
X-Gm-Message-State: AOUpUlGA+40TYLt3ZiYY/QBICDhaTl2cc/1Scd7y2WvACQJvOp+Zby3Y
        rM/dBcKkdAauXOgEJcP3pDS4+t7U
X-Google-Smtp-Source: AAOMgpdUlII/N+s/Wv/7m14LXh/u7P2Y0Tm8PgUfD9wbv8A1FsaU1PcNdsmQlKP1KrbFMWZRF0qxCA==
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr5298878edz.79.1533254583438;
        Thu, 02 Aug 2018 17:03:03 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:03:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/18] staging:rtl8192u: Rename constants - Style
Date:   Fri,  3 Aug 2018 01:02:09 +0100
Message-Id: <20180803000211.10589-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants 'VeryLowRSSI' and 'CTSToSelfTHVal' generate warnings from
checkpatch due to the use of CamelCase naming. The two constants have
been renamed to 'VERY_LOW_RSSI' and 'CTS_TO_SELF_TH_VAL' respectively.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_dm.c   | 2 +-
 drivers/staging/rtl8192u/r8192U_dm.h   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 6129ac55656f..e218b5c20642 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3090,7 +3090,7 @@ static bool HalRxCheckStuck819xUsb(struct net_device *dev)
 		rx_chk_cnt = 0;
 	} else if (((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_40M) ||
 		    (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_20M)) &&
-		     priv->undecorated_smoothed_pwdb >= VeryLowRSSI) {
+		     priv->undecorated_smoothed_pwdb >= VERY_LOW_RSSI) {
 		if (rx_chk_cnt < 4)
 			return bStuck;
 
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 21107a00776f..0e4f55c6493f 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2268,7 +2268,7 @@ static void dm_init_ctstoself(struct net_device *dev)
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	priv->ieee80211->bCTSToSelfEnable = true;
-	priv->ieee80211->CTSToSelfTH = CTSToSelfTHVal;
+	priv->ieee80211->CTSToSelfTH = CTS_TO_SELF_TH_VAL;
 }
 
 static void dm_ctstoself(struct net_device *dev)
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index a1378488423b..30241d91e44a 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -43,8 +43,8 @@
 #define		RATE_ADAPTIVE_TH_HIGH			50
 #define		RATE_ADAPTIVE_TH_LOW_20M		30
 #define		RATE_ADAPTIVE_TH_LOW_40M		10
-#define		VeryLowRSSI					15
-#define		CTSToSelfTHVal					30
+#define		VERY_LOW_RSSI					15
+#define		CTS_TO_SELF_TH_VAL					30
 
 /* defined by vivi, for tx power track */
 #define		E_FOR_TX_POWER_TRACK               300
-- 
2.18.0

