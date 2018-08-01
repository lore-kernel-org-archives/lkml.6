Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7168CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C808320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Sjb9rlcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C808320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbeHAMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:42:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbeHAMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:42:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so19667860wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=BN37pvmmWbVTpksW6gMLiYsUHWEhBJrmBHOOgcKUudk=;
        b=Sjb9rlcIQxvuL6/1CeU+lySdkSLQtmhI3ThZ+wcNKruBwZczT2w/Xg5yN7ww2OIoQo
         x6kr3M/k+48vV+dH22qf24xbgVnZl0EoVrc/iPjNaNV6vvj2gGeG22Mxh4hHFNfFicEb
         3KZr/IVt761alTmY/pP/Bz2G5mPVMQe49WMlkDl/deKooKAB7+TXJLUMEwdAmzKnYRIS
         40CSczSQLkJrmmBI+SkoTHesUJoVW8A3v4gayF1ouiWKbgJ18/LCOwBPx7TALK1xRvRn
         B2cl5v6QVvuolIKW0z6SjNdft9QWM00LZhHO4AaKLPjfTH3a5Gj2ZHhJA9WKo3hajIoC
         NOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BN37pvmmWbVTpksW6gMLiYsUHWEhBJrmBHOOgcKUudk=;
        b=EeH2UBedSGDhPo6rMobQdmqJNWlOoUw82+Ex+xdTZCEHl7GsOuQnBJKQAenLQkdaxm
         tUqd2tyK4pmEZrBij6Z6Yqm8eENXu7H6aCzE4BxPftlDU6NwzZ9iUzs2EUA4EFqlg/i0
         4X5nThQRFl+v3III5v6Ym6KtTRQ697h+TM712LRYwRNAmyEOkg3HBNq9XEi310LN4CzI
         32sqIjERH2AvF4E4nDgqySuT5NzRxbxX8vqKR3cHRurG9R2oi8pCp/pTBn8cvK2Ae7am
         jm//yDxS0VpjulJJm3fvwjXE2l+leun/AZ9K4XXLP9unHMJwVR1OCYcuT667mNGYMvfM
         Zx6Q==
X-Gm-Message-State: AOUpUlGzdIlZLB/+/oFrW5ubzuSsjFZDIgHPETCgQjpk5G6Sd0pP6Fp8
        O5edKaxhKdYhScFGXCC0r41x7Q==
X-Google-Smtp-Source: AAOMgpeY/CxUFN6u+NxQmNMD0Z5s1oidxKIp8ZF4SNgeik9qDWL/xR37mkaXgrlT3MQ5s50UFieaow==
X-Received: by 2002:adf:dc4c:: with SMTP id m12-v6mr24870340wrj.84.1533121043956;
        Wed, 01 Aug 2018 03:57:23 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b202-v6sm7528939wme.22.2018.08.01.03.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 03:57:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: meson: fix mux clock names
Date:   Wed,  1 Aug 2018 12:57:20 +0200
Message-Id: <20180801105720.23999-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current clock name looks like this:
/soc/bus@ffd00000/pwm@1b000#mux0

This is bad because CCF uses the clock to create a directory in clk debugfs.
With such name, the directory creation (silently) fails and the debugfs
entry end up being created at the debugfs root.

With this change, the clock name will now be:
ffd1b000.pwm#mux0

This matches the clock naming scheme used in the ethernet and mmc driver.
It also fixes the problem with debugfs.

Fixes: 36af66a79056 ("pwm: Convert to using %pOF instead of full_name")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 822860b4801a..c1ed641b3e26 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -458,7 +458,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 				   struct meson_pwm_channel *channels)
 {
 	struct device *dev = meson->chip.dev;
-	struct device_node *np = dev->of_node;
 	struct clk_init_data init;
 	unsigned int i;
 	char name[255];
@@ -467,7 +466,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &channels[i];
 
-		snprintf(name, sizeof(name), "%pOF#mux%u", np, i);
+		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
 		init.name = name;
 		init.ops = &clk_mux_ops;
-- 
2.17.1

