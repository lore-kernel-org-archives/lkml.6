Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E994C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB712089D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxTk5P/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB712089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeGGOz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:55:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35261 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id h40-v6so6724180wrh.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dfXuacu3IEzbBd3Q3QfhH5fjBmBWJ340bYP2/yTom40=;
        b=lxTk5P/70zrjKnF/h3qlvB4hbu6JdH7q2JfbL8h3QLqngK19VoLi/ysAIP6P+AxuUO
         g+hrt42SnUuOERL5Dkk0bC3RzphVeBy3dq7plXgfRM6idS1GA2SjOnDgPAKDAkJ0hllC
         n3DgoylW1QHJuAXM8JQKqkgw4URdDbqj5DS+WuMxlvXGjDDCn09GUcL54zEcpBEY7ypU
         zdYGxLDX8bFRF/k3YZ1/ambeS1Cdv1L9YEVRvVPmqJq/tWBTHHrgADSMXcrmVfsqJfAW
         8YwO4PMPY3KZRqHXbnBA1wGMSrQ1YvRlEkOdKRx/ysj325sQXFjV/lX81LvwO0q+QtY3
         Kceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dfXuacu3IEzbBd3Q3QfhH5fjBmBWJ340bYP2/yTom40=;
        b=mpVldNsOwwno88NRQpQ+ezVanCACONEiu/KIalTGPNy4BdWGFdaYVUBUQvt17ZU4Zj
         3tgnG+Zr90YodDiL3U7sIyWJhamnhsZouF3FLbnyXX1uK3kLOseeedh20YLnr0Lk0sEO
         kFOTV6B66XZ1NmLz42B3ZI10s1n9GUfFU8BYdPk6F90stZtXkEgh2VpvmSYGDvfN23k9
         QRaFBtre2h1bFjUmcTc9g2+dTQaX+CRN4peIWp9ei2cdVvKAdp+18BtZBAdQDOzj92yY
         wZfVRzfD96gm/Z+erd5xaOgT1o7I9/j5l1ZYR37oyiZBf3rxBuFxNwYObsL7rD2kAMCV
         GWbw==
X-Gm-Message-State: APt69E0sCmpZHpATZXG79zGpIvqU0o9rDJsoK7mD2W7Yq8QCRXPwI+cm
        rYTRKArsSkN+eAunnTYdbbYKMg==
X-Google-Smtp-Source: AAOMgpfcjTUHVxH5e1l9WvSQdiiWcvxjQHmLfHVGFpKPb5Vb8c04uIdyznog2lyWnSyUhxAlSFLvuA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr10907330wrq.156.1530975324567;
        Sat, 07 Jul 2018 07:55:24 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/12] staging:rtl8192u: rename HT_CHANNEL_WIDTH -> enum ht_channel_width
Date:   Sat,  7 Jul 2018 15:55:02 +0100
Message-Id: <20180707145513.15325-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove the typedef HT_CHANNEL_WIDTH and replace with 'enum ht_channel_width'

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h            | 4 ++--
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h           | 4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c       | 6 +++---
 drivers/staging/rtl8192u/r8190_rtl8256.c                  | 2 +-
 drivers/staging/rtl8192u/r8190_rtl8256.h                  | 2 +-
 drivers/staging/rtl8192u/r8192U.h                         | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.c                     | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.h                     | 3 ++-
 9 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 3addaa65085a..8ca24c10c28e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2002,7 +2002,7 @@ struct ieee80211_device {
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
 	//added by wb for HT related
 //	void (*SwChnlByTimerHandler)(struct net_device *dev, int channel);
-	void (*SetBWModeHandler)(struct net_device *dev, HT_CHANNEL_WIDTH Bandwidth, HT_EXTCHNL_OFFSET Offset);
+	void (*SetBWModeHandler)(struct net_device *dev, enum ht_channel_width Bandwidth, HT_EXTCHNL_OFFSET Offset);
 //	void (*UpdateHalRATRTableHandler)(struct net_device* dev, u8* pMcsRate);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
@@ -2358,7 +2358,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString);
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString);
 
 void HTSetConnectBwMode(struct ieee80211_device *ieee,
-			HT_CHANNEL_WIDTH Bandwidth, HT_EXTCHNL_OFFSET Offset);
+			enum ht_channel_width Bandwidth, HT_EXTCHNL_OFFSET Offset);
 void HTUpdateDefaultSetting(struct ieee80211_device *ieee);
 void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap,
 				  u8 *len, u8 isEncrypt);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index 21bd0dc40888..804d628ed9eb 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -303,7 +303,7 @@ void ieee80211_wx_sync_scan_wq(struct work_struct *work)
 	struct ieee80211_device *ieee = container_of(work, struct ieee80211_device, wx_sync_scan_wq);
 	short chan;
 	HT_EXTCHNL_OFFSET chan_offset = 0;
-	HT_CHANNEL_WIDTH bandwidth = 0;
+	enum ht_channel_width bandwidth = 0;
 	int b40M = 0;
 
 	chan = ieee->current_network.channel;
