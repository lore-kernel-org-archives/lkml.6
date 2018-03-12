Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-942284-1520877265-2-9169347834649012635
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
    t=1520877265; b=Y0qCfiqsFnBwwAIXZrQ5zROnI6p+I8th9rQQYTaRlAMwf6O
    20nt8Kc7rnNzhu7QORov+8rd/Yuum3ZGI0fgS+Gbid/Yhmjgz+O/EQkzt3BKRuC2
    1ZFv2LzuyETTaH/Y3AXQaWsh/2nml9nZ4ZmTIssK8OGFNoIDFuANBhT6lZGh3cdj
    GNE3Jgh2WpZy87dkoVMgZSRuRJ2trLKnRlAp9Av7+9VVkV+J2BaV9YCKeVVHHrK2
    UOUB9ohMe7vlFoBobOgzGFWarqbtFJANSOiLH5aE+qLJV9m7n/qiO+SSP80iagYP
    DPGAFS7Wn21oogTN1YLi2y1xYOIbcmwKUPnK2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520877265;
    bh=MvxquRch6Iak1Clo3e0HOotSI26oMSuXaCui9x6OG9U=; b=Ce1Jrpsf3ssl
    Msk8y0m7Rajz6haq5QFWF86LLWOZpTpTlZwBJ21JCpjDktosBHhHP2BnmcBeiZRW
    wuRX8aXblLmIyi5QyvSvokGaizuusaijMn7Q94TVpjkeXRFCJf/BQ1cf60FhRcHH
    duzSWxZL+WeZRY3pYu4jrzl581epsMZ1JvDfG/Ylb39Hr0H/bldgri8x2D8YKylJ
    Wx7cFkEqgpoG54jjRwWhQ+r1NEmVwSpoD2RBz+WdWobeW+ZHv0GCMqQ3RDb7vVfD
    v9BqDycNvFWYavDyYhjPpfR0lVaS0sgn7CnVl1MbgdIyARl1WrqLuHovE2kQh8Cu
    Wkc8eEzGpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lV0VdsLk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cHzrK8Bv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lV0VdsLk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cHzrK8Bv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeCLRyV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 13:54:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45250 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932793AbeCLRyC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Mar 2018 13:54:02 -0400
X-Google-Smtp-Source: AG47ELubK9ZTZWuYp7PPn0H3Mdr051xo3b1tXZJw+c7unJM5g2/uFkEWNMEjRM/f0Hwn8XjTRXK7nw==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-api@vger.kernel.org
Subject: [PATCH v4 09/10] change time types to new y2038 safe __kernel_* types
Date: Mon, 12 Mar 2018 10:53:06 -0700
Message-Id: <20180312175307.11032-10-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180312175307.11032-1-deepa.kernel@gmail.com>
References: <20180312175307.11032-1-deepa.kernel@gmail.com>
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

