Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17753208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fanqtr4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17753208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGMU3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45110 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbeGMU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so13557669wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wGQ9c/FJm/IOKLQ5GJNd9aJ7NSDiQp59KSTSmI8//Pw=;
        b=Fanqtr4XXWEfy4Ie3sgt3ggYnekeM67DxkdNTzV9IHhvk6Wlc+zPxtyptDhlXFLDVZ
         XKwTRhmUmyydiNeqaDWizpO7V3p/SSp2E9S6YvBPhbmxiWpwu6YGId5/rlLnQaF7d4Rp
         H8MZClKTvn3DjQWUcO8IHhTe18jflgdZZZLH9Wtqj/1BdfliQF/vfB26SLHyGHgyBZZj
         of2k9S4FcapIKIBLzZFRpporVL9LpzhHBlWhoQIhVqvS1SFVql8Hn04tHCJxmyXx6zQb
         ZssA00ITUcbPQsrnQS9/lYi5CUbGiOQnPDGI4YvTQk/p/GEfcvvdPQcwZ/fbkH8B+3ci
         BOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wGQ9c/FJm/IOKLQ5GJNd9aJ7NSDiQp59KSTSmI8//Pw=;
        b=bZvidInRFuUhGvBpig/GIaiDXFmWdYNf6qGOAUaB2GkkWMJoJh52jzi+j3AyZijyqW
         8hPKDrm230BwutB0/u92wzURZsGOoWvP1ooxLipAnEvxIQ8DQkU9l7LrgZv9Q59CFArW
         pC1+F0Oc1B0pAC8v6CovtA3FRVTm+XcJ3XdCEjTAd3ug5W+aqf27F+UFo59cfq3jEAO9
         q1vuhW+vHU7TNW7BWNm9OBaGqfBTxTtQoJLdfPCNt9D8P2w2i7Rv0VmhkFfw6kkj+OgW
         3CIY1K0zYHgyaOp5uOuKu5Gdc0vpdcROj1l/H2S+vwE1MMtUxZAHNObP+u2eHzJj45Or
         WpjA==
X-Gm-Message-State: AOUpUlEbn2l2qwyriLR9a+6oCNYsLkYyqvXGLztdkVQ3kSBPQMSJJDEo
        HuhZYyAR0rmRvl8ETNcEAc6zn7C1
X-Google-Smtp-Source: AAOMgpd/IFE9wWKPjtQiuIlPQlW6HXzVuzYRZ6mqOWJOfzkulWJmqfPxm2/habsY4uzUNNrgDk1Tfg==
X-Received: by 2002:adf:e584:: with SMTP id l4-v6mr5510523wrm.190.1531512807696;
        Fri, 13 Jul 2018 13:13:27 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:27 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/10] staging:rtl8192u: remove typedef of struct TS_COMMON_INFO - Style
Date:   Fri, 13 Jul 2018 21:12:39 +0100
Message-Id: <20180713201247.21428-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
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
index 0fa55af7060a..f4e1c9655fa0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2391,7 +2391,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb);
 void TsInitAddBA(struct ieee80211_device *ieee, PTX_TS_RECORD pTS,
 		 u8 Policy, u8 bOverwritePending);
 void TsInitDelBA(struct ieee80211_device *ieee,
-		 PTS_COMMON_INFO pTsCommonInfo, enum TR_SELECT TxRxSelect);
+		 struct TS_COMMON_INFO *pTsCommonInfo, enum TR_SELECT TxRxSelect);
 void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
