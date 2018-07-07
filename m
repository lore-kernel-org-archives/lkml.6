Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E00C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E042089D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsVE2pOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E042089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeGGOze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:55:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46393 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so6726859wra.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9H07jX1m1vdKb2hHcDEbVq4I76cwcCFpiKT1lDIK1YA=;
        b=lsVE2pOLjs73dlXDKESwDP/kEUAXMRz5/UxTEDcXZV3wVmE6yKQisew00BASvMX8d4
         cU97gnt2o1d3mfLXOFDv2kGp0lPZJSLjPP2rFpqmK2+DBSZdu1+tWARCn6h+i7QPMwb/
         PE8+aVvBptg5fxUFTNl6iDRannOgqzqm6Ne4nYaHSyVugEcAbyNEg9SxasY5VGM70n5P
         IlcRUaQqV1da6rbiXRNjPWVpV/evXMaWqovtoyTYQAsRVvlvewQaOOndp/p8UuEU+p9t
         5thPPTN2VgeoXuhRvXFfedAsVE3Qgaphpq7nH0BIHz7DNxx8VC1BQS3kaGHwJu0Na1HX
         LPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9H07jX1m1vdKb2hHcDEbVq4I76cwcCFpiKT1lDIK1YA=;
        b=PdQ735ORzalqXnbfGUD5BVVG2ZDIvl/tKdWTTWb7jDJNr0KOONxTyNhAas3lAnyL7m
         8UUBQjR/XNz4YYyxDLWRepiYG/+EhaDc/3T18YQcwl7RfQwoOJkhl10dkmHk3RVP068B
         1diiSSWY/xKu3S19rm3lnDuJkcXb2mQ2fXmiWcHYmdQZlh2oOPFCd+N9zrJ2zTx/Xgmx
         Ua9uyZa3Nl1gsIIrTCYvi5QfNprFdJW1AdYWBzRrr4B6JvXtSdYB8TeQ4R1imMc9EYKy
         q1BLwWPh2Mmzvt7YtFl6NdL9Xf9znt60H5IuI8oziN9Sp1WshylLC0jcHvEoO/feaVd0
         Px9g==
X-Gm-Message-State: APt69E1wsSFdYsJY9JJY+tNNA7fcdVtrKLedZNqDm6SDdzKWI6pF1Pqq
        ExmdSeCh74bfKTM53gkT4Jy7+w==
X-Google-Smtp-Source: AAOMgpcFNZn0UWzrrvvlEEnSuPN1luvipi36eSUMoE1BSoYJ+fzsTWgdUkmulpgJ+wfjcaMuyZWj+g==
X-Received: by 2002:a5d:550a:: with SMTP id b10-v6mr10954837wrv.228.1530975327026;
        Sat, 07 Jul 2018 07:55:27 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/12] staging:rtl8192u: Add space required before  '(' - Style
Date:   Sat,  7 Jul 2018 15:55:03 +0100
Message-Id: <20180707145513.15325-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple addition of the coding style required space before '('.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 174 +++++++++---------
 1 file changed, 86 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 5895d6e5eb67..1f6d0fb3c5bd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -109,7 +109,7 @@ static void ieee80211_WMM_Info(struct ieee80211_device *ieee, u8 **tag_p)
 	*tag++ = 0x00;
 	*tag++ = 0x01;
 #ifdef SUPPORT_USPD
