Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974F5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344C520842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuFY29zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344C520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbeG0Syg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45090 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbeG0Syf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so5790754wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJv/hvbOnNWpeJznSSAsvduqrRZ7AdllQkI2LvJKQDA=;
        b=UuFY29zI5JJQp38HQ25Ed+csZILFBKisJDlMOtJh00mCQrCpsVRV3lgYvpVLQ1uEjA
         ZEQ5SG7BZS/ZC01OgWjshM/n+8wmZCKGmzlQMgw04lMIAOCKexJnVNJ3VNfWOmEuCDaS
         iVPVvjNoX/kjKI5ibHajwKxx84EfyruNO89YmwZ3r5R361rDLU3CDezjRaCVJkGEMId+
         NcwHIIm/7e0fdh3XjHRHVWsJJ5UAJfXvXN+E8oIes+qxUAQHWjoLtXrbtcoEyRs51iWw
         DPUOal8vxzwUU3QjSbfSVwL/L8BDK36JxHCatM0ObeR+86Rzv1v3eqR4/N02QkJ45hy6
         Go6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XJv/hvbOnNWpeJznSSAsvduqrRZ7AdllQkI2LvJKQDA=;
        b=TVq5ZMJf7BsV0F0rpNjc42dH7yZGbR/TBiWA7nO5lsCJewa2EUxNKyuW6pX0j0dsbl
         B8txtn+ZiYkFaC/bAwHHZCi5JYmKR99UQQGYaC4hT1wqFArNSUDp3iRKhiDbJg3D+JGW
         rQtqUOPbe4q5A3LX8a7IS7cQjwJDiaxXAZVT1qMEkv6hBnB/mCOAdsjsu55bQm1OyDgc
         6iEL30koaUZjwwXTnQRGlr3rrtRA6L2tg3KqJ/lygrWX5mJEeIpg5pvBvZe6bYtDiy4d
         625Af0/tu7aAR+i/D/zuC91qW2rBYijMQAmqdN0t+4uaSuuInGTKZPYQGoz4ZPYxmpr5
         14iw==
X-Gm-Message-State: AOUpUlE7bvtIqVlOTlYXDUcNSXpiHr+wLYj6M0ScA6LtwDcxErVik6yG
        p5OsUTdBqGmY/Lm3HKCxp4kY6XSXBgQ=
X-Google-Smtp-Source: AAOMgpfEcDMst3A/mWHo8ihqdRb/2PxjCmNMlY6EWW6eQqEnZYzLPq/ZblTjFz+1ozwNj3wXaM1oAg==
X-Received: by 2002:adf:fc86:: with SMTP id g6-v6mr5598070wrr.216.1532712700307;
        Fri, 27 Jul 2018 10:31:40 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:39 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/20] staging:rtl8192u: Remove typedef and rename TX_TS_RECORD - Style
Date:   Fri, 27 Jul 2018 18:31:04 +0100
Message-Id: <20180727173123.27391-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typdef from structure TX_TS_RECORD and rename to tx_ts_record.
The removal of the typedef clears the checkpatch issue with creating new
types in code. The name change, whilst not specifically flagged by
checkpatch, is an issue since types are meant to be named in lowercase.

These changes are purely coding style changes and should have no impact
on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  6 +++---
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  4 ++--
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 20 +++++++++----------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  4 ++--
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 16 +++++++--------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index bb4bb68bb3dd..aecb697f3729 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1646,7 +1646,7 @@ struct ieee80211_device {
 	struct list_head		Tx_TS_Admit_List;
 	struct list_head		Tx_TS_Pending_List;
 	struct list_head		Tx_TS_Unused_List;
-	TX_TS_RECORD		TxTsRecord[TOTAL_TS_NUM];
+	struct tx_ts_record		TxTsRecord[TOTAL_TS_NUM];
 	// 802.11e and WMM Traffic Stream Info (RX)
 	struct list_head		Rx_TS_Admit_List;
 	struct list_head		Rx_TS_Pending_List;
@@ -2388,7 +2388,7 @@ u16 TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate);
 int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb);
 int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb);
 int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
-void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
+void TsInitAddBA(struct ieee80211_device *ieee, struct tx_ts_record *pTS,
 		 u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct ieee80211_device *ieee,
 		 struct ts_common_info *pTsCommonInfo, enum tr_select TxRxSelect);
@@ -2406,7 +2406,7 @@ bool GetTs(
 	bool                            bAddNewTs
 	);
 void TSInitialize(struct ieee80211_device *ieee);
