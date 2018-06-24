Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC5AC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B8725061
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0MHFS0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B8725061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755895AbeFXPk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:40:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50978 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755446AbeFXPky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:40:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so6628241wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nglHdYa04LyYai2cglOAcFjHhMXHRhixExhM2yAmZvQ=;
        b=a0MHFS0GpfErmgCxHIDFExpUY6dJuuGCRus7UiJ/b498VcrvtugzyzIJgqdlYfeIay
         TWjC/j17AXa5dM3OKLhC0fcenNpCMWYXZeT5lxQNuXjQpQY3kOgrsg620oyfM83mUXuG
         Ul05yqzKABUesFSSn3iIzA1ZCXPDHZVUiV6lnc3K0/TZwzN76mf3IxYu6rKMHGvu80OJ
         kmfh0ik5hfVt8eXO+1QvgN7T/kff3MN3ofyj0+378PvKNGRZB3B6tIIUfogqriUtX5KK
         hOfGI1ePlt6PAKAczEgU2P/DZN5fNcMcNMYkmjzk9ri+emHZvVk2FntLx+fF+s0IbVEl
         ss8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nglHdYa04LyYai2cglOAcFjHhMXHRhixExhM2yAmZvQ=;
        b=kE2Xjtc7PL8ZVQloHLHVBhVJsA4iZ502eO7OMeG+WsyE547gbpyawTVkejRcD3CqXp
         gHvJ4XxIL6ylDFCcanAVfPzBb+S9bmOEyt1ReyiD233lS7CwPdmhq0BjG0TGExsAI3N5
         kfCbJNmnV+knRNPTFIxx+pStaZ8dAYIcKVjRm2AbUEv3/NpFh7H9oWnwPDJh3Kf6Tck3
         1DeUabQ3jA4q1Y0XgeVbXpAWMPc6wYH/TjijKh5+4HONn3c7alTRpoOiUBolK7m8IoYa
         xdtLFhjyf4uXWnnUxiMUPVecLAsQZxBrxT+ZI8gOcvi2WUjg0qMK29qXPCp+i8DMhMiR
         fYNg==
X-Gm-Message-State: APt69E1Cub2SkHKRuP6xjEn8m08ulvXzSOMo6C7+XzrobDgLhGjVpDqL
        01aBEajVAoU2PUeAfkGJX1vgXBcm
X-Google-Smtp-Source: AAOMgpcNcNN+g5D8vFp9qoalgQWQ5k1ENi+87SZKmk2rkmnUzI+fYb2d5MPvHw1twMrzRFEkB9S5UQ==
X-Received: by 2002:a1c:3e4a:: with SMTP id l71-v6mr6839732wma.55.1529854852576;
        Sun, 24 Jun 2018 08:40:52 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:40:51 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 1/8] staging: rtl8192u: change block comments to prefered style - Coding Style
Date:   Sun, 24 Jun 2018 16:40:20 +0100
Message-Id: <20180624154027.27654-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624154027.27654-1-johnfwhitmore@gmail.com>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the comment blocks are commening out code so have been left for the
moment.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 366 ++++++++++--------
 1 file changed, 195 insertions(+), 171 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 5a48693e2cf3..54c48747f5fa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -41,17 +41,18 @@ static u8 EDIMAX_RALINK[3] = {0x00, 0x0e, 0x2e};
 static u8 AIRLINK_RALINK[3] = {0x00, 0x18, 0x02};
 //static u8 DLINK_ATHEROS[3] = {0x00, 0x1c, 0xf0};
 static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
-
-// 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we put the
-// code in other place??
-//static u8 WIFI_CISCO_G_AP[3] = {0x00, 0x40, 0x96};
-/********************************************************************************************************************
+/*
+ * 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we put the
+ * code in other place??
+ * static u8 WIFI_CISCO_G_AP[3] = {0x00, 0x40, 0x96};
+ */
+/*
  *function:  This function update default settings in pHTInfo structure
  *   input:  PRT_HIGH_THROUGHPUT	pHTInfo
  *  output:  none
  *  return:  none
  *  notice:  These value need be modified if any changes.
- * *****************************************************************************************************************/
+ */
 void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -93,8 +94,10 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	// 8190 only. Assign duration operation mode to firmware
 	pMgntInfo->bTxEnableFwCalcDur = (BOOLEAN)pNdisCommon->bRegTxEnableFwCalcDur;
 #endif
