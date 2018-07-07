Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A3C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963C820862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNf6hpvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963C820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeGGO5E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:57:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38540 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbeGGOzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j33-v6so6723332wrj.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=orbzD27OVjS3M48AHD0uE0GOHX4PUJbUg2u5CuyzJwI=;
        b=oNf6hpvRrAdzX31u8Yvjk7UJdqfjw6meK3tcyjOZyjSZQNHskw4LVjbi2cCd0aQUhn
         lohiKHV2c3LtDJ3QVUtuNiNpr/kdwy8TAEOT1ErPJ72cimVNG/7YkPGCCzlkNIxFMyIE
         uedbuEwE6bOVuRL63oET05OefOfTQh8DoOZ58UC4B1XRXRl1cZtnx3u3pG9Y1zHNPAI4
         NVvIw056KmgxViLTC7MuqBeDHnK3aDk+Eu3skjO277STuaFHUxbWgMg+AQL+exRDYApB
         c10eB1xf6dQXJOm7bVw+xBPrCnLFH4/nEMksVavIOvQNvCss7i6tOkvH81DjIcIY3Ua4
         xifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=orbzD27OVjS3M48AHD0uE0GOHX4PUJbUg2u5CuyzJwI=;
        b=t5ngKj3otUBBxW7iEU44cORSKY35UsxeqUfptk6BjD87HOuyIMPPhn7sm0QIYjU75G
         rtvTW3RQMmx0+mw8h4JTF1G5P9NDXIf7nkJwCXOUXFicMx8n2Wwwg5frjIHmlhCL3OqT
         2qdkVE+a3r46uL2nKinO06MjNf6YYud10nSzgxJYRdCzFpKJRgRBP/9aY/35pQ+z3ff9
         S2j7uwn5PYbat2GfIOvUs/EcUxqT+mF0DD0GpW5oogrjzR8jjGj+HeIKScbd338kBCJ8
         DdJnHC6EzlHqBHH/bRa9rKjUyE/0YsatOfd8TRtzLy9W8DOqJsCDmcWDC3hhI1XmAk/L
         HrZw==
X-Gm-Message-State: APt69E1rEoB4aqTCxKpUUOiJhwwfgITT/PGf88/APpuSzP914ecNFFN1
        7wD5QoDjs0Lyu26+BLYL0e+MxQ==
X-Google-Smtp-Source: AAOMgpfiDayaW3/9yMmfBtBZmA0NRaHmNRSjAVc6/0sHa66eOM11pk2hXBsAx5X6oKOdffnEqdG5Cg==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr11426266wrj.212.1530975335537;
        Sat, 07 Jul 2018 07:55:35 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:34 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/12] staging:rtl8192u: rename HT_EXTCHNL_OFFSET -> enum ht_extension_chan_width
