Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A81C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E632082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX5l75C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E632082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH3XZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:25:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39695 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeH3XZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:25:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id j201-v6so8097401lfg.6;
        Thu, 30 Aug 2018 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xAjspFSrbot8A1PzNp0zdjRgfutJv+YsrCYjia3i/EU=;
        b=UX5l75C48+mPr+3nGhbBZYREKbGfoJCb54Sy2y/mqwxXWMOswaf3Eyi8ZYphaN6MV2
         qLq+Y23hS0qCwwoQYS6fMv+CMW6nEFDTKXstqczcrPGfmlkjM3POEAVzktANO7mVoHEN
         qeLPsu2ML0rI+STGvpi4hdmrH+SQimV/Al1jp5B1xeYy/z2P9j48mEMHOxqll0osZKwV
         ScD+QZpwfvNUkMMM6UWm9Pcr9r8q0kAH5tLHOfBFIcMOCAWri3N686JXxB+MXubuzWUr
         U02ssAPCpctW/fcHEE9vWdvFw5jNO0gSawCi32AcvWJmh/9YzNT9/WPOlu+vJIE/BNQN
         kemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xAjspFSrbot8A1PzNp0zdjRgfutJv+YsrCYjia3i/EU=;
        b=LEpaeTlp3XH5SIRRGsvZxe5JIBaC/a+mAfxCNrufRyC8y4SDyTMbvOQ4js/oC6Aqak
         KYoLB2/nE9hgZkBDbP5jEwlZNFrbqDMXkxsozLoONn2pkevW2/IUunW5VstTHsdL9XRx
         gpHRlVD1j20EDDgztq+ZP8zQcMCSJ/nW/PXkgya6Z1IiFuZPrhWEl8C4cT8KXf6+Y5Of
         Du4oEdsUHBI7cdUwvfKMG9QwxMe06IaF3gNK0JF6BF3QaRYWkABtHn1159grzs/BJ+J4
         npKbU9HNkih8ZG6NG5UGW8U5amhX9L/vHMHfxnE3ppUaOLd0se7bLixPQFQrcLLsUIQ5
         WvlQ==
X-Gm-Message-State: APzg51BGeqLnF8uasv9qqdHYd1VtbrRjhb65mqrDPqq0BYjbjtXp8RdS
        DAbycOcC8V9qYlbr0sAuiCI=
X-Google-Smtp-Source: ANB0VdYCYZWa0BaeKxKBQbXrRcp6H4F8qMwVKFst92XuMywhFZtWhMn+IRFLZ1CDiWnVa//Gu+P1Zg==
X-Received: by 2002:a19:d095:: with SMTP id h143-v6mr8220471lfg.16.1535656912223;
        Thu, 30 Aug 2018 12:21:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1403291lfl.1.2018.08.30.12.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:21:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] clk: tegra: Poll PLLX lock-status on resume from suspend on Tegra20/30
Date:   Thu, 30 Aug 2018 22:20:45 +0300
Message-Id: <20180830192045.11017-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830192045.11017-1-digetx@gmail.com>
References: <20180830192045.11017-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Poll PLLX lock-status instead of delaying for a constant time. This speeds
up resume from suspend a tad and is less error-prone since lock failure
will be reported.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 51 +++++++++++++++++++++++++++------
 drivers/clk/tegra/clk-tegra30.c | 51 +++++++++++++++++++++++++++------
 2 files changed, 86 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index f987ed361df6..c8146e65e7ad 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/of.h>
@@ -1001,6 +1002,47 @@ static void tegra20_cpu_clock_suspend(void)
 				readl(clk_base + SUPER_CCLK_DIVIDER);
 }
 
