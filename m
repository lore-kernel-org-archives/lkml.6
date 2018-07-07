Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A1C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CDA2089D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiuXykIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CDA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGGOzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:55:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeGGOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id h40-v6so6724419wrh.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZfIs9gJFu0FOZylyzJsBkuF+RLWqGXy7Q94NDnJzQMQ=;
        b=OiuXykIZE9t7lPMHbjubRHJJFRl9mfKLODCYX35ZprbktFTiB1sbfu234x9SaD6who
         JFoZJjRRboHxB+EBpc8NBiu1vZRvHGwrtI/5frnO5XB/otSBGa3csO4F9cR6hbABwfCa
         kJKq+h5YqL6b1J7pJWD+lFjWQpdDf4wCVOJd0vObYpx3rFEknROI9W5bYWIeTdpqaKxr
         fGORBCgRYcw7xnlDTwKhAN3IHWoLjG025Kld0coGYBI2SQ3p4ws4c3fvJecYxZIIHau0
         7PPAbYq9lWZKAttKKy61Qc5hZLXl0XaZ2xoB81AMRoIMGPah+GXww76J6a4/uDJRkR22
         OCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZfIs9gJFu0FOZylyzJsBkuF+RLWqGXy7Q94NDnJzQMQ=;
        b=eddeeO5dghp1zoa2owjG0g9cTimdzy3YEjdTM9zj/ozfiMll3Mz/U1qd9r5aAfgAgX
         hRy42otssN75oaTebuYRWt6R+zAVxJD+QDfSWMQHLarx6fdmgy62TdUaT+KfbkYAN9aG
         QNVKpxPVRbwqXWAusy4Q7T+MX0HayJwQJ9PQFrFq4eV8Ow81L3mySXYJUYa6IgURNhSp
         aZgZgG97xyku7tgL8J8+id5kiImgQdZNgbmSV7j6m+rx56vl2KAOs6uEv0H2Xq3vb1zH
         PnkDgBJMtWKdtGEj+29+bd3iIpeWhR3cay+on9W11XdKFIg9RxC68uY1u/wzpXCgi1u5
         +aMQ==
X-Gm-Message-State: APt69E3zI1dduw9spnpJ8V+RyVPFGm2iul8EqAjK7PoI9rTzhFiiOlPB
        RgoOPyRjxU7uE5Wd9S1ifp9ukA==
X-Google-Smtp-Source: AAOMgpcwjvtYpRo3cKOgiTgPZGHPuzw2TSA/9BAq2q3KfeZMm/j+wXcoZLD5ILDLpC44VO5miqa5fw==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr8721038wrq.61.1530975333609;
        Sat, 07 Jul 2018 07:55:33 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/12] staging:rtl8192u: Correct indentation and spacing for braces of code blocks
Date:   Sat,  7 Jul 2018 15:55:06 +0100
Message-Id: <20180707145513.15325-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple style change to fix the indentaiton and spacing of the braces around
multi ling code blocks.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 250 ++++++++----------
 1 file changed, 105 insertions(+), 145 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 5ec74f9d61b2..a33509e6d2b0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -107,11 +107,10 @@ static void ieee80211_WMM_Info(struct ieee80211_device *ieee, u8 **tag_p)
 	*tag++ = 0x00;
 	*tag++ = 0x01;
 #ifdef SUPPORT_USPD
-	if (ieee->current_network.wmm_info & 0x80) {
+	if (ieee->current_network.wmm_info & 0x80)
 		*tag++ = 0x0f | MAX_SP_Len;
-	} else {
+	else
 		*tag++ = MAX_SP_Len;
-	}
 #else
 	*tag++ = MAX_SP_Len;
 #endif
