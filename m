Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D36C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC494208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYBaHqAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC494208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389316AbeG0Syy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35551 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeG0Syx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so6334639wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1yqe9bXxtfpjyS3UGM/qI0ca40kRtyqexCjfXhBcck=;
        b=VYBaHqALk0ybwhwpoAMWKNTSbrbpg7QG14hJ5tGseyTPUBzEbacmO++JJ0YiS9jUeF
         TX1k0H4IAs518mjGGTGnqyo2lUJvKzgYJh7kkxr4/SxHqG8sEvMy9FrgR/PjYOhf8a4P
         NEGTCPpG/oaG8vRurHQyueje0nNuxx8BGw6XGloZq+3qjBI+BVz4tfZXKNQTQeK8vjTo
         /BCUaxui5XUKJnvZVqpf48/SqVbpG7WJN4mlzbGebLzWJ+UCbR6iVXkOhpYA2PpzM52N
         L/mFJlIjczKv/MkFD4dHNXWXe/1600kWcIYFMwRT+jIWdVzdo16dnm0OY8H9SxcqPnxO
         WZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1yqe9bXxtfpjyS3UGM/qI0ca40kRtyqexCjfXhBcck=;
        b=kq1ab2RUz9EAQ7VoUjV+BdU6w1RlcRbaPoJtyqktCBHgkbuicJbe6xOGHXHq1sIRx8
         4cdVoBGhx5RVQcUbSFCF27YzkSwZpzzaXD+TKBf0U+eBMuD2l8RjpA4D6FucHN9WO+bt
         uCkBXA9nGWmCQe4+0gxUefEXMXZawtusIaWe1FFCRD7dGU5JB7gG4JZD8kPEIyiGBg0v
         G0GFwouCHsjLVkHYbi4sYiDNGZlnZKLPHtJof36D3Sj05vPVlO9JCdRp7Wwd+B/iUPWq
         PdeRVtMnNtUAleg7wuhjqY57F+YhHsT02tGJoodFfK1ZCtBOPSHdXpxY9WosHEvGuVJR
         VAEQ==
X-Gm-Message-State: AOUpUlHAJNs4SKzLd+cg22FcDR9GG31YJxci83GMf/eQoVWrLOE++Utb
        i3Z8k8bABhn9WOVSboN2MFsmDqW3068=
X-Google-Smtp-Source: AAOMgpfeSit9El9F7lc3TWOQy3laGrprgS6z3ZoGODRwYRaBMwkTF7vHZ/BbglGr8QXipsD1obTp6Q==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr5145394wmj.124.1532712718337;
        Fri, 27 Jul 2018 10:31:58 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/20] staging:rtl8192u: Rename RxIndicateSeq - Style
Date:   Fri, 27 Jul 2018 18:31:16 +0100
Message-Id: <20180727173123.27391-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable RxIndicateSeq to rx_indicate_seq. This change
clears the checkpatch issue with CamelCase naming.

The resulting changes are purely coding style changes which should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 40 +++++++++----------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  2 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 14 +++----
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 037bd5dfb21a..e1f5161be4f3 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -592,10 +592,10 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	PRX_REORDER_ENTRY	pReorderEntry = NULL;
 	struct ieee80211_rxb **prxbIndicateArray;
 	u8			WinSize = pHTInfo->RxReorderWinSize;
-	u16			WinEnd = (pTS->RxIndicateSeq + WinSize -1)%4096;
+	u16			WinEnd = (pTS->rx_indicate_seq + WinSize - 1) % 4096;
 	u8			index = 0;
 	bool			bMatchWinStart = false, bPktInBuf = false;
