Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C0AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E79208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEhcxO+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E79208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGPTeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40428 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbeGPTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so30750359edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4jaGcCkEPp+Te13nAC3ifhnoeiGwlR8CxXPnKFSYj4=;
        b=rEhcxO+/2qWcKo0sl6iyOAc97evbKQTDX8dXGP/jTHCxrWgZ8Ks1vKk0YaEmpbMsbb
         oGLFTX0iu2p+lNRF4NT6PT7A2gu73gXh0nKnvwv9mYAu5YfZo2jpwHDVxq5my/FyMd/0
         5i3TgfeFRAC9OYaOfn1ennZLyWKDeWYHCl1e/bI1V2U/Kg5mFTk1J7r6fETkmub6mLqt
         UgNpzMO33YTjpUMbiHHkdoXdZTxWUUeoB0CxfKgqC/5jFNGcdAcnvWTW/NxAwZUCqhN2
         SXSyCSs30b05KF5xdfyvzX2ft/JaE6o+iajL8aKjGZJLeoHqmw5SJOKbV9Et/40AB+JC
         e2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4jaGcCkEPp+Te13nAC3ifhnoeiGwlR8CxXPnKFSYj4=;
        b=uND8FOHVVydQb4W6jNStcOL7vSflucgqba58pYnN2IsP/S/9xMz7YQ+i2OHE/NfXSD
         wq4Us8Knzy1vSE7ApLfQV3YzrkdDUcI6eJt9yh55rFvV6tfaR6R8KkOe4z32Y3Ts5Z8i
         V9ub3t5/xrwoobrA8EfvwB/mL2IS3Ab2/2eMDxNT3CJAg4Q8V8nu2Uj9TNel0Os0mo6o
         z0VxY5NHyZ9LNaWH6V0Fona0QcKnhnPstpXfXUY5l+0TpSKHKPZoZz0kFv6E8UtZE2Ss
         pq0z8IenNlO+7xDDnEC4QwO0Ne7AfifIMGbHrwl+dCK1q0JAvzmDYV7Ms4+2VNCG/gsY
         2+sA==
X-Gm-Message-State: AOUpUlEYvLlObLWMc6XTtsF/gSgpR/GRw/mhqCaou3cwhcM1q6yyJ2Ch
        veU7hHfVb9Y+k+J/SNBaT55n1g==
X-Google-Smtp-Source: AAOMgpeNU5066XzCCwcBrvI0vIvbYMfTjUuR/KAxDloRR4BgsTNLc+mPXIjXoyZouu4kg/yLIi7iVA==
X-Received: by 2002:aa7:d5d2:: with SMTP id d18-v6mr18791045eds.130.1531767926683;
        Mon, 16 Jul 2018 12:05:26 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:25 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/10] staging:rtl8192u: remove typedef of struct TS_COMMON_INFO - Style
Date:   Mon, 16 Jul 2018 20:04:46 +0100
Message-Id: <20180716190454.31489-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To clear a checkpatch issue removed the typedef of the structure
TS_COMMON_INFO.

This change removes the previous declaration, which defined two types, both
TS_COMMON_INFO and a pointer type PTS_COMMON_INFO:

typedef struct _TS_COMMON_INFO {
	...
} TS_COMMON_INFO, *PTS_COMMON_INFO;

The pointer type has been completely removed from the code, as:
"(so-called Hungarian notation) is brain damaged" according to the coding
standard.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  4 ++--
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c |  4 ++--
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  4 ++--
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 10 ++++----
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  8 +++----
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 24 +++++++++----------
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index e65c9967b627..bb4bb68bb3dd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2391,7 +2391,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
 void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
 		 u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct ieee80211_device *ieee,
