Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15321A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjpkgNj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD15321A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeHHXWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45394 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so1873158edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fHmMz6xQpBCRfn3/gMvZnhyvcv1ZxV7Wh/CxeVhf/co=;
        b=XjpkgNj7ziigDVM8gto7B/9Y/5V61+L+VgyJMpdpk0cblXwugxRF/jEdR3vDneHDGo
         2IDHkIk8W1XhiLE3EMVsXAads6hSTM5dP7irOnIbYOZVISIwcmu28gakAoG0XKGvTh2H
         UqB1h+Sx4/6w9Gg+tYctpTxhGzfMtx2cuoKvAfporT7yic4jmEbptO+XQxktREnEnBI4
         4tTK8MveAMjX+NUNSSRmHeIQ91PNZkFp7yRLqIfY+twvIDgm+BsBYkms1Dtm3x6uucYO
         Tx+dZYzXkC+lX7A6+c/jQUhTMvq9/r8SRvHOnaTLQFxj7HxiGNX2N5tndd0UsxsJUk3w
         iObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fHmMz6xQpBCRfn3/gMvZnhyvcv1ZxV7Wh/CxeVhf/co=;
        b=gdZ62Wo3cAdQjerl7Smf7Ef0dCfHVw8nN3vf0nw5DpsKoglnIJqN66d/M0kTBYRcSH
         edHKqk9L/zfrWtS5TrXUzOKccUxqDbyDaLIBZTIjnTw9XVbsoSiudkga1PtdJSbtx/af
         WxmgsFsSkNCXgATPy7ATCydeeFmr/r4lC39lP4usbuJI3YTsGjKFZJvQt9jjDNBZynWd
         OCXAB2B3n8ujCCCDjMqiNfZun2XF9sd7QfkIHrjosJW4S2GnNgxzb5fZB9u25o1aTOBi
         Q8AD9JWUGxjd52m9k8HxnLWW/pZm4goitqIIGQqnAXb4q2erHqygYuF0EGQYEPfVe8y1
         877A==
X-Gm-Message-State: AOUpUlGNFLa08m1gloAIxAa3M9a6AKOP2JNHcJDRM6Zr/gzCbqmSa4Qe
        P/LdkuP1vXRdq9URhevk+FgSV9XtR2c=
X-Google-Smtp-Source: AA+uWPxD32/K4gaUCFFEj3MEf2YBjJaLoRVaPi39+z8RK7vhddhofF09jezIG60lM+z+I2OvOGt8Hg==
X-Received: by 2002:aa7:c4cf:: with SMTP id p15-v6mr5135863edr.240.1533762057321;
        Wed, 08 Aug 2018 14:00:57 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:00:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 01/15] staging:rtl8192u: Remove macro eqMacAddr - Style
Date:   Wed,  8 Aug 2018 22:00:22 +0100
Message-Id: <20180808210036.22580-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro eqMacAddr implements the same functionality as the
ether_addr_equal function defined in etherdevice.h, as a result the
macro has been removed from the code, and its use replaced with the
function call.

Note that to use the ether_addr_equal function the data array
containing the MAC Address has to be u16 aligned. Because of this the
struct rt_dot11d_info has had it's member variables re-ordered.

This is a coding style change which should have no impact on runtime
code execution.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 12 +++++-------
 drivers/staging/rtl8192u/r8192U_core.c      |  6 +++---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 363a6bed18dd..3bfd7efe05a0 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -17,22 +17,20 @@ enum dot11d_state {
 };
 
 struct rt_dot11d_info {
-	bool enabled; /* dot11MultiDomainCapabilityEnabled */
-
 	u16 country_ie_len; /* > 0 if country_ie_buf[] contains valid country information element. */
-	u8  country_ie_buf[MAX_IE_LEN];
+
+	/*  country_ie_src_addr u16 aligned for comparison and copy */
 	u8  country_ie_src_addr[6]; /* Source AP of the country IE. */
+	u8  country_ie_buf[MAX_IE_LEN];
 	u8  country_ie_watchdog;
 
 	u8  channel_map[MAX_CHANNEL_NUMBER + 1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
 	u8  max_tx_pwr_dbm_list[MAX_CHANNEL_NUMBER + 1];
 
 	enum dot11d_state state;
+	bool enabled; /* dot11MultiDomainCapabilityEnabled */
 };
 
-#define eqMacAddr(a, b)		(((a)[0] == (b)[0] &&		    \
-	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
-	(a)[4] == (b)[4] && (a)[5] == (b)[5]) ? 1 : 0)
 #define cpMacAddr(des, src)	      ((des)[0] = (src)[0], \
 	(des)[1] = (src)[1], (des)[2] = (src)[2], \
 	(des)[3] = (src)[3], (des)[4] = (src)[4], \
@@ -42,7 +40,7 @@ struct rt_dot11d_info {
 #define IS_DOT11D_ENABLE(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->enabled)
 #define IS_COUNTRY_IE_VALID(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_len > 0)
 
-#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) eqMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
+#define IS_EQUAL_CIE_SRC(__pIeeeDev, __pTa) ether_addr_equal(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 #define UPDATE_CIE_SRC(__pIeeeDev, __pTa) cpMacAddr(GET_DOT11D_INFO(__pIeeeDev)->country_ie_src_addr, __pTa)
 
 #define GET_CIE_WATCHDOG(__pIeeeDev) (GET_DOT11D_INFO(__pIeeeDev)->country_ie_watchdog)
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index e218b5c20642..b2be09fcd43b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4460,15 +4460,15 @@ static void TranslateRxSignalStuff819xUsb(struct sk_buff *skb,
 
 	/* Check if the received packet is acceptable. */
 	bpacket_match_bssid = (type != IEEE80211_FTYPE_CTL) &&
-			       (eqMacAddr(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
+			       (ether_addr_equal(priv->ieee80211->current_network.bssid,  (fc & IEEE80211_FCTL_TODS) ? hdr->addr1 : (fc & IEEE80211_FCTL_FROMDS) ? hdr->addr2 : hdr->addr3))
 			       && (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV);
 	bpacket_toself =  bpacket_match_bssid &
-			  (eqMacAddr(praddr, priv->ieee80211->dev->dev_addr));
+			  (ether_addr_equal(praddr, priv->ieee80211->dev->dev_addr));
 
 	if (WLAN_FC_GET_FRAMETYPE(fc) == IEEE80211_STYPE_BEACON)
 		bPacketBeacon = true;
 	if (WLAN_FC_GET_FRAMETYPE(fc) == IEEE80211_STYPE_BLOCKACK) {
-		if ((eqMacAddr(praddr, dev->dev_addr)))
+		if ((ether_addr_equal(praddr, dev->dev_addr)))
 			bToSelfBA = true;
 	}
 
-- 
2.18.0

