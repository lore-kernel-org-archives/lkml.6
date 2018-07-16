Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD490ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B609208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEq/HE+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B609208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGPTeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43834 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeGPTeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so5222766edt.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ftcFMu2mfC5KrTpKxDfrlTaUu8DQVByjMRksHUfppec=;
        b=HEq/HE+74HjA2ouLryvdVDmQMXhV26tV8efp7D/DIpr/wF1UMlD1w9CyhUzd55oqHZ
         Iwxnxkywy0ncsEhu2OYDg6EN69uIxe1bf7KH8ECiqS1e7G+MyaRzAs2wZrBpEkd0XglU
         gAqHURiwBYxM2NOCKfZN91CkLDYCljX6i2HC47tlMGmS3um6U/B9TSS4GQmR8MVbVB2o
         8nscX7Txpv5Iit5SaUaL003qr4B+Wy+ewGg3mcEADCzByR8wlQJpIJUcXHD0a3+vAGFf
         KVlE1LPq0j/PzXxnndY4KMfY9LJjOaq1wiewxnPxDAYRh0P0Fndie/6xadifd1sH7TGY
         xLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ftcFMu2mfC5KrTpKxDfrlTaUu8DQVByjMRksHUfppec=;
        b=uKk4+ojWvESP9LnkjAIKA1+1aXeqr8EiQ3FdpHhkn0O+VQGK3wsuXCyCE3SgONlEkS
         afttwY8TaX3RxC1elSMoThGC7JNBXiEnTlxZE/FStxgbFmvptG+dGQ2U39v4JJM03JdC
         lTO3SFDTKOfRcy9lT67wjlNNfufxRPLYkP61pmbx6OFXfYzr3Qv+zyRVg7UwqDo7GUL+
         cGRaEK2sRWZstYLZi0bGMJdvfSzoVLhqvyLe3icitj/z8zAAC6g5amsm1Mg8kj/khq52
         R9R/KwcIZMKdL+6iGlogjcI/HS9scZYhSKdTwQZ/HMmMCCqT+/gc6kDFHVHzlb5bwBEc
         gigw==
X-Gm-Message-State: AOUpUlFuL2Qysat28A4xGzvrTbvPflwU/Oxr9IGtfEZqowNXwN4WlGW/
        DE0tROeT3RZ+HgEL9H1q/Do4pw==
X-Google-Smtp-Source: AAOMgpcjBL/OaKhpAGUMJ1iWcbEoJHRl2L9pot+6x+w1nNKFG+VlQ0mT+fcwoES+/E/fvwmaOgH0Qg==
X-Received: by 2002:aa7:c342:: with SMTP id j2-v6mr18398512edr.201.1531767932943;
        Mon, 16 Jul 2018 12:05:32 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 06/10] staging:rtl8192u: Rename Addr > addr - Style
Date:   Mon, 16 Jul 2018 20:04:50 +0100
Message-Id: <20180716190454.31489-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the TX_COMMON_INFO structure's member Addr to addr. This change
clears the checkpatch issue with CamelCase naming. This is a coding style
change only and should not impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_TSProc.c    | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 950f827a1740..297c498aef6a 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -634,7 +634,7 @@ TsInitAddBA(
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
 
-	ieee80211_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
+	ieee80211_send_ADDBAReq(ieee, pTS->TsCommonInfo.addr, pBA);
 }
 
 void
@@ -646,7 +646,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 		if (TxTsDeleteBA(ieee, pTxTs))
 			ieee80211_send_DELBA(
 				ieee,
-				pTsCommonInfo->Addr,
+				pTsCommonInfo->addr,
 				(pTxTs->TxAdmittedBARecord.bValid)?(&pTxTs->TxAdmittedBARecord):(&pTxTs->TxPendingBARecord),
 				TxRxSelect,
 				DELBA_REASON_END_BA);
