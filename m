Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F2823E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwxVd/Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F2823E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeGDOVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35318 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbeGDOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so2332992wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sg92mpfihJWi/7073ROBB6EhnSUIe25bhVC7K6SewTM=;
        b=EwxVd/Izsun5lKhvo8qiyYWCDsrnPI7VPgAdukKTHdQnRpAqdavwrdg72WQeeJtaQl
         wO1O3DDKYAY13Sr9QvZUA50IuJBJZlWjqPKIvy0Kh8VAbpcxnhSbhgwDKSB+xIUFdMqt
         TQjwz7sn1tIyti6SKEpz5ZiwpyhdWS2pQsOC2jKowKS9Gq5rnfShM97iB856qZf3p4h5
         b9ho53mDhb7F65ijTTw54GpVvGcw+UQ3WS/NLqjpcJMZ8mYwvg+8AkBmMnWCCbJtubuG
         H5RhMLP/YFWJWS/bT7kJWG+7n7NH9DLu9xk9NzI+Iyv7YaFCtwxBvSBaJD1dwPV5U4o6
         jLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sg92mpfihJWi/7073ROBB6EhnSUIe25bhVC7K6SewTM=;
        b=H/pKICJOAA75Dit0IPjae226hz9gzzCYgB6K64RY1CMGeG+mNB+i0hUl+XJ6PwdESQ
         iLFO1gFhy89gyLQp12FnuWNIGiRFO6tZQKulOf6wfN4i3EcJ28aJipFhgTVqSOJwrMzS
         1o98FlLuqswqJyG89ahhWfEavsbwVMXPHlNcFXYww3wZ6XciPbd7P9sHBUCNNsoKlZFE
         cnRX8tI09SovU/VNqetL8cgySQF6XbDVRyt8HKWbhljznf9hwZdCmOAICitbNyB4dJDE
         zJgMiPvupH+FQfqUWoQeQL6v68HZu8tkYcIHOz+mvdsMvS+KDOtGxJNt1sftOE6IckLF
         9K4A==
X-Gm-Message-State: APt69E3NO7OCnWyeSKn/VylmEIAtPEQnaFBeFBSTMDULGazmQgxroAMI
        Z2Z4sIevLBADnzJ6HOIaoRTY1PWK
X-Google-Smtp-Source: AAOMgpcOHcNN462MsZb6BwfdFHqqHrIl2A/QU8HUta/bmqRT76aEAxo1i3VHKc0on6xCVZ+iOX57vg==
X-Received: by 2002:adf:c4a7:: with SMTP id m36-v6mr1797251wrf.103.1530714072382;
        Wed, 04 Jul 2018 07:21:12 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 4/9] staging: rtl8192u: Remove superfluous blank lines - Coding Style
Date:   Wed,  4 Jul 2018 15:20:51 +0100
Message-Id: <20180704142056.2179-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of extra blank lines from the ieee80211_softmac.c file

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 105 ------------------
 1 file changed, 105 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 9d9a9e102bb8..7ef761632629 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -12,8 +12,6 @@
  *
  * released under the GPL
  */
-
-
 #include "ieee80211.h"
 
 #include <linux/random.h>
@@ -98,7 +96,6 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 	*tag_p = tag;
 }
 
-
 static void ieee80211_WMM_Info(struct ieee80211_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
@@ -216,7 +213,6 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 	return rate;
 }
 
-
 void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl);
 
 inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
@@ -289,14 +285,11 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 static inline void
 softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 {
-
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
 	struct rtl_80211_hdr_3addr  *header =
 		(struct rtl_80211_hdr_3addr  *) skb->data;
 
-
 	if(single){
-
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -307,7 +300,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 		/* avoid watchdog triggers */
 		netif_trans_update(ieee->dev);
 		ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
-
 	}else{
 
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
@@ -318,7 +310,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 			ieee->seq_ctrl[0]++;
 
 		ieee->softmac_hard_start_xmit(skb, ieee->dev);
-
 	}
 	//dev_kfree_skb_any(skb);//edit by thomas
 }
