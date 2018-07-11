Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7637C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967D420835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv9gQ5xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967D420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeGKL2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42877 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12-v6so18938282edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WtK074ibeTZZ8TcAOFWDyhFVi4FjEtyO9GHVw5t9kw4=;
        b=kv9gQ5xySLhrFtH9juT/qFNPBpcXw+eNCsDd6udjXyqtPaH0eJh9lCrDuG9iCTLMNq
         rDUOG0O+tW6YR7WmhIwIm7FubLH4AtiC9bvRL8WnOkVzjjPhalKvzzQvSF5LnxQIRJzx
         u0AUNYbRbptuIteQ1G0HyG7HNN5nxlnbRIvlmE8DRt+LAZOgVQZh9cxUfPlB2d1YA+65
         P+1/6sktYWZeEFHAa1W+bYdC7Gm7HcmToYqgGR03HLVsKrThrd+HVLE1CVIiB/wZAyTB
         TKQeJqML7V6EAp/JiSNG050Lcuv72jyZlx3rxJzQ1LGhOS7k/jO0J+Vr2hoItnkcgrzT
         DC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WtK074ibeTZZ8TcAOFWDyhFVi4FjEtyO9GHVw5t9kw4=;
        b=JnwwEWLWNndf9s53pVrG44maIg3hf0Olm2OkLajfE+QzRuDaftzRjgT2vzFqVDwUeC
         /4bNKRUoss6GUUr6k3dwJdX8nYsKSNkCaRTMlQJ1ADQaFeaJ6+eiEa1KWZZMEQXRf6kQ
         lC0k16EnI+8Ly2UfcU48xaa2hjoCQFhl8Fa+io/sHLTB1HwgfHspXIef9P9nMAN8mTMt
         qRX4i9wWm6toM2HKh3HTDluWUewr+AziTSsbtS2Egwa+Yqatn9yyIsIaYtQeXqnjJ/dm
         zzSyxIONmrf1BzpU871jzyy8sBZoABhFFFrr1g7vaS3ntTSszPvZUwrTVgMla17tmtbB
         K6kA==
X-Gm-Message-State: APt69E1EyIPNsg+wT9CyZeg6ATVexmouV8SCF8oeDHcgl5EHnyuFX1J/
        RZKsV3EbGMXyy6PxdfSGyWtTYiCbAps=
X-Google-Smtp-Source: AAOMgpdVywSGw5Ji6K2rSCbnts73rUwstxt0C7WSWrd+m4SZ0mgKfwII1zoYoUK3g46+R+vEb8moJw==
X-Received: by 2002:a50:a392:: with SMTP id s18-v6mr31706598edb.271.1531308267956;
        Wed, 11 Jul 2018 04:24:27 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id h1-v6sm8186346eds.68.2018.07.11.04.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:24:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8723bs: add spaces around '|'
Date:   Wed, 11 Jul 2018 13:23:26 +0200
Message-Id: <20180711112330.28020-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '|' to follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2b3eb6f8ddc5..7216466f89e2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -42,13 +42,13 @@ extern unsigned char WPA_TKIP_CIPHER[4];
 #define DISCONNECT_BY_CHK_BCN_FAIL_THRESHOLD 3
 
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
 
 int cckrates_included(unsigned char *rate, int ratelen)
-- 
2.18.0

