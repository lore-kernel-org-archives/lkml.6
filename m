Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0358A21450
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxMJRl59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0358A21450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeGGO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:57:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44830 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeGGOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so6729288wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0di9Wyl4OsBXvf8MN1cEPU09rtK0NR51AFr5l3+DtII=;
        b=KxMJRl59pjDhTp4GeThPtpiGgWYx6t0JZWN94+U/EXk5oS4AjxhD6D0kA86qBKZNGU
         USc3lby5xZPvhp4csB0+sYKha7EM+5kBuG5s/y44dMV9e+Lwjc3GtdsHYGsh8Muq417i
         bijyOWClHaJUFnNx9fM76PajhTNdolQxbmioa4Dqb49e4hWEKAKgmlyIVOpzpBjx1FjQ
         tnAzx+rnM40CSyG6HWcFs8uDoRR2nC9CJ1BXgF5/wyE+ijAzBrFi+4GS99yX+XFsQOB0
         1EUn+olLORKBS6yFaTaABzUAxPBKbl6n7KbFfdeVZErPWoEwzxc4NFy21WEwQqAKfYu4
         hvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0di9Wyl4OsBXvf8MN1cEPU09rtK0NR51AFr5l3+DtII=;
        b=kkG+L3jDoHXd8J/MrOoOg0mg7yZQBNu1ReDjN7bOBooXWUlpwTm0Jm7gk4WpfDRyz9
         KUfT5qGo+hlMZLqDMSxPOnIov/qf+KeA7HSsMyJwN2LSr2jobnUba0OgzlnSihScJ3/V
         BCdpHxWPAG8OG4F134rDWh+soZurB0gP5f5LEl+Hma0KVU0hfDH8vjZW1bnKEh4S3iPr
         sVLlTagSglM9o3fwM/kgobHWbpYUPhnFgOcqYteqipzezYYsYJfIOvPBjI8tQfvtjCAQ
         c2tDsOG1yXUgF4OIxW5hO9VH3K98exhk7TrbzTekN2pDbnMlMBjEbnsz9wJLwjddQnYG
         yDtg==
X-Gm-Message-State: APt69E0o74wpUY2Pg7a6QLwvN+HFc1cdcWAXSLaG4YKLgV2PApa9XsF9
        nSeqNSnT36PoQVZJkk140XSgHA==
X-Google-Smtp-Source: AAOMgpdvNU1O3VXNVfIIJ2AEjz+rmA4vs7Bjz8Bz7qruXE2aQG5Pw99RP2EE8szPZ1qkVN51EZ67Hg==
X-Received: by 2002:adf:b0a3:: with SMTP id i32-v6mr10144653wra.213.1530975328866;
        Sat, 07 Jul 2018 07:55:28 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:28 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/12] staging:rtl8192u: Remove blank lines before '}' and after '{' characters
Date:   Sat,  7 Jul 2018 15:55:04 +0100
Message-Id: <20180707145513.15325-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style change to simply remove the unrequired spaces before a closing
brace or before an opening brace.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 44 ++++++-------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 1f6d0fb3c5bd..e046cc49f3d7 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -77,8 +77,7 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
-		if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
-
+	if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
 		*tag++ = MFIE_TYPE_RATES_EX;
 		*tag++ = 8;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_6MB;
@@ -89,7 +88,6 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_36MB;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_48MB;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_54MB;
-
 	}
 
 	/* We may add an option for custom rates that specific HW might support */
@@ -301,7 +299,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 		netif_trans_update(ieee->dev);
 		ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
 	}else{
-
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -1473,7 +1470,6 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	list_for_each_entry(target, &ieee->network_list, list) {
-
 		/* if the state become different that NOLINK means
 		 * we had found what we are searching for
 		 */
@@ -1572,8 +1568,7 @@ static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
 	struct ieee80211_assoc_request_frame *a;
 
 	if (skb->len < (sizeof(struct ieee80211_assoc_request_frame) -
-		sizeof(struct ieee80211_info_element))) {
-
+			sizeof(struct ieee80211_info_element))) {
 		IEEE80211_DEBUG_MGMT("invalid len in auth request:%d \n", skb->len);
 		return -1;
 	}
@@ -1640,7 +1635,6 @@ ieee80211_rx_auth_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 		ieee80211_resp_to_auth(ieee, status, dest);
 	}
 	//DMESG("Dest is "MACSTR, MAC2STR(dest));
-
 }
 
 static inline void
