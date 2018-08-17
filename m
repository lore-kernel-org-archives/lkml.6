Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157CAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40E321A7C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdvVJaGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40E321A7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeHQVjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35389 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeHQVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id g1-v6so7868184wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGtADly62BUsV5Rqvy+9s2U9IdKNcFr5usZEbb832SI=;
        b=FdvVJaGwrCLc3gp4CSwmo0jNhxlZTq6iGum4u/RVdFd4wwaRiZIa+ExDeBdkARmA1P
         z9kiDVrTjAf1VuoIe6HK4BF9ZYyGwf6Wjk23TcKVBbaPJPYdryLT7TvS3+mn9A9eyflT
         l+sB4pTqoVYowwkMgAb5OGuRjptADu7sB1HLo5Tc20XxKFeqXgKS/LvNAnDHgdVokGTZ
         0DSskm7G2HIriF7NzpYwCh5t+TLEQusrZS5zA8oIDmnXJBlxSL2hMUFk/rgXIDUr9Hbc
         P1aD83KSbl1dD7Tf+2GMRqgzrRtuerwrk3OhPxvLyVMQlrPcMl2sQBFpT9eiQctm9mvT
         SQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGtADly62BUsV5Rqvy+9s2U9IdKNcFr5usZEbb832SI=;
        b=lfEYwJXhjiHGIR7FpIy6MlEcr+P0GWC+dfPhorQ1oxXaE1DE0RkO3EvEMydMHbiK0m
         C0jHoF7jVrVYT7vv9c+kCv3MkGsAIZyBm/Bd4Ehi8sB3xIZZO1RKCp7huiCD3JdjEbAP
         BzckQeDmF3988mrYAaXJyI3iKdsrHNcFpI7nNXPPqaqaqGwy2FLc9Mdiam+wFazxSU4a
         FSAoYjAe9iG0sbSAuVX3dkMdZmrb5HB7FlndS9TPDoHT3dIxDlpCsCg8t/zxcnOSpeDG
         b0Bo5s7iXc/Vd4clLe8D5TpfTJtgCLswrF/sjOXRoSwtyrIjPfXz+ByAlItUS9xfGlpH
         DO1w==
X-Gm-Message-State: AOUpUlGiizAYEo9TRAAvm5YHj1hHZ1nAhJ49R+lsBlUvI+pgI5Hm4Ztq
        McKtXsqv5S4qwqVsrrDTdY+wYW4Y/DU=
X-Google-Smtp-Source: AA+uWPwrC9dmt4+ebN/H3rJGTySqszudiBgD9+kOseKeBe2sHqUegb6uBxyXIWRH3mi6P9RZzFSFAg==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr23732215wrb.127.1534530913127;
        Fri, 17 Aug 2018 11:35:13 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:12 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/10] staging:rtl8192u: Refactor struct HT_CAPABILITY_ELE - Style
Date:   Fri, 17 Aug 2018 19:34:47 +0100
Message-Id: <20180817183447.15993-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure HT_CAPABILITY_ELE causes a number of checkpatch / coding
style issues. The structure uses a 'typedef' directive causing an
issue regarding defining new types in the code. The name of the
structure should be lowercase, and the '__packed' directive is prefered
over the attribute directive.

The typedef has been removed, structure renamed to ht_capability_ele
and the '__packed' directive used.

These are coding style changes and should not impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  6 ++--
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  8 ++---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 36 +++++++++----------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index f2fcdec9bd17..fa59c712c74b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -147,13 +147,13 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 
 	if (network->mode >= IEEE_N_24G)//add N rate here;
 	{
-		PHT_CAPABILITY_ELE ht_cap = NULL;
+		struct ht_capability_ele *ht_cap = NULL;
 		bool is40M = false, isShortGI = false;
 		u8 max_mcs = 0;
 		if (!memcmp(network->bssht.bdHTCapBuf, EWC11NHTCap, 4))
-			ht_cap = (PHT_CAPABILITY_ELE)&network->bssht.bdHTCapBuf[4];
+			ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[4];
 		else
-			ht_cap = (PHT_CAPABILITY_ELE)&network->bssht.bdHTCapBuf[0];
+			ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[0];
 		is40M = (ht_cap->ChlWidth)?1:0;
 		isShortGI = (ht_cap->ChlWidth)?
 						((ht_cap->ShortGI40Mhz)?1:0):
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 176caa74e4a8..64d5359cf7e2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -37,7 +37,7 @@ enum ht_extension_chan_offset {
 	HT_EXTCHNL_OFFSET_LOWER = 3,
 };
 
-typedef	struct _HT_CAPABILITY_ELE {
+struct ht_capability_ele {
 	//HT capability info
 	u8	AdvCoding:1;
 	u8	ChlWidth:1;
@@ -71,7 +71,7 @@ typedef	struct _HT_CAPABILITY_ELE {
 	//Antenna Selection Capabilities
 	u8	ASCap;
 
-} __attribute__ ((packed)) HT_CAPABILITY_ELE, *PHT_CAPABILITY_ELE;
+} __packed;
 
 /*
  * The HT Information element is present in beacons
@@ -140,7 +140,7 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	HT_SPEC_VER			ePeerHTSpecVer;
 
 	// HT related information for "Self"
-	HT_CAPABILITY_ELE	SelfHTCap;		// This is HT cap element sent to peer STA, which also indicate HT Rx capabilities.
+	struct ht_capability_ele	SelfHTCap;		// This is HT cap element sent to peer STA, which also indicate HT Rx capabilities.
 	HT_INFORMATION_ELE	SelfHTInfo;		// This is HT info element sent to peer STA, which also indicate HT Rx capabilities.
 
 	// HT related information for "Peer"
@@ -233,7 +233,7 @@ typedef struct _BSS_HT {
 	u16					bdHTInfoLen;
 
 	HT_SPEC_VER				bdHTSpecVer;
-	//HT_CAPABILITY_ELE			bdHTCapEle;
+	//struct ht_capability_ele              bdHTCapEle;
 	//HT_INFORMATION_ELE		bdHTInfoEle;
 
 	u8					bdRT2RTAggregation;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 155805e20143..9bf52cebe4cd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -130,15 +130,15 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
  */
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
-	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
-	PHT_CAPABILITY_ELE		pCapELE;
+	static u8	          EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
+	struct ht_capability_ele *pCapELE;
 
 	if (!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap))) {
 		//EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
-		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[4]);
+		pCapELE = (struct ht_capability_ele *)(&CapIE[4]);
 	} else {
-		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[0]);
+		pCapELE = (struct ht_capability_ele *)(&CapIE[0]);
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
@@ -230,7 +230,7 @@ static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
 		retValue = false;
 	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