-void TsStartAddBaProcess(struct ieee80211_device *ieee, PTX_TS_RECORD   pTxTS);
+void TsStartAddBaProcess(struct ieee80211_device *ieee, struct tx_ts_record   *pTxTS);
 void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr);
 void RemoveAllTS(struct ieee80211_device *ieee);
 void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 010b53b45825..142b86b393dc 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -306,7 +306,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 				       struct sk_buff *skb, struct cb_desc *tcb_desc)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-	PTX_TS_RECORD			pTxTs = NULL;
+	struct tx_ts_record        *pTxTs = NULL;
 	struct rtl_80211_hdr_1addr *hdr = (struct rtl_80211_hdr_1addr *)skb->data;
 
 	if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
@@ -584,7 +584,7 @@ static void ieee80211_query_seqnum(struct ieee80211_device *ieee,
 		return;
 	if (IsQoSDataFrame(skb->data)) //we deal qos data only
 	{
-		PTX_TS_RECORD pTS = NULL;
+		struct tx_ts_record *pTS = NULL;
 		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priority, TX_DIR, true))
 		{
 			return;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 2c7d3ab1b5f7..507014d44d54 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -36,11 +36,11 @@ static void DeActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA)
 /********************************************************************************************************************
  *function: deactivete BA entry in Tx Ts, and send DELBA.
  *   input:
- *	     PTX_TS_RECORD		pTxTs //Tx Ts which is to deactivate BA entry.
+ *	     struct tx_ts_record *pTxTs //Tx Ts which is to deactivate BA entry.
  *  output:  none
- *  notice:  As PTX_TS_RECORD structure will be defined in QOS, so wait to be merged. //FIXME
+ *  notice:  As struct tx_ts_record * structure will be defined in QOS, so wait to be merged. //FIXME
  ********************************************************************************************************************/
