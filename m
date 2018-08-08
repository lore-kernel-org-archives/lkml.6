Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62521A9A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIhvJ8rU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF62521A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbeHHXWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41249 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so1886270edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ArH99AlqcIXpsbW71iOMRkzPZaIKitSbTC3VTX0sHk=;
        b=PIhvJ8rU8mpqrSEFEtAUTlCDYS68uqsDb+ZVe630dFcRNQoVKPfRy0MsMuXu1wsq8G
         YztTcA0/BupzDWtBm2G63G8dtDhc2P8iBP6NnoVZ5YgyOzcUaF21ZPXoRUpaDkU815IH
         veGEOag23p3UXyW1VZ2MsTHF5JljrSMgf8llKEgADCXJfMdmWtsSBjuQ2fO0lDY3fuzP
         BAH9LbbaO7/2XEm0zi/RcmxpiopwVor5udRXeFCZtaCNNdbBHqeE0q9Ae1ghciha18/G
         wUcWoqwe8b/UnZ8p1x5xtv6jCUznWDeSWqS+YQEQaBR2Zfbgz3usWI60MxdkzaSndnUi
         8XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ArH99AlqcIXpsbW71iOMRkzPZaIKitSbTC3VTX0sHk=;
        b=TS8bJBuJoN+prXhIEPiAW0rG3uuH8eKg0jd5Q7aTOwAIseVAvmFuTrh+3AoPVABaP7
         BwflxnKgZU9q11ZaxOA0WLSOroOph59DjXMZSOUFiov/rBwQV6zQyZls4Kd2GcXbjLFD
         t2JCR41B/PXefqLbZEw+goyr8iPxCrpTHLL09srT0c4wXt4FXlt0jqTboon8K5q87QoV
         i8DqjUGRLjX7+hvb1doYB97eqdvpTBPY9ILtk2XsUvE4dS9M5IQlaJavB4fz250lEq8n
         JY4A+caapFpYUsk3VPtAR6SWv6jjJtngkn2i86hyfko1a2ESSWusbCjacyWDAoJbU1rI
         upGA==
X-Gm-Message-State: AOUpUlEbToD9xxm2bO/TguaBHnoP+ujVYX1spR1S3JsroTE+Ma+QE9xx
        GKqUFKcav0Nnxk/8mZHAYNWSE9xNeEM=
X-Google-Smtp-Source: AA+uWPzC2iGYJ6NuiboK8t5P5gp+SAecSKuB8vMnhlkn8CcREG+Bk2enJi/jrI+Q3JU2pIyZjdfBMg==
X-Received: by 2002:aa7:c44d:: with SMTP id n13-v6mr4889425edr.222.1533762075405;
        Wed, 08 Aug 2018 14:01:15 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 14/15] staging:rtl8192u: Rename IsLegalChannel - Style
Date:   Wed,  8 Aug 2018 22:00:35 +0100
Message-Id: <20180808210036.22580-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function IsLegalChannel causes a checkpatch issue due to its use
of CamelCase naming. The function has been renamed to is_legal_channel.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c       | 8 ++++----
 drivers/staging/rtl8192u/ieee80211/dot11d.h       | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.c             | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index 48911c68b7a4..a116858d151c 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -136,19 +136,19 @@ void dot11d_scan_complete(struct ieee80211_device *dev)
 }
 EXPORT_SYMBOL(dot11d_scan_complete);
 
-int IsLegalChannel(struct ieee80211_device *dev, u8 channel)
+int is_legal_channel(struct ieee80211_device *dev, u8 channel)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 
 	if (channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "IsLegalChannel(): Invalid Channel\n");
+		netdev_err(dev->dev, "is_legal_channel(): Invalid Channel\n");
 		return 0;
 	}
 	if (pDot11dInfo->channel_map[channel] > 0)
 		return 1;
 	return 0;
 }
-EXPORT_SYMBOL(IsLegalChannel);
+EXPORT_SYMBOL(is_legal_channel);
 
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
 {
@@ -164,7 +164,7 @@ int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
 	}
 
 	if (channel > MAX_CHANNEL_NUMBER) {
-		netdev_err(dev->dev, "IsLegalChannel(): Invalid Channel\n");
+		netdev_err(dev->dev, "is_legal_channel(): Invalid Channel\n");
 		return default_chn;
 	}
 
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 00e59e949f82..37c493789608 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -51,7 +51,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *coutry_ie);
 u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void dot11d_scan_complete(struct ieee80211_device *dev);
-int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
+int is_legal_channel(struct ieee80211_device *dev, u8 channel);
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
 
 #endif /* #ifndef __INC_DOT11D_H */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 787aefa4656e..e1897bd4bdc9 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -2439,7 +2439,7 @@ static inline void ieee80211_process_probe_response(
 	//       then wireless adapter should do active scan from ch1~11 and
 	//       passive scan from ch12~14
 
-	if (!IsLegalChannel(ieee, network->channel))
+	if (!is_legal_channel(ieee, network->channel))
 		goto out;
 	if (ieee->bGlobalDomain)
 	{
@@ -2448,7 +2448,7 @@ static inline void ieee80211_process_probe_response(
 			// Case 1: Country code
 			if(IS_COUNTRY_IE_VALID(ieee) )
 			{
-				if (!IsLegalChannel(ieee, network->channel)) {
+				if (!is_legal_channel(ieee, network->channel)) {
 					printk("GetScanInfo(): For Country code, filter probe response at channel(%d).\n", network->channel);
 					goto out;
 				}
@@ -2469,7 +2469,7 @@ static inline void ieee80211_process_probe_response(
 			// Case 1: Country code
 			if(IS_COUNTRY_IE_VALID(ieee) )
 			{
-				if (!IsLegalChannel(ieee, network->channel)) {
+				if (!is_legal_channel(ieee, network->channel)) {
 					printk("GetScanInfo(): For Country code, filter beacon at channel(%d).\n",network->channel);
 					goto out;
 				}
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 7ee10d49894b..0a13a1f8a14d 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1271,7 +1271,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 
 	RT_TRACE(COMP_CH, "%s() stage: %d, step: %d, channel: %d\n",
 		 __func__, *stage, *step, channel);
-	if (!IsLegalChannel(priv->ieee80211, channel)) {
+	if (!is_legal_channel(priv->ieee80211, channel)) {
 		RT_TRACE(COMP_ERR, "set to illegal channel: %d\n", channel);
 		/* return true to tell upper caller function this channel
 		 * setting is finished! Or it will in while loop.
-- 
2.18.0

