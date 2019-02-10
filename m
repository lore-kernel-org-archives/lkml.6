Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C1C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EDA2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="FQN9DBH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfBJWvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:51:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33128 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfBJWvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:51:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id h22so12732278wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 14:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nIdxf4j3KnD7oNy9LuC6ROOVelJxc6kOF3KEKzbbZsk=;
        b=FQN9DBH3yJUGgHit/7Gs31JZ6yXI7evBdhm03ZWaTwBWiuM7qP+xUFJ3h4NCV6s70h
         Fm2Y1411mgMAf0ZyaupkxkYX+caDJWRkp605wqPXpqfoXWmZsMsJkvgGCev7w6ABkOt4
         BG0BykM9ueNXygRr5Yv/ErIG39yRQSVJWLqOcpX++zbXr3QK3XCCcZ5BQ78rmpcSoGuW
         OmgmHRw1uKGcyU/ZIu4BcSPYBtbd9wX1u+6pyKJGaAWtRRoEbEzyC3a7E3beXezqyCXc
         D3MXOP+VQpjrRt5dwbMSI35madC+42o6Ua+Jzbfv5lsrQEYKOfpA9bNbcO6t/EbZkGVn
         GnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nIdxf4j3KnD7oNy9LuC6ROOVelJxc6kOF3KEKzbbZsk=;
        b=Fz3A3f3WuNo/a8exA0eOhZRzS0sRg2beRHdumFrLdfgc2i5h9GdNMudJHWGdN0XKO0
         mD057AfCVq/V6F0Low0nNaxXvfWOMXxotgoiW8bY85DjYkscmBSiMTyAt6DppPWyc5tg
         BuyFm44eeOB0AlFWv/hISySR5tauXATt1aVlas4MJYwDTpzXoGk3jrvlUySXRfWBCpGX
         sGTGWN3TsB/ystlElhN/s5TDz+1HUfRyMlR6Yc8MDNyJ69ktjwX2iNp/N0B9elzQ7yaD
         duLd/758qAf+j2IOVJ2dJfcXefomu1a93EniBKnageV54XM0U/Op7iYYgpJ/4qqw/RBs
         ZeOA==
X-Gm-Message-State: AHQUAuY43N2gauEc837OTg94HwllP37KEon/HjT0HVNiw4s0AY5bxZk2
        za0DNV7ynrPQPJuW9dX11Sy7TA==
X-Google-Smtp-Source: AHgI3IYF7h43g1CP/CDeb8vtCTWWwEjXO0VVxxT/wv42bMeamEthbEwi9vSE+7xxgm+u02hIU/H6cQ==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr20116413wrq.161.1549839079055;
        Sun, 10 Feb 2019 14:51:19 -0800 (PST)
Received: from localhost.localdomain (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id c139sm3904325wmd.13.2019.02.10.14.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 14:51:18 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH 1/2] clocksource: exynos_mct: Move one-shot check from tick clear to ISR
Date:   Sun, 10 Feb 2019 22:51:13 +0000
Message-Id: <20190210225114.20110-2-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a timer tick occurs and the clock is in one-shot mode, the timer
needs to be stopped to prevent it triggering subsequent interrupts.
Currently this code is in exynos4_mct_tick_clear(), but as it is
only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
leaving exynos4_mct_tick_clear() just doing what its name suggests it
should.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/clocksource/exynos_mct.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..1e325f89d408 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -388,6 +388,13 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
 }
 
+static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+{
+	/* Clear the MCT tick interrupt */
+	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+}
+
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
@@ -420,8 +427,11 @@ static int set_state_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
-static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 {
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = &mevt->evt;
+
 	/*
 	 * This is for supporting oneshot mode.
 	 * Mct would generate interrupt periodically
@@ -430,16 +440,6 @@ static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 	if (!clockevent_state_periodic(&mevt->evt))
 		exynos4_mct_tick_stop(mevt);
 
-	/* Clear the MCT tick interrupt */
-	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
-		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-}
-
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
-{
-	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = &mevt->evt;
-
 	exynos4_mct_tick_clear(mevt);
 
 	evt->event_handler(evt);
-- 
2.13.6

