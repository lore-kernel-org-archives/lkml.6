Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A9D2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WpetVQL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfBDRSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37441 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfBDRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so699076wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqxdWQN8UOwRccvQcL/hEimhgA05XyRuysVUHnsgGlE=;
        b=WpetVQL+Y39MOmc0TFXx3nwd5DqaB7TBISMMXEGnBJS44XqFfJs1sMz9qm6yKoirqV
         YUUU7SvxxgDershi/qrEzz8b339FBa9/sl0yedYMSKBm4DZuxrSSoiYAGx+M1nzV9qah
         KVI1Ot/2TarQaYfFq5xi4hE6fBnFJI0qpTHER1McU+GhMMkGN0j3V/8AUQSL7FnV2ZR9
         rAgTo+lucQZLcTN3QmXEH8vQtape3Vvv/YpXxzMeBOnjxSQCmX8RDHNwlOTyp02Od9Qk
         tZnRs1Wbbfrz0vR+4aQXYSJpBB/yx0WMU7Pg++NbJPJy3hV4tt5Gf/w0CddB98gsZhnV
         dmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqxdWQN8UOwRccvQcL/hEimhgA05XyRuysVUHnsgGlE=;
        b=caykM8mtd+9VjYU6tKDnrad2EGXtSbyBJJyIFXDLXvHkwdVolltWgN0NMEhoDOI9FD
         qDZEdDEHNh4m5ojADt7Q6NnS6cBLYBA2QZ0x6M1uMcBcSH7hFXmXxtaQKwY2Aw2+1qmk
         NOQMdnuarASdpxFeDI49cL8W5gzBszvOjrqx2z4bpWDUrg+tCbtqQg2wrwxmGo//X5OL
         9AdLgJGrbV6/lLcgF9GMPmZWZOMLA6+4uxmqfcRNtGmD2ZfGT1dB0vyN/f7EndlzgkiZ
         FvaTrIbfSpLaVQF3G8L7RgpXci/PEwdq91NRM2HjnfCi1Sfb9/jcrIdV7vkM9HdNCVTC
         O60w==
X-Gm-Message-State: AHQUAuYhgOi533GkDNiu2GxTj2G6LQByEZY/TRji6QL6LE0WqomIO3Xe
        rf7Yq/vrdrhqE2d1coawAOA34g==
X-Google-Smtp-Source: AHgI3IaqpKtLUOCLvvumTaYWrnTPDl+3fjRJWz9cgc+ShD7qaSGXRUsfEwT70UesxRKyAlpsKCZeiw==
X-Received: by 2002:adf:b649:: with SMTP id i9mr370979wre.70.1549300690407;
        Mon, 04 Feb 2019 09:18:10 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 03/12] ARM: davinci: enable the clocksource driver for DT mode
Date:   Mon,  4 Feb 2019 18:17:48 +0100
Message-Id: <20190204171757.32073-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch all davinci boards using device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer to be built for
davinci_all_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..8a09a0ab0ce2 100644
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

