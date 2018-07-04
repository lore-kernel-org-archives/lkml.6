Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339EC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9673523E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0pk6ilt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9673523E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeGDOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34445 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeGDOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so13202584wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9F6QAzJ81OBjcE+mFyNTJmCW1HVXxOMllo0OOYODwmQ=;
        b=m0pk6iltlzi54JS+057IzLpGgRHqWuKV97ku6erntNsvC5KSmPPtrg7Vzwc93jT5Iu
         gRwo9JzKX9+U93WlcsMfNkAkr6U3K+tYmuhRnLLHc7GhcIx3WjS+871g/OgmrggevWzp
         h34LJw3haEjIVBaDlGxCf/pYNWLUCu5MKbn1sCIJDv2z95Lr+xm3QA1J0uGkq25G7f/k
         QHzZfjQHFblJLwCJIDcKJSXxhOfPk1jfD31h2zxCLGvAtVnvVWkAK1hrXuFikFC70YWw
         1+htxT4BGSo8KbaODKtqapdA/SqS/SCZngJgq7KkibFZp94HTXnp/7XhHTjEtCl78vdf
         CmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9F6QAzJ81OBjcE+mFyNTJmCW1HVXxOMllo0OOYODwmQ=;
        b=UNRKKBTqvY9ZvevfXz3IXzTybPEmULP9/VEbpgY7xFPFAOqk7DkV2fI18v4bi3nCJe
         Q1MjG5utrU9gIACjVz+NGxpJhs5QlX+Ak3zqlEfLJIMojV5NkhKmrSy6vhUtO6osQWUz
         NRrxF5PkyN3XvTkAmTSFDkLsXPoZV9EHzkdbskBhLrA2uaHt9RSGE5u9HpnA685vWMsW
         tKchuGaCLfrXlI4b4qhQlbL8RxbWlcSH5SUFzInNZCOwt4dhA0iQtZJrQBeackcYB2yt
         FK+f5gUNscaKX4v+YM2dnnHkPzeETZafYomrT4ct5Wq4Y3Um8NXKtr4tC6zcUHiRSv3D
         SDgA==
X-Gm-Message-State: APt69E04u7VI/AChOyVW0V3Tk6Mk2sM1d0ivL1GNMk/o2UBB+oJcbScS
        bxzHv3M8lVuXrvCdQu1MfI6rZ0XK
X-Google-Smtp-Source: AAOMgpfDGBKrOZ6OWQys1eo6S46nyMV2u7gF3LdESxEvxhaiE98iG38LD8SyyMK0zrWoZixB2GkGgw==
X-Received: by 2002:adf:aadb:: with SMTP id i27-v6mr1754097wrc.149.1530714081513;
        Wed, 04 Jul 2018 07:21:21 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 9/9] staging: rtl8192u: Add space after ',' character - Coding Style
Date:   Wed,  4 Jul 2018 15:20:56 +0100
Message-Id: <20180704142056.2179-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch requires a space after ',' - Added.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 57 ++++++++++---------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index c7c391b1077e..5895d6e5eb67 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -248,7 +248,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 
 			/* avoid watchdog triggers */
 			netif_trans_update(ieee->dev);
-			ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
+			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
 			//dev_kfree_skb_any(skb);//edit by thomas
 		}
 
@@ -265,14 +265,14 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 			ieee->seq_ctrl[0]++;
 
 		/* check whether the managed packet queued greater than 5 */
-		if(!ieee->check_nic_enough_desc(ieee->dev,tcb_desc->queue_index) ||\
+		if(!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) ||\
 				(skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) ||\
 				(ieee->queue_stop) ) {
 			/* insert the skb packet to the management queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
 			 * */
-			printk("%s():insert to waitqueue!\n",__func__);
+			printk("%s():insert to waitqueue!\n", __func__);
 			skb_queue_tail(&ieee->skb_waitQ[tcb_desc->queue_index], skb);
 		} else {
 			ieee->softmac_hard_start_xmit(skb, ieee->dev);
@@ -299,7 +299,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 
 		/* avoid watchdog triggers */
 		netif_trans_update(ieee->dev);
-		ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
+		ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
 	}else{
 
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
@@ -347,8 +347,8 @@ static inline struct sk_buff *ieee80211_probe_req(struct ieee80211_device *ieee)
 	memcpy(tag, ieee->current_network.ssid, len);
 	tag += len;
 
-	ieee80211_MFIE_Brate(ieee,&tag);
-	ieee80211_MFIE_Grate(ieee,&tag);
+	ieee80211_MFIE_Brate(ieee, &tag);
+	ieee80211_MFIE_Grate(ieee, &tag);
 	return skb;
 }
 
