Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E5FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706B620868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706B620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeLGNt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:27 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:46707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeLGNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0nvJ-1hRtT448Jx-00wjPT; Fri, 07 Dec 2018 14:49:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/8] sh: remove board_time_init() callback
Date:   Fri,  7 Dec 2018 14:48:20 +0100
Message-Id: <20181207134824.300024-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:9cuu4JV5QuwVw4x8eeXazgYWnfEJ9oe/85wD/FKz/VcRZRdCSqK
 ElfJ/ve9XcqBnx8BJyqiIsEB57Wug3fBiIUqBgeyRuMmHae5DKo5CdofMexzR8FsOWhHa/C
 EjghrLhfcfrp/jtnerIg1AnC9LMoSRmYOqGl3AItOiIUhn15j2w0ZGlQjqMnuJtLEVL/HCN
 kuxanGlosS2WHSYnKsDOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CpuypnIsk1E=:I+aRj2VUC3orR51voR46Pa
 RhWJBjhLxLzXJNlt9H9QsNLhgskLJotLc/rJIjAZjfrKGmMkFoW9EAuZl0cuvuAhH1R7trSGY
 qLnr6/vWB1/6p4Xh2tQ2H0nrL4zfX4ioL2KmNhh86rnA81trWUDL1WtSN6diXW9EhYVLZ1x+5
 7ThXc0IchLzNHteYA3v5xElRw5DQJCbb5JbBv7Pa0c8l1XqmaZMKHY2rwU78SQ8ADfqs7jMOd
 QTUYsw7qAp6U2cAoxV+c+VkAQChQghKAM+aEezHE9rq5laNHFUAxpL3q784tB2GocWZmqjckR
 H60NXiStBaqjSyR4x0jRVJuh4gGpaEhg/mKh8Ww23Ra64OcQqn1kb5y9zt36AjtHdUqfPDLP9
 iMMl7WVWnrLLl6sc6jHFtGCNPOlonsl8xRkkLScUCd2xyOE+lAhOGVI7qeu8zWIyEoM9jS6eH
 NFY6GXpy/aBzoafjUU82psfGvRhVoPyHV8EBuxtkUyn8s3QdtYYom5Rgq3/SoS4A7HVYULBE3
 kVphO9KSWozzlz5ooV84BLdhItX+ZoqNK23E2dbOM+KQbAaFPOZJwJiA9TzjIsv+V6cwJtYsB
 ZxVvahuuDypyVKG3hOMxVa1hxQbR2GxGDoUao1JoyM7goalikGhm8ReJFTsHv0b5mFoisvy5G
 r89w+y98oEE3gFrVbrOFMPwYwHncgflkhFZN9RP9zW5JcvGi5i9fEFOMd+5K8lu/Hp1PY4MQw
 z/I2bXsHgiIqjgb5RxBPYY0mDU0o5MGvUmDKag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only remaining user of board_time_init() is the of-generic
machine, and that just calls the global timer_init() function.
Calling that one has no effect on non-DT platforms, so we can
simply call it unconditionally in place of board_time_init().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/sh/new-machine.txt | 8 --------
 arch/sh/boards/of-generic.c      | 8 --------
 arch/sh/include/asm/rtc.h        | 1 -
 arch/sh/kernel/time.c            | 5 +----
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.txt
index f0354164cb0e..e0961a66130b 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.txt
@@ -116,7 +116,6 @@ might look something like:
  * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
  */
 #include <linux/init.h>
-#include <asm/rtc.h> /* for board_time_init() */
 
 const char *get_system_type(void)
 {
@@ -132,13 +131,6 @@ int __init platform_setup(void)
 	 * this board.
 	 */
 
-  	/* 
-	 * Presume all FooTech boards have the same broken timer,
-	 * and also presume that we've defined foo_timer_init to
-	 * do something useful.
-	 */
-  	board_time_init = foo_timer_init;
-
 	/* Start-up imaginary PCI ... */
 
 	/* And whatever else ... */
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index cde370cad4ae..6e9786548ac6 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -117,18 +117,10 @@ static void __init sh_of_mem_reserve(void)
 	early_init_fdt_scan_reserved_mem();
 }
 
-static void __init sh_of_time_init(void)
-{
-	pr_info("SH generic board support: scanning for clocksource devices\n");
-	timer_probe();
-}
-
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
 
-	board_time_init = sh_of_time_init;
-
 	sh_mv.mv_name = "Unknown SH model";
 	root = of_find_node_by_path("/");
 	if (root) {
diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index fe55fbb181aa..69dbae2949b0 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -3,7 +3,6 @@
 #define _ASM_RTC_H
 
 void time_init(void);
-extern void (*board_time_init)(void);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index eb0a91270499..8a1c6c8ab4ec 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,8 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-void (*board_time_init)(void);
-
 static void __init sh_late_time_init(void)
 {
 	/*
@@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
 
 void __init time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
+	timer_probe();
 
 	clk_init();
 
-- 
2.18.0

