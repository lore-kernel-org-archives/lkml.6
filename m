Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFCC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CE521AA7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYQNybGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CE521AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeHHXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40866 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbeHHXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so1890528edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y23NJb71pEMtUiUbIT6xBfJ7i9YzkGdQKvUf7Qqa1ys=;
        b=TYQNybGxuHRXFZAV3hM1CUoWIkHNQfkvedHEmNgDWjNOh4CmaOejqZn9tILzXS4csj
         v8u1JWMtqr6WD/c7Av6do+UNotfetLSuWe+hKkfHeJ7dysOpva1PTF2e2umWXQaM6sQH
         xurDonnyOaTFJZazFHkk4aITDRKl1xs6SJ5IxtFBpVBFILjejgEh7B/s71WuH7b5I05q
         TNJdW87KlkqoQyL7LBiwTPBUB/789o1D6Wa5KmtlWJeluuYGJjJ0pZuZE8fGharyFuVj
         jpKgU9o0gr7AqO9E6gY+R9iyzISFlc2vX597IUZk7cjj0zptqrhvP9NfXsdZXh674ohA
         DEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y23NJb71pEMtUiUbIT6xBfJ7i9YzkGdQKvUf7Qqa1ys=;
        b=F83h+FtQRcBRuIWebu/9upHCBZyoNOUJfVF0G80VlK2P4KwDDGDjKIdNCHAUHbu51o
         Uq+JDRYGysBFEaH31dVAUfHBqk9MiWJzVqkueSOpiqunttLKiPpmkxR33dxzGtwYpubw
         OO2K9CwKRCWVFeE8cf9svJ1KS70zqzORkb54q6kLEkimQEJt5ZHAiQdavi8vwLUblsQG
         I8MQQWJvSY+KZrz3wqNetmq7qq7u6MaNNGSi53l7tEvKdB9mtEh//AS8nUcbN8oZNRv0
         zId+VxF9KQoFTrYA7HpxhfhLTwWIpctxqSu4LmNPuVX4zh88yPp+xWQ2Kas0f0upz0yP
         q2EA==
X-Gm-Message-State: AOUpUlGZu6EqLcAQRIQZC3end19+snSspXts3hJlvQ58L9xHpREofuCI
        nP6nYf9dplBhcRIkHjBd5yLmNLvoYjE=
X-Google-Smtp-Source: AA+uWPymiOpI8aRkenCcmrXIJfeuDQMwhUUGJMHrKpJGmD0sBT9XJQusrBQHHB45XlCScJPD3NTxgg==
X-Received: by 2002:a50:84e9:: with SMTP id 96-v6mr4908495edq.118.1533762067066;
        Wed, 08 Aug 2018 14:01:07 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 08/15] staging:rtl8192u: Rename Dot11d_Reset - Style
Date:   Wed,  8 Aug 2018 22:00:29 +0100
Message-Id: <20180808210036.22580-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function Dot11d_Reset causes a checkpatch issue due to its use of
CamelCase naming, so has been renamed to dot11d_reset.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c            | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h            | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c                 | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index aef16794af76..d6baeec91669 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -20,7 +20,7 @@ void dot11d_init(struct ieee80211_device *ieee)
 EXPORT_SYMBOL(dot11d_init);
 
 /* Reset to the state as we are just entering a regulatory domain. */
-void Dot11d_Reset(struct ieee80211_device *ieee)
+void dot11d_reset(struct ieee80211_device *ieee)
 {
 	u32 i;
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
@@ -38,7 +38,7 @@ void Dot11d_Reset(struct ieee80211_device *ieee)
 	pDot11dInfo->country_ie_len = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
-EXPORT_SYMBOL(Dot11d_Reset);
+EXPORT_SYMBOL(dot11d_reset);
 
 /*
  * Update country IE from Beacon or Probe Resopnse and configure PHY for
@@ -127,7 +127,7 @@ void DOT11D_ScanComplete(struct ieee80211_device *dev)
 	case DOT11D_STATE_DONE:
 		if (GET_CIE_WATCHDOG(dev) == 0) {
 			/* Reset country IE if previous one is gone. */
-			Dot11d_Reset(dev);
+			dot11d_reset(dev);
 		}
 		break;
 	case DOT11D_STATE_NONE:
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 8e65e54a372c..73cf2e6aeb06 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -44,7 +44,7 @@ struct rt_dot11d_info {
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
 void dot11d_init(struct ieee80211_device *dev);
-void Dot11d_Reset(struct ieee80211_device *dev);
+void dot11d_reset(struct ieee80211_device *dev);
 void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
 			    u8 *pTaddr,
 			    u16 CoutryIeLen,
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 212cc9ccbb96..39ed743a1a56 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2357,7 +2357,7 @@ void ieee80211_disassociate(struct ieee80211_device *ieee)
 	if (ieee->data_hard_stop)
 		ieee->data_hard_stop(ieee->dev);
 	if (IS_DOT11D_ENABLE(ieee))
-		Dot11d_Reset(ieee);
+		dot11d_reset(ieee);
 	ieee->state = IEEE80211_NOLINK;
 	ieee->is_set_key = false;
 	ieee->link_change(ieee->dev);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index c77f35102fd4..da4b376d6122 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -212,7 +212,7 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 		 * otherwise, it shall follow global domain settings.
 		 */
 		GET_DOT11D_INFO(ieee)->enabled = 0;
-		Dot11d_Reset(ieee);
+		dot11d_reset(ieee);
 		ieee->bGlobalDomain = true;
 		break;
 
-- 
2.18.0