@@ -1665,7 +1659,6 @@ static void ieee80211_sta_ps_send_null_frame(struct ieee80211_device *ieee,
 
 	if (buf)
 		softmac_ps_mgmt_xmit(buf, ieee);
-
 }
 /* EXPORT_SYMBOL(ieee80211_sta_ps_send_null_frame); */
 
@@ -1726,10 +1719,9 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	if ((ieee->ps == IEEE80211_PS_DISABLED ||
-		ieee->iw_mode != IW_MODE_INFRA ||
-		ieee->state != IEEE80211_LINKED)){
-
-	//	#warning CHECK_LOCK_HERE
+	     ieee->iw_mode != IW_MODE_INFRA ||
+	     ieee->state != IEEE80211_LINKED)){
+		//	#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
 		ieee80211_sta_wakeup(ieee, 1);
@@ -1999,8 +1991,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 	case IEEE80211_STYPE_AUTH:
 		if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
 			if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING
-				&& ieee->iw_mode == IW_MODE_INFRA) {
-
+			    && ieee->iw_mode == IW_MODE_INFRA) {
 				IEEE80211_DEBUG_MGMT("Received auth response");
 				ieee80211_check_auth_response(ieee, skb);
 			} else if (ieee->iw_mode == IW_MODE_MASTER) {
@@ -2011,9 +2002,9 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	case IEEE80211_STYPE_PROBE_REQ:
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
-			((ieee->iw_mode == IW_MODE_ADHOC ||
-			ieee->iw_mode == IW_MODE_MASTER) &&
-			ieee->state == IEEE80211_LINKED)){
+		    ((ieee->iw_mode == IW_MODE_ADHOC ||
+		      ieee->iw_mode == IW_MODE_MASTER) &&
+		     ieee->state == IEEE80211_LINKED)){
 			ieee80211_rx_probe_rq(ieee, skb);
 		}
 		break;
@@ -2024,9 +2015,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		* both for disassociation and deauthentication
 		*/
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->state == IEEE80211_LINKED &&
-			ieee->iw_mode == IW_MODE_INFRA){
-
+		    ieee->state == IEEE80211_LINKED &&
+		    ieee->iw_mode == IW_MODE_INFRA){
 			ieee->state = IEEE80211_ASSOCIATING;
 			ieee->softmac_stats.reassoc++;
 
@@ -2117,7 +2107,6 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 
 //exit:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 EXPORT_SYMBOL(ieee80211_softmac_xmit);
 
@@ -2126,12 +2115,10 @@ static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 {
 	int i;
 	for (i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
-
 		if (ieee->queue_stop){
 			ieee->tx_pending.frag = i;
 			return;
 		}else{
-
 			ieee->softmac_data_hard_start_xmit(
 				ieee->tx_pending.txb->fragments[i],
 				ieee->dev, ieee->rate);
@@ -2172,8 +2159,7 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 	ieee->queue_stop = 0;
 
 	if (ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) {
-		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))){
-
+		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))) {
 			header = (struct rtl_80211_hdr_3addr  *)skb->data;
 
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
@@ -2243,7 +2229,6 @@ void ieee80211_start_master_bss(struct ieee80211_device *ieee)
 static void ieee80211_start_monitor_mode(struct ieee80211_device *ieee)
 {
 	if (ieee->raw_tx) {
-
 		if (ieee->data_hard_resume)
 			ieee->data_hard_resume(ieee->dev);
 
@@ -2302,8 +2287,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 		if (!ieee->wap_set)
 			eth_random_addr(ieee->current_network.bssid);
 
-		if (ieee->modulation & IEEE80211_CCK_MODULATION){
-
+		if (ieee->modulation & IEEE80211_CCK_MODULATION) {
 			ieee->current_network.rates_len = 4;
 
 			ieee->current_network.rates[0] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_1MB;
@@ -2338,7 +2322,6 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
 		if (ieee->short_slot)
 			ieee->current_network.capability |= WLAN_CAPABILITY_SHORT_SLOT;
-
 	}
 
 	ieee->state = IEEE80211_LINKED;
@@ -3054,7 +3037,6 @@ int ieee80211_wpa_supplicant_ioctl(struct ieee80211_device *ieee, struct iw_poin
 	}
 
 	switch (param->cmd) {
-
 	case IEEE_CMD_SET_WPA_PARAM:
 		ret = ieee80211_wpa_set_param(ieee, param->u.wpa_param.name,
 					param->u.wpa_param.value);
-- 
2.18.0

