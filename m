Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E7C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F9921946
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHjbbQdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F9921946
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHGX3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40267 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHGX3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so516155wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+r6TumydzP1CsX9kVO/Rx+ic7xyiZJcfQJG0Wpl8Bkc=;
        b=iHjbbQdzj4pbcdaaWC15zMw+KuWhts5zZN6CTPHxVYlmd5re0i0lw6yhbuor1Z9MWX
         spjf942F9u+/uNO5ijDYI71XlKDqd6mMaTeCAZ6rCAerQfyO0QbTdBiP+zWQ4qY9hYsw
         nPjG/6e6h+XMTjUZ0bafIVOPKoXXgsfSWIVyV+AlndsNi4Kqx/9HFmW8vMsOpnw52GGi
         7I1Tk1jcwBpwNzNEjOlI5gcFYVLhd98Y6KI30MNPYtzil1Qm60ef+TMKSXbt2+383vPf
         rtt4YfUE+LSZYG45OmJh10OkTMGwTxz3nSUUO6d0egpCH6jcnnXNchoa6to/VaoZc3Ue
         0d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+r6TumydzP1CsX9kVO/Rx+ic7xyiZJcfQJG0Wpl8Bkc=;
        b=dJ0G/K6/o9IDyBhSs1oI0HeQ18+L3CuTfqxCoo3HaohsMoq/mckV1AWtf6OX4JQjak
         J1cwQTb+2OXPfMFax/EBg/g6ZCrSEpJNYg2o34aJrLG7u6i0BfCgCciSyVhsULf5C6RJ
         ma1dP07COWHlpv03CoXuaX4kEqQnDRJ5devq6Wp8rMgJiTdFAjnPOnvyTg/McGeDmYid
         F12Eu4d7RAmIHbmydpXTEU+eCpWg0rf0bzlggGyL4OedhzqYjwk+7tzvp2aoMlgFzV8r
         HwA4mi2+Glw7UfvC4XiD84F3mj9m94m+3tSnAtYMleJmVzrPdnpJ+Lyn+iqzOoMLm01J
         7j2g==
X-Gm-Message-State: AOUpUlFOazF56aHoKBd16A2nnCVgeVIi/Vw2OdTJlgdXrP4NDKC3Cmr2
        wHHNIsAzhWWflnGO0y5TNWkQUR9E
X-Google-Smtp-Source: AA+uWPyc11hLzDx97IwuRomYnUgU/TyBft2g16fvf99GFLvy/hFbx5J51KxE3rEB6yIqzHwB/6E28g==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr31110wmd.135.1533676393617;
        Tue, 07 Aug 2018 14:13:13 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:12 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/17] staging:rtl8192u: Rename Dot11d_Init - Style
Date:   Tue,  7 Aug 2018 22:12:47 +0100
Message-Id: <20180807211255.29343-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function Dot11d_Init() causes a checkpatch issue due to its use
of CamelCase naming. The function has been renamed to dot11d_init.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 2fb575a2b6ab..aef16794af76 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -3,7 +3,7 @@
 
 #include "dot11d.h"
 
-void Dot11d_Init(struct ieee80211_device *ieee)
+void dot11d_init(struct ieee80211_device *ieee)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 
@@ -15,9 +15,9 @@ void Dot11d_Init(struct ieee80211_device *ieee)
 	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	RESET_CIE_WATCHDOG(ieee);
 
-	netdev_info(ieee->dev, "Dot11d_Init()\n");
+	netdev_info(ieee->dev, "dot11d_init()\n");
 }
-EXPORT_SYMBOL(Dot11d_Init);
+EXPORT_SYMBOL(dot11d_init);
 
 /* Reset to the state as we are just entering a regulatory domain. */
 void Dot11d_Reset(struct ieee80211_device *ieee)
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index cb6d6ce440be..891cfd49abb9 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -49,7 +49,7 @@ struct rt_dot11d_info {
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
-void Dot11d_Init(struct ieee80211_device *dev);
+void dot11d_init(struct ieee80211_device *dev);
 void Dot11d_Reset(struct ieee80211_device *dev);
 void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
 			    u8 *pTaddr,
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index b7b4694c1f27..f7b69fbbe5f3 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -183,7 +183,7 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 	case COUNTRY_CODE_ISRAEL:
 	case COUNTRY_CODE_TELEC:
 	case COUNTRY_CODE_MIC:
-		Dot11d_Init(ieee);
+		dot11d_init(ieee);
 		ieee->bGlobalDomain = false;
 		/* actually 8225 & 8256 rf chips only support B,G,24N mode */
 		if ((priv->rf_chip == RF_8225) || (priv->rf_chip == RF_8256)) {
-- 
2.18.0

