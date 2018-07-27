Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25296C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4320862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmuw6Zsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeG0Sy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39794 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeG0Sy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so6259202wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ftfe38b24mLEXR5z3+wUvh0iiKpqK72kgHIElTfePzE=;
        b=Tmuw6ZswHEV+Ud/SdROpqjT27QypeIVMrvs69cPrO0UzsoY83VMZqKNZTFfZW7c5Bt
         zojib5NUit7/SbYHDUnjjatpOLJRIfHCRPKojo2BoUR9HfI+8zpWOALyVCQapitbGIDN
         uCQHrTKhwdR/pWHfZTES/3eqJQfWQ/DXXZZcC/7gpTQ/IGRxj18sm9CimRyS6aqtpob2
         aF9MjVi4NxdeNB6LwzCzjBJJE30rHXsdMz5amP2WqCn+v9PpgiXrGrFmk0g+bbzv/n7o
         tWKa/x6gq9+T/aPt17WYWqRZsm5b/sUIi6TLYBeFCWpuWIKJ9VqwIiC5YvKbnCzGAjJ6
         jeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ftfe38b24mLEXR5z3+wUvh0iiKpqK72kgHIElTfePzE=;
        b=KGq7m/wYTWrJSYwMv9p7TgPNyMICCcFt/7FY24f0mkDyD9g4AU4+zoSd860i/3gBgh
         lXRwUp7cyQOYfws8qwBnQydAUmSVQOyFwsFGGDvq6YFu8OQ/I/52nNSOgHE2olNcrQ1R
         O+bOUTuMbAJejvXDb3mcN7lYpgvtNP54G8y1A2QvCMtqyny4YQQU9ghFINq5PFKQuysn
         8Zj27q2n5a4F01vgVOj6RM6zlXOm89hgp/piI4ZzSr9FEG3p91mfKWF/oiAeyNspsgrq
         qOff41u7oqu4EmX31VdkWEoe0G3ZtqKFbFVelpkm9ULq5HPcpAMXhfycOXECuVVqqFBP
         wI5w==
X-Gm-Message-State: AOUpUlEY9LY74ATquIF3z1RC1gWL03s6FCc2EiChrB1zgJalysxXPEuI
        chHdEszkJwaK84dzTBK85UBerwJ7zDw=
X-Google-Smtp-Source: AAOMgpcRbvJKqjbsLyN38ePKmsNwvGvXBSVe1I2dfBNY/N9Xj/zdxeZEAQj0pmcPZpkasygn7tcqhA==
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr4956438wmi.116.1532712721392;
        Fri, 27 Jul 2018 10:32:01 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:32:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/20] staging:rtl8192u: Rename RxPendingPktList - Style
Date:   Fri, 27 Jul 2018 18:31:18 +0100
Message-Id: <20180727173123.27391-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable RxPendingPktList to rx_pending_pkt_list.
This change resolves the checkpatch issue with CamelCase naming.

The resulting changes are purely coding style changes which should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c   |  8 ++++----
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 99fb59a3b8f0..0a1f433def2f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -510,8 +510,8 @@ static int is_duplicate_packet(struct ieee80211_device *ieee,
 
 static bool AddReorderEntry(struct rx_ts_record *pTS, PRX_REORDER_ENTRY pReorderEntry)
 {
-	struct list_head *pList = &pTS->RxPendingPktList;
-	while(pList->next != &pTS->RxPendingPktList)
+	struct list_head *pList = &pTS->rx_pending_pkt_list;
+	while(pList->next != &pTS->rx_pending_pkt_list)
 	{
 		if( SN_LESS(pReorderEntry->SeqNum, ((PRX_REORDER_ENTRY)list_entry(pList->next,RX_REORDER_ENTRY,List))->SeqNum) )
 		{
@@ -707,9 +707,9 @@ static void RxReorderIndicatePacket(struct ieee80211_device *ieee,
 	}
 
 	/* Check if there is any packet need indicate.*/
-	while(!list_empty(&pTS->RxPendingPktList)) {
+	while(!list_empty(&pTS->rx_pending_pkt_list)) {
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): start RREORDER indicate\n",__func__);
-		pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pTS->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
+		pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pTS->rx_pending_pkt_list.prev,RX_REORDER_ENTRY,List);
 		if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
 		    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
 		{
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 02b76d49b5e1..9c85d3623578 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -41,7 +41,7 @@ struct rx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				rx_indicate_seq;
 	u16				rx_timeout_indicate_seq;
-	struct list_head		RxPendingPktList;
+	struct list_head		rx_pending_pkt_list;
 	struct timer_list		RxPktPendingTimer;
 	BA_RECORD			RxAdmittedBARecord;	 /*  For BA Recipient */
 	u16				RxLastSeqNum;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index e3877f35e677..6a6aad6decd6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -39,8 +39,8 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"==================>%s()\n",__func__);
 	if(pRxTs->rx_timeout_indicate_seq != 0xffff) {
 		// Indicate the pending packets sequentially according to SeqNum until meet the gap.
-		while(!list_empty(&pRxTs->RxPendingPktList)) {
-			pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTs->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
+		while(!list_empty(&pRxTs->rx_pending_pkt_list)) {
+			pReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTs->rx_pending_pkt_list.prev,RX_REORDER_ENTRY,List);
 			if(index == 0)
 				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
 
@@ -166,7 +166,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
 	for(count = 0; count < TOTAL_TS_NUM; count++) {
 		pRxTS->num = count;
-		INIT_LIST_HEAD(&pRxTS->RxPendingPktList);
+		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
 		timer_setup(&pRxTS->ts_common_info.setup_timer, TsSetupTimeOut,
 			    0);
 		timer_setup(&pRxTS->ts_common_info.inact_timer, TsInactTimeout,
@@ -423,10 +423,10 @@ static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common_info *
 		if(timer_pending(&pRxTS->RxPktPendingTimer))
 			del_timer_sync(&pRxTS->RxPktPendingTimer);
 
-		while(!list_empty(&pRxTS->RxPendingPktList)) {
+		while(!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
-			//pRxReorderEntry = list_entry(&pRxTS->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
-			pRxReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTS->RxPendingPktList.prev,RX_REORDER_ENTRY,List);
+			//pRxReorderEntry = list_entry(&pRxTS->rx_pending_pkt_list.prev,RX_REORDER_ENTRY,List);
+			pRxReorderEntry = (PRX_REORDER_ENTRY)list_entry(pRxTS->rx_pending_pkt_list.prev,RX_REORDER_ENTRY,List);
 			list_del_init(&pRxReorderEntry->List);
 			{
 				int i = 0;
-- 
2.18.0

