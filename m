Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B933208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zonev8OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B933208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389368AbeG0Sy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43936 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388955AbeG0Sy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so5790192wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zvagxvPzr1gIGaQdP/vNEpoN/X7woYzNxyZGGkp+Gfs=;
        b=Zonev8OPpKN8G2nm8Jw0P1nf2ElPpwjx2WQOy5MTkJ3wkF5Y0anJarOOLJLZjErspP
         qnLH+/0SIOn6oBJ0tKm106ijUdRUZY0OpWrnXgAH/dBJtSEi8h5nP1GEASRdi16iEh8C
         ZR4W78IAhnJY8VjlsREUJDp+zYwM1lJ1Xm38ttqjrRyND5cANCj726uMFO6z0bN27HPA
         l8+v+76nMXfl/HR43InipC+vTv14Y+CxDGuJ0pBxrN9QIwOo4cLD41O8E/E89VKjyGpK
         j6Dl3W/O7uyZO0gQaa4M5WBigm6/UzkTDSjDgaKSMeU81EUjCMHmZmkAc4oyLAnkTlkc
         wG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zvagxvPzr1gIGaQdP/vNEpoN/X7woYzNxyZGGkp+Gfs=;
        b=P49o7GhCZPMGucmZP1yEGct1jTGbMZOxZg+/8ODidtwq2Lckp5zQhjWJF10BE7PKVt
         Ly/W1pVZRQGatO0p+3VENGlKlxbAY8kA9dDD6O8ZJN1cuLb58QzhYKnwb50TXy8ueCpm
         s/qW/1oino0VQ8m64Ne18G0YpZoUs+3IUY53N2XNsUEhoJNhyC4cnD2jkkzcOewOEhZ2
         pXyKUoBTvADyMAYjxDSRRes/PWikJ12SzZoUttvdJ9Azq3QJ8mwZVQR09KW0GL0fE0SJ
         JR//T4HJ6UQoDKSZGrJ44ZxwJw0gcIC1TtZvaxIwxCmq4RNiq9hjUrj/nyFizNK3z8E8
         YNAA==
X-Gm-Message-State: AOUpUlFjAaVKOzD3LH/QGmrNYHQxgublj95T5+OBAtYAFNTYhxF94pvz
        k8o6y03GY2U60NAOkfz8hX4H38taugE=
X-Google-Smtp-Source: AAOMgpcyJqOweZuWQuoPuxjupiibuWe6J6Ut0uw9TsuvyiJbzkkq0T3SYD74ZdWdDCNnJDpCqjsHig==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr534553wri.221.1532712722881;
        Fri, 27 Jul 2018 10:32:02 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:32:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/20] staging:rtl8192u: Rename RxPktPendingTimer - Style
Date:   Fri, 27 Jul 2018 18:31:19 +0100
Message-Id: <20180727173123.27391-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable RxPktPendingTimer to rx_pkt_pending_timer.
This change clears the checkpatch issue with CamelCase naming.

The resulting changes are coding style changes in nature so should
have no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c   | 10 +++++-----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 0a1f433def2f..5a2a7a4aedca 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -740,7 +740,7 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	/* Handling pending timer. Set this timer to prevent from long time Rx buffering.*/
 	if (index>0) {
 		// Cancel previous pending timer.
-	//	del_timer_sync(&pTS->RxPktPendingTimer);
+	//	del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_timeout_indicate_seq = 0xffff;
 
 		// Indicate packets
@@ -756,11 +756,11 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 		// Set new pending timer.
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): SET rx timeout timer\n", __func__);
 		pTS->rx_timeout_indicate_seq = pTS->rx_indicate_seq;
-		if(timer_pending(&pTS->RxPktPendingTimer))
-			del_timer_sync(&pTS->RxPktPendingTimer);
-		pTS->RxPktPendingTimer.expires = jiffies +
+		if(timer_pending(&pTS->rx_pkt_pending_timer))
+			del_timer_sync(&pTS->rx_pkt_pending_timer);
+		pTS->rx_pkt_pending_timer.expires = jiffies +
 				msecs_to_jiffies(pHTInfo->RxReorderPendingTime);
-		add_timer(&pTS->RxPktPendingTimer);
+		add_timer(&pTS->rx_pkt_pending_timer);
 	}
 
 	kfree(prxbIndicateArray);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 9c85d3623578..a338d53ff88c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -42,7 +42,7 @@ struct rx_ts_record {
 	u16				rx_indicate_seq;
 	u16				rx_timeout_indicate_seq;
 	struct list_head		rx_pending_pkt_list;
-	struct timer_list		RxPktPendingTimer;
+	struct timer_list		rx_pkt_pending_timer;
 	BA_RECORD			RxAdmittedBARecord;	 /*  For BA Recipient */
 	u16				RxLastSeqNum;
 	u8				RxLastFragNum;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 6a6aad6decd6..aad2704a7f46 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -25,7 +25,7 @@ static void TsInactTimeout(struct timer_list *unused)
  ********************************************************************************************************************/
 static void RxPktPendingTimeout(struct timer_list *t)
 {
-	struct rx_ts_record     *pRxTs = from_timer(pRxTs, t, RxPktPendingTimer);
+	struct rx_ts_record     *pRxTs = from_timer(pRxTs, t, rx_pkt_pending_timer);
 	struct ieee80211_device *ieee = container_of(pRxTs, struct ieee80211_device, RxTsRecord[pRxTs->num]);
 
 	PRX_REORDER_ENTRY	pReorderEntry = NULL;
@@ -78,7 +78,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 
 	if(bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
 		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
-		mod_timer(&pRxTs->RxPktPendingTimer,
+		mod_timer(&pRxTs->rx_pkt_pending_timer,
 			  jiffies + msecs_to_jiffies(ieee->pHTInfo->RxReorderPendingTime));
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
@@ -173,7 +173,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 			    0);
 		timer_setup(&pRxTS->RxAdmittedBARecord.Timer,
 			    RxBaInactTimeout, 0);
-		timer_setup(&pRxTS->RxPktPendingTimer, RxPktPendingTimeout, 0);
+		timer_setup(&pRxTS->rx_pkt_pending_timer, RxPktPendingTimeout, 0);
 		ResetRxTsEntry(pRxTS);
 		list_add_tail(&pRxTS->ts_common_info.list, &ieee->Rx_TS_Unused_List);
 		pRxTS++;
@@ -420,8 +420,8 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 //#ifdef TO_DO_LIST
 		PRX_REORDER_ENTRY	pRxReorderEntry;
 		struct rx_ts_record     *pRxTS = (struct rx_ts_record *)pTs;
-		if(timer_pending(&pRxTS->RxPktPendingTimer))
-			del_timer_sync(&pRxTS->RxPktPendingTimer);
+		if(timer_pending(&pRxTS->rx_pkt_pending_timer))
+			del_timer_sync(&pRxTS->rx_pkt_pending_timer);
 
 		while(!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
-- 
2.18.0

