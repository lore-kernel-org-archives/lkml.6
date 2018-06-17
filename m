Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42616C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674B2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB/6W6Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E674B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbeFQFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:12:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36242 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbeFQFMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:12:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so6662655pfi.3;
        Sat, 16 Jun 2018 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZSMjW9fzrLdVDATyVHmykY7RbhvdhToLNNjkpZ9bW+M=;
        b=YB/6W6LdvM1OOXcrJl2RfQcosKQzV6FsVtBTnAl2QeSNSkIMDAK/rQ+fe8Sh/VXyNB
         HXFq+x+AM1daQsebrHs339tOSz+a920S1w4qgvtr9WMO0mHjfdjxzY2kxsA8FlZqasNO
         xhS3cjlUM6A3Da8u10xXDs9+oIY+nC+5KFOzbAk02TimbsGhcqylInpaXg5DEr6MBXmd
         igcCXiiKqrCUkEVRrjyYm4lB4cw4zepCH+sRWXnh9EPsp5mBI+faHV2YMWDpcZNl/ZOr
         a1DgzfxAdc8yuIUuYEbeBP3RPslPau2jS2IfxqDO1NqWfaKBcTDldF6ggqHu4JWbr213
         hWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZSMjW9fzrLdVDATyVHmykY7RbhvdhToLNNjkpZ9bW+M=;
        b=dMTVF93uKErNvUiTklIqoJeFD3UKd7bxH3X2VwWdzPDsTMTFqG6n4nVnvJspvGpJET
         26OM7EiwYS4Fn3r2o8/NZW+sWA/SR3loMg/k7l51+JXQbDFY6Hu3Np0YYsa0IrGamGi8
         7IGkq1F3f3ymPO+ieXHytQZmbyRItx4EAYINdQCQzvw+8gCdQUC+pblwBhVdeFjlA4l0
         pjw6V/vfmr1tC6EBzRBHZU7ptVEkY2lnuVIYpdbYgOEbT/PbhKSWukh+qombudFm6VvN
         mTMRkeksinCHRkUADEnPM7iTTDNU2RYi7uL8RYhw+BlfeUOnYaj6LJl8k1ZFr4OcH0uR
         ajQg==
X-Gm-Message-State: APt69E0qkkYmzNv8Zoc2iDAcTdHeuKtucaL8O1nkGpiURhwgYrehlB7H
        K8u/MhU6G3YJzxC4ZdzONL4=
X-Google-Smtp-Source: ADUXVKL1Wsz6bRzFHbLGnII6dk+/mqJQ4dISlMjs2vQ7tDEjXEKUsI+ka+NbxrLyQYiU3EzBNMcxww==
X-Received: by 2002:a62:5d48:: with SMTP id r69-v6mr8412717pfb.84.1529212333345;
        Sat, 16 Jun 2018 22:12:13 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h27-v6sm28354594pfk.160.2018.06.16.22.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 22:12:12 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH 3/3] time: Change types to new y2038 safe __kernel_itimerspec
Date:   Sat, 16 Jun 2018 22:11:44 -0700
Message-Id: <20180617051144.29756-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617051144.29756-1-deepa.kernel@gmail.com>
References: <20180617051144.29756-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timer_set/gettime and timerfd_set/get apis use struct itimerspec at the
user interface layer.  struct itimerspec is not y2038-safe.
Change these interfaces to use y2038-safe struct __kernel_itimerspec
instead.  This will help define new syscalls when architectures select
CONFIG_64BIT_TIME.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/timerfd.c               |  8 ++++----
 include/linux/syscalls.h   | 10 +++++-----
 kernel/time/posix-timers.c | 12 +++++++-----
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index d84a2bee4f82..8bb926253f88 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -533,8 +533,8 @@ static int do_timerfd_gettime(int ufd, struct itimerspec64 *t)
 }
 
 SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
-		const struct itimerspec __user *, utmr,
-		struct itimerspec __user *, otmr)
+		const struct __kernel_itimerspec __user *, utmr,
+		struct __kernel_itimerspec __user *, otmr)
 {
 	struct itimerspec64 new, old;
 	int ret;
@@ -550,7 +550,7 @@ SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
 	return ret;
 }
 
-SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct itimerspec __user *, otmr)
+SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct __kernel_itimerspec __user *, otmr)
 {
 	struct itimerspec64 kotmr;
 	int ret = do_timerfd_gettime(ufd, &kotmr);
@@ -559,7 +559,7 @@ SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct itimerspec __user *, otmr)
 	return put_itimerspec64(&kotmr, otmr) ? -EFAULT : 0;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
 		const struct compat_itimerspec __user *, utmr,
 		struct compat_itimerspec __user *, otmr)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 73810808cdf2..38b9ec152024 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -501,9 +501,9 @@ asmlinkage long sys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 /* fs/timerfd.c */
 asmlinkage long sys_timerfd_create(int clockid, int flags);
 asmlinkage long sys_timerfd_settime(int ufd, int flags,
-				    const struct itimerspec __user *utmr,
-				    struct itimerspec __user *otmr);
-asmlinkage long sys_timerfd_gettime(int ufd, struct itimerspec __user *otmr);
+				    const struct __kernel_itimerspec __user *utmr,
+				    struct __kernel_itimerspec __user *otmr);
+asmlinkage long sys_timerfd_gettime(int ufd, struct __kernel_itimerspec __user *otmr);
 
 /* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
@@ -568,10 +568,10 @@ asmlinkage long sys_timer_create(clockid_t which_clock,
 				 struct sigevent __user *timer_event_spec,
 				 timer_t __user * created_timer_id);
 asmlinkage long sys_timer_gettime(timer_t timer_id,
-				struct itimerspec __user *setting);
+				struct __kernel_itimerspec __user *setting);
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
-				const struct itimerspec __user *new_setting,
+				const struct __kernel_itimerspec __user *new_setting,
 				struct itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e08ce3f27447..bc35603cf2a9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -743,7 +743,7 @@ static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 
 /* Get the time remaining on a POSIX.1b interval timer. */
 SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
-		struct itimerspec __user *, setting)
+		struct __kernel_itimerspec __user *, setting)
 {
 	struct itimerspec64 cur_setting;
 
@@ -755,7 +755,8 @@ SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
+
 COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 		       struct compat_itimerspec __user *, setting)
 {
@@ -768,6 +769,7 @@ COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 	}
 	return ret;
 }
+
 #endif
 
 /*
@@ -906,8 +908,8 @@ static int do_timer_settime(timer_t timer_id, int flags,
 
 /* Set a POSIX.1b interval timer */
 SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
-		const struct itimerspec __user *, new_setting,
-		struct itimerspec __user *, old_setting)
+		const struct __kernel_itimerspec __user *, new_setting,
+		struct __kernel_itimerspec __user *, old_setting)
 {
 	struct itimerspec64 new_spec, old_spec;
 	struct itimerspec64 *rtn = old_setting ? &old_spec : NULL;
@@ -927,7 +929,7 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 	return error;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 		       struct compat_itimerspec __user *, new,
 		       struct compat_itimerspec __user *, old)
-- 
2.17.1

