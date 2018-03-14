Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-637638-1521000453-2-13466828721623018217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521000452; b=oEu4H7WwcLHG8P9dHTnLZHI3liwX/bGwA5Fx0l/bvc8x3FB
    HXUGck8ooTfn8zEbkYD04+jbv5xEQI3xTQPG9OPuUuMdR1LENYXUudz+JVl8wFow
    X5DvU/sLCMvWqSD8hlcxxtXBNSP9IhKUTpnl/+idd791IukNnq7I2/ijX6zFxIyj
    3qBvq8TGgGFyCtSthyEX+yNSTMVSkfGy5gpO4z5QJue4HnjjVmi9wkpeITcYf4Zm
    DtEhcp3x4jkuqw0zqoqTV4V2cphkQb3HHhnWfvaxn7Kwvckmuv4VWT6OD7M4piCQ
    1O0Lu3Yd85iOPt7Y1ObdCT4qg5FHIssHOXY3CPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521000452;
    bh=MvxquRch6Iak1Clo3e0HOotSI26oMSuXaCui9x6OG9U=; b=CaMrEVak8bUh
    2FC/qr1fr+n0UboH1R8WElRtiU/GAfcQ2iKtkRJPsbSlBwxaHDqKyGRgm62GG6bs
    kypT0r5/0+YKGoowYFEDAKuTxnm/YW5srHWlMnrWztG7a6/abea/weaaAOEmY4Qa
    4b3ndBoxydtXhyHw+BVkb9gqjxJ00Zy1pCoTo1VsQJ2fxUAkLpwPtTTkZRUgb0HG
    GyuHIGhluu6xqu7JMDz2pPlk33uUvgN1/E2l/zGDlJmq2V8GUjZLgSLEbo2BJ/nN
    VgFKxuIwHUvHMUkEJXYtdAT1LYqZeKvkc+pXYZh9F1Aqfvr285k4BHCjRGxBWRmB
    Pbjm90ISIg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kG7kKz2F x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iX58YMdr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kG7kKz2F x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iX58YMdr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeCNEHS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 00:07:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36183 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCNEGZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 00:06:25 -0400
X-Google-Smtp-Source: AG47ELuY7SHe+mMHBGDm/xsgjGP3y3XjfypwdPYiVpIDsx3biOGb0qf0VaXv63rQceztOkftbgmcUQ==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-api@vger.kernel.org
Subject: [PATCH v5 09/10] change time types to new y2038 safe __kernel_* types
Date: Tue, 13 Mar 2018 21:03:32 -0700
Message-Id: <20180314040333.3291-10-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change over clock_settime, clock_gettime and clock_getres
syscalls to use __kernel_timespec times. This will enable
changing over of these syscalls to use new y2038 safe syscalls
when the architectures define the CONFIG_64BIT_TIME.

Cc: linux-api@vger.kernel.org
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/syscalls.h   | 6 +++---
 kernel/time/posix-stubs.c  | 6 +++---
 kernel/time/posix-timers.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d826d7..7ac1bb9ea7da 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -309,13 +309,13 @@ asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				struct itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
-				const struct timespec __user *tp);
+				const struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_gettime(clockid_t which_clock,
-				struct timespec __user *tp);
+				struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_adjtime(clockid_t which_clock,
 				struct timex __user *tx);
 asmlinkage long sys_clock_getres(clockid_t which_clock,
-				struct timespec __user *tp);
+				struct __kernel_timespec __user *tp);
 asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
 				const struct timespec __user *rqtp,
 				struct timespec __user *rmtp);
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 0645cfa93609..28c22f54d0f2 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -49,7 +49,7 @@ SYS_NI(alarm);
  */
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
-		const struct timespec __user *, tp)
+		const struct __kernel_timespec __user *, tp)
 {
 	struct timespec64 new_tp;
 
@@ -80,7 +80,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 	return 0;
 }
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
-		struct timespec __user *, tp)
+		struct __kernel_timespec __user *, tp)
 {
 	int ret;
 	struct timespec64 kernel_tp;
@@ -94,7 +94,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	return 0;
 }
 
-SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct timespec __user *, tp)
+SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_timespec __user *, tp)
 {
 	struct timespec64 rtn_tp = {
 		.tv_sec = 0,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 35b7b08f79f5..78e50b26a283 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1039,7 +1039,7 @@ void exit_itimers(struct signal_struct *sig)
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
-		const struct timespec __user *, tp)
+		const struct __kernel_timespec __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 new_tp;
@@ -1054,7 +1054,7 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 }
 
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
-		struct timespec __user *,tp)
+		struct __kernel_timespec __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 kernel_tp;
@@ -1095,7 +1095,7 @@ SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
 }
 
 SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
-		struct timespec __user *, tp)
+		struct __kernel_timespec __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 rtn_tp;
-- 
2.14.1