@@ -390,7 +381,6 @@ static void ieee80211_send_beacon(struct ieee80211_device *ieee)
 	//spin_unlock_irqrestore(&ieee->beacon_lock,flags);
 }
 
-
 static void ieee80211_send_beacon_cb(struct timer_list *t)
 {
 	struct ieee80211_device *ieee =
@@ -402,7 +392,6 @@ static void ieee80211_send_beacon_cb(struct timer_list *t)
 	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
 }
 
-
 static void ieee80211_send_probe(struct ieee80211_device *ieee)
 {
 	struct sk_buff *skb;
@@ -436,7 +425,6 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 
 	while(1)
 	{
-
 		do{
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
@@ -475,7 +463,6 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 			goto out;
 
 		msleep_interruptible(IEEE80211_SOFTMAC_SCAN_TIME);
-
 	}
 out:
 	if(ieee->state < IEEE80211_LINKED){
@@ -520,7 +507,6 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	if(channel_map[ieee->current_network.channel] == 1)
 		ieee80211_send_probe_requests(ieee);
 
-
 	schedule_delayed_work(&ieee->softmac_scan_wq, IEEE80211_SOFTMAC_SCAN_TIME);
 
 	mutex_unlock(&ieee->scan_mutex);
@@ -534,8 +520,6 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	mutex_unlock(&ieee->scan_mutex);
 }
 
-
-
 static void ieee80211_beacons_start(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
@@ -557,10 +541,8 @@ static void ieee80211_beacons_stop(struct ieee80211_device *ieee)
 	del_timer_sync(&ieee->beacon_timer);
 
 	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
-
 }
 
-
 void ieee80211_stop_send_beacons(struct ieee80211_device *ieee)
 {
 	if(ieee->stop_send_beacons)
@@ -624,7 +606,6 @@ static void ieee80211_start_scan(struct ieee80211_device *ieee)
 		}
 	}else
 		ieee->start_scan(ieee->dev);
-
 }
 
 /* called with wx_mutex held */
@@ -642,7 +623,6 @@ void ieee80211_start_scan_syncro(struct ieee80211_device *ieee)
 		ieee80211_softmac_scan_syncro(ieee);
 	else
 		ieee->scan_syncro(ieee->dev);
-
 }
 EXPORT_SYMBOL(ieee80211_start_scan_syncro);
 
@@ -654,7 +634,6 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 	struct ieee80211_authentication *auth;
 	int len = sizeof(struct ieee80211_authentication) + challengelen + ieee->tx_headroom;
 
-
 	skb = dev_alloc_skb(len);
 	if (!skb) return NULL;
 
@@ -687,10 +666,8 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 	auth->status = cpu_to_le16(WLAN_STATUS_SUCCESS);
 
 	return skb;
-
 }
 
-
 static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *dest)
 {
 	u8 *tag;
@@ -728,10 +705,8 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	else
 		erp_len = 0;
 
-
 	crypt = ieee->crypt[ieee->tx_keyidx];
 
-
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 	/* HT ralated element */
@@ -742,7 +717,6 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len,encrypt);
 	HTConstructInfoElement(ieee,tmp_ht_info_buf,&tmp_ht_info_len, encrypt);
 
-
 	if (pHTInfo->bRegRT2RTAggregation)
 	{
 		tmp_generic_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
@@ -787,7 +761,6 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	if (encrypt)
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
-
 	beacon_buf->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_PROBE_RESP);
 	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
 	beacon_buf->info_element[0].len = ssid_len;
@@ -842,7 +815,6 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	return skb;
 }
 
-
 static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 					    u8 *dest)
 {
@@ -872,7 +844,6 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
 		WLAN_CAPABILITY_BSS : WLAN_CAPABILITY_IBSS);
 
-
 	if(ieee->short_slot)
 		assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 
