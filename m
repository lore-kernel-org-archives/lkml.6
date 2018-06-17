Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBEFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D24C20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D24C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeFQFbM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:31:12 -0400
Received: from mout.perfora.net ([74.208.4.194]:60249 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbeFQFbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:10 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0ML8yt-1fU9IJ3att-000LGx;
 Sun, 17 Jun 2018 07:30:59 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 03/11] staging: rtl8723bs: Fix camel-case names in phy_get_tx_pwr_lmt().
Date:   Sat, 16 Jun 2018 22:30:32 -0700
Message-Id: <20180617053040.5903-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:19qb8BYoHtzCg39/0VoQBeD2NLmrSc8geWDTLj6yDWeVkBZ+/52
 jFVZLqkoBaFwZ/brjmGGOLca36qQfz7cL58TF8+sm/AFYZ+tow8/kCL1/Ac0dwz/AleyFrg
 vqq+ZOZ+5GB9igPHny8qFCvAX4ONwSPqMXAlOUhsXIzNaAOVdKs6gwHszxUtdbUZ6plA56Z
 TkPCypAqYrHVIuBj/Lfuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qRwY8t+UXbw=:HI1pY21Bp69qZ2ayhJx2Wx
 K0iQicCnoVI9FJOcK76UF00M0Xfunpa1aXiFBh39bbgYRC+fHWmM1dw3zRmV2csVjyo1ocAe3
 M8sGje9ZLd3egNFvNxQcDmxLaGyvVAZkYTBGjxaUpRvWo/qcZ0u64GChMIBnLnILhm/cH8XVb
 aiGTyvuabn35P7j+KuDg4q4HEu57jRb/WveHsuZyfFqueKVI0sgNhitnnPQqUxAjj5ItqE+cf
 7UejtOr4cjQ6UUy2u/NDaV769uiymPM+ALDEL3o///AeCurFYcPQf+WmmIaPdB0TJaJXlxP5e
 OLi5woFvE9txXceJkkA5rz4GR2fASpDZbRY/+TmleOenw0G45kvb5OT5++ZKI9FDtDp5xx96b
 iIsFfEw+kbCvtMn8Ku7iWFCA1s8ulBimW07d28vH06gZU7ElYJ5P7lx2ePYlQ2GVxkSky0+Ql
 oqOuBoBUz/FMBH8UZjq1tsdsRoahdwJBecy8v2NSEALstIZLm4oeNFF9899KcznFKSQO9cJm1
 lMTM4ZlXHmi9BpT+xIIRB0NEzC/xqPa+3ceUrrA6jhrFVpyNC7FQQrOcVR3xTqmYrk1o8aVdD
 shjorrfVhKQvRYl+eHEhYRwWG4Qhiweo7AbRi9GjLGL91SKD4c2X/NFgGAZ32PymCLNsaKslf
 6xJhFKmByqO+Q/EodJVkvKAz3qVsA3l0htk0OGc4UldOTvvIKfz9osNKRnPGLT3ns5k8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change camel-case names to snake-case names; to avoid variable name
conflicts, rename table index variables to idx_*.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 200 +++++++++---------
 1 file changed, 105 insertions(+), 95 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 4ab624f5ece0..7e27d7ff29fa 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1612,211 +1612,221 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 	return channelIndex;
 }
 
