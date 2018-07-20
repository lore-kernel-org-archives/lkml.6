Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD3AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FAF205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhoM4JB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FAF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeGTPA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:00:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43672 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeGTPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:00:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id m12-v6so1911252lfc.10;
        Fri, 20 Jul 2018 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=acFZK/7X6j4muzxldI+NoMpYw/NvtTNePa1EpMQF1fA=;
        b=jhoM4JB+tz6yvxVo+lKb7Hhn9NiCvHVyXAcvK328Xs7kXKcjMoQmIQr5d/nw7Mjo5l
         cDGnJwTYLCCHlQUTL6XeYaeyjVdP/ZDdE82Y7Btkztt1r3i5LmBMimoSL6brXkQYAfDF
         2cXS/m6994Tu19mDJzx+AGB1BbTRD4RzsUyxl2AeVmM2GynKkHLK+62Yg99/2ubtAFE6
         0/5Mov+MkSQtb4Fzgna52KtKJ0o0ukYhXTsFRf33NIZfYQV1xpJD7bB6UuVO99lpOedM
         9pDULRndicQIwTxmovCwWNGOpY7LlAiyUA+XjZqSVcOR20x1NPayjZDZGIvyx1Twoh38
         fKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=acFZK/7X6j4muzxldI+NoMpYw/NvtTNePa1EpMQF1fA=;
        b=d0U06xQI8nm5zll/30Hzige/qiOh6KfzxyiRnODQBJPx5C1E3KAQlL4/qvuSjnZtXN
         CxzJ7NBFj6wJni3/NNaK6u8aE+BwexgNpGd2lbBDA6h6opscwf3DMvwQKllowkv3Lgen
         jcUuMaHHPWp7A/uV8Jd9ULCgMuOVBWQWsLBJLbjYAgJ9/no/7yVETBnexOY013vMOrl1
         mj+FI2w98obAnZSVhwG+L5nmQXWkNysFVVYI3CxIbZNdx9e7Da/MKa+sTUpezA2q6n03
         d1nGydtmRR4eT0ITkUOpg7P0ZI8G6yXWgLaqOnMmGZeZzziSz6aFcM6eBoZt6DOcEfGP
         ysmw==
X-Gm-Message-State: AOUpUlHr0BAvwvjX+r3Mi036gNOBoECLFkRFan9ckqBSYzQ9iZyzemVn
        SqH5c6zmWhGKQF9XX9uppVVnvghG
X-Google-Smtp-Source: AAOMgpecQC0Z0auppx9LTZ/JThqpcmnkBD3CBvsM+Ke/3NUDWcB/dJ8CPyYkYqQJqvuBEqpkh1ieAg==
X-Received: by 2002:a19:1b07:: with SMTP id b7-v6mr1551958lfb.32.1532095945031;
        Fri, 20 Jul 2018 07:12:25 -0700 (PDT)
Received: from localhost.localdomain ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id a16-v6sm385342ljj.28.2018.07.20.07.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 07:12:24 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH] ARM: OMAP1: Make OMAP15xx MPUIO based GPIO device optional
Date:   Fri, 20 Jul 2018 16:12:47 +0200
Message-Id: <20180720141247.32214-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least one OMAP15xx based board - Amstrad Delta - makes other use
than simple GPIO of OMAP1 MPUIO port.  Since the port is registered
unconditionally at postcore_initcall as "omap_gpio" platform device,
hence occupied by gpio-omap driver, other device driver has no chance
to request its I/O memory resources successfully and may either fail or
proceed without having those resources reserved.
See commit b027274d2e3a ("mtd: ams-delta: fix request_mem_region()
failure") for details.

Even if it's theoretically possible to perform data I/O on the MPUIO
port with help of gpiod_*_array_*() functions, that additional layer
adds too much overhead for a relatively low powerful OMAP15xx machine.
One possible workaround providing acceptable performance would be to
use GPIO chip callbacks directly but that approach hasn't been
accepted.

Instead of inventing a widely acceptable new API for affected driver to
get efficient access to the port over the gpio-omap driver, make
registration of gpio-omap platform device optional for that port.
Boards are then free to decide if they need it as a GPIO device and can
call its initialization, or can assign the port resources to another
device.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-generic.c   | 2 ++
 arch/arm/mach-omap1/board-innovator.c | 7 ++++++-
 arch/arm/mach-omap1/board-palmte.c    | 2 ++
 arch/arm/mach-omap1/board-palmtt.c    | 2 ++
 arch/arm/mach-omap1/board-palmz71.c   | 2 ++
 arch/arm/mach-omap1/board-sx1.c       | 2 ++
 arch/arm/mach-omap1/common.h          | 3 +++
 arch/arm/mach-omap1/gpio15xx.c        | 6 +++++-
 8 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index 9708629f8c5f..3f812061095e 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -55,6 +55,8 @@ static void __init omap_generic_init(void)
 {
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap15xx()) {
+		omap15xx_mpuio_init();
+
 		/* mux pins for uarts */
 		omap_cfg_reg(UART1_TX);
 		omap_cfg_reg(UART1_RTS);
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 8c286a29f24b..33b74efe3352 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -373,8 +373,13 @@ static inline void innovator_mmc_init(void)
 
 static void __init innovator_init(void)
 {
-	if (cpu_is_omap1510())
+#ifdef CONFIG_ARCH_OMAP15XX
+	if (cpu_is_omap1510()) {
+		omap15xx_mpuio_init();
+
 		omap1510_fpga_init_irq();
+	}
+#endif
 	innovator_init_smc91x();
 
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 2dc5deb19803..b8620e4a2958 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -210,6 +210,8 @@ static void __init palmte_misc_gpio_setup(void)
 
 static void __init omap_palmte_init(void)
 {
+	omap15xx_mpuio_init();
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index a23327682df0..20ab494f20c5 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -256,6 +256,8 @@ static void __init omap_mpu_wdt_mode(int mode) {
 
 static void __init omap_palmtt_init(void)
 {
+	omap15xx_mpuio_init();
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 30b07096197b..5d468111f681 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -268,6 +268,8 @@ palmz71_gpio_setup(int early)
 static void __init
 omap_palmz71_init(void)
 {
+	omap15xx_mpuio_init();
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index ec27bb3e370f..bbea85943b3b 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -311,6 +311,8 @@ static struct platform_device *sx1_devices[] __initdata = {
 
 static void __init omap_sx1_init(void)
 {
+	omap15xx_mpuio_init();
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index c6537d2c2859..72551c850197 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -95,6 +95,9 @@ static inline int __init omap_32k_timer_init(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP15XX
+extern void omap15xx_init_mpuio(void);
+#endif
 #ifdef CONFIG_ARCH_OMAP16XX
 extern int ocpi_enable(void);
 #else
diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 312a0924d786..d4c8d257d14d 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -115,9 +115,13 @@ static int __init omap15xx_gpio_init(void)
 	if (!cpu_is_omap15xx())
 		return -EINVAL;
 
-	platform_device_register(&omap15xx_mpu_gpio);
 	platform_device_register(&omap15xx_gpio);
 
 	return 0;
 }
 postcore_initcall(omap15xx_gpio_init);
+
+void __init omap15xx_mpuio_init(void)
+{
+	platform_device_register(&omap15xx_mpu_gpio);
+}
-- 
2.16.4

