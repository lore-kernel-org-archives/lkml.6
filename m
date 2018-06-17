Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C15DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CD8208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CD8208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeFQVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:11:07 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:45951 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751032AbeFQVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:11:04 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2018 17:11:04 EDT
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 7663658C4C9;
        Sun, 17 Jun 2018 23:02:43 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Sun, 17 Jun 2018 23:02:43 +0200
From:   =?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     maximilian.o.ott@fau.de, linux-kernel@i4.cs.fau.de,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        julia.lawall@lip6.fr, georgiana.chelu93@gmail.com,
        dafna3@gmail.com, keescook@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@fau.de>
Subject: [PATCH 2/2] rtl8192u/rtl819x_BAProc.c: Adjust spaces to coding guidelines
Date:   Sun, 17 Jun 2018 23:02:31 +0200
Message-Id: <1529269351-21941-3-git-send-email-fabian.blaese@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529269351-21941-1-git-send-email-fabian.blaese@fau.de>
References: <1529269351-21941-1-git-send-email-fabian.blaese@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves spacing according to the coding guidelines,
mainly around braces.

This patch fixes errors reported by checkpatch.

Signed-off-by: Fabian Bläse <fabian.blaese@fau.de>
Signed-off-by: Maximilian Ott <maximilian.o.ott@fau.de>
---
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    | 71 ++++++++++------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 86c7357..2dc4d0e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -19,7 +19,7 @@
 static void ActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA, u16 Time)
 {
 	pBA->bValid = true;
-	if(Time != 0)
+	if (Time != 0)
 		mod_timer(&pBA->Timer, jiffies + msecs_to_jiffies(Time));
 }
 
@@ -117,13 +117,13 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pBA is NULL\n");
 		return NULL;
 	}
-	skb = dev_alloc_skb(len + sizeof( struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
+	skb = dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
 	if (!skb) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc skb for ADDBA_REQ\n");
 		return NULL;
 	}
 
-	memset(skb->data, 0, sizeof( struct rtl_80211_hdr_3addr));	//I wonder whether it's necessary. Apparently kernel will not do it when alloc a skb.
+	memset(skb->data, 0, sizeof(struct rtl_80211_hdr_3addr));	//I wonder whether it's necessary. Apparently kernel will not do it when alloc a skb.
 	skb_reserve(skb, ieee->tx_headroom);
 
 	BAReq = skb_put(skb, sizeof(struct rtl_80211_hdr_3addr));
@@ -137,10 +137,10 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, P
 
 	//tag += sizeof( struct rtl_80211_hdr_3addr); //move to action field
 	tag = skb_put(skb, 9);
-	*tag ++= ACT_CAT_BA;
-	*tag ++= type;
+	*tag++ = ACT_CAT_BA;
+	*tag++ = type;
 	// Dialog Token
-	*tag ++= pBA->DialogToken;
+	*tag++ = pBA->DialogToken;
 
 	if (ACT_ADDBARSP == type) {
 		// Status Code
@@ -201,10 +201,10 @@ static struct sk_buff *ieee80211_DELBA(
 
 	memset(&DelbaParamSet, 0, 2);
 
-	DelbaParamSet.field.Initiator	= (TxRxSelect==TX_DIR)?1:0;
+	DelbaParamSet.field.Initiator	= (TxRxSelect == TX_DIR) ? 1 : 0;
 	DelbaParamSet.field.TID	= pBA->BaParamSet.field.TID;
 
-	skb = dev_alloc_skb(len + sizeof( struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
+	skb = dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need to add something others? FIXME
 	if (!skb) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc skb for ADDBA_REQ\n");
 		return NULL;
@@ -221,8 +221,8 @@ static struct sk_buff *ieee80211_DELBA(
 
 	tag = skb_put(skb, 6);
 
-	*tag ++= ACT_CAT_BA;
-	*tag ++= ACT_DELBA;
+	*tag++ = ACT_CAT_BA;
+	*tag++ = ACT_DELBA;
 
 	// DELBA Parameter Set
 
@@ -258,8 +258,7 @@ static void ieee80211_send_ADDBAReq(struct ieee80211_device *ieee,
 		//add statistic needed here.
 		//and skb will be freed in softmac_mgmt_xmit(), so omit all dev_kfree_skb_any() outside softmac_mgmt_xmit()
 		//WB
-	}
-	else {
+	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "alloc skb error in function %s()\n", __func__);
 	}
 }
@@ -280,8 +279,7 @@ static void ieee80211_send_ADDBARsp(struct ieee80211_device *ieee, u8 *dst,
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
 		//same above
-	}
-	else {
+	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "alloc skb error in function %s()\n", __func__);
 	}
 
@@ -307,8 +305,7 @@ static void ieee80211_send_DELBA(struct ieee80211_device *ieee, u8 *dst,
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
 		//same above
-	}
-	else {
+	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "alloc skb error in function %s()\n", __func__);
 	}
 }
@@ -367,7 +364,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 			dst,
 			(u8)(pBaParamSet->field.TID),
 			RX_DIR,
-			true)	) {
+			true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't get TS in %s()\n", __func__);
 		goto OnADDBAReq_Fail;
@@ -450,7 +447,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	if (ieee->current_network.qos_data.active == 0  ||
 	    !ieee->pHTInfo->bCurrentHTSupport ||
 	    !ieee->pHTInfo->bCurrentAMPDUEnable) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",ieee->current_network.qos_data.active, ieee->pHTInfo->bCurrentHTSupport, ieee->pHTInfo->bCurrentAMPDUEnable);
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n", ieee->current_network.qos_data.active, ieee->pHTInfo->bCurrentHTSupport, ieee->pHTInfo->bCurrentAMPDUEnable);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
@@ -466,7 +463,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 			dst,
 			(u8)(pBaParamSet->field.TID),
 			TX_DIR,
-			false)	) {
+			false)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't get TS in %s()\n", __func__);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -485,19 +482,17 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		// Since BA is already setup, we ignore all other ADDBA Response.
 		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. Drop because already admit it! \n");
 		return -1;
