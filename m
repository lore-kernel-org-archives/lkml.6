Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA9F2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOZmj5tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA9F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGQL5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:57:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36066 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbeGQL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:57:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id d14-v6so365959pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PTtFId+Y0EEs5+cllmvrMc/Z4BBjEeLBQmZE8Amw2Fs=;
        b=JOZmj5tuLw2cxLCnpI93zZTUwIZv+Z6685Ga82IC6HSk74uIe9xTOqwuzOyXsLSjou
         fsmqRX7gwVUtXjilC31ujon5hxjxqfgB2ixE9ovqN0eT30OQPGbs1Fkgq35QPrRq4bJH
         TpSOMbdHUxnKMGuMWbEN7UnGEGRSCyN2EVND0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PTtFId+Y0EEs5+cllmvrMc/Z4BBjEeLBQmZE8Amw2Fs=;
        b=s45kG2OP69UDic/H6eOVX+GNV3mQTW3Jv8MBzb1GJA0lFAVtbOwPT0kDyEMd8kxLQf
         abQijsMU99M70KjGtJbxb09GDNjeBhpmMSFeRxX88pzZ+8ZxgBHkXFpJvgcl8lQrdMJW
         oWLFEDfO/+kRhqw6G68eAGwN7f+KWEQ7RqrJFdRQ44txSGe1i3OrJ7Jm9qg+z3JtcUdU
         caWYa1SRbLSC/W+qEBUAsT5dwRpQKT80lEBBcLdVrIIGORUObZjfBatahMoog4A0ygRe
         hT86Vu7fwnG0EoDP8CMeEsEpZATT3bIthxYnrJnPAYd9EEAbKAxzgpoZJ0CriLGEvwrD
         fIeA==
X-Gm-Message-State: AOUpUlGzKI2eZXS8Jy6z0v+bmk44xxwX/nSec3xCYSmXIe3i9w3DweM8
        d2s/09rjSfxavtYyQPBBOQK9XQ==
X-Google-Smtp-Source: AAOMgpd3cR8UU01Pr4HkKwTDERGOtcxKrxLiHloBiGKjtGNa1Ek4VOznh0chC0jeIQ++XB2DlSd4Pg==
X-Received: by 2002:a65:614a:: with SMTP id o10-v6mr1151025pgv.387.1531826713954;
        Tue, 17 Jul 2018 04:25:13 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y3-v6sm1391207pge.29.2018.07.17.04.25.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 04:25:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org, corbet@lwn.net
Cc:     baolin.wang@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/4] sh: sh03: rtc: push down rtc class ops into driver
Date:   Tue, 17 Jul 2018 19:24:25 +0800
Message-Id: <c2862178b063b9a9d5a62a732de61c2963ce989a.1531826106.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dreamcast RTC support has an extra level of indirection to
provide either the old read_persistent_clock/update_persistent_clock
interface or the rtc-generic device for hctosys/systohc.

By removing the indirection and always using the RTC_CLASS interface,
we can avoid the lossy double conversion between rtc_time and timespec,
so we end up supporting the entire range of 'year' values, and clarifying
the rtc_set_time callback.

I did not change the behavior of sh03_rtc_settimeofday(), which keeps
just updating the seconds/minutes by calling set_rtc_mmss(), this
could be improved if anyone cares. Also, the file should ideally be
moved into drivers/rtc and not use rtc-generic.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/sh/boards/mach-sh03/Makefile |    3 ++-
 arch/sh/boards/mach-sh03/rtc.c    |   51 ++++++++++++++++++++++---------------
 arch/sh/boards/mach-sh03/setup.c  |    9 -------
 arch/sh/configs/sh03_defconfig    |    2 ++
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/sh/boards/mach-sh03/Makefile b/arch/sh/boards/mach-sh03/Makefile
index 400306a..47007a3 100644
--- a/arch/sh/boards/mach-sh03/Makefile
+++ b/arch/sh/boards/mach-sh03/Makefile
@@ -2,4 +2,5 @@
 # Makefile for the Interface (CTP/PCI-SH03) specific parts of the kernel
 #
 
-obj-y	 := setup.o rtc.o
+obj-y	 := setup.o
+obj-$(CONFIG_RTC_DRV_GENERIC) += rtc.o
diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index dc3d50e..8b23ed7 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -13,8 +13,9 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
-#include <asm/io.h>
-#include <asm/rtc.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
 
 #define RTC_BASE	0xb0000000
 #define RTC_SEC1	(RTC_BASE + 0)
