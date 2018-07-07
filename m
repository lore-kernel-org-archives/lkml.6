Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF997C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8442089D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/+Y0Eh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8442089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeGGOzr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:55:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37545 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so6728109wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6NDSU8W6igoW5AYA0yJPx0lbBOXKtEeZ+Ln+llxUZCQ=;
        b=X/+Y0Eh4tOUAmqbPpheasf3iJs1xTkpYFuqDl+z/kc/iRDlwm1JMpPG/F3zSVkY2sW
         sV7AzSXW6W3M46fKLDesUFbozJKXwDTZGMNrEoBzvuIrcYxDtK7lpAiB1wSFv47pJ85X
         M6qwnVDUq54W+mA+pCcGKPuXtQatyiw6RUu4NawJuT3qrfMRb5istnIR/U0yNpmkzo3K
         jB/480yuKMIjCSUbO7Sn41sneGoPSPDb8aqROdZicfCSBhkFTFpX7EH/11OQ28Id51KM
         FZGASvtZtwHdR6YuFHfFGs6Ni719P8/B3YCAJzUfT1erASmf824v1uDFf6pPJpL7HMNH
         EoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6NDSU8W6igoW5AYA0yJPx0lbBOXKtEeZ+Ln+llxUZCQ=;
        b=CJmbvQKiiKlcthFkEjct1LmE41e4XwJUCFf0bx/kGChvZCA2F43duJ38/tw3c5mEoY
         fSE42ExPjDFG1nSXn4w+0v2K7I919VwnFsCLB9EVQ1byXi2QEIqttLqb5fB6HOIFkpM1
         hGMR1FYIGy5riUTemlFX2XD/fPpOFTyef6szAdtwirzRdTIEvSFWMgOwUDZaXZ1jVgxo
         CQAA6TojVtjseVXds6Bk9MVoNgHy9ZPJK6o8G11Tv4vQhM4VD612KSrycanrAozcLOl7
         +bX1r0QulMT4p/gb+RYZfh+lwZFHQW6uGCUNehUk7zvnO3O61WFcLGAAxeokTY5PLifb
         knkw==
X-Gm-Message-State: APt69E3Rvz26TGE56ieOgtD9HtVSetb9lRJr/m4GvE3kiddWIoF2kN1n
        ETLwKscdl6rO5Pv1d+ImQ69FwQ==
X-Google-Smtp-Source: AAOMgpe6g2ArIuAEdEsr4ZoamOOvGHNvcMC/zNQDm4nm3d3+Lj7tvb5GlLQr6UygxjtS5dZDj2mJwg==
X-Received: by 2002:adf:ea0a:: with SMTP id q10-v6mr10385282wrm.224.1530975337441;
        Sat, 07 Jul 2018 07:55:37 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:36 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/12] staging:rtl8192u: Correct spacing before and after parenthesis - Style
Date:   Sat,  7 Jul 2018 15:55:08 +0100
Message-Id: <20180707145513.15325-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected coding style issues aroung opening and closed parenthesis.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 78 +++++++++----------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index a33509e6d2b0..429b8140d3ef 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -263,7 +263,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 		/* check whether the managed packet queued greater than 5 */
 		if (!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) ||\
 		    (skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) || \
-		    (ieee->queue_stop) ) {
+		    (ieee->queue_stop)) {
 			/* insert the skb packet to the management queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
@@ -493,7 +493,7 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 			}
 		}
 	} while (!channel_map[ieee->current_network.channel]);
-	if (ieee->scanning == 0 )
+	if (ieee->scanning == 0)
 		goto out;
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
 	if (channel_map[ieee->current_network.channel] == 1)
@@ -584,7 +584,7 @@ EXPORT_SYMBOL(ieee80211_stop_scan);
 /* called with ieee->lock held */
 static void ieee80211_start_scan(struct ieee80211_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee) ) {
+	if (IS_DOT11D_ENABLE(ieee)) {
 		if (IS_COUNTRY_IE_VALID(ieee))
 			RESET_CIE_WATCHDOG(ieee);
 	}
@@ -601,7 +601,7 @@ static void ieee80211_start_scan(struct ieee80211_device *ieee)
 /* called with wx_mutex held */
 void ieee80211_start_scan_syncro(struct ieee80211_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee) ) {
+	if (IS_DOT11D_ENABLE(ieee)) {
 		if (IS_COUNTRY_IE_VALID(ieee))
 			RESET_CIE_WATCHDOG(ieee);
 	}
@@ -728,9 +728,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 		return NULL;
 	skb_reserve(skb, ieee->tx_headroom);
 	beacon_buf = skb_put(skb, (beacon_size - ieee->tx_headroom));
-	memcpy (beacon_buf->header.addr1, dest, ETH_ALEN);
-	memcpy (beacon_buf->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
-	memcpy (beacon_buf->header.addr3, ieee->current_network.bssid, ETH_ALEN);
+	memcpy(beacon_buf->header.addr1, dest, ETH_ALEN);
+	memcpy(beacon_buf->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
+	memcpy(beacon_buf->header.addr3, ieee->current_network.bssid, ETH_ALEN);
 
 	beacon_buf->header.duration_id = 0; /* FIXME */
 	beacon_buf->beacon_interval =
@@ -973,7 +973,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len, encrypt);
 		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
 			realtek_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
-			realtek_ie_len = sizeof( ieee->pHTInfo->szRT2RTAggBuffer);
+			realtek_ie_len = sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
 			HTConstructRT2RTAggElement(ieee, realtek_ie_buf, &realtek_ie_len);
 		}
 	}
@@ -1033,7 +1033,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	memcpy(ieee->ap_mac_addr, beacon->bssid, ETH_ALEN);//for HW security, John
 
 	hdr->capability = cpu_to_le16(WLAN_CAPABILITY_BSS);
