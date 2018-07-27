Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADCBC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBB2208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnOCscgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBB2208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbeG0Syo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55211 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbeG0Syo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so6027668wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a6i4A851T1SOaZPJZrmSuW09rKEPD2/L6EN85FmQv0k=;
        b=LnOCscgqP3FD4CTNdk0So8qDcTaXNI/Z/bttgkIYKfKgAr9paD1butTBQZMaQWMP5b
         oLZDddPBskar3T7LVKcvSqRyI4aQ6UCZ3WMLP8JzbZmBmLe+1C6w2lnBs3kwQM2agd7N
         XxgDWaPEYCFAiHfDYNqhXvuW541XhspdRskOvfNApJ9an/lBb/y/LRhIqirX31Y2ieQt
         wXvf2/qVrIBBbwj9aNCLX96CPle6HHglL2ylBt2ZO7MoU8gixIvjo6NgriMoFnJ02qXH
         AqhDJwkC7cXq0SeeGhH9LGstuVeY1ByrlFGVIa57Iz0ZZnOYXm5djwe20qVEF8V4ur3G
         sDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a6i4A851T1SOaZPJZrmSuW09rKEPD2/L6EN85FmQv0k=;
        b=Ow54twgI9desllchHD+Yk4I9duMjf/WrXXgdGVmrtwZUUbbXpzUh+gmBx7tz/XLCK3
         pv4D7weuBQDujqbqXJLY+H988LPZY5gtYGa2hFyCXsWJav9n4q0lnwxUBX2HjfZXoEfG
         voVv3EXzSY20c3nz+Nz+gKn7bgn3yXPc3pTiET8ny1g9GauETNHMtj6R68XAhUw8AHUN
         9+PZypwIyQF4t9Dgkw1oIvWDuUhl41DPMAG9BMhCrMZMBz1zW1YRoXcVYMpeBMvpKJJx
         x819B7VISwIZMw/4BzcVwpszSDf+HBLcrBwHj2VcToCOdqsBl2DuxAZXLUyhccdI0mal
         ERBw==
X-Gm-Message-State: AOUpUlHt9vy3om4F4doXxf0vagcH5r0FO8WxoHe8AwgKNKxYq3AwCONc
        QLg3zGCPApxbPbCwTMyIx7X7pCpFKJY=
X-Google-Smtp-Source: AAOMgpfbzayQUIb7f0SmQOciJi7HcIg4YvQhGTtUQGqKIpoRCJ8bwpTnZwA28cUiTN2gBc+/3W0GcQ==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr5144880wmj.124.1532712709345;
        Fri, 27 Jul 2018 10:31:49 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:48 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/20] staging:rtl8192u: Rename bAddBaReqDelayed - Style
Date:   Fri, 27 Jul 2018 18:31:10 +0100
Message-Id: <20180727173123.27391-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable bAddBaReqDelayed to add_ba_req_delayed
This change clears the checkpatch issue with CamelCase naming.

The resulting changes are purely coding style changes which should
have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 8 ++++----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 3430a3041560..93967e56916c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -500,7 +500,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		//
 		if (pBaParamSet->field.BAPolicy == BA_POLICY_DELAYED) {
 			// Since this is a kind of ADDBA failed, we delay next ADDBA process.
-			pTS->bAddBaReqDelayed = true;
+			pTS->add_ba_req_delayed = true;
 			DeActivateBAEntry(ieee, pAdmittedBA);
 			ReasonCode = DELBA_REASON_END_BA;
 			goto OnADDBARsp_Reject;
@@ -518,7 +518,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 		ActivateBAEntry(ieee, pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		// Delay next ADDBA process.
-		pTS->bAddBaReqDelayed = true;
+		pTS->add_ba_req_delayed = true;
 	}
 
 	// End of procedure
@@ -596,7 +596,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb)
 
 		pTxTs->bUsingBa = false;
 		pTxTs->add_ba_req_in_progress = false;
-		pTxTs->bAddBaReqDelayed = false;
+		pTxTs->add_ba_req_delayed = false;
 		del_timer_sync(&pTxTs->TsAddBaTimer);
 		//PlatformCancelTimer(Adapter, &pTxTs->TsAddBaTimer);
 		TxTsDeleteBA(ieee, pTxTs);
@@ -672,7 +672,7 @@ void BaSetupTimeOut(struct timer_list *t)
 	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_pending_ba_record.Timer);
 
 	pTxTs->add_ba_req_in_progress = false;
-	pTxTs->bAddBaReqDelayed = true;
+	pTxTs->add_ba_req_delayed = true;
 	pTxTs->tx_pending_ba_record.bValid = false;
 }
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 4d4c25c0f7c4..4c11ed776c25 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -33,7 +33,7 @@ struct tx_ts_record {
 	BA_RECORD			tx_admitted_ba_record;	/*  For BA Originator */
 /* 	QOS_DL_RECORD		DLRecord; */
 	u8				add_ba_req_in_progress;
-	u8				bAddBaReqDelayed;
+	u8				add_ba_req_delayed;
 	u8				bUsingBa;
 	struct timer_list		TsAddBaTimer;
 	u8				num;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 54ba60725317..ba7763265c08 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -115,7 +115,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->tx_cur_seq = 0;
 	pTS->add_ba_req_in_progress = false;
-	pTS->bAddBaReqDelayed = false;
+	pTS->add_ba_req_delayed = false;
 	pTS->bUsingBa = false;
 	ResetBaEntry(&pTS->tx_admitted_ba_record); //For BA Originator
 	ResetBaEntry(&pTS->tx_pending_ba_record);
@@ -524,7 +524,7 @@ void TsStartAddBaProcess(struct ieee80211_device *ieee, struct tx_ts_record *pTx
 {
 	if(!pTxTS->add_ba_req_in_progress) {
 		pTxTS->add_ba_req_in_progress = true;
-		if(pTxTS->bAddBaReqDelayed)	{
+		if(pTxTS->add_ba_req_delayed)	{
 			IEEE80211_DEBUG(IEEE80211_DL_BA, "TsStartAddBaProcess(): Delayed Start ADDBA after 60 sec!!\n");
 			mod_timer(&pTxTS->TsAddBaTimer,
 				  jiffies + msecs_to_jiffies(TS_ADDBA_DELAY));
-- 
2.18.0

