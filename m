Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A7BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9F21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th3vsRZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9F21837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeHUUhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39479 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbeHUUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so3533626wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyLwx686wU+dSGpt0yvOxdyskzF4F6A9uy8a9IJuyNA=;
        b=Th3vsRZD5gwM8E6n25fF9Ab1SpqlKkur2EWLI3YMP3SRDtAjd6LgZe6lDrC6ADKiIi
         cISqGWrS8pOnUBk9XQFusXM3hQ+rhsvSqUdYZQRNCpE8ohiMEP6Wr+MDoB1vYqvSYo23
         jxE56ucgmPmAkA1zfEGFj/DjOU3sugXuYmNCLziAZdFZfbO17M6e+d6ZNgr94gcYk5tA
         MhF6QtYH015Gqf5Osv9is1+4W3FI0f5tPXZu0NGbVCutG6R7XgJZA4mbqTXE8TMsJ8uX
         T3ncpP2tH88EuxacJuBzbsTQuhNGr5EnDfz48+5xGrny1MN6pyZtZC2mkRf8YxG9zJpo
         AlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyLwx686wU+dSGpt0yvOxdyskzF4F6A9uy8a9IJuyNA=;
        b=XnR412GQJi56JUrsaW85Oe8DuRNRcSj/75aK6+nbb9CLIgJV9PulaQyJ93l6yo8WYN
         JUtsRUNkR7nVqwFDAk/xMH6LXiYKGE8+Oz4XqKXGF1kqOAbu0qUhO/uHkXMui2i8Gx0/
         s8vD+uotORkwuGz1Br57omLOwny54gDO/1a05GK7GnNZYb604jC6m1IsafGVdYr/GZsE
         zeyjSMWaEbcAhvpAiBNmbV2Z9fK0HFTqAAHa6fYNgSCNB/MMoxSpdPs2x0gRi+yYcVK5
         dWbzwQABHDyb/Te4LA3eUMaPIGd0WKu19/660jBT7om7oxnyl0GY6T+QGprcgXAQzRe7
         K6Vg==
X-Gm-Message-State: APzg51BdvvmMJWIX13CM5DsSz2Wgwv8+MDKYOvkssgXjGAHoiY0Cd1wI
        xSUDna0SiwRO+AcIt34MVa0QFU7fUiU=
X-Google-Smtp-Source: ANB0VdZg5fyAtB5CxvI16/KJIL88xyVVs7i7Yq8SP3gMS36Des8PSN+nx+C+nNqTlqib10iYqILxSw==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr191426wmg.44.1534871761014;
        Tue, 21 Aug 2018 10:16:01 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:16:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/17] staging:rtl8192u: Rename DialogToken - Style
Date:   Tue, 21 Aug 2018 18:15:33 +0100
Message-Id: <20180821171537.9330-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable DialogToken to dialog_token. This clears
the checkpatch issue with CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 9ec381c049aa..948888224f24 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -52,7 +52,7 @@ union delba_param_set {
 struct ba_record {
 	struct timer_list		timer;
 	u8				valid;
-	u8				DialogToken;
+	u8				dialog_token;
 	union ba_param_set		BaParamSet;
 	u16				BaTimeoutValue;
 	union sequence_control	BaStartSeqCtrl;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index feac3cb371cd..21398892b0e5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -92,7 +92,7 @@ void ResetBaEntry(struct ba_record *pBA)
 	pBA->valid			= false;
 	pBA->BaParamSet.short_data	= 0;
 	pBA->BaTimeoutValue		= 0;
-	pBA->DialogToken		= 0;
+	pBA->dialog_token		= 0;
 	pBA->BaStartSeqCtrl.short_data	= 0;
 }
 //These functions need porting here or not?
@@ -140,7 +140,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211_device *ieee, u8 *Dst, s
 	*tag++ = ACT_CAT_BA;
 	*tag++ = type;
 	// Dialog Token
-	*tag++ = pBA->DialogToken;
+	*tag++ = pBA->dialog_token;
 
 	if (ACT_ADDBARSP == type) {
 		// Status Code
@@ -382,7 +382,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 		// Admit the ADDBA Request
 	//
 	DeActivateBAEntry(ieee, pBA);
-	pBA->DialogToken = *pDialogToken;
+	pBA->dialog_token = *pDialogToken;
 	pBA->BaParamSet = *pBaParamSet;
 	pBA->BaTimeoutValue = *pBaTimeoutVal;
 	pBA->BaStartSeqCtrl = *pBaStartSeqCtrl;
@@ -402,7 +402,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 		struct ba_record	BA;
 		BA.BaParamSet = *pBaParamSet;
 		BA.BaTimeoutValue = *pBaTimeoutVal;
-		BA.DialogToken = *pDialogToken;
+		BA.dialog_token = *pDialogToken;
 		BA.BaParamSet.field.ba_policy = BA_POLICY_IMMEDIATE;
 		ieee80211_send_ADDBARsp(ieee, dst, &BA, rc);
 		return 0; //we send RSP out.
@@ -482,7 +482,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		// Since BA is already setup, we ignore all other ADDBA Response.
 		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. Drop because already admit it! \n");
 		return -1;
-	} else if ((!pPendingBA->valid) || (*pDialogToken != pPendingBA->DialogToken)) {
+	} else if ((!pPendingBA->valid) || (*pDialogToken != pPendingBA->dialog_token)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,  "OnADDBARsp(): Recv ADDBA Rsp. BA invalid, DELBA! \n");
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -510,7 +510,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		//
 		// Admitted condition
 		//
-		pAdmittedBA->DialogToken = *pDialogToken;
+		pAdmittedBA->dialog_token = *pDialogToken;
 		pAdmittedBA->BaTimeoutValue = *pBaTimeoutVal;
 		pAdmittedBA->BaStartSeqCtrl = pPendingBA->BaStartSeqCtrl;
 		pAdmittedBA->BaParamSet = *pBaParamSet;
@@ -623,7 +623,7 @@ TsInitAddBA(
 	// Set parameters to "Pending" variable set
 	DeActivateBAEntry(ieee, pBA);
 
-	pBA->DialogToken++;						// DialogToken: Only keep the latest dialog token
+	pBA->dialog_token++;						// DialogToken: Only keep the latest dialog token
 	pBA->BaParamSet.field.amsdu_support = 0;	// Do not support A-MSDU with A-MPDU now!!
 	pBA->BaParamSet.field.ba_policy = Policy;	// Policy: Delayed or Immediate
 	pBA->BaParamSet.field.tid = pTS->ts_common_info.t_spec.ts_info.uc_tsid;	// TID
-- 
2.18.0

