Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031512AbeEZILj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:11:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38509 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031467AbeEZILb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:11:31 -0400
X-Google-Smtp-Source: AB8JxZq2jm+JDIJ4e3KEP70HUpW2vIPvfpXNWhzntxNbMX/XElFDTmGZGcXBuuY+V9SYHejYZaY16g==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.king@canonical.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v4 2/5] staging: rtl8192e: correct position of '{', '}', '(' and ')' - coding style
Date: Sat, 26 May 2018 09:10:16 +0100
Message-Id: <20180526081019.4738-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180526081019.4738-1-johnfwhitmore@gmail.com>
References: <20180526081019.4738-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the coding style of parenthesis and braces in various code blocks

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 217 ++++++++-------------
 1 file changed, 79 insertions(+), 138 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 0a8be54fea4a..2cf67b50a995 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -7,28 +7,28 @@ u8 MCS_FILTER_ALL[16] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0
 
 u8 MCS_FILTER_1SS[16] = {0xff, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
-u16 MCS_DATA_RATE[2][2][77] =
-	{	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78, 104, 156, 208, 234, 260,
-			39, 78, 117, 234, 312, 351, 390, 52, 104, 156, 208, 312, 416, 468, 520,
-			0, 78, 104, 130, 117, 156, 195, 104, 130, 130, 156, 182, 182, 208, 156, 195,
-			195, 234, 273, 273, 312, 130, 156, 181, 156, 181, 208, 234, 208, 234, 260, 260,
-			286, 195, 234, 273, 234, 273, 312, 351, 312, 351, 390, 390, 429},			// Long GI, 20MHz
-			{14, 29, 43, 58, 87, 116, 130, 144, 29, 58, 87, 116, 173, 231, 260, 289,
-			43, 87, 130, 173, 260, 347, 390, 433, 58, 116, 173, 231, 347, 462, 520, 578,
-			0, 87, 116, 144, 130, 173, 217, 116, 144, 144, 173, 202, 202, 231, 173, 217,
-			217, 260, 303, 303, 347, 144, 173, 202, 173, 202, 231, 260, 231, 260, 289, 289,
-			318, 217, 260, 303, 260, 303, 347, 390, 347, 390, 433, 433, 477}	},		// Short GI, 20MHz
-		{	{27, 54, 81, 108, 162, 216, 243, 270, 54, 108, 162, 216, 324, 432, 486, 540,
-			81, 162, 243, 324, 486, 648, 729, 810, 108, 216, 324, 432, 648, 864, 972, 1080,
-			12, 162, 216, 270, 243, 324, 405, 216, 270, 270, 324, 378, 378, 432, 324, 405,
-			405, 486, 567, 567, 648, 270, 324, 378, 324, 378, 432, 486, 432, 486, 540, 540,
-			594, 405, 486, 567, 486, 567, 648, 729, 648, 729, 810, 810, 891},	// Long GI, 40MHz
-			{30, 60, 90, 120, 180, 240, 270, 300, 60, 120, 180, 240, 360, 480, 540, 600,
-			90, 180, 270, 360, 540, 720, 810, 900, 120, 240, 360, 480, 720, 960, 1080, 1200,
-			13, 180, 240, 300, 270, 360, 450, 240, 300, 300, 360, 420, 420, 480, 360, 450,
-			450, 540, 630, 630, 720, 300, 360, 420, 360, 420, 480, 540, 480, 540, 600, 600,
-			660, 450, 540, 630, 540, 630, 720, 810, 720, 810, 900, 900, 990}	}	// Short GI, 40MHz
-	};
+u16 MCS_DATA_RATE[2][2][77] = {
+	{	{13, 26, 39, 52, 78, 104, 117, 130, 26, 52, 78, 104, 156, 208, 234, 260,
+		 39, 78, 117, 234, 312, 351, 390, 52, 104, 156, 208, 312, 416, 468, 520,
+		 0, 78, 104, 130, 117, 156, 195, 104, 130, 130, 156, 182, 182, 208, 156, 195,
+		 195, 234, 273, 273, 312, 130, 156, 181, 156, 181, 208, 234, 208, 234, 260, 260,
+		 286, 195, 234, 273, 234, 273, 312, 351, 312, 351, 390, 390, 429},			// Long GI, 20MHz
+		{14, 29, 43, 58, 87, 116, 130, 144, 29, 58, 87, 116, 173, 231, 260, 289,
+		 43, 87, 130, 173, 260, 347, 390, 433, 58, 116, 173, 231, 347, 462, 520, 578,
+		 0, 87, 116, 144, 130, 173, 217, 116, 144, 144, 173, 202, 202, 231, 173, 217,
+		 217, 260, 303, 303, 347, 144, 173, 202, 173, 202, 231, 260, 231, 260, 289, 289,
+		 318, 217, 260, 303, 260, 303, 347, 390, 347, 390, 433, 433, 477}	},		// Short GI, 20MHz
+	{	{27, 54, 81, 108, 162, 216, 243, 270, 54, 108, 162, 216, 324, 432, 486, 540,
+		 81, 162, 243, 324, 486, 648, 729, 810, 108, 216, 324, 432, 648, 864, 972, 1080,
+		 12, 162, 216, 270, 243, 324, 405, 216, 270, 270, 324, 378, 378, 432, 324, 405,
+		 405, 486, 567, 567, 648, 270, 324, 378, 324, 378, 432, 486, 432, 486, 540, 540,
+		 594, 405, 486, 567, 486, 567, 648, 729, 648, 729, 810, 810, 891},	// Long GI, 40MHz
+		{30, 60, 90, 120, 180, 240, 270, 300, 60, 120, 180, 240, 360, 480, 540, 600,
+		 90, 180, 270, 360, 540, 720, 810, 900, 120, 240, 360, 480, 720, 960, 1080, 1200,
+		 13, 180, 240, 300, 270, 360, 450, 240, 300, 300, 360, 420, 420, 480, 360, 450,
+		 450, 540, 630, 630, 720, 300, 360, 420, 360, 420, 480, 540, 480, 540, 600, 600,
+		 660, 450, 540, 630, 540, 630, 720, 810, 720, 810, 900, 900, 990}	}	// Short GI, 40MHz
+};
 
 static u8 UNKNOWN_BORADCOM[3] = {0x00, 0x14, 0xbf};
 static u8 LINKSYSWRT330_LINKSYSWRT300_BROADCOM[3] = {0x00, 0x1a, 0x70};
