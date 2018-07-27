Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B345C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E598C20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBGuBoK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E598C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbeG0Syu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38430 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbeG0Syt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so6266829wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/p6n/FoGqmYuTcVUZt0J97HFSsZke8uKjQ5UMe4wqvk=;
        b=OBGuBoK6G44W4YtZlnFkoaBQZULqotOVrxYpoip2ALmVfFxrA6GTyYUaj6+J3EvP9b
         MgioJ9oCicEEGUgr2p5XoaMF5ivfXFunvJiUYWz6mHtxEATS1zMG8eKV9+QeWZfCGPf9
         5EWKIpLoybBGDYB8QboYdORHXBJx69bnNuxmGkvUKootv7kHPf2dKjq+j2BMK8UpGeRi
         x28ae9lNomLufPSqa9gX7cvJNbNk5k0GqYa9YVZOG28GDPLgoiDvxxJt8Dh3ZSyov4Ip
         q40KYPNCGAqObikcqJhNvmA89N4F056rsm8GaWOwWqaY01uEa4BfCXM9cgovkCSQ5xTV
         N08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/p6n/FoGqmYuTcVUZt0J97HFSsZke8uKjQ5UMe4wqvk=;
        b=jnrypW0o7rVDeGprxh5RULORN12TyoCp1y0mZmakCHh+8wLUACWhkqkJCaZW+O09AF
         bCiIgy84NpFLzSBqsuN8Mbi5c/BHjroCKx0SFQkiUvXweAyZeDznhqy+mJB/NQnJhWzl
         B1HrcA7qGbm+AuT58WjlnETCc6di6aL+smnoWF0whQRp5Utu4VPint57ZhjrIxVgFiF2
         0DmYxHV2FDQUiuQea4k+lHF1iGAEYjtNkJ/87fdXl1u2QnG4ZYrxOicGD/3TsH+I5cVn
         Gaj8NEuazhOFr2+RUo6QhxDQEfMbrRAHDdKGuadS9BwpPWRFgkY2EX9Rf1Aebgbx5AZt
         OS5w==
X-Gm-Message-State: AOUpUlF7ZCCNZz9oSrN2lWdztjHuZkhwFCssvdQBLnUHBCY22jOO4csG
        E8GWX9J1Gq569plwmSrq8MH5oukkMZw=
X-Google-Smtp-Source: AAOMgpf0Ctiyia7s7OUuoQgOcJQyBfYLe1unCo/2oiOD5bWTxwx5VPOPV2uDhCHSofRkTwtCCY8yMg==
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr5196100wmb.16.1532712714085;
        Fri, 27 Jul 2018 10:31:54 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/20] staging:rtl8192u: Remove typedef and rename RX_TS_RECORD - Style
Date:   Fri, 27 Jul 2018 18:31:13 +0100
Message-Id: <20180727173123.27391-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef from structure RX_TS_RECORD, this change clears the
checkpatch issue with creation of new types.

Additionally the structure is renamed from RX_TS_RECORD to rx_ts_record.
Whilst this is not raised as a checkpatch error structures are meant to
be named in lower case.

These changes are coding style changes which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h   |  2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c    |  8 ++++----
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c  | 16 ++++++++--------
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h  |  4 ++--
 .../staging/rtl8192u/ieee80211/rtl819x_TSProc.c  | 14 +++++++-------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index aecb697f3729..326a1e47bade 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1651,7 +1651,7 @@ struct ieee80211_device {
 	struct list_head		Rx_TS_Admit_List;
 	struct list_head		Rx_TS_Pending_List;
 	struct list_head		Rx_TS_Unused_List;
-	RX_TS_RECORD		RxTsRecord[TOTAL_TS_NUM];
+	struct rx_ts_record		RxTsRecord[TOTAL_TS_NUM];
 //#ifdef TO_DO_LIST
 	RX_REORDER_ENTRY	RxReorderEntry[128];
 	struct list_head		RxReorder_Unused_List;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index a84de8c52a2b..037bd5dfb21a 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -508,7 +508,7 @@ static int is_duplicate_packet(struct ieee80211_device *ieee,
 	return 1;
 }
 
-static bool AddReorderEntry(PRX_TS_RECORD pTS, PRX_REORDER_ENTRY pReorderEntry)
+static bool AddReorderEntry(struct rx_ts_record *pTS, PRX_REORDER_ENTRY pReorderEntry)
 {
 	struct list_head *pList = &pTS->RxPendingPktList;
 	while(pList->next != &pTS->RxPendingPktList)
@@ -586,7 +586,7 @@ void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct ieee80211_
 
 static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 				    struct ieee80211_rxb *prxb,
-				    PRX_TS_RECORD pTS, u16 SeqNum)
+				    struct rx_ts_record *pTS, u16 SeqNum)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 	PRX_REORDER_ENTRY	pReorderEntry = NULL;
@@ -898,7 +898,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 	//added by amy for reorder
 	u8	TID = 0;
 	u16	SeqNum = 0;