+static void tegra20_cpu_clock_restore_pllx(void)
+{
+	u32 misc = readl_relaxed(clk_base + PLLX_MISC);
+	u32 base = readl_relaxed(clk_base + PLLX_BASE);
+	u32 misc_restore = tegra20_cpu_clk_sctx.pllx_misc;
+	u32 base_restore = tegra20_cpu_clk_sctx.pllx_base;
+	int err;
+
+	/* nothing to do if PLL configuration is unchanged */
+	if (misc == misc_restore && base == base_restore)
+		return;
+
+	/* otherwise restore configuration */
+	if (base_restore & BIT(30)) {
+		/* PLL shall be locked if we are going to (re)enable it */
+		misc_restore |= BIT(18);
+	}
+
+	/* disable PLL if it is enabled to re-apply configuration safely */
+	if (base & BIT(30)) {
+		writel_relaxed(base & ~BIT(30), clk_base + PLLX_BASE);
+		udelay(1);
+	}
+
+	/* restore the configuration */
+	writel_relaxed(misc_restore, clk_base + PLLX_MISC);
+	writel_relaxed(base_restore, clk_base + PLLX_BASE);
+
+	/* PLL is disabled now, nothing left to do */
+	if (!(base_restore & BIT(30)))
+		return;
+
+	/* otherwise start polling the PLL lock-status */
+	err = readl_relaxed_poll_timeout_atomic(clk_base + PLLX_BASE, base,
+						base & BIT(27), 1, 2000);
+	/* should not happen */
+	WARN_ONCE(err, "PLLX failed to lock: %d\n", err);
+	/* post-enable delay */
+	udelay(50);
+}
+
 static void tegra20_cpu_clock_resume(void)
 {
 	unsigned int reg, policy;
@@ -1018,14 +1060,7 @@ static void tegra20_cpu_clock_resume(void)
 
 	if (reg != CCLK_BURST_POLICY_PLLX) {
 		/* restore PLLX settings if CPU is on different PLL */
-		writel(tegra20_cpu_clk_sctx.pllx_misc,
-					clk_base + PLLX_MISC);
-		writel(tegra20_cpu_clk_sctx.pllx_base,
-					clk_base + PLLX_BASE);
-
-		/* wait for PLL stabilization if PLLX was enabled */
-		if (tegra20_cpu_clk_sctx.pllx_base & (1 << 30))
-			udelay(300);
+		tegra20_cpu_clock_restore_pllx();
 	}
 
 	/*
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 0f8797ca39e2..0059fdf79169 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
@@ -1189,6 +1190,47 @@ static void tegra30_cpu_clock_suspend(void)
 				readl(clk_base + CLK_RESET_CCLK_DIVIDER);
 }
 
+static void tegra30_cpu_clock_restore_pllx(void)
+{
+	u32 misc = readl_relaxed(clk_base + CLK_RESET_PLLX_MISC);
+	u32 base = readl_relaxed(clk_base + CLK_RESET_PLLX_BASE);
+	u32 misc_restore = tegra30_cpu_clk_sctx.pllx_misc;
+	u32 base_restore = tegra30_cpu_clk_sctx.pllx_base;
+	int err;
+
+	/* nothing to do if PLL configuration is unchanged */
+	if (misc == misc_restore && base == base_restore)
+		return;
+
+	/* otherwise restore configuration */
+	if (base_restore & BIT(30)) {
+		/* PLL shall be locked if we are going to (re)enable it */
+		misc_restore |= BIT(18);
+	}
+
+	/* disable PLL if it is enabled to re-apply configuration safely */
+	if (base & BIT(30)) {
+		writel_relaxed(base & ~BIT(30), clk_base + CLK_RESET_PLLX_BASE);
+		udelay(1);
+	}
+
+	/* restore the configuration */
+	writel_relaxed(misc_restore, clk_base + CLK_RESET_PLLX_MISC);
+	writel_relaxed(base_restore, clk_base + CLK_RESET_PLLX_BASE);
+
+	/* PLL is disabled now, nothing left to do */
+	if (!(base_restore & BIT(30)))
+		return;
+
+	/* otherwise start polling the PLL lock-status */
+	err = readl_relaxed_poll_timeout_atomic(clk_base + CLK_RESET_PLLX_BASE,
+						base, base & BIT(27), 1, 2000);
+	/* should not happen */
+	WARN_ONCE(err, "PLLX failed to lock: %d\n", err);
+	/* post-enable delay */
+	udelay(50);
+}
+
 static void tegra30_cpu_clock_resume(void)
 {
 	unsigned int reg, policy;
@@ -1206,14 +1248,7 @@ static void tegra30_cpu_clock_resume(void)
 
 	if (reg != CLK_RESET_CCLK_BURST_POLICY_PLLX) {
 		/* restore PLLX settings if CPU is on different PLL */
-		writel(tegra30_cpu_clk_sctx.pllx_misc,
-					clk_base + CLK_RESET_PLLX_MISC);
-		writel(tegra30_cpu_clk_sctx.pllx_base,
-					clk_base + CLK_RESET_PLLX_BASE);
-
-		/* wait for PLL stabilization if PLLX was enabled */
-		if (tegra30_cpu_clk_sctx.pllx_base & (1 << 30))
-			udelay(300);
+		tegra30_cpu_clock_restore_pllx();
 	}
 
 	/*
-- 
2.18.0