-s8 phy_get_tx_pwr_lmt(struct adapter *Adapter, u32 RegPwrTblSel,
-		      enum BAND_TYPE Band, enum CHANNEL_WIDTH Bandwidth,
-		      u8 RfPath, u8 DataRate, u8 Channel)
+s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
+		      enum BAND_TYPE band_type, enum CHANNEL_WIDTH bandwidth,
+		      u8 rf_path, u8 data_rate, u8 channel)
 {
-	s16 band        = -1;
-	s16 regulation  = -1;
-	s16 bandwidth   = -1;
-	s16 rateSection = -1;
-	s16 channel     = -1;
-	s8 powerLimit = MAX_POWER_INDEX;
-	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
-
-	if (((Adapter->registrypriv.RegEnableTxPowerLimit == 2) &&
-	     (pHalData->EEPROMRegulatory != 1)) ||
-	    (Adapter->registrypriv.RegEnableTxPowerLimit == 0))
+	s16 idx_band       = -1;
+	s16 idx_regulation = -1;
+	s16 idx_bandwidth  = -1;
+	s16 idx_rate_sctn  = -1;
+	s16 idx_channel    = -1;
+	s8 pwr_lmt = MAX_POWER_INDEX;
+	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
+
+	if (((adapter->registrypriv.RegEnableTxPowerLimit == 2) &&
+	     (hal_data->EEPROMRegulatory != 1)) ||
+	    (adapter->registrypriv.RegEnableTxPowerLimit == 0))
 		return MAX_POWER_INDEX;
 
-	switch (Adapter->registrypriv.RegPwrTblSel) {
+	switch (adapter->registrypriv.RegPwrTblSel) {
 	case 1:
-		regulation = TXPWR_LMT_ETSI;
+		idx_regulation = TXPWR_LMT_ETSI;
 		break;
 	case 2:
-		regulation = TXPWR_LMT_MKK;
+		idx_regulation = TXPWR_LMT_MKK;
 		break;
 	case 3:
-		regulation = TXPWR_LMT_FCC;
+		idx_regulation = TXPWR_LMT_FCC;
 		break;
 	case 4:
-		regulation = TXPWR_LMT_WW;
+		idx_regulation = TXPWR_LMT_WW;
 		break;
 	default:
-		regulation = (Band == BAND_ON_2_4G) ?
-			pHalData->Regulation2_4G :
-			pHalData->Regulation5G;
+		idx_regulation = (band_type == BAND_ON_2_4G) ?
+			hal_data->Regulation2_4G :
+			hal_data->Regulation5G;
 		break;
 	}
 
 	/* DBG_871X("pMgntInfo->RegPwrTblSel %d, final regulation %d\n", */
-	/*         Adapter->registrypriv.RegPwrTblSel, regulation); */
-
-	if (Band == BAND_ON_2_4G)
-		band = 0;
-	else if (Band == BAND_ON_5G)
-		band = 1;
-
-	if (Bandwidth == CHANNEL_WIDTH_20)
-		bandwidth = 0;
-	else if (Bandwidth == CHANNEL_WIDTH_40)
-		bandwidth = 1;
-	else if (Bandwidth == CHANNEL_WIDTH_80)
-		bandwidth = 2;
-	else if (Bandwidth == CHANNEL_WIDTH_160)
-		bandwidth = 3;
-
-	switch (DataRate) {
+	/*         adapter->registrypriv.RegPwrTblSel, idx_regulation); */
+
+	if (band_type == BAND_ON_2_4G)
+		idx_band = 0;
+	else if (band_type == BAND_ON_5G)
+		idx_band = 1;
+
+	if (bandwidth == CHANNEL_WIDTH_20)
+		idx_bandwidth = 0;
+	else if (bandwidth == CHANNEL_WIDTH_40)
+		idx_bandwidth = 1;
+	else if (bandwidth == CHANNEL_WIDTH_80)
+		idx_bandwidth = 2;
+	else if (bandwidth == CHANNEL_WIDTH_160)
+		idx_bandwidth = 3;
+
+	switch (data_rate) {
 	case MGN_1M: case MGN_2M: case MGN_5_5M: case MGN_11M:
-		rateSection = 0;
+		idx_rate_sctn = 0;
 		break;
 
 	case MGN_6M: case MGN_9M: case MGN_12M: case MGN_18M:
 	case MGN_24M: case MGN_36M: case MGN_48M: case MGN_54M:
-		rateSection = 1;
+		idx_rate_sctn = 1;
 		break;
 
 	case MGN_MCS0: case MGN_MCS1: case MGN_MCS2: case MGN_MCS3:
 	case MGN_MCS4: case MGN_MCS5: case MGN_MCS6: case MGN_MCS7:
-		rateSection = 2;
+		idx_rate_sctn = 2;
 		break;
 
 	case MGN_MCS8: case MGN_MCS9: case MGN_MCS10: case MGN_MCS11:
 	case MGN_MCS12: case MGN_MCS13: case MGN_MCS14: case MGN_MCS15:
-		rateSection = 3;
+		idx_rate_sctn = 3;
 		break;
 
 	case MGN_MCS16: case MGN_MCS17: case MGN_MCS18: case MGN_MCS19:
 	case MGN_MCS20: case MGN_MCS21: case MGN_MCS22: case MGN_MCS23:
-		rateSection = 4;
+		idx_rate_sctn = 4;
 		break;
 
 	case MGN_MCS24: case MGN_MCS25: case MGN_MCS26: case MGN_MCS27:
 	case MGN_MCS28: case MGN_MCS29: case MGN_MCS30: case MGN_MCS31:
-		rateSection = 5;
+		idx_rate_sctn = 5;
 		break;
 
 	case MGN_VHT1SS_MCS0: case MGN_VHT1SS_MCS1: case MGN_VHT1SS_MCS2:
 	case MGN_VHT1SS_MCS3: case MGN_VHT1SS_MCS4: case MGN_VHT1SS_MCS5:
 	case MGN_VHT1SS_MCS6: case MGN_VHT1SS_MCS7: case MGN_VHT1SS_MCS8:
 	case MGN_VHT1SS_MCS9:
-		rateSection = 6;
+		idx_rate_sctn = 6;
 		break;
 
 	case MGN_VHT2SS_MCS0: case MGN_VHT2SS_MCS1: case MGN_VHT2SS_MCS2:
 	case MGN_VHT2SS_MCS3: case MGN_VHT2SS_MCS4: case MGN_VHT2SS_MCS5:
 	case MGN_VHT2SS_MCS6: case MGN_VHT2SS_MCS7: case MGN_VHT2SS_MCS8:
 	case MGN_VHT2SS_MCS9:
-		rateSection = 7;
+		idx_rate_sctn = 7;
 		break;
 
 	case MGN_VHT3SS_MCS0: case MGN_VHT3SS_MCS1: case MGN_VHT3SS_MCS2:
 	case MGN_VHT3SS_MCS3: case MGN_VHT3SS_MCS4: case MGN_VHT3SS_MCS5:
 	case MGN_VHT3SS_MCS6: case MGN_VHT3SS_MCS7: case MGN_VHT3SS_MCS8:
 	case MGN_VHT3SS_MCS9:
-		rateSection = 8;
+		idx_rate_sctn = 8;
 		break;
 
 	case MGN_VHT4SS_MCS0: case MGN_VHT4SS_MCS1: case MGN_VHT4SS_MCS2:
 	case MGN_VHT4SS_MCS3: case MGN_VHT4SS_MCS4: case MGN_VHT4SS_MCS5:
 	case MGN_VHT4SS_MCS6: case MGN_VHT4SS_MCS7: case MGN_VHT4SS_MCS8:
 	case MGN_VHT4SS_MCS9:
-		rateSection = 9;
+		idx_rate_sctn = 9;
 		break;
 
 	default:
-		DBG_871X("Wrong rate 0x%x\n", DataRate);
+		DBG_871X("Wrong rate 0x%x\n", data_rate);
 		break;
 	}
 
-	if (Band == BAND_ON_5G && rateSection == 0)
+	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
                 DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
-	if (rateSection == 1)
-		bandwidth = 0;
+	if (idx_rate_sctn == 1)
+		idx_bandwidth = 0;
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  CCK table will only be given in BW 20M */
-	if (rateSection == 0)
-		bandwidth = 0;
+	if (idx_rate_sctn == 0)
+		idx_bandwidth = 0;
 
 	/*  workaround for wrong indxe combination to obtain tx power limit, */
 	/*  HT on 80M will reference to HT on 40M */
-	if ((rateSection == 2 || rateSection == 3) &&
-	    Band == BAND_ON_5G && bandwidth == 2) {
-		bandwidth = 1;
+	if ((idx_rate_sctn == 2 || idx_rate_sctn == 3) &&
+	    band_type == BAND_ON_5G && idx_bandwidth == 2) {
+		idx_bandwidth = 1;
 	}
 
-	if (Band == BAND_ON_2_4G)
+	if (band_type == BAND_ON_2_4G)
 		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_2_4G,
-							    Channel);
-	else if (Band == BAND_ON_5G)
+							    channel);
+	else if (band_type == BAND_ON_5G)
 		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G,
-							    Channel);
-	else if (Band == BAND_ON_BOTH) {
+							    channel);
+	else if (band_type == BAND_ON_BOTH) {
 		/*  BAND_ON_BOTH don't care temporarily */
 	}
 
-	if (band == -1 || regulation == -1 || bandwidth == -1 ||
-	    rateSection == -1 || channel == -1) {
+	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
+	    idx_rate_sctn == -1 || idx_channel == -1) {
 		/* DBG_871X("Wrong index value to access power limit table [band %d][regulation %d][bandwidth %d][rf_path %d][rate_section %d][chnlGroup %d]\n", */
-		/*         band, regulation, bandwidth, RfPath, */
-		/*         rateSection, channelGroup); */
+		/*         idx_band, idx_regulation, idx_bandwidth, rf_path, */
+		/*         idx_rate_sctn, channel); */
 
 		return MAX_POWER_INDEX;
 	}
 
-	if (Band == BAND_ON_2_4G) {
+	if (band_type == BAND_ON_2_4G) {
 		s8 limits[10] = {0}; u8 i = 0;
 		for (i = 0; i < MAX_REGULATION_NUM; i++)
-			limits[i] = pHalData->TxPwrLimit_2_4G[i][bandwidth]
-							     [rateSection]
-							     [channel][RfPath];
+			limits[i] = hal_data->TxPwrLimit_2_4G[i]
+							     [idx_bandwidth]
+							     [idx_rate_sctn]
+							     [idx_channel]
+							     [rf_path];
 
-		powerLimit = (regulation == TXPWR_LMT_WW) ?
+		pwr_lmt = (idx_regulation == TXPWR_LMT_WW) ?
 			phy_GetWorldWideLimit(limits) :
-			pHalData->TxPwrLimit_2_4G[regulation][bandwidth]
-						 [rateSection][channel][RfPath];
+			hal_data->TxPwrLimit_2_4G[idx_regulation]
+						 [idx_bandwidth]
+						 [idx_rate_sctn]
+						 [idx_channel]
+						 [rf_path];
 
-	} else if (Band == BAND_ON_5G) {
+	} else if (band_type == BAND_ON_5G) {
 		s8 limits[10] = {0}; u8 i = 0;
 		for (i = 0; i < MAX_REGULATION_NUM; ++i)
-			limits[i] = pHalData->TxPwrLimit_5G[i][bandwidth]
-							   [rateSection]
-							   [channel][RfPath];
+			limits[i] = hal_data->TxPwrLimit_5G[i]
+							   [idx_bandwidth]
+							   [idx_rate_sctn]
+							   [idx_channel]
+							   [rf_path];
 
-		powerLimit = (regulation == TXPWR_LMT_WW) ?
+		pwr_lmt = (idx_regulation == TXPWR_LMT_WW) ?
 			phy_GetWorldWideLimit(limits) :
-			pHalData->TxPwrLimit_5G[regulation][bandwidth]
-					       [rateSection][channel][RfPath];
+			hal_data->TxPwrLimit_5G[idx_regulation]
+					       [idx_bandwidth]
+					       [idx_rate_sctn]
+					       [idx_channel]
+					       [rf_path];
 	} else
 		DBG_871X("No power limit table of the specified band\n");
 
 	/*  combine 5G VHT & HT rate */
 	/*  5G 20M and 40M HT and VHT can cross reference */
 	/*
-	if (Band == BAND_ON_5G && powerLimit == MAX_POWER_INDEX) {
-		if (bandwidth == 0 || bandwidth == 1) {
+	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
+		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
 			RT_TRACE(COMP_INIT, DBG_LOUD, ("No power limit table of the specified band %d, bandwidth %d, ratesection %d, rf path %d\n",
-				 band, bandwidth,
-				 rateSection, RfPath));
-			if (rateSection == 2)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][4][channelGroup][RfPath];
-			else if (rateSection == 4)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][2][channelGroup][RfPath];
-			else if (rateSection == 3)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][5][channelGroup][RfPath];
-			else if (rateSection == 5)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][3][channelGroup][RfPath];
+				 idx_band, idx_bandwidth,
+				 idx_rate_sctn, rf_path));
+			if (idx_rate_sctn == 2)
+				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][4][idx_channel][rf_path];
+			else if (idx_rate_sctn == 4)
+				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][2][idx_channel][rf_path];
+			else if (idx_rate_sctn == 3)
+				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][5][idx_channel][rf_path];
+			else if (idx_rate_sctn == 5)
+				pwr_lmt = hal_data->TxPwrLimit_5G[idx_regulation][idx_bandwidth][3][idx_channel][rf_path];
 		}
 	}
 	*/
 
 	/* DBG_871X("TxPwrLmt[Regulation %d][Band %d][BW %d][RFPath %d][Rate 0x%x][Chnl %d] = %d\n", */
-	/*		regulation, pHalData->CurrentBandType, Bandwidth, RfPath, DataRate, Channel, powerLimit); */
-	return powerLimit;
+	/*		idx_regulation, hal_data->CurrentBandType, bandwidth, rf_path, data_rate, channel, pwr_lmt); */
+	return pwr_lmt;
 }
 
 static void phy_CrossReferenceHTAndVHTTxPowerLimit(struct adapter *padapter)
-- 
2.17.1