-	// 8190 only, Realtek proprietary aggregation mode
-	// Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
+	/*
+	 * 8190 only, Realtek proprietary aggregation mode
+	 * Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
+	 */
 	pHTInfo->bRegRT2RTAggregation = 1;//0: Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
 
 	// For Rx Reorder Control
@@ -113,14 +116,14 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 #endif
 }
 
-/********************************************************************************************************************
+/*
  *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
  *  return:  none
  *  notice:  Driver should not print out this message by default.
- * *****************************************************************************************************************/
+ */
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
@@ -147,14 +150,14 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 }
 
-/********************************************************************************************************************
+/*
  *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
  *  return:  none
  *  notice:  Driver should not print out this message by default.
- * *****************************************************************************************************************/
+ */
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
@@ -209,8 +212,8 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 }
 
 /*
-*	Return:		true if station in half n mode and AP supports 40 bw
-*/
+ *	Return:		true if station in half n mode and AP supports 40 bw
+ */
 static bool IsHTHalfNmode40Bandwidth(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
@@ -276,14 +279,14 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
-/********************************************************************************************************************
+/*
  *function:  This function returns current datarate.
  *   input:  struct ieee80211_device*	ieee
  *	     u8				nDataRate
  *  output:  none
  *  return:  tx rate
  *  notice:  quite unsure about how to use this function //wb
- * *****************************************************************************************************************/
+ */
 u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 {
 	//PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -345,13 +348,13 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 	return retValue;
 }
 
-/********************************************************************************************************************
+/*
  *function:  This function returns peer IOT.
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:
  *  notice:
- * *****************************************************************************************************************/
+ */
 static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -383,31 +386,31 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG(IEEE80211_DL_IOT, "Joseph debug!! IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
 
-/********************************************************************************************************************
+/*
  *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
  *	     at receiving MCS14~15 frame from some AP.
  *   input:  struct ieee80211_device*	ieee
  *	     u8 *			PeerMacAddr
  *  output:  none
  *  return:  return 1 if driver should declare MCS13 only(otherwise return 0)
-  * *****************************************************************************************************************/
+ */
 static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 {
 	return 0;
 }
 
-/**
-* Function:	HTIOTActIsDisableMCS15
-*
-* Overview:	Check whether driver should declare capability of receiving MCS15
-*
-* Input:
-*			PADAPTER		Adapter,
-*
-* Output:		None
-* Return:	true if driver should disable MCS15
-* 2008.04.15	Emily
-*/
+/*
+ * Function:	HTIOTActIsDisableMCS15
+ *
+ * Overview:	Check whether driver should declare capability of receiving MCS15
+ *
+ * Input:
+ *			PADAPTER		Adapter,
+ *
+ * Output:		None
+ * Return:	true if driver should disable MCS15
+ * 2008.04.15	Emily
+ */
 static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 {
 	bool retValue = false;
@@ -433,18 +436,18 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 	return retValue;
 }
 
-/**
-* Function:	HTIOTActIsDisableMCSTwoSpatialStream
-*
-* Overview:	Check whether driver should declare capability of receiving All 2 ss packets
-*
-* Input:
-*			PADAPTER		Adapter,
-*
-* Output:		None
-* Return:	true if driver should disable all two spatial stream packet
-* 2008.04.21	Emily
-*/
+/*
+ * Function:	HTIOTActIsDisableMCSTwoSpatialStream
+ *
+ * Overview:	Check whether driver should declare capability of receiving All 2 ss packets
+ *
+ * Input:
+ *			PADAPTER		Adapter,
+ *
+ * Output:		None
+ * Return:	true if driver should disable all two spatial stream packet
+ * 2008.04.21	Emily
+ */
 static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
 						 u8 *PeerMacAddr)
 {
@@ -454,25 +457,25 @@ static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
 	return false;
 }
 
-/********************************************************************************************************************
+/*
  *function:  Check whether driver should disable EDCA turbo mode
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			PeerMacAddr
  *  output:  none
  *  return:  return 1 if driver should disable EDCA turbo mode(otherwise return 0)
-  * *****************************************************************************************************************/
+ */
 static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 				     u8 *PeerMacAddr)
 {	/* default enable EDCA Turbo mode. */
 	return false;
 }
 