@@ -200,8 +199,7 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 
 	/*
 	// Data rate of ProbeReq is already decided. Annie, 2005-03-31
-	if( pMgntInfo->bScanInProgress || (pMgntInfo->bDualModeScanStep!=0) )
-	{
+	if( pMgntInfo->bScanInProgress || (pMgntInfo->bDualModeScanStep!=0) ) {
 	if(pMgntInfo->dot11CurrentWirelessMode==WIRELESS_MODE_A)
 	rate = 0x0c;
 	else
@@ -233,10 +231,10 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 	tcb_desc->bTxDisableRateFallBack = 1;
 	tcb_desc->bTxUseDriverAssingedRate = 1;
 
-	if (single){
-		if (ieee->queue_stop){
+	if (single) {
+		if (ieee->queue_stop) {
 			enqueue_mgmt(ieee, skb);
-		}else{
+		} else {
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
@@ -251,7 +249,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 		}
 
 		spin_unlock_irqrestore(&ieee->lock, flags);
-	}else{
+	} else {
 		spin_unlock_irqrestore(&ieee->lock, flags);
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags);
 
@@ -287,7 +285,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 	struct rtl_80211_hdr_3addr  *header =
 		(struct rtl_80211_hdr_3addr  *)skb->data;
 
-	if (single){
+	if (single) {
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -298,7 +296,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 		/* avoid watchdog triggers */
 		netif_trans_update(ieee->dev);
 		ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
-	}else{
+	} else {
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -420,13 +418,12 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER + 1);
 	mutex_lock(&ieee->scan_mutex);
 
-	while (1)
-	{
-		do{
+	while (1) {
+		do {
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				goto out; /* scan completed */
-		}while (!channel_map[ch]);
+		} while (!channel_map[ch]);
 
 		/* this function can be called in two situations
 		 * 1- We have switched to ad-hoc mode and we are
@@ -462,16 +459,15 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 		msleep_interruptible(IEEE80211_SOFTMAC_SCAN_TIME);
 	}
 out:
-	if (ieee->state < IEEE80211_LINKED){
+	if (ieee->state < IEEE80211_LINKED) {
 		ieee->actscanning = false;
 		mutex_unlock(&ieee->scan_mutex);
+	} else {
+		ieee->sync_scan_hurryup = 0;
+		if (IS_DOT11D_ENABLE(ieee))
+			DOT11D_ScanComplete(ieee);
+		mutex_unlock(&ieee->scan_mutex);
 	}
-	else{
-	ieee->sync_scan_hurryup = 0;
-	if (IS_DOT11D_ENABLE(ieee))
-		DOT11D_ScanComplete(ieee);
-	mutex_unlock(&ieee->scan_mutex);
-}
 }
 EXPORT_SYMBOL(ieee80211_softmac_scan_syncro);
 
@@ -486,18 +482,17 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	if (!ieee->ieee_up)
 		return;
 	mutex_lock(&ieee->scan_mutex);
-	do{
+	do {
 		ieee->current_network.channel =
 			(ieee->current_network.channel + 1) % MAX_CHANNEL_NUMBER;
-		if (watchdog++ > MAX_CHANNEL_NUMBER)
-		{
+		if (watchdog++ > MAX_CHANNEL_NUMBER) {
 		//if current channel is not in channel map, set to default channel.
 			if (!channel_map[ieee->current_network.channel]) {
 				ieee->current_network.channel = 6;
 				goto out; /* no good chans */
 			}
 		}
-	}while (!channel_map[ieee->current_network.channel]);
+	} while (!channel_map[ieee->current_network.channel]);
 	if (ieee->scanning == 0 )
 		goto out;
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
@@ -589,31 +584,26 @@ EXPORT_SYMBOL(ieee80211_stop_scan);
 /* called with ieee->lock held */
 static void ieee80211_start_scan(struct ieee80211_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee) )
-	{
+	if (IS_DOT11D_ENABLE(ieee) ) {
 		if (IS_COUNTRY_IE_VALID(ieee))
-		{
 			RESET_CIE_WATCHDOG(ieee);
-		}
 	}
-	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN){
+	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN) {
 		if (ieee->scanning == 0) {
 			ieee->scanning = 1;
 			schedule_delayed_work(&ieee->softmac_scan_wq, 0);
 		}
-	}else
+	} else {
 		ieee->start_scan(ieee->dev);
+	}
 }
 
 /* called with wx_mutex held */
 void ieee80211_start_scan_syncro(struct ieee80211_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee) )
