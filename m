Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8007C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C612087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC8qg+7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C612087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeH1Ws4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:48:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45519 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeH1Wsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:48:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id p52-v6so2126552eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CN9a7LVobPNYp8VpFyZuYSThXaSAY8q8JXG9+4MCSpI=;
        b=kC8qg+7rqsUJiBtwhSXaqSIniwuLoBKGExmNgZry7BIabcFOs0fMczE83is2o6IJLr
         o7SuhiSunJ1KMADSoPTclee+9h14nj14I2gG8SQxnvrUvIZbkrkkkUlKC0Fc3LrrBykj
         gfld8jYh6qnUWUZQnGrKPirTY68/KR27VYCOXtOoyivQm5I29iusT3obXOyU7q3KD7R8
         bR8wQmM2Ec81rpGtT5Wy0IiaTRGzeJDmKZLnWvbtfaieOwYHvO1CD/nLIlv1N0/dSVWV
         j5Hw6dO13ZvNcqcrxOw+QVLlsf5o5k5IKAMinZwo+tpcSR6e9/W9OhJrpmXvnjkiOL/Y
         6czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CN9a7LVobPNYp8VpFyZuYSThXaSAY8q8JXG9+4MCSpI=;
        b=K6HLTV+FdtDV1supWeNifpVTvq+QnFNkPzyDI1IjCUcVtthgHp/e7QkhB7/BQ5QtQe
         CKZHx+PD3wkDAhdYMh6TpKMQQCIRZXX9wa4n2EyVO6vR63AcRRTE0mtG7V5Vm6JBcc3U
         r6aEOtIDzpBJ3qj5SFlSkxIsvWdvo3pAYGOVOfjtTQ4vqkbkxvadqGCX39zB33jAM7he
         eOfiGpZJHsynX2ktBclLW6LWWDLhkGx3ORAj7JYA4wcm85OlMUPYcYFS6teWlBsKX14T
         H5VwWkqNJ5WYQ7FBkI8W73ha8t0F9gW4YqrLcja3FAPijh+Xh3egJnYrBJ7jJupMG9Wm
         B9Kw==
X-Gm-Message-State: APzg51DaE3j9ppMHCg+p3dfMnVRCtg1IPlEcu8Raj8kKj+K9fP03p8/t
        qPGVb9UsyOo0sJeMm3q1McTn522g
X-Google-Smtp-Source: ANB0VdaG7D6pMxkZw/hKP3Jj/lkeBkh9CRxL/FUFFrwH0JtKpdefxjQ/i1G3QMyKuc7ipm6nVQcY6Q==
X-Received: by 2002:a50:c201:: with SMTP id n1-v6mr3973700edf.11.1535482554532;
        Tue, 28 Aug 2018 11:55:54 -0700 (PDT)
Received: from localhost.localdomain ([109.79.175.209])
        by smtp.gmail.com with ESMTPSA id o24-v6sm742975edr.64.2018.08.28.11.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:55:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 4/4] staging:rtl8192u: Rename member pDot11dInfo - Style
Date:   Tue, 28 Aug 2018 19:55:35 +0100
Message-Id: <20180828185535.28808-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828185535.28808-1-johnfwhitmore@gmail.com>
References: <20180828185535.28808-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'pDot11dInfo', this member variable of the structure
ieee80211_device causes a checkpatch issue, CamelCase naming. The
member has been renamed 'dot11d_info' to clear this issue.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 66 +++++++++----------
 drivers/staging/rtl8192u/ieee80211/dot11d.h   |  2 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  8 +--
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index f3aa60cb3227..e152528c9409 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -5,14 +5,14 @@
 
 void dot11d_init(struct ieee80211_device *ieee)
 {
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
 
-	pDot11dInfo->dot11d_enabled = false;
+	dot11d_info->dot11d_enabled = false;
 
-	pDot11dInfo->state = DOT11D_STATE_NONE;
-	pDot11dInfo->country_ie_len = 0;
-	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
+	dot11d_info->state = DOT11D_STATE_NONE;
+	dot11d_info->country_ie_len = 0;
+	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
+	memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	RESET_CIE_WATCHDOG(ieee);
 
 	netdev_info(ieee->dev, "dot11d_init()\n");
@@ -23,19 +23,19 @@ EXPORT_SYMBOL(dot11d_init);
 void dot11d_reset(struct ieee80211_device *ieee)
 {
 	u32 i;
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
 	/* Clear old channel map */
-	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER+1);
-	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
+	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER+1);
+	memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	/* Set new channel map */
 	for (i = 1; i <= 11; i++)