-	else if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ChlWidth) // ap support 40 bw
+	else if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ChlWidth) // ap support 40 bw
 		retValue = true;
 	else
 		retValue = false;
@@ -248,12 +248,12 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
 	else if (is40MHz) { // ap support 40 bw
-		if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
+		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
 	} else {
-		if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
+		if (((struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
@@ -530,7 +530,7 @@ void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
 void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
-	PHT_CAPABILITY_ELE	pCapELE = NULL;
+	struct ht_capability_ele   *pCapELE = NULL;
 	//u8 bIsDeclareMCS13;
 
 	if (!posHTCap || !pHT) {
@@ -544,9 +544,9 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE)&posHTCap[4];
+		pCapELE = (struct ht_capability_ele *)&posHTCap[4];
 	} else {
-		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
+		pCapELE = (struct ht_capability_ele *)posHTCap;
 	}
 
 	//HT capability info
@@ -898,7 +898,7 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width Ban
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-	PHT_CAPABILITY_ELE		pPeerHTCap = NULL;
+	struct ht_capability_ele       *pPeerHTCap = NULL;
 	PHT_INFORMATION_ELE		pPeerHTInfo = NULL;
 	u16	nMaxAMSDUSize = 0;
 	u8	*pMcsFilter = NULL;
@@ -913,16 +913,16 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===> HTOnAssocRsp_wq(): HT_ENABLE\n");
-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, pHTInfo->PeerHTCapBuf, sizeof(HT_CAPABILITY_ELE));
+//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, pHTInfo->PeerHTCapBuf, sizeof(struct ht_capability_ele));
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, pHTInfo->PeerHTInfoBuf, sizeof(HT_INFORMATION_ELE));
 
 //	HTDebugHTCapability(pHTInfo->PeerHTCapBuf,"HTOnAssocRsp_wq");
 //	HTDebugHTInfo(pHTInfo->PeerHTInfoBuf,"HTOnAssocRsp_wq");
 	//
 	if (!memcmp(pHTInfo->PeerHTCapBuf, EWC11NHTCap, sizeof(EWC11NHTCap)))
-		pPeerHTCap = (PHT_CAPABILITY_ELE)(&pHTInfo->PeerHTCapBuf[4]);
+		pPeerHTCap = (struct ht_capability_ele *)(&pHTInfo->PeerHTCapBuf[4]);
 	else
-		pPeerHTCap = (PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf);
+		pPeerHTCap = (struct ht_capability_ele *)(pHTInfo->PeerHTCapBuf);
 
 	if (!memcmp(pHTInfo->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
 		pPeerHTInfo = (PHT_INFORMATION_ELE)(&pHTInfo->PeerHTInfoBuf[4]);
@@ -932,7 +932,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
-	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
+	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, sizeof(struct ht_capability_ele));
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
@@ -1176,7 +1176,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 {
 	PRT_HIGH_THROUGHPUT		pHTInfo = ieee->pHTInfo;
 //	u16						nMaxAMSDUSize;
-//	PHT_CAPABILITY_ELE		pPeerHTCap = (PHT_CAPABILITY_ELE)pNetwork->bssht.bdHTCapBuf;
+//	struct ht_capability_ele       *pPeerHTCap = (struct ht_capability_ele *)pNetwork->bssht.bdHTCapBuf;
 //	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 //	u8*	pMcsFilter;
 	u8	bIOTAction = 0;
@@ -1249,8 +1249,8 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 
 void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
 {
-	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-//	PHT_CAPABILITY_ELE		pPeerHTCap = (PHT_CAPABILITY_ELE)pNetwork->bssht.bdHTCapBuf;
+	PRT_HIGH_THROUGHPUT	        pHTInfo = ieee->pHTInfo;
+//	struct ht_capability_ele       *pPeerHTCap = (struct ht_capability_ele *)pNetwork->bssht.bdHTCapBuf;
 	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 
 	if (pHTInfo->bCurrentHTSupport) {
-- 
2.18.0

