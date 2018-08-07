Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE2C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA1D21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuoouudL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA1D21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeHGX30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55526 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeHGX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so499911wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZjCgMN7qy9tvzdksivWG7XH/xQQGheDUiUQWZrIokg=;
        b=SuoouudLIEHCaY4oM+f47dkX4/g2OtY1Tr8yApaJ0yUP2ESUrQANoDcL/2YN9t9mPL
         tw8aVllxkhGwwF2oNMj9IEU8Vg0BD57mhGksXyaLowIugmcQe5XDbUQPD1+lN3KyFdSj
         iYcVG5iHkMm1zKr8muwd9CYtpmpgQ/qRd38qo8MaKaQcLLfMyptEhVuwT9T+lTN54D0L
         qx5cK6rl/3SjIwwEBmAXj4R9QW3WcWCuAPQhp0kdX1vmrBfZP7/Ln4cRgXRTv8RDaKSP
         Q8oyYdZIFHiIZxvD7RILXxIoc+O6a5ZHbwRDXOumvER7t98gFXNkwiE5jAoV76vUdVl5
         eFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HZjCgMN7qy9tvzdksivWG7XH/xQQGheDUiUQWZrIokg=;
        b=cxWR6GA3OAh0f6lkwF9Krj/X+IARtX0ozeDx/XR2LRCD7Y/Z2l8ea7dHz1OXd6NHmJ
         +KYUcSRLmVnRvYuLvrLEfzbRSe+sRV3BX1vTxlol7+yfcTNO6OB4k+xj9lSaCRnTJaOW
         jNW2clqkNsj9TBh7hq7eII3JJzqMov8ZcbJ6oVrCmYcrk3V0drtP9u3oHrWg5y/Nz9YC
         WSPIgbEjCl55O9/kjbKlZ2VQ/0bq44A+DqXjpB2MRagakn+gMNixFOtn8r+JiorjyKaL
         aRcdUFbu8BnBrRgKFug8iLLW/WrefvNTM8mW6dOpb4fYTSDNi7lxipYaDQWr0yjh91hh
         0gVQ==
X-Gm-Message-State: AOUpUlHac1FCENOxMUOhsLKN6wb+bnTM9DixJGB1EfbHqBxi2hUK8MCJ
        iQ5wZk75dYu57H7J2kTW7/fWE87D
X-Google-Smtp-Source: AA+uWPxMNzGsjV7ExNJtGnHHBEGfyHCLLGPE8jl/+5aHbA2NfMKRCqpASL+V7h78pFw6Qt5qNp7fmA==
X-Received: by 2002:a1c:ca0f:: with SMTP id a15-v6mr51356wmg.102.1533676386144;
        Tue, 07 Aug 2018 14:13:06 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/17] staging:rtl8192u: Rename eqMacAddr macro - Style
Date:   Tue,  7 Aug 2018 22:12:42 +0100
Message-Id: <20180807211255.29343-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eqMacAddr(a, b) macro causes a checkpatch issue, due to CamelCase
naming, so has been renamed to eq_mac_addr(a, b).

This is a coding style change which should not impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 4 ++--
 drivers/staging/rtl8192u/r8192U_core.c      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 363a6bed18dd..81a0bb20f662 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -30,7 +30,7 @@ struct rt_dot11d_info {
 	enum dot11d_state state;
 };
 
-#define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
+#define eq_mac_addr(a, b)		(((a)[0] == (b)[0] &&		    \
 	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
 	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)
 #define cpMacAddr(des, src)	      ((des)[0] = (src)[0], \
@@ -42,7 +42,7 @@ struct rt_dot11d_info {
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eq_mac_addr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 #define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
 #define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index e218b5c20642..b7b4694c1f27 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4460,15 +4460,15 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
 
 	/* Check if the received packet is acceptable. */
 	bpacket_match_bssid = (type != IEEE80211_FTYPE_CTL) &&
-			       (eqMacAddr(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
+			       (eq_mac_addr(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
 			       && (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV);
 	bpacket_toself =  bpacket_match_bssid &
-			  (eqMacAddr(praddr, priv->ieee80211->dev->dev_addr));
+			  (eq_mac_addr(praddr, priv->ieee80211->dev->dev_addr));
 
 	if (WLAN_FC_GET_FRAMETYPE(fc) == IEEE80211_STYPE_BEACON)
 		bPacketBeacon = true;
 	if (WLAN_FC_GET_FRAMETYPE(fc) == IEEE80211_STYPE_BLOCKACK) {
-		if ((eqMacAddr(praddr, dev->dev_addr)))
+		if ((eq_mac_addr(praddr, dev->dev_addr)))
 			bToSelfBA = true;
 	}
 
-- 
2.18.0