-/********************************************************************************************************************
+/*
  *function:  Check whether we need to use OFDM to sned MGNT frame for broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
  *  return:  return 1 if true
-  * *****************************************************************************************************************/
+ */
 static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 {
 	u8	retValue = 0;
@@ -504,7 +507,7 @@ void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
 }
 
-/********************************************************************************************************************
+/*
  *function:  Construct Capablility Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posHTCap //pointer to store Capability Ele
@@ -513,7 +516,7 @@ void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and should be initialized before.
-  * *****************************************************************************************************************/
+ */
 void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
@@ -557,8 +560,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
-	//MAC HT parameters info
-	// TODO: Nedd to take care of this part
+	/*
+	 * MAC HT parameters info
+	 * TODO: Nedd to take care of this part
+	 */
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
 
 	if (IsEncrypt) {
@@ -580,8 +585,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_ALL_2SS)
 		pCapELE->MCS[1] &= 0x00;
 
-	// 2008.06.12
-	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
+	/*
+	 * 2008.06.12
+	 * For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
+	 */
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
 
@@ -609,7 +616,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 }
 
-/********************************************************************************************************************
+/*
  *function:  Construct  Information Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posHTCap //pointer to store Information Ele
@@ -618,7 +625,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and be initialized before. only AP and IBSS sta should do this
-  * *****************************************************************************************************************/
+ */
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
@@ -659,24 +666,24 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 }
 
 /*
-  *  According to experiment, Realtek AP to STA (based on rtl8190) may achieve best performance
-  *  if both STA and AP set limitation of aggregation size to 32K, that is, set AMPDU density to 2
-  *  (Ref: IEEE 11n specification). However, if Realtek STA associates to other AP, STA should set
-  *  limitation of aggregation size to 8K, otherwise, performance of traffic stream from STA to AP
-  *  will be much less than the traffic stream from AP to STA if both of the stream runs concurrently
-  *  at the same time.
-  *
-  *  Frame Format
-  *  Element ID		Length		OUI			Type1		Reserved
-  *  1 byte			1 byte		3 bytes		1 byte		1 byte
-  *
-  *  OUI		= 0x00, 0xe0, 0x4c,
-  *  Type	= 0x02
-  *  Reserved	= 0x00
-  *
-  *  2007.8.21 by Emily
-*/
-/********************************************************************************************************************
+ *  According to experiment, Realtek AP to STA (based on rtl8190) may achieve best performance
+ *  if both STA and AP set limitation of aggregation size to 32K, that is, set AMPDU density to 2
+ *  (Ref: IEEE 11n specification). However, if Realtek STA associates to other AP, STA should set
+ *  limitation of aggregation size to 8K, otherwise, performance of traffic stream from STA to AP
+ *  will be much less than the traffic stream from AP to STA if both of the stream runs concurrently
+ *  at the same time.
+ *
+ *  Frame Format
+ *  Element ID		Length		OUI			Type1		Reserved
+ *  1 byte			1 byte		3 bytes		1 byte		1 byte
+ *
+ *  OUI		= 0x00, 0xe0, 0x4c,
+ *  Type	= 0x02
+ *  Reserved	= 0x00
+ *
+ *  2007.8.21 by Emily
+ */
+/*
  *function:  Construct  Information Element in Beacon... in RT2RT condition
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			posRT2RTAgg //pointer to store Information Ele
@@ -684,7 +691,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
  *  output:  none
  *  return:  none
  *  notice:
-  * *****************************************************************************************************************/
+ */
 void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg, u8 *len)
 {
 	if (!posRT2RTAgg) {
@@ -726,13 +733,13 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 #endif
 }
 
-/********************************************************************************************************************
+/*
  *function:  Pick the right Rate Adaptive table to use
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			pOperateMCS //A pointer to MCS rate bitmap
  *  return:  always we return true
  *  notice:
-  * *****************************************************************************************************************/
+ */
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
@@ -774,24 +781,24 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 }
 
 /*
-*	Description:
-*		This function will get the highest speed rate in input MCS set.
-*
-*	/param	Adapter			Pionter to Adapter entity
-*			pMCSRateSet		Pointer to MCS rate bitmap
-*			pMCSFilter		Pointer to MCS rate filter
-*
-*	/return	Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter.
-*
-*/
-/********************************************************************************************************************
+ *	Description:
+ *		This function will get the highest speed rate in input MCS set.
+ *
+ *	/param	Adapter			Pionter to Adapter entity
+ *			pMCSRateSet		Pointer to MCS rate bitmap
+ *			pMCSFilter		Pointer to MCS rate filter
+ *
+ *	/return	Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter.
+ *
+ */
+/*
  *function:  This function will get the highest speed rate in input MCS set.
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			pMCSRateSet //Pointer to MCS rate bitmap
  *	     u8*			pMCSFilter //Pointer to MCS rate filter
  *  return:  Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter
  *  notice:
-  * *****************************************************************************************************************/
+ */
 u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSFilter)
 {
 	u8		i, j;
@@ -829,14 +836,13 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 }
 
 /*
-**
-**1.Filter our operation rate set with AP's rate set
-**2.shall reference channel bandwidth, STBC, Antenna number
-**3.generate rate adative table for firmware
-**David 20060906
-**
-** \pHTSupportedCap: the connected STA's supported rate Capability element
-*/
+ * 1.Filter our operation rate set with AP's rate set
+ * 2.shall reference channel bandwidth, STBC, Antenna number
+ * 3.generate rate adative table for firmware
+ * David 20060906
+ *
+ * \pHTSupportedCap: the connected STA's supported rate Capability element
+ */
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
@@ -849,18 +855,20 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
-	// TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
-	// we also shall suggested the first start rate set according to our singal strength
+	/*
+	 * TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
+	 * we also shall suggested the first start rate set according to our singal strength
+	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
 	// For RTL819X, if pairwisekey = wep/tkip, we support only MCS0~7.
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pOperateMCS[1] = 0;
 
-	//
-	// For RTL819X, we support only MCS0~15.
-	// And also, we do not know how to use MCS32 now.
-	//
+	/*
+	 * For RTL819X, we support only MCS0~15.
+	 * And also, we do not know how to use MCS32 now.
+	 */
 	for (i = 2; i <= 15; i++)
 		pOperateMCS[i] = 0;
 
