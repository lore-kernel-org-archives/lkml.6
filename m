Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE06C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BC0208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYQvEG2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BC0208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933932AbeGJPFz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:05:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37343 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:05:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so16824532edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96tP4SSKq0p2mloxCaOcpxs3o8FWxzvVeI7EbRBc5Yc=;
        b=rYQvEG2n6qo5l8Ybsj7ZyOITNBa56wifbrBhzO2bsFL1M6noELy68Smkpulv01UjGU
         nucMpBe9lgJyDOjzmsocNfqKizmGBDCYTn3f+lX3mzYyBXwQUACcLz4oOQjQTWlV2KnM
         VLsC/joPfuD2SQLEVrXlHpjT5IKwT3sQsc34rSflKkeIsLA3zYzm8bcchIRRXaqhJw5+
         qHE1PBaRaiSCR+OjVD2ZMzrv+ohMM6JQOXRdVHkV1rYvO6mhTUhEr5zQnURx57A7jVA1
         DL0+8F7v/mukETYHCMaFCsIyMapiJkQmAmdZu11d8919AOZon81x9Zft5E1y+0aXHWR3
         0tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96tP4SSKq0p2mloxCaOcpxs3o8FWxzvVeI7EbRBc5Yc=;
        b=ToLMt1K352yqfXPn53Yqbee73iCEtuy2z0RBE7EbYP3KR2ON7HMqhp2yP7GM3H6ZMG
         6aa5j3cNWud+fxSJuezwKH1ewth0o8Q9p69QKCv5MU1rf19w9omgV1Jxm5TYOt78girT
         4jqKc2KmfeRiszRfxRNP+2VUGD7qb/BmChLTcrlwLKVRI1ZbDYeCBWYxia1HWKEy5Ccz
         bgzw9ptFBmIiI3lGt0Bzqp+ZjmTSmG/wc/xrw3gg3HUl4K8Ugn8cEVGmOldTXG5QCCc+
         Uqlwi7WW/t6MthTq/JJS9sCzaky41xxNkmgDbPSNv5hco4esj/gc136WuxseojCwkqkv
         PgOw==
X-Gm-Message-State: APt69E391L7Uo06aN5t4tkqyWrv1YHpZezyQ+t8QT4kA05SrYPAsACiN
        QGtlyLMlhgNxgAcsgTYVMlNApXYt
X-Google-Smtp-Source: AAOMgpd9Sy4slkL/OsoROChPyWXQRtMOLOUaYrMpbZ3h34Bgvz66spM9OKxMyfhjOFMw5iUdrkU8CA==
X-Received: by 2002:a50:b723:: with SMTP id g32-v6mr27540381ede.139.1531235150197;
        Tue, 10 Jul 2018 08:05:50 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:05:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 1/8] staging:rtl8192u: Remove blank lines before '}' and after '{' characters
Date:   Tue, 10 Jul 2018 16:05:16 +0100
Message-Id: <20180710150523.17384-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710150523.17384-1-johnfwhitmore@gmail.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style change to simply remove the unrequired blanks lines before a
closing brace or after an opening brace.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c     | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 553e4aff235c..b971c404f152 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -78,7 +78,6 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 	u8 *tag = *tag_p;
 
 		if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
-
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
@@ -1573,7 +1569,6 @@ static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
 
 	if (skb->len < (sizeof(struct ieee80211_assoc_request_frame) -
 		sizeof(struct ieee80211_info_element))) {
-
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
 
@@ -1728,7 +1721,6 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 	if ((ieee->ps == IEEE80211_PS_DISABLED ||
 		ieee->iw_mode != IW_MODE_INFRA ||
 		ieee->state != IEEE80211_LINKED)){
-
 	//	#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
@@ -2000,7 +1992,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
 			if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING
 				&& ieee->iw_mode == IW_MODE_INFRA) {
-
 				IEEE80211_DEBUG_MGMT("Received auth response");
 				ieee80211_check_auth_response(ieee, skb);
 			} else if (ieee->iw_mode == IW_MODE_MASTER) {
@@ -2026,7 +2017,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 			ieee->state == IEEE80211_LINKED &&
 			ieee->iw_mode == IW_MODE_INFRA){
-
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
@@ -2173,7 +2160,6 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 
 	if (ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) {
 		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))){
-
 			header = (struct rtl_80211_hdr_3addr  *)skb->data;
 
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
@@ -2243,7 +2229,6 @@ void ieee80211_start_master_bss(struct ieee80211_device *ieee)
 static void ieee80211_start_monitor_mode(struct ieee80211_device *ieee)
 {
 	if (ieee->raw_tx) {
-
 		if (ieee->data_hard_resume)
 			ieee->data_hard_resume(ieee->dev);
 
@@ -2303,7 +2288,6 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 			eth_random_addr(ieee->current_network.bssid);
 
 		if (ieee->modulation & IEEE80211_CCK_MODULATION){
-
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

