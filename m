Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6EA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp9nFnbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6EA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbeGKL2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43979 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKL2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id u11-v6so18945589eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HaQ3cRoXKh8ZDwakHf9lDp8JFgI/yb+XWHrVGvhCrM=;
        b=mp9nFnbNyTub3wJ98KS9nE7TjSqrHQw+O3AR8EHEtpJnOlqMGdVuPonQnfyO4EaLYX
         A8Q1k+wTkxBXIsDtTCvD99pBTkUmeRWjGQkKDrpugTdqBPyzB3vQShe3SqzT2p3T8rzv
         vi/uEYfWB92cBQPgFo5fZOP3h1AegeCjj9PABoBBm7Zs+zpXspW+yEd7AClGnS0tpRtL
         4YGGuO1TCW9hQ9hp4Pm7wao+1zWTurv0bXa+FNFnlZHw/L0IOTsOjwamd43x01rDUqga
         fSNtQ7UPi1fkN4rc6IziqgCI/SzGg0gbxpPsnehub/eH1o0AHdbfRzD6aJWwjVJIEWzV
         ONrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HaQ3cRoXKh8ZDwakHf9lDp8JFgI/yb+XWHrVGvhCrM=;
        b=fasx2BqYsowWklKg3qIvrfXNpMF1ev4c8jXmElTLhXxCh8m5zMJ6qbfqc1z1DlU+bZ
         mc0XDyy6zHSjyuhemPAdqLsojemEvI9pX1TI10edjOTi9PsFK40QksamYRigguMrSMM5
         xxkVrjSni8ZMgJLDNuDP9Tb1wvJv3sm+GwHkIS8P+r9ExMEDZIVnWgctkTXGPzDSbDwK
         mdVuyMArhVD89SwSORJMVK9DAo/n/BveIHZCpXL94vg15nxnJc/rEQTzufQZNhzOp01e
         koUWqbJEzJAeeba6WP9dBoRjkFJssQIBRyRpsCLBR/X1TTXInfcfZMfKwLuosPLdsNdd
         zkyA==
X-Gm-Message-State: APt69E3IYL+blYmW4GIC/HlfKdVYdcAi3jZ3/gcPmFuJjUAbBoqEzAQk
        +6C8z+tk4hBmJk3D/Q3gM2pxgj+g+8o=
X-Google-Smtp-Source: AAOMgpfdxJ80WLW1KmB2dDGdJMA5ZoFqXgy5kahG0SwFzHyfSAlsHoxgbZKCLij2ts/vahyqqLPdEw==
X-Received: by 2002:a50:cb45:: with SMTP id h5-v6mr6108192edi.169.1531308269736;
        Wed, 11 Jul 2018 04:24:29 -0700 (PDT)
Received: from arch.localdomain (x4db0e292.dyn.telefonica.de. [77.176.226.146])
        by smtp.gmail.com with ESMTPSA id h1-v6sm8186346eds.68.2018.07.11.04.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:24:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8723bs: fix lines over 80 characters
Date:   Wed, 11 Jul 2018 13:23:27 +0200
Message-Id: <20180711112330.28020-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180711112330.28020-1-straube.linux@gmail.com>
References: <20180711112330.28020-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lines over 80 characters by adding appropriate line breaks.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7216466f89e2..234e741c87e8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -42,12 +42,15 @@ extern unsigned char WPA_TKIP_CIPHER[4];
 #define DISCONNECT_BY_CHK_BCN_FAIL_THRESHOLD 3
 
 static u8 rtw_basic_rate_cck[4] = {
-	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
-	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
+	IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK
 };
 
 static u8 rtw_basic_rate_ofdm[3] = {
-	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK, IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_6MB | IEEE80211_BASIC_RATE_MASK,
+	IEEE80211_OFDM_RATE_12MB | IEEE80211_BASIC_RATE_MASK,
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-- 
2.18.0

