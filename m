Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pC/0LRoSHluXVgAAmS7hNA
	; Mon, 11 Jun 2018 06:09:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A09A960792; Mon, 11 Jun 2018 06:09:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="NALVgYoN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D0306605A5;
	Mon, 11 Jun 2018 06:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0306605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeFKGJr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:09:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32856 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbeFKGJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:09:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so14326328wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YNeDPIYG4vrf7/2PVcwWEVdDAMM99rCp4a/88SmbO/8=;
        b=NALVgYoNTG09BtzUyTPqdFWeN2s+z0YLnGUHXbEUvLXVpPehtLfzAdSASmveIhmG7y
         o8xqfPEV3Ug0BTuehgUiT3cyu0CAu4wve0v1BQ5WbUO3pVrz7qpa0bfhahlMw08MvmCn
         8kw3d7immEfn2CHyFGAG4GC5ANU3iW2k8PtNqFYp4kXgvfYDZBgt6tJ6vsMik79pGgUd
         Zp5jmcVARi6EhxnJ1ZOgJ98Z/GTTsJAilz0Brr1qU1rK4zwtdJfN3QRf7yFNKQW/pyLn
         F//v531XQsK7X0EqIRLZaefIMDiiia9R7dWlKaYwEsbDGrodtwGQROCjqH1ZjcPVfAmu
         u6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=YNeDPIYG4vrf7/2PVcwWEVdDAMM99rCp4a/88SmbO/8=;
        b=Gv8zlEXOnR+UcUvUwq+zJu5S7eSMRhT2CWCaZ76pZOy31USkGo0fev5SAllJrJ1tQu
         LRcle8r+6JRzVXTXcaulZqUTRnQzdug0GKUiGvvAqDTyp0USfhSxasuRD/Ek1ZXaBSzj
         fVPpsmQiW3RQSczWLc9zoEWXCQP69ILiLffPOcD+rhCBdD59VRcvJIuxq2+OW2byAW5X
         NbBKgZEw1LRjd4qaIMCBbPO2PmyGIdD1cwlap1bFmOo/A6WNt64fomFvuJQTHV0lOE00
         KfqtPW1jNa1vR5FgzJafgW1YWi/GrFqBG7MraH5YAI1iuKQ82kax6sFBJ1DAC1CgdLMl
         KGLg==
X-Gm-Message-State: APt69E0cugumB+xlpnJsAdVYJ2I4ayf6e146qUcXETHiLjoE6WsnaAkl
        k7WJ4atMsrJ/61BEhb7n1GjvhUDG
X-Google-Smtp-Source: ADUXVKKeHykS1V1PddtKQFnQEIYB3t7ea7MNzIRTqyqg2EjoGfoiqilgZacenxz+kUOrb2NPkPZy1w==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr7024770wme.159.1528697384022;
        Sun, 10 Jun 2018 23:09:44 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c10-v6sm27557523wrs.6.2018.06.10.23.09.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 10 Jun 2018 23:09:43 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] microblaze: Remove architecture heart beat code
Date: Mon, 11 Jun 2018 08:09:39 +0200
Message-Id: <84075652e978661247d71f84de46efd827869948.1528697370.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to keep this gpio based code in architecture. Use
ledtrig-heartbeat.c instead which is much more flexible then this
ancient code.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/Kconfig.debug       |  7 ----
 arch/microblaze/include/asm/setup.h |  3 --
 arch/microblaze/kernel/Makefile     |  2 --
 arch/microblaze/kernel/heartbeat.c  | 72 -------------------------------------
 arch/microblaze/kernel/timer.c      |  7 ----
 5 files changed, 91 deletions(-)
 delete mode 100644 arch/microblaze/kernel/heartbeat.c

diff --git a/arch/microblaze/Kconfig.debug b/arch/microblaze/Kconfig.debug
index 331a3bb66297..93a737c8d1a6 100644
--- a/arch/microblaze/Kconfig.debug
+++ b/arch/microblaze/Kconfig.debug
@@ -8,11 +8,4 @@ config TRACE_IRQFLAGS_SUPPORT
 
 source "lib/Kconfig.debug"
 