-	if(ieee->current_network.wmm_info & 0x80) {
+	if (ieee->current_network.wmm_info & 0x80) {
 		*tag++ = 0x0f|MAX_SP_Len;
 	} else {
 		*tag++ = MAX_SP_Len;
@@ -163,7 +163,7 @@ static struct sk_buff *dequeue_mgmt(struct ieee80211_device *ieee)
 {
 	struct sk_buff *ret;
 
-	if(ieee->mgmt_queue_tail == ieee->mgmt_queue_head)
+	if (ieee->mgmt_queue_tail == ieee->mgmt_queue_head)
 		return NULL;
 
 	ret = ieee->mgmt_queue_ring[ieee->mgmt_queue_tail];
@@ -185,16 +185,16 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 	u8 rate;
 
 	/* 2008/01/25 MH For broadcom, MGNT frame set as OFDM 6M. */
-	if(pHTInfo->IOTAction & HT_IOT_ACT_MGNT_USE_CCK_6M)
+	if (pHTInfo->IOTAction & HT_IOT_ACT_MGNT_USE_CCK_6M)
 		rate = 0x0c;
 	else
 		rate = ieee->basic_rate & 0x7f;
 
 	if (rate == 0) {
 		/* 2005.01.26, by rcnjko. */
-		if(ieee->mode == IEEE_A ||
-		   ieee->mode == IEEE_N_5G ||
-		   (ieee->mode == IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
+		if (ieee->mode == IEEE_A ||
+		    ieee->mode == IEEE_N_5G ||
+		    (ieee->mode == IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
 			rate = 0x0c;
 		else
 			rate = 0x02;
@@ -235,8 +235,8 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 	tcb_desc->bTxDisableRateFallBack = 1;
 	tcb_desc->bTxUseDriverAssingedRate = 1;
 
-	if(single){
-		if(ieee->queue_stop){
+	if (single){
+		if (ieee->queue_stop){
 			enqueue_mgmt(ieee, skb);
 		}else{
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0]<<4);
@@ -265,9 +265,9 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 			ieee->seq_ctrl[0]++;
 
 		/* check whether the managed packet queued greater than 5 */
-		if(!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) ||\
-				(skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) ||\
-				(ieee->queue_stop) ) {
+		if (!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) ||\
+		    (skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) || \
+		    (ieee->queue_stop) ) {
 			/* insert the skb packet to the management queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
@@ -289,7 +289,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 	struct rtl_80211_hdr_3addr  *header =
 		(struct rtl_80211_hdr_3addr  *)skb->data;
 
-	if(single){
+	if (single){
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -358,7 +358,7 @@ static void ieee80211_send_beacon(struct ieee80211_device *ieee)
 {
 	struct sk_buff *skb;
 
-	if(!ieee->ieee_up)
+	if (!ieee->ieee_up)
 		return;
 	//unsigned long flags;
 	skb = ieee80211_get_beacon_(ieee);
@@ -423,13 +423,13 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER+1);
 	mutex_lock(&ieee->scan_mutex);
 
-	while(1)
+	while (1)
 	{
 		do{
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				goto out; /* scan completed */
-		}while(!channel_map[ch]);
+		}while (!channel_map[ch]);
 
 		/* this function can be called in two situations
 		 * 1- We have switched to ad-hoc mode and we are
@@ -453,7 +453,7 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 		if (ieee->state == IEEE80211_LINKED)
 			goto out;
 		ieee->set_chan(ieee->dev, ch);
-		if(channel_map[ch] == 1)
+		if (channel_map[ch] == 1)
 			ieee80211_send_probe_requests(ieee);
 
 		/* this prevent excessive time wait when we
@@ -465,13 +465,13 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 		msleep_interruptible(IEEE80211_SOFTMAC_SCAN_TIME);
 	}
 out:
-	if(ieee->state < IEEE80211_LINKED){
+	if (ieee->state < IEEE80211_LINKED){
 		ieee->actscanning = false;
 		mutex_unlock(&ieee->scan_mutex);
 	}
 	else{
 	ieee->sync_scan_hurryup = 0;
-	if(IS_DOT11D_ENABLE(ieee))
+	if (IS_DOT11D_ENABLE(ieee))
 		DOT11D_ScanComplete(ieee);
 	mutex_unlock(&ieee->scan_mutex);
 }
@@ -486,7 +486,7 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	u8 channel_map[MAX_CHANNEL_NUMBER+1];
 
 	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER+1);
-	if(!ieee->ieee_up)
+	if (!ieee->ieee_up)
 		return;
 	mutex_lock(&ieee->scan_mutex);
 	do{
@@ -500,11 +500,11 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 				goto out; /* no good chans */
 			}
 		}
-	}while(!channel_map[ieee->current_network.channel]);
+	}while (!channel_map[ieee->current_network.channel]);
 	if (ieee->scanning == 0 )
 		goto out;
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
-	if(channel_map[ieee->current_network.channel] == 1)
+	if (channel_map[ieee->current_network.channel] == 1)
 		ieee80211_send_probe_requests(ieee);
 
 	schedule_delayed_work(&ieee->softmac_scan_wq, IEEE80211_SOFTMAC_SCAN_TIME);
@@ -512,7 +512,7 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	mutex_unlock(&ieee->scan_mutex);
 	return;
 out:
-	if(IS_DOT11D_ENABLE(ieee))
+	if (IS_DOT11D_ENABLE(ieee))
 		DOT11D_ScanComplete(ieee);
 	ieee->actscanning = false;
 	watchdog = 0;
@@ -545,7 +545,7 @@ static void ieee80211_beacons_stop(struct ieee80211_device *ieee)
 
 void ieee80211_stop_send_beacons(struct ieee80211_device *ieee)
 {
-	if(ieee->stop_send_beacons)
+	if (ieee->stop_send_beacons)
 		ieee->stop_send_beacons(ieee->dev);
 	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
 		ieee80211_beacons_stop(ieee);
@@ -554,9 +554,9 @@ EXPORT_SYMBOL(ieee80211_stop_send_beacons);
 
 void ieee80211_start_send_beacons(struct ieee80211_device *ieee)
 {
-	if(ieee->start_send_beacons)
+	if (ieee->start_send_beacons)
 		ieee->start_send_beacons(ieee->dev, ieee->basic_rate);
-	if(ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
+	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
 		ieee80211_beacons_start(ieee);
 }
 EXPORT_SYMBOL(ieee80211_start_send_beacons);
@@ -653,11 +653,11 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 	memcpy(auth->header.addr3, beacon->bssid, ETH_ALEN);
 
 	//auth->algorithm = ieee->open_wep ? WLAN_AUTH_OPEN : WLAN_AUTH_SHARED_KEY;
-	if(ieee->auth_mode == 0)
+	if (ieee->auth_mode == 0)
 		auth->algorithm = WLAN_AUTH_OPEN;
-	else if(ieee->auth_mode == 1)
+	else if (ieee->auth_mode == 1)
 		auth->algorithm = cpu_to_le16(WLAN_AUTH_SHARED_KEY);
-	else if(ieee->auth_mode == 2)
+	else if (ieee->auth_mode == 2)
 		auth->algorithm = WLAN_AUTH_OPEN; /* 0x80; */
 	printk("=================>%s():auth->algorithm is %d\n", __func__, auth->algorithm);
 	auth->transaction = cpu_to_le16(ieee->associate_seq);
@@ -693,14 +693,14 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	u8 *tmp_generic_ie_buf = NULL;
 	u8 tmp_generic_ie_len = 0;
 
-	if(rate_ex_len > 0) rate_ex_len+=2;
+	if (rate_ex_len > 0) rate_ex_len+=2;
 
-	if(ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
+	if (ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
 		atim_len = 4;
 	else
 		atim_len = 0;
 
-	if(ieee80211_is_54g(&ieee->current_network))
+	if (ieee80211_is_54g(&ieee->current_network))
 		erp_len = 3;
 	else
 		erp_len = 0;
@@ -754,7 +754,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	beacon_buf->capability |=
 		cpu_to_le16(ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE); /* add short preamble here */
 
-	if(ieee->short_slot && (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT))
+	if (ieee->short_slot && (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT))
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 
 	crypt = ieee->crypt[ieee->tx_keyidx];
@@ -844,7 +844,7 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
 		WLAN_CAPABILITY_BSS : WLAN_CAPABILITY_IBSS);
 
-	if(ieee->short_slot)
+	if (ieee->short_slot)
 		assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 
 	if (ieee->host_encrypt)
@@ -1059,7 +1059,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	if (beacon->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE); //add short_preamble here
 
-	if(ieee->short_slot)
+	if (ieee->short_slot)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 	if (wmm_info_len) //QOS
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_QOS);
@@ -1156,7 +1156,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 #endif
 
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
-		if(ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC)
+		if (ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC)
 		{
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
@@ -1293,9 +1293,8 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 {
 	struct ieee80211_device *ieee = container_of(work, struct ieee80211_device, associate_complete_wq);
 	printk(KERN_INFO "Associated successfully\n");
-	if(ieee80211_is_54g(&ieee->current_network) &&
-		(ieee->modulation & IEEE80211_OFDM_MODULATION)){
-
+	if (ieee80211_is_54g(&ieee->current_network) &&
+	    (ieee->modulation & IEEE80211_OFDM_MODULATION)){
 		ieee->rate = 108;
 		printk(KERN_INFO"Using G rates:%d\n", ieee->rate);
 	}else{
@@ -1432,7 +1431,7 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 					/* Join the network for the first time */
 					ieee->AsocRetryCount = 0;
 					//for HT by amy 080514
-					if((ieee->current_network.qos_data.supported == 1) &&
+					if ((ieee->current_network.qos_data.supported == 1) &&
 					  // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
 					   ieee->current_network.bssht.bdSupportHT)
 /*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to put together to check whether we are in HT now, so needn't to check bEnableHT flags here. That's is to say we will set to HT support whenever joined AP has the ability to support HT. And whether we are in HT or not, please check bCurrentHTSupport&&bEnableHT now please.*/
@@ -1448,8 +1447,8 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 					ieee->state = IEEE80211_ASSOCIATING;
 					schedule_work(&ieee->associate_procedure_wq);
 				}else{
-					if(ieee80211_is_54g(&ieee->current_network) &&
-						(ieee->modulation & IEEE80211_OFDM_MODULATION)){
+					if (ieee80211_is_54g(&ieee->current_network) &&
+					    (ieee->modulation & IEEE80211_OFDM_MODULATION)){
 						ieee->rate = 108;
 						ieee->SetWirelessMode(ieee->dev, IEEE_G);
 						printk(KERN_INFO"Using G rates\n");
@@ -1600,14 +1599,14 @@ static inline u16 assoc_parse(struct ieee80211_device *ieee, struct sk_buff *skb
 	*aid = le16_to_cpu(response_head->aid) & 0x3fff;
 
 	status_code = le16_to_cpu(response_head->status);
-	if((status_code == WLAN_STATUS_ASSOC_DENIED_RATES || \
-	   status_code == WLAN_STATUS_CAPS_UNSUPPORTED)&&
-	   ((ieee->mode == IEEE_G) &&
-	    (ieee->current_network.mode == IEEE_N_24G) &&
-	    (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
-		 ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
+	if ((status_code == WLAN_STATUS_ASSOC_DENIED_RATES || \
+	     status_code == WLAN_STATUS_CAPS_UNSUPPORTED)&&
+	    ((ieee->mode == IEEE_G) &&
+	     (ieee->current_network.mode == IEEE_N_24G) &&
+	     (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
+		ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
 	}else {
-		 ieee->AsocRetryCount = 0;
+		ieee->AsocRetryCount = 0;
 	}
 
 	return le16_to_cpu(response_head->status);
@@ -1682,24 +1681,24 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 		return 0;
 	*/
 	dtim = ieee->current_network.dtim_data;
-	if(!(dtim & IEEE80211_DTIM_VALID))
+	if (!(dtim & IEEE80211_DTIM_VALID))
 		return 0;
 	timeout = ieee->current_network.beacon_interval; //should we use ps_timeout value or beacon_interval
 	ieee->current_network.dtim_data = IEEE80211_DTIM_INVALID;
 
-	if(dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST)& ieee->ps))
+	if (dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST)& ieee->ps))
 		return 2;
 
-	if(!time_after(jiffies,
-		       dev_trans_start(ieee->dev) + msecs_to_jiffies(timeout)))
+	if (!time_after(jiffies,
+			dev_trans_start(ieee->dev) + msecs_to_jiffies(timeout)))
 		return 0;
 
-	if(!time_after(jiffies,
-		       ieee->last_rx_ps_time + msecs_to_jiffies(timeout)))
+	if (!time_after(jiffies,
+			ieee->last_rx_ps_time + msecs_to_jiffies(timeout)))
 		return 0;
 
-	if((ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE ) &&
-		(ieee->mgmt_queue_tail != ieee->mgmt_queue_head))
+	if ((ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE ) &&
+	    (ieee->mgmt_queue_tail != ieee->mgmt_queue_head))
 		return 0;
 
 	if (time_l) {
@@ -1710,7 +1709,7 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 
 	if (time_h) {
 		*time_h = ieee->current_network.last_dtim_sta_time[1];
-		if(time_l && *time_l < ieee->current_network.last_dtim_sta_time[0])
+		if (time_l && *time_l < ieee->current_network.last_dtim_sta_time[0])
 			*time_h += 1;
 	}
 
@@ -1740,18 +1739,18 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 
 	sleep = ieee80211_sta_ps_sleep(ieee, &th, &tl);
 	/* 2 wake, 1 sleep, 0 do nothing */
-	if(sleep == 0)
+	if (sleep == 0)
 		goto out;
 
-	if(sleep == 1){
-		if(ieee->sta_sleep == 1)
+	if (sleep == 1){
+		if (ieee->sta_sleep == 1)
 			ieee->enter_sleep_state(ieee->dev, th, tl);
 
-		else if(ieee->sta_sleep == 0){
+		else if (ieee->sta_sleep == 0){
 		//	printk("send null 1\n");
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
-			if(ieee->ps_is_queue_empty(ieee->dev)){
+			if (ieee->ps_is_queue_empty(ieee->dev)){
 				ieee->sta_sleep = 2;
 
 				ieee->ps_request_tx_ack(ieee->dev);
@@ -1763,7 +1762,7 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 			}
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 		}
-	}else if(sleep == 2){
+	}else if (sleep == 2){
 //#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
@@ -1786,7 +1785,7 @@ void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl)
 		return;
 	}
 
-	if(ieee->sta_sleep == 1)
+	if (ieee->sta_sleep == 1)
 		ieee->sta_wake_up(ieee->dev);
 
 	ieee->sta_sleep = 0;
@@ -1803,7 +1802,7 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if(ieee->sta_sleep == 2){
+	if (ieee->sta_sleep == 2){
 		/* Null frame with PS bit set */
 		if (success) {
 			ieee->sta_sleep = 1;
@@ -1924,17 +1923,16 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 	struct ieee80211_assoc_response_frame *assoc_resp;
 //	struct ieee80211_info_element *info_element;
 
-	if(!ieee->proto_started)
+	if (!ieee->proto_started)
 		return 0;
 
-	if(ieee->sta_sleep || (ieee->ps != IEEE80211_PS_DISABLED &&
-		ieee->iw_mode == IW_MODE_INFRA &&
-		ieee->state == IEEE80211_LINKED))
-
+	if (ieee->sta_sleep || (ieee->ps != IEEE80211_PS_DISABLED &&
+				ieee->iw_mode == IW_MODE_INFRA &&
+				ieee->state == IEEE80211_LINKED))
 		tasklet_schedule(&ieee->ps_task);
 
-	if(WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_PROBE_RESP &&
-		WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_BEACON)
+	if (WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_PROBE_RESP &&
+	    WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_BEACON)
 		ieee->last_rx_ps_time = jiffies;
 
 	switch (WLAN_FC_GET_STYPE(header->frame_ctl)) {
@@ -1981,7 +1979,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				IEEE80211_DEBUG_MGMT(
 					"Association response status code 0x%x\n",
 					errcode);
-				if(ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT) {
+				if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT) {
 					schedule_work(&ieee->associate_procedure_wq);
 				} else {
 					ieee80211_associate_abort(ieee);
@@ -2087,7 +2085,7 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 		ieee->stats.multicast++;
 	}
 	/* if xmit available, just xmit it immediately, else just insert it to the wait queue */
-	for(i = 0; i < txb->nr_frags; i++) {
+	for (i = 0; i < txb->nr_frags; i++) {
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
 		if ((skb_queue_len(&ieee->skb_drv_aggQ[queue_index]) != 0) ||
 #else
@@ -2127,7 +2125,7 @@ EXPORT_SYMBOL(ieee80211_softmac_xmit);
 static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 {
 	int i;
-	for(i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
+	for (i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
 
 		if (ieee->queue_stop){
 			ieee->tx_pending.frag = i;
@@ -2301,10 +2299,10 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	/* the network definitively is not here.. create a new cell */
 	if (ieee->state == IEEE80211_NOLINK) {
 		printk("creating new IBSS cell\n");
-		if(!ieee->wap_set)
+		if (!ieee->wap_set)
 			eth_random_addr(ieee->current_network.bssid);
 
-		if(ieee->modulation & IEEE80211_CCK_MODULATION){
+		if (ieee->modulation & IEEE80211_CCK_MODULATION){
 
 			ieee->current_network.rates_len = 4;
 
@@ -2315,7 +2313,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 		}else
 			ieee->current_network.rates_len = 0;
 
-		if(ieee->modulation & IEEE80211_OFDM_MODULATION){
+		if (ieee->modulation & IEEE80211_OFDM_MODULATION){
 			ieee->current_network.rates_ex_len = 8;
 
 			ieee->current_network.rates_ex[0] = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_6MB;
@@ -2338,7 +2336,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 		ieee->SetWirelessMode(ieee->dev, IEEE_G);
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-		if(ieee->short_slot)
+		if (ieee->short_slot)
 			ieee->current_network.capability |= WLAN_CAPABILITY_SHORT_SLOT;
 
 	}
@@ -2411,7 +2409,7 @@ void ieee80211_disassociate(struct ieee80211_device *ieee)
 
 	if (ieee->data_hard_stop)
 			ieee->data_hard_stop(ieee->dev);
-	if(IS_DOT11D_ENABLE(ieee))
+	if (IS_DOT11D_ENABLE(ieee))
 		Dot11d_Reset(ieee);
 	ieee->state = IEEE80211_NOLINK;
 	ieee->is_set_key = false;
@@ -2428,10 +2426,10 @@ static void ieee80211_associate_retry_wq(struct work_struct *work)
 	unsigned long flags;
 
 	mutex_lock(&ieee->wx_mutex);
-	if(!ieee->proto_started)
+	if (!ieee->proto_started)
 		goto exit;
 
-	if(ieee->state != IEEE80211_ASSOCIATING_RETRY)
+	if (ieee->state != IEEE80211_ASSOCIATING_RETRY)
 		goto exit;
 
 	/* until we do not set the state to IEEE80211_NOLINK
@@ -2453,7 +2451,7 @@ static void ieee80211_associate_retry_wq(struct work_struct *work)
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if(ieee->state == IEEE80211_NOLINK)
+	if (ieee->state == IEEE80211_NOLINK)
 		ieee80211_start_scan(ieee);
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
@@ -2486,7 +2484,7 @@ struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee)
 	struct ieee80211_probe_response *b;
 
 	skb = ieee80211_get_beacon_(ieee);
-	if(!skb)
+	if (!skb)
 		return NULL;
 
 	b = (struct ieee80211_probe_response *)skb->data;
@@ -2551,7 +2549,7 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				return; /* no channel found */
-		}while(!GET_DOT11D_INFO(ieee)->channel_map[ch]);
+		}while (!GET_DOT11D_INFO(ieee)->channel_map[ch]);
 		ieee->current_network.channel = ch;
 	}
 
@@ -2560,7 +2558,7 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 //	printk("===>%s(), chan:%d\n", __func__, ieee->current_network.channel);
 //	ieee->set_chan(ieee->dev,ieee->current_network.channel);
 
-	for(i = 0; i < 17; i++) {
+	for (i = 0; i < 17; i++) {
 	  ieee->last_rxseq_num[i] = -1;
 	  ieee->last_rxfrag_num[i] = -1;
 	  ieee->last_packet_time[i] = 0;
@@ -2582,7 +2580,7 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 	else if (ieee->iw_mode == IW_MODE_MASTER)
 		ieee80211_start_master_bss(ieee);
 
-	else if(ieee->iw_mode == IW_MODE_MONITOR)
+	else if (ieee->iw_mode == IW_MODE_MONITOR)
 		ieee80211_start_monitor_mode(ieee);
 }
 
@@ -2594,7 +2592,7 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 
 	ieee->state = IEEE80211_NOLINK;
 	ieee->sync_scan_hurryup = 0;
-	for(i = 0; i < 5; i++) {
+	for (i = 0; i < 5; i++) {
 	  ieee->seq_ctrl[i] = 0;
 	}
 	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_KERNEL);
-- 
2.18.0

