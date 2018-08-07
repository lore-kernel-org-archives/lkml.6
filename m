Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DDB21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO1/nIMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DDB21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeHGX3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34615 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeHGX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so89397wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KT9LnYC4m3+xAF67ggHCUVuujMFJxHTVsdopb5BanXE=;
        b=aO1/nIMNOfZkbzJR2l9NuaF/I58mQbGHzJn8+lilSy4qCea1n7d2xbn5Ux+xngp++F
         hLwzglWThHhDuoob0c/jp+d+u6Wlb/PFWUYUzz96thvOd6liJR//U5sJ0gAIZtvG9+B4
         gBzyJrQNBVaHOLIkAMNNxRHSjdeuwKTUkbNzG6Sfoeik4VlT/bv2JcdwbYD8AoeHP9jM
         cK/Nw/bh3oP9yA2pVGpwuwzPlzQt8y8qiWXfK6h1jtFH+U9Y+C7nc6bJ5CHmuLxtpyJS
         EzQSEqwvbUcbNB8JnCE/CszLaQDI3CO2UOhfOVXz7zZk+m2j8mabtX8gZCdPmTCySq9c
         ZEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KT9LnYC4m3+xAF67ggHCUVuujMFJxHTVsdopb5BanXE=;
        b=oRcFXKcHFu0fFZax1YGXt7BcTg233Yrjf48ITmJdKAqV6M1M5kS0ktfpfDEgZhxqK7
         SGVzPOCl9Nq0c5dKU81nAjr3J1S8VmVRAD/dFovW8jjISa9jjXqlAMKWl2iqhB/YHM+B
         cCo8hwollHsmkK1UUHVYMRZDoNWpJkaPCpWTeo4DGBtmbY5Q0HSVk+2EWgg6MTbbgllO
         IYr7XJMIw8YkqxBeEdk3v0gQWMVwr552Kn3UJC8WLffKe49QfxjnCnyWqBFfxvAGDAan
         u86ut0Fv/MvpKRt4g+MaKtsGTxCzOIPHekWubseGKMjyyULrZTHNAgojscMaAbzLRWFG
         gmHA==
X-Gm-Message-State: AOUpUlEzEBekxvW+sT6us/fbZJFIV/Wh/joDUmjU2oqxjxk+/eR2AJnk
        x4qtB+/ShK5becNqcCQBtFBu81oj
X-Google-Smtp-Source: AA+uWPyg3wyqNlPrZQ/ui1pnOm7sNMX5pzybvUNmlnX43oL7PKANKi8YIY0PRX+6SBYuD19QdqA/hw==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr32781wrn.245.1533676392149;
        Tue, 07 Aug 2018 14:13:12 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/17] staging:rtl8192u: Lines should not end with a '(' - Style
Date:   Tue,  7 Aug 2018 22:12:46 +0100
Message-Id: <20180807211255.29343-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of function prototypes cause a checkpatch issue - "Lines
should not end with a '(' ". This issue has been cleared by moving
function prototype parameters to the same line as the function name.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 47 +++++----------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 72fc04e08b34..cb6d6ce440be 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -49,42 +49,15 @@ struct rt_dot11d_info {
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
-void
-Dot11d_Init(
-	struct ieee80211_device *dev
-	);
+void Dot11d_Init(struct ieee80211_device *dev);
+void Dot11d_Reset(struct ieee80211_device *dev);
+void Dot11d_UpdateCountryIe(struct ieee80211_device *dev,
+			    u8 *pTaddr,
+			    u16 CoutryIeLen,
+			    u8 *pCoutryIe);
+u8 DOT11D_GetMaxTxPwrInDbm(struct ieee80211_device *dev, u8 Channel);
+void DOT11D_ScanComplete(struct ieee80211_device *dev);
+int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
+int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
 
-void
-Dot11d_Reset(
-	struct ieee80211_device *dev
-	);
-
-void
-Dot11d_UpdateCountryIe(
-	struct ieee80211_device *dev,
-	u8 *pTaddr,
-	u16 CoutryIeLen,
-	u8 *pCoutryIe
-	);
-
-u8
-DOT11D_GetMaxTxPwrInDbm(
-	struct ieee80211_device *dev,
-	u8 Channel
-	);
-
-void
-DOT11D_ScanComplete(
-	struct ieee80211_device *dev
-	);
-
-int IsLegalChannel(
-	struct ieee80211_device *dev,
-	u8 channel
-);
-
-int ToLegalChannel(
-	struct ieee80211_device *dev,
-	u8 channel
-);
 #endif /* #ifndef __INC_DOT11D_H */
-- 
2.18.0

