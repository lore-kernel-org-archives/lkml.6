Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-637638-1521000430-2-17140977528653982949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521000429; b=XkACXVZwBz2/WbsqrKOvYNpfBRnjNOvzcx8nEDpJgxEFGW6
    YZ2gD04r5vjSgIXvPyhyWGMeu0W2LunUbLDI8w0XyqRGiOcKaVFWDwizIoIqxQxa
    +tj2/rfrrvSUgb7LAKcMtsyPBMtjKvZ2HgUKgR1hdG3rIcnbJ1EnoPoq/gJOOXtw
    wOBYPqaIaio27iQf618wN+Vga67S9Fp/RZttKwPeJGbFU7a9bl497RScXK+pqT5m
    hG3DX/4uj8QmOD5gQjTzOcXTArT5XGFft3ynVhp/xH1cj4wOwuU5eJo6GiSSXNCs
    rcG3x3m4FxlpZqnZeWk44h0PLSOCEbpZdfELiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521000429;
    bh=7uWeQCYRG2q964WMOtMM1WV+ZDQxicQF1ZcrmDrN7MM=; b=Ug1fRPpF5Ott
    CQbFMq9kjcjjkopqwDDNzTOwmluE1Q+0mJJWZBPurPNdldVyAxmbaQpAZ9XSPtHa
    sb78g4LEU8NtU44e68dmYYhdvV8JYKvgXPeowx1wmdAKfJXb5UiLTaR6kRD+skF2
    G6jUtJC2bVNONL3ddzi9hT/U7wpSPdnZY/1tzsEoqi2Rg4964/qNtscv/0GNIB9W
    gGei6vgcxw/bSQX8Ido8piuUvI/W3/egf46OjxwoqDjJU5oPglQADC3ecmIXv33E
    sl2RjXoBnEaa/ZFwqyX7dy9pmbt3AVdpJ4XELnS/gl39v20TXU9kmLf0n5tzf/zs
    YIm3SLqFQQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tw/TENgr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HOY4WHeA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tw/TENgr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HOY4WHeA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNEG5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 00:06:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45335 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCNEG0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 00:06:26 -0400
X-Google-Smtp-Source: AG47ELuOSZ7S1izjvpwT1N4wFfXEL7L0PnFCLTUt5m0dIIjtCyysGZpVP7d0f/iWhv4w5mTAJ14RbQ==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-api@vger.kernel.org
Subject: [PATCH v5 10/10] nanosleep: change time types to safe __kernel_* types
Date: Tue, 13 Mar 2018 21:03:33 -0700
Message-Id: <20180314040333.3291-11-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change over clock_nanosleep syscalls to use y2038 safe
__kernel_timespec times. This will enable changing over
of these syscalls to use new y2038 safe syscalls when
the architectures define the CONFIG_64BIT_TIME.

Note that nanosleep syscall is deprecated and does not have a
plan for making it y2038 safe. But, the syscall should work as
before on 64 bit machines and on 32 bit machines, the syscall
works correctly until y2038 as before using the existing compat
syscall version. There is no new syscall for supporting 64 bit
time_t on 32 bit architectures.

Cc: linux-api@vger.kernel.org
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/restart_block.h | 7 ++-----
 include/linux/syscalls.h      | 6 +++---
 kernel/time/hrtimer.c         | 8 ++++++--
 kernel/time/posix-stubs.c     | 4 ++--
 kernel/time/posix-timers.c    | 4 ++--
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bcfdb918cd81..5d83d0c1d06c 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -7,6 +7,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/time64.h>
 
 struct timespec;
 struct compat_timespec;
@@ -15,9 +16,7 @@ struct pollfd;
 enum timespec_type {
 	TT_NONE		= 0,
 	TT_NATIVE	= 1,
-#ifdef CONFIG_COMPAT
 	TT_COMPAT	= 2,
-#endif
 };
 
 /*
@@ -40,10 +39,8 @@ struct restart_block {
 			clockid_t clockid;
 			enum timespec_type type;
 			union {
-				struct timespec __user *rmtp;
-#ifdef CONFIG_COMPAT
+				struct __kernel_timespec __user *rmtp;
 				struct compat_timespec __user *compat_rmtp;
-#endif
 			};
 			u64 expires;
 		} nanosleep;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7ac1bb9ea7da..4df16a70b0d7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -254,7 +254,7 @@ asmlinkage long sys_adjtimex(struct timex __user *txc_p);
 asmlinkage long sys_times(struct tms __user *tbuf);
 
 asmlinkage long sys_gettid(void);
-asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp);
+asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp, struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_alarm(unsigned int seconds);
 asmlinkage long sys_getpid(void);
 asmlinkage long sys_getppid(void);
@@ -317,8 +317,8 @@ asmlinkage long sys_clock_adjtime(clockid_t which_clock,
 asmlinkage long sys_clock_getres(clockid_t which_clock,
 				struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
-				const struct timespec __user *rqtp,
-				struct timespec __user *rmtp);
+				const struct __kernel_timespec __user *rqtp,
+				struct __kernel_timespec __user *rmtp);
 
 asmlinkage long sys_nice(int increment);
 asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6528dec955b8..10190de38be3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1710,8 +1710,10 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	return ret;
 }
 
-SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
-		struct timespec __user *, rmtp)
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+
+SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
+		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 tu;
 
@@ -1726,6 +1728,8 @@ SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
 	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
+#endif
+
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 28c22f54d0f2..f7e7a05e651d 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -114,8 +114,8 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 }
 
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
-		const struct timespec __user *, rqtp,
-		struct timespec __user *, rmtp)
+		const struct __kernel_timespec __user *, rqtp,
+		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 t;
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 78e50b26a283..851886b38da6 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1210,8 +1210,8 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 }
 
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
-		const struct timespec __user *, rqtp,
-		struct timespec __user *, rmtp)
+		const struct __kernel_timespec __user *, rqtp,
+		struct __kernel_timespec __user *, rmtp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 t;
-- 
2.14.1

