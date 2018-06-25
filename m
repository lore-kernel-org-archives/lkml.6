Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2093124CB5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPnXm1ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2093124CB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964799AbeFYPOS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:14:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37025 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934867AbeFYPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:07 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6-v6so14073319wrp.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QCB2jOEyla75iCTIJg5GkES40Ud8smj1zIgzC1TXi/8=;
        b=vPnXm1adVuXQdQGuJy2kEXq8jp3DEY1fdf1JHZrl1E3M33Ji9uDeK8scVeNzaN1HOo
         w4Yy3hyMgxbGvG9BzvQlj3UaYZ/9pivCF8cIuiweD3WGLGmEAw2iFxRpnYOU/DMKnKRb
         2Q5KyUmS6fuLKoJytTPRp90Nvv56OvUJ44fKNueLSJFgJWvJ/SOjaKxMaOSslNdrrseY
         jemLUD3aw3aXmzs4mEVo+uNNOeiDIcKRq0JBXKu5cLrwT7wMbiOPhubzoT0r7eqHHGKq
         Fdj383SOsKMNxBZxtWQHjlVrHdS8sKYRGkpGKX3HTAJcSIaVBcX0DPMx+aUU+ZZ1yD5G
         dDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QCB2jOEyla75iCTIJg5GkES40Ud8smj1zIgzC1TXi/8=;
        b=OlIkP2j7Pd4c2UCH/cYD7MBBWLog4vql7XMxFxlS8VP4Nw+dPmZE8Vbzb+7/b1JNP1
         Y8XDTzNCzcHbZEjtoCTD4ad/VltY+cssV845ga+dc6Vizp+BEiS1UvjVSOhvLrbK4+AX
         HRSw8i6ChUZLE/zE0/ASMQg7Io8CzUnCcs2tOfRTCNDAzgiBPPrxWV5tz8fcWe2ll2lI
         YX5VW2XN/A6PQ25m9p0eh4hkbcC7XnFjEbWFfSnLYc6trciLQLgd8WLeaYvZJkFnlhAA
         CNNSMSGcGVVI5UMmZ1ch/sMvI8pTAquf0IBiP2hKUb53KwMpNrno5oaz+M3tEjnOPKKG
         xX5Q==
X-Gm-Message-State: APt69E2WY+n/tYPe0in4qfiYJQ3xUgVU8iqhJhj2pT8m5CKbOtgeNaIS
        9dAvfzPtzzKUPvm+Qv5jhTY=
X-Google-Smtp-Source: AAOMgpcMGgEMrTS0IlARhqfaso2w29BNtxlMZErIy1kTlLmFSrrtr1Ok/RcS8NoAgdHsAj7AVuMAuQ==
X-Received: by 2002:adf:a14a:: with SMTP id r10-v6mr10190053wrr.104.1529939585883;
        Mon, 25 Jun 2018 08:13:05 -0700 (PDT)
Received: from arch.localdomain (x590e3931.dyn.telefonica.de. [89.14.57.49])
        by smtp.gmail.com with ESMTPSA id l78-v6sm15368283wmb.39.2018.06.25.08.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:13:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/4] staging: rtl8723bs: refactor rtw_macaddr_cfg()
Date:   Mon, 25 Jun 2018 17:12:36 +0200
Message-Id: <20180625151238.23147-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625151238.23147-1-straube.linux@gmail.com>
References: <20180625151238.23147-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
testing each byte of the mac[] array for 0xff and 0x00 shortens the
code and improves readability.

If np == NULL, of_get_property() returns NULL, hence the "np" check
is not needed.

Instead of a fixed default mac address use a random one to reduce the
likelihood of mac address collision.

Thanks to Joe Perches and Dan Carpenter.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e55895632921..7aa00d1391f7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1177,24 +1177,13 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
-	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
-		if (np &&
-		    (addr = of_get_property(np, "local-mac-address", &len)) &&
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
 		    len == ETH_ALEN) {
 			memcpy(mac_addr, addr, ETH_ALEN);
 		} else {
-			mac[0] = 0x00;
-			mac[1] = 0xe0;
-			mac[2] = 0x4c;
-			mac[3] = 0x87;
-			mac[4] = 0x00;
-			mac[5] = 0x00;
-			/*  use default mac addresss */
-			memcpy(mac_addr, mac, ETH_ALEN);
-			DBG_871X("MAC Address from efuse error, assign default one !!!\n");
+			eth_random_addr(mac_addr);
+			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
 		}
 	}
 
-- 
2.18.0