@@ -122,21 +122,20 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
  *  return:  none
  *  notice:  Driver should not print out this message by default.
  * *****************************************************************************************************************/
-void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
+void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
 
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_CAPABILITY_ELE		pCapELE;
 
-	if (!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap)))
-	{
+	if (!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap))) {
 		//EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[4]);
-	}else
+	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[0]);
-
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString );
+	}
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth) ? "20MHz" : "20/40MHz");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz) ? "YES" : "NO");
@@ -165,21 +164,19 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
-	if (!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
-	{
+	if (!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo))) {
 		// Not EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pHTInfoEle = (PHT_INFORMATION_ELE)(&InfoIE[4]);
-	}else
+	} else {
 		pHTInfoEle = (PHT_INFORMATION_ELE)(&InfoIE[0]);
-
+	}
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Information Element>. Called by %s\n", TitleString);
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tPrimary channel = %d\n", pHTInfoEle->ControlChl);
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tSecondary channel =");
-	switch (pHTInfoEle->ExtChlOffset)
-	{
+	switch (pHTInfoEle->ExtChlOffset) {
 		case 0:
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "Not Present\n");
 			break;
@@ -196,8 +193,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth) ? "20Mhz" : "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
-	switch (pHTInfoEle->OptMode)
-	{
+	switch (pHTInfoEle->OptMode) {
 		case 0:
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "No Protection\n");
 			break;
@@ -248,15 +244,12 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 		retValue = false;
 	else if (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))	// station in half n mode
 		retValue = false;
