Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F16C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893F820862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oolSaZve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893F820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeGGO4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:56:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeGGOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so198713wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tE8d+TfBfMEZ2UUCuQdHpDqvjhePRyrOfgx6CL34hvw=;
        b=oolSaZveLLlkZlho0XfQrPR8pdtL92GNlLLzFMvldMwuzQP4SW6j+mi6imD2+D/eL9
         myEzURJSv3f9Jj0Qu4y3sOgGp6Mx4n1n4nR+9lZ/nWIclEoIbEUG3ivaFUf+LVGXmMtH
         eSs5tO9L6I0C0kECe2BphxSPAdWQVLaGbH7m+r5/MpTzaPpe2gLwUvTydSN9Hg6zW7Nf
         EGCnseP6+P0C34Djhxj9k4VWUxAonzQUdwsmbcXrL3Gy9Y7Cdhr0kBaKSpNyaCuZiT/Q
         RGvqzhdn4dbY5i+nk8qvOS2Mhl+Fl6jbz725Jor0MWvGNpJZeYrFLrDXgPqz72GJWz2A
         H4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tE8d+TfBfMEZ2UUCuQdHpDqvjhePRyrOfgx6CL34hvw=;
        b=IoAkWKmL5unSxs4xsPFpiOfUrMWV9QC2hLlcN7PGBzWHRoI2Al2LjZgEGzyVF9nZWi
         BowSrU0lGkU56X/Fjvi/G+nA7Ku/JdRiO5HSbOhDAhncpq6/VzKtrBv9CdIuFEjLy9vi
         mV7T7Nn8DHqoBpkhzK64wEqwzVTVoDSaGa6mlf+hwyRoXu4cwk3w4cZK7ZVCEKO+EXoI
         drL6bm+IzD4wuSgm/iPHNGH3fpOAC+uBe7jk4sNGo/G8Wm5gx1C4WwvZIP/OdIUTJkwI
         /zhVRRx2tXuj+GJPQdOh7KJAVUIrc05FDfzkubQ31lqjo9vEcbvUPmY6fVU/DDB2pBvb
         jJdg==
X-Gm-Message-State: APt69E2pFy5UNCOsJExZ1ATZQw7ERvkJWU0t0O5roEv878gi1m+bSCcL
        oos4ArdbWI2cHDnbTjtGuY1Ecg==
X-Google-Smtp-Source: AAOMgpf88/t6O6mb8NKN2ZKqYKKamca7BuMKukSPiyvj2fDHA/Hm+iIxGPKXqrnNHqXubt0U+rAFCQ==
X-Received: by 2002:adf:ec02:: with SMTP id x2-v6mr9506754wrn.245.1530975340779;
        Sat, 07 Jul 2018 07:55:40 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:40 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/12] staging:rtl8192u: Move trailing conditional statement to the following line
Date:   Sat,  7 Jul 2018 15:55:10 +0100
Message-Id: <20180707145513.15325-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding standard requires that the conditional statement is not on the same
line as the 'if' or 'else' but on the following line. Statements moved
accordingly.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 6d62fc1b249c..7bc2e94792ca 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -622,7 +622,8 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 	int len = sizeof(struct ieee80211_authentication) + challengelen + ieee->tx_headroom;
 
 	skb = dev_alloc_skb(len);
-	if (!skb) return NULL;
+	if (!skb)
+		return NULL;
 
 	skb_reserve(skb, ieee->tx_headroom);
 	auth = skb_put(skb, sizeof(struct ieee80211_authentication));
@@ -680,7 +681,8 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	u8 *tmp_generic_ie_buf = NULL;
 	u8 tmp_generic_ie_len = 0;
 
-	if (rate_ex_len > 0) rate_ex_len += 2;
+	if (rate_ex_len > 0)
+		rate_ex_len += 2;
 
 	if (ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
 		atim_len = 4;
@@ -834,7 +836,8 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 
 	if (ieee->host_encrypt)
 		crypt = ieee->crypt[ieee->tx_keyidx];
-	else crypt = NULL;
+	else
+		crypt = NULL;
 
 	encrypt = crypt && crypt->ops;
 
@@ -843,8 +846,10 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 
 	assoc->status = 0;
 	assoc->aid = cpu_to_le16(ieee->assoc_id);
-	if (ieee->assoc_id == 0x2007) ieee->assoc_id = 0;
-	else ieee->assoc_id++;
+	if (ieee->assoc_id == 0x2007)
+		ieee->assoc_id = 0;
+	else
+		ieee->assoc_id++;
 
 	tag = skb_put(skb, rate_len);
 
@@ -1529,9 +1534,12 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 	}
 
 	//IEEE80211DMESG("Card MAC address is "MACSTR, MAC2STR(src));
-	if (ssidlen == 0) return 1;
+	if (ssidlen == 0)
+		return 1;
+
+	if (!ssid)
+		return 1; /* ssid not found in tagged param */
 
-	if (!ssid) return 1; /* ssid not found in tagged param */
 	return (!strncmp(ssid, ieee->current_network.ssid, ssidlen));
 }
 
@@ -2115,7 +2123,8 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 	struct rtl_80211_hdr_3addr  *header;
 
 	spin_lock_irqsave(&ieee->lock, flags);
-	if (!ieee->queue_stop) goto exit;
+	if (!ieee->queue_stop)
+		goto exit;
 
 	ieee->queue_stop = 0;
 
-- 
2.18.0