@@ -911,30 +919,33 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	pHTInfo->bCurTxBW40MHz = (pPeerHTInfo->RecommemdedTxWidth == 1);
 
-	//
-	// Update short GI/ long GI setting
-	//
-	// TODO:
+	/*
+	 * Update short GI/ long GI setting
+	 *
+	 * TODO:
+	 */
 	pHTInfo->bCurShortGI20MHz = pHTInfo->bRegShortGI20MHz &&
 				    (pPeerHTCap->ShortGI20Mhz == 1);
 	pHTInfo->bCurShortGI40MHz = pHTInfo->bRegShortGI40MHz &&
 				   (pPeerHTCap->ShortGI40Mhz == 1);
 
-	//
-	// Config TX STBC setting
-	//
-	// TODO:
+	/*
+	 * Config TX STBC setting
+	 *
+	 * TODO:
+	 */
 
-	//
-	// Config DSSS/CCK  mode in 40MHz mode
-	//
-	// TODO:
+	/*
+	 * Config DSSS/CCK  mode in 40MHz mode
+	 *
+	 * TODO:
+	 */
 	pHTInfo->bCurSuppCCK = pHTInfo->bRegSuppCCK &&
 			       (pPeerHTCap->DssCCk == 1);
 
-	//
-	// Config and configure A-MSDU setting
-	//
+	/*
+	 * Config and configure A-MSDU setting
+	 */
 	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
