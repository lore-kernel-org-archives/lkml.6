Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E995E22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gY7fKNKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E995E22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbeKNTzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:55:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50704 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:55:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so14863313wmw.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22+WsIp9gWJXQ2saFVjdkLtz//e64h7C5HtNVx8zEPY=;
        b=gY7fKNKWY0mom49ebb4agp83QPlv4z0oXU3GHM71iNiHI3E6vgafZsXbNYUPsfX/Z8
         QmbtVcrkkAsUZN54vnj+vgogGE/VX7TC06ngPZocoBPt4dEt6XEyU+RxDV1oa5eAruqx
         1sfWpuPfzyVa4Bt2eGNYy49M/7pBIDIna57njYEepfOigFVH2e0V+DIdaLrY+yP40ZuH
         GEPtKKjyxs1ghmYVc+89MCpJkXZ0CqQVOqfVEwo1D/Pu72T8ltHgL0Xj8+uEnw+upQox
         1CHcQD0TWrGv77xh32xQPTC7lUs3GIPgWfRSzA1sFbZxO0AR8h3Z6pU76znSNNAtx49W
         7D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=22+WsIp9gWJXQ2saFVjdkLtz//e64h7C5HtNVx8zEPY=;
        b=l1KX60ppbBSg+cKIRCn9NXg+lN2GG2KJrUCI850X/JI+9zT36JvUAXMu/wXh4vlCpE
         RCtk2CPXrOYqSMfPRXtw+I2YPgQmlKQLfsDhitYrq+uO3Hx3t/iEucXgfxs4IInjcOFf
         VgASha8u4HvgTbp9+xKC5g+0Ggk9uZcXgbCQXAkvtfu478m8VeHi9sEovuQyfxKBuIj3
         /FKw6AS9XsY/R+ktnABHIHNwlCiAVY7SOVRVmzUaXhWMPhcxnFZqj/yOl/a2N4loZCeL
         YBcYk3QTRc/cLVUgDwQ0ZoYad2fYaVTpc8zTlitflrNzUUYF20OGW9DX3S2E6CsjiFlv
         24Zg==
X-Gm-Message-State: AGRZ1gLIY15dRpSxTtvJYcGBPNiCvANr/SpVQdWOd8CEy2LqDTrceIfh
        RCgKCokE+p94AmA4ldCQA1eE1w==
X-Google-Smtp-Source: AJdET5dXNFYOIkXw8QevBiXe/YZGuNdO5EOIDuQo1EdI5tn3yuLNe3UWF2KykmlDGmXp7mqCnk6LSA==
X-Received: by 2002:a7b:cb59:: with SMTP id v25-v6mr1237079wmj.102.1542189196404;
        Wed, 14 Nov 2018 01:53:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id z7-v6sm21955660wrv.21.2018.11.14.01.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:53:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH] clocksource: timer-ti-dm: remove the early platform driver registration
Date:   Wed, 14 Nov 2018 10:53:12 +0100
Message-Id: <20181114095312.23667-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver is no longer used as an early platform driver. Remove the
registration macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b224b87..595124074821 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -991,7 +991,6 @@ static struct platform_driver omap_dm_timer_driver = {
 	},
 };
 
-early_platform_init("earlytimer", &omap_dm_timer_driver);
 module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-- 
2.19.1

