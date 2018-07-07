Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65FDC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5F2089D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghjnQczf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED5F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeGGOzu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:55:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39197 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbeGGOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so953744wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1pvv2Jgswn79DRB3kDfu1s3vypndYh5f9J63BFkli58=;
        b=ghjnQczfskHTzVrDJK8MgJF/OejH299R5MgLxcfhMdf1L2Rdo5GP3OlGYCjfAutdgk
         9IdpIBVFsm6kAyOBWs92N/rg0454IAh1V9keHT1748RGbeMjeIkp1qeiE4HErdlg3WxR
         bEWPpOkLDPWnLqEqORi7nRo0lpZq4O0KerW1hxcMC96c36gLIwxErAt1a6CTiS7RqSAW
         hyICeRmzRf5Ul4lXYqS/ufd6RI4FIvI5tgDzjUNtJ5qLYOVIqJJ37s/jL2VACfcM3wBN
         oYTsPeETL21QMGRGTOXp0PeREeQB+4+CvNKeuvLJYoopVRsjGxHYHuuc0V+saWPPEp9t
         1O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1pvv2Jgswn79DRB3kDfu1s3vypndYh5f9J63BFkli58=;
        b=HyHBmKw28YFjSKWs9yaSrCiDo5bWuPaDsCsNMoih5+ZTuUJgKQ0bTZoU2p9dqHgKcQ
         dty8H9MDiMYkOhMe5QE0F/GKonh0uh7SXC6r2I3pG+oq/x7nweqsHHZOdTFPzsV7M6h6
         +QE/0D66C3B7TBoXNE/wAooB+15IqoOAG/MsEHahLvnxGuGbCpQElQ5sjNu8hkenGKVH
         pw1gbvKIkoB02uJvMpNP0WGgtslY73J9toud5+GBVCWTK5gjCRiBUhw5JDPXYvOODUjE
         YNOSljWB7ExY8s1PpMHX2Kmkv/VFmPAdPEbCjzuNYAgtZXzzRL611v/kWvnxpWhEED1o
         jK0A==
X-Gm-Message-State: APt69E1T0i6DwMXtVlm/oFkNBbNI4+XQr6MiAqRdfGLlIgu/RWB6b8Dp
        D1KjsZ/ohwHKTZ/7LIPcUr8K/g==
X-Google-Smtp-Source: AAOMgpf7+gZO9oY81+kGq+YK0rGHHmRimKgT/X3FBoRKvTfLSrnBZGXKVq9Y2i/mx8FgMwbKxbi4AA==
X-Received: by 2002:a1c:6546:: with SMTP id z67-v6mr8066856wmb.130.1530975345955;
        Sat, 07 Jul 2018 07:55:45 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/12] staging:rtl8192u: Correction of indentation issues - Coding Style
Date:   Sat,  7 Jul 2018 15:55:13 +0100
Message-Id: <20180707145513.15325-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple changes to correct indentation issues.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index e1a91db7f0a1..b1dc8d2eba0e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2354,10 +2354,10 @@ void ieee80211_disassociate(struct ieee80211_device *ieee)
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
@@ -2508,9 +2508,9 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
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
@@ -2968,14 +2968,14 @@ SendDisassociation(struct ieee80211_device *ieee,
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

