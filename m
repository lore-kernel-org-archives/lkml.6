Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C279217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FlZSLv7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfBZMJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:09:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfBZMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so10407026wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmnSVQdTfbGKlefXWSsyV37QV8Nr2Ok7q6FkkpWXde8=;
        b=FlZSLv7otsdiPABD/OcgNwvBy8SQ2V4fgpJVxYomW3SiwbCcmmzKIzqmIxYoMdNt7o
         K6SVjvE4Nywt4+DwWGyqBM/1wwwOFLO8ZmRUYDpunaRdCHWwGYRFwlG7fbLkb+PiJUKa
         HLn8Rr0TKMzpmeBnt+Q/JTabR8Kj6h1Wv2KPJ+547Se9qVcvu0lLJY98v0clHJQyBJWu
         XXLl+I7S+9/GoMo3J+scjPw1qDLWxrzu08I5asNM3FOgKxX+Kmy0FoDzlkNftwYrJocY
         uMUvtTee5nVzNV7aGU3aHSrvWOO+rI7chfp1JLGGb3lGvNAUE97QMaAKlln4aSddX8Lf
         uX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmnSVQdTfbGKlefXWSsyV37QV8Nr2Ok7q6FkkpWXde8=;
        b=oa/SDEDiXgD8xAXRyXWkUcRxoLMsVqisnw37fzMctjBe5VRqhOmx/sY31yaRXhcNN7
         hIVqeMCxPOwebjJ0VfADQZwp+rHF0g4549BjGrZ8GmD7vIF0YqDcCLQfVFKcdoqdUtFH
         GXDkLE5v6Qe0ysKRj4kl1M5VH8yx2z9fBHfM4JNYP40LlNz6MlZVI/2xfUJ0B+tShYby
         Sc0mFLUjZIP+CEDR8+wwPnv19ukVSxbBNK1E/nW5HLBANsF+XVboJdnPqrTDxWrmtznH
         iRE0PVG4Z0yY8D4wj4cwg2N9RV9aCuNuNAdsKArVk65e2g8jcJ4HijMvtebIQ99w1HE6
         zGnQ==
X-Gm-Message-State: AHQUAuY9K0YI05pTL3yfZX6pYbwoMysJ8n5DobPlRba9JjGAlQFCOi2G
        hU05S2b64QbLS0rng6z2aaTWgA==
X-Google-Smtp-Source: AHgI3IYCdNyaujemoePtKT2MpyWub+GOJHfHfPbRf8DMum6dJLYP//Zds7cN3YocizjowMtnswornA==
X-Received: by 2002:adf:81a1:: with SMTP id 30mr6488983wra.285.1551182852040;
        Tue, 26 Feb 2019 04:07:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 02/11] ARM: davinci: enable the clocksource driver for DT mode
Date:   Tue, 26 Feb 2019 13:06:24 +0100
Message-Id: <20190226120633.18200-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch all davinci boards supporting device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer for ARCH_DAVINCI.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1037f49e050f..da414692bd0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -586,6 +586,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select COMMON_CLK
 	select CPU_ARM926T
+	select DAVINCI_TIMER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 5a6de5368ab0..740410a3bb6a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -398,17 +398,3 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
-
-static int __init of_davinci_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	davinci_timer_init(clk);
-
-	return 0;
-}
-TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.20.1

