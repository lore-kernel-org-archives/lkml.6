Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45118C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A7120700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsIWcPQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBVTgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:36:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36065 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBVTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:36:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id k2so1540018plt.3;
        Fri, 22 Feb 2019 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrdurJIx2ld6iD2HW3AERYM3O3FQwL4YTObVlgwwugY=;
        b=QsIWcPQXAzbb6uZrfIis+xBs77qjr0BU+D0w07M5eQQYqp2M//xMcU5g96MOELlN17
         WEhzsTB+lySILZx3VD4NM8f6mi3P4ed++C7Akex+/b4rqB9RVS4Thd6tBqzq2Vhhoyz9
         L76AhYVT5BaW56uwHiFEvv/I7Pl14lRYL+xCefOrO2K/Y/hHOu75+aTcuxLAJbUCvx1L
         KY62NVZCG4RvelkCBW1oZJ2e3FCgEpxkxN7Vh+ZCbwZC18ekoqMOZ954ch902VpaRVwA
         FRd3fEdsd4jlyyu8UCNe9XfvbJkQ1feUmAuBcGDaarauYIxV3G88mCWsCBwXyPSSxDRE
         2CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrdurJIx2ld6iD2HW3AERYM3O3FQwL4YTObVlgwwugY=;
        b=RxpjcNoG7ZJdeOMcj+yksnpupOawugALXpqbW/WXsUUfqFNQXim+CKlMSE0Q2Uy+T/
         Js3vN74axkUhfjo6xwrRGnkpVryKlHWn/4IsVN0oAaVAz6YP2EJw8GmWde+JvRLekr1O
         9M+UWkem0cgFH/whzi2sBZrod6TkcxV/WW/NxtIIVT6FMXJvmTDMh5zVqMUVTn+xR1wZ
         PQKm0t7Bkzkln0vvxncr+7D7IQ+YE7uqscU8BCti45NRKLslZ6uY08efwJqZ1Bzs+s/c
         UN7PPirw97A4bJ6LUX+ZQJtyiOXO3CVm2My0unO90dQVbhJDVQqSY1HxVmFekEtTDyQ8
         URHg==
X-Gm-Message-State: AHQUAuaNgrmNO0VG1TwlbAPHaAq6op9UmQ/2VK1bvPfKuTWhKEO6A4vX
        Z6oT4LLZNMUJdRZJ1ARau3k=
X-Google-Smtp-Source: AHgI3Ia7hqgW/kb9OTCGGT3iuulY64/F+vtW0SruFmUxap4EncdfxbUcxjoZaBybhy6gnjvpr2TmIw==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr5598889pla.19.1550864161588;
        Fri, 22 Feb 2019 11:36:01 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:36:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/7] ARM: tegra: Don't apply CPU erratas in insecure mode
Date:   Fri, 22 Feb 2019 22:34:24 +0300
Message-Id: <20190222193426.10747-6-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU isn't allowed to touch secure registers while running under secure
monitor. Hence skip applying of CPU erratas in the reset handler if
Trusted Foundations firmware presents.

Partially based on work done by Michał Mirosław [1].

[1] https://www.spinics.net/lists/arm-kernel/msg594768.html

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 23 ++++++++++++-----------
 arch/arm/mach-tegra/reset.c         |  3 +++
 arch/arm/mach-tegra/reset.h         |  9 +++++++--
 arch/arm/mach-tegra/sleep-tegra20.S |  4 ++++
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..6bea95d165fa 100644
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
+	ldr	r5, [r12, #RESET_DATA(TF_PRESENT)]
+	cmp	r5, #0
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
 
@@ -277,14 +279,13 @@ ENDPROC(__tegra_cpu_reset_handler)
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
index dedeebfccc55..50d51d3465f6 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -28,6 +28,7 @@
 #include <asm/cache.h>
 
 #include "irammap.h"
+#include "reset.h"
 #include "sleep.h"
 
 #define EMC_CFG				0xc
@@ -53,6 +54,9 @@
 #define APB_MISC_XM2CFGCPADCTRL2	0x8e4
 #define APB_MISC_XM2CFGDPADCTRL2	0x8e8
 
+#define __tegra20_cpu1_resettable_status_offset \
+	(__tegra_cpu_reset_handler_data_offset + RESET_DATA(RESETTABLE_STATUS))
+
 .macro pll_enable, rd, r_car_base, pll_base
 	ldr	\rd, [\r_car_base, #\pll_base]
 	tst	\rd, #(1 << 30)
-- 
2.20.1