-	}
-	else if((!pPendingBA->bValid) ||(*pDialogToken != pPendingBA->DialogToken)) {
+	} else if ((!pPendingBA->bValid) || (*pDialogToken != pPendingBA->DialogToken)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,  "OnADDBARsp(): Recv ADDBA Rsp. BA invalid, DELBA! \n");
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
-	}
-	else {
+	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. BA is admitted! Status code:%X\n", *pStatusCode);
 		DeActivateBAEntry(ieee, pPendingBA);
 	}
 
 
-	if(*pStatusCode == ADDBA_STATUS_SUCCESS) {
+	if (*pStatusCode == ADDBA_STATUS_SUCCESS) {
 		//
 		// Determine ADDBA Rsp content here.
 		// We can compare the value of BA parameter set that Peer returned and Self sent.
@@ -521,8 +516,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		pAdmittedBA->BaParamSet = *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
 		ActivateBAEntry(ieee, pAdmittedBA, *pBaTimeoutVal);
-	}
-	else {
+	} else {
 		// Delay next ADDBA process.
 		pTS->bAddBaReqDelayed = true;
 	}
@@ -562,7 +556,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 	if (ieee->current_network.qos_data.active == 0 ||
 	    !ieee->pHTInfo->bCurrentHTSupport) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "received DELBA while QOS or HT is not supported(%d, %d)\n",ieee->current_network.qos_data.active, ieee->pHTInfo->bCurrentHTSupport);
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "received DELBA while QOS or HT is not supported(%d, %d)\n", ieee->current_network.qos_data.active, ieee->pHTInfo->bCurrentHTSupport);
 		return -1;
 	}
 
@@ -571,7 +565,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 	dst = &delba->addr2[0];
 	pDelBaParamSet = (PDELBA_PARAM_SET)&delba->payload[2];
 
-	if(pDelBaParamSet->field.Initiator == 1) {
+	if (pDelBaParamSet->field.Initiator == 1) {
 		PRX_TS_RECORD	pRxTs;
 
 		if (!GetTs(
@@ -580,14 +574,13 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 				dst,
 				(u8)pDelBaParamSet->field.TID,
 				RX_DIR,
-				false)	) {
+				false)) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR,  "can't get TS for RXTS in %s()\n", __func__);
 			return -1;
 		}
 
 		RxTsDeleteBA(ieee, pRxTs);
-	}
-	else {
+	} else {
 		PTX_TS_RECORD	pTxTs;
 
 		if (!GetTs(
@@ -596,7 +589,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 			dst,
 			(u8)pDelBaParamSet->field.TID,
 			TX_DIR,
-			false)	) {
+			false)) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR,  "can't get TS for TXTS in %s()\n", __func__);
 			return -1;
 		}
@@ -645,29 +638,27 @@ TsInitAddBA(
 }
 
 void
-TsInitDelBA( struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect)
+TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, TR_SELECT TxRxSelect)
 {
-
-	if(TxRxSelect == TX_DIR) {
+	if (TxRxSelect == TX_DIR) {
 		PTX_TS_RECORD	pTxTs = (PTX_TS_RECORD)pTsCommonInfo;
 
-		if(TxTsDeleteBA(ieee, pTxTs))
+		if (TxTsDeleteBA(ieee, pTxTs))
 			ieee80211_send_DELBA(
 				ieee,
 				pTsCommonInfo->Addr,
 				(pTxTs->TxAdmittedBARecord.bValid)?(&pTxTs->TxAdmittedBARecord):(&pTxTs->TxPendingBARecord),
 				TxRxSelect,
 				DELBA_REASON_END_BA);
-	}
-	else if(TxRxSelect == RX_DIR) {
+	} else if (TxRxSelect == RX_DIR) {
 		PRX_TS_RECORD	pRxTs = (PRX_TS_RECORD)pTsCommonInfo;
-		if(RxTsDeleteBA(ieee, pRxTs))
+		if (RxTsDeleteBA(ieee, pRxTs))
 			ieee80211_send_DELBA(
 				ieee,
 				pTsCommonInfo->Addr,
 				&pRxTs->RxAdmittedBARecord,
 				TxRxSelect,
-				DELBA_REASON_END_BA	);
+				DELBA_REASON_END_BA);
 	}
 }
 /********************************************************************************************************************
-- 
2.7.4

