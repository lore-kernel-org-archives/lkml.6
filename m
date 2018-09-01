Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09412083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmz4k9mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09412083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeIBBB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:01:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40522 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeIBBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:01:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so2429350pga.7;
        Sat, 01 Sep 2018 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8RIZycRRCZSHAxDULpj0u8S6T2BMmn3XJ2wNoZkYFk=;
        b=hmz4k9mk6XgNi+a06CyB1ak7/hyqD4u9DjvZoiAPDNjDQyLJ7A5jMhi3HCz8Z+69yh
         MfGswiRJXZSyuMsRo4DBV9Gss1u5B2dJHyHeU8dCtOvc1nhkrFaaVQ3+gWIXQKoyzoA1
         DuEHXINV+4crdP5zkrckzUveTCkxgQDAn8oN5H4iDgaRd4esTLd/v76hWmh7xI9J1Krl
         cgewSB94XkJDL2J+agMiusvqzPWU5R/VHeQIOfrvZrSMnjUJ26PyCQ9WdurhCANRklgW
         I1uiQ1L5qRhGJLGJK+DeOgPJH+RGI22Z8JVyV+xM3A5LkwVkzjTkvs+ySXQp54yRvIzh
         wPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8RIZycRRCZSHAxDULpj0u8S6T2BMmn3XJ2wNoZkYFk=;
        b=IKr5W3RWgfmDm7IZYAKG8VExZXhdPYKP0serDAMATlC0feYZDDDeTPtbp8zCvS+rqa
         CKHyMOKUPazf4R4WaGS7tEto7Qek7K+DUjNHqIViVGGCohTpC8Up46jkxDwHII297yP1
         2WGNlkcq2kzn1wASTy8bjsm3Wgc35yrAOuDXNsfrjSXnc//48hpS+XNte7cw18QFaLB0
         5JkKNJFUuuEogePWZA46GOKBMw+qOA5NBYluBwlvrSLj90RUlOihtiG5C0lLPkkwUT7M
         SXxGyvrK7vBktUzTGl68WFz5ts2hMGyeXwTm5+E9wgWSufhgjaglZvCVxQ8rGlqUKNmk
         YVmQ==
X-Gm-Message-State: APzg51ArFz3fsl8FpYsVsutCxsoLZFlSTUwHf6N/dgdyFQvWPPaojRlD
        HQ8sihGs7kXqRl2WPGhgznw=
X-Google-Smtp-Source: ANB0VdagMceAF/4dt64PlHd5V2FioplPXj1jm5Ox6g7qTv+gq1mzIe3+hh7seBW3JR3kSgtcqZTAJg==
X-Received: by 2002:a63:a06:: with SMTP id 6-v6mr20446501pgk.318.1535834896201;
        Sat, 01 Sep 2018 13:48:16 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id u17-v6sm24512265pfa.176.2018.09.01.13.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 13:48:15 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH 5/5] io_pgetevents: use __kernel_timespec
Date:   Sat,  1 Sep 2018 13:47:21 -0700
Message-Id: <20180901204721.13117-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901204721.13117-1-deepa.kernel@gmail.com>
References: <20180901204721.13117-1-deepa.kernel@gmail.com>
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