@@ -943,14 +954,15 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
-	//
-	// Config A-MPDU setting
-	//
+	/*
+	 * Config A-MPDU setting
+	 */
 	pHTInfo->bCurrentAMPDUEnable = pHTInfo->bAMPDUEnable;
 
-	// <1> Decide AMPDU Factor
-
-	// By Emily
+	/*
+	 * <1> Decide AMPDU Factor
+	 * By Emily
+	 */
 	if (!pHTInfo->bRegRT2RTAggregation) {
 		// Decide AMPDU Factor according to protocol handshake
 		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
@@ -958,8 +970,10 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		else
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 	} else {
-		// Set MPDU density to 2 to Realtek AP, and set it to 0 for others
-		// Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
+		/*
+		 * Set MPDU density to 2 to Realtek AP, and set it to 0 for others
+		 * Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
+		 */
 		if (ieee->current_network.bssht.bdRT2RTAggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
 				// Realtek may set 32k in security mode and 64k for others
@@ -974,8 +988,10 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		}
 	}
 
-	// <2> Set AMPDU Minimum MPDU Start Spacing
-	// 802.11n 3.0 section 9.7d.3
+	/*
+	 * <2> Set AMPDU Minimum MPDU Start Spacing
+	 * 802.11n 3.0 section 9.7d.3
+	 */
 	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
@@ -997,22 +1013,24 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// Rx Reorder Setting
 	pHTInfo->bCurRxReorderEnable = pHTInfo->bRegRxReorderEnable;
 
-	//
-	// Filter out unsupported HT rate for this AP
-	// Update RATR table
-	// This is only for 8190 ,8192 or later product which using firmware to handle rate adaptive mechanism.
-	//
+	/*
+	 * Filter out unsupported HT rate for this AP
+	 * Update RATR table
+	 * This is only for 8190 ,8192 or later product which using firmware to handle rate adaptive mechanism.
+	 */
 
-	// Handle Ralink AP bad MCS rate set condition. Joseph.
-	// This fix the bug of Ralink AP. This may be removed in the future.
+	/*
+	 * Handle Ralink AP bad MCS rate set condition. Joseph.
+	 * This fix the bug of Ralink AP. This may be removed in the future.
+	 */
 	if (pPeerHTCap->MCS[0] == 0)
 		pPeerHTCap->MCS[0] = 0xff;
 
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11HTOperationalRateSet);
 
-	//
-	// Config MIMO Power Save setting
-	//
+	/*
+	 * Config MIMO Power Save setting
+	 */
 	pHTInfo->PeerMimoPs = pPeerHTCap->MimoPwrSave;
 	if (pHTInfo->PeerMimoPs == MIMO_PS_STATIC)
 		pMcsFilter = MCS_FILTER_1SS;
@@ -1023,28 +1041,28 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee, ieee->dot11HTOperationalRateSet, pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
-	//
-	// Config current operation mode.
-	//
+	/*
+	 * Config current operation mode.
+	 */
 	pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
 }
 
 void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
-/********************************************************************************************************************
+/*
  *function:  initialize HT info(struct PRT_HIGH_THROUGHPUT)
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:  none
  *  notice: This function is called when *  (1) MPInitialization Phase *  (2) Receiving of Deauthentication from AP
-********************************************************************************************************************/
+ */
 // TODO: Should this funciton be called when receiving of Disassociation?
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
 
-	//
-	// These parameters will be reset when receiving deauthentication packet
-	//
+	/*
+	 * These parameters will be reset when receiving deauthentication packet
+	 */
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "===========>%s()\n", __func__);
 	pHTInfo->bCurrentHTSupport = false;
 
