Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA58C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A320862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnbJsiO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbeG0TAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:00:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38421 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbeG0Syl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so6266624wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uGdN9zWlyCEolBwPFNwUWq8FZVcPV2ttAPESuBptSpk=;
        b=OnbJsiO0PIBjv4PUp9DHEAMjeO5CMW9xXNWdd9JcvGaX5L/TCZDVdAAVgmHdvNPqbN
         fNxxPCb92sjJu68A3xOwqwUB33wWyA1ht8meXnPZP435Uj+BXBAG9SuV+wuKcoAZ2GKQ
         KicAgpLKVziQ89L4qMBWcPETkzxJJszBVOPwUnOjkp82VuZsHNa/R9O/WgHddgo7J2kZ
         EZJiDjWWMm8xWmGcQDht9Ufh80T5XrxUPZgMoSsqmKH0C62JvvVjmtwjGBCn4uVldLHG
         yrFSuA4GYBnh5lvH2W8/U+cNKNJK48aDY+jAJ7OYzZ2GfUoKHeaKqD8VDv1NR2OlkaQ6
         N5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uGdN9zWlyCEolBwPFNwUWq8FZVcPV2ttAPESuBptSpk=;
        b=gdtWprquHv8f4KDicMePr4CAV309DyueXeelQ+UF2Am9hghTH2pHARrYB61f9zdt9j
         9fK82alwxdhjtfvN7WnA/Rc5CIjr+Vt3pv27jcwAPYuIGAL7snY0HDzju+sfWC6g5X7a
         Wu4faR18J48TLWUZ31FmLAqdpDG405FGe6TeB+wk54GVJp+0UiZlrNRVsIfvzePTPoAC
         9LU+smWzWfKDSA+CyrLlasg5FXyA1oIQRs7E8QD+2zu0k5a+yFqEJzeNZt8L7m95Xjfq
         P1LeOSJyml+Ju8TDDnOb1D3+bQdCWAOdHiSlaGykQW5aObUp9o4e54VMIQ5ZW4PE8AjH
         7ZdA==
X-Gm-Message-State: AOUpUlFGqs6Byw6hrnjtTe2ppvXLEM2UgeKKx6YoBzP7k8XIUigHTz+s
        4KWjfF4v/GEGEoaSY2aOC9AdvTgBriw=
X-Google-Smtp-Source: AAOMgpcLIhyz2qvQ3yh55W90QUYwDGGhh3IbLlbmmCVjntN2ROXydE+fxfvLjtImHdLCXaS/coTM/w==
X-Received: by 2002:a1c:8e08:: with SMTP id q8-v6mr5440500wmd.137.1532712707810;
        Fri, 27 Jul 2018 10:31:47 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/20] staging:rtl8192u: Rename bAddBaReqInProgress - Style
Date:   Fri, 27 Jul 2018 18:31:09 +0100
Message-Id: <20180727173123.27391-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable bAddBaReqInProgress to add_ba_req_in_progress
This change clears the checkpatch issue with CamelCase naming.

Changes are purely coding style and should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 92666fdf8ca8..3430a3041560 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -469,7 +469,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		goto OnADDBARsp_Reject;
 	}
 
-	pTS->bAddBaReqInProgress = false;
+	pTS->add_ba_req_in_progress = false;
 	pPendingBA = &pTS->tx_pending_ba_record;
 	pAdmittedBA = &pTS->tx_admitted_ba_record;
 
@@ -595,7 +595,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 		}
 
 		pTxTs->bUsingBa = false;
-		pTxTs->bAddBaReqInProgress = false;
+		pTxTs->add_ba_req_in_progress = false;
 		pTxTs->bAddBaReqDelayed = false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
 		//PlatformCancelTimer(Adapter, &pTxTs->TsAddBaTimer);
@@ -671,7 +671,7 @@ void BaSetupTimeOut(struct timer_list *t)
 {
 	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_pending_ba_record.Timer);
 
-	pTxTs->bAddBaReqInProgress = false;
+	pTxTs->add_ba_req_in_progress = false;
 	pTxTs->bAddBaReqDelayed = true;
 	pTxTs->tx_pending_ba_record.bValid = false;
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index cacf9b9c295d..4d4c25c0f7c4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -32,7 +32,7 @@ struct tx_ts_record {
 	BA_RECORD			tx_pending_ba_record;	/*  For BA Originator */
 	BA_RECORD			tx_admitted_ba_record;	/*  For BA Originator */
 /* 	QOS_DL_RECORD		DLRecord; */
-	u8				bAddBaReqInProgress;
+	u8				add_ba_req_in_progress;
 	u8				bAddBaReqDelayed;
 	u8				bUsingBa;
 	struct timer_list		TsAddBaTimer;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index e347a83d6a4f..54ba60725317 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -114,7 +114,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->tx_cur_seq = 0;
-	pTS->bAddBaReqInProgress = false;
+	pTS->add_ba_req_in_progress = false;
 	pTS->bAddBaReqDelayed = false;
 	pTS->bUsingBa = false;
 	ResetBaEntry(&pTS->tx_admitted_ba_record); //For BA Originator
@@ -522,8 +522,8 @@ void RemoveAllTS(struct ieee80211_device *ieee)
 
 void TsStartAddBaProcess(struct ieee80211_device *ieee, struct tx_ts_record *pTxTS)
 {
-	if(!pTxTS->bAddBaReqInProgress) {
-		pTxTS->bAddBaReqInProgress = true;
+	if(!pTxTS->add_ba_req_in_progress) {
+		pTxTS->add_ba_req_in_progress = true;
 		if(pTxTS->bAddBaReqDelayed)	{
 			IEEE80211_DEBUG(IEEE80211_DL_BA, "TsStartAddBaProcess(): Delayed Start ADDBA after 60 sec!!\n");
 			mod_timer(&pTxTS->TsAddBaTimer,
-- 
2.18.0

