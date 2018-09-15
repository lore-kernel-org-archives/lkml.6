Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D55ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A294D2083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMigb8wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A294D2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeIOK1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:27:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43915 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeIOK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:27:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so5284886pgb.10;
        Fri, 14 Sep 2018 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8RIZycRRCZSHAxDULpj0u8S6T2BMmn3XJ2wNoZkYFk=;
        b=YMigb8wdAFrSB4s9dL2uOJNJ2FbCJMPrJmqu48pzysUgjJnxo38/AhlckdTjyGps8c
         XWEfzETwO74b198r+3aSuy6lETlBzbNs9EDc6EhoWWE6beGM9+DkSeoSx/1hcrjl1Eti
         Uf6zwJ3BlbE3FSGwyXrM6L2C0Qw8VX7KOLMUdbvpXeSh8yUdmZr/pWph2mTE1s0x6yYc
         eHTXec4r2mdAhAmHPRlq7qLGn8rPMxEUgFsq89d9f8wv9XrnxyfMptygsz7DIn/xjRSR
         TWx2pt2Cl6yg1h1rKyIscFp8Qj2meoXvIwBSYMM7L0qN9wESJ8uts0pTIQ8AWfVz2bQB
         Lfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8RIZycRRCZSHAxDULpj0u8S6T2BMmn3XJ2wNoZkYFk=;
        b=rEMOFD5ZwTbfmE0DG/nzYS4qSkwynA1wMV8KIafyNoRVdu3R3wP2vwsrKDDsn+aZg0
         lR2ztL78Hl6WSqctF+SP790DAQo2BUC7QME9FdXqG/MTvlRhpwIHYF0mEMnzVQ7s+Bes
         lUAGOtqwtdRzI5xXz4fDlrTBokJ6RbfB1H025WnkgsHQzhlpPEOY+F1502Ky9YEuneEC
         hG0klwuelC1QUsDbguTNdzed/61gi5qJ4BlwDHg8Lk4ID0qC2D9UJqrgKu4HgRwKe96r
         PihqTZx8vYtjGO+aI4Th+JqjE0C5XEz0Q+T+7Q+ZzOJIAsVf0Nw1nROFxvc9Mkd7lwC9
         22OQ==
X-Gm-Message-State: APzg51BvDE3gtuLZ8sW+u7bJxGxE0JXCUyAiqVfH7vs46oumPcXHjueJ
        jQNHsdPoEpyA5Lizyx+rBCI=
X-Google-Smtp-Source: ANB0VdYIqa4vM4y3++/3j276w44tMKQn9GpGPYYwmU4f8x8bI0y3+cD99aiERhR/CRbAueN9VQo6sA==
X-Received: by 2002:a62:1fdd:: with SMTP id l90-v6mr15298736pfj.121.1536988182562;
        Fri, 14 Sep 2018 22:09:42 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id g6-v6sm14195676pfb.11.2018.09.14.22.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 22:09:42 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v2 5/5] io_pgetevents: use __kernel_timespec
Date:   Fri, 14 Sep 2018 22:08:43 -0700
Message-Id: <20180915050843.19183-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180915050843.19183-1-deepa.kernel@gmail.com>
References: <20180915050843.19183-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timespec is not y2038 safe.
struct __kernel_timespec is the new y2038 safe structure for all
syscalls that are using struct timespec.
Update io_pgetevents interfaces to use struct __kernel_timespec.

sigset_t also has different representations on 32 bit and 64 bit
architectures. Hence, we need to support the following different
syscalls:

New y2038 safe syscalls:
(Controlled by CONFIG_64BIT_TIME for 32 bit ABIs)

Native 64 bit(unchanged) and native 32 bit : sys_io_pgetevents
Compat : compat_sys_io_pgetevents_time64

Older y2038 unsafe syscalls:
(Controlled by CONFIG_32BIT_COMPAT_TIME for 32 bit ABIs)

Native 32 bit : sys_io_pgetevents_time32
Compat : compat_sys_io_pgetevents

Note that io_getevents syscalls do not have a y2038 safe solution.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/aio.c                 | 88 ++++++++++++++++++++++++++++++++++++++--
 include/linux/compat.h   |  6 +++
 include/linux/syscalls.h | 10 ++++-
 3 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b81c216534d6..9560f147d7a5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2063,11 +2063,13 @@ static long do_io_getevents(aio_context_t ctx_id,
  *	specifies an infinite timeout. Note that the timeout pointed to by
  *	timeout is relative.  Will fail with -ENOSYS if not implemented.
  */
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+
 SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 		long, min_nr,
 		long, nr,
 		struct io_event __user *, events,
-		struct timespec __user *, timeout)
+		struct __kernel_timespec __user *, timeout)
 {
 	struct timespec64	ts;
 	int			ret;
@@ -2081,6 +2083,8 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 	return ret;
 }
 