@@ -923,8 +894,6 @@ static struct sk_buff *ieee80211_auth_resp(struct ieee80211_device *ieee,
 	memcpy(auth->header.addr1, dest, ETH_ALEN);
 	auth->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_AUTH);
 	return skb;
-
-
 }
 
 static struct sk_buff *ieee80211_null_func(struct ieee80211_device *ieee,
@@ -949,11 +918,8 @@ static struct sk_buff *ieee80211_null_func(struct ieee80211_device *ieee,
 		(pwr ? IEEE80211_FCTL_PM:0));
 
 	return skb;
-
-
 }
 
-
 static void ieee80211_resp_to_assoc_rq(struct ieee80211_device *ieee, u8 *dest)
 {
 	struct sk_buff *buf = ieee80211_assoc_resp(ieee, dest);
@@ -962,7 +928,6 @@ static void ieee80211_resp_to_assoc_rq(struct ieee80211_device *ieee, u8 *dest)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static void ieee80211_resp_to_auth(struct ieee80211_device *ieee, int s,
 				   u8 *dest)
 {
@@ -972,17 +937,13 @@ static void ieee80211_resp_to_auth(struct ieee80211_device *ieee, int s,
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static void ieee80211_resp_to_probe(struct ieee80211_device *ieee, u8 *dest)
 {
-
-
 	struct sk_buff *buf = ieee80211_probe_resp(ieee, dest);
 	if (buf)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static inline struct sk_buff *
 ieee80211_association_req(struct ieee80211_network *beacon,
 			  struct ieee80211_device *ieee)
@@ -1031,14 +992,12 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 			realtek_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
 			realtek_ie_len = sizeof( ieee->pHTInfo->szRT2RTAggBuffer);
 			HTConstructRT2RTAggElement(ieee, realtek_ie_buf, &realtek_ie_len);
-
 		}
 	}
 	if (ieee->qos_support) {
 		wmm_info_len = beacon->qos_data.supported?9:0;
 	}
 
-
 	if (beacon->bCkipSupported)
 	{
 		ckip_ie_len = 30+2;
@@ -1076,7 +1035,6 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		+ cxvernum_ie_len
 		+ ieee->tx_headroom;
 #endif
-
 	skb = dev_alloc_skb(len);
 
 	if (!skb)
@@ -1086,7 +1044,6 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 	hdr = skb_put(skb, sizeof(struct ieee80211_assoc_request_frame) + 2);
 
-
 	hdr->header.frame_ctl = IEEE80211_STYPE_ASSOC_REQ;
 	hdr->header.duration_id = cpu_to_le16(37);
 	memcpy(hdr->header.addr1, beacon->bssid, ETH_ALEN);
@@ -1182,7 +1139,6 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		}
 	}
 
-
 	//choose what wpa_supplicant gives to associate.
 	if (wpa_ie_len) {
 		skb_put_data(skb, ieee->wpa_ie, wpa_ie_len);
@@ -1223,7 +1179,6 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 void ieee80211_associate_abort(struct ieee80211_device *ieee)
 {
-
 	unsigned long flags;
 	spin_lock_irqsave(&ieee->lock, flags);
 
@@ -1258,7 +1213,6 @@ static void ieee80211_associate_abort_cb(struct timer_list *t)
 	ieee80211_associate_abort(dev);
 }
 
-
 static void ieee80211_associate_step1(struct ieee80211_device *ieee)
 {
 	struct ieee80211_network *beacon = &ieee->current_network;
@@ -1430,7 +1384,6 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 	if ((ieee->iw_mode == IW_MODE_ADHOC) && !(net->capability & WLAN_CAPABILITY_IBSS))
 		return;
 
-
 	if (ieee->iw_mode == IW_MODE_INFRA || ieee->iw_mode == IW_MODE_ADHOC) {
 		/* if the user specified the AP MAC, we need also the essid
 		 * This could be obtained by beacons or, if the network does not
@@ -1443,7 +1396,6 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len)&&\
 				(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
 
-
 		if (	/* if the user set the AP check if match.
 			 * if the network does not broadcast essid we check the user supplyed ANY essid
 			 * if the network does broadcast and the user does not set essid it is OK
@@ -1505,10 +1457,8 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 					//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 					ieee->state = IEEE80211_LINKED;
 				}
-
 		}
 	}
-
 }
 
 void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
@@ -1532,10 +1482,8 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
 	}
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 
-
 static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 {
 	struct ieee80211_authentication *a;
@@ -1558,10 +1506,8 @@ static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 	}
 
 	return le16_to_cpu(a->status);
-
 }
 
-
 static int auth_rq_parse(struct sk_buff *skb, u8 *dest)
 {
 	struct ieee80211_authentication *a;
@@ -1615,7 +1561,6 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	if (!ssid) return 1; /* ssid not found in tagged param */
 	return (!strncmp(ssid, ieee->current_network.ssid, ssidlen));
-
 }
 
 static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
@@ -1697,7 +1642,6 @@ ieee80211_rx_auth_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 static inline void
 ieee80211_rx_assoc_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
-
 	u8 dest[ETH_ALEN];
 	//unsigned long flags;
 
@@ -1713,7 +1657,6 @@ ieee80211_rx_assoc_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 static void ieee80211_sta_ps_send_null_frame(struct ieee80211_device *ieee,
 					     short pwr)
 {
-
 	struct sk_buff *buf = ieee80211_null_func(ieee, pwr);
 
 	if (buf)
@@ -1767,13 +1710,10 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 	}
 
 	return 1;
-
-
 }
 
 static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 {
-
 	u32 th, tl;
 	short sleep;
 
@@ -1799,7 +1739,6 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 		goto out;
 
 	if(sleep == 1){
-
 		if(ieee->sta_sleep == 1)
 			ieee->enter_sleep_state(ieee->dev, th, tl);
 
@@ -1808,8 +1747,6 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
 			if(ieee->ps_is_queue_empty(ieee->dev)){
-
-
 				ieee->sta_sleep = 2;
 
 				ieee->ps_request_tx_ack(ieee->dev);
@@ -1820,10 +1757,7 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 				ieee->ps_tl = tl;
 			}
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
-
 		}
-
-
 	}else if(sleep == 2){
 //#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
@@ -1832,10 +1766,8 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 
 		spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 	}
-
 out:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 
 void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl)
@@ -1847,7 +1779,6 @@ void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl)
 			ieee80211_sta_ps_send_null_frame(ieee, 0);
 		}
 		return;
