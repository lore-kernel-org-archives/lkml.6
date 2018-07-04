Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D51C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D823E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMoBzVdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432D823E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeGDOV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40822 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeGDOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so5945052wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8W721NxzLVacJxtoSL1lP7VR6sq1Y5Yj1Ih6BLi094Y=;
        b=bMoBzVdNcWbUz2KD6yeY20YsFT17eDU2uhsCGIE/wFdm2LE1dVdleLd2ugdG7a1Dh1
         gEEOg3rk4b7i2WwR+ULZC3wey12oeSz6iMOtaWrwKINuNSRxSAAD5Gy4s1R0VcB5Nt4O
         NLVecetJGwhuDcWSupKvtjC3JUp5enN4VltpFaPRvYwpTFWAu8U4ba6ggFXdhjBe3JTU
         9ulw7oG/7g188XlaaxigBs7hod9GQOe7h14Y4far2v/ms941udDDYF5HOJpEbNIX3cxA
         VstTCZsogsGdm+a9nTDdOeM3VmtFtj7oWm6QZgmhkglK7DvX+wg/MWT0qKk4jTbM7BKV
         fxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8W721NxzLVacJxtoSL1lP7VR6sq1Y5Yj1Ih6BLi094Y=;
        b=KsJRBioyP/U59HRoEf3bmtaJzwCtp8P0xVf6Yb0To0CESAbptjOjdgAhFpNTBJHwfo
         x5eqczjZT7GTKwotp8bCNqjS3c8pH8+OVsaWHUj5l2kXFbyWt1RjCySLBI5Nt+8++5FD
         x7GlN0uDMuQ6ILXTvvZ+qqqF+rgEWKlfolra5bKAh11KLM3E+BIXYutUUQTlpd/K95t6
         /Gg/O/d4uwZ2YMSYmMx8PjT1V41WzXzKqtDIoc1hCJljYqB5pOYASwBLm68L1VzC1n0Q
         FV7epOCr9A44c/Gc0WLRzp1qy3egjkh4zL9VL4pI4+gDxUEvlKEr70bTwdQANr81xOM2
         dJgw==
X-Gm-Message-State: APt69E1GEv8+CofrhvqRr8N7TpbHzILM7WQHjerD+bCaXQvgEVKHfXqA
        25UDNPeJoEVSGrysnnDyPIU9CF+P
X-Google-Smtp-Source: AAOMgpcBxhDt9nqO2JXvIkARVV0klqjpVs6ujrgcwjR71bBTRSQHUJytiaCChf1I6VCK3+xMPJ9o3w==
X-Received: by 2002:adf:d24a:: with SMTP id o10-v6mr1755530wri.229.1530714077737;
        Wed, 04 Jul 2018 07:21:17 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 7/9] staging: rtl8192u: Remove space after cast - Coding Style
Date:   Wed,  4 Jul 2018 15:20:54 +0100
Message-Id: <20180704142056.2179-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to checkpatch - No space is necessary after a cast.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 337d86effa69..e7b5cd896f02 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -220,7 +220,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 	unsigned long flags;
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
 	struct rtl_80211_hdr_3addr  *header=
-		(struct rtl_80211_hdr_3addr  *) skb->data;
+		(struct rtl_80211_hdr_3addr  *)skb->data;
 
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
 
@@ -287,7 +287,7 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 {
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
 	struct rtl_80211_hdr_3addr  *header =
-		(struct rtl_80211_hdr_3addr  *) skb->data;
+		(struct rtl_80211_hdr_3addr  *)skb->data;
 
 	if(single){
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
@@ -710,9 +710,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 	/* HT ralated element */
-	tmp_ht_cap_buf =(u8 *) &(ieee->pHTInfo->SelfHTCap);
+	tmp_ht_cap_buf =(u8 *)&(ieee->pHTInfo->SelfHTCap);
 	tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
-	tmp_ht_info_buf =(u8 *) &(ieee->pHTInfo->SelfHTInfo);
+	tmp_ht_info_buf =(u8 *)&(ieee->pHTInfo->SelfHTInfo);
 	tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
 	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len,encrypt);
 	HTConstructInfoElement(ieee,tmp_ht_info_buf,&tmp_ht_info_len, encrypt);
@@ -765,7 +765,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
 	beacon_buf->info_element[0].len = ssid_len;
 
-	tag = (u8 *) beacon_buf->info_element[0].data;
+	tag = (u8 *)beacon_buf->info_element[0].data;
 
 	memcpy(tag, ssid, ssid_len);
 
@@ -1493,7 +1493,7 @@ static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 		return 0xcafe;
 	}
 	*challenge = NULL;