-	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): Seq is %d,pTS->RxIndicateSeq is %d, WinSize is %d\n",__func__,SeqNum,pTS->RxIndicateSeq,WinSize);
+	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): Seq is %d,pTS->rx_indicate_seq is %d, WinSize is %d\n",__func__,SeqNum,pTS->rx_indicate_seq,WinSize);
 
 	prxbIndicateArray = kmalloc_array(REORDER_WIN_SIZE,
 					  sizeof(struct ieee80211_rxb *),
@@ -604,14 +604,14 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 		return;
 
 	/* Rx Reorder initialize condition.*/
-	if (pTS->RxIndicateSeq == 0xffff) {
-		pTS->RxIndicateSeq = SeqNum;
+	if (pTS->rx_indicate_seq == 0xffff) {
+		pTS->rx_indicate_seq = SeqNum;
 	}
 
 	/* Drop out the packet which SeqNum is smaller than WinStart */
-	if (SN_LESS(SeqNum, pTS->RxIndicateSeq)) {
+	if (SN_LESS(SeqNum, pTS->rx_indicate_seq)) {
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packet Drop! IndicateSeq: %d, NewSeq: %d\n",
-				 pTS->RxIndicateSeq, SeqNum);
+				 pTS->rx_indicate_seq, SeqNum);
 		pHTInfo->RxReorderDropCounter++;
 		{
 			int i;
@@ -631,16 +631,16 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	 * 1. Incoming SeqNum is equal to WinStart =>Window shift 1
 	 * 2. Incoming SeqNum is larger than the WinEnd => Window shift N
 	 */
-	if(SN_EQUAL(SeqNum, pTS->RxIndicateSeq)) {
-		pTS->RxIndicateSeq = (pTS->RxIndicateSeq + 1) % 4096;
+	if(SN_EQUAL(SeqNum, pTS->rx_indicate_seq)) {
+		pTS->rx_indicate_seq = (pTS->rx_indicate_seq + 1) % 4096;
 		bMatchWinStart = true;
 	} else if(SN_LESS(WinEnd, SeqNum)) {
 		if(SeqNum >= (WinSize - 1)) {
-			pTS->RxIndicateSeq = SeqNum + 1 -WinSize;
+			pTS->rx_indicate_seq = SeqNum + 1 -WinSize;
 		} else {
-			pTS->RxIndicateSeq = 4095 - (WinSize - (SeqNum +1)) + 1;
+			pTS->rx_indicate_seq = 4095 - (WinSize - (SeqNum + 1)) + 1;
 		}
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Window Shift! IndicateSeq: %d, NewSeq: %d\n",pTS->RxIndicateSeq, SeqNum);
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Window Shift! IndicateSeq: %d, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
 	}
 
 	/*
@@ -655,7 +655,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	if(bMatchWinStart) {
 		/* Current packet is going to be indicated.*/
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! IndicateSeq: %d, NewSeq: %d\n",\
-				pTS->RxIndicateSeq, SeqNum);
+				pTS->rx_indicate_seq, SeqNum);
 		prxbIndicateArray[0] = prxb;
 //		printk("========================>%s(): SeqNum is %d\n",__func__,SeqNum);
 		index = 1;
@@ -673,7 +673,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 
 			if(!AddReorderEntry(pTS, pReorderEntry)) {
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): Duplicate packet is dropped!! IndicateSeq: %d, NewSeq: %d\n",
-					__func__, pTS->RxIndicateSeq, SeqNum);
+					__func__, pTS->rx_indicate_seq, SeqNum);
 				list_add_tail(&pReorderEntry->List,&ieee->RxReorder_Unused_List);
 				{
 					int i;
@@ -685,7 +685,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 				}
 			} else {
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER,
-					 "Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n",pTS->RxIndicateSeq, SeqNum);
+					 "Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
 			}
 		}
 		else {
@@ -710,8 +710,8 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	while(!list_empty(&pTS->RxPendingPktList)) {
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): start RREORDER indicate\n",__func__);
 		pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pTS->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
-		if (SN_LESS(pReorderEntry->SeqNum, pTS->RxIndicateSeq) ||
-		    SN_EQUAL(pReorderEntry->SeqNum, pTS->RxIndicateSeq))
+		if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
+		    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
 		{
 			/* This protect buffer from overflow. */
 			if (index >= REORDER_WIN_SIZE) {
@@ -722,10 +722,10 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 
 			list_del_init(&pReorderEntry->List);
 
-			if(SN_EQUAL(pReorderEntry->SeqNum, pTS->RxIndicateSeq))
-				pTS->RxIndicateSeq = (pTS->RxIndicateSeq + 1) % 4096;
+			if(SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
+				pTS->rx_indicate_seq = (pTS->rx_indicate_seq + 1) % 4096;
 
-			IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packets indication!! IndicateSeq: %d, NewSeq: %d\n",pTS->RxIndicateSeq, SeqNum);
+			IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packets indication!! IndicateSeq: %d, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
 			prxbIndicateArray[index] = pReorderEntry->prxb;
 		//	printk("========================>%s(): pReorderEntry->SeqNum is %d\n",__func__,pReorderEntry->SeqNum);
 			index++;
@@ -755,7 +755,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	if (bPktInBuf && pTS->RxTimeoutIndicateSeq==0xffff) {
 		// Set new pending timer.
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): SET rx timeout timer\n", __func__);
-		pTS->RxTimeoutIndicateSeq = pTS->RxIndicateSeq;
+		pTS->RxTimeoutIndicateSeq = pTS->rx_indicate_seq;
 		if(timer_pending(&pTS->RxPktPendingTimer))
 			del_timer_sync(&pTS->RxPktPendingTimer);
 		pTS->RxPktPendingTimer.expires = jiffies +
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 0db0d01ec5c4..98be5e1b7c84 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -39,7 +39,7 @@ struct tx_ts_record {
 
 struct rx_ts_record {
 	struct ts_common_info		ts_common_info;
-	u16				RxIndicateSeq;
+	u16				rx_indicate_seq;
 	u16				RxTimeoutIndicateSeq;
 	struct list_head		RxPendingPktList;
 	struct timer_list		RxPktPendingTimer;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 8728048d3f27..ac45b502d07d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -42,14 +42,14 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		while(!list_empty(&pRxTs->RxPendingPktList)) {
 			pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTs->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
 			if(index == 0)
-				pRxTs->RxIndicateSeq = pReorderEntry->SeqNum;
+				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
 
-			if( SN_LESS(pReorderEntry->SeqNum, pRxTs->RxIndicateSeq) ||
-				SN_EQUAL(pReorderEntry->SeqNum, pRxTs->RxIndicateSeq)	) {
+			if( SN_LESS(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq) ||
+				SN_EQUAL(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq)	) {
 				list_del_init(&pReorderEntry->List);
 
-				if(SN_EQUAL(pReorderEntry->SeqNum, pRxTs->RxIndicateSeq))
-					pRxTs->RxIndicateSeq = (pRxTs->RxIndicateSeq + 1) % 4096;
+				if(SN_EQUAL(pReorderEntry->SeqNum, pRxTs->rx_indicate_seq))
+					pRxTs->rx_indicate_seq = (pRxTs->rx_indicate_seq + 1) % 4096;
 
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER,"RxPktPendingTimeout(): IndicateSeq: %d\n", pReorderEntry->SeqNum);
 				ieee->stats_IndicateArray[index] = pReorderEntry->prxb;
@@ -77,7 +77,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	}
 
 	if(bPktInBuf && (pRxTs->RxTimeoutIndicateSeq==0xffff)) {
-		pRxTs->RxTimeoutIndicateSeq = pRxTs->RxIndicateSeq;
+		pRxTs->RxTimeoutIndicateSeq = pRxTs->rx_indicate_seq;
 		mod_timer(&pRxTs->RxPktPendingTimer,
 			  jiffies + msecs_to_jiffies(ieee->pHTInfo->RxReorderPendingTime));
 	}
@@ -124,7 +124,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 static void ResetRxTsEntry(struct rx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->ts_common_info);
-	pTS->RxIndicateSeq = 0xffff; // This indicate the RxIndicateSeq is not used now!!
+	pTS->rx_indicate_seq = 0xffff; // This indicate the rx_indicate_seq is not used now!!
 	pTS->RxTimeoutIndicateSeq = 0xffff; // This indicate the RxTimeoutIndicateSeq is not used now!!
 	ResetBaEntry(&pTS->RxAdmittedBARecord);	  // For BA Recipient
 }
-- 
2.18.0