@@ -523,7 +523,7 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 static void ieee80211_beacons_start(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ieee->beacon_lock,flags);
+	spin_lock_irqsave(&ieee->beacon_lock, flags);
 
 	ieee->beacon_txing = 1;
 	ieee80211_send_beacon(ieee);
@@ -659,7 +659,7 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 		auth->algorithm = cpu_to_le16(WLAN_AUTH_SHARED_KEY);
 	else if(ieee->auth_mode == 2)
 		auth->algorithm = WLAN_AUTH_OPEN; /* 0x80; */
-	printk("=================>%s():auth->algorithm is %d\n",__func__,auth->algorithm);
+	printk("=================>%s():auth->algorithm is %d\n", __func__, auth->algorithm);
 	auth->transaction = cpu_to_le16(ieee->associate_seq);
 	ieee->associate_seq++;
 
@@ -714,8 +714,8 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
 	tmp_ht_info_buf = (u8 *)&(ieee->pHTInfo->SelfHTInfo);
 	tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
-	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len,encrypt);
-	HTConstructInfoElement(ieee,tmp_ht_info_buf,&tmp_ht_info_len, encrypt);
+	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len, encrypt);
+	HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len, encrypt);
 
 	if (pHTInfo->bRegRT2RTAggregation)
 	{
@@ -742,7 +742,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 		return NULL;
 	skb_reserve(skb, ieee->tx_headroom);
 	beacon_buf = skb_put(skb, (beacon_size - ieee->tx_headroom));
-	memcpy (beacon_buf->header.addr1, dest,ETH_ALEN);
+	memcpy (beacon_buf->header.addr1, dest, ETH_ALEN);
 	memcpy (beacon_buf->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
 	memcpy (beacon_buf->header.addr3, ieee->current_network.bssid, ETH_ALEN);
 
@@ -838,7 +838,7 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 	assoc = skb_put(skb, sizeof(struct ieee80211_assoc_response_frame));
 
 	assoc->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_ASSOC_RESP);
-	memcpy(assoc->header.addr1, dest,ETH_ALEN);
+	memcpy(assoc->header.addr1, dest, ETH_ALEN);
 	memcpy(assoc->header.addr3, ieee->dev->dev_addr, ETH_ALEN);
 	memcpy(assoc->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
 	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
@@ -979,7 +979,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	int len = 0;
 
 	crypt = ieee->crypt[ieee->tx_keyidx];
-	encrypt = ieee->host_encrypt && crypt && crypt->ops && ((0 == strcmp(crypt->ops->name,"WEP") || wpa_ie_len));
+	encrypt = ieee->host_encrypt && crypt && crypt->ops && ((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 
 	/* Include High Throuput capability && Realtek proprietary */
 	if (ieee->pHTInfo->bCurrentHTSupport&&ieee->pHTInfo->bEnableHT)
@@ -1419,7 +1419,12 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 
 				strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
 				ieee->current_network.ssid_len = tmp_ssid_len;
-				printk(KERN_INFO"Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",ieee->current_network.ssid,ieee->current_network.channel, ieee->current_network.qos_data.supported, ieee->pHTInfo->bEnableHT, ieee->current_network.bssht.bdSupportHT);
+				printk(KERN_INFO"Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",
+				       ieee->current_network.ssid,
+				       ieee->current_network.channel,
+				       ieee->current_network.qos_data.supported,
+				       ieee->pHTInfo->bEnableHT,
+				       ieee->current_network.bssht.bdSupportHT);
 
 				//ieee->pHTInfo->IOTAction = 0;
 				HTResetIOTSetting(ieee->pHTInfo);
@@ -1489,7 +1494,7 @@ static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 	struct ieee80211_authentication *a;
 	u8 *t;
 	if (skb->len < (sizeof(struct ieee80211_authentication) - sizeof(struct ieee80211_info_element))) {
-		IEEE80211_DEBUG_MGMT("invalid len in auth resp: %d\n",skb->len);
+		IEEE80211_DEBUG_MGMT("invalid len in auth resp: %d\n", skb->len);
 		return 0xcafe;
 	}
 	*challenge = NULL;
@@ -1513,12 +1518,12 @@ static int auth_rq_parse(struct sk_buff *skb, u8 *dest)
 	struct ieee80211_authentication *a;
 
 	if (skb->len < (sizeof(struct ieee80211_authentication) - sizeof(struct ieee80211_info_element))) {
-		IEEE80211_DEBUG_MGMT("invalid len in auth request: %d\n",skb->len);
+		IEEE80211_DEBUG_MGMT("invalid len in auth request: %d\n", skb->len);
 		return -1;
 	}
 	a = (struct ieee80211_authentication *)skb->data;
 
-	memcpy(dest,a->header.addr2, ETH_ALEN);
+	memcpy(dest, a->header.addr2, ETH_ALEN);
 
 	if (le16_to_cpu(a->algorithm) != WLAN_AUTH_OPEN)
 		return  WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG;
@@ -1539,7 +1544,7 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 	if (skb->len < sizeof (struct rtl_80211_hdr_3addr  ))
 		return -1; /* corrupted */
 
-	memcpy(src,header->addr2, ETH_ALEN);
+	memcpy(src, header->addr2, ETH_ALEN);
 
 	skbend = (u8 *)skb->data + skb->len;
 
@@ -1576,7 +1581,7 @@ static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
 
 	a = (struct ieee80211_assoc_request_frame *)skb->data;
 
-	memcpy(dest,a->header.addr2,ETH_ALEN);
+	memcpy(dest, a->header.addr2, ETH_ALEN);
 
 	return 0;
 }
@@ -1733,7 +1738,7 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 		spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 	}
 
-	sleep = ieee80211_sta_ps_sleep(ieee,&th, &tl);
+	sleep = ieee80211_sta_ps_sleep(ieee, &th, &tl);
 	/* 2 wake, 1 sleep, 0 do nothing */
 	if(sleep == 0)
 		goto out;
@@ -1802,7 +1807,7 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
 		/* Null frame with PS bit set */
 		if (success) {
 			ieee->sta_sleep = 1;
-			ieee->enter_sleep_state(ieee->dev,ieee->ps_th,ieee->ps_tl);
+			ieee->enter_sleep_state(ieee->dev, ieee->ps_th, ieee->ps_tl);
 		}
 		/* if the card report not success we can't be sure the AP
 		 * has not RXed so we can't assume the AP believe us awake
@@ -1953,9 +1958,9 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				if (ieee->qos_support) {
 					assoc_resp = (struct ieee80211_assoc_response_frame *)skb->data;
 					memset(network, 0, sizeof(*network));
-					if (ieee80211_parse_info_param(ieee,assoc_resp->info_element,\
+					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,\
 								rx_stats->len - sizeof(*assoc_resp),\
-								network,rx_stats)){
+								network, rx_stats)){
 						return 1;
 					}
 					else
@@ -2088,7 +2093,7 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 #else
 		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
 #endif
-		(!ieee->check_nic_enough_desc(ieee->dev,queue_index)) || \
+		(!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
 		     (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/* as for the completion function, it does not need
@@ -2180,7 +2185,7 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 			else
 				ieee->seq_ctrl[0]++;
 
-			ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
+			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
 			//dev_kfree_skb_any(skb);//edit by thomas
 		}
 	}
@@ -3071,7 +3076,7 @@ int ieee80211_wpa_supplicant_ioctl(struct ieee80211_device *ieee, struct iw_poin
 		break;
 
 	default:
-		printk("Unknown WPA supplicant request: %d\n",param->cmd);
+		printk("Unknown WPA supplicant request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 	}
-- 
2.17.1