-
 	}
 
 	if(ieee->sta_sleep == 1)
@@ -1879,7 +1810,6 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
 	}
 	/* 21112005 - tx again null without PS bit if lost */
 	else {
-
 		if ((ieee->sta_sleep == 0) && !success) {
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 			ieee80211_sta_ps_send_null_frame(ieee, 0);
@@ -1917,7 +1847,6 @@ static void ieee80211_process_action(struct ieee80211_device *ieee,
 		break;
 	}
 	return;
-
 }
 
 static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
@@ -2004,10 +1933,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		ieee->last_rx_ps_time = jiffies;
 
 	switch (WLAN_FC_GET_STYPE(header->frame_ctl)) {
-
 	case IEEE80211_STYPE_ASSOC_RESP:
 	case IEEE80211_STYPE_REASSOC_RESP:
-
 		IEEE80211_DEBUG_MGMT("received [RE]ASSOCIATION RESPONSE (%d)\n",
 				WLAN_FC_GET_STYPE(header->frame_ctl));
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
@@ -2060,7 +1987,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	case IEEE80211_STYPE_ASSOC_REQ:
 	case IEEE80211_STYPE_REASSOC_REQ:
-
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 			ieee->iw_mode == IW_MODE_MASTER)
 
@@ -2068,7 +1994,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		break;
 
 	case IEEE80211_STYPE_AUTH:
-
 		if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
 			if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING
 				&& ieee->iw_mode == IW_MODE_INFRA) {
@@ -2082,7 +2007,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		break;
 
 	case IEEE80211_STYPE_PROBE_REQ:
-
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 			((ieee->iw_mode == IW_MODE_ADHOC ||
 			ieee->iw_mode == IW_MODE_MASTER) &&
@@ -2140,7 +2064,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
  */
 void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *ieee)
 {
-
 	unsigned int queue_index = txb->queue_index;
 	unsigned long flags;
 	int  i;
@@ -2215,12 +2138,10 @@ static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 		}
 	}
 
