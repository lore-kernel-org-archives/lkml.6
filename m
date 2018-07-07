Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC76BC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A394224D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrCN2VJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A394224D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbeGGFoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:44:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42059 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbeGGFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id y8-v6so3745851plr.9;
        Fri, 06 Jul 2018 22:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYYWFz/eXY24V7TJQqMVo+cbm8GUZpZrNaBc9Co+6os=;
        b=YrCN2VJ+RqtidZLvHLlLGfUdAaouxbv54rUbuErb3XFy0LPk+aDYeB9laNT8BVJjbX
         RtZoNLB/A1c85d88tuS06Cnns2++i23pMFrgksTkvfasoOkK+5FSPfH7xTKXe2hJVDyy
         7/vU6RnEIbo/eGPlGlVq2jza+J4wgyQggzL7Bk/r4hgK+2UIXtSX4138Rzmnp+YpnmyL
         fV+dbkrITNI9sP88O3s+8izXo3HlXXJEvtyZoVUOxrkq0anCJsV5mC/lgCUMg4I4lqO8
         iAb8al9p7qj0gqethLjDcMW6qW/ZEI9Zf4hddpZwmb9d02TnMmwkCXLD4pnPYohyIocC
         slaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYYWFz/eXY24V7TJQqMVo+cbm8GUZpZrNaBc9Co+6os=;
        b=TZH90NCZMOf5xMjsy5Wufk89jDuS3iSUo68G36jjebItp2ysex/D0fu9t6IfKFgqjS
         R0+r1YARluHuUKok0IH4Hb02bVmH9L5yr5KnW9kvKSVXvT+r6JcqSUnHy0qJjdLbta4p
         w3j0X98KTUuxIjSqRTtdpzObquCL+fOHtA0RBCWEt2mJKQnwx/hWNd3wnicPhm+ReBhW
         LdFRMv2nTEQ4BRdp4FHIEBtwfVDH8Yr91qk88kTLpaBy+0XiA168AjF04OTSY4RQzIhc
         PVcW4VE6WfAWbCF4oky6fr6JCE8afRroLlajmf0hWHfQ3DXIllXn32I40+M0zMDIQSjs
         Qa/Q==
X-Gm-Message-State: APt69E0s5wZyAI/gu1TmVOxGrUwkr5f5xrUdEPCPFWjFM+0hXwu6b39h
        OFN6eablDXw74ZGciLZaRxqA9w==
X-Google-Smtp-Source: AAOMgpf+tOuUGEkyJb3c4oYXZaiOPmPohfeVChaYxSuvPNAHrB55zG/ny/rTE6/zLwXns4xNer5Vzg==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr12820350plp.212.1530942234498;
        Fri, 06 Jul 2018 22:43:54 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:54 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, linux-api@vger.kernel.org
Subject: [PATCH v3 7/7] timex: change syscalls to use struct __kernel_timex
Date:   Fri,  6 Jul 2018 22:42:47 -0700
Message-Id: <20180707054247.19802-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707054247.19802-1-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
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

