Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C888208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5OH0ILv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C888208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbeG0SzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36816 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeG0Sy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so5818051wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PMq9drPf1Hxh/OS+1c2X7jEfU3s93OLPMzPdY+lWZng=;
        b=b5OH0ILvrt2NzrnCeB/HIELyfY/TRbcF0m2wErZoMLThZNJvqyJIZ6df5WRuPMNKqh
         8bVt+SZdJ6qF9eLfbpbS18EpLkM3Npb5A2XUjKXrXcTFH+xAumLQLLY58ohy3GC6TDFc
         lG7qxCAuL32mvkixAYPIvorsvsMmccAulhJCjhgIUZwgzxzlUebOuOasV4/We+17cu7u
         DrRSzUJKIAmDfjddkOih0H9GI1yKN2U81l9o0P80785WnpXX/uXGewOBAY+fFkY3/Umd
         fX1e5PWag591YQhnuWIVdBHqSNruBb48f5ChI7+BYdQ5en3atAqqBmYC4yA2DdgWa45Y
         7Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PMq9drPf1Hxh/OS+1c2X7jEfU3s93OLPMzPdY+lWZng=;
        b=rO9mnyaFlr7Yuuf4ZKoWyn/zWDq0lo4H+UMJnCgvWitkd4pL8aiJWgIMuZkr9as/dL
         ZyD0mYKgg8BzYnxCwgocaZjSapSBfQp4a6vGVfuv1+76WPDHrNBuh5zVUdZINr91bJ4X
         DP8hFOZZi9222IQ0WpeIEJR8WM/rz38uGh6Mb419fx8jkvj+o+nsh8ChZn1ide5RMEHf
         jKsjjF6Un742zEF5TAF6UOpNVZOT6K96AOdC3VQa9eiN5f4Icp++ioTmecsEImzQSr+e
         sFYr4LwqRZRvjyRTskFwqCPVuk3UKpPazdS7iS2t7UChVb7CAga/XkbW3TDeYOjjtXcA
         3OMA==
X-Gm-Message-State: AOUpUlEXA/8zERFaO67kvhMKqVl+j0V3hqfa7UdRUezW4x09XfWX1BpY
        wbzzHqmK1YcmozM1f6HEI7DlhHSZJsU=
X-Google-Smtp-Source: AAOMgpcqMHJS8nI3uAXTghRZnxm89Gn1CwsQchx6s9SWyEhG4Odf6GBnjbDBugdOdPnUDweKDbN8pg==
X-Received: by 2002:adf:9bc9:: with SMTP id e9-v6mr5921760wrc.240.1532712724336;
        Fri, 27 Jul 2018 10:32:04 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:32:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/20] staging:rtl8192u: Rename RxAdmittedBARecord - Style
Date:   Fri, 27 Jul 2018 18:31:20 +0100
Message-Id: <20180727173123.27391-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable RxAdmittedBARecord to rx_admitted_ba_record.
This change clears the checkpatch issue with CamelCase naming.

The resulting changes are coding style in nature and as such should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index c2a51a6c2969..e296813203aa 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -70,7 +70,7 @@ static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs
  ********************************************************************************************************************/
 static u8 RxTsDeleteBA(struct ieee80211_device *ieee, struct rx_ts_record *pRxTs)
 {
-	PBA_RECORD		pBa = &pRxTs->RxAdmittedBARecord;
+	PBA_RECORD		pBa = &pRxTs->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
 	if (pBa->bValid) {
@@ -369,7 +369,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't get TS in %s()\n", __func__);
 		goto OnADDBAReq_Fail;
 	}
-	pBA = &pTS->RxAdmittedBARecord;
+	pBA = &pTS->rx_admitted_ba_record;
 	// To Determine the ADDBA Req content
 	// We can do much more check here, including BufferSize, AMSDU_Support, Policy, StartSeqCtrl...
 	// I want to check StartSeqCtrl to make sure when we start aggregation!!!
@@ -656,7 +656,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 			ieee80211_send_DELBA(
 				ieee,
 				pTsCommonInfo->addr,
-				&pRxTs->RxAdmittedBARecord,
+				&pRxTs->rx_admitted_ba_record,
 				TxRxSelect,
 				DELBA_REASON_END_BA);
 	}
@@ -691,14 +691,14 @@ void TxBaInactTimeout(struct timer_list *t)
 
 void RxBaInactTimeout(struct timer_list *t)
 {
-	struct rx_ts_record *pRxTs = from_timer(pRxTs, t, RxAdmittedBARecord.Timer);
+	struct rx_ts_record *pRxTs = from_timer(pRxTs, t, rx_admitted_ba_record.Timer);
 	struct ieee80211_device *ieee = container_of(pRxTs, struct ieee80211_device, RxTsRecord[pRxTs->num]);
 
 	RxTsDeleteBA(ieee, pRxTs);
 	ieee80211_send_DELBA(
 		ieee,
 		pRxTs->ts_common_info.addr,
-		&pRxTs->RxAdmittedBARecord,
+		&pRxTs->rx_admitted_ba_record,
 		RX_DIR,
 		DELBA_REASON_TIMEOUT);
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index a338d53ff88c..7cc13e5dfb2d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -43,7 +43,7 @@ struct rx_ts_record {
 	u16				rx_timeout_indicate_seq;
 	struct list_head		rx_pending_pkt_list;
 	struct timer_list		rx_pkt_pending_timer;
-	BA_RECORD			RxAdmittedBARecord;	 /*  For BA Recipient */
+	BA_RECORD			rx_admitted_ba_record;	 /*  For BA Recipient */
 	u16				RxLastSeqNum;
 	u8				RxLastFragNum;
 	u8				num;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index aad2704a7f46..a44536d8cd42 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -126,7 +126,7 @@ static void ResetRxTsEntry(struct rx_ts_record *pTS)
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->rx_indicate_seq = 0xffff; // This indicate the rx_indicate_seq is not used now!!
 	pTS->rx_timeout_indicate_seq = 0xffff; // This indicate the rx_timeout_indicate_seq is not used now!!
-	ResetBaEntry(&pTS->RxAdmittedBARecord);	  // For BA Recipient
+	ResetBaEntry(&pTS->rx_admitted_ba_record);	  // For BA Recipient
 }
 
 void TSInitialize(struct ieee80211_device *ieee)
@@ -171,7 +171,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 			    0);
 		timer_setup(&pRxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
-		timer_setup(&pRxTS->RxAdmittedBARecord.Timer,
+		timer_setup(&pRxTS->rx_admitted_ba_record.Timer,
 			    RxBaInactTimeout, 0);
 		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
 		ResetRxTsEntry(pRxTS);
-- 
2.18.0

