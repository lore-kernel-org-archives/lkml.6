Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8635C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCBE2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd+AYcrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCBE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeGCFpk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:45:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42669 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933013AbeGCFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:45:29 -0400
Received: by mail-pl0-f65.google.com with SMTP id y15-v6so459487pll.9;
        Mon, 02 Jul 2018 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYJQorcg9dk4RdtFwcKtzQ5ep9R/FqIc0ORefoXP1CU=;
        b=Dd+AYcrz9Flo47e+UhzDvJevKejyLYoydlG1+O3U5/A1FQ8GHyioBqOgafwhFxB7m8
         mGGCU4Pn/KivDmXP26d/FPb+xjBKBOdE9thfktd3IValu9Q9RA48W6Y5h+wY49qRpX9U
         tJLeKXOolW1y9F0rmObNsq1IdChBMxuv4XumXbs/oosK3QN4mYAsIf5VrhTkrXvlfVL5
         YLmcHDYj7S+y0nLPPQjMDSvI5vrYqavDzHrHFS8RQCyPc/5AGB57HfDU9kUKcAg/JeEQ
         6kq5QoDbjaJnLS/Z09MoFrAt33Opihns7LQ5rt8VO4n6I7m814s+tDaGRZEv71fzeDEU
         AYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYJQorcg9dk4RdtFwcKtzQ5ep9R/FqIc0ORefoXP1CU=;
        b=CWm20YyI0cDD/kmYf/eXHr2dC4Piyd51sviOI1VaP563D+biO0chVKdGub3fLEJVCW
         OoR6bLMGGRYhFp/kc+q4M7zxd2fUnyIONO7uVtvx8pygehtXkr81HbwyTmgQ84RsYy5Y
         z84zzej4BcfSNaO7RS6faaAOBlQ0ubOhhTthapCfhNhNgtWWorxVBYz2jChOWN/OyOTu
         3DYfiUHxUtP1qufBAAe7LPsiVuJKxOrNNURMSsUuIAZtX/dkNSqK626eCvpvnsx2zpJu
         mLd8DBvHicscTDZIFifmUbicJcRkPuD+gnmAtp0HLoTGfhArckGAT4BeKAX37NP+Fleb
         cs6g==
X-Gm-Message-State: APt69E3ShD2kp8ur59lrJhFv/I1v3vRzoJFE7ndfzht4RhK1cJgq4aj4
        mWF/7BH8NCEjVn0VRoUvcUU=
X-Google-Smtp-Source: ADUXVKIk0LMopnv6J3fMGlNQzOU9+5C9T4uaZ+kBXjpmwB789R5zY7xDwdVRJogAu97wnCWqiLogLA==
X-Received: by 2002:a17:902:345:: with SMTP id 63-v6mr29027571pld.328.1530596728481;
        Mon, 02 Jul 2018 22:45:28 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h75-v6sm784780pfh.86.2018.07.02.22.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 22:45:28 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, linux-api@vger.kernel.org
Subject: [PATCH 6/6] timex: change syscalls to use struct __kernel_timex
Date:   Mon,  2 Jul 2018 22:44:22 -0700
Message-Id: <20180703054422.12089-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703054422.12089-1-deepa.kernel@gmail.com>
References: <20180703054422.12089-1-deepa.kernel@gmail.com>
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
index 640e30792413..8ae5d73ecee3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1075,7 +1075,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 }
 
 SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+		struct __kernel_timex __user *, utx)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct __kernel_timex ktx;
@@ -1150,10 +1150,6 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT
-
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 		       struct compat_timex __user *, utp)
 {
@@ -1178,10 +1174,6 @@ COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
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