+#endif
+
 struct __aio_sigset {
 	const sigset_t __user	*sigmask;
 	size_t		sigsetsize;
@@ -2091,7 +2095,7 @@ SYSCALL_DEFINE6(io_pgetevents,
 		long, min_nr,
 		long, nr,
 		struct io_event __user *, events,
-		struct timespec __user *, timeout,
+		struct __kernel_timespec __user *, timeout,
 		const struct __aio_sigset __user *, usig)
 {
 	struct __aio_sigset	ksig = { NULL, };
@@ -2118,7 +2122,44 @@ SYSCALL_DEFINE6(io_pgetevents,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
+
+SYSCALL_DEFINE6(io_pgetevents_time32,
+		aio_context_t, ctx_id,
+		long, min_nr,
+		long, nr,
+		struct io_event __user *, events,
+		struct old_timespec32 __user *, timeout,
+		const struct __aio_sigset __user *, usig)
+{
+	struct __aio_sigset	ksig = { NULL, };
+	sigset_t		ksigmask, sigsaved;
+	struct timespec64	ts;
+	int ret;
+
+	if (timeout && unlikely(get_old_timespec32(&ts, timeout)))
+		return -EFAULT;
+
+	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
+		return -EFAULT;
+
+
+	ret = set_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
+	if (ret)
+		return ret;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
+
+	return ret;
+}
+
+#endif
+
+#if defined(CONFIG_COMPAT_32BIT_TIME)
+
 COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 		       compat_long_t, min_nr,
 		       compat_long_t, nr,
@@ -2137,12 +2178,17 @@ COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 	return ret;
 }
 
+#endif
+
+#ifdef CONFIG_COMPAT
 
 struct __compat_aio_sigset {
 	compat_sigset_t __user	*sigmask;
 	compat_size_t		sigsetsize;
 };
 
+#if defined(CONFIG_COMPAT_32BIT_TIME)
+
 COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		compat_aio_context_t, ctx_id,
 		compat_long_t, min_nr,
@@ -2173,4 +2219,40 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 
 	return ret;
 }
+
+#endif
+
+#if defined(CONFIG_64BIT_TIME)
+
+COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
+		compat_aio_context_t, ctx_id,
+		compat_long_t, min_nr,
+		compat_long_t, nr,
+		struct io_event __user *, events,
+		struct __kernel_timespec __user *, timeout,
+		const struct __compat_aio_sigset __user *, usig)
+{
+	struct __compat_aio_sigset ksig = { NULL, };
+	sigset_t ksigmask, sigsaved;
+	struct timespec64 t;
+	int ret;
+
+	if (timeout && get_timespec64(&t, timeout))
+		return -EFAULT;
+
+	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
+		return -EFAULT;
+
+	ret = set_compat_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
+	if (ret)
+		return ret;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
+
+	return ret;
+}
+#endif
 #endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6896e6e51c00..50cd0329c8bf 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -556,6 +556,12 @@ asmlinkage long compat_sys_io_pgetevents(compat_aio_context_t ctx_id,
 					struct io_event __user *events,
 					struct old_timespec32 __user *timeout,
 					const struct __compat_aio_sigset __user *usig);
+asmlinkage long compat_sys_io_pgetevents_time64(compat_aio_context_t ctx_id,
+					compat_long_t min_nr,
+					compat_long_t nr,
+					struct io_event __user *events,
+					struct __kernel_timespec __user *timeout,
+					const struct __compat_aio_sigset __user *usig);
 
 /* fs/cookies.c */
 asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e9cd0409c3fe..3ff0e29c082c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -297,12 +297,18 @@ asmlinkage long sys_io_getevents(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
 				struct io_event __user *events,
-				struct timespec __user *timeout);
+				struct __kernel_timespec __user *timeout);
 asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
 				struct io_event __user *events,
-				struct timespec __user *timeout,
+				struct __kernel_timespec __user *timeout,
+				const struct __aio_sigset *sig);
+asmlinkage long sys_io_pgetevents_time32(aio_context_t ctx_id,
+				long min_nr,
+				long nr,
+				struct io_event __user *events,
+				struct old_timespec32 __user *timeout,
 				const struct __aio_sigset *sig);
 
 /* fs/xattr.c */
-- 
2.17.1