@@ -1057,10 +1075,12 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->bCurShortGI40MHz = false;
 	pHTInfo->bForcedShortGI = false;
 
-	// CCK rate support
-	// This flag is set to true to support CCK rate by default.
-	// It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities only when associate to
-	// 11N BSS.
+	/*
+	 * CCK rate support
+	 * This flag is set to true to support CCK rate by default.
+	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities only when associate to
+	 * 11N BSS.
+	 */
 	pHTInfo->bCurSuppCCK = true;
 
 	// AMSDU related
@@ -1099,13 +1119,13 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	}
 }
 
-/********************************************************************************************************************
+/*
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  PBSS_HT pBssHT //to be initialized
  *  output:  none
  *  return:  none
  *  notice: This function is called when initialize network structure
-********************************************************************************************************************/
+ */
 void HTInitializeBssDesc(PBSS_HT pBssHT)
 {
 	pBssHT->bdSupportHT = false;
@@ -1120,14 +1140,14 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	pBssHT->bdRT2RTLongSlotTime = false;
 }
 
-/********************************************************************************************************************
+/*
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
  *	     struct ieee80211_network	*pNetwork //usually current network we are live in
  *  output:  none
  *  return:  none
  *  notice: This function should ONLY be called before association
-********************************************************************************************************************/
+ */
 void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
 {
 	PRT_HIGH_THROUGHPUT		pHTInfo = ieee->pHTInfo;
@@ -1166,8 +1186,10 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		// Determine the IOT Peer Vendor.
 		HTIOTPeerDetermine(ieee);
 
-		// Decide IOT Action
-		// Must be called after the parameter of pHTInfo->bCurrentRT2RTAggregation is decided
+		/*
+		 * Decide IOT Action
+		 * Must be called after the parameter of pHTInfo->bCurrentRT2RTAggregation is decided
+		 */
 		pHTInfo->IOTAction = 0;
 		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
 		if (bIOTAction)
@@ -1208,27 +1230,27 @@ void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_
 	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 
 	if (pHTInfo->bCurrentHTSupport) {
-		//
-		// Config current operation mode.
-		//
+		/*
+		 * Config current operation mode.
+		 */
 		if (pNetwork->bssht.bdHTInfoLen != 0)
 			pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
 
-		//
-		// <TODO: Config according to OBSS non-HT STA present!!>
-		//
+		/*
+		 * <TODO: Config according to OBSS non-HT STA present!!>
+		 */
 	}
 }
 EXPORT_SYMBOL(HTUpdateSelfAndPeerSetting);
 
-/********************************************************************************************************************
+/*
  *function:  check whether HT control field exists
  *   input:  struct ieee80211_device	*ieee
  *	     u8*			pFrame //coming skb->data
  *  output:  none
  *  return:  return true if HT control field exists(false otherwise)
  *  notice:
-********************************************************************************************************************/
+ */
 u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 {
 	if (ieee->pHTInfo->bCurrentHTSupport) {
@@ -1240,9 +1262,9 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 	return false;
 }
 
-//
-// This function set bandwidth mode in protocol layer.
-//
+/*
+ * This function set bandwidth mode in protocol layer.
+ */
 void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
@@ -1280,10 +1302,12 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 
 	pHTInfo->bSwBwInProgress = true;
 
-	// TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that switching
-	//   bandwidth is executed after scan is finished. It is a temporal solution
-	//   because software should ganrantee the last operation of switching bandwidth
-	//   is executed properlly.
+	/*
+	 * TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that switching
+	 *   bandwidth is executed after scan is finished. It is a temporal solution
+	 *   because software should ganrantee the last operation of switching bandwidth
+	 *   is executed properlly.
+	 */
 	HTSetConnectBwModeCallback(ieee);
 
 //	spin_unlock_irqrestore(&(ieee->bw_spinlock), flags);
-- 
2.17.1

