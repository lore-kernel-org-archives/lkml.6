Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA4EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE3A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSGN6too"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE3A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbeG0Syh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44794 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbeG0Syg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so5785641wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7YrfrFTzg0UMwzteMRULGV98hmoCC1b8l2JJCXrBEg=;
        b=fSGN6too4YUHbjtwt47Vre4NO8++gjRZ8W168bXYCKR2IwDP2ln0+gtIdIU1iuA3aM
         R3Vw1rK/R943xBZX/gu1Ug8W9NJAeNoMiWnziQU+kZA9EEFI6KjjEuXllOpmndMt4PPu
         o3v1PHBS5RZKAVDc67nQlvivTgxUJGrJgG5wUY//GWEF42673lZXruGrq2RpOtrQ4hhc
         cstKbQCYc/WSrMO6c5mbCiN8FV1ewgc2uHNaUjIpl8jYOjqYDQo7Nrhn9b3eLdnnVfAb
         undj3F1+c5yqpXxoU4GX29x0SREMyAPKcOh5erv4tnE7gpTPceHTe4qtCMiRMzX01v8g
         d7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7YrfrFTzg0UMwzteMRULGV98hmoCC1b8l2JJCXrBEg=;
        b=gBODetnadSptmmyrTjm7vha0atMdzwXN2D/0TRRzoZseJuLMC4nN/7cZCrO9tjdG17
         6L20tlDAuLP538Dj13UjeoBnsD0jOhaLfcmLFlml/tQZOe62jQcNQVVfjlUw9zZRMKeO
         iVQbJYuRCPxVmj443kDhPc63Hqm3ILxUvY+YQTr84pI6mEwvRzwq/b5WHcmEuI8HzsVd
         drKeC6KBFGkasnHuF9YtI+VV1/wzipaQd9zgPSBIM3iomgFr+V+yw9i8V8o+6G+hgVFo
         Y9IfyoECh1O669dRaJ9xXQC0AM/A2ONfD4/vBAk+DB2xEjXhdvmIWv6fpwv21K30ds8x
         onJg==
X-Gm-Message-State: AOUpUlGTP3Gf5A4g7mwSgssBqiTk2XaJOUWub8W74vek5ouVnZieDi3H
        rz6e1KRtbwSUXeSeb6jLK9AO/GtaYxI=
X-Google-Smtp-Source: AAOMgpdn/iq9JlvaT9teq33nHyx+79A+/CvEMroTA0Z9O6wz68ay0fDKijTK8756ln1shtHyuTHaaA==
X-Received: by 2002:adf:e642:: with SMTP id b2-v6mr5989349wrn.254.1532712701946;
        Fri, 27 Jul 2018 10:31:41 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/20] staging:rtl8192u: Rename TsCommonInfo - Style
Date:   Fri, 27 Jul 2018 18:31:05 +0100
Message-Id: <20180727173123.27391-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable TsCommonInfo in two structures, both
tx_ts_record and RX_TS_RECORD. This member variable is used in both
structures and in both cases causes a checkpatch issue with CamelCase
naming.

