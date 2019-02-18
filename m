Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5165A218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjfT5Ard"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfBRAUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:20:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39830 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfBRAUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:20:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so7609532pfa.6;
        Sun, 17 Feb 2019 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvZ9oj3/sW8iZFxRIUh2GML421I70F1BQFHxs/lpvMg=;
        b=TjfT5Ardm+nWAMMGW/qXxaRrMgEVjhMs3IxlxLDThMh5A1u4aKAzu91599vKGBccIR
         AClzIhZOJNcFOZecAGT+EAJ1sjbXh3giEmE9DvtZB4aQ1bWgVX4YlkT6u33X84/kBus4
         BGl7F6Hyv7Vwu89H9bxGaYGijfZx8xXy3i3qYszLObQgazidbdtOX33PYgnUGR0Qdl5I
         BtxDRfhQwUNSwFjhcc7xkp5W9zjszbhDwM/SVXrzN4XUsGuavFlNnC0V6PtrfRxo+INj
         m4vm+Zpytzvu6W1bRIIoPZejTIboTNq9z3A0OScm7Gl9jpa2IefBPzmo6BP7/VVCK0pt
         IulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvZ9oj3/sW8iZFxRIUh2GML421I70F1BQFHxs/lpvMg=;
        b=uTrktWkwkaDhBH8bcboqbDFVOleBa3TRr8Idh1Qmp0VbgqAfjvbQbBUqedCG4IYDTg
         DfkT7WbVTmmYeFA8GRy/3c/gAPNn3kAu86tjQzJgtWwH16w25yHUEw2lfGbp1pkf2ypj
         6ChdnuvyTEVeV1z6Rdhl3PyAcMMWwinTLfzYpVhbBxWjlnO0Bf/kvhEfvpNKkVKyW5CA
         ebAJwCkOo/hYPGE21E9LRChP0qoJiashFEX3ShrxJEG/kzyPAhtPRXS2EV+ayJz/sslB
         qOiblyYkvLk9M3pGGpf1HspI2yQYtqf/lqL7/Gowl3RW9poAtYNv7WT2kr1Ai3ytqdck
         CZnQ==
X-Gm-Message-State: AHQUAuZUoJGrAnRxWP+h5SS5P6s+zbBkyJyLH/HZ039wSAtHA0wQtPLZ
        lgBjIHMxomKvMcJ75UbduXso/d98
X-Google-Smtp-Source: AHgI3IZFxXD8vvprhu2l4e5vhlmtcR4sxejpGHTL3Fp9T2bq/p4Yol+XqQX+5E8wjDFWzQJvtQWsSw==
X-Received: by 2002:a63:2a96:: with SMTP id q144mr16028847pgq.338.1550449210513;
        Sun, 17 Feb 2019 16:20:10 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:20:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] ARM: tegra: Add firmware calls required for suspend-resume
Date:   Mon, 18 Feb 2019 03:17:26 +0300
Message-Id: <20190218001726.16785-9-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to resume CPU from suspend via trusted Foundations firmware,
the LP1/LP2 boot vectors shall be specified using the firmware calls.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 14 ++++++++++++++
 arch/arm/mach-tegra/reset-handler.S | 26 ++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 66c8cd63dd86..97bdfffc244e 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,6 +33,7 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
@@ -207,6 +208,8 @@ void tegra_idle_lp2_last(void)
 	if (trusted_foundations_registered())
 		outer_disable();
 
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
 	/*
@@ -368,6 +371,17 @@ static int tegra_suspend_enter(suspend_state_t state)
 	if (trusted_foundations_registered())
 		outer_disable();
 
+	switch (mode) {
+	case TEGRA_SUSPEND_LP1:
+		call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
+		break;
+	case TEGRA_SUSPEND_LP2:
+		call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+		break;
+	default:
+		break;
+	}
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
 	/*
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index c827b185d281..24fb375e11a9 100644
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
-- 
2.20.1