-		(pDot11dInfo->channel_map)[i] = 1;
+		(dot11d_info->channel_map)[i] = 1;
 
 	for (i = 12; i <= 14; i++)
-		(pDot11dInfo->channel_map)[i] = 2;
+		(dot11d_info->channel_map)[i] = 2;
 
-	pDot11dInfo->state = DOT11D_STATE_NONE;
-	pDot11dInfo->country_ie_len = 0;
+	dot11d_info->state = DOT11D_STATE_NONE;
+	dot11d_info->country_ie_len = 0;
 	RESET_CIE_WATCHDOG(ieee);
 }
 EXPORT_SYMBOL(dot11d_reset);
@@ -52,12 +52,12 @@ EXPORT_SYMBOL(dot11d_reset);
 void dot11d_update_country_ie(struct ieee80211_device *dev, u8 *pTaddr,
 			    u16 CoutryIeLen, u8 *pCoutryIe)
 {
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
 	u8 i, j, NumTriples, MaxChnlNum;
 	struct chnl_txpower_triple *pTriple;
 
-	memset(pDot11dInfo->channel_map, 0, MAX_CHANNEL_NUMBER+1);
-	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
+	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER+1);
+	memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	MaxChnlNum = 0;
 	NumTriples = (CoutryIeLen - 3) / 3; /* skip 3-byte country string. */
 	pTriple = (struct chnl_txpower_triple *)(pCoutryIe + 3);
@@ -78,8 +78,8 @@ void dot11d_update_country_ie(struct ieee80211_device *dev, u8 *pTaddr,
 		}
 
 		for (j = 0; j < pTriple->num_channels; j++) {
-			pDot11dInfo->channel_map[pTriple->first_channel + j] = 1;
-			pDot11dInfo->max_tx_pwr_dbm_list[pTriple->first_channel + j] = pTriple->max_tx_pwr_dbm;
+			dot11d_info->channel_map[pTriple->first_channel + j] = 1;
+			dot11d_info->max_tx_pwr_dbm_list[pTriple->first_channel + j] = pTriple->max_tx_pwr_dbm;
 			MaxChnlNum = pTriple->first_channel + j;
 		}
 
@@ -87,29 +87,29 @@ void dot11d_update_country_ie(struct ieee80211_device *dev, u8 *pTaddr,
 	}
 	netdev_info(dev->dev, "Channel List:");
 	for (i = 1; i <= MAX_CHANNEL_NUMBER; i++)
-		if (pDot11dInfo->channel_map[i] > 0)
+		if (dot11d_info->channel_map[i] > 0)
 			netdev_info(dev->dev, " %d", i);
 	netdev_info(dev->dev, "\n");
 
 	UPDATE_CIE_SRC(dev, pTaddr);
 
-	pDot11dInfo->country_ie_len = CoutryIeLen;
-	memcpy(pDot11dInfo->country_ie_buf, pCoutryIe, CoutryIeLen);
-	pDot11dInfo->state = DOT11D_STATE_LEARNED;
+	dot11d_info->country_ie_len = CoutryIeLen;
+	memcpy(dot11d_info->country_ie_buf, pCoutryIe, CoutryIeLen);
+	dot11d_info->state = DOT11D_STATE_LEARNED;
 }
 EXPORT_SYMBOL(dot11d_update_country_ie);
 
 u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel)
 {
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
 	u8 MaxTxPwrInDbm = 255;
 
 	if (Channel > MAX_CHANNEL_NUMBER) {
 		netdev_err(dev->dev, "dot11d_get_max_tx_pwr_in_dbm(): Invalid Channel\n");
 		return MaxTxPwrInDbm;
 	}
-	if (pDot11dInfo->channel_map[Channel])
-		MaxTxPwrInDbm = pDot11dInfo->max_tx_pwr_dbm_list[Channel];
+	if (dot11d_info->channel_map[Channel])
+		MaxTxPwrInDbm = dot11d_info->max_tx_pwr_dbm_list[Channel];
 
 	return MaxTxPwrInDbm;
 }