The changes are purely coding style and should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  8 ++++----
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  4 ++--
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 20 +++++++++----------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 507014d44d54..686d4e917384 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -626,7 +626,7 @@ TsInitAddBA(
 	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.AMSDU_Support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.BAPolicy = Policy;	// Policy: Delayed or Immediate
-	pBA->BaParamSet.field.TID = pTS->TsCommonInfo.t_spec.f.TSInfo.field.ucTSID;	// TID
+	pBA->BaParamSet.field.TID = pTS->ts_common_info.t_spec.f.TSInfo.field.ucTSID;	// TID
 	// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaParamSet.field.BufferSize = 32;		// BufferSize: This need to be set according to A-MPDU vector
 	pBA->BaTimeoutValue = 0;					// Timeout value: Set 0 to disable Timer
@@ -634,7 +634,7 @@ TsInitAddBA(
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
 
-	ieee80211_send_ADDBAReq(ieee, pTS->TsCommonInfo.addr, pBA);
+	ieee80211_send_ADDBAReq(ieee, pTS->ts_common_info.addr, pBA);
 }
 
 void
@@ -683,7 +683,7 @@ void TxBaInactTimeout(struct timer_list *t)
 	TxTsDeleteBA(ieee, pTxTs);
 	ieee80211_send_DELBA(
 		ieee,
-		pTxTs->TsCommonInfo.addr,
+		pTxTs->ts_common_info.addr,
 		&pTxTs->TxAdmittedBARecord,
 		TX_DIR,
 		DELBA_REASON_TIMEOUT);
@@ -697,7 +697,7 @@ void RxBaInactTimeout(struct timer_list *t)
 	RxTsDeleteBA(ieee, pRxTs);
 	ieee80211_send_DELBA(
 		ieee,
-		pRxTs->TsCommonInfo.addr,
+		pRxTs->ts_common_info.addr,
 		&pRxTs->RxAdmittedBARecord,
 		RX_DIR,
 		DELBA_REASON_TIMEOUT);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 0f744b112dcf..e2c2001dc5ca 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -27,7 +27,7 @@ struct ts_common_info {
 };
 
 struct tx_ts_record {
-	struct ts_common_info		TsCommonInfo;
+	struct ts_common_info		ts_common_info;
 	u16				TxCurSeq;
 	BA_RECORD			TxPendingBARecord;	/*  For BA Originator */
 	BA_RECORD			TxAdmittedBARecord;	/*  For BA Originator */
@@ -40,7 +40,7 @@ struct tx_ts_record {
 };
 
 typedef struct _RX_TS_RECORD {
-	struct ts_common_info		TsCommonInfo;
+	struct ts_common_info		ts_common_info;
 	u16				RxIndicateSeq;
 	u16				RxTimeoutIndicateSeq;
 	struct list_head		RxPendingPktList;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index f2a5771185f0..e1ce4e5096bb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -112,7 +112,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 
 static void ResetTxTsEntry(struct tx_ts_record *pTS)
 {
-	ResetTsCommonInfo(&pTS->TsCommonInfo);
+	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->TxCurSeq = 0;
 	pTS->bAddBaReqInProgress = false;
 	pTS->bAddBaReqDelayed = false;
@@ -123,7 +123,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 
 static void ResetRxTsEntry(PRX_TS_RECORD pTS)
 {
-	ResetTsCommonInfo(&pTS->TsCommonInfo);
+	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->RxIndicateSeq = 0xffff; // This indicate the RxIndicateSeq is not used now!!
 	pTS->RxTimeoutIndicateSeq = 0xffff; // This indicate the RxTimeoutIndicateSeq is not used now!!
 	ResetBaEntry(&pTS->RxAdmittedBARecord);	  // For BA Recipient
@@ -146,9 +146,9 @@ void TSInitialize(struct ieee80211_device *ieee)
 		pTxTS->num = count;
 		// The timers for the operation of Traffic Stream and Block Ack.
 		// DLS related timer will be add here in the future!!
-		timer_setup(&pTxTS->TsCommonInfo.setup_timer, TsSetupTimeOut,
+		timer_setup(&pTxTS->ts_common_info.setup_timer, TsSetupTimeOut,
 			    0);
-		timer_setup(&pTxTS->TsCommonInfo.inact_timer, TsInactTimeout,
+		timer_setup(&pTxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
 		timer_setup(&pTxTS->TxPendingBARecord.Timer, BaSetupTimeOut,
@@ -156,7 +156,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		timer_setup(&pTxTS->TxAdmittedBARecord.Timer,
 			    TxBaInactTimeout, 0);
 		ResetTxTsEntry(pTxTS);
-		list_add_tail(&pTxTS->TsCommonInfo.list, &ieee->Tx_TS_Unused_List);
+		list_add_tail(&pTxTS->ts_common_info.list, &ieee->Tx_TS_Unused_List);
 		pTxTS++;
 	}
 
@@ -167,15 +167,15 @@ void TSInitialize(struct ieee80211_device *ieee)
 	for(count = 0; count < TOTAL_TS_NUM; count++) {
 		pRxTS->num = count;
 		INIT_LIST_HEAD(&pRxTS->RxPendingPktList);
-		timer_setup(&pRxTS->TsCommonInfo.setup_timer, TsSetupTimeOut,
+		timer_setup(&pRxTS->ts_common_info.setup_timer, TsSetupTimeOut,
 			    0);
-		timer_setup(&pRxTS->TsCommonInfo.inact_timer, TsInactTimeout,
+		timer_setup(&pRxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
 		timer_setup(&pRxTS->RxAdmittedBARecord.Timer,
 			    RxBaInactTimeout, 0);
 		timer_setup(&pRxTS->RxPktPendingTimer, RxPktPendingTimeout, 0);
 		ResetRxTsEntry(pRxTS);
-		list_add_tail(&pRxTS->TsCommonInfo.list, &ieee->Rx_TS_Unused_List);
+		list_add_tail(&pRxTS->ts_common_info.list, &ieee->Rx_TS_Unused_List);
 		pRxTS++;
 	}
 	// Initialize unused Rx Reorder List.
@@ -374,10 +374,10 @@ bool GetTs(
 				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
 				list_del_init(&(*ppTS)->list);
 				if(TxRxSelect==TX_DIR) {
-					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, TsCommonInfo);
+					struct tx_ts_record *tmp = container_of(*ppTS, struct tx_ts_record, ts_common_info);
 					ResetTxTsEntry(tmp);
 				} else {
-					PRX_TS_RECORD tmp = container_of(*ppTS, RX_TS_RECORD, TsCommonInfo);
+					PRX_TS_RECORD tmp = container_of(*ppTS, RX_TS_RECORD, ts_common_info);
 					ResetRxTsEntry(tmp);
 				}
 
-- 
2.18.0

