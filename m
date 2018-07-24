Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA181C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C80620685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C80620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbeGXWpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:45:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36132 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeGXWpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:45:17 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MgDvl-1fKlD52hBF-00NVMy; Tue, 24 Jul 2018 23:36:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     dalias@libc.org
Cc:     ysato@users.sourceforge.jp, baolin.wang@linaro.org,
        y2038@lists.linaro.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 3/4] sh: remove unused rtc_sh_get/set_time infrastructure
Date:   Tue, 24 Jul 2018 23:36:23 +0200
Message-Id: <20180724213624.3899336-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724213624.3899336-1-arnd@arndb.de>
References: <20180724213624.3899336-1-arnd@arndb.de>
X-Provags-ID: V03:K1:U1Qrjj1bkxg0qF4o5IC8qmsI3joJaEm+yz4arZrc83Qq402sChO
 TuyW69VJb102RT0/BB13urqwiQkhI1cD4cM7GC9IxZaUEYO9PQ41tivMFlbfALICIELImAy
 3dj5lSRuG9CJsO0T8qzSHrB1maMFUCHcbEFGpJCEVw3V/cbnjZADRq5xq6KKgCE6eWBsl9m
 dzklb5DVhoFBRJPwR5+Zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LmUWx6R57Z8=:E8k7JeGgQCLaJB5o8Etzif
 3WGRy5abn8W1tu4EqaAFXrwmIvnkDWKmz4T0h+AeMNzblegzflllLxVxfnhdb0jh0qJFXVKr9
 QuRukRMbBsvlYHzze9hmm+XvBQDz3p7mJ5h6IHk4651BBzATqoZvXnI5aXlzvJa7oO8vvsojt
 yQ/8S7+HgnEKGJ2f032gU3nfBExTnSBYB/P3DOBTsWdWdIl7tvJX1HAwywrVLfi9Xfrn4AxQO
 LN8Ahi5H9zQ8XvbZb0c9FCmIvV4+V9nDh3nzMN1xaNXNwielmm1vIMcZn/SH/r/ZkAI6Rt4pb
 T7ku/lAwcTJ9f8qm/ujee0yrXzSSQj6p1dwuOlNca64HOdgdYGpbqi6e/Ol7OCQBDKesEGEbM
 L0hh04kcDg59BcnlANw/mu64IMXqV9BvoYeMLvwl/8mny4d4tAfxEwPtGAJNG+Vo1DgkcANAm
 XNmbkgrAG8+qQvR2nPZQH0YP8J718Zn10Z1Ht/vFRx0wd4n1eR+pw4kJr0Abam5lFJ/B9il78
 N09uZ/NL4YH40pU3haBDyuoEPLfuOaydjcxYap18jhLemhZl7YD2t0IUxPmscMYLvYWBKjeQ3
 VCNyhS1iJeA7nZysWYffLFHPYZ6hyINwTCnKBufKeDwYuQVKIOf1tbzrO9SctWlcNRhnaJkpC
 qsToOxZ9Wn5NQ9CaK36rxBJWQhKSDLngsQCqACB5cDy9+aBiXHJbNAuDUfki4if+CsHo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platforms are now converted to RTC drivers, so this has become
obsolete. The board_time_init() callback still has one caller, but
could otherwise also get killed.

This removes one more usage of the deprecated timespec structure,
which overflows in y2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/rtc.h |  2 --
 arch/sh/kernel/time.c     | 69 ---------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index c63555ee1255..fe55fbb181aa 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -4,8 +4,6 @@
 
 void time_init(void);
 extern void (*board_time_init)(void);
-extern void (*rtc_sh_get_time)(struct timespec *);
-extern int (*rtc_sh_set_time)(const time_t);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41977d1..eb0a91270499 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,75 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-/* Dummy RTC ops */
-static void null_rtc_get_time(struct timespec *tv)
-{
-	tv->tv_sec = mktime(2000, 1, 1, 0, 0, 0);
-	tv->tv_nsec = 0;
-}
-
-static int null_rtc_set_time(const time_t secs)
-{
-	return 0;
-}
-
-void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
-int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
-
-void read_persistent_clock(struct timespec *ts)
-{
-	rtc_sh_get_time(ts);
-}
-
-#ifdef CONFIG_GENERIC_CMOS_UPDATE
-int update_persistent_clock(struct timespec now)
-{
-	return rtc_sh_set_time(now.tv_sec);
-}
-#endif
-
-static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
-{
-	struct timespec tv;
-
-	rtc_sh_get_time(&tv);
-	rtc_time_to_tm(tv.tv_sec, tm);
-	return 0;
-}
-
-static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-{
-	unsigned long secs;
-
-	rtc_tm_to_time(tm, &secs);
-	if ((rtc_sh_set_time == null_rtc_set_time) ||
-	    (rtc_sh_set_time(secs) < 0))
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
-static const struct rtc_class_ops rtc_generic_ops = {
-	.read_time = rtc_generic_get_time,
-	.set_time = rtc_generic_set_time,
-};
-
-static int __init rtc_generic_init(void)
-{
-	struct platform_device *pdev;
-
-	if (rtc_sh_get_time == null_rtc_get_time)
-		return -ENODEV;
-
-	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
-					     &rtc_generic_ops,
-					     sizeof(rtc_generic_ops));
-
-
-	return PTR_ERR_OR_ZERO(pdev);
-}
-device_initcall(rtc_generic_init);
-
 void (*board_time_init)(void);
 
 static void __init sh_late_time_init(void)
-- 
2.18.0

