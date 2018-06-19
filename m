Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B82920836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0YP3ppR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B82920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966156AbeFSLDY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:03:24 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46903 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937591AbeFSLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:02:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id u5-v6so8218826lff.13;
        Tue, 19 Jun 2018 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4qnPvHb0NZBUOnlNBHbpGIEhOz4uE+W521CnV0Z9Do=;
        b=Z0YP3ppR+QzZPWzy5c5RKy04UpBf35VQ94q4bSVSvlE9NmI3UX3TrySAVNmPVOpCSR
         R3bnsql0QawcAmsJYB4zzH05NB45sk2I8XaNvBVZXiZOMiyTre5miTaHX6jWBl6E7DEY
         1Mk8Ig+kGY/U5o8wRSC/tPNeTF+h05hOE6/7MQRYGyQWIqZYfDpcEJF/6QgH1k6dGqnP
         rEh18x2f4x5g90ERwgBU7751zZm/TXbv1TaDvvAv9ntIzkHeBogNAGXVvIO7WNxX7XfO
         b6PhaPZ846gtQSmUKfsEJx0NdWarwTTXfj32SFI7IHsGm6Sjph9RDREkLwjuv69e2zKZ
         tFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4qnPvHb0NZBUOnlNBHbpGIEhOz4uE+W521CnV0Z9Do=;
        b=prJ+cFB3cnji2YHNzjXOVEUXBDdtwHi3+AKwmpSYL+z965ojdsxe/a/lgq+yNFpRya
         IY9Gz1dOYbMit6gKxx9n32eIWD5GuD6wB8ifCvhXiBCE9k8RUfiYXCDskkZAmCdCx9Mt
         bPQvpEsjtZ6ZYdrNfdNFPBORECe6Ov6oUBcJjn3UU223Pna+crzN0JaPOyVs79UEcrES
         gx27cBN1dCRV7llT0IElaOT5Y5rWrCcsKL+mN9Mw+Zcq4mzAvubMZFA6wNVdJVlk1U+Q
         eUsV4vDGlYkwQk25v8wwzOz9iiqf0AB33mJiIFz2zuaJySbvqs20CsPUXiW5rmjDwTOJ
         1bTQ==
X-Gm-Message-State: APt69E1gen1cZ0UozLNUPTlbDOJrA4ZCfYhFXgxjEBpAs+xPOL0dZCU2
        qXLZUxsCzkLT8JrQuQPy1NI=
X-Google-Smtp-Source: ADUXVKJjXdcv4E4BlNSs7BRgvpM6WQB25/mKKdyhKDHNeFpq5CNHrg/xJX1CE3crH8bjx/nbm+oQow==
X-Received: by 2002:a19:9a8d:: with SMTP id c135-v6mr6072300lfe.140.1529406176489;
        Tue, 19 Jun 2018 04:02:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id m84-v6sm3118543lje.91.2018.06.19.04.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:02:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/5] ARM: tegra: Don't apply CPU erratas in insecure mode
Date:   Tue, 19 Jun 2018 14:00:26 +0300
Message-Id: <20180619110027.16935-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU isn't allowed to touch secure registers while running under secure
monitor. Hence skip applying CPU erratas in the reset handler if Trusted
Foundations firmware presents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 24 ++++++++++++------------
 arch/arm/mach-tegra/reset.c         |  3 +++
 arch/arm/mach-tegra/reset.h         |  9 +++++++--
 arch/arm/mach-tegra/sleep-tegra20.S |  4 ++++
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..e9f2a7775998 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -29,8 +29,6 @@
 
 #define PMC_SCRATCH41	0x140
 
-#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
-
 #ifdef CONFIG_PM_SLEEP
 /*
  *	tegra_resume
@@ -121,6 +119,12 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+
+	adr	r12, __tegra_cpu_reset_handler_data
+	ldr	r0, [r12, #RESET_DATA(TF_PRESENT)]
+	cmp	r0, #0
+	bne	after_errata
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
@@ -155,7 +159,6 @@ after_errata:
 	and	r10, r10, #0x3			@ R10 = CPU number
 	mov	r11, #1
 	mov	r11, r11, lsl r10  		@ R11 = CPU mask
-	adr	r12, __tegra_cpu_reset_handler_data
 
 #ifdef CONFIG_SMP
 	/* Does the OS know about this CPU? */
@@ -169,10 +172,9 @@ after_errata:
 	cmp	r6, #TEGRA20
 	bne	1f
 	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov32	r5, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
 	mov	r0, #CPU_NOT_RESETTABLE
 	cmp	r10, #0
-	strneb	r0, [r5, #__tegra20_cpu1_resettable_status_offset]
+	strneb	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
 1:
 #endif
 
@@ -277,14 +279,12 @@ ENDPROC(__tegra_cpu_reset_handler)
 	.align L1_CACHE_SHIFT
 	.type	__tegra_cpu_reset_handler_data, %object
 	.globl	__tegra_cpu_reset_handler_data
+	.globl	__tegra_cpu_reset_handler_data_offset
+	.equ	__tegra_cpu_reset_handler_data_offset, \
+					. - __tegra_cpu_reset_handler_start
 __tegra_cpu_reset_handler_data:
-	.rept	TEGRA_RESET_DATA_SIZE
-	.long	0
+	.rept   TEGRA_RESET_DATA_SIZE
+	.long   0
 	.endr
-	.globl	__tegra20_cpu1_resettable_status_offset
-	.equ	__tegra20_cpu1_resettable_status_offset, \
-					. - __tegra_cpu_reset_handler_start
-	.byte	0
 	.align L1_CACHE_SHIFT
-
 ENTRY(__tegra_cpu_reset_handler_end)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index dc558892753c..b02ae7699842 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "irammap.h"
@@ -89,6 +90,8 @@ static void __init tegra_cpu_reset_handler_enable(void)
 
 void __init tegra_cpu_reset_handler_init(void)
 {
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] =
+		trusted_foundations_registered();
 
 #ifdef CONFIG_SMP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 9c479c7925b8..db0e6b3097ab 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -25,7 +25,11 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_DATA_SIZE		6
+#define TEGRA_RESET_RESETTABLE_STATUS	6
+#define TEGRA_RESET_TF_PRESENT		7
+#define TEGRA_RESET_DATA_SIZE		8
+
+#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
 #ifndef __ASSEMBLY__
 
@@ -49,7 +53,8 @@ void __tegra_cpu_reset_handler_end(void);
 	 (u32)__tegra_cpu_reset_handler_start)))
 #define tegra20_cpu1_resettable_status \
 	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
-	 (u32)__tegra20_cpu1_resettable_status_offset))
+	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_RESETTABLE_STATUS] - \
+	 (u32)__tegra_cpu_reset_handler_start)))
 #endif
 
 #define tegra_cpu_reset_handler_offset \
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 5c8e638ee51a..11f423e4a263 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -28,6 +28,7 @@
 #include <asm/cache.h>
 
 #include "irammap.h"
+#include "reset.h"
 #include "sleep.h"
 
 #define EMC_CFG				0xc
@@ -54,6 +55,9 @@
 #define APB_MISC_XM2CFGCPADCTRL2	0x8e4
 #define APB_MISC_XM2CFGDPADCTRL2	0x8e8
 
+#define __tegra20_cpu1_resettable_status_offset \
+	(__tegra_cpu_reset_handler_data_offset + RESET_DATA(RESETTABLE_STATUS))
+
 .macro pll_enable, rd, r_car_base, pll_base
 	ldr	\rd, [\r_car_base, #\pll_base]
 	tst	\rd, #(1 << 30)
-- 
2.17.1

