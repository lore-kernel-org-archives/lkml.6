Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A4AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F325A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F325A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLGNt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:27 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mv3I0-1hM8AV2JMm-00qw7W; Fri, 07 Dec 2018 14:48:59 +0100
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
Subject: [PATCH 3/8] sh: remove unused rtc_sh_get/set_time infrastructure
Date:   Fri,  7 Dec 2018 14:48:19 +0100
Message-Id: <20181207134824.300024-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ptjeVIj9pJisn+HaW1swv5AKqW7dc3s5a8wTDbLUJiUakNelqRd
 ke1RgFvGLb0EiX1wkfOnuCgToqapBlSI88L8VdFZ+FxT8KcharP3dOVcc02tAegIpebPed5
 0IBjHTW6ddjW4q0pixDVb+mWTOd9ae5RXfRJrESAYN0nbaOrdjnLVs4smk/2n8SGHGwK7Cs
 4bWAPjvAeXJyC4zHHNk+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GFdkd1pRCsM=:LEEf2ULtxxEAm0xDqCjU/n
 DGGXXO34JScu2d+ApJqTsz715016BvTEdJD7bRsnvZ8oxQnQfJkbmZBpHJXYcj2fnd8pcOpGH
 /wJ2vK4zya4DaExuK3nnNsz5+Berf5QQ02euOuYXWovFx+1ADg2G2T38e2bxHBovorlT9YDvu
 lWudnmcmCzKfBeb1w/PjFaRT8Pn47yFSJ8obIH2gQ2hQTwVLMi/A95qrUUl3AMl274sKb6HdF
 T/hwvWcxVRJiRf1j6+E5Y8mlZIOVSjH9q2Et8K6TymbA6+Z7Uv4SL3fbbc1u6X9jewAQa7yVb
 mQw3MH0+mlllXqbJ0vcPOQiH1Pnpg0p5BaK/B6owlYxT9bxyJBZ6QRYvUyoYqCw9bfhsU/SOZ
 swBNae1BDiRzYhlbgR1ty4th5+4AM7GGB8IMnaIE/9J9tKa/xk8uLNgxMk1D6yq/I2GwQkqqr
 c28swUoLffuRieAly6gksrRrhBuJr8sEpRKwpaDD4UTAPJaU/3DXZERWssn6MwLq4KnKfLud9
 LITXUD6m7gbzakwYxWQR8OCiTiyyBrG9ePBpBChl2maKjugdq0TY5D8a7SrTkw2rvPxsUZLmk
 2adHkLdjbqKxPvLEt7Xulrh7GJvXf3hXBCEZwDKSmFi/jVnOFNUze9VwV1FtHs0xhTvMcC6+r
 +UPTBIY/BeMl5jLKCygp5NSNpCsHEJ290h5edYVy3EKVQmdB0G2wz3rf0M1jNQtUBv+jtwx6e
 f27WiTIRZFJZGmCfApqe5mf+btJsLi18RUV9XA==
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