-static u8 TxTsDeleteBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTxTs)
+static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs)
 {
 	PBA_RECORD		pAdmittedBa = &pTxTs->TxAdmittedBARecord;  //These two BA entries must exist in TS structure
 	PBA_RECORD		pPendingBa = &pTxTs->TxPendingBARecord;
@@ -420,7 +420,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
 	 struct rtl_80211_hdr_3addr *rsp = NULL;
 	PBA_RECORD		pPendingBA, pAdmittedBA;
-	PTX_TS_RECORD		pTS = NULL;
+	struct tx_ts_record     *pTS = NULL;
 	u8 *dst = NULL, *pDialogToken = NULL, *tag = NULL;
 	u16 *pStatusCode = NULL, *pBaTimeoutVal = NULL;
 	PBA_PARAM_SET		pBaParamSet = NULL;
@@ -581,7 +581,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 		RxTsDeleteBA(ieee, pRxTs);
 	} else {
-		PTX_TS_RECORD	pTxTs;
+		struct tx_ts_record *pTxTs;
 
 		if (!GetTs(
 			ieee,
@@ -610,7 +610,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 void
 TsInitAddBA(
 	struct ieee80211_device *ieee,
-	PTX_TS_RECORD	pTS,
+	struct tx_ts_record     *pTS,
 	u8		Policy,
 	u8		bOverwritePending
 	)
@@ -641,7 +641,7 @@ void
 TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo, enum tr_select TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
-		PTX_TS_RECORD	pTxTs = (PTX_TS_RECORD)pTsCommonInfo;
+		struct tx_ts_record *pTxTs = (struct tx_ts_record *)pTsCommonInfo;
 
 		if (TxTsDeleteBA(ieee, pTxTs))
 			ieee80211_send_DELBA(
@@ -663,13 +663,13 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 }
 /********************************************************************************************************************
  *function:  BA setup timer
- *   input:  unsigned long	 data		//acturally we send TX_TS_RECORD or RX_TS_RECORD to these timer
+ *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or RX_TS_RECORD to these timer
  *  return:  NULL
  *  notice:
  ********************************************************************************************************************/
 void BaSetupTimeOut(struct timer_list *t)
 {
-	PTX_TS_RECORD	pTxTs = from_timer(pTxTs, t, TxPendingBARecord.Timer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TxPendingBARecord.Timer);
 
 	pTxTs->bAddBaReqInProgress = false;
 	pTxTs->bAddBaReqDelayed = true;
@@ -678,7 +678,7 @@ void BaSetupTimeOut(struct timer_list *t)
 
 void TxBaInactTimeout(struct timer_list *t)
 {
-	PTX_TS_RECORD	pTxTs = from_timer(pTxTs, t, TxAdmittedBARecord.Timer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TxAdmittedBARecord.Timer);
 	struct ieee80211_device *ieee = container_of(pTxTs, struct ieee80211_device, TxTsRecord[pTxTs->num]);
 	TxTsDeleteBA(ieee, pTxTs);
 	ieee80211_send_DELBA(
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 3da1ef6ef105..0f744b112dcf 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -26,7 +26,7 @@ struct ts_common_info {
 	u8				t_clas_num;
 };
 
-typedef struct _TX_TS_RECORD {
+struct tx_ts_record {
 	struct ts_common_info		TsCommonInfo;
 	u16				TxCurSeq;
 	BA_RECORD			TxPendingBARecord;	/*  For BA Originator */
@@ -37,7 +37,7 @@ typedef struct _TX_TS_RECORD {
 	u8				bUsingBa;
 	struct timer_list		TsAddBaTimer;
 	u8				num;
-} TX_TS_RECORD, *PTX_TS_RECORD;
+};
 
 typedef struct _RX_TS_RECORD {
 	struct ts_common_info		TsCommonInfo;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 4b2da7f31166..f2a5771185f0 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -19,7 +19,7 @@ static void TsInactTimeout(struct timer_list *unused)
 
 /********************************************************************************************************************
  *function:  I still not understand this function, so wait for further implementation
- *   input:  unsigned long	 data		//acturally we send TX_TS_RECORD or RX_TS_RECORD to these timer
+ *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or RX_TS_RECORD to these timer
  *  return:  NULL
  *  notice:
  ********************************************************************************************************************/
@@ -86,13 +86,13 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 /********************************************************************************************************************
  *function:  Add BA timer function
- *   input:  unsigned long	 data		//acturally we send TX_TS_RECORD or RX_TS_RECORD to these timer
+ *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or RX_TS_RECORD to these timer
  *  return:  NULL
  *  notice:
  ********************************************************************************************************************/
 static void TsAddBaProcess(struct timer_list *t)
 {
-	PTX_TS_RECORD	pTxTs = from_timer(pTxTs, t, TsAddBaTimer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TsAddBaTimer);
 	u8 num = pTxTs->num;
 	struct ieee80211_device *ieee = container_of(pTxTs, struct ieee80211_device, TxTsRecord[num]);
 
@@ -110,7 +110,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 	pTsCommonInfo->t_clas_num = 0;
 }
 
-static void ResetTxTsEntry(PTX_TS_RECORD pTS)
+static void ResetTxTsEntry(struct tx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->TsCommonInfo);
 	pTS->TxCurSeq = 0;
@@ -131,7 +131,7 @@ static void ResetRxTsEntry(PRX_TS_RECORD pTS)
 
 void TSInitialize(struct ieee80211_device *ieee)
 {
-	PTX_TS_RECORD		pTxTS  = ieee->TxTsRecord;
+	struct tx_ts_record     *pTxTS  = ieee->TxTsRecord;
 	PRX_TS_RECORD		pRxTS  = ieee->RxTsRecord;
 	PRX_REORDER_ENTRY	pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
@@ -374,7 +374,7 @@ bool GetTs(
 				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
 				list_del_init(&(*ppTS)->list);
 				if(TxRxSelect==TX_DIR) {
-					PTX_TS_RECORD tmp = container_of(*ppTS, TX_TS_RECORD, TsCommonInfo);
+					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, TsCommonInfo);
 					ResetTxTsEntry(tmp);
 				} else {
 					PRX_TS_RECORD tmp = container_of(*ppTS, RX_TS_RECORD, TsCommonInfo);
@@ -447,7 +447,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 
 //#endif
 	} else {
-		PTX_TS_RECORD pTxTS = (PTX_TS_RECORD)pTs;
+		struct tx_ts_record *pTxTS = (struct tx_ts_record *)pTs;
 		del_timer_sync(&pTxTS->TsAddBaTimer);
 	}
 }
@@ -520,7 +520,7 @@ void RemoveAllTS(struct ieee80211_device *ieee)
 	}
 }
 
-void TsStartAddBaProcess(struct ieee80211_device *ieee, PTX_TS_RECORD	pTxTS)
+void TsStartAddBaProcess(struct ieee80211_device *ieee, struct tx_ts_record *pTxTS)
 {
 	if(!pTxTS->bAddBaReqInProgress) {
 		pTxTS->bAddBaReqInProgress = true;
-- 
2.18.0

