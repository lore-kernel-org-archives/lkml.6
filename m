Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeFCME6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:04:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40807 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:04:56 -0400
X-Google-Smtp-Source: ADUXVKIYGlHTEJNgAm+vSDmyk/SzTTLC3jewSi06pHXtu+ETI2v5TsS/XHWe6OjwuAsQepR6J3Uj8w==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 2/8] staging: rtl8192e: Addition of prefered spacing - Coding style
Date: Sun,  3 Jun 2018 13:04:07 +0100
Message-Id: <20180603120413.13042-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces around various operators, as preferred by coding style.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 47b6add256d0..0db98c77a8e9 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -264,7 +264,7 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	is40MHz = (IsHTHalfNmode40Bandwidth(ieee)) ? 1 : 0;
 	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz)) ? 1 : 0;
 
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
@@ -275,7 +275,7 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 	u8	isShortGI = (pHTInfo->bCurBW40MHz) ?
 						((pHTInfo->bCurShortGI40MHz) ? 1 : 0) :
 						((pHTInfo->bCurShortGI20MHz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
 /********************************************************************************************************************
@@ -317,7 +317,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 
 			//nDataRate = nDataRate - 60;
 		}
-		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate&0xf];
+		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 	}
 }
 
@@ -823,15 +823,15 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
 			for (j = 0; j < 8; j++) {
-				if ((bitMap%2) != 0) {
-					if (HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
-						mcsRate = (8*i+j);
+				if ((bitMap % 2) != 0) {
+					if (HTMcsToDataRate(ieee, (8 * i + j)) > HTMcsToDataRate(ieee, mcsRate))
+						mcsRate = (8 * i + j);
 				}
 				bitMap >>= 1;
 			}
 		}
 	}
-	return (mcsRate|0x80);
+	return (mcsRate | 0x80);
 }
 
 /*
@@ -850,7 +850,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	// filter out operational rate set not supported by AP, the length of it is 16
 	for (i = 0; i <= 15; i++) {
-		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
+		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
 	}
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
@@ -909,7 +909,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
-	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
+	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
@@ -1303,9 +1303,9 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 
 	if (pHTInfo->bCurBW40MHz) {
 		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
+			ieee->set_chan(ieee->dev, ieee->current_network.channel + 2);
 		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel-2);
+			ieee->set_chan(ieee->dev, ieee->current_network.channel - 2);
 		else
 			ieee->set_chan(ieee->dev, ieee->current_network.channel);
 
-- 
2.17.0
