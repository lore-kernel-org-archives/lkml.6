Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6375ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8129D208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3cwe9Mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8129D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbeGMU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53575 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbeGMU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so2536777wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FW7yGz3uEpzDoHxk1zYNnK1lwPAPtWP2RfdjcIybV+Y=;
        b=M3cwe9MvEu1vZoYTh0QJm1YFnJM8xHYE6jLkaGtRUlawv05tIII3QYri9JB+ha3mf2
         n93F9tqyB60Waws2RyUqjGsQH9u4vWH1ZsK4IiC6+VWQTiIONLnHIYj/XckfaoXCuptd
         /HmU4cNyaSg3LWpTIdNw4DpGhRRvaLDg+9ZS//6vb8iBS+Xd/HiE7wr2VD8X6xbEBHb1
         AOfgfVha7W2Nlth70vRgGTVpvoqU8dKdIlnDx0dxs7RTMPsnFEeyJmYQ5Oi0ocwmuEQr
         Iuzn6rQXGpP2g3oLfdcyrYBQMau6dIexkd+NNSCkLc+495wwVToZvT9w4f2KJWxMWV2e
         CkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FW7yGz3uEpzDoHxk1zYNnK1lwPAPtWP2RfdjcIybV+Y=;
        b=PUyIc/T/28VEwJX67M04G/+oPvyqXtec5lax4ZEtMgRxAeegbZbu1hTK1dSdrziYQ+
         +CiatjAHASEwzFqI/UM27j9kh6p82BB11qLjnj8fwcThLOkYzmjyvei7wH8OQBbXpfw5
         hfrTcGxZjmFc58+5pj8C90QQ3+z2bmIbNITER3/HM+zA7gDR6r0xIt6jmRoYmV1C0kWC
         MHtAhkEocsXpFp1ZemMAznl1axjHcGocLzMHUNo1AkofVzjf3BvJ9PjBGwyQxStCjLoq
         gVMGyTKaxPTopP4brezywGrdXZsLcOEyP0P6Jhja4W76j1d3nx+za5yg41bJHO395b30
         Eyvg==
X-Gm-Message-State: AOUpUlFb+GmzKdKlntR5egMklI4BWjq8vF46Zp90vs1wrKUyBb9in4YX
        knGkSFU5Cs5RUC7iuYv9RKNP+urp
X-Google-Smtp-Source: AAOMgpeNAY3SheL36UJP8WvC2l9+L1+GmaD65pMZ2weT0rdKp/j0XuNUsoA/IU5R4kNqjR8HfWE5mQ==
X-Received: by 2002:a1c:ce0c:: with SMTP id e12-v6mr4382506wmg.86.1531512809352;
        Fri, 13 Jul 2018 13:13:29 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:28 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/10] staging:rtl8192u: Rename List > list - Coding style
Date:   Fri, 13 Jul 2018 21:12:40 +0100
Message-Id: <20180713201247.21428-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In struct TS_COMMON_INFO rename the member List to list. This clears the
checkpatch issue concerning CamelCase naming of variables.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  2 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 64 +++++++++----------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 39ce5d89883f..bf1e01cde407 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -16,7 +16,7 @@ enum TR_SELECT {
 };
 
 struct TS_COMMON_INFO {
-	struct list_head		List;
+	struct list_head		list;
 	struct timer_list		SetupTimer;
 	struct timer_list		InactTimer;
 	u8				Addr[6];
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index a3bcb15037af..cc6fdcb7c5fb 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -156,7 +156,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		timer_setup(&pTxTS->TxAdmittedBARecord.Timer,
 			    TxBaInactTimeout, 0);
 		ResetTxTsEntry(pTxTS);
-		list_add_tail(&pTxTS->TsCommonInfo.List, &ieee->Tx_TS_Unused_List);
+		list_add_tail(&pTxTS->TsCommonInfo.list, &ieee->Tx_TS_Unused_List);
 		pTxTS++;
 	}
 
@@ -175,7 +175,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 			    RxBaInactTimeout, 0);
 		timer_setup(&pRxTS->RxPktPendingTimer, RxPktPendingTimeout, 0);
 		ResetRxTsEntry(pRxTS);
-		list_add_tail(&pRxTS->TsCommonInfo.List, &ieee->Rx_TS_Unused_List);
+		list_add_tail(&pRxTS->TsCommonInfo.list, &ieee->Rx_TS_Unused_List);
 		pRxTS++;
 	}
 	// Initialize unused Rx Reorder List.