@@ -2399,7 +2399,7 @@ void ResetBaEntry(PBA_RECORD pBA);
 //function in TS.c
 bool GetTs(
 	struct ieee80211_device		*ieee,
-	PTS_COMMON_INFO                 *ppTS,
+	struct TS_COMMON_INFO           **ppTS,
 	u8                              *Addr,
 	u8                              TID,
 	enum TR_SELECT                  TxRxSelect,  //Rx:1, Tx:0
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 172165f4461a..55563d0a7ae0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1021,7 +1021,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 			//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): QOS ENABLE AND RECEIVE QOS DATA , we will get Ts, tid:%d\n",__func__, tid);
 		if(GetTs(
 				ieee,
-				(PTS_COMMON_INFO *) &pRxTS,
+				(struct TS_COMMON_INFO **) &pRxTS,
 				hdr->addr2,
 				Frame_QoSTID((u8 *)(skb->data)),
 				RX_DIR,
@@ -1266,7 +1266,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 	{
 		TID = Frame_QoSTID(skb->data);
 		SeqNum = WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee,(PTS_COMMON_INFO *) &pTS,hdr->addr2,TID,RX_DIR,true);
+		GetTs(ieee,(struct TS_COMMON_INFO **) &pTS,hdr->addr2,TID,RX_DIR,true);
 		if (TID !=0 && TID !=3)
 		{
 			ieee->bis_any_nonbepkts = true;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 9a1a84548bc6..d7a6ab5742a7 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -330,7 +330,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 	}
 	if(pHTInfo->bCurrentAMPDUEnable)
 	{
-		if (!GetTs(ieee, (PTS_COMMON_INFO *)(&pTxTs), hdr->addr1, skb->priority, TX_DIR, true))
+		if (!GetTs(ieee, (struct TS_COMMON_INFO **)(&pTxTs), hdr->addr1, skb->priority, TX_DIR, true))
 		{
 			printk("===>can't get TS\n");
 			return;
@@ -585,7 +585,7 @@ static void ieee80211_query_seqnum(struct ieee80211_device *ieee,
 	if (IsQoSDataFrame(skb->data)) //we deal qos data only
 	{
 		PTX_TS_RECORD pTS = NULL;
-		if (!GetTs(ieee, (PTS_COMMON_INFO *)(&pTS), dst, skb->priority, TX_DIR, true))
+		if (!GetTs(ieee, (struct TS_COMMON_INFO **)(&pTS), dst, skb->priority, TX_DIR, true))
 		{
 			return;
 		}
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 07d64ae12fdd..6434ba47e5cb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -360,7 +360,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	// If there is no matched TS, reject the ADDBA request.
 	if (!GetTs(
 			ieee,
-			(PTS_COMMON_INFO *)(&pTS),
+			(struct TS_COMMON_INFO **)(&pTS),
 			dst,
 			(u8)(pBaParamSet->field.TID),
 			RX_DIR,
@@ -459,7 +459,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	//
 	if (!GetTs(
 			ieee,
-			(PTS_COMMON_INFO *)(&pTS),
+			(struct TS_COMMON_INFO **)(&pTS),
 			dst,
 			(u8)(pBaParamSet->field.TID),
 			TX_DIR,
@@ -570,7 +570,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 		if (!GetTs(
 				ieee,
-				(PTS_COMMON_INFO *)&pRxTs,
+				(struct TS_COMMON_INFO **)&pRxTs,
 				dst,
 				(u8)pDelBaParamSet->field.TID,
 				RX_DIR,
@@ -585,7 +585,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 		if (!GetTs(
 			ieee,
-			(PTS_COMMON_INFO *)&pTxTs,
+			(struct TS_COMMON_INFO **)&pTxTs,
 			dst,
 			(u8)pDelBaParamSet->field.TID,
 			TX_DIR,
@@ -638,7 +638,7 @@ TsInitAddBA(
 }
 
 void
-TsInitDelBA(struct ieee80211_device *ieee, PTS_COMMON_INFO pTsCommonInfo, enum TR_SELECT TxRxSelect)
+TsInitDelBA(struct ieee80211_device *ieee, struct TS_COMMON_INFO *pTsCommonInfo, enum TR_SELECT TxRxSelect)
 {
 	if (TxRxSelect == TX_DIR) {
 		PTX_TS_RECORD	pTxTs = (PTX_TS_RECORD)pTsCommonInfo;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 3a5347818718..39ce5d89883f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -15,7 +15,7 @@ enum TR_SELECT {
 	RX_DIR = 1,
 };
 
-typedef struct _TS_COMMON_INFO {
+struct TS_COMMON_INFO {
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
+	struct TS_COMMON_INFO		TsCommonInfo;
 	u16				TxCurSeq;
 	BA_RECORD			TxPendingBARecord;	/*  For BA Originator */
 	BA_RECORD			TxAdmittedBARecord;	/*  For BA Originator */
@@ -40,7 +40,7 @@ typedef struct _TX_TS_RECORD {
 } TX_TS_RECORD, *PTX_TS_RECORD;
 
 typedef struct _RX_TS_RECORD {
-	TS_COMMON_INFO		TsCommonInfo;
+	struct TS_COMMON_INFO		TsCommonInfo;
 	u16				RxIndicateSeq;
 	u16				RxTimeoutIndicateSeq;
 	struct list_head		RxPendingPktList;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 75d269a7bf09..a3bcb15037af 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -101,7 +101,7 @@ static void TsAddBaProcess(struct timer_list *t)
 }
 
 
-static void ResetTsCommonInfo(PTS_COMMON_INFO pTsCommonInfo)
+static void ResetTsCommonInfo(struct TS_COMMON_INFO *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->Addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(TSPEC_BODY));
@@ -191,7 +191,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 }
 
 static void AdmitTS(struct ieee80211_device *ieee,
-		    PTS_COMMON_INFO pTsCommonInfo, u32 InactTime)
+		    struct TS_COMMON_INFO *pTsCommonInfo, u32 InactTime)
 {
 	del_timer_sync(&pTsCommonInfo->SetupTimer);
 	del_timer_sync(&pTsCommonInfo->InactTimer);
@@ -202,15 +202,15 @@ static void AdmitTS(struct ieee80211_device *ieee,
 }
 
 
-static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
-					   u8 *Addr, u8 TID,
-					   enum TR_SELECT TxRxSelect)
+static struct TS_COMMON_INFO *SearchAdmitTRStream(struct ieee80211_device *ieee,
+						  u8 *Addr, u8 TID,
+						  enum TR_SELECT TxRxSelect)
 {
 	//DIRECTION_VALUE	dir;
 	u8	dir;
 	bool				search_dir[4] = {0};
 	struct list_head		*psearch_list; //FIXME
-	PTS_COMMON_INFO	pRet = NULL;
+	struct TS_COMMON_INFO	*pRet = NULL;
 	if(ieee->iw_mode == IW_MODE_MASTER) { //ap mode
 		if(TxRxSelect == TX_DIR) {
 			search_dir[DIR_DOWN] = true;
@@ -264,7 +264,7 @@ static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
 		return NULL;
 }
 
-static void MakeTSEntry(PTS_COMMON_INFO pTsCommonInfo, u8 *Addr,
+static void MakeTSEntry(struct TS_COMMON_INFO *pTsCommonInfo, u8 *Addr,
 			PTSPEC_BODY pTSPEC, PQOS_TCLAS pTCLAS, u8 TCLAS_Num,
 			u8 TCLAS_Proc)
 {
@@ -288,7 +288,7 @@ static void MakeTSEntry(PTS_COMMON_INFO pTsCommonInfo, u8 *Addr,
 
 bool GetTs(
 	struct ieee80211_device		*ieee,
-	PTS_COMMON_INFO			*ppTS,
+	struct TS_COMMON_INFO		**ppTS,
 	u8				*Addr,
 	u8				TID,
 	enum TR_SELECT			TxRxSelect,  //Rx:1, Tx:0
@@ -371,7 +371,7 @@ bool GetTs(
 								((TxRxSelect==TX_DIR)?DIR_UP:DIR_DOWN);
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
 			if(!list_empty(pUnusedList)) {
-				(*ppTS) = list_entry(pUnusedList->next, TS_COMMON_INFO, List);
+				(*ppTS) = list_entry(pUnusedList->next, struct TS_COMMON_INFO, List);
 				list_del_init(&(*ppTS)->List);
 				if(TxRxSelect==TX_DIR) {
 					PTX_TS_RECORD tmp = container_of(*ppTS, TX_TS_RECORD, TsCommonInfo);
@@ -407,7 +407,7 @@ bool GetTs(
 	}
 }
 
-static void RemoveTsEntry(struct ieee80211_device *ieee, PTS_COMMON_INFO pTs,
+static void RemoveTsEntry(struct ieee80211_device *ieee, struct TS_COMMON_INFO *pTs,
 			  enum TR_SELECT TxRxSelect)
 {
 	//u32 flags = 0;
@@ -454,7 +454,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, PTS_COMMON_INFO pTs,
 
 void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 {
-	PTS_COMMON_INFO	pTS, pTmpTS;
+	struct TS_COMMON_INFO	*pTS, *pTmpTS;
 
 	printk("===========>RemovePeerTS,%pM\n", Addr);
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
@@ -493,7 +493,7 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 
 void RemoveAllTS(struct ieee80211_device *ieee)
 {
-	PTS_COMMON_INFO pTS, pTmpTS;
+	struct TS_COMMON_INFO *pTS, *pTmpTS;
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
 		RemoveTsEntry(ieee, pTS, TX_DIR);
-- 
2.18.0