-
 	ieee80211_txb_free(ieee->tx_pending.txb);
 	ieee->tx_pending.txb = NULL;
 }
 
-
 void ieee80211_reset_queue(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
@@ -2233,13 +2154,11 @@ void ieee80211_reset_queue(struct ieee80211_device *ieee)
 	}
 	ieee->queue_stop = 0;
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 EXPORT_SYMBOL(ieee80211_reset_queue);
 
 void ieee80211_wake_queue(struct ieee80211_device *ieee)
 {
-
 	unsigned long flags;
 	struct sk_buff *skb;
 	struct rtl_80211_hdr_3addr  *header;
@@ -2272,7 +2191,6 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 		ieee->softmac_stats.swtxawake++;
 		netif_wake_queue(ieee->dev);
 	}
-
 exit :
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
@@ -2289,7 +2207,6 @@ void ieee80211_stop_queue(struct ieee80211_device *ieee)
 	}
 	ieee->queue_stop = 1;
 	//spin_unlock_irqrestore(&ieee->lock,flags);
-
 }
 EXPORT_SYMBOL(ieee80211_stop_queue);
 
@@ -2332,7 +2249,6 @@ static void ieee80211_start_monitor_mode(struct ieee80211_device *ieee)
 }
 static void ieee80211_start_ibss_wq(struct work_struct *work)
 {
-
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ieee80211_device *ieee = container_of(dwork, struct ieee80211_device, start_ibss_wq);
 	/* iwconfig mode ad-hoc will schedule this and return
@@ -2357,7 +2273,6 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	/* check if we have this cell in our network list */
 	ieee80211_softmac_check_all_nets(ieee);
 
-
 //	if((IS_DOT11D_ENABLE(ieee)) && (ieee->state == IEEE80211_NOLINK))
 	if (ieee->state == IEEE80211_NOLINK)
 		ieee->current_network.channel = 6;
@@ -2392,7 +2307,6 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 			ieee->current_network.rates[1] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_2MB;
 			ieee->current_network.rates[2] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_5MB;
 			ieee->current_network.rates[3] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_11MB;
-
 		}else
 			ieee->current_network.rates_len = 0;
 
@@ -2486,8 +2400,6 @@ void ieee80211_start_bss(struct ieee80211_device *ieee)
 /* called only in userspace context */
 void ieee80211_disassociate(struct ieee80211_device *ieee)
 {
-
-
 	netif_carrier_off(ieee->dev);
 	if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)
 			ieee80211_reset_queue(ieee);
@@ -2501,7 +2413,6 @@ void ieee80211_disassociate(struct ieee80211_device *ieee)
 	ieee->link_change(ieee->dev);
 	//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	notify_wx_assoc_event(ieee);
-
 }
 EXPORT_SYMBOL(ieee80211_disassociate);
 
@@ -2562,7 +2473,6 @@ struct sk_buff *ieee80211_get_beacon_(struct ieee80211_device *ieee)
 	b->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_BEACON);
 
 	return skb;
-
 }
 
 struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee)
@@ -2653,7 +2563,6 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 
 	ieee->init_wmmparam_flag = 0;//reinitialize AC_xx_PARAM registers.
 
