Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74781ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF082087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqgxYHis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF082087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbeGMU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50668 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbeGMU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so9896689wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6SNVQn+wzY1U1+jQVbQ/a5tNSGnVoD3lj5lukMWlXxE=;
        b=dqgxYHis9x/DVvSoLqj4oPQQpgiSJPNR8vB8tKDpJMy/HD5xvzixRw5lPlWutc6qw6
         xoS0FXEPZa2ZQc6nHZEMn2UpJf+ekZ+NOSdMzqBWJlcy0OX76mZ8k3iIg3+LaBLVYmpX
         S5LuOvjzsbEXlKU4KeFDCzA0zs8c9Y5OXgU3pXLxBt3j5eqBF2xNPBUj4LQ+0YeC1+JR
         agiElGBgLvUOsocUbzYyaUWHu6TS1ilLOlcHbyzkGiX/DzpLoIbOJIijPWjyVx5wBCU6
         yLAcPiNtaHVO8BBnkf5F6YHLR3CMv0bQnzCU5bj+MS3uYDFrIjNTBYrOE3VVfp0DExDM
         K7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6SNVQn+wzY1U1+jQVbQ/a5tNSGnVoD3lj5lukMWlXxE=;
        b=dZnjEnLpQyg/bUSYbVemQ4IsWxZmsvOUhuGdGW2yErL0FkivzwrEHTxQqXgHF6Ekbl
         M/JRa2RkAssuo29R051t9hNwOK4a4ja4O/qF0FSv0EMELksWOBMqsqlUAmgMjZuzzwPo
         g0BRV0MK6fN20V6ISEbNyugCo9fknuaAVKgc/UmnlhLVvX2s4IImgk7NrU1Agwwh5pk6
         tvBwoIES+Zjk0ashYjt1MSx8y34OWUKMaEK/rvC9bqmsO1xpudCAceSsNN4CmSMnsX5D
         uuhFM9YAfrgOT+vQ3LgN5CTcOtVBgR1IwAUNyswFYh919fsbKL5lZmk52vxBE93bznFG
         cXAg==
X-Gm-Message-State: AOUpUlF4Qnihybhq6khMWrQlbH+BwWDLPnaEroy60iNRIDsYi2KKOUbH
        o4gl3xDS/uKRPq98Bmnpc57KbKRH
X-Google-Smtp-Source: AAOMgpfVbw430L4YK7agxLi4fosVbxhYyQpoB8dikSDzovqk3xPsjbhe49HKcZJ2/Gkx0JE80wosHQ==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr4461297wmi.152.1531512814215;
        Fri, 13 Jul 2018 13:13:34 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id f6-v6sm14072677wrp.30.2018.07.13.13.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:33 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/10] staging:rtl8192u: Rename Addr > addr - Style
Date:   Fri, 13 Jul 2018 21:12:43 +0100
Message-Id: <20180713201247.21428-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
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
index 6434ba47e5cb..f9716db4509e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -634,7 +634,7 @@ TsInitAddBA(
 
 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
 
-	ieee80211_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
+	ieee80211_send_ADDBAReq(ieee, pTS->TsCommonInfo.addr, pBA);
 }
 
 void
@@ -646,7 +646,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct TS_COMMON_INFO *pTsCommonInfo,
 		if (TxTsDeleteBA(ieee, pTxTs))
 			ieee80211_send_DELBA(
 				ieee,
-				pTsCommonInfo->Addr,
+				pTsCommonInfo->addr,
 				(pTxTs->TxAdmittedBARecord.bValid)?(&pTxTs->TxAdmittedBARecord):(&pTxTs->TxPendingBARecord),
 				TxRxSelect,
 				DELBA_REASON_END_BA);
@@ -655,7 +655,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct TS_COMMON_INFO *pTsCommonInfo,
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
index 9c0998db220f..4ad152920be4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -19,7 +19,7 @@ struct TS_COMMON_INFO {
 	struct list_head		list;
 	struct timer_list		setup_timer;
 	struct timer_list		inact_timer;
-	u8				Addr[6];
+	u8				addr[6];
 	TSPEC_BODY			TSpec;
 	QOS_TCLAS			TClass[TCLAS_NUM];
 	u8				TClasProc;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 04cc101f680e..80e03dc73bae 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -103,7 +103,7 @@ static void TsAddBaProcess(struct timer_list *t)
 
 static void ResetTsCommonInfo(struct TS_COMMON_INFO *pTsCommonInfo)
 {
-	eth_zero_addr(pTsCommonInfo->Addr);
+	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(TSPEC_BODY));
 	memset(&pTsCommonInfo->TClass, 0, sizeof(QOS_TCLAS)*TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
@@ -247,7 +247,7 @@ static struct TS_COMMON_INFO *SearchAdmitTRStream(struct ieee80211_device *ieee,
 			continue;
 		list_for_each_entry(pRet, psearch_list, list){
 	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->Addr, pRet->TSpec.f.TSInfo.field.ucTSID, pRet->TSpec.f.TSInfo.field.ucDirection);
-			if (memcmp(pRet->Addr, Addr, 6) == 0)
+			if (memcmp(pRet->addr, Addr, 6) == 0)
 				if (pRet->TSpec.f.TSInfo.field.ucTSID == TID)
 					if(pRet->TSpec.f.TSInfo.field.ucDirection == dir) {
 	//					printk("Bingo! got it\n");
@@ -273,7 +273,7 @@ static void MakeTSEntry(struct TS_COMMON_INFO *pTsCommonInfo, u8 *Addr,
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

