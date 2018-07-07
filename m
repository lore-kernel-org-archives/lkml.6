Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A7C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97B6224D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXTo6fFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97B6224D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeGGFn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:43:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42057 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeGGFnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so3745803plr.9;
        Fri, 06 Jul 2018 22:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4uER1mCGp98ugwU9ohzLN36nmQ3UMVuSMSSmBfxBmA=;
        b=cXTo6fFez3BAv8OgXJXe5eNnxuWjkUk29gkMcW5nVorSffSRTECbLQBzd1RSRKCSx6
         +rWCjQ76hMOedn1tfJbjs9nypNek2cfTlhYKgr4+Pi9+U8zSSK2z5bt1yUbh/60c4Goc
         okvIy3otzooH2g+QtFTtdzzLvY3LTmywyeQ3WGr62aw9VafLB5He3hp0bS5uiNa7LMNL
         374gvrr9+3I6HKyxEnjfSUBWGaI8/8huQRjTNsFVayHw4M7ZCXj679oYxX1dPHkNj0Zu
         yI5WT/oWxy+8l7mCf63N3AdR45eLAvMLgiRx8C/xYUn+lPtXx787JCUjB4IWvEm65Nw3
         NUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4uER1mCGp98ugwU9ohzLN36nmQ3UMVuSMSSmBfxBmA=;
        b=c8SINNgFJ85nRmvpx3fHF/UaEiG7fzB50yEMB0Z1EhPazGEQmDVTYtK2sY/WGGpSXZ
         rr7NbmI8bX5BBueNt/xuSgcuW0yTBtr3CicAQ4qJxQkkpCCwUReLLFawsLbNOgyc0uuq
         VTzs5lhNyCk7BWMcK1zp9MPZ/M7iUqQgYS1IOs6Sj6fIeYQazfEZD5e0XhnaktSR9ipC
         2ZRxlUXEOJl4KZqZ9tCOersUCcacWIDypkvNwjiv7E+zme8m23xeoNDn5BoEODYOOtZy
         E12JZ3K43w2GjWFpeJUFRZY8T1zx17kGIeuGf7AlsA9UgxNIc3NEuDvAayxyAMGspd/d
         JvaA==
X-Gm-Message-State: APt69E1DIF5JctQCaYSuB6/peliTIc8ccKVVO3bcMma56yyN9d2PpbzJ
        Fg/GbeeZyrMAHntDhEr3IBI=
X-Google-Smtp-Source: AAOMgpciPlRDFTiRT9JVG+BmiEkQ1YsMQW9Ik46yzf05A9yGFHjL8GvFJlVn0s5FyKIkqOUlq/uO2w==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr9239586plb.210.1530942230550;
        Fri, 06 Jul 2018 22:43:50 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:49 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 4/7] timex: prepare compat helpers for y2038 changes
Date:   Fri,  6 Jul 2018 22:42:44 -0700
Message-Id: <20180707054247.19802-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707054247.19802-1-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct compat_timex to compat_time.h.
This is in line with other compat time structures that are planned
to be deprecated eventually.

Also enable compat_get/put_timex helpers unconditionally.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/compat.h |  8 ++++-
 include/linux/compat.h       | 33 -------------------
 include/linux/compat_time.h  | 34 +++++++++++++++++++
 kernel/compat.c              | 63 ------------------------------------
 kernel/time/time.c           | 63 ++++++++++++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 97 deletions(-)

diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
index 28819451b6d1..d2876f43484f 100644
--- a/include/asm-generic/compat.h
+++ b/include/asm-generic/compat.h
@@ -1,3 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/* This is an empty stub for 32-bit-only architectures */
+/* This is a stub for 32-bit-only architectures */
+
+#include <linux/types.h>
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index df45ee8413d6..2ee58590aeae 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -19,8 +19,6 @@
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
 
-#include <asm/compat.h>
-
 #ifdef CONFIG_COMPAT
 #include <asm/siginfo.h>
 #include <asm/signal.h>
@@ -136,37 +134,6 @@ struct compat_tms {
 	compat_clock_t		tms_cstime;
 };
 
