Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46581C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F168B21829
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/OfFIPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F168B21829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHUUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34613 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeHUUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so10138556wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwQ/smDAnK5772xDVEaqKTMbRiJWihZBNRzxKN6AErg=;
        b=d/OfFIPB9Us8iSOH8aGirIo/fz4WFWzW/R8pITSTQ/FUZzHiTknz9AdmKrWE5AZMkz
         UU3oMPwyB1OdMSBQeesgeaKub4IEITVevbPo1uHXcAu7uuS0F2vlGi7Mo6EbQNt0j6hl
         nmMdIN5qGuDVRs11870wdKgvgViUqCBgQIxIBggqx3Htsq5pLdivCOP8XFgGrcJIRz/9
         TB2AOC7svGq3apVHbopRm+g6mAFKWYaXQitnNwc0GkYHhlv6IXPpoul9rCw+xk+f6k7Z
         2nVgGUNboFtsKerN0hgJ1rXC3vy3zMQzPBSWrOkcplnOneCW8QS8mO9fYnPoft3YbD1i
         xvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iwQ/smDAnK5772xDVEaqKTMbRiJWihZBNRzxKN6AErg=;
        b=QBWgJc77nLFpZ4uED0/a+1cTCZZoQzBiEUm1gx3oX21+BK5H7Xp/B/UNysd9hIscDM
         MKuDySHtZ1o+DQYRiwmMc+/1YEOGkJdGTAe0c/BJJNgui7VOzMWHn8R0EDkEgH5sDok3
         +7oDulXmTCTLb02j1YFYwEVWF/iqysFrJud6ZMqtfARJByW0weP1dl4QcIdZqMAk3daK
         KEew1nMAcgFtZXNuR2L16u0ebSy7lf+Z2FzCr+nIDesVqnnaPBqh2zL/GuKQ/eK7EJ6M
         5oOkFyDdswxNluoLXcDhUVDDXCmNszbuGckyQcDx7X0tehg/r992KNCdNqiM/OZBWcwX
         VBVw==
X-Gm-Message-State: APzg51BesodScwAKMuof7Rp5XSZVelHpcbJ+gCf1y4+grAUX4GUAEq8+
        qU/cEKav4v5JH9pXw1uLFYWVVch+wIY=
X-Google-Smtp-Source: ANB0VdYYav5a/sF5qmWEVzYIsIOV80mcvwFyttzvt32bc5e76fwF/64mzyTRobUEUYdKg4qBNt5jdw==
X-Received: by 2002:a1c:1f50:: with SMTP id f77-v6mr209694wmf.52.1534871759449;
        Tue, 21 Aug 2018 10:15:59 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/17] staging:rtl8192u: Rename bValid - Style
Date:   Tue, 21 Aug 2018 18:15:32 +0100
Message-Id: <20180821171537.9330-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable bValid to valid, this clears the checkpatch
issue with CamelCase naming.

This is a coding style change which should have no impatch on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |  2 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 22 +++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index a61e3805437d..a7850b04c81b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -335,7 +335,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211_device *ieee,
 			printk("===>can't get TS\n");
 			return;
 		}
-		if (!pTxTs->tx_admitted_ba_record.bValid)
+		if (!pTxTs->tx_admitted_ba_record.valid)
 		{
 			TsStartAddBaProcess(ieee, pTxTs);
 			goto FORCED_AGG_SETTING;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index a36e8ecc6c59..9ec381c049aa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -51,7 +51,7 @@ union delba_param_set {
 
 struct ba_record {
 	struct timer_list		timer;
-	u8				bValid;
+	u8				valid;
 	u8				DialogToken;
 	union ba_param_set		BaParamSet;
 	u16				BaTimeoutValue;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 3e88333688ea..feac3cb371cd 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -18,7 +18,7 @@
  ********************************************************************************************************************/
 static void ActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA, u16 Time)
 {
-	pBA->bValid = true;
+	pBA->valid = true;
 	if (Time != 0)
 		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(Time));
 }
@@ -30,7 +30,7 @@ static void ActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA
  ********************************************************************************************************************/
 static void DeActivateBAEntry(struct ieee80211_device *ieee, struct ba_record *pBA)
 {
-	pBA->bValid = false;
+	pBA->valid = false;
 	del_timer_sync(&pBA->timer);
 }
 /********************************************************************************************************************
@@ -47,13 +47,13 @@ static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs
 	u8			bSendDELBA = false;
 
 	// Delete pending BA
-	if (pPendingBa->bValid) {
+	if (pPendingBa->valid) {
 		DeActivateBAEntry(ieee, pPendingBa);
 		bSendDELBA = true;
 	}
 
 	// Delete admitted BA
-	if (pAdmittedBa->bValid) {
+	if (pAdmittedBa->valid) {
 		DeActivateBAEntry(ieee, pAdmittedBa);
 		bSendDELBA = true;
 	}
@@ -73,7 +73,7 @@ static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs
 	struct ba_record       *pBa = &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
-	if (pBa->bValid) {
+	if (pBa->valid) {
 		DeActivateBAEntry(ieee, pBa);
 		bSendDELBA = true;
 	}
@@ -89,7 +89,7 @@ static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs
  ********************************************************************************************************************/
 void ResetBaEntry(struct ba_record *pBA)
 {
-	pBA->bValid			= false;
+	pBA->valid			= false;
 	pBA->BaParamSet.short_data	= 0;
 	pBA->BaTimeoutValue		= 0;
 	pBA->DialogToken		= 0;
@@ -478,11 +478,11 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	// Check if related BA is waiting for setup.
 	// If not, reject by sending DELBA frame.
 	//
-	if (pAdmittedBA->bValid) {
+	if (pAdmittedBA->valid) {
 		// Since BA is already setup, we ignore all other ADDBA Response.
 		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. Drop because already admit it! \n");
 		return -1;
-	} else if ((!pPendingBA->bValid) || (*pDialogToken != pPendingBA->DialogToken)) {
+	} else if ((!pPendingBA->valid) || (*pDialogToken != pPendingBA->DialogToken)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,  "OnADDBARsp(): Recv ADDBA Rsp. BA invalid, DELBA! \n");
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -617,7 +617,7 @@ TsInitAddBA(
 {
 	struct ba_record *pBA = &pTS->tx_pending_ba_record;
 
-	if (pBA->bValid && !bOverwritePending)
+	if (pBA->valid && !bOverwritePending)
 		return;
 
 	// Set parameters to "Pending" variable set
@@ -647,7 +647,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 			ieee80211_send_DELBA(
 				ieee,
 				pTsCommonInfo->addr,
-				(pTxTs->tx_admitted_ba_record.bValid)?(&pTxTs->tx_admitted_ba_record):(&pTxTs->tx_pending_ba_record),
+				(pTxTs->tx_admitted_ba_record.valid)?(&pTxTs->tx_admitted_ba_record):(&pTxTs->tx_pending_ba_record),
 				TxRxSelect,
 				DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
@@ -673,7 +673,7 @@ void BaSetupTimeOut(struct timer_list *t)
 
 	pTxTs->add_ba_req_in_progress = false;
 	pTxTs->add_ba_req_delayed = true;
-	pTxTs->tx_pending_ba_record.bValid = false;
+	pTxTs->tx_pending_ba_record.valid = false;
 }
 
 void TxBaInactTimeout(struct timer_list *t)
-- 
2.18.0

