Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365DBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB92E208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaW09ZRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB92E208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934173AbeGJPGR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:06:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37371 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934150AbeGJPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:06:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so16825204edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5rKBapm5e9MxEMBPbVuoswRuIkvxqEj2l3tQYkkeo2I=;
        b=oaW09ZRPBcevg6vUPcov0Ccjtfcn9Ce7rnBjyHkljbM41JkGC6RyvR0AYRexqA5Zxa
         wHt1YWM7jOR98fPGOQStgqHe9/2t/zCv0Q9oDx5Rgl+p35FxbtGdP1dAZrO4B9qsxtHS
         ObkLVwMUdqYygT180l/R6YlKJEZTUt7SDqnYmxfFgAYgqClfM8affAvwRBZgraX3uj1b
         SINwGLKoZJwOs86C1Z2FU2OzfV3xvqEzxNUDD5dLustnUA2TzsXHuepfLlOcTjSEJyRc
         lqqFHAmcyEcG4XPgngyPEiXR1K6yPHw18Ns6jH8NDN3ZmMLkh1bw7RJFIQ7W8SP+zil/
         oEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5rKBapm5e9MxEMBPbVuoswRuIkvxqEj2l3tQYkkeo2I=;
        b=nvzSxZ5x+Xxn+OrCcsybWu72HJacEGTka0KE+7tyFm1sY2vbQJcTkWkAoYUXPJ2J34
         W/x9PWLhPYJtwNys3TonKsqRZg84AHK0uYCBFggTie5i4Ie+mmbyjUmaogCHFDJnAFI9
         BBFHj7DzPh7EuYIleS6FnGHLyBZkElNuY63M3d9Fi7Tg7d7nDXk5Zb59piuojdcMIgBz
         e+n0t1vnXH+DhpUsAASDe6S0DGoqvW3VPx/AccAnvvIXGBBQ1UEIEUtI535K3e5fyDUR
         QghZuE1Ez4kQWBCIo+3w835/SaQgyx31npM3rR1+MdUKBAfe6HsUf/lTIYp3E3djvZtJ
         5Ktg==
X-Gm-Message-State: APt69E24fs5gOoEPg3K8j7/xRPPECcLd4eaOC7t7CXp6k7LfLtsM3QUH
        MVmJYBx2FiHDTmpE1eP/fd8n5rCy
X-Google-Smtp-Source: AAOMgpcNs4TmWosm67gLFJ1fJG5ORDJfKVYO9NdGmbT0A1PfoI5V1WT6h6VLuYKM/MKumluzHcpZzg==
X-Received: by 2002:a50:f31a:: with SMTP id p26-v6mr22095632edm.68.1531235164247;
        Tue, 10 Jul 2018 08:06:04 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:06:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 8/8] staging:rtl8192u: Correction of indentation issues - Coding Style
Date:   Tue, 10 Jul 2018 16:05:23 +0100
Message-Id: <20180710150523.17384-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710150523.17384-1-johnfwhitmore@gmail.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple changes to correct indentation issues.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 76 +++++++++----------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 6507b6101342..fe61451f6c14 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -46,7 +46,6 @@ static unsigned int ieee80211_MFIE_rate_len(struct ieee80211_device *ieee)
 		rate_len = IEEE80211_CCK_RATE_LEN + 2;
 
 	if (ieee->modulation & IEEE80211_OFDM_MODULATION)
-
 		rate_len += IEEE80211_OFDM_RATE_LEN + 2;
 
 	return rate_len;
@@ -77,7 +76,7 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
-		if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
+	if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
 		*tag++ = MFIE_TYPE_RATES_EX;
 		*tag++ = 8;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_6MB;
@@ -261,7 +260,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 			ieee->seq_ctrl[0]++;
 
 		/* check whether the managed packet queued greater than 5 */