-struct compat_timex {
-	compat_uint_t modes;
-	compat_long_t offset;
-	compat_long_t freq;
-	compat_long_t maxerror;
-	compat_long_t esterror;
-	compat_int_t status;
-	compat_long_t constant;
-	compat_long_t precision;
-	compat_long_t tolerance;
-	struct compat_timeval time;
-	compat_long_t tick;
-	compat_long_t ppsfreq;
-	compat_long_t jitter;
-	compat_int_t shift;
-	compat_long_t stabil;
-	compat_long_t jitcnt;
-	compat_long_t calcnt;
-	compat_long_t errcnt;
-	compat_long_t stbcnt;
-	compat_int_t tai;
-
-	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
-	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
-	compat_int_t:32; compat_int_t:32; compat_int_t:32;
-};
-
-struct timex;
-int compat_get_timex(struct timex *, const struct compat_timex __user *);
-int compat_put_timex(struct compat_timex __user *, const struct timex *);
-
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
 typedef struct {
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
index e70bfd1d2c3f..f04454e1b863 100644
--- a/include/linux/compat_time.h
+++ b/include/linux/compat_time.h
@@ -7,6 +7,9 @@
 
 typedef s32		compat_time_t;
 
+/* TODO: Move to linux/compat.h when this file is deleted. */
+#include <asm/compat.h>
+
 struct compat_timespec {
 	compat_time_t	tv_sec;
 	s32		tv_nsec;
@@ -22,11 +25,42 @@ struct compat_itimerspec {
 	struct compat_timespec it_value;
 };
 
+struct compat_timex {
+	compat_uint_t modes;
+	compat_long_t offset;
+	compat_long_t freq;
+	compat_long_t maxerror;
+	compat_long_t esterror;
+	compat_int_t status;
+	compat_long_t constant;
+	compat_long_t precision;
+	compat_long_t tolerance;
+	struct compat_timeval time;
+	compat_long_t tick;
+	compat_long_t ppsfreq;
+	compat_long_t jitter;
+	compat_int_t shift;
+	compat_long_t stabil;
+	compat_long_t jitcnt;
+	compat_long_t calcnt;
+	compat_long_t errcnt;
+	compat_long_t stbcnt;
+	compat_int_t tai;
+
+	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
+	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
+	compat_int_t:32; compat_int_t:32; compat_int_t:32;
+};
+
+
 extern int compat_get_timespec64(struct timespec64 *, const void __user *);
 extern int compat_put_timespec64(const struct timespec64 *, void __user *);
 extern int get_compat_itimerspec64(struct itimerspec64 *its,
 			const struct compat_itimerspec __user *uits);
 extern int put_compat_itimerspec64(const struct itimerspec64 *its,
 			struct compat_itimerspec __user *uits);
+struct timex;
+int compat_get_timex(struct timex *, const struct compat_timex __user *);
+int compat_put_timex(struct compat_timex __user *, const struct timex *);
 
 #endif /* _LINUX_COMPAT_TIME_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index 8e40efc2928a..e1de768e5607 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -30,69 +30,6 @@
 
 #include <linux/uaccess.h>
 
-int compat_get_timex(struct timex *txc, const struct compat_timex __user *utp)
-{
-	struct compat_timex tx32;
-
-	memset(txc, 0, sizeof(struct timex));
-	if (copy_from_user(&tx32, utp, sizeof(struct compat_timex)))
-		return -EFAULT;
-
-	txc->modes = tx32.modes;
-	txc->offset = tx32.offset;
-	txc->freq = tx32.freq;
-	txc->maxerror = tx32.maxerror;
-	txc->esterror = tx32.esterror;
-	txc->status = tx32.status;
-	txc->constant = tx32.constant;
-	txc->precision = tx32.precision;
-	txc->tolerance = tx32.tolerance;
-	txc->time.tv_sec = tx32.time.tv_sec;
-	txc->time.tv_usec = tx32.time.tv_usec;
-	txc->tick = tx32.tick;
-	txc->ppsfreq = tx32.ppsfreq;
-	txc->jitter = tx32.jitter;
-	txc->shift = tx32.shift;
-	txc->stabil = tx32.stabil;
-	txc->jitcnt = tx32.jitcnt;
-	txc->calcnt = tx32.calcnt;
-	txc->errcnt = tx32.errcnt;
-	txc->stbcnt = tx32.stbcnt;
-
-	return 0;
-}
-
-int compat_put_timex(struct compat_timex __user *utp, const struct timex *txc)
-{
-	struct compat_timex tx32;
-
-	memset(&tx32, 0, sizeof(struct compat_timex));
-	tx32.modes = txc->modes;
-	tx32.offset = txc->offset;
-	tx32.freq = txc->freq;
-	tx32.maxerror = txc->maxerror;
-	tx32.esterror = txc->esterror;
-	tx32.status = txc->status;
-	tx32.constant = txc->constant;
-	tx32.precision = txc->precision;
-	tx32.tolerance = txc->tolerance;
-	tx32.time.tv_sec = txc->time.tv_sec;
-	tx32.time.tv_usec = txc->time.tv_usec;
-	tx32.tick = txc->tick;
-	tx32.ppsfreq = txc->ppsfreq;
-	tx32.jitter = txc->jitter;
-	tx32.shift = txc->shift;
-	tx32.stabil = txc->stabil;
-	tx32.jitcnt = txc->jitcnt;
-	tx32.calcnt = txc->calcnt;
-	tx32.errcnt = txc->errcnt;
-	tx32.stbcnt = txc->stbcnt;
-	tx32.tai = txc->tai;
-	if (copy_to_user(utp, &tx32, sizeof(struct compat_timex)))
-		return -EFAULT;
-	return 0;
-}
-
 static int __compat_get_timeval(struct timeval *tv, const struct compat_timeval __user *ctv)
 {
 	return (!access_ok(VERIFY_READ, ctv, sizeof(*ctv)) ||
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ccdb351277ee..c40cce820380 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -978,3 +978,66 @@ int put_compat_itimerspec64(const struct itimerspec64 *its,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(put_compat_itimerspec64);
+
+int compat_get_timex(struct timex *txc, const struct compat_timex __user *utp)
+{
+	struct compat_timex tx32;
+
+	memset(txc, 0, sizeof(struct timex));
+	if (copy_from_user(&tx32, utp, sizeof(struct compat_timex)))
+		return -EFAULT;
+
+	txc->modes = tx32.modes;
+	txc->offset = tx32.offset;
+	txc->freq = tx32.freq;
+	txc->maxerror = tx32.maxerror;
+	txc->esterror = tx32.esterror;
+	txc->status = tx32.status;
+	txc->constant = tx32.constant;
+	txc->precision = tx32.precision;
+	txc->tolerance = tx32.tolerance;
+	txc->time.tv_sec = tx32.time.tv_sec;
+	txc->time.tv_usec = tx32.time.tv_usec;
+	txc->tick = tx32.tick;
+	txc->ppsfreq = tx32.ppsfreq;
+	txc->jitter = tx32.jitter;
+	txc->shift = tx32.shift;
+	txc->stabil = tx32.stabil;
+	txc->jitcnt = tx32.jitcnt;
+	txc->calcnt = tx32.calcnt;
+	txc->errcnt = tx32.errcnt;
+	txc->stbcnt = tx32.stbcnt;
+
+	return 0;
+}
+
+int compat_put_timex(struct compat_timex __user *utp, const struct timex *txc)
+{
+	struct compat_timex tx32;
+
+	memset(&tx32, 0, sizeof(struct compat_timex));
+	tx32.modes = txc->modes;
+	tx32.offset = txc->offset;
+	tx32.freq = txc->freq;
+	tx32.maxerror = txc->maxerror;
+	tx32.esterror = txc->esterror;
+	tx32.status = txc->status;
+	tx32.constant = txc->constant;
+	tx32.precision = txc->precision;
+	tx32.tolerance = txc->tolerance;
+	tx32.time.tv_sec = txc->time.tv_sec;
+	tx32.time.tv_usec = txc->time.tv_usec;
+	tx32.tick = txc->tick;
+	tx32.ppsfreq = txc->ppsfreq;
+	tx32.jitter = txc->jitter;
+	tx32.shift = txc->shift;
+	tx32.stabil = txc->stabil;
+	tx32.jitcnt = txc->jitcnt;
+	tx32.calcnt = txc->calcnt;
+	tx32.errcnt = txc->errcnt;
+	tx32.stbcnt = txc->stbcnt;
+	tx32.tai = txc->tai;
+	if (copy_to_user(utp, &tx32, sizeof(struct compat_timex)))
+		return -EFAULT;
+	return 0;
+}
-- 
2.17.1