Date:   Sat,  7 Jul 2018 15:55:07 +0100
Message-Id: <20180707145513.15325-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove the typedef of enumerated type HT_EXTCHNL_OFFSET and replace it with
'enum ht_extension_chan_offset'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h            | 4 ++--
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h           | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c       | 6 +++---
 drivers/staging/rtl8192u/r819xU_phy.c                     | 5 +++--
 drivers/staging/rtl8192u/r819xU_phy.h                     | 2 +-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 8ca24c10c28e..3b7968681f77 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2002,7 +2002,7 @@ struct ieee80211_device {
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
 	//added by wb for HT related
 //	void (*SwChnlByTimerHandler)(struct net_device *dev, int channel);
-	void (*SetBWModeHandler)(struct net_device *dev, enum ht_channel_width Bandwidth, HT_EXTCHNL_OFFSET Offset);
+	void (*SetBWModeHandler)(struct net_device *dev, enum ht_channel_width Bandwidth, enum ht_extension_chan_offset Offset);
 //	void (*UpdateHalRATRTableHandler)(struct net_device* dev, u8* pMcsRate);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
@@ -2358,7 +2358,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString);
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString);
 
 void HTSetConnectBwMode(struct ieee80211_device *ieee,
-			enum ht_channel_width Bandwidth, HT_EXTCHNL_OFFSET Offset);
+			enum ht_channel_width Bandwidth, enum ht_extension_chan_offset Offset);
 void HTUpdateDefaultSetting(struct ieee80211_device *ieee);
 void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap,
 				  u8 *len, u8 isEncrypt);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index 804d628ed9eb..81020fbcdc20 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -302,7 +302,7 @@ void ieee80211_wx_sync_scan_wq(struct work_struct *work)
 {
 	struct ieee80211_device *ieee = container_of(work, struct ieee80211_device, wx_sync_scan_wq);
 	short chan;
-	HT_EXTCHNL_OFFSET chan_offset = 0;
+	enum ht_extension_chan_offset chan_offset = 0;
 	enum ht_channel_width bandwidth = 0;
 	int b40M = 0;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index c13ca7f0f4dd..7d54a7cd9514 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -36,12 +36,12 @@ enum ht_channel_width {
 // Represent Extension Channel Offset in HT Capabilities
 // This is available only in 40Mhz mode.
 //
-typedef enum _HT_EXTCHNL_OFFSET {
+enum ht_extension_chan_offset {
 	HT_EXTCHNL_OFFSET_NO_EXT = 0,
 	HT_EXTCHNL_OFFSET_UPPER = 1,
 	HT_EXTCHNL_OFFSET_NO_DEF = 2,
 	HT_EXTCHNL_OFFSET_LOWER = 3,
-}HT_EXTCHNL_OFFSET, *PHT_EXTCHNL_OFFSET;
+};
 
 typedef enum _CHNLOP {
 	CHNLOP_NONE = 0, // No Action now
@@ -237,7 +237,7 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	u8				PeerMimoPs;
 
 	// 40MHz Channel Offset settings.
-	HT_EXTCHNL_OFFSET	CurSTAExtChnlOffset;
+	enum ht_extension_chan_offset	CurSTAExtChnlOffset;
 	u8				bCurTxBW40MHz;	// If we use 40 MHz to Tx
 	u8				PeerBandwidth;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 86c63b217d3b..264d15fbcc6b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -894,7 +894,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	return true;
 }
 
-void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width	Bandwidth, HT_EXTCHNL_OFFSET	Offset);
+void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width Bandwidth, enum ht_extension_chan_offset	Offset);
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -936,7 +936,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
-	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth), (HT_EXTCHNL_OFFSET)(pPeerHTInfo->ExtChlOffset));
+	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth), (enum ht_extension_chan_offset)(pPeerHTInfo->ExtChlOffset));
 
 	pHTInfo->bCurTxBW40MHz = (pPeerHTInfo->RecommemdedTxWidth == 1);
 
@@ -1290,7 +1290,7 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 /*
  * This function set bandwidth mode in protocol layer.
  */
-void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width	Bandwidth, HT_EXTCHNL_OFFSET	Offset)
+void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width Bandwidth, enum ht_extension_chan_offset Offset)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
 //	u32 flags = 0;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 8bb14cc79d8a..98cfc222e241 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1663,8 +1663,9 @@ void rtl8192_SetBWModeWorkItem(struct net_device *dev)
  * notice:    I doubt whether SetBWModeInProgress flag is necessary as we can
  *	      test whether current work in the queue or not.//do I?
  *****************************************************************************/
-void rtl8192_SetBWMode(struct net_device *dev, enum ht_channel_width bandwidth,
-		       HT_EXTCHNL_OFFSET offset)
+void rtl8192_SetBWMode(struct net_device *dev,
+		       enum ht_channel_width bandwidth,
+		       enum ht_extension_chan_offset offset)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index ea0032643620..d2e69228ac8a 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -81,7 +81,7 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 u8 rtl8192_phy_SwChnl(struct net_device *dev, u8 channel);
 void rtl8192_SetBWMode(struct net_device *dev,
 		       enum ht_channel_width bandwidth,
-		       HT_EXTCHNL_OFFSET offset);
+		       enum ht_extension_chan_offset offset);
 void rtl8192_SwChnl_WorkItem(struct net_device *dev);
 void rtl8192_SetBWModeWorkItem(struct net_device *dev);
 bool rtl8192_SetRFPowerState(struct net_device *dev,
-- 
2.18.0