-	{
+	if (IS_DOT11D_ENABLE(ieee) ) {
 		if (IS_COUNTRY_IE_VALID(ieee))
-		{
 			RESET_CIE_WATCHDOG(ieee);
-		}
 	}
 	ieee->sync_scan_hurryup = 0;
 	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
@@ -714,8 +704,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len, encrypt);
 	HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len, encrypt);
 
-	if (pHTInfo->bRegRT2RTAggregation)
-	{
+	if (pHTInfo->bRegRT2RTAggregation) {
 		tmp_generic_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
 		tmp_generic_ie_len = sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
 		HTConstructRT2RTAggElement(ieee, tmp_generic_ie_buf, &tmp_generic_ie_len);
@@ -798,10 +787,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 		tag += rate_ex_len - 2;
 	}
 
-	if (wpa_ie_len)
-	{
-		if (ieee->iw_mode == IW_MODE_ADHOC)
-		{//as Windows will set pairwise key same as the group key which is not allowed in Linux, so set this for IOT issue. WB 2008.07.07
+	if (wpa_ie_len) {
+		if (ieee->iw_mode == IW_MODE_ADHOC) {
+			//as Windows will set pairwise key same as the group key which is not allowed in Linux, so set this for IOT issue. WB 2008.07.07
 			memcpy(&ieee->wpa_ie[14], &ieee->wpa_ie[8], 4);
 		}
 		memcpy(tag, ieee->wpa_ie, ieee->wpa_ie_len);
@@ -979,30 +967,25 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	encrypt = ieee->host_encrypt && crypt && crypt->ops && ((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 
 	/* Include High Throuput capability && Realtek proprietary */
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT)
-	{
+	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
 		ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
 		ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len, encrypt);
-		if (ieee->pHTInfo->bCurrentRT2RTAggregation)
-		{
+		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
 			realtek_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
 			realtek_ie_len = sizeof( ieee->pHTInfo->szRT2RTAggBuffer);
 			HTConstructRT2RTAggElement(ieee, realtek_ie_buf, &realtek_ie_len);
 		}
 	}
-	if (ieee->qos_support) {
+	if (ieee->qos_support)
 		wmm_info_len = beacon->qos_data.supported ? 9 : 0;
-	}
 
 	if (beacon->bCkipSupported)
-	{
 		ckip_ie_len = 30 + 2;
-	}
+
 	if (beacon->bCcxRmEnable)
-	{
 		ccxrm_ie_len = 6 + 2;
-	}
+
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5 + 2;
 
@@ -1098,8 +1081,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		tag += osCcxAironetIE.Length;
 	}
 
-	if (beacon->bCcxRmEnable)
-	{
+	if (beacon->bCcxRmEnable) {
 		static u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01, 0x00};
 		OCTET_STRING osCcxRmCap;
 
@@ -1126,8 +1108,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	}
 	//HT cap element
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
-		if (ieee->pHTInfo->ePeerHTSpecVer != HT_SPEC_VER_EWC)
-		{
+		if (ieee->pHTInfo->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_HT_CAP;
 			*tag++ = ht_cap_len - 2;
@@ -1137,9 +1118,8 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	}
 
 	//choose what wpa_supplicant gives to associate.
-	if (wpa_ie_len) {
+	if (wpa_ie_len)
 		skb_put_data(skb, ieee->wpa_ie, wpa_ie_len);
-	}
 
 	if (wmm_info_len) {
 		tag = skb_put(skb, wmm_info_len);
@@ -1153,8 +1133,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 #endif
 
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
-		if (ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC)
-		{
+		if (ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = ht_cap_len - 2;
@@ -1187,10 +1166,10 @@ void ieee80211_associate_abort(struct ieee80211_device *ieee)
 	 * Here we will check if there are good nets to associate
 	 * with, so we retry or just get back to NO_LINK and scanning
 	 */
-	if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING){
+	if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING) {
 		IEEE80211_DEBUG_MGMT("Authentication failed\n");
 		ieee->softmac_stats.no_auth_rs++;
-	}else{
+	} else {
 		IEEE80211_DEBUG_MGMT("Association failed\n");
 		ieee->softmac_stats.no_ass_rs++;
 	}
@@ -1220,9 +1199,9 @@ static void ieee80211_associate_step1(struct ieee80211_device *ieee)
 	ieee->softmac_stats.tx_auth_rq++;
 	skb = ieee80211_authentication_req(beacon, ieee, 0);
 
-	if (!skb)
+	if (!skb) {
 		ieee80211_associate_abort(ieee);
-	else{
+	} else {
 		ieee->state = IEEE80211_ASSOCIATING_AUTHENTICATING ;
 		IEEE80211_DEBUG_MGMT("Sending authentication request\n");
 		softmac_mgmt_xmit(skb, ieee);
@@ -1248,9 +1227,9 @@ static void ieee80211_auth_challenge(struct ieee80211_device *ieee,
 	ieee->softmac_stats.tx_auth_rq++;
 
 	skb = ieee80211_authentication_req(beacon, ieee, chlen + 2);
-	if (!skb)
+	if (!skb) {
 		ieee80211_associate_abort(ieee);
-	else{
+	} else {
 		c = skb_put(skb, chlen + 2);
 		*(c++) = MFIE_TYPE_CHALLENGE;
 		*(c++) = chlen;
@@ -1278,9 +1257,9 @@ static void ieee80211_associate_step2(struct ieee80211_device *ieee)
 
 	ieee->softmac_stats.tx_ass_rq++;
 	skb = ieee80211_association_req(beacon, ieee);
-	if (!skb)
+	if (!skb) {
 		ieee80211_associate_abort(ieee);
-	else{
+	} else {
 		softmac_mgmt_xmit(skb, ieee);
 		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 		//dev_kfree_skb_any(skb);//edit by thomas
@@ -1291,28 +1270,24 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 	struct ieee80211_device *ieee = container_of(work, struct ieee80211_device, associate_complete_wq);
 	printk(KERN_INFO "Associated successfully\n");
 	if (ieee80211_is_54g(&ieee->current_network) &&
-	    (ieee->modulation & IEEE80211_OFDM_MODULATION)){
+	    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
 		ieee->rate = 108;
 		printk(KERN_INFO"Using G rates:%d\n", ieee->rate);
-	}else{
+	} else {
 		ieee->rate = 22;
 		printk(KERN_INFO"Using B rates:%d\n", ieee->rate);
 	}
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT)
-	{
+	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
 		printk("Successfully associated, ht enabled\n");
 		HTOnAssocRsp(ieee);
-	}
-	else
-	{
+	} else {
 		printk("Successfully associated, ht not enabled(%d, %d)\n", ieee->pHTInfo->bCurrentHTSupport, ieee->pHTInfo->bEnableHT);
 		memset(ieee->dot11HTOperationalRateSet, 0, 16);
 		//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval / 500);
 	// To prevent the immediately calling watch_dog after association.
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 )
-	{
+	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 ) {
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
 	}
@@ -1403,7 +1378,7 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 			 * and the network does broadcast and that those two bssid matches
 			 */
 			(!apset && ssidset && ssidbroad && ssidmatch)
-			){
+			) {
 				/* if the essid is hidden replace it with the
 				* essid provided by the user.
 				*/
@@ -1424,32 +1399,29 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 
 				//ieee->pHTInfo->IOTAction = 0;
 				HTResetIOTSetting(ieee->pHTInfo);
-				if (ieee->iw_mode == IW_MODE_INFRA){
+				if (ieee->iw_mode == IW_MODE_INFRA) {
 					/* Join the network for the first time */
 					ieee->AsocRetryCount = 0;
 					//for HT by amy 080514
 					if ((ieee->current_network.qos_data.supported == 1) &&
-					  // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
-					   ieee->current_network.bssht.bdSupportHT)
+					    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
+					    ieee->current_network.bssht.bdSupportHT) {
 /*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to put together to check whether we are in HT now, so needn't to check bEnableHT flags here. That's is to say we will set to HT support whenever joined AP has the ability to support HT. And whether we are in HT or not, please check bCurrentHTSupport&&bEnableHT now please.*/
-					{
 					//	ieee->pHTInfo->bCurrentHTSupport = true;
 						HTResetSelfAndSavePeerSetting(ieee, &(ieee->current_network));
-					}
-					else
-					{
+					} else {
 						ieee->pHTInfo->bCurrentHTSupport = false;
 					}
 
 					ieee->state = IEEE80211_ASSOCIATING;
 					schedule_work(&ieee->associate_procedure_wq);
-				}else{
+				} else {
 					if (ieee80211_is_54g(&ieee->current_network) &&
-					    (ieee->modulation & IEEE80211_OFDM_MODULATION)){
+					    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
 						ieee->rate = 108;
 						ieee->SetWirelessMode(ieee->dev, IEEE_G);
 						printk(KERN_INFO"Using G rates\n");
-					}else{
+					} else {
 						ieee->rate = 22;
 						ieee->SetWirelessMode(ieee->dev, IEEE_B);
 						printk(KERN_INFO"Using B rates\n");
@@ -1545,7 +1517,7 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	tag = skb->data + sizeof (struct rtl_80211_hdr_3addr  );
 
-	while (tag + 1 < skbend){
+	while (tag + 1 < skbend) {
 		if (*tag == 0) {
 			ssid = tag + 2;
 			ssidlen = *(tag + 1);
@@ -1600,7 +1572,7 @@ static inline u16 assoc_parse(struct ieee80211_device *ieee, struct sk_buff *skb
 	     (ieee->current_network.mode == IEEE_N_24G) &&
 	     (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 		ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
-	}else {
+	} else {
 		ieee->AsocRetryCount = 0;
 	}
 
@@ -1631,9 +1603,8 @@ ieee80211_rx_auth_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	ieee->softmac_stats.rx_auth_rq++;
 
 	status = auth_rq_parse(skb, dest);
-	if (status != -1) {
+	if (status != -1)
 		ieee80211_resp_to_auth(ieee, status, dest);
-	}
 	//DMESG("Dest is "MACSTR, MAC2STR(dest));
 }
 
@@ -1644,9 +1615,8 @@ ieee80211_rx_assoc_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	//unsigned long flags;
 
 	ieee->softmac_stats.rx_ass_rq++;
-	if (assoc_rq_parse(skb, dest) != -1) {
+	if (assoc_rq_parse(skb, dest) != -1)
 		ieee80211_resp_to_assoc_rq(ieee, dest);
-	}
 
 	printk(KERN_INFO"New client associated: %pM\n", dest);
 	//FIXME
@@ -1720,7 +1690,7 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 
 	if ((ieee->ps == IEEE80211_PS_DISABLED ||
 	     ieee->iw_mode != IW_MODE_INFRA ||
-	     ieee->state != IEEE80211_LINKED)){
+	     ieee->state != IEEE80211_LINKED)) {
 		//	#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
@@ -1734,15 +1704,14 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 	if (sleep == 0)
 		goto out;
 
-	if (sleep == 1){
-		if (ieee->sta_sleep == 1)
+	if (sleep == 1) {
+		if (ieee->sta_sleep == 1) {
 			ieee->enter_sleep_state(ieee->dev, th, tl);
-
-		else if (ieee->sta_sleep == 0){
+		} else if (ieee->sta_sleep == 0) {
 		//	printk("send null 1\n");
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
-			if (ieee->ps_is_queue_empty(ieee->dev)){
+			if (ieee->ps_is_queue_empty(ieee->dev)) {
 				ieee->sta_sleep = 2;
 
 				ieee->ps_request_tx_ack(ieee->dev);
@@ -1754,7 +1723,7 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 			}
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 		}
-	}else if (sleep == 2){
+	} else if (sleep == 2) {
 //#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
@@ -1794,7 +1763,7 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->sta_sleep == 2){
+	if (ieee->sta_sleep == 2) {
 		/* Null frame with PS bit set */
 		if (success) {
 			ieee->sta_sleep = 1;
@@ -1803,9 +1772,8 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
 		/* if the card report not success we can't be sure the AP
 		 * has not RXed so we can't assume the AP believe us awake
 		 */
-	}
-	/* 21112005 - tx again null without PS bit if lost */
-	else {
+	} else {
+		/* 21112005 - tx again null without PS bit if lost */
 		if ((ieee->sta_sleep == 0) && !success) {
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 			ieee80211_sta_ps_send_null_frame(ieee, 0);
@@ -1823,8 +1791,7 @@ static void ieee80211_process_action(struct ieee80211_device *ieee,
 	u8 *act = ieee80211_get_payload(header);
 	u8 tmp = 0;
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb->len);
-	if (act == NULL)
-	{
+	if (act == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "error to get payload of action frame\n");
 		return;
 	}
@@ -1890,9 +1857,9 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 					bHalfSupportNmode) {
 				netdev_dbg(ieee->dev, "enter half N mode\n");
 				ieee->bHalfWirelessN24GMode = true;
-			} else
+			} else {
 				ieee->bHalfWirelessN24GMode = false;
-
+			}
 			ieee80211_associate_step2(ieee);
 		} else {
 			ieee80211_auth_challenge(ieee, challenge, chlen);
@@ -1933,8 +1900,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		IEEE80211_DEBUG_MGMT("received [RE]ASSOCIATION RESPONSE (%d)\n",
 				WLAN_FC_GET_STYPE(header->frame_ctl));
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATED &&
-			ieee->iw_mode == IW_MODE_INFRA){
+		    ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATED &&
+		    ieee->iw_mode == IW_MODE_INFRA) {
 			struct ieee80211_network network_resp;
 			struct ieee80211_network *network = &network_resp;
 
@@ -1950,11 +1917,10 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 					memset(network, 0, sizeof(*network));
 					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,\
 								rx_stats->len - sizeof(*assoc_resp),\
-								network, rx_stats)){
+								network, rx_stats)) {
 						return 1;
-					}
-					else
-					{	//filling the PeerHTCap. //maybe not necessary as we can get its info from current_network.
+					} else {
+						//filling the PeerHTCap. //maybe not necessary as we can get its info from current_network.
 						memcpy(ieee->pHTInfo->PeerHTCapBuf, network->bssht.bdHTCapBuf, network->bssht.bdHTCapLen);
 						memcpy(ieee->pHTInfo->PeerHTInfoBuf, network->bssht.bdHTInfoBuf, network->bssht.bdHTInfoLen);
 					}
@@ -1971,11 +1937,10 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				IEEE80211_DEBUG_MGMT(
 					"Association response status code 0x%x\n",
 					errcode);
-				if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT) {
+				if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT)
 					schedule_work(&ieee->associate_procedure_wq);
-				} else {
+				else
 					ieee80211_associate_abort(ieee);
-				}
 			}
 		}
 		break;
@@ -2004,7 +1969,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    ((ieee->iw_mode == IW_MODE_ADHOC ||
 		      ieee->iw_mode == IW_MODE_MASTER) &&
-		     ieee->state == IEEE80211_LINKED)){
+		     ieee->state == IEEE80211_LINKED)) {
 			ieee80211_rx_probe_rq(ieee, skb);
 		}
 		break;
@@ -2016,7 +1981,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		*/
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 		    ieee->state == IEEE80211_LINKED &&
-		    ieee->iw_mode == IW_MODE_INFRA){
+		    ieee->iw_mode == IW_MODE_INFRA) {
 			ieee->state = IEEE80211_ASSOCIATING;
 			ieee->softmac_stats.reassoc++;
 
@@ -2071,9 +2036,9 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 	ieee->stats.tx_bytes += le16_to_cpu(txb->payload_size);
 	ieee->stats.tx_packets++;
 	tcb_desc = (struct cb_desc *)(txb->fragments[0]->cb + MAX_DEV_ADDR_SIZE);
-	if (tcb_desc->bMulticast) {
+	if (tcb_desc->bMulticast)
 		ieee->stats.multicast++;
-	}
+
 	/* if xmit available, just xmit it immediately, else just insert it to the wait queue */
 	for (i = 0; i < txb->nr_frags; i++) {
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
@@ -2094,7 +2059,7 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 #else
 			skb_queue_tail(&ieee->skb_waitQ[queue_index], txb->fragments[i]);
 #endif
-		}else{
+		} else {
 			ieee->softmac_data_hard_start_xmit(
 					txb->fragments[i],
 					ieee->dev, ieee->rate);
@@ -2115,10 +2080,10 @@ static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 {
 	int i;
 	for (i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
-		if (ieee->queue_stop){
+		if (ieee->queue_stop) {
 			ieee->tx_pending.frag = i;
 			return;
-		}else{
+		} else {
 			ieee->softmac_data_hard_start_xmit(
 				ieee->tx_pending.txb->fragments[i],
 				ieee->dev, ieee->rate);
@@ -2294,10 +2259,10 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 			ieee->current_network.rates[1] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_2MB;
 			ieee->current_network.rates[2] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_5MB;
 			ieee->current_network.rates[3] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_11MB;
-		}else
+		} else {
 			ieee->current_network.rates_len = 0;
-
-		if (ieee->modulation & IEEE80211_OFDM_MODULATION){
+		}
+		if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
 			ieee->current_network.rates_ex_len = 8;
 
 			ieee->current_network.rates_ex[0] = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_6MB;
@@ -2310,7 +2275,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 			ieee->current_network.rates_ex[7] = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_54MB;
 
 			ieee->rate = 108;
-		}else{
+		} else {
 			ieee->current_network.rates_ex_len = 0;
 			ieee->rate = 22;
 		}
@@ -2353,12 +2318,9 @@ void ieee80211_start_bss(struct ieee80211_device *ieee)
 	// Ref: 802.11d 11.1.3.3
 	// STA shall not start a BSS unless properly formed Beacon frame including a Country IE.
 	//
-	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee))
-	{
+	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee)) {
 		if (! ieee->bGlobalDomain)
-		{
 			return;
-		}
 	}
 	/* check if we have already found the net we
 	 * are interested in (if any).
@@ -2528,11 +2490,11 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 	ieee->proto_started = 1;
 
 	if (ieee->current_network.channel == 0) {
-		do{
+		do {
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				return; /* no channel found */
-		}while (!GET_DOT11D_INFO(ieee)->channel_map[ch]);
+		} while (!GET_DOT11D_INFO(ieee)->channel_map[ch]);
 		ieee->current_network.channel = ch;
 	}
 
@@ -2575,9 +2537,9 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 
 	ieee->state = IEEE80211_NOLINK;
 	ieee->sync_scan_hurryup = 0;
-	for (i = 0; i < 5; i++) {
-	  ieee->seq_ctrl[i] = 0;
-	}
+	for (i = 0; i < 5; i++)
+		ieee->seq_ctrl[i] = 0;
+
 	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_KERNEL);
 	if (!ieee->pDot11dInfo)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
@@ -2732,12 +2694,11 @@ static int ieee80211_wpa_set_auth_algs(struct ieee80211_device *ieee, int value)
 		sec.auth_mode = WLAN_AUTH_SHARED_KEY;
 		ieee->open_wep = 0;
 		ieee->auth_mode = 1;
-	} else if (value & AUTH_ALG_OPEN_SYSTEM){
+	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
 		sec.auth_mode = WLAN_AUTH_OPEN;
 		ieee->open_wep = 1;
 		ieee->auth_mode = 0;
-	}
-	else if (value & IW_AUTH_ALG_LEAP){
+	} else if (value & IW_AUTH_ALG_LEAP) {
 		sec.auth_mode = WLAN_AUTH_LEAP;
 		ieee->open_wep = 1;
 		ieee->auth_mode = 2;
@@ -2788,8 +2749,7 @@ static int ieee80211_wpa_set_param(struct ieee80211_device *ieee, u8 name, u32 v
 		if (!value) {
 			sec.flags |= SEC_LEVEL;
 			sec.level = SEC_LEVEL_0;
-		}
-		else {
+		} else {
 			sec.flags |= SEC_LEVEL;
 			sec.level = SEC_LEVEL_1;
 		}
@@ -2935,9 +2895,9 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 		ieee->tx_keyidx = param->u.crypt.idx;
 		sec.active_key = param->u.crypt.idx;
 		sec.flags |= SEC_ACTIVE_KEY;
-	} else
+	} else {
 		sec.flags &= ~SEC_ACTIVE_KEY;
-
+	}
 	memcpy(sec.keys[param->u.crypt.idx],
 	       param->u.crypt.key,
 	       param->u.crypt.key_len);
-- 
2.18.0