@@ -38,7 +39,7 @@
 
 static DEFINE_SPINLOCK(sh03_rtc_lock);
 
-unsigned long get_cmos_time(void)
+static int sh03_rtc_gettimeofday(struct device *dev, struct rtc_time *tm)
 {
 	unsigned int year, mon, day, hour, min, sec;
 
@@ -75,17 +76,18 @@ unsigned long get_cmos_time(void)
 	}
 
 	spin_unlock(&sh03_rtc_lock);
-	return mktime(year, mon, day, hour, min, sec);
-}
 
-void sh03_rtc_gettimeofday(struct timespec *tv)
-{
+	tm->tm_sec  = sec;
+	tm->tm_min  = min;
+	tm->tm_hour = hour;
+	tm->tm_mday = day;
+	tm->tm_mon  = mon;
+	tm->tm_year = year - 1900;
 
-	tv->tv_sec = get_cmos_time();
-	tv->tv_nsec = 0;
+	return 0;
 }
 
-static int set_rtc_mmss(unsigned long nowtime)
+static int set_rtc_mmss(struct rtc_time *tm)
 {
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
@@ -97,8 +99,8 @@ static int set_rtc_mmss(unsigned long nowtime)
 		if (!(__raw_readb(RTC_CTL) & RTC_BUSY))
 			break;
 	cmos_minutes = (__raw_readb(RTC_MIN1) & 0xf) + (__raw_readb(RTC_MIN10) & 0xf) * 10;
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
+	real_seconds = tm->tm_sec;
+	real_minutes = tm->tm_min;
 	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
 		real_minutes += 30;		/* correct for half hour time zone */
 	real_minutes %= 60;
@@ -112,22 +114,31 @@ static int set_rtc_mmss(unsigned long nowtime)
 		printk_once(KERN_NOTICE
 		       "set_rtc_mmss: can't update from %d to %d\n",
 		       cmos_minutes, real_minutes);
-		retval = -1;
+		retval = -EINVAL;
 	}
 	spin_unlock(&sh03_rtc_lock);
 
 	return retval;
 }
 
-int sh03_rtc_settimeofday(const time_t secs)
+int sh03_rtc_settimeofday(struct device *dev, struct rtc_time *tm)
 {
-	unsigned long nowtime = secs;
-
-	return set_rtc_mmss(nowtime);
+	return set_rtc_mmss(tm);
 }
 
-void sh03_time_init(void)
+static const struct rtc_class_ops rtc_generic_ops = {
+	.read_time = sh03_rtc_gettimeofday,
+	.set_time = sh03_rtc_settimeofday,
+};
+
+static int __init sh03_time_init(void)
 {
-	rtc_sh_get_time = sh03_rtc_gettimeofday;
-	rtc_sh_set_time = sh03_rtc_settimeofday;
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
+					     &rtc_generic_ops,
+					     sizeof(rtc_generic_ops));
+
+	return PTR_ERR_OR_ZERO(pdev);
 }
+arch_initcall(sh03_time_init);
diff --git a/arch/sh/boards/mach-sh03/setup.c b/arch/sh/boards/mach-sh03/setup.c
index 85e7059..3901b60 100644
--- a/arch/sh/boards/mach-sh03/setup.c
+++ b/arch/sh/boards/mach-sh03/setup.c
@@ -22,14 +22,6 @@ static void __init init_sh03_IRQ(void)
 	plat_irq_setup_pins(IRQ_MODE_IRQ);
 }
 
-/* arch/sh/boards/sh03/rtc.c */
-void sh03_time_init(void);
-
-static void __init sh03_setup(char **cmdline_p)
-{
-	board_time_init = sh03_time_init;
-}
-
 static struct resource cf_ide_resources[] = {
 	[0] = {
 		.start  = 0x1f0,
@@ -101,6 +93,5 @@ static int __init sh03_devices_setup(void)
 
 static struct sh_machine_vector mv_sh03 __initmv = {
 	.mv_name		= "Interface (CTP/PCI-SH03)",
-	.mv_setup		= sh03_setup,
 	.mv_init_irq		= init_sh03_IRQ,
 };
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 2156223..489ffdf 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -130,3 +130,5 @@ CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_DEFLATE=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GENERIC=y
-- 
1.7.9.5