-		if (!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) ||\
+		if (!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) || \
 		    (skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) || \
 		    (ieee->queue_stop)) {
 			/* insert the skb packet to the management queue */
@@ -630,7 +629,7 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 
 	if (challengelen)
 		auth->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_AUTH
-				| IEEE80211_FCTL_WEP);
+						     | IEEE80211_FCTL_WEP);
 	else
 		auth->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_AUTH);
 
@@ -904,8 +903,8 @@ static struct sk_buff *ieee80211_null_func(struct ieee80211_device *ieee,
 	memcpy(hdr->addr3, ieee->current_network.bssid, ETH_ALEN);
 
 	hdr->frame_ctl = cpu_to_le16(IEEE80211_FTYPE_DATA |
-		IEEE80211_STYPE_NULLFUNC | IEEE80211_FCTL_TODS |
-		(pwr ? IEEE80211_FCTL_PM : 0));
+				     IEEE80211_STYPE_NULLFUNC | IEEE80211_FCTL_TODS |
+				     (pwr ? IEEE80211_FCTL_PM : 0));
 
 	return skb;
 }
@@ -1182,7 +1181,7 @@ void ieee80211_associate_abort(struct ieee80211_device *ieee)
 	ieee->state = IEEE80211_ASSOCIATING_RETRY;
 
 	schedule_delayed_work(&ieee->associate_retry_wq, \
-			   IEEE80211_SOFTMAC_ASSOC_RETRY_TIME);
+			      IEEE80211_SOFTMAC_ASSOC_RETRY_TIME);
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
@@ -1674,7 +1673,7 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 	if (time_l) {
 		*time_l = ieee->current_network.last_dtim_sta_time[0]
 			+ (ieee->current_network.beacon_interval
-			* ieee->current_network.dtim_period) * 1000;
+			   * ieee->current_network.dtim_period) * 1000;
 	}
 
 	if (time_h) {
@@ -1696,9 +1695,9 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	if ((ieee->ps == IEEE80211_PS_DISABLED ||
-		ieee->iw_mode != IW_MODE_INFRA ||
-		ieee->state != IEEE80211_LINKED)) {
-	//	#warning CHECK_LOCK_HERE
+	     ieee->iw_mode != IW_MODE_INFRA ||
+	     ieee->state != IEEE80211_LINKED)) {
+		//	#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
 		ieee80211_sta_wakeup(ieee, 1);
@@ -1880,8 +1879,8 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 
 inline int
 ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
-			struct ieee80211_rx_stats *rx_stats, u16 type,
-			u16 stype)
+			   struct ieee80211_rx_stats *rx_stats, u16 type,
+			   u16 stype)
 {
 	struct rtl_80211_hdr_3addr *header = (struct rtl_80211_hdr_3addr *)skb->data;
 	u16 errcode;
@@ -1923,8 +1922,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 					assoc_resp = (struct ieee80211_assoc_response_frame *)skb->data;
 					memset(network, 0, sizeof(*network));
 					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,\
-								rx_stats->len - sizeof(*assoc_resp),\
-								network, rx_stats)) {
+								       rx_stats->len - sizeof(*assoc_resp), \
+								       network, rx_stats)) {
 						return 1;
 					} else {
 						//filling the PeerHTCap. //maybe not necessary as we can get its info from current_network.
@@ -1953,15 +1952,14 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 	case IEEE80211_STYPE_ASSOC_REQ:
 	case IEEE80211_STYPE_REASSOC_REQ:
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->iw_mode == IW_MODE_MASTER)
-
+		    ieee->iw_mode == IW_MODE_MASTER)
 			ieee80211_rx_assoc_rq(ieee, skb);
 		break;
 
 	case IEEE80211_STYPE_AUTH:
 		if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
 			if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING
-				&& ieee->iw_mode == IW_MODE_INFRA) {
+			    && ieee->iw_mode == IW_MODE_INFRA) {
 				IEEE80211_DEBUG_MGMT("Received auth response");
 				ieee80211_check_auth_response(ieee, skb);
 			} else if (ieee->iw_mode == IW_MODE_MASTER) {
@@ -1972,9 +1970,9 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	case IEEE80211_STYPE_PROBE_REQ:
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
-			((ieee->iw_mode == IW_MODE_ADHOC ||
-			ieee->iw_mode == IW_MODE_MASTER) &&
-			ieee->state == IEEE80211_LINKED)) {
+		    ((ieee->iw_mode == IW_MODE_ADHOC ||
+		      ieee->iw_mode == IW_MODE_MASTER) &&
+		     ieee->state == IEEE80211_LINKED)) {
 			ieee80211_rx_probe_rq(ieee, skb);
 		}
 		break;
@@ -1985,8 +1983,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		* both for disassociation and deauthentication
 		*/
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->state == IEEE80211_LINKED &&
-			ieee->iw_mode == IW_MODE_INFRA) {
+		    ieee->state == IEEE80211_LINKED &&
+		    ieee->iw_mode == IW_MODE_INFRA) {
 			ieee->state = IEEE80211_ASSOCIATING;
 			ieee->softmac_stats.reassoc++;
 
@@ -2051,8 +2049,8 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 #else
 		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
 #endif
-		(!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
-		     (ieee->queue_stop)) {
+		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
+		    (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
@@ -2354,10 +2352,10 @@ void ieee80211_disassociate(struct ieee80211_device *ieee)
 {
 	netif_carrier_off(ieee->dev);
 	if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)
-			ieee80211_reset_queue(ieee);
+		ieee80211_reset_queue(ieee);
 
 	if (ieee->data_hard_stop)
-			ieee->data_hard_stop(ieee->dev);
+		ieee->data_hard_stop(ieee->dev);
 	if (IS_DOT11D_ENABLE(ieee))
 		Dot11d_Reset(ieee);
 	ieee->state = IEEE80211_NOLINK;
@@ -2508,9 +2506,9 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 //	ieee->set_chan(ieee->dev,ieee->current_network.channel);
 
 	for (i = 0; i < 17; i++) {
-	  ieee->last_rxseq_num[i] = -1;
-	  ieee->last_rxfrag_num[i] = -1;
-	  ieee->last_packet_time[i] = 0;
+		ieee->last_rxseq_num[i] = -1;
+		ieee->last_rxfrag_num[i] = -1;
+		ieee->last_packet_time[i] = 0;
 	}
 
 	ieee->init_wmmparam_flag = 0;//reinitialize AC_xx_PARAM registers.
@@ -2598,8 +2596,8 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	spin_lock_init(&ieee->beacon_lock);
 
 	tasklet_init(&ieee->ps_task,
-	     (void(*)(unsigned long)) ieee80211_sta_ps,
-	     (unsigned long)ieee);
+		     (void(*)(unsigned long)) ieee80211_sta_ps,
+		     (unsigned long)ieee);
 }
 
 void ieee80211_softmac_free(struct ieee80211_device *ieee)
@@ -2968,14 +2966,14 @@ SendDisassociation(struct ieee80211_device *ieee,
 		   u8			    asRsn
 )
 {
-		struct ieee80211_network *beacon = &ieee->current_network;
-		struct sk_buff *skb;
+	struct ieee80211_network *beacon = &ieee->current_network;
+	struct sk_buff *skb;
 
-		skb = ieee80211_disassociate_skb(beacon, ieee, asRsn);
-		if (skb) {
-				softmac_mgmt_xmit(skb, ieee);
-				//dev_kfree_skb_any(skb);//edit by thomas
-		}
+	skb = ieee80211_disassociate_skb(beacon, ieee, asRsn);
+	if (skb) {
+		softmac_mgmt_xmit(skb, ieee);
+		//dev_kfree_skb_any(skb);//edit by thomas
+	}
 }
 EXPORT_SYMBOL(SendDisassociation);
 
-- 
2.18.0

