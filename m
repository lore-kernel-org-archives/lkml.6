Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C629521523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMfpamZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C629521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJTTSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:18:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34177 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeJTTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:18:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so33665642eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXsJo56Gh2j8BuZNMP4gnM+V0kIp0Gm+16R/i2FpjLI=;
        b=EMfpamZ0nzZ0KOHJkISG+XOyUZsqQUU6+fcky8rqzG7jRHD/6adRIc2cpr4z9fXvIo
         tWCIB0rcE34nB7bncZK4F0o1GpVP9YOVIjcKw7vTYuem/QJZol4lUAqZvZ8I6G8ExVHR
         nDtC6ZhS+SuiDIz1aE2sbUsaTY1kl22X8nk6VEctBlta1q5d31N8ERxbCtjc+CYGZeGX
         tVvF3wQkKcXp8sn8jVYmM449pR1A2GBylW9rbzPkuKPEkGvtmdh/4JT8OJ60kHmBKClC
         JyP3j4YCTQAsfXLB924xPWh5X1lRs+L21J4OMksKcVpYSkbCsUJDjPzlGhXUCsJ/3sSP
         j9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXsJo56Gh2j8BuZNMP4gnM+V0kIp0Gm+16R/i2FpjLI=;
        b=fZ1s+OD5UJkw58+MxCqH91RFzLbFK+W4Gybl8NCW5sSZeBOwG6yJdOjSc3MR7kkrvO
         UP1XXQDvHKAqrJ4eZwMjjXF2oDsEhp8d7SZBPBVE/tVXy0lEVhvaP6lPI1RCjYVnCTA9
         dy60pzddMjc4lNKXL81k1Mz4kO2PU3DMbhZXxcMCrOUdAp/MECnqzG/oY0DuLbCswmWg
         A3IjbQKvYQsP65a5GJqi99h+m+St59Mey5Qlz2HO9lnxoJG1fhTRqMl94cSngq5YxN/2
         YQsRAn2V26CTWWejfdNZtPzUNLuAsMvKaiFx3hfLie5jadsE1zpH40GtsbdkjCRrqCHg
         5pXw==
X-Gm-Message-State: ABuFfog25b79+BYU47TsbGdKgzXaSp8Us2SE4ZKzLh3C6XWA7s5sytS3
        ekyaG2v2AEgy49aWcPHFm1E=
X-Google-Smtp-Source: ACcGV60jrTaMBCbJomCgRSMzbFVlefFeAJhHvQs9qb3j4Qmg/5rKDBdPKHSuwcuPFrhcJ5zF3DAWHQ==
X-Received: by 2002:aa7:d442:: with SMTP id q2-v6mr8684695edr.26.1540033711312;
        Sat, 20 Oct 2018 04:08:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id r23-v6sm11418422eda.44.2018.10.20.04.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 04:08:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: simplify odm_evm_db_to_percentage()
Date:   Sat, 20 Oct 2018 13:08:17 +0200
Message-Id: <20181020110819.1576-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clamp() to simplify code in odm_evm_db_to_percentage().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 82d6b2e18b29..0c034b19d3dd 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -53,20 +53,11 @@ static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 currsig)
 static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
-	s8 ret_val;
-
-	ret_val = value;
-
-	if (ret_val >= 0)
-		ret_val = 0;
-	if (ret_val <= -33)
-		ret_val = -33;
-
-	ret_val = 0 - ret_val;
-	ret_val *= 3;
+	s8 ret_val = clamp(-value, 0, 33) * 3;
 
 	if (ret_val == 99)
 		ret_val = 100;
+
 	return ret_val;
 }
 
-- 
2.19.1

