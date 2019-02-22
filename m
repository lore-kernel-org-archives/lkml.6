Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90253C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5958A2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqEIwjj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfBVSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37639 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfBVSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id z196so1702939lff.4;
        Fri, 22 Feb 2019 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYaQf2uE1bC7QPOkeoCbL4U6C9x9+VxaeGqL2OwsNgg=;
        b=DqEIwjj5N2Y9TVUSi9elZTTyD/zLlmRzx7F6oU+wkte7WdKEFHmcD+cHoOBrMnIu4q
         yPPU6ul+geqPDpHiNP9+tRz41f2UgkGzEBY3eTDBbTfkyK7LtP2ct3HBCeHd1xPaJ/u6
         ykpLTMpDEPbNBJLuv+47DJmph+UOGZi09a0pMDbuWultGp/hJDBEEtnXWiRzaUi81W+3
         xFi3ktCdN7IfTTu6DJjaNWMkEOy9KU692WyczHG1JQayse95kSP66EOXE3crMg/o9L/3
         gVy79DBmH/1ywHbkk9PtZXaojkP6qrfudiTkxbEcGOchYRDt7FQ2E2hKR+UYBw+ZIN9E
         hOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYaQf2uE1bC7QPOkeoCbL4U6C9x9+VxaeGqL2OwsNgg=;
        b=g/Zh0FofF//VTSmSaWpSCCIQjgcuuqg8SGJQTURaedlOTeOtUtAlxitOCPYEzBdhmV
         DZg6fI9C+OW0TtZluN3JcjUDmwrWbpq20Tu/6QZNbmGoOHBu3yrMoVzdoKwDhs7nmMUk
         +W2AahNwUHH7wMZKfbvgWlyiXjsSPLan650452QqjSNVp3PVFDzhW38ipEGuY2bBXGdu
         zDr16TII1lD0ariRK3o6SSecm9Z7rGJSfwurXBkF3hmx0tidpNlS6P7jWsivxumf7UH9
         H9bci4r2HNvYtU/v5Dbe4tgJNhriCQ5avUpNe+GfMYbGtpCTTBY3O4AZNh+/T68juvwP
         Xgtg==
X-Gm-Message-State: AHQUAuavtBD2f0ZOq+nHYRYZU4LvlIP+7Eq4oEOcQxsHNdGz9D+4k8zN
        vDMRRFP+9AUvaSksfgwS4bA=
X-Google-Smtp-Source: AHgI3Ib7t2qtKWzy1es0HVB0btxyzLqrB2Y2VD6MUU8P+E50U3FhtesCtG5Dl/NFX7+wEdf7hwg52A==
X-Received: by 2002:a19:f818:: with SMTP id a24mr3181709lff.58.1550858678430;
        Fri, 22 Feb 2019 10:04:38 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] ARM: tegra: Add firmware calls required for suspend-resume
Date:   Fri, 22 Feb 2019 20:59:26 +0300
Message-Id: <20190222175926.23366-9-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to resume CPU from suspend via trusted Foundations firmware,
the LP1/LP2 boot vectors and CPU caches need to be set up using the
firmware calls.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 53 ++++++++++++++++++-----------
 arch/arm/mach-tegra/reset-handler.S | 26 ++++++++++++++
 arch/arm/mach-tegra/sleep.S         |  3 +-
 3 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 66c8cd63dd86..f209f59e0daf 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,6 +33,7 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
@@ -160,6 +161,28 @@ int tegra_cpu_do_idle(void)
 
 static int tegra_sleep_cpu(unsigned long v2p)
 {
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled with
+	 * MMU-on if cache maintenance is done via Trusted Foundations
+	 * firmware. Note that CPUIDLE won't ever enter powergate on Tegra30
+	 * if any of secondary CPU's is online and this is the LP2-idle
+	 * code-path only for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
+	/*
+	 * Note that besides of setting up CPU reset vector this firmware
+	 * call may also do the following, depending on the FW version:
+	 * 	1) Disable L2. But this doesn't matter since we already
+	 * 	   disabled the L2.
+	 *	2) Disable D-cache. This need to be taken into account in
+	 *	   particular by the tegra_disable_clean_inv_dcache() which
+	 *	   shall avoid the re-disable.
+	 */
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+
 	setup_mm_for_reboot();
 	tegra_sleep_cpu_finish(v2p);
 
@@ -196,24 +219,13 @@ void tegra_idle_lp2_last(void)
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
-	/*
-	 * L2 cache disabling using kernel API only allowed when all
-	 * secondary CPU's are offline. Cache have to be disabled early
-	 * if cache maintenance is done via Trusted Foundations firmware.
-	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
-	 * of secondary CPU's is online and this is the LP2 codepath only
-	 * for Tegra20/30.
-	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
 	/*
 	 * Resume L2 cache if it wasn't re-enabled early during resume,
 	 * which is the case for Tegra30 that has to re-enable the cache
 	 * via firmware call. In other cases cache is already enabled and
-	 * hence re-enabling is a no-op.
+	 * hence re-enabling is a no-op. This is always a no-op on Tegra114+.
 	 */
 	outer_resume();
 
@@ -235,6 +247,15 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 
 static int tegra_sleep_core(unsigned long v2p)
 {
+	/*
+	 * Cache have to be disabled with MMU-on if cache maintenance is done
+	 * via Trusted Foundations firmware. This is a no-op on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
+
 	setup_mm_for_reboot();
 	tegra_sleep_core_finish(v2p);
 
@@ -360,14 +381,6 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
-	/*
-	 * Cache have to be disabled early if cache maintenance is done
-	 * via Trusted Foundations firmware. Otherwise this is a no-op,
-	 * like on Tegra114+.
-	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
 	/*
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 3bf202819534..19a609046547 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -20,6 +20,7 @@
 #include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
@@ -76,6 +77,7 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
+	bl	tegra_resume_trusted_foundations
 
 #ifdef CONFIG_CACHE_L2X0
 	/* L2 cache resume & re-enable */
@@ -88,6 +90,30 @@ end_ca9_scu_l2_resume:
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
+
+/*
+ *	tegra_resume_trusted_foundations
+ *
+ *	  Trusted Foundations firmware initialization.
+ *
+ *	Doesn't return if firmware presents.
+ *	Corrupted registers: r1, r2
+ */
+ENTRY(tegra_resume_trusted_foundations)
+	/* Check whether Trusted Foundations firmware presents. */
+	mov32	r2, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
+	ldr	r1, =__tegra_cpu_reset_handler_data_offset + \
+							RESET_DATA(TF_PRESENT)
+	ldr	r1, [r2, r1]
+	cmp	r1, #0
+	reteq	lr
+
+ .arch_extension sec
+	/* First call after suspend wakes firmware. No arguments required. */
+	smc	#0
+
+	b	cpu_resume
+ENDPROC(tegra_resume_trusted_foundations)
 #endif
 
 	.align L1_CACHE_SHIFT
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 0a8086d5a47a..78c74ace98ee 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -49,8 +49,9 @@ ENTRY(tegra_disable_clean_inv_dcache)
 
 	/* Disable the D-cache */
 	mrc	p15, 0, r2, c1, c0, 0
+	tst	r2, #CR_C
 	bic	r2, r2, #CR_C
-	mcr	p15, 0, r2, c1, c0, 0
+	mcrne	p15, 0, r2, c1, c0, 0
 	isb
 
 	/* Flush the D-cache */
-- 
2.20.1

