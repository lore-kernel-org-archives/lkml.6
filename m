Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E64220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHMPIDTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBVTgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:36:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41063 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:36:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so1546439pfn.8;
        Fri, 22 Feb 2019 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmXj2CFCufbymv3cp8YFtUbtulq2NnKIhiNfkKJJYEo=;
        b=GHMPIDTvLvjBOHwS0fwhok9I+SyWu+L8neRkBq9y14Ecsvn26HH1M8ThSa6vY1+Fe7
         FRTBItk72hhlsAoylKvK+tx+16dn10IoJ1+rxTMQQv4v6wlGoWE9x9jlJ+53Ay8Hj8pt
         2ErvJiE3dJyD7jNuFUKsJeRS3wNbhRWgHHrmCO8UdTdDpyXjM414ynqA8gH2RoaXOcKe
         vIRRDSljXvmppuxfIDvh5Zue+O74dztwNnUBeui7rZn23xhyQZ+0cbp16WW883zqhZOl
         enVgXJB5wsF5ZW2oxiWoYDbyzCAMhqMdV4DUUaGCQvp8/24MEdkZ1v7B8bcEKzD1OyPk
         s8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmXj2CFCufbymv3cp8YFtUbtulq2NnKIhiNfkKJJYEo=;
        b=mfutqFYiciWZxfuMCZYMhj1HIMC0QDPsWjuh5ak8jTVmRPX2HJs2qz3QAgTOutUpbf
         Gx2ZU3Is9YZNARdWdNsameoDy9WwrBkPhLmJSmXAck8YV4Dg6VmuRwQygo/cDFXsaele
         sVeYMwgKOwyvSCYBRk7GoaSEa0SMm5OvHnXqGTW/0c9pDaTCTeV4GP+M30X9cMlLYtiY
         kQeLc2LihBK3s92udmGm4Sjn7k9bRzJ+JssjlxTkgSgix8bg4LDAdzli6pRlpT4YPivm
         qWNAu/vJitDHiBq9hfZ3auQLYk5yCjRZ3VtD3IOuqkn4CYmWJI3op9YPXYie1mb9Mk30
         Q+Aw==
X-Gm-Message-State: AHQUAuY8L6x97v2X9tcrSR+/hauyMayQD1lq3lyx1xR851zohCGaMeTE
        hUWtNa65vzIa4kA9SsGQ1LM=
X-Google-Smtp-Source: AHgI3IaOa/u2+3YKsR9DYtkRjEFGoGuDZpBZ63o4ogm0aGaOurDqSzqa8Yw3MvOCYQjB751aEsVlnQ==
X-Received: by 2002:a63:d413:: with SMTP id a19mr5439163pgh.199.1550864174444;
        Fri, 22 Feb 2019 11:36:14 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:36:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/7] ARM: tegra: Add firmware calls required for suspend-resume on Tegra30
Date:   Fri, 22 Feb 2019 22:34:26 +0300
Message-Id: <20190222193426.10747-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to suspend-resume CPU with Trusted Foundations firmware being
present on Tegra30, the LP1/LP2 boot vectors and CPU caches need to be
set up using the firmware calls and then suspend code shall avoid
re-disabling parts that were disabled by the firmware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 49 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/reset-handler.S | 26 +++++++++++++++
 arch/arm/mach-tegra/sleep.S         | 14 ++++++---
 3 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ad5719779b0..f209f59e0daf 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,11 +33,13 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -159,6 +161,28 @@ int tegra_cpu_do_idle(void)
 
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
 
@@ -197,6 +221,14 @@ void tegra_idle_lp2_last(void)
 
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op. This is always a no-op on Tegra114+.
+	 */
+	outer_resume();
+
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
@@ -215,6 +247,15 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 
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
 
@@ -342,6 +383,14 @@ static int tegra_suspend_enter(suspend_state_t state)
 
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP1:
 		tegra_suspend_exit_lp1();
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
index 5e3496753df1..53863d59521b 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -49,8 +49,9 @@ ENTRY(tegra_disable_clean_inv_dcache)
 
 	/* Disable the D-cache */
 	mrc	p15, 0, r2, c1, c0, 0
+	tst	r2, #CR_C			@ see tegra_sleep_cpu()
 	bic	r2, r2, #CR_C
-	mcr	p15, 0, r2, c1, c0, 0
+	mcrne	p15, 0, r2, c1, c0, 0
 	isb
 
 	/* Flush the D-cache */
@@ -132,10 +133,13 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
-	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	moveq	r3, #0
-	streq	r3, [r2, #L2X0_CTRL]
+	retne	r0
+
+	mov32   r2, TEGRA_ARM_PERIF_BASE + 0x3000
+	ldr	r3, [r2, #L2X0_CTRL]
+	mov	r9, #0
+	tst	r3, #1				@ see tegra_sleep_cpu()
+	strne	r9, [r2, #L2X0_CTRL]
 #endif
 	ret	r0
 ENDPROC(tegra_shut_off_mmu)
-- 
2.20.1