-
 	/* if the user set the MAC of the ad-hoc cell and then
 	 * switch to managed mode, shall we  make sure that association
 	 * attempts does not fail just because the user provide the essid
@@ -2672,7 +2581,6 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 		ieee80211_start_monitor_mode(ieee);
 }
 
-
 #define DRV_NAME  "Ieee80211"
 void ieee80211_softmac_init(struct ieee80211_device *ieee)
 {
@@ -2724,7 +2632,6 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 
 	timer_setup(&ieee->beacon_timer, ieee80211_send_beacon_cb, 0);
 
-
 	INIT_DELAYED_WORK(&ieee->start_ibss_wq, ieee80211_start_ibss_wq);
 	INIT_WORK(&ieee->associate_complete_wq, ieee80211_associate_complete_wq);
 	INIT_WORK(&ieee->associate_procedure_wq, ieee80211_associate_procedure_wq);
@@ -2732,7 +2639,6 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	INIT_DELAYED_WORK(&ieee->associate_retry_wq, ieee80211_associate_retry_wq);
 	INIT_WORK(&ieee->wx_sync_scan_wq, ieee80211_wx_sync_scan_wq);
 
-
 	mutex_init(&ieee->wx_mutex);
 	mutex_init(&ieee->scan_mutex);
 
@@ -2742,7 +2648,6 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	tasklet_init(&ieee->ps_task,
 	     (void(*)(unsigned long)) ieee80211_sta_ps,
 	     (unsigned long)ieee);
-
 }
 
 void ieee80211_softmac_free(struct ieee80211_device *ieee)
@@ -2761,8 +2666,6 @@ void ieee80211_softmac_free(struct ieee80211_device *ieee)
  * Start of WPA code.                                   *
  * this is stolen from the ipw2200 driver               *
  ********************************************************/
-
-
 static int ieee80211_wpa_enable(struct ieee80211_device *ieee, int value)
 {
 	/* This is called when wpa_supplicant loads and closes the driver
@@ -2772,7 +2675,6 @@ static int ieee80211_wpa_enable(struct ieee80211_device *ieee, int value)
 	return 0;
 }
 
-
 static void ieee80211_wpa_assoc_frame(struct ieee80211_device *ieee,
 				      char *wpa_ie, int wpa_ie_len)
 {
@@ -2782,10 +2684,8 @@ static void ieee80211_wpa_assoc_frame(struct ieee80211_device *ieee,
 	ieee80211_disassociate(ieee);
 }
 
-
 static int ieee80211_wpa_mlme(struct ieee80211_device *ieee, int command, int reason)
 {
-
 	int ret = 0;
 
 	switch (command) {
@@ -2805,7 +2705,6 @@ static int ieee80211_wpa_mlme(struct ieee80211_device *ieee, int command, int re
 	return ret;
 }
 
-
 static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
 			      struct ieee_param *param, int plen)
 {
@@ -2839,7 +2738,6 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
 
 static int ieee80211_wpa_set_auth_algs(struct ieee80211_device *ieee, int value)
 {
-
 	struct ieee80211_security sec = {
 		.flags = SEC_AUTH_MODE,
 	};
@@ -2859,7 +2757,6 @@ static int ieee80211_wpa_set_auth_algs(struct ieee80211_device *ieee, int value)
 		ieee->auth_mode = 2;
 	}
 
-
 	if (ieee->set_security)
 		ieee->set_security(ieee->dev, &sec);
 	//else
@@ -2943,7 +2840,6 @@ static int ieee80211_wpa_set_param(struct ieee80211_device *ieee, u8 name, u32 v
 }
 
 /* implementation borrowed from hostap driver */
-
 static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 				  struct ieee_param *param, int param_len)
 {
@@ -3117,7 +3013,6 @@ static inline struct sk_buff *ieee80211_disassociate_skb(
 	return skb;
 }
 
-
 void
 SendDisassociation(
 		struct ieee80211_device *ieee,
-- 
2.17.1