-	else if (is40MHz) // ap support 40 bw
-	{
+	else if (is40MHz) { // ap support 40 bw
 		if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI40Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
 			retValue = false;
-	}
-	else
-	{
+	} else {
 		if (((PHT_CAPABILITY_ELE)(pHTInfo->PeerHTCapBuf))->ShortGI20Mhz) // ap support 40 bw short GI
 			retValue = true;
 		else
@@ -305,35 +298,25 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
-	if (nDataRate < 12)
-	{
+	if (nDataRate < 12) {
 		return CCKOFDMRate[nDataRate];
-	}
-	else
-	{
-		if (nDataRate >= 0x10 && nDataRate <= 0x1f)//if(nDataRate > 11 && nDataRate < 28 )
-		{
+	} else {
+		if (nDataRate >= 0x10 && nDataRate <= 0x1f) { //if(nDataRate > 11 && nDataRate < 28 )
 			is40MHz = 0;
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		}
-		else if (nDataRate >= 0x20  && nDataRate <= 0x2f ) //(27, 44)
-		{
+		} else if (nDataRate >= 0x20  && nDataRate <= 0x2f) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
 			//nDataRate = nDataRate - 28;
-		}
-		else if (nDataRate >= 0x30  && nDataRate <= 0x3f )  //(43, 60)
-		{
+		} else if (nDataRate >= 0x30  && nDataRate <= 0x3f) { //(43, 60)
 			is40MHz = 0;
 			isShortGI = 1;
 
 			//nDataRate = nDataRate - 44;
-		}
-		else if (nDataRate >= 0x40  && nDataRate <= 0x4f ) //(59, 76)
-		{
+		} else if (nDataRate >= 0x40  && nDataRate <= 0x4f) { //(59, 76)
 			is40MHz = 1;
 			isShortGI = 1;
 
@@ -388,7 +371,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
 			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
 			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0) )
+			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
@@ -505,9 +488,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 	// 2008/01/28 MH We must prevent that we select null bssid to link.
 
 	if (network->broadcom_cap_exist)
-	{
 		retValue = 1;
-	}
 
 	return retValue;
 }
@@ -518,9 +499,7 @@ static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
-	{
 		retValue = 1;
-	}
 
 	return retValue;
 }
@@ -550,31 +529,25 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	PHT_CAPABILITY_ELE	pCapELE = NULL;
 	//u8 bIsDeclareMCS13;
 
-	if ((posHTCap == NULL) || (pHT == NULL))
-	{
+	if ((posHTCap == NULL) || (pHT == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTCap or pHTInfo can't be null in HTConstructCapabilityElement()\n");
 		return;
 	}
 	memset(posHTCap, 0, *len);
-	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)
-	{
+	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
-	}else
-	{
+	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
 
 
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	{
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		pCapELE->ChlWidth = 0;
-	}
-	else
-	{
+	} else {
 		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
 	}
 
@@ -601,9 +574,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
 		pCapELE->MaxRxAMPDUFactor = 2; // 2 is for 32 K and 3 is 64K
-	}
-	else
-	{
+	} else {
 		pCapELE->MaxRxAMPDUFactor = 3; // 2 is for 32 K and 3 is 64K
 		pCapELE->MPDUDensity	= 0; // no density
 	}
@@ -621,8 +592,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	// 2008.06.12
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-	{
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
 		for (i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
@@ -666,15 +636,13 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
-	if ((posHTInfo == NULL) || (pHTInfoEle == NULL))
-	{
+	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
 		return;
 	}
 
 	memset(posHTInfo, 0, *len);
-	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) //ap mode is not currently supported
-	{
+	if ((ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
 		pHTInfoEle->ExtChlOffset		= ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_NO_EXT :
 											(ieee->current_network.channel <= 6) ?
@@ -696,9 +664,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 
 		*len = 22 + 2; //same above
 
-	}
-	else
-	{
+	} else {
 		//STA should not generate High Throughput Information Element
 		*len = 0;
 	}
@@ -791,23 +757,20 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
-	if (pOperateMCS == NULL)
-	{
+	if (pOperateMCS == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
 	}
 
-	switch (ieee->mode)
-	{
+	switch (ieee->mode) {
 	case IEEE_A:
 	case IEEE_B:
 	case IEEE_G:
 			//legacy rate routine handled at selectedrate
 
 			//no MCS rate
-			for (i = 0; i <= 15; i++){
+			for (i = 0; i <= 15; i++)
 				pOperateMCS[i] = 0;
-			}
 			break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
@@ -857,31 +820,25 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
-	if (pMCSRateSet == NULL || pMCSFilter == NULL)
-	{
+	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
 	for (i = 0; i < 16; i++)
 		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
 
-	for (i = 0; i < 16; i++)
-	{
+	for (i = 0; i < 16; i++) {
 		if (availableMcsRate[i] != 0)
 			break;
 	}
 	if (i == 16)
 		return false;
 
-	for (i = 0; i < 16; i++)
-	{
-		if (availableMcsRate[i] != 0)
-		{
+	for (i = 0; i < 16; i++) {
+		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
-			for (j = 0; j < 8; j++)
-			{
-				if ((bitMap%2) != 0)
-				{
+			for (j = 0; j < 8; j++) {
+				if ((bitMap%2) != 0) {
 					if (HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
 						mcsRate = (8*i+j);
 				}
@@ -910,7 +867,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++){
+	for (i = 0; i <= 15; i++) {
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
 	}
 
@@ -1008,7 +965,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
-	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
+	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
@@ -1022,27 +979,23 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// <1> Decide AMPDU Factor
 
 	// By Emily
-	if (!pHTInfo->bRegRT2RTAggregation)
-	{
+	if (!pHTInfo->bRegRT2RTAggregation) {
 		// Decide AMPDU Factor according to protocol handshake
 		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
 			pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 		else
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-	}else
-	{
+	} else {
 		// Set MPDU density to 2 to Realtek AP, and set it to 0 for others
 		// Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
-		if (ieee->current_network.bssht.bdRT2RTAggregation)
-		{
+		if (ieee->current_network.bssht.bdRT2RTAggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
 				// Realtek may set 32k in security mode and 64k for others
 				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
-		}else
-		{
+		} else {
 			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
 				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 			else
@@ -1056,18 +1009,16 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	else
 		pHTInfo->CurrentMPDUDensity = pPeerHTCap->MPDUDensity;
-	if (ieee->pairwise_key_type != KEY_TYPE_NA )
+	if (ieee->pairwise_key_type != KEY_TYPE_NA)
 		pHTInfo->CurrentMPDUDensity	= 7; // 8us
 	// Force TX AMSDU
 
 	// Lanhsin: mark for tmp to avoid deauth by ap from  s3
 	//if(memcmp(pMgntInfo->Bssid, NETGEAR834Bv2_BROADCOM, 3)==0)
-	if (0)
-		{
-
-			pHTInfo->bCurrentAMPDUEnable = false;
-			pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
-			pHTInfo->ForcedAMSDUMaxSize = 7935;
+	if (0) {
+		pHTInfo->bCurrentAMPDUEnable = false;
+		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
+		pHTInfo->ForcedAMSDUMaxSize = 7935;
 
 		pHTInfo->IOTAction |=  HT_IOT_ACT_TX_USE_AMSDU_8K;
 	}
@@ -1224,8 +1175,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "==============>%s()\n", __func__);
 	/*unmark bEnableHT flag here is the same reason why unmarked in function ieee80211_softmac_new_net. WB 2008.09.10*/
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
-	if (pNetwork->bssht.bdSupportHT)
-	{
+	if (pNetwork->bssht.bdSupportHT) {
 		pHTInfo->bCurrentHTSupport = true;
 		pHTInfo->ePeerHTSpecVer = pNetwork->bssht.bdHTSpecVer;
 
@@ -1237,13 +1187,10 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 			memcpy(pHTInfo->PeerHTInfoBuf, pNetwork->bssht.bdHTInfoBuf, pNetwork->bssht.bdHTInfoLen);
 
 		// Check whether RT to RT aggregation mode is enabled
-		if (pHTInfo->bRegRT2RTAggregation)
-		{
+		if (pHTInfo->bRegRT2RTAggregation) {
 			pHTInfo->bCurrentRT2RTAggregation = pNetwork->bssht.bdRT2RTAggregation;
 			pHTInfo->bCurrentRT2RTLongSlotTime = pNetwork->bssht.bdRT2RTLongSlotTime;
-		}
-		else
-		{
+		} else {
 			pHTInfo->bCurrentRT2RTAggregation = false;
 			pHTInfo->bCurrentRT2RTLongSlotTime = false;
 		}
@@ -1280,9 +1227,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
 
 
-	}
-	else
-	{
+	} else {
 		pHTInfo->bCurrentHTSupport = false;
 		pHTInfo->bCurrentRT2RTAggregation = false;
 		pHTInfo->bCurrentRT2RTLongSlotTime = false;
@@ -1298,8 +1243,7 @@ void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_
 //	PHT_CAPABILITY_ELE		pPeerHTCap = (PHT_CAPABILITY_ELE)pNetwork->bssht.bdHTCapBuf;
 	PHT_INFORMATION_ELE		pPeerHTInfo = (PHT_INFORMATION_ELE)pNetwork->bssht.bdHTInfoBuf;
 
-	if (pHTInfo->bCurrentHTSupport)
-	{
+	if (pHTInfo->bCurrentHTSupport) {
 		//
 		// Config current operation mode.
 		//
@@ -1323,8 +1267,7 @@ EXPORT_SYMBOL(HTUpdateSelfAndPeerSetting);
 ********************************************************************************************************************/
 u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame)
 {
-	if (ieee->pHTInfo->bCurrentHTSupport)
-	{
+	if (ieee->pHTInfo->bCurrentHTSupport) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "HT CONTROL FILED EXIST!!\n");
 			return true;
@@ -1357,8 +1300,7 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 		return;
 	}
 	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
-	if (Bandwidth == HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)))
-	 {
+	if (Bandwidth == HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
 			// Handle Illegal extension channel offset!!
 		if (ieee->current_network.channel < 2 && Offset == HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
@@ -1391,8 +1333,7 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
 
-	if (pHTInfo->bCurBW40MHz)
-	{
+	if (pHTInfo->bCurBW40MHz) {
 		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
 		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
-- 
2.16.3
