Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeEUUtQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:49:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38789 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEUUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:49:13 -0400
X-Google-Smtp-Source: AB8JxZpDBdnCA2GqkgnCv676m2XfpocVn4H4FtL5pP0/LGqgdyHYcen0Ew2SzULQZto/MtXm2WARpA==
From: Davide Spataro <davide90.spataro@gmail.com>
To: gregkh@linuxfoundation.org
Cc: stephen@networkplumber.org, davem@davemloft.net,
        johannes.berg@intel.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Davide Spataro <davide90.spataro@gmail.com>
Subject: [PATCH] staging: rtl8192e: rtllib_tx: fix spelling issue.
Date: Mon, 21 May 2018 22:48:57 +0200
Message-Id: <20180521204857.6416-1-davide90.spataro@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling problem. Issue found by checkpatch.pl.

Signed-off-by: Davide Spataro <davide90.spataro@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index fc88d47dea43..d314b2f602e4 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -578,7 +578,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		.seq_ctl = 0,
 		.qos_ctl = 0
 	};
-	int qos_actived = ieee->current_network.qos_data.active;
+	int qos_activated = ieee->current_network.qos_data.active;
 	u8 dest[ETH_ALEN];
 	u8 src[ETH_ALEN];
 	struct lib80211_crypt_data *crypt = NULL;
@@ -684,7 +684,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		else
 			fc = RTLLIB_FTYPE_DATA;
 
-		if (qos_actived)
+		if (qos_activated)
 			fc |= RTLLIB_STYPE_QOS_DATA;
 		else
 			fc |= RTLLIB_STYPE_DATA;
@@ -727,7 +727,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			qos_ctl = 0;
 		}
 
-		if (qos_actived) {
+		if (qos_activated) {
 			hdr_len = RTLLIB_3ADDR_LEN + 2;
 
 			/* in case we are a client verify acm is not set for this ac */
@@ -788,7 +788,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		txb->encrypted = encrypt;
 		txb->payload_size = cpu_to_le16(bytes);
 
-		if (qos_actived)
+		if (qos_activated)
 			txb->queue_index = UP2AC(skb->priority);
 		else
 			txb->queue_index = WME_AC_BE;
@@ -797,7 +797,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			skb_frag = txb->fragments[i];
 			tcb_desc = (struct cb_desc *)(skb_frag->cb +
 				    MAX_DEV_ADDR_SIZE);
-			if (qos_actived) {
+			if (qos_activated) {
 				skb_frag->priority = skb->priority;
 				tcb_desc->queue_index =  UP2AC(skb->priority);
 			} else {
@@ -831,7 +831,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				/* The last fragment has the remaining length */
 				bytes = bytes_last_frag;
 			}
-			if ((qos_actived) && (!bIsMulticast)) {
+			if ((qos_activated) && (!bIsMulticast)) {
 				frag_hdr->seq_ctl =
 					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
 							     header.addr1));
@@ -866,7 +866,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				skb_put(skb_frag, 4);
 		}
 
-		if ((qos_actived) && (!bIsMulticast)) {
+		if ((qos_activated) && (!bIsMulticast)) {
 			if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] == 0xFFF)
 				ieee->seq_ctrl[UP2AC(skb->priority) + 1] = 0;
 			else
-- 
2.17.0
