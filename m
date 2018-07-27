Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F2F208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6suAa25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F2F208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbeG0Syz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52558 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388955AbeG0Syy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so6006956wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+cF6KGIIY91UmDmhc0sy9fX/qmt9y/8jGM5RBagCXug=;
        b=k6suAa25hb0PlnBPVNa3vbiGwwYlWY/40KpKCZNfDv8gy62gBR2o+3eGfvO4p2muaR
         3Qv0RCnXJl5C/8pao+lhjknqobEgwJxp+Js4H4askqWehi3C7JWTT+7C0Geu1YCulg0n
         nQ8fF6QaSta9s8OAWjDSqDuxhQVSWFoR6zRwzLLxckWpEV8v+G28DodsHTAD+fvJG1qK
         9LhUi2IK5U9wbC8md27YbsoLnsQ4CpzyH1EF/5becy8JMuK3GGh4nqyrvsXlkpQ3k6hh
         2g9AmLVoDQEn9wfYCK8bT+BRxe3UHTpHbFZP7vMagWW0u98cCSYJ+MSJgf5LDEBhzOXq
         2VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cF6KGIIY91UmDmhc0sy9fX/qmt9y/8jGM5RBagCXug=;
        b=dHJ4knwyJnbKVX+aAtLyGef6X1itaoQbx8O9rjBW3elrMaD3NXHq5xn0if55o7GVHt
         2wSehxm2q1VRtPSjvUsceFGoX+3iYFnWMYHZioeYOYqPNKlxo416w/v4TGDdxGxjrrvW
         1xVJTW/+JOBjR9W3tL3v1UqsC2h1UpiHBHFpv7BUweX0DsJJhoGuHJTtZFvIdhq4/2r/
         6gB6BjWt7Nc3oot2nJUXdQeUnwg3/5zNxUP5bHJSodVMIGLIjT5aMVQuYOLXgdBRImEF
         /jI8TNatFcYEMbqGJIfeLi5qq2m/elaYU/RmB1d9Ega/Ca3c5BRNYOgEXNo7+YHUIuXY
         2efg==
X-Gm-Message-State: AOUpUlE0rfpZvELQdfONXmW75pRACub4Zl69+ljwZC5KoWW1MchgtLsz
        h5ZcVtAMNrs+PXVT7qkimM4JrgNstQo=
X-Google-Smtp-Source: AAOMgpcbl2HefhrshvvvKibhHtKyzHPwp8h9NYf0P7SGINqSwwHr6HWoiKpld0n8bzcLSS6+HU2qdQ==
X-Received: by 2002:a1c:3697:: with SMTP id y23-v6mr4853086wmh.71.1532712719876;
        Fri, 27 Jul 2018 10:31:59 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/20] staging:rtl8192u: Rename RxTimeoutIndicateSeq _Style
Date:   Fri, 27 Jul 2018 18:31:17 +0100
Message-Id: <20180727173123.27391-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename member variable RxTimeoutIndicateSeq to rx_timeout_indicate_seq.
This change clears the checkpatch issue with CamelCase naming.

The resulting changes are purely coding style in nature and should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c   |  6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index e1f5161be4f3..99fb59a3b8f0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -741,7 +741,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	if (index>0) {
 		// Cancel previous pending timer.
 	//	del_timer_sync(&pTS->RxPktPendingTimer);
-		pTS->RxTimeoutIndicateSeq = 0xffff;
+		pTS->rx_timeout_indicate_seq = 0xffff;
 
 		// Indicate packets
 		if(index>REORDER_WIN_SIZE){
@@ -752,10 +752,10 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 		ieee80211_indicate_packets(ieee, prxbIndicateArray, index);
 	}
 
-	if (bPktInBuf && pTS->RxTimeoutIndicateSeq==0xffff) {
+	if (bPktInBuf && pTS->rx_timeout_indicate_seq == 0xffff) {
 		// Set new pending timer.
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): SET rx timeout timer\n", __func__);
-		pTS->RxTimeoutIndicateSeq = pTS->rx_indicate_seq;
+		pTS->rx_timeout_indicate_seq = pTS->rx_indicate_seq;
 		if(timer_pending(&pTS->RxPktPendingTimer))
 			del_timer_sync(&pTS->RxPktPendingTimer);
 		pTS->RxPktPendingTimer.expires = jiffies +
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 98be5e1b7c84..02b76d49b5e1 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -40,7 +40,7 @@ struct tx_ts_record {
 struct rx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				rx_indicate_seq;
-	u16				RxTimeoutIndicateSeq;
+	u16				rx_timeout_indicate_seq;
 	struct list_head		RxPendingPktList;
 	struct timer_list		RxPktPendingTimer;
 	BA_RECORD			RxAdmittedBARecord;	 /*  For BA Recipient */
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index ac45b502d07d..e3877f35e677 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -37,7 +37,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"==================>%s()\n",__func__);
-	if(pRxTs->RxTimeoutIndicateSeq != 0xffff) {
+	if(pRxTs->rx_timeout_indicate_seq != 0xffff) {
 		// Indicate the pending packets sequentially according to SeqNum until meet the gap.
 		while(!list_empty(&pRxTs->RxPendingPktList)) {
 			pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTs->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
@@ -64,8 +64,8 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	}
 
 	if(index>0) {
-		// Set RxTimeoutIndicateSeq to 0xffff to indicate no pending packets in buffer now.
-		pRxTs->RxTimeoutIndicateSeq = 0xffff;
+		// Set rx_timeout_indicate_seq to 0xffff to indicate no pending packets in buffer now.
+		pRxTs->rx_timeout_indicate_seq = 0xffff;
 
 		// Indicate packets
 		if(index > REORDER_WIN_SIZE) {
@@ -76,8 +76,8 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		ieee80211_indicate_packets(ieee, ieee->stats_IndicateArray, index);
 	}
 
-	if(bPktInBuf && (pRxTs->RxTimeoutIndicateSeq==0xffff)) {
-		pRxTs->RxTimeoutIndicateSeq = pRxTs->rx_indicate_seq;
+	if(bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
+		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
 		mod_timer(&pRxTs->RxPktPendingTimer,
 			  jiffies + msecs_to_jiffies(ieee->pHTInfo->RxReorderPendingTime));
 	}
@@ -125,7 +125,7 @@ static void ResetRxTsEntry(struct rx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->ts_common_info);
 	pTS->rx_indicate_seq = 0xffff; // This indicate the rx_indicate_seq is not used now!!
-	pTS->RxTimeoutIndicateSeq = 0xffff; // This indicate the RxTimeoutIndicateSeq is not used now!!
+	pTS->rx_timeout_indicate_seq = 0xffff; // This indicate the rx_timeout_indicate_seq is not used now!!
 	ResetBaEntry(&pTS->RxAdmittedBARecord);	  // For BA Recipient
 }
 
-- 
2.18.0

