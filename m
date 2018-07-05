Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FD1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542F240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4q6tFrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2542F240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeGEVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:37:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38993 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbeGEVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:37:02 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so1838333plq.6;
        Thu, 05 Jul 2018 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYYWFz/eXY24V7TJQqMVo+cbm8GUZpZrNaBc9Co+6os=;
        b=m4q6tFrSMKQO0mfRE6cb2HIjOMmWBcrD039fB3eY58iaDl+9SedUJ8PNhesR5j5p3O
         lVR/w+JExGoyPnZEBKnoB7qwkCT/yDKJbIkOVj+Q+D2NaT+lOakLvQivZgZ3NJv7t/QM
         Z3F9MwLqGJ2Ysq215eZ7Bcq23GXgUWR6p6wllHL0hLUVH3SRT1RoqAdYdqSJdxVF7ayX
         Nwhu8QruvPRP5p4+B+UVVzo4wzIbHIu+aRBCi2bIdmirXzkC6Fb6HPPl9RnNptsy78/y
         JwTg0HBC0yf7ZsbWIQj2chosuqT8SnieKMOwplbnHGe7Qv68nFMrhYON12aB2NKcDlyi
         oDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYYWFz/eXY24V7TJQqMVo+cbm8GUZpZrNaBc9Co+6os=;
        b=BznK4HaHEwA9Xv+LLJfGUXnrSWfRtbs/IP/utUW6btinjyD6F3p2JIbiiVez2FcDUn
         DCG/s0STILNGvLulmmoqKZYPLjkP1RAn5BHNSTVx11qiFCzUWJ5VbuRUVqR9nDwSXqTZ
         aOgoUgcgN7TtzGR05Qidp9uAbKVq1SwqZEC7lhPVyo1wGLv3ouHPOgDp94AoDHZO9fu8
         7gYqjapr0qwosBzCH6WNutuvJLXDsyXgGJ04P8C0mSRZ2yIb8eC/GLN9zOxpka1PGia8
         ydolPblhvS3lIFXL6e+x3DaVpqwH07+dr3UaroC+7JLrll5uD6RRYtUHg+r8XNVP/3jj
         O1Pw==
X-Gm-Message-State: APt69E2CvuKXEzewbUKnh6pk7wnAKA9HMsIptUx3FFBRdQwsu4NB5pvl
        PjC+EYU27kn6TElbWc7D+wU=
X-Google-Smtp-Source: AAOMgpf8E5d5bvnFS/b67CknGq8otzYgxablSibFybv8DD1WaFfzdFEPBU9VR+uxE0nD306fBeI0WQ==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr4325249plb.210.1530826621539;
        Thu, 05 Jul 2018 14:37:01 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id v89-v6sm20438290pfd.64.2018.07.05.14.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 14:37:00 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, linux-api@vger.kernel.org
Subject: [PATCH v2 7/7] timex: change syscalls to use struct __kernel_timex
Date:   Thu,  5 Jul 2018 14:36:04 -0700
Message-Id: <20180705213604.18883-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705213604.18883-1-deepa.kernel@gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timex is not y2038 safe.
Switch all the syscall apis to use y2038 safe __kernel_timex.

Note that sys_adjtimex() does not have a y2038 safe solution.
The api is meant to be deprecated on 32 bit machines after y2038.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-api@vger.kernel.org
---
 include/linux/syscalls.h   |  5 ++---
 kernel/time/posix-timers.c | 10 +---------
 kernel/time/time.c         |  9 +++++++--
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3ee3b3f1302f..54688c7b4dae 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -54,7 +54,6 @@ struct __sysctl_args;
 struct sysinfo;
 struct timespec;
 struct timeval;
-struct timex;
 struct timezone;
 struct tms;
 struct utimbuf;
@@ -677,7 +676,7 @@ asmlinkage long sys_gettimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
-asmlinkage long sys_adjtimex(struct timex __user *txc_p);
+asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 
 /* kernel/timer.c */
 asmlinkage long sys_getpid(void);
@@ -846,7 +845,7 @@ asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
 asmlinkage long sys_clock_adjtime(clockid_t which_clock,
-				struct timex __user *tx);
+				struct __kernel_timex __user *tx);
 asmlinkage long sys_syncfs(int fd);
 asmlinkage long sys_setns(int fd, int nstype);
 asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a2595cb0cb16..1b485422f9f3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1084,7 +1084,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 }
 
 SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+		struct __kernel_timex __user *, utx)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct __kernel_timex ktx;
@@ -1159,10 +1159,6 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT
-
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 		       struct compat_timex __user *, utp)
 {
@@ -1187,10 +1183,6 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT_32BIT_TIME
-
 COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 		       struct compat_timespec __user *, tp)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 2c5afb008b14..a374fdbb368b 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -263,7 +263,10 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct compat_timeval __user *, tv,
 }
 #endif
 
-SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
+
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+
+SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;		/* Local copy of parameter */
 	int ret;
@@ -278,7 +281,9 @@ SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
 	return copy_to_user(txc_p, &txc, sizeof(struct __kernel_timex)) ? -EFAULT : ret;
 }
 
-#ifdef CONFIG_COMPAT
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 
 COMPAT_SYSCALL_DEFINE1(adjtimex, struct compat_timex __user *, utp)
 {
-- 
2.17.1

