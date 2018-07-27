Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664BC208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYLTeZPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664BC208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbeG0Sym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55207 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389096AbeG0Syl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so6027484wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wICvbpwiUWSVSItvqABxGTKMD7Bvg//80nch0Bq75X4=;
        b=aYLTeZPfRHa1WNJ16vynk74/uRCcEqQsUu66JXNjtZsupW0fmU79xc1I9h3jGqbMwI
         AEbPU23D19dMaLlOju7u2xKYKz9G2HDAM4TFyR8RjUA5NneqQU5CKjtlUZaKKSQlqYNC
         F4D7j9TX7va4Ri+ApfECG/uTlXZIIRwwStEIfO8LZUFR8AWUBekD2NmEGwQHs/XZxE9p
         mj9KAuoxYqxJctYmAXbvL8r0ZXkl115FSKpDRmzk0edOREvXGIH5cA7QJi//lkgK1vvf
         +Mj3GAdVRBAh17BPnwS3HyW63+Wu94yePZdhiC8zZN0BSXsh+Vxndtl1YMUgXI6sZU/Z
         An0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wICvbpwiUWSVSItvqABxGTKMD7Bvg//80nch0Bq75X4=;
        b=aBb9JEbVMdRxMnAYm1s1BEjhXAQRNdiBGHJU4oHBwhDGKERikwgYL1uoHvcexOTWIW
         U8tPPmrQjTpvMq6Xej42RI6y3MO9v8QA6haXn0OgFtMdZysevXUZOzzPJdxcqNRXmWjt
         nvo8B5cm6QH+SpWxkWkYRatYr6iTezlMwXKJtnWT0DbkRSuk5YQxlK5hnpJmsyzDnETh
         eiuGk936Grq/OHPi9vUbP5Kl4YiL9ZcA/10q/bqACCixTAAqrxsTeXeKhhcQB2+x4CV0
         +vnWL1FQ3iq7M/A4S7KDtxzdHOU19CsctVuukoVrVd0rony33HbdtHnZaGQ7yT+4NAdN
         TJMQ==
X-Gm-Message-State: AOUpUlFZaMQ7Y3Su99eXRC0dCJS1mebg6N/pLdQlckjm6vZinihr9XmR
        n2Hka1b9U/e4WTyAo5q0mqjRbr7V6ls=
X-Google-Smtp-Source: AAOMgpepCSXgrDLO/F1tksab69hzWtsNOITjdzFLSUnZNklN8TwcIj+BaR4mEIzQBRpPBpZPaG2FcA==
X-Received: by 2002:a1c:af0c:: with SMTP id y12-v6mr4852845wme.87.1532712706369;
        Fri, 27 Jul 2018 10:31:46 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/20] staging:rtl8192u: Rename TxAdmittedBARecord - Style
Date:   Fri, 27 Jul 2018 18:31:08 +0100
Message-Id: <20180727173123.27391-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable TxAdmittedBARecord to tx_admitted_ba_record
This change clears the checkpatch issue with CamelCase naming.

The resulting changes are purely coding style changes which should not
impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c   |  4 ++--
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 77ec1d5938be..2fb9464f6ec3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -335,14 +335,14 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 			printk("===>can't get TS\n");
 			return;
 		}
-		if (!pTxTs->TxAdmittedBARecord.bValid)
+		if (!pTxTs->tx_admitted_ba_record.bValid)
 		{
 			TsStartAddBaProcess(ieee, pTxTs);
 			goto FORCED_AGG_SETTING;
 		}
 		else if (!pTxTs->bUsingBa)
 		{
-			if (SN_LESS(pTxTs->TxAdmittedBARecord.BaStartSeqCtrl.field.SeqNum, (pTxTs->tx_cur_seq + 1) % 4096))
+			if (SN_LESS(pTxTs->tx_admitted_ba_record.BaStartSeqCtrl.field.SeqNum, (pTxTs->tx_cur_seq + 1) % 4096))
 				pTxTs->bUsingBa = true;
 			else
 				goto FORCED_AGG_SETTING;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 55b989d71ab8..92666fdf8ca8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -42,7 +42,7 @@ static void DeActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA)
  ********************************************************************************************************************/
 static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs)
 {
-	PBA_RECORD		pAdmittedBa = &pTxTs->TxAdmittedBARecord;  //These two BA entries must exist in TS structure
+	PBA_RECORD		pAdmittedBa = &pTxTs->tx_admitted_ba_record;  //These two BA entries must exist in TS structure
 	PBA_RECORD		pPendingBa = &pTxTs->tx_pending_ba_record;
 	u8			bSendDELBA = false;
 
@@ -471,7 +471,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 	pTS->bAddBaReqInProgress = false;
 	pPendingBA = &pTS->tx_pending_ba_record;
-	pAdmittedBA = &pTS->TxAdmittedBARecord;
+	pAdmittedBA = &pTS->tx_admitted_ba_record;
 
 
 	//
@@ -647,7 +647,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 			ieee80211_send_DELBA(
 				ieee,
 				pTsCommonInfo->addr,
-				(pTxTs->TxAdmittedBARecord.bValid)?(&pTxTs->TxAdmittedBARecord):(&pTxTs->tx_pending_ba_record),
+				(pTxTs->tx_admitted_ba_record.bValid)?(&pTxTs->tx_admitted_ba_record):(&pTxTs->tx_pending_ba_record),
 				TxRxSelect,
 				DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
@@ -678,13 +678,13 @@ void BaSetupTimeOut(struct timer_list *t)
 
 void TxBaInactTimeout(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TxAdmittedBARecord.Timer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_admitted_ba_record.Timer);
 	struct ieee80211_device *ieee = container_of(pTxTs, struct ieee80211_device, TxTsRecord[pTxTs->num]);
 	TxTsDeleteBA(ieee, pTxTs);
 	ieee80211_send_DELBA(
 		ieee,
 		pTxTs->ts_common_info.addr,
-		&pTxTs->TxAdmittedBARecord,
+		&pTxTs->tx_admitted_ba_record,
 		TX_DIR,
 		DELBA_REASON_TIMEOUT);
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 3af894fe5afe..cacf9b9c295d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -30,7 +30,7 @@ struct tx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				tx_cur_seq;
 	BA_RECORD			tx_pending_ba_record;	/*  For BA Originator */
-	BA_RECORD			TxAdmittedBARecord;	/*  For BA Originator */
+	BA_RECORD			tx_admitted_ba_record;	/*  For BA Originator */
 /* 	QOS_DL_RECORD		DLRecord; */
 	u8				bAddBaReqInProgress;
 	u8				bAddBaReqDelayed;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 3cb6354cf14e..e347a83d6a4f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -117,7 +117,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->bAddBaReqInProgress = false;
 	pTS->bAddBaReqDelayed = false;
 	pTS->bUsingBa = false;
-	ResetBaEntry(&pTS->TxAdmittedBARecord); //For BA Originator
+	ResetBaEntry(&pTS->tx_admitted_ba_record); //For BA Originator
 	ResetBaEntry(&pTS->tx_pending_ba_record);
 }
 
@@ -153,7 +153,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
 		timer_setup(&pTxTS->tx_pending_ba_record.Timer, BaSetupTimeOut,
 			    0);
-		timer_setup(&pTxTS->TxAdmittedBARecord.Timer,
+		timer_setup(&pTxTS->tx_admitted_ba_record.Timer,
 			    TxBaInactTimeout, 0);
 		ResetTxTsEntry(pTxTS);
 		list_add_tail(&pTxTS->ts_common_info.list, &ieee->Tx_TS_Unused_List);
-- 
2.18.0

