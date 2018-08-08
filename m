Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5896BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F279921A84
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF3xcwP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F279921A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbeHHXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so1893193edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BwHakbWRGz6oUFwhpe26Uf+Xa0Lb2eFmsaUc9LNyQc=;
        b=aF3xcwP+G+EORhBKHm2+LgCe4NUv2pv/Pu3oyqtEo/KMAoZC0Jb+Jr78D3I/cmUEDg
         GyNCjly7oWawNWj+NZuYuHikRcB+KoZZg855jI/orGLiXif0lKEfALSbk33I6XsiGlu3
         a0DgIaoVyKt9H/NpAvD628x84VI/tf/L9BF8Env0F5M0Tsgcj5EqOhCtTVsNB5V1WqeP
         j+DnGIFaqB4ZPzG+vJ/R1pG96UDJr8Vi2AX37uNA/N+pECMe/0PB0LQH5pcmut6mfNJt
         on5Vg9M3P/kBMCoe0gIMDhR82XkzFhFHqEwY23b71ev61M+keZoiFoOaXJlhbc4hQaLw
         ZKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BwHakbWRGz6oUFwhpe26Uf+Xa0Lb2eFmsaUc9LNyQc=;
        b=uO4Y3421uOfG4Yi3VnIqvfUbG6mBt0Um+ckT3PsYgEj3YPofcsz/08CXt4FzbjgFh6
         utkqTBmIzVHY99MDtoL6IePJISVjp2E3T9XQHrxM15GaGlZNLBStNOfeaAmBoudLbspg
         1VakWZgrr6idVb0AhgbIHBwTODM/WSU6636SoQTfRNsndOq2sz2SC5a3Rdup5exGm3Dm
         8PXNuW3KmAxCRemToAc1tTItRX4M8gY1tuOCXhF066x34Ao9R+CtShes9/sjrY+oBnN6
         2xRV6yijehu/K4XG2cVfsIONZb9Aw77ApCAma148Vo8laGiggnzF0LeHlfC7YtL3k1Cv
         cCZA==
X-Gm-Message-State: AOUpUlGBhrdrVDu5z+NgEv09YkESNozMiR51p785HO+hrNmoFC5Ztnuq
        +CoHqyL2zfTQuhBSKqIhBhUNbjtP6ts=
X-Google-Smtp-Source: AA+uWPwB97ZXJqK2Rldug0FHQJgWZ9E9984KbvEVePJL5fubnx/Ll+Ni7OShw6iyrAoE1AZgdTh8XA==
X-Received: by 2002:aa7:c24d:: with SMTP id y13-v6mr5059639edo.266.1533762065670;
        Wed, 08 Aug 2018 14:01:05 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 07/15] staging:rtl8192u: Rename Dot11d_Init - Style
Date:   Wed,  8 Aug 2018 22:00:28 +0100
Message-Id: <20180808210036.22580-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
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
index 0856d5ea7991..8e65e54a372c 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -43,7 +43,7 @@ struct rt_dot11d_info {
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
-void Dot11d_Init(struct ieee80211_device *dev);
+void dot11d_init(struct ieee80211_device *dev);
 void Dot11d_Reset(struct ieee80211_device *dev);
 void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
 			    u8 *pTaddr,
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index b2be09fcd43b..c77f35102fd4 100644
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