@@ -245,7 +245,7 @@ static struct TS_COMMON_INFO *SearchAdmitTRStream(struct ieee80211_device *ieee,
 	for(dir = 0; dir <= DIR_BI_DIR; dir++) {
 		if (!search_dir[dir])
 			continue;
-		list_for_each_entry(pRet, psearch_list, List){
+		list_for_each_entry(pRet, psearch_list, list){
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.field.ucTSID, pRet->TSpec.f.TSInfo.field.ucDirection);
 			if (memcmp(pRet->Addr, Addr, 6) == 0)
 				if (pRet->TSpec.f.TSInfo.field.ucTSID == TID)
@@ -254,11 +254,11 @@ static struct TS_COMMON_INFO *SearchAdmitTRStream(struct ieee80211_device *ieee,
 						break;
 					}
 		}
-		if(&pRet->List  != psearch_list)
+		if(&pRet->list  != psearch_list)
 			break;
 	}
 
-	if(&pRet->List  != psearch_list)
+	if(&pRet->list  != psearch_list)
 		return pRet ;
 	else
 		return NULL;
@@ -371,8 +371,8 @@ bool GetTs(
 								((TxRxSelect==TX_DIR)?DIR_UP:DIR_DOWN);
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
 			if(!list_empty(pUnusedList)) {
-				(*ppTS) = list_entry(pUnusedList->next, struct TS_COMMON_INFO, List);
-				list_del_init(&(*ppTS)->List);
+				(*ppTS) = list_entry(pUnusedList->next, struct TS_COMMON_INFO, list);
+				list_del_init(&(*ppTS)->list);
 				if(TxRxSelect==TX_DIR) {
 					PTX_TS_RECORD tmp = container_of(*ppTS, TX_TS_RECORD, TsCommonInfo);
 					ResetTxTsEntry(tmp);
@@ -395,7 +395,7 @@ bool GetTs(
 
 				MakeTSEntry(*ppTS, Addr, &TSpec, NULL, 0, 0);
 				AdmitTS(ieee, *ppTS, 0);
-				list_add_tail(&((*ppTS)->List), pAddmitList);
+				list_add_tail(&((*ppTS)->list), pAddmitList);
 				// if there is DirectLink, we need to do additional operation here!!
 
 				return true;
@@ -457,36 +457,36 @@ void RemovePeerTS(struct ieee80211_device *ieee, u8 *Addr)
 	struct TS_COMMON_INFO	*pTS, *pTmpTS;
 
 	printk("===========>RemovePeerTS,%pM\n", Addr);
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
 		if (memcmp(pTS->Addr, Addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, TX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+			list_del_init(&pTS->list);
+			list_add_tail(&pTS->list, &ieee->Tx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
 		if (memcmp(pTS->Addr, Addr, 6) == 0) {
 			printk("====>remove Tx_TS_admin_list\n");
 			RemoveTsEntry(ieee, pTS, TX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+			list_del_init(&pTS->list);
+			list_add_tail(&pTS->list, &ieee->Tx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
 		if (memcmp(pTS->Addr, Addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, RX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+			list_del_init(&pTS->list);
+			list_add_tail(&pTS->list, &ieee->Rx_TS_Unused_List);
 		}
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, list) {
 		if (memcmp(pTS->Addr, Addr, 6) == 0) {
 			RemoveTsEntry(ieee, pTS, RX_DIR);
-			list_del_init(&pTS->List);
-			list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+			list_del_init(&pTS->list);
+			list_add_tail(&pTS->list, &ieee->Rx_TS_Unused_List);
 		}
 	}
 }
@@ -495,28 +495,28 @@ void RemoveAllTS(struct ieee80211_device *ieee)
 {
 	struct TS_COMMON_INFO *pTS, *pTmpTS;
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Pending_List, list) {
 		RemoveTsEntry(ieee, pTS, TX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+		list_del_init(&pTS->list);
+		list_add_tail(&pTS->list, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Tx_TS_Admit_List, list) {
 		RemoveTsEntry(ieee, pTS, TX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Tx_TS_Unused_List);
+		list_del_init(&pTS->list);
+		list_add_tail(&pTS->list, &ieee->Tx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Pending_List, list) {
 		RemoveTsEntry(ieee, pTS, RX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+		list_del_init(&pTS->list);
+		list_add_tail(&pTS->list, &ieee->Rx_TS_Unused_List);
 	}
 
-	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, List) {
+	list_for_each_entry_safe(pTS, pTmpTS, &ieee->Rx_TS_Admit_List, list) {
 		RemoveTsEntry(ieee, pTS, RX_DIR);
-		list_del_init(&pTS->List);
-		list_add_tail(&pTS->List, &ieee->Rx_TS_Unused_List);
+		list_del_init(&pTS->list);
+		list_add_tail(&pTS->list, &ieee->Rx_TS_Unused_List);
 	}
 }
 
-- 
2.18.0