-	a = (struct ieee80211_authentication *) skb->data;
+	a = (struct ieee80211_authentication *)skb->data;
 	if (skb->len > (sizeof(struct ieee80211_authentication) + 3)) {
 		t = skb->data + sizeof(struct ieee80211_authentication);
 
@@ -1516,7 +1516,7 @@ static int auth_rq_parse(struct sk_buff *skb, u8 *dest)
 		IEEE80211_DEBUG_MGMT("invalid len in auth request: %d\n",skb->len);
 		return -1;
 	}
-	a = (struct ieee80211_authentication *) skb->data;
+	a = (struct ieee80211_authentication *)skb->data;
 
 	memcpy(dest,a->header.addr2, ETH_ALEN);
 
@@ -1534,7 +1534,7 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 	u8 ssidlen = 0;
 
 	struct rtl_80211_hdr_3addr   *header =
-		(struct rtl_80211_hdr_3addr   *) skb->data;
+		(struct rtl_80211_hdr_3addr   *)skb->data;
 
 	if (skb->len < sizeof (struct rtl_80211_hdr_3addr  ))
 		return -1; /* corrupted */
@@ -1574,7 +1574,7 @@ static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
 		return -1;
 	}
 
-	a = (struct ieee80211_assoc_request_frame *) skb->data;
+	a = (struct ieee80211_assoc_request_frame *)skb->data;
 
 	memcpy(dest,a->header.addr2,ETH_ALEN);
 
@@ -1591,7 +1591,7 @@ static inline u16 assoc_parse(struct ieee80211_device *ieee, struct sk_buff *skb
 		return 0xcafe;
 	}
 
-	response_head = (struct ieee80211_assoc_response_frame *) skb->data;
+	response_head = (struct ieee80211_assoc_response_frame *)skb->data;
 	*aid = le16_to_cpu(response_head->aid) & 0x3fff;
 
 	status_code = le16_to_cpu(response_head->status);
@@ -1913,7 +1913,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 			struct ieee80211_rx_stats *rx_stats, u16 type,
 			u16 stype)
 {
-	struct rtl_80211_hdr_3addr *header = (struct rtl_80211_hdr_3addr *) skb->data;
+	struct rtl_80211_hdr_3addr *header = (struct rtl_80211_hdr_3addr *)skb->data;
 	u16 errcode;
 	int aid;
 	struct ieee80211_assoc_response_frame *assoc_resp;
@@ -2171,7 +2171,7 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 	if (ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) {
 		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))){
 
-			header = (struct rtl_80211_hdr_3addr  *) skb->data;
+			header = (struct rtl_80211_hdr_3addr  *)skb->data;
 
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
@@ -2469,7 +2469,7 @@ struct sk_buff *ieee80211_get_beacon_(struct ieee80211_device *ieee)
 	if (!skb)
 		return NULL;
 
-	b = (struct ieee80211_probe_response *) skb->data;
+	b = (struct ieee80211_probe_response *)skb->data;
 	b->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_BEACON);
 
 	return skb;
@@ -2484,7 +2484,7 @@ struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee)
 	if(!skb)
 		return NULL;
 
-	b = (struct ieee80211_probe_response *) skb->data;
+	b = (struct ieee80211_probe_response *)skb->data;
 	b->header.seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 	if (ieee->seq_ctrl[0] == 0xFFF)
@@ -2857,7 +2857,7 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
 	if (param_len !=
-	    (int) ((char *) param->u.crypt.key - (char *) param) +
+	    (int)((char *)param->u.crypt.key - (char *)param) +
 	    param->u.crypt.key_len) {
 		printk("Len mismatch %d, %d\n", param_len,
 			       param->u.crypt.key_len);
-- 
2.17.1

