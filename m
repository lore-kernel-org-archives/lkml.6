Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELt1e/s3Mqxr1TYZdisqaGc7HIIc2qnVPffJvaCBaGj1Y7hCRoJTBAUzsCBy9vZPeSyOJHY0
ARC-Seal: i=1; a=rsa-sha256; t=1522140099; cv=none;
        d=google.com; s=arc-20160816;
        b=jW7Xw9xCcJuYkeatiRO2lm9pBWXQeGExO6P4esWBDFhxNx2Umy7xHa0k0FWXX37Vca
         Ce9dvtn5ftLgvVkm6YffaZZS+DgfwV74z/00XqDcwx9x66LQ7GXkNLhQjRrPtOSm+OGI
         AmCksJzAgR6hw7So3fmfPCJTh2iBOcm7MpwjVaqgRh4gEageSGJAbB1xvcU8y+aDU5ma
         66bIlIGNm1XcncE7eBP7ov0BTLI3JlW5eDAlk6kHkSYvdUZy6QB1g2bR3Sew6yIHObvc
         0eBI7PeujdkrE4SgkGzodDb5/I91ou1h/RXau29VoHwPSarF0iWifRJtjkAb64QZEVz8
         q7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=upqpKSWwdNJ4gxi/GrVn7V78WpShR0ZDJ4XeuQtJyX8=;
        b=NiRznqiGCmyxfn9GvajouT9y6r2QjMyWw3V1ydCnAHoIq5cE2QbsvW4buWLDuFvJVI
         e7K+l8vy74QX81GRk0XByEEPmtH7ALYg9L4Q+zffelTX5rlK7aKu9DK+GSBLHfz8aX4+
         nI1482PabStOBAWeTjcS4kfEYAZrWnPqPXnaDfVG2ysPigX5udY8/WcXlPOdEXSGb2X7
         izjV94Gwv21KUAOZyo2m0fhT8waaA0IDOkIYZN0txF7TY8gFtjU4A/bSJpNED/Aq/MZO
         UotGHRs+ONoiH6g+u8j2C8j4S8E/PMZBUc+v/M3kYSH9fk6HChpJEgQi0pjkq4TuBo2u
         9waA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 21/23] staging: rtl8723bs: Rework 'struct _ODM_Per_Pkt_Info_' coding style.
Date: Tue, 27 Mar 2018 01:41:13 -0700
Message-Id: <20180327084115.16129-21-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:qnzxCxLCIq0ZpjEGQIERpDGY0aI+fId9t9K+sXr05DkiWwna6UP
 tx0VOYKD1k721c66hSAArzoMYrkvsMSkP2aXfvqp61UyC85en1i5o6wCnbBBLlIF4fO+Ncm
 rwAUoJMKO8gE/zSsUOEZkbBXuPENyr3LfHdAr/QHgixg10wAIGK/4AktlOC4urqrAKDCgzt
 OQstvHetU4XYE2WWGWmOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jB0XHHXt+FM=:Em1ybNdJSi6E1I4VPP7EHI
 kzuZRkQgkHaC3nRwzBl/fDgOeJrRWiCMc8hD2icqcib7rnyg4mfFt8/9wW2OLj/Je9YLcgfrW
 eaaWXADs2e0sqqkZh/spI84MDxvTr8kmxDH/DRb/AjQnlACaedvrRdC5hmEzzD6oiingM2047
 1ip5GWr07X6/TUSUyfYfUFDIf4bRCCLabGmFvjWJ+xN6oKUJ4vXXuQcHqg0UOLNwQCMPO/7Lr
 omfehETFs9BGvu0TY6kqr1Fzzh8qwOHifOAo/QVpMuUPIr3upf7Z58JBrd0rDs/L6CvqsQQUH
 48sCDsXxSQneYxZ3K6slo8M/3cpoYKrw2XKVsWM1EyCxD2ldZ3gdYDryf2lK4nWLTPVdTi93I
 fTdrjAs4KLKnxKqnDSwWOu9PkYadx77zV73M2r1uG0gV5FzHFXRYfwRhHtbB+gjhiMALBdqqp
 g21S2Bw1UiQgV+1YOIjq5HDPuTLxu05CDxF3iWbAWQu+2lKB7YlHgQ3xjOVKli9AcUtR0OYYW
 T4cw9VJrXchudZqboBdJJw7yXDD9m2+ILIl2A85QGWiVPVj9kaxHvaf1fV8oRyUZn1GAR3oFT
 rORL/uaHmWDfUMUdL3efuIa3Z8Py8tlDUk4/93I+3wR7/RNiU4TzR1jTk4NHN8rlsR/0hAadz
 l+GTvQwcv//L9nA/URxXWL7RHM0dLofv6qyqnwPWstX8emuC/MU+887G8PD84tTOs8/rVIUbZ
 MgCbnnSsVzQVyd8pkRAoNy2/IrDiYh2XL33Xgg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079577396167118?=