@@ -117,11 +117,11 @@ EXPORT_SYMBOL(dot11d_get_max_tx_pwr_in_dbm);
 
 void dot11d_scan_complete(struct ieee80211_device *dev)
 {
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
 
-	switch (pDot11dInfo->state) {
+	switch (dot11d_info->state) {
 	case DOT11D_STATE_LEARNED:
-		pDot11dInfo->state = DOT11D_STATE_DONE;
+		dot11d_info->state = DOT11D_STATE_DONE;
 		break;
 
 	case DOT11D_STATE_DONE:
@@ -138,13 +138,13 @@ EXPORT_SYMBOL(dot11d_scan_complete);
 
 int is_legal_channel(struct ieee80211_device *dev, u8 channel)
 {
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
 
 	if (channel > MAX_CHANNEL_NUMBER) {
 		netdev_err(dev->dev, "is_legal_channel(): Invalid Channel\n");
 		return 0;
 	}
-	if (pDot11dInfo->channel_map[channel] > 0)
+	if (dot11d_info->channel_map[channel] > 0)
 		return 1;
 	return 0;
 }
@@ -152,12 +152,12 @@ EXPORT_SYMBOL(is_legal_channel);
 
 int to_legal_channel(struct ieee80211_device *dev, u8 channel)
 {
-	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
+	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
 	u8 default_chn = 0;
 	u32 i = 0;
 
 	for (i = 1; i <= MAX_CHANNEL_NUMBER; i++) {
-		if (pDot11dInfo->channel_map[i] > 0) {
+		if (dot11d_info->channel_map[i] > 0) {
 			default_chn = i;
 			break;
 		}
@@ -168,7 +168,7 @@ int to_legal_channel(struct ieee80211_device *dev, u8 channel)
 		return default_chn;
 	}
 
-	if (pDot11dInfo->channel_map[channel] > 0)
+	if (dot11d_info->channel_map[channel] > 0)
 		return channel;
 
 	return default_chn;
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index df37678b806d..414b74abfb74 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -31,7 +31,7 @@ struct rt_dot11d_info {
 	u8  dot11d_enabled; /* dot11MultiDomainCapabilityEnabled */
 };
 
-#define GET_DOT11D_INFO(ieee_dev) ((struct rt_dot11d_info *)((ieee_dev)->pDot11dInfo))
+#define GET_DOT11D_INFO(ieee_dev) ((struct rt_dot11d_info *)((ieee_dev)->dot11d_info))
 
 #define IS_DOT11D_ENABLE(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->dot11d_enabled)
 #define IS_COUNTRY_IE_VALID(ieee_dev) (GET_DOT11D_INFO(ieee_dev)->country_ie_len > 0)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index e2e503d24c4c..b4e7ae60ac1c 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1772,7 +1772,7 @@ struct ieee80211_device {
 
 	/* map of allowed channels. 0 is dummy */
 	// FIXME: remember to default to a basic channel plan depending of the PHY type
-	void *pDot11dInfo;
+	void *dot11d_info;
 	bool bGlobalDomain;
 	int rate;       /* current rate */
 	int basic_rate;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index a20c79401dab..8635faf84316 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2542,8 +2542,8 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	for (i = 0; i < 5; i++)
 		ieee->seq_ctrl[i] = 0;
 
-	ieee->pDot11dInfo = kzalloc(sizeof(struct rt_dot11d_info), GFP_KERNEL);
-	if (!ieee->pDot11dInfo)
+	ieee->dot11d_info = kzalloc(sizeof(struct rt_dot11d_info), GFP_KERNEL);
+	if (!ieee->dot11d_info)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
 	//added for  AP roaming
 	ieee->LinkDetectInfo.SlotNum = 2;
@@ -2603,8 +2603,8 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 void ieee80211_softmac_free(struct ieee80211_device *ieee)
 {
 	mutex_lock(&ieee->wx_mutex);
-	kfree(ieee->pDot11dInfo);
-	ieee->pDot11dInfo = NULL;
+	kfree(ieee->dot11d_info);
+	ieee->dot11d_info = NULL;
 	del_timer_sync(&ieee->associate_timer);
 
 	cancel_delayed_work(&ieee->associate_retry_wq);
-- 
2.18.0

