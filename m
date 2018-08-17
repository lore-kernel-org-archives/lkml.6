Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1692187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in1x4gOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1692187B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeHQVj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37861 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbeHQVj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so8149152wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BS7CyxeBtouHKMExciTczrhjjY4e4nTh2O0XQB8pl4g=;
        b=in1x4gOXcPDZchDTDbKn3JZor7wWPvo9gKB4OPwXoa/LQdPqNSzhVn6tEwZDeJTNHT
         EhufsvxpsgjW5+AGYY/ck8F6I9S3/S7ft73JfPCiGamEWpxZoLUBHOrJ1+Hv+h0RSlHM
         96nd4ex3b+Vbj+CSi+m/pcx1redQFQ5YLDYQc0yxJny/yyj4PGvz3+GzdBk0tJkzxV+1
         6dA8YFRiEkfBQ0ZTXnEAdLMaDfy4XK/aA7DBWt1zXP0y1vUiet34Ytk/Ro2+yzZJSDCt
         0b2yanfabPhnQlujCiFyC/rsCU8CYDZdgp/t7nUyV9Ilg+z0okfj77bHKUDQDXWWw8Au
         nl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BS7CyxeBtouHKMExciTczrhjjY4e4nTh2O0XQB8pl4g=;
        b=b+BJdv0IU04VuXvTwD5z0ky54zm/3lW3s2oN3+V+CT7dMjx1jfBfJHx9fqpjrvURtw
         Q5H3F5nATqEu1yEY78rLSOJJK7FRxOt71u1sGcrWtmNR7f3y6Z+zQGpLn8b07HFX6F15
         fUz8jwKp0eVtG75AJctvwyAuztHN/BZV12vXXv72NRh3H0gNU73e2tz+0JbxQyIPe86D
         xB6Kz81EPlrdZrPy6tJNQAw3vwh8ZiIw8qF36zUFQhPe/yyrM5rLgZQQDEFZ/ho0BKgC
         TgzIeYUhDGxGI7VDquLrxSUBSQ6XtvHS5znNTYuCrUxlPA+Z/Fsn5zqjxOEfP3qHrwpP
         rAEg==
X-Gm-Message-State: AOUpUlEvw82gUcK70B5OKMVtE+VKdv2R01SdX56cY6JG2mBygf6vBVHj
        8E9nuizdyNmzhPCk2Wb1coKKbk0koUc=
X-Google-Smtp-Source: AA+uWPzgCqwuGkDVQybsaZUe+cvWYLo49244uY9NFVLyNNrHBPMQsPgvQkGoGeBzCNCR+SpKRBbC2w==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr20410638wmc.27.1534530900812;
        Fri, 17 Aug 2018 11:35:00 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/10] staging:rtl8192u: Add required spaces - Style
Date:   Fri, 17 Aug 2018 19:34:41 +0100
Message-Id: <20180817183447.15993-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces required by coding style to clear checkpatch issues.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 69cb5884bbc4..da71f745f039 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -20,7 +20,7 @@
 
 #define HT_SUPPORTED_MCS_1SS_BITMAP					0x000000ff
 #define HT_SUPPORTED_MCS_2SS_BITMAP					0x0000ff00
-#define HT_SUPPORTED_MCS_1SS_2SS_BITMAP			HT_MCS_1SS_BITMAP|HT_MCS_1SS_2SS_BITMAP
+#define HT_SUPPORTED_MCS_1SS_2SS_BITMAP			HT_MCS_1SS_BITMAP | HT_MCS_1SS_2SS_BITMAP
 
 //
 // Represent Channel Width in HT Capabilities
@@ -300,13 +300,13 @@ extern u8 MCS_FILTER_1SS[16];
    STA in A/B/G mode and AP is still in N mode. The macro will be wrong. We have
    to add a macro to judge wireless mode. */
 #define PICK_RATE(_nLegacyRate, _nMcsRate)	\
-		(_nMcsRate==0)?(_nLegacyRate&0x7f):(_nMcsRate)
+		(_nMcsRate == 0) ? (_nLegacyRate & 0x7f) : (_nMcsRate)
 /* 2007/07/12 MH We only define legacy and HT wireless mode now. */
 #define	LEGACY_WIRELESS_MODE	IEEE_MODE_MASK
 
 #define CURRENT_RATE(WirelessMode, LegacyRate, HTRate)	\
-					((WirelessMode & (LEGACY_WIRELESS_MODE))!=0)?\
-						(LegacyRate):\
+					((WirelessMode & (LEGACY_WIRELESS_MODE)) != 0) ?\
+						(LegacyRate) :\
 						(PICK_RATE(LegacyRate, HTRate))
 
 // MCS Bw 40 {1~7, 12~15,32}
@@ -314,7 +314,7 @@ extern u8 MCS_FILTER_1SS[16];
 #define	RATE_ADPT_2SS_MASK		0xF0 //Skip MCS8~11 because mcs7 > mcs6, 9, 10, 11. 2007.01.16 by Emily
 #define	RATE_ADPT_MCS32_MASK		0x01
 
-#define		IS_11N_MCS_RATE(rate)		(rate&0x80)
+#define		IS_11N_MCS_RATE(rate)		(rate & 0x80)
 
 typedef enum _HT_AGGRE_SIZE {
 	HT_AGG_SIZE_8K = 0,
@@ -331,7 +331,7 @@ typedef enum _HT_IOT_PEER
 	HT_IOT_PEER_BROADCOM = 2,
 	HT_IOT_PEER_RALINK = 3,
 	HT_IOT_PEER_ATHEROS = 4,
-	HT_IOT_PEER_CISCO= 5,
+	HT_IOT_PEER_CISCO = 5,
 	HT_IOT_PEER_MAX = 6
 }HT_IOT_PEER_E, *PHTIOT_PEER_E;
 
-- 
2.18.0