@@ -655,7 +655,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 		if (RxTsDeleteBA(ieee, pRxTs))
 			ieee80211_send_DELBA(
 				ieee,
-				pTsCommonInfo->Addr,
+				pTsCommonInfo->addr,
 				&pRxTs->RxAdmittedBARecord,
 				TxRxSelect,
 				DELBA_REASON_END_BA);
@@ -683,7 +683,7 @@ void TxBaInactTimeout(struct timer_list *t)
 	TxTsDeleteBA(ieee, pTxTs);
 	ieee80211_send_DELBA(
 		ieee,
-		pTxTs->TsCommonInfo.Addr,
+		pTxTs->TsCommonInfo.addr,
 		&pTxTs->TxAdmittedBARecord,
 		TX_DIR,
 		DELBA_REASON_TIMEOUT);
@@ -697,7 +697,7 @@ void RxBaInactTimeout(struct timer_list *t)
 	RxTsDeleteBA(ieee, pRxTs);
 	ieee80211_send_DELBA(
 		ieee,
-		pRxTs->TsCommonInfo.Addr,
+		pRxTs->TsCommonInfo.addr,
 		&pRxTs->RxAdmittedBARecord,
 		RX_DIR,
 		DELBA_REASON_TIMEOUT);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 1613c3c5d447..62c6fc513540 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -19,7 +19,7 @@ struct ts_common_info {
 	struct list_head		list;
 	struct timer_list		setup_timer;
 	struct timer_list		inact_timer;
-	u8				Addr[6];
+	u8				addr[6];
 	TSPEC_BODY			TSpec;
 	QOS_TCLAS			TClass[TCLAS_NUM];
 	u8				TClasProc;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 175d91218af8..72a5fc0bbb47 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -103,7 +103,7 @@ static void TsAddBaProcess(struct timer_list *t)
 
 static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
-	eth_zero_addr(pTsCommonInfo->Addr);
+	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->TClass, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
@@ -247,7 +247,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 			continue;
 		list_for_each_entry(pRet, psearch_list, list){
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.field.ucTSID, pRet->TSpec.f.TSInfo.field.ucDirection);
-			if (memcmp(pRet->Addr, Addr, 6) == 0)
+			if (memcmp(pRet->addr, Addr, 6) == 0)
 				if (pRet->TSpec.f.TSInfo.field.ucTSID == TID)
 					if(pRet->TSpec.f.TSInfo.field.ucDirection == dir) {
 	//					printk("Bingo! got it\n");
@@ -273,7 +273,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 	if(pTsCommonInfo == NULL)
 		return;
 
-	memcpy(pTsCommonInfo->Addr, Addr, 6);
+	memcpy(pTsCommonInfo->addr, Addr, 6);
 
 	if(pTSPEC != NULL)
 		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC, sizeof(TSPEC_BODY));
@@ -458,7 +458,7 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 
 	printk("===========>RemovePeerTS,%pM\n", Addr);
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, Addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, TX_DIR);
 			list_del_init(&pTS->list);
 			list_add_tail(&pTS->list, &ieee->Tx_TS_Unused_List);
@@ -466,7 +466,7 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 	}
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, Addr, 6) == 0) {
 			printk("====>remove Tx_TS_admin_list\n");
 			RemoveTsEntry(ieee, pTS, TX_DIR);
 			list_del_init(&pTS->list);
@@ -475,7 +475,7 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 	}
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, Addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, RX_DIR);
 			list_del_init(&pTS->list);
 			list_add_tail(&pTS->list, &ieee->Rx_TS_Unused_List);
@@ -483,7 +483,7 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 	}
 
 	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, list) {
-		if (memcmp(pTS->Addr, Addr, 6) == 0) {
+		if (memcmp(pTS->addr, Addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, RX_DIR);
 			list_del_init(&pTS->list);
 			list_add_tail(&pTS->list, &ieee->Rx_TS_Unused_List);
-- 
2.18.0