X-GMAIL-MSGID: =?utf-8?q?1596079577396167118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the typedef'd 'struct _ODM_Per_Pkt_Info_' into
'struct odm_packet_info' and change the members to snake case in
order to meet the coding style guidelines.
Members:
* u8 DataRate            -> data_rate
* u8 StationID           -> station_id
* bool bPacketMatchBSSID -> bssid_match
* bool bPacketToSelf     -> to_self
* bool bPacketBeacon     -> is_beacon
* bool bToSelf           -> (removed because it isn't used)

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/odm.h             | 16 +++++------
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c |  4 +--
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c    | 26 ++++++++---------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h    |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c  | 37 +++++++++++++------------
 5 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 87a76bafecb3..7c13a9314a22 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -262,15 +262,13 @@ typedef struct _ODM_Phy_Status_Info_ {
 } ODM_PHY_INFO_T, *PODM_PHY_INFO_T;
 
 
-typedef struct _ODM_Per_Pkt_Info_ {
-	/* u8 Rate; */
-	u8 DataRate;
-	u8 StationID;
-	bool bPacketMatchBSSID;
-	bool bPacketToSelf;
-	bool bPacketBeacon;
-	bool bToSelf;
-} ODM_PACKET_INFO_T, *PODM_PACKET_INFO_T;
+struct odm_packet_info {
+	u8 data_rate;
+	u8 station_id;
+	bool bssid_match;
+	bool to_self;
+	bool is_beacon;
+};
 
 
 typedef struct _ODM_Phy_Dbg_Info_ {
diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index 71853e6f7106..178aaab3f76c 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -316,14 +316,14 @@ void ODM_CfoTracking(void *pDM_VOID)
 void ODM_ParsingCFO(void *pDM_VOID, void *pPktinfo_VOID, s8 *pcfotail)
 {
 	PDM_ODM_T pDM_Odm = (PDM_ODM_T)pDM_VOID;
-	PODM_PACKET_INFO_T pPktinfo = (PODM_PACKET_INFO_T)pPktinfo_VOID;
+	struct odm_packet_info *pPktinfo = (struct odm_packet_info *)pPktinfo_VOID;
 	PCFO_TRACKING pCfoTrack = &pDM_Odm->DM_CfoTrack;
 	u8 i;
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_CFO_TRACKING))
 		return;
 
-	if (pPktinfo->StationID != 0) {
+	if (pPktinfo->station_id != 0) {
 		/* 3 Update CFO report for path-A & path-B */
 		/*  Only paht-A and path-B have CFO tail and short CFO */
 		for (i = ODM_RF_PATH_A; i <= ODM_RF_PATH_B; i++)
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index 8dd6da8a4e26..b3f4c237e903 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -93,7 +93,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 	PDM_ODM_T pDM_Odm,
 	PODM_PHY_INFO_T pPhyInfo,
 	u8 *pPhyStatus,
-	PODM_PACKET_INFO_T pPktinfo
+	struct odm_packet_info *pPktinfo
 )
 {
 	u8 i, Max_spatial_stream;
@@ -106,7 +106,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 	u8 LNA_idx, VGA_idx;
 	PPHY_STATUS_RPT_8192CD_T pPhyStaRpt = (PPHY_STATUS_RPT_8192CD_T)pPhyStatus;
 
-	isCCKrate = pPktinfo->DataRate <= DESC_RATE11M;
+	isCCKrate = pPktinfo->data_rate <= DESC_RATE11M;
 	pPhyInfo->RxMIMOSignalQuality[ODM_RF_PATH_A] = -1;
 	pPhyInfo->RxMIMOSignalQuality[ODM_RF_PATH_B] = -1;
 
@@ -215,7 +215,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 			/*  */
 			/*  (3)EVM of HT rate */
 			/*  */
-			if (pPktinfo->DataRate >= DESC_RATEMCS8 && pPktinfo->DataRate <= DESC_RATEMCS15)
+			if (pPktinfo->data_rate >= DESC_RATEMCS8 && pPktinfo->data_rate <= DESC_RATEMCS15)
 				Max_spatial_stream = 2; /* both spatial stream make sense */
 			else
 				Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
@@ -267,7 +267,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 }
 
 static void odm_Process_RSSIForDM(
-	PDM_ODM_T pDM_Odm, PODM_PHY_INFO_T pPhyInfo, PODM_PACKET_INFO_T pPktinfo
+	PDM_ODM_T pDM_Odm, PODM_PHY_INFO_T pPhyInfo, struct odm_packet_info *pPktinfo
 )
 {
 
@@ -279,22 +279,22 @@ static void odm_Process_RSSIForDM(
 	PSTA_INFO_T pEntry;
 
 
-	if (pPktinfo->StationID == 0xFF)
+	if (pPktinfo->station_id == 0xFF)
 		return;
 
-	pEntry = pDM_Odm->pODM_StaInfo[pPktinfo->StationID];
+	pEntry = pDM_Odm->pODM_StaInfo[pPktinfo->station_id];
 
 	if (!IS_STA_VALID(pEntry))
 		return;
 
-	if ((!pPktinfo->bPacketMatchBSSID))
+	if ((!pPktinfo->bssid_match))
 		return;
 
-	if (pPktinfo->bPacketBeacon)
+	if (pPktinfo->is_beacon)
 		pDM_Odm->PhyDbgInfo.NumQryBeaconPkt++;
 
-	isCCKrate = ((pPktinfo->DataRate <= DESC_RATE11M)) ? true : false;
-	pDM_Odm->RxRate = pPktinfo->DataRate;
+	isCCKrate = ((pPktinfo->data_rate <= DESC_RATE11M)) ? true : false;
+	pDM_Odm->RxRate = pPktinfo->data_rate;
 
 	/* Statistic for antenna/path diversity------------------ */
 	if (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV) {
@@ -307,7 +307,7 @@ static void odm_Process_RSSIForDM(
 	UndecoratedSmoothedOFDM = pEntry->rssi_stat.UndecoratedSmoothedOFDM;
 	UndecoratedSmoothedPWDB = pEntry->rssi_stat.UndecoratedSmoothedPWDB;
 
-	if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
+	if (pPktinfo->to_self || pPktinfo->is_beacon) {
 
 		if (!isCCKrate) { /* ofdm rate */
 			if (pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_B] == 0) {
@@ -424,7 +424,7 @@ static void ODM_PhyStatusQuery_92CSeries(
 	PDM_ODM_T pDM_Odm,
 	PODM_PHY_INFO_T pPhyInfo,
 	u8 *pPhyStatus,
-	PODM_PACKET_INFO_T pPktinfo
+	struct odm_packet_info *pPktinfo
 )
 {
 
@@ -438,7 +438,7 @@ void ODM_PhyStatusQuery(
 	PDM_ODM_T pDM_Odm,
 	PODM_PHY_INFO_T pPhyInfo,
 	u8 *pPhyStatus,
-	PODM_PACKET_INFO_T pPktinfo
+	struct odm_packet_info *pPktinfo
 )
 {
 
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
index f029922d12f0..ff0373eba495 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
@@ -133,7 +133,7 @@ void ODM_PhyStatusQuery(
 	PDM_ODM_T pDM_Odm,
 	PODM_PHY_INFO_T pPhyInfo,
 	u8 *pPhyStatus,
-	PODM_PACKET_INFO_T pPktinfo
+	struct odm_packet_info *pPktinfo
 );
 
 HAL_STATUS ODM_ConfigRFWithTxPwrTrackHeaderFile(PDM_ODM_T pDM_Odm);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 7a294102b63b..6280a2e21dc2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -97,45 +97,48 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	u8 *rx_bssid;
 	u8 *rx_ra;
 	u8 *my_hwaddr;
-
-	ODM_PACKET_INFO_T pkt_info;
 	u8 *sa = NULL;
+
+	struct odm_packet_info pkt_info = {
+		.data_rate   = 0x00,
+		.station_id  = 0x00,
+		.bssid_match = false,
+		.to_self     = false,
+		.is_beacon   = false,
+	};
+
 	/* _irqL		irqL; */
 	struct sta_priv *pstapriv;
 	struct sta_info *psta;
 
-	pkt_info.bPacketMatchBSSID = false;
-	pkt_info.bPacketToSelf = false;
-	pkt_info.bPacketBeacon = false;
-
 	wlanhdr = get_recvframe_data(precvframe);
 	my_bssid = get_bssid(&padapter->mlmepriv);
 	rx_bssid = get_hdr_bssid(wlanhdr);
-	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
-				      !pattrib->icv_err && !pattrib->crc_err &&
-				      !ether_addr_equal(rx_bssid, my_bssid));
+	pkt_info.bssid_match = ((!IsFrameTypeCtrl(wlanhdr)) &&
+				!pattrib->icv_err && !pattrib->crc_err &&
+				!ether_addr_equal(rx_bssid, my_bssid));
 
 	rx_ra = get_ra(wlanhdr);
 	my_hwaddr = myid(&padapter->eeprompriv);
-	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
+	pkt_info.to_self = pkt_info.bssid_match &&
 		!ether_addr_equal(rx_ra, my_hwaddr);
 
 
-	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
+	pkt_info.is_beacon = pkt_info.bssid_match &&
 		(GetFrameSubType(wlanhdr) == WIFI_BEACON);
 
 	sa = get_ta(wlanhdr);
 
-	pkt_info.StationID = 0xFF;
+	pkt_info.station_id = 0xFF;
 
 	pstapriv = &padapter->stapriv;
 	psta = rtw_get_stainfo(pstapriv, sa);
 	if (psta) {
-		pkt_info.StationID = psta->mac_id;
+		pkt_info.station_id = psta->mac_id;
 		/* DBG_8192C("%s ==> StationID(%d)\n",
-		 * 	  __func__, pkt_info.StationID); */
+		 * 	  __func__, pkt_info.station_id); */
 	}
-	pkt_info.DataRate = pattrib->data_rate;
+	pkt_info.data_rate = pattrib->data_rate;
 
 	/* rtl8723b_query_rx_phy_status(precvframe, pphy_status); */
 	/* spin_lock_bh(&p_hal_data->odm_stainfo_lock); */
@@ -146,14 +149,14 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	/* spin_unlock_bh(&p_hal_data->odm_stainfo_lock); */
 	precvframe->u.hdr.psta = NULL;
 	if (
-		pkt_info.bPacketMatchBSSID &&
+		pkt_info.bssid_match &&
 		(check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)
 	) {
 		if (psta) {
 			precvframe->u.hdr.psta = psta;
 			rtl8723b_process_phy_info(padapter, precvframe);
 		}
-	} else if (pkt_info.bPacketToSelf || pkt_info.bPacketBeacon) {
+	} else if (pkt_info.to_self || pkt_info.is_beacon) {
 		u32 adhoc_state = WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE;
 		if (check_fwstate(&padapter->mlmepriv, adhoc_state))
 			if (psta)
-- 
2.16.3