-	PRX_TS_RECORD pTS = NULL;
+	struct rx_ts_record *pTS = NULL;
 	//bool bIsAggregateFrame = false;
 	//added by amy for reorder
 #ifdef NOT_YET
@@ -1017,7 +1017,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 	}
 	else
 	{
-		PRX_TS_RECORD pRxTS = NULL;
+		struct rx_ts_record *pRxTS = NULL;
 			//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): QOS ENABLE AND RECEIVE QOS DATA , we will get Ts, tid:%d\n",__func__, tid);
 		if(GetTs(
 				ieee,
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 01bf9f3488ab..c2a51a6c2969 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -64,11 +64,11 @@ static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs
 /********************************************************************************************************************
  *function: deactivete BA entry in Tx Ts, and send DELBA.
  *   input:
- *	     PRX_TS_RECORD		pRxTs //Rx Ts which is to deactivate BA entry.
+ *	     struct rx_ts_record  *pRxTs //Rx Ts which is to deactivate BA entry.
  *  output:  none
- *  notice:  As PRX_TS_RECORD structure will be defined in QOS, so wait to be merged. //FIXME, same with above
+ *  notice:  As struct rx_ts_record * structure will be defined in QOS, so wait to be merged. //FIXME, same with above
  ********************************************************************************************************************/
-static u8 RxTsDeleteBA(struct ieee80211_device *ieee, PRX_TS_RECORD pRxTs)
+static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs)
 {
 	PBA_RECORD		pBa = &pRxTs->RxAdmittedBARecord;
 	u8			bSendDELBA = false;
@@ -325,7 +325,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	PBA_PARAM_SET	pBaParamSet = NULL;
 	u16 *pBaTimeoutVal = NULL;
 	PSEQUENCE_CONTROL pBaStartSeqCtrl = NULL;
-	PRX_TS_RECORD	pTS = NULL;
+	struct rx_ts_record  *pTS = NULL;
 
 	if (skb->len < sizeof(struct rtl_80211_hdr_3addr) + 9) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,
@@ -566,7 +566,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 	pDelBaParamSet = (PDELBA_PARAM_SET)&delba->payload[2];
 
 	if (pDelBaParamSet->field.Initiator == 1) {
-		PRX_TS_RECORD	pRxTs;
+		struct rx_ts_record *pRxTs;
 
 		if (!GetTs(
 				ieee,
@@ -651,7 +651,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 				TxRxSelect,
 				DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
-		PRX_TS_RECORD	pRxTs = (PRX_TS_RECORD)pTsCommonInfo;
+		struct rx_ts_record *pRxTs = (struct rx_ts_record *)pTsCommonInfo;
 		if (RxTsDeleteBA(ieee, pRxTs))
 			ieee80211_send_DELBA(
 				ieee,
@@ -663,7 +663,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 }
 /********************************************************************************************************************
  *function:  BA setup timer
- *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or RX_TS_RECORD to these timer
+ *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or struct rx_ts_record to these timer
  *  return:  NULL
  *  notice:
  ********************************************************************************************************************/
@@ -691,7 +691,7 @@ void TxBaInactTimeout(struct timer_list *t)
 
 void RxBaInactTimeout(struct timer_list *t)
 {
-	PRX_TS_RECORD	pRxTs = from_timer(pRxTs, t, RxAdmittedBARecord.Timer);
+	struct rx_ts_record *pRxTs = from_timer(pRxTs, t, RxAdmittedBARecord.Timer);
 	struct ieee80211_device *ieee = container_of(pRxTs, struct ieee80211_device, RxTsRecord[pRxTs->num]);
 
 	RxTsDeleteBA(ieee, pRxTs);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index b878ff5f7d0f..53203e633c0b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -39,7 +39,7 @@ struct tx_ts_record {
 	u8				num;
 };
 
-typedef struct _RX_TS_RECORD {
+struct rx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				RxIndicateSeq;
 	u16				RxTimeoutIndicateSeq;
@@ -50,7 +50,7 @@ typedef struct _RX_TS_RECORD {
 	u8				RxLastFragNum;
 	u8				num;
 /* 	QOS_DL_RECORD		DLRecord; */
-} RX_TS_RECORD, *PRX_TS_RECORD;
+};
 
 
 #endif
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 399e97ce62b4..8728048d3f27 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -19,13 +19,13 @@ static void TsInactTimeout(struct timer_list *unused)
 
 /********************************************************************************************************************
  *function:  I still not understand this function, so wait for further implementation
- *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or RX_TS_RECORD to these timer
+ *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or struct rx_ts_record to these timer
  *  return:  NULL
  *  notice:
  ********************************************************************************************************************/
 static void RxPktPendingTimeout(struct timer_list *t)
 {
-	PRX_TS_RECORD	pRxTs = from_timer(pRxTs, t, RxPktPendingTimer);
+	struct rx_ts_record     *pRxTs = from_timer(pRxTs, t, RxPktPendingTimer);
 	struct ieee80211_device *ieee = container_of(pRxTs, struct ieee80211_device, RxTsRecord[pRxTs->num]);
 
 	PRX_REORDER_ENTRY	pReorderEntry = NULL;
@@ -86,7 +86,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 /********************************************************************************************************************
  *function:  Add BA timer function
- *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or RX_TS_RECORD to these timer
+ *   input:  unsigned long	 data		//acturally we send struct tx_ts_record or struct rx_ts_record to these timer
  *  return:  NULL
  *  notice:
  ********************************************************************************************************************/
@@ -121,7 +121,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	ResetBaEntry(&pTS->tx_pending_ba_record);
 }
 
-static void ResetRxTsEntry(PRX_TS_RECORD pTS)
+static void ResetRxTsEntry(struct rx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->RxIndicateSeq = 0xffff; // This indicate the RxIndicateSeq is not used now!!
@@ -132,7 +132,7 @@ static void ResetRxTsEntry(PRX_TS_RECORD pTS)
 void TSInitialize(struct ieee80211_device *ieee)
 {
 	struct tx_ts_record     *pTxTS  = ieee->TxTsRecord;
-	PRX_TS_RECORD		pRxTS  = ieee->RxTsRecord;
+	struct rx_ts_record     *pRxTS  = ieee->RxTsRecord;
 	PRX_REORDER_ENTRY	pRxReorderEntry = ieee->RxReorderEntry;
 	u8				count = 0;
 	IEEE80211_DEBUG(IEEE80211_DL_TS, "==========>%s()\n", __func__);
@@ -377,7 +377,7 @@ bool GetTs(
 					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, ts_common_info);
 					ResetTxTsEntry(tmp);
 				} else {
-					PRX_TS_RECORD tmp = container_of(*ppTS, RX_TS_RECORD, ts_common_info);
+					struct rx_ts_record *tmp = container_of(*ppTS, struct rx_ts_record, ts_common_info);
 					ResetRxTsEntry(tmp);
 				}
 
@@ -419,7 +419,7 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 	if(TxRxSelect == RX_DIR) {
 //#ifdef TO_DO_LIST
 		PRX_REORDER_ENTRY	pRxReorderEntry;
-		PRX_TS_RECORD		pRxTS = (PRX_TS_RECORD)pTs;
+		struct rx_ts_record     *pRxTS = (struct rx_ts_record *)pTs;
 		if(timer_pending(&pRxTS->RxPktPendingTimer))
 			del_timer_sync(&pRxTS->RxPktPendingTimer);
 
-- 
2.18.0