-	if (beacon->capability & WLAN_CAPABILITY_PRIVACY )
+	if (beacon->capability & WLAN_CAPABILITY_PRIVACY)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
 	if (beacon->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
@@ -1237,7 +1237,7 @@ static void ieee80211_auth_challenge(struct ieee80211_device *ieee,
 
 		IEEE80211_DEBUG_MGMT("Sending authentication challenge response\n");
 
-		ieee80211_encrypt_fragment(ieee, skb, sizeof(struct rtl_80211_hdr_3addr  ));
+		ieee80211_encrypt_fragment(ieee, skb, sizeof(struct rtl_80211_hdr_3addr));
 
 		softmac_mgmt_xmit(skb, ieee);
 		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
@@ -1287,7 +1287,7 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 	}
 	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval / 500);
 	// To prevent the immediately calling watch_dog after association.
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 ) {
+	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0) {
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
 	}
@@ -1367,13 +1367,13 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len) &&
 			(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
 
-		if (	/* if the user set the AP check if match.
-			 * if the network does not broadcast essid we check the user supplyed ANY essid
-			 * if the network does broadcast and the user does not set essid it is OK
-			 * if the network does broadcast and the user did set essid chech if essid match
-			 */
-			(apset && apmatch &&
-				((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset)) ) ||
+		/* if the user set the AP check if match.
+		 * if the network does not broadcast essid we check the user supplyed ANY essid
+		 * if the network does broadcast and the user does not set essid it is OK
+		 * if the network does broadcast and the user did set essid chech if essid match
+		 */
+		if ((apset && apmatch &&
+				((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
 			/* if the ap is not set, check that the user set the bssid
 			 * and the network does broadcast and that those two bssid matches
 			 */
@@ -1508,14 +1508,14 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 	struct rtl_80211_hdr_3addr   *header =
 		(struct rtl_80211_hdr_3addr   *)skb->data;
 
-	if (skb->len < sizeof (struct rtl_80211_hdr_3addr  ))
+	if (skb->len < sizeof(struct rtl_80211_hdr_3addr))
 		return -1; /* corrupted */
 
 	memcpy(src, header->addr2, ETH_ALEN);
 
 	skbend = (u8 *)skb->data + skb->len;
 
-	tag = skb->data + sizeof (struct rtl_80211_hdr_3addr  );
+	tag = skb->data + sizeof(struct rtl_80211_hdr_3addr);
 
 	while (tag + 1 < skbend) {
 		if (*tag == 0) {
@@ -1660,7 +1660,7 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 			ieee->last_rx_ps_time + msecs_to_jiffies(timeout)))
 		return 0;
 
-	if ((ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE ) &&
+	if ((ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) &&
 	    (ieee->mgmt_queue_tail != ieee->mgmt_queue_head))
 		return 0;
 
@@ -1931,12 +1931,10 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 			} else {
 				/* aid could not been allocated */
 				ieee->softmac_stats.rx_ass_err++;
-				printk(
-					"Association response status code 0x%x\n",
-					errcode);
-				IEEE80211_DEBUG_MGMT(
-					"Association response status code 0x%x\n",
-					errcode);
+				printk("Association response status code 0x%x\n",
+				       errcode);
+				IEEE80211_DEBUG_MGMT("Association response status code 0x%x\n",
+						     errcode);
 				if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT)
 					schedule_work(&ieee->associate_procedure_wq);
 				else
@@ -2060,9 +2058,8 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 			skb_queue_tail(&ieee->skb_waitQ[queue_index], txb->fragments[i]);
 #endif
 		} else {
-			ieee->softmac_data_hard_start_xmit(
-					txb->fragments[i],
-					ieee->dev, ieee->rate);
+			ieee->softmac_data_hard_start_xmit(txb->fragments[i],
+							   ieee->dev, ieee->rate);
 			//ieee->stats.tx_packets++;
 			//ieee->stats.tx_bytes += txb->fragments[i]->len;
 			//ieee->dev->trans_start = jiffies;
@@ -2084,10 +2081,9 @@ static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 			ieee->tx_pending.frag = i;
 			return;
 		} else {
-			ieee->softmac_data_hard_start_xmit(
-				ieee->tx_pending.txb->fragments[i],
-				ieee->dev, ieee->rate);
-				//(i+1)<ieee->tx_pending.txb->nr_frags);
+			ieee->softmac_data_hard_start_xmit(ieee->tx_pending.txb->fragments[i],
+							   ieee->dev, ieee->rate);
+			//(i+1)<ieee->tx_pending.txb->nr_frags);
 			ieee->stats.tx_packets++;
 			netif_trans_update(ieee->dev);
 		}
@@ -2935,10 +2931,9 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 	return ret;
 }
 
-static inline struct sk_buff *ieee80211_disassociate_skb(
-							struct ieee80211_network *beacon,
-							struct ieee80211_device *ieee,
-							u8	asRsn)
+static inline struct sk_buff *ieee80211_disassociate_skb(struct ieee80211_network *beacon,
+							 struct ieee80211_device *ieee,
+							 u8	asRsn)
 {
 	struct sk_buff *skb;
 	struct ieee80211_disassoc *disass;
@@ -2960,10 +2955,9 @@ static inline struct sk_buff *ieee80211_disassociate_skb(
 }
 
 void
-SendDisassociation(
-		struct ieee80211_device *ieee,
-		u8					*asSta,
-		u8						asRsn
+SendDisassociation(struct ieee80211_device *ieee,
+		   u8			   *asSta,
+		   u8			    asRsn
 )
 {
 		struct ieee80211_network *beacon = &ieee->current_network;
-- 
2.18.0

