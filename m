Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DEAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7350208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZaLKXnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7350208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbeGKMbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:31:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46148 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:31:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so19076313edo.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VegiRQ4J6BezZekVEfFYaAnBem24r3T65Na7X81LiEs=;
        b=TZaLKXnxIb6me6FG4bhnlW40iy/KQLfNi8m+dmOZAVH2QVciB3lRdZGfNF2eFdvHim
         NI/AMGoJN2AbzeRrfUBZttO9Kjcp8FQ87rG9UfOW37c4O+32dFOuI6uEyX6+emDYycOF
         HH7d7dl3MqARVz1jm8UkcXNwcHkzCrmIYUlwrg+jHtDAzEz6mSMbejraECXY3fq5TeqM
         ekH/C011g/B21je04KjYiVJ1+OcfI3kf41qRQkN3qr9rSnUeBb1mvjTTmhm1glRqfurJ
         LaetRttqcc3FK5PEBpi+ics875n845sQGQshdQPQGHpifoUfPtfdo2d2HM4u+6DdasUe
         Nxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VegiRQ4J6BezZekVEfFYaAnBem24r3T65Na7X81LiEs=;
        b=IppAUGg9eP9eJD6VIMc1V78/xcsI3sJO8s/vyLpB7lkyG/9l5Ak2UlaYh5qthg4qcJ
         hk2Gs0Cq0Gg889lHVkkfJ507OiUi2DUJpe9RcWvXeFX+IHV6JVRYheBD9u64vi/gmAV/
         ks/9UHbcQmyVtaZyVrYG7yvS13ut2ut1VHXuEUros0+CYs3FfRloyGIY9M2f9d7VDtA/
         DUGwmAp+/II8pkjWOa8YUmsnJsH82UToFC2sRway5JoBskFcqyFaWlzlnRJ6ztwlXsaL
         EjLCZAuWPgOB1tEQ72AEYZdeg5ovpqeim7A6ss5gj3M56b2YAIpdKu2g6NV9LctMbTL0
         +PPw==
X-Gm-Message-State: APt69E0H/4tyFf/CYJqoHbvKBFs0cNdBoVl/A3JqaHFqp8LofN3vF0Zv
        Tv8rogzNgyftJxAPK3yrWTs=
X-Google-Smtp-Source: AAOMgpddpvcpy8Rg56GCBTrOnXPrRs0z8UvViwpgeysRJVyDxmN+hmKeIM2Ef8xmT5IOlQX7/wNUeQ==
X-Received: by 2002:a50:f501:: with SMTP id t1-v6mr31973937edm.199.1531312055311;
        Wed, 11 Jul 2018 05:27:35 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id i12-v6sm11855623edf.26.2018.07.11.05.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:27:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: add spaces around '|'
Date:   Wed, 11 Jul 2018 14:27:13 +0200
Message-Id: <20180711122715.22234-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '|' to follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 93d8fa66be7a..54a48ccfcb0d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -34,20 +34,20 @@ unsigned char REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 #define WAIT_FOR_BCN_TO_MAX	(20000)
 
 static u8 rtw_basic_rate_cck[4] = {
-	IEEE80211_CCK_RATE_1MB|IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB|IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_CCK_RATE_5MB|IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB|IEEE80211_BASIC_RATE_MASK
+	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
 };
 
 static u8 rtw_basic_rate_ofdm[3] = {
-	IEEE80211_OFDM_RATE_6MB|IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB|IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_OFDM_RATE_24MB|IEEE80211_BASIC_RATE_MASK
+	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
 static u8 rtw_basic_rate_mix[7] = {
-	IEEE80211_CCK_RATE_1MB|IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB|IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_CCK_RATE_5MB|IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB|IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_OFDM_RATE_6MB|IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB|IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_OFDM_RATE_24MB|IEEE80211_BASIC_RATE_MASK
+	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
 int cckrates_included(unsigned char *rate, int ratelen)
-- 
2.18.0