-config HEART_BEAT
-	bool "Heart beat function for kernel"
-	default n
-	help
-	  This option turns on/off heart beat kernel functionality.
-	  First GPIO node is taken.
-
 endmenu
diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index d5384f6f36f7..a38e4a56e3c6 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -19,9 +19,6 @@
 
 extern char *klimit;
 
-void microblaze_heartbeat(void);
-void microblaze_setup_heartbeat(void);
-
 #   ifdef CONFIG_MMU
 extern void mmu_reset(void);
 #   endif /* CONFIG_MMU */
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 7e99cf6984a1..3a53378d66d9 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -8,7 +8,6 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_timer.o = -pg
 CFLAGS_REMOVE_intc.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
-CFLAGS_REMOVE_heartbeat.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
@@ -22,7 +21,6 @@ obj-y += dma.o exceptions.o \
 
 obj-y += cpu/
 
-obj-$(CONFIG_HEART_BEAT)	+= heartbeat.o
 obj-$(CONFIG_MODULES)		+= microblaze_ksyms.o module.o
 obj-$(CONFIG_MMU)		+= misc.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/microblaze/kernel/heartbeat.c b/arch/microblaze/kernel/heartbeat.c
deleted file mode 100644
index 2022130139d2..000000000000
--- a/arch/microblaze/kernel/heartbeat.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2006 Atmark Techno, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/sched.h>
-#include <linux/sched/loadavg.h>
-#include <linux/io.h>
-
-#include <asm/setup.h>
-#include <asm/page.h>
-#include <asm/prom.h>
-
-static unsigned int base_addr;
-
-void microblaze_heartbeat(void)
-{
-	static unsigned int cnt, period, dist;
-
-	if (base_addr) {
-		if (cnt == 0 || cnt == dist)
-			out_be32(base_addr, 1);
-		else if (cnt == 7 || cnt == dist + 7)
-			out_be32(base_addr, 0);
-
-		if (++cnt > period) {
-			cnt = 0;
-			/*
-			 * The hyperbolic function below modifies the heartbeat
-			 * period length in dependency of the current (5min)
-			 * load. It goes through the points f(0)=126, f(1)=86,
-			 * f(5)=51, f(inf)->30.
-			 */
-			period = ((672 << FSHIFT) / (5 * avenrun[0] +
-						(7 << FSHIFT))) + 30;
-			dist = period / 4;
-		}
-	}
-}
-
-void microblaze_setup_heartbeat(void)
-{
-	struct device_node *gpio = NULL;
-	int *prop;
-	int j;
-	const char * const gpio_list[] = {
-		"xlnx,xps-gpio-1.00.a",
-		NULL
-	};
-
-	for (j = 0; gpio_list[j] != NULL; j++) {
-		gpio = of_find_compatible_node(NULL, NULL, gpio_list[j]);
-		if (gpio)
-			break;
-	}
-
-	if (gpio) {
-		base_addr = be32_to_cpup(of_get_property(gpio, "reg", NULL));
-		base_addr = (unsigned long) ioremap(base_addr, PAGE_SIZE);
-		pr_notice("Heartbeat GPIO at 0x%x\n", base_addr);
-
-		/* GPIO is configured as output */
-		prop = (int *) of_get_property(gpio, "xlnx,is-bidir", NULL);
-		if (prop)
-			out_be32(base_addr + 4, 0);
-	}
-}
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index 7de941cbbd94..a6683484b3a1 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -156,9 +156,6 @@ static inline void timer_ack(void)
 static irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_xilinx_timer;
-#ifdef CONFIG_HEART_BEAT
-	microblaze_heartbeat();
-#endif
 	timer_ack();
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
@@ -318,10 +315,6 @@ static int __init xilinx_timer_init(struct device_node *timer)
 		return ret;
 	}
 
-#ifdef CONFIG_HEART_BEAT
-	microblaze_setup_heartbeat();
-#endif
-
 	ret = xilinx_clocksource_init();
 	if (ret)
 		return ret;
-- 
1.9.1