@@ -320,7 +320,7 @@ void ieee80211_wx_sync_scan_wq(struct work_struct *work)
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT && ieee->pHTInfo->bCurBW40MHz) {
 		b40M = 1;
 		chan_offset = ieee->pHTInfo->CurSTAExtChnlOffset;
-		bandwidth = (HT_CHANNEL_WIDTH)ieee->pHTInfo->bCurBW40MHz;
+		bandwidth = (enum ht_channel_width)ieee->pHTInfo->bCurBW40MHz;
 		printk("Scan in 40M, force to 20M first:%d, %d\n", chan_offset, bandwidth);
 		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 		}
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 6abf32b142ef..c13ca7f0f4dd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -27,10 +27,10 @@
 //
 // Represent Channel Width in HT Capabilities
 //
-typedef enum _HT_CHANNEL_WIDTH {
+enum ht_channel_width {
 	HT_CHANNEL_WIDTH_20 = 0,
 	HT_CHANNEL_WIDTH_20_40 = 1,
-}HT_CHANNEL_WIDTH, *PHT_CHANNEL_WIDTH;
+};
 
 //
 // Represent Extension Channel Offset in HT Capabilities
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index abf55877331e..86c63b217d3b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -894,7 +894,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	return true;
 }
 
-void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset);
+void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width	Bandwidth, HT_EXTCHNL_OFFSET	Offset);
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -936,7 +936,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
-	HTSetConnectBwMode(ieee, (HT_CHANNEL_WIDTH)(pPeerHTCap->ChlWidth), (HT_EXTCHNL_OFFSET)(pPeerHTInfo->ExtChlOffset));
+	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth), (HT_EXTCHNL_OFFSET)(pPeerHTInfo->ExtChlOffset));
 
 	pHTInfo->bCurTxBW40MHz = (pPeerHTInfo->RecommemdedTxWidth == 1);
 
@@ -1290,7 +1290,7 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 /*
  * This function set bandwidth mode in protocol layer.
  */
-void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset)
+void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width	Bandwidth, HT_EXTCHNL_OFFSET	Offset)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
 //	u32 flags = 0;
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index e54f6fad2e68..02bdd933f05b 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -23,7 +23,7 @@
  * Note:	8226 support both 20M  and 40 MHz
  *--------------------------------------------------------------------------
  */
-void PHY_SetRF8256Bandwidth(struct net_device *dev, HT_CHANNEL_WIDTH Bandwidth)
+void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwidth)
 {
 	u8	eRFPath;
 	struct r8192_priv *priv = ieee80211_priv(dev);
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index 5c325ce9d631..29b926cad14b 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -14,7 +14,7 @@
 #define RTL8225H
 
 #define RTL819X_TOTAL_RF_PATH 2 /* for 8192U */
-void PHY_SetRF8256Bandwidth(struct net_device *dev, HT_CHANNEL_WIDTH Bandwidth);
+void PHY_SetRF8256Bandwidth(struct net_device *dev, enum ht_channel_width Bandwidth);
 void PHY_RF8256_Config(struct net_device *dev);
 void phy_RF8256_Config_ParaFile(struct net_device *dev);
 void PHY_SetRF8256CCKTxPower(struct net_device *dev, u8	powerlevel);
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 51c150a39fc2..af9d0bd57391 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -995,7 +995,7 @@ typedef struct r8192_priv {
 	u8	SwChnlStage;
 	u8	SwChnlStep;
 	u8	SetBWModeInProgress;
-	HT_CHANNEL_WIDTH		CurrentChannelBW;
+	enum ht_channel_width 	CurrentChannelBW;
 	u8      ChannelPlan;
 	/* 8190 40MHz mode */
 	/* Control channel sub-carrier */
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 12750671c860..8bb14cc79d8a 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1663,7 +1663,7 @@ void rtl8192_SetBWModeWorkItem(struct net_device *dev)
  * notice:    I doubt whether SetBWModeInProgress flag is necessary as we can
  *	      test whether current work in the queue or not.//do I?
  *****************************************************************************/
-void rtl8192_SetBWMode(struct net_device *dev, HT_CHANNEL_WIDTH bandwidth,
+void rtl8192_SetBWMode(struct net_device *dev, enum ht_channel_width bandwidth,
 		       HT_EXTCHNL_OFFSET offset)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 0a42a6092ea9..ea0032643620 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -79,7 +79,8 @@ u8 rtl8192_phy_ConfigRFWithHeaderFile(struct net_device *dev,
 				      RF90_RADIO_PATH_E eRFPath);
 
 u8 rtl8192_phy_SwChnl(struct net_device *dev, u8 channel);
-void rtl8192_SetBWMode(struct net_device *dev, HT_CHANNEL_WIDTH bandwidth,
+void rtl8192_SetBWMode(struct net_device *dev,
+		       enum ht_channel_width bandwidth,
 		       HT_EXTCHNL_OFFSET offset);
 void rtl8192_SwChnl_WorkItem(struct net_device *dev);
 void rtl8192_SetBWModeWorkItem(struct net_device *dev);
-- 
2.18.0

