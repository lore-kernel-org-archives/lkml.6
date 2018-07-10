Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A20C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7046208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGWfqeVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7046208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934140AbeGJPGD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:06:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37362 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933966AbeGJPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:06:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so16824939edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmEYkUt/aTszb6TVSaH7/FQOuxA+hAJERHnNstNtayQ=;
        b=UGWfqeVhE2O1P6v3/QKHhG7GZSGs/xcvgXrg5KWXKqSx4AQZGNO/EyJgLNnoxMxqqa
         1RVCBmlZBvYL+KlhtHDRlZCEv2eY0jAeSnHOuAR9Z4+9ktTd562wRzM428WK87C1LGz7
         bsEMW2LojkeSZ/7Sa2AARP50ZrgMWJkexgA9TR5VEYFwI9RQrJLPOFKPHIb/GWLX04Or
         Kd3EqQPO3uVhZLIi3+gJVEzqw8TLKDN7RZp36zLTAf9tOV1jZCxMfc6TxcbtZntIVfKg
         yqtRrfTOjxghpw1PHJfX9SkAV0XPKLH+Lq6bnoR0aNOYUxVKcECk2ZIbJTl6+l3DpANY
         cGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmEYkUt/aTszb6TVSaH7/FQOuxA+hAJERHnNstNtayQ=;
        b=qBr6NMWnMdG+iAkO6kzOinywb62X1FIFPhfv2KfGSWVypEfa1CgIHCESwRk1UoPQzM
         zP5JUXuUTf987Xw9B2NeCfTJBME3QMZolAEBKLZJtUQn1fnlHpWRPR7dIJPTmnHBz3Vx
         pXWDg4Fvs4644EcQv5cSlfbUYOGc9JSS40U4FgKFsnkXMg7Vj/rsmGJcn6IvWKNCYGEs
         4yuDnIDLyKR0JKAAS7wXFZ2tqDOKcd3WtwyBgIcIu+bFQWpDmieb/DHUmEq5cx6GStre
         /4ud+XQ1FCQJHPaOtCLr3PsXWl+1FkUO/lVb+4AwBhLd2Q+UbD6uj7Ot0ixdwo+oUfRs
         Jgyg==
X-Gm-Message-State: APt69E1xv7YT8JGuEpcvJiOJSAsh03hCEX1OQNcFqk/1FmCgtm17kyGb
        PVnGHgdx/q6XTwQeyRply5Ze9Kvv
X-Google-Smtp-Source: AAOMgpeKyr4Y27I9lNOlahomCvhm04v2n5hIkyFwJq6ek/1SiYlcRdGgnZRUwCGbFg9tTPDf/001gw==
X-Received: by 2002:a50:c2d9:: with SMTP id u25-v6mr27969370edf.56.1531235158589;
        Tue, 10 Jul 2018 08:05:58 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:05:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 5/8] staging:rtl8192u: Move trailing conditional statement to the following line
Date:   Tue, 10 Jul 2018 16:05:20 +0100
Message-Id: <20180710150523.17384-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710150523.17384-1-johnfwhitmore@gmail.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
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
index 64d7980e7e13..d916cc5b97db 100644
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