-		 PTS_COMMON_INFO pTsCommonInfo, enum tr_select TxRxSelect);
+		 struct ts_common_info *pTsCommonInfo, enum tr_select TxRxSelect);
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
@@ -2399,7 +2399,7 @@ void ResetBaEntry(PBA_RECORD pBA);
 //function in TS.c
 bool GetTs(
 	struct ieee80211_device		*ieee,
-	PTS_COMMON_INFO                 *ppTS,
+	struct ts_common_info           **ppTS,
 	u8                              *Addr,
 	u8                              TID,
 	enum tr_select                  TxRxSelect,  //Rx:1, Tx:0
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 172165f4461a..a84de8c52a2b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1021,7 +1021,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 			//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): QOS ENABLE AND RECEIVE QOS DATA , we will get Ts, tid:%d\n",__func__, tid);
 		if(GetTs(
 				ieee,
-				(PTS_COMMON_INFO *) &pRxTS,
+				(struct ts_common_info **) &pRxTS,
 				hdr->addr2,
 				Frame_QoSTID((u8 *)(skb->data)),
 				RX_DIR,
@@ -1266,7 +1266,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 	{
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee,(PTS_COMMON_INFO *) &pTS,hdr->addr2,TID,RX_DIR,true);
+		GetTs(ieee,(struct ts_common_info **) &pTS,hdr->addr2,TID,RX_DIR,true);
 		if (TID !=0 && TID !=3)
 		{
 			ieee->bis_any_nonbepkts = true;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 9a1a84548bc6..010b53b45825 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -330,7 +330,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 	}
 	if(pHTInfo->bCurrentAMPDUEnable)
 	{
-		if (!GetTs(ieee, (PTS_COMMON_INFO *)(&pTxTs), hdr->addr1, skb->priority, TX_DIR, true))
+		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1, skb->priority, TX_DIR, true))
 		{
 			printk("===>can't get TS\n");
 			return;
@@ -585,7 +585,7 @@ static void ieee80211_query_seqnum(struct ieee80211_device *ieee,
 	if (IsQoSDataFrame(skb->data)) //we deal qos data only
 	{
 		PTX_TS_RECORD pTS = NULL;
-		if (!GetTs(ieee, (PTS_COMMON_INFO *)(&pTS), dst, skb->priority, TX_DIR, true))
+		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priority, TX_DIR, true))
 		{
 			return;
 		}
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 04779da803e4..950f827a1740 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -360,7 +360,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	// If there is no matched TS, reject the ADDBA request.
 	if (!GetTs(
 			ieee,
-			(PTS_COMMON_INFO *)(&pTS),
+			(struct ts_common_info **)(&pTS),
 			dst,
 			(u8)(pBaParamSet->field.TID),
 			RX_DIR,
@@ -459,7 +459,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	//
 	if (!GetTs(
 			ieee,
-			(PTS_COMMON_INFO *)(&pTS),
+			(struct ts_common_info **)(&pTS),
 			dst,
 			(u8)(pBaParamSet->field.TID),
 			TX_DIR,
@@ -570,7 +570,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 		if (!GetTs(
 				ieee,
-				(PTS_COMMON_INFO *)&pRxTs,
+				(struct ts_common_info **)&pRxTs,
 				dst,
 				(u8)pDelBaParamSet->field.TID,
 				RX_DIR,
@@ -585,7 +585,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 		if (!GetTs(
 			ieee,
-			(PTS_COMMON_INFO *)&pTxTs,
+			(struct ts_common_info **)&pTxTs,
 			dst,
 			(u8)pDelBaParamSet->field.TID,
 			TX_DIR,
@@ -638,7 +638,7 @@ TsInitAddBA(
 }
 
 void
-TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, enum tr_select TxRxSelect)
+TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo, enum tr_select TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
 		PTX_TS_RECORD	pTxTs = (PTX_TS_RECORD)pTsCommonInfo;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index c6a5ac1e647c..5d2fb52a8072 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -15,7 +15,7 @@ enum tr_select {
 	RX_DIR = 1,
 };
 
-typedef struct _TS_COMMON_INFO {
+struct ts_common_info {
 	struct list_head		List;
 	struct timer_list		SetupTimer;
 	struct timer_list		InactTimer;
@@ -24,10 +24,10 @@ typedef struct _TS_COMMON_INFO {
 	QOS_TCLAS			TClass[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
-} TS_COMMON_INFO, *PTS_COMMON_INFO;
+};
 
 typedef struct _TX_TS_RECORD {
-	TS_COMMON_INFO		TsCommonInfo;
+	struct ts_common_info		TsCommonInfo;
 	u16				TxCurSeq;
 	BA_RECORD			TxPendingBARecord;	/*  For BA Originator */
 	BA_RECORD			TxAdmittedBARecord;	/*  For BA Originator */
@@ -40,7 +40,7 @@ typedef struct _TX_TS_RECORD {
 } TX_TS_RECORD, *PTX_TS_RECORD;
 
 typedef struct _RX_TS_RECORD {
-	TS_COMMON_INFO		TsCommonInfo;
+	struct ts_common_info		TsCommonInfo;
 	u16				RxIndicateSeq;
 	u16				RxTimeoutIndicateSeq;
 	struct list_head		RxPendingPktList;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index d6ba9201028f..fd3347dca025 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -101,7 +101,7 @@ static void TsAddBaProcess(struct timer_list *t)
 }
 
 
-static void ResetTsCommonInfo(PTS_COMMON_INFO pTsCommonInfo)
+static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->Addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(TSPEC_BODY));
@@ -191,7 +191,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 }
 
 static void AdmitTS(struct ieee80211_device *ieee,
-		    PTS_COMMON_INFO pTsCommonInfo, u32 InactTime)
+		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
 {
 	del_timer_sync(&pTsCommonInfo->SetupTimer);
 	del_timer_sync(&pTsCommonInfo->InactTimer);
@@ -202,15 +202,15 @@ static void AdmitTS(struct ieee80211_device *ieee,
 }
 
 
-static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
-					   u8 *Addr, u8 TID,
-					   enum tr_select TxRxSelect)
+static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
+						  u8 *Addr, u8 TID,
+						  enum tr_select TxRxSelect)
 {
 	//DIRECTION_VALUE	dir;
 	u8	dir;
 	bool				search_dir[4] = {0};
 	struct list_head		*psearch_list; //FIXME
-	PTS_COMMON_INFO	pRet = NULL;
+	struct ts_common_info	*pRet = NULL;
 	if(ieee->iw_mode == IW_MODE_MASTER) { //ap mode
 		if(TxRxSelect == TX_DIR) {
 			search_dir[DIR_DOWN] = true;
@@ -264,7 +264,7 @@ static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
 		return NULL;
 }
 
-static void MakeTSEntry(PTS_COMMON_INFO pTsCommonInfo, u8 *Addr,
+static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 			PTSPEC_BODY pTSPEC, PQOS_TCLAS pTCLAS, u8 TCLAS_Num,
 			u8 TCLAS_Proc)
 {
@@ -288,7 +288,7 @@ static void MakeTSEntry(PTS_COMMON_INFO pTsCommonInfo, u8 *Addr,
 
 bool GetTs(
 	struct ieee80211_device		*ieee,
-	PTS_COMMON_INFO			*ppTS,
+	struct ts_common_info		**ppTS,
 	u8				*Addr,
 	u8				TID,
 	enum tr_select			TxRxSelect,  //Rx:1, Tx:0
@@ -371,7 +371,7 @@ bool GetTs(
 								((TxRxSelect==TX_DIR)?DIR_UP:DIR_DOWN);
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
 			if(!list_empty(pUnusedList)) {
-				(*ppTS) = list_entry(pUnusedList->next, TS_COMMON_INFO, List);
+				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, List);
 				list_del_init(&(*ppTS)->List);
 				if(TxRxSelect==TX_DIR) {
 					PTX_TS_RECORD tmp = container_of(*ppTS, TX_TS_RECORD, TsCommonInfo);
@@ -407,7 +407,7 @@ bool GetTs(
 	}
 }
 
-static void RemoveTsEntry(struct ieee80211_device *ieee, PTS_COMMON_INFO pTs,
+static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *pTs,
 			  enum tr_select TxRxSelect)
 {
 	//u32 flags = 0;
@@ -454,7 +454,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, PTS_COMMON_INFO pTs,
 
 void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 {
-	PTS_COMMON_INFO	pTS, pTmpTS;
+	struct ts_common_info	*pTS, *pTmpTS;
 
 	printk("===========>RemovePeerTS,%pM\n", Addr);
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
@@ -493,7 +493,7 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 
 void RemoveAllTS(struct ieee80211_device *ieee)
 {
-	PTS_COMMON_INFO pTS, pTmpTS;
+	struct ts_common_info *pTS, *pTmpTS;
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
 		RemoveTsEntry(ieee, pTS, TX_DIR);
-- 
2.18.0

