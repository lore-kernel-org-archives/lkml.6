Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF26ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F30208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9NKfIXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F30208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbeGPTeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36912 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so3552673eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zQNvabZE80bn9n8GnX69Mqc8QA7hSxT7wktTQT4Bz4=;
        b=H9NKfIXik2Gj543YDHXzOgrf9b4YCiMmex5nGMfglF1yrm6Lo1z1g++vN1tlU5H2pc
         1mUTlATjEmXebFuwDxl2cauPd5Pn0H3+Li1gdlccUh73pgvBF2mXKfCeoL2pxJm1fWpu
         qx8VuZDz2T8DJn94kpJeZBRZtQLwxRwJuFpoQ6YNHiDDUCgYDz7FvIUIyBBdYq0XYz4+
         dP3/nR/x6V1ISlSYCdZ+OSJC32JgcH9EX5hUOZRHi6xPX3BKMIlCLTbh+dAPER2yzbwW
         AJ0FPoKhmJuTxmyEGAFzqZdL14PvgXqH5MQTFH2yRybLrcoVTSZ32MkEXWg7m2Jlt6/6
         WMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zQNvabZE80bn9n8GnX69Mqc8QA7hSxT7wktTQT4Bz4=;
        b=mMB+pPUZlsjQcIi8YbYTkys0fyGhqvLRHyxNWA2okdSJmSqeuErz553Ts1SrK7yD7Z
         nChXwaTGFqRKaOQ9RC/bzBqQGrYY4Gr5W3gvwmE14YNxRwdPYkGJAmI2FVCpN+iLtfUk
         nv9Qau5dRCRSp0dsCD1dcT4eGqqspVeVvPOwqwdBMMH9YNslq7tTQwONC15dqPFQsg6b
         OE0j20q1MBq1mmTKDHDOvzsmKbEzRGGQLBTyYqe3YIjxKQmWQFbTyvNrhPEhbBDvDfbl
         PUotoFUWC4QhlSOyXvc5xb2TQxZhR6U0uBEyVs+l8SrNuF0gCvoxOqMCG/IsHYu7eGnc
         Jq4Q==
X-Gm-Message-State: AOUpUlHhBePvSoyj7YCEHp1/r3eVF/mQF77RXpICCJuS2ZRoPVAsYgja
        Hemqdv9eeQEH8zPh/mH9Py6ZlA==
X-Google-Smtp-Source: AAOMgpdXt49up/BTfZAIoIPxDGmwlanzrtbrYS9RXyOA/SZF8JJtRb37IMfOkparvp+FmDP+m5Mfyg==
X-Received: by 2002:a50:8c45:: with SMTP id p63-v6mr7242230edp.84.1531767928379;
        Mon, 16 Jul 2018 12:05:28 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:27 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 03/10] staging:rtl8192u: Rename List > list - Coding style
Date:   Mon, 16 Jul 2018 20:04:47 +0100
Message-Id: <20180716190454.31489-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716190454.31489-1-johnfwhitmore@gmail.com>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
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
index 5d2fb52a8072..0a0420aa91cf 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -16,7 +16,7 @@ enum tr_select {
 };
 
 struct ts_common_info {
-	struct list_head		List;
+	struct list_head		list;
 	struct timer_list		SetupTimer;
 	struct timer_list		InactTimer;
 	u8				Addr[6];
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index fd3347dca025..24abdad52ed6 100644
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
@@ -245,7 +245,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
 	for(dir = 0; dir <= DIR_BI_DIR; dir++) {
 		if (!search_dir[dir])
 			continue;
-		list_for_each_entry(pRet, psearch_list, List){
+		list_for_each_entry(pRet, psearch_list, list){
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.field.ucTSID, pRet->TSpec.f.TSInfo.field.ucDirection);
 			if (memcmp(pRet->Addr, Addr, 6) == 0)
 				if (pRet->TSpec.f.TSInfo.field.ucTSID == TID)
@@ -254,11 +254,11 @@ static struct ts_common_info *SearchAdmitTRStream(struct ieee80211_device *ieee,
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
-				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, List);
-				list_del_init(&(*ppTS)->List);
+				(*ppTS) = list_entry(pUnusedList->next, struct ts_common_info, list);
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
 	struct ts_common_info	*pTS, *pTmpTS;
 
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
 	struct ts_common_info *pTS, *pTmpTS;
 
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

