Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E56ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38838208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWQIAKG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38838208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeIQGaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:30:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46257 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbeIQGai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:30:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so6716052pfn.13;
        Sun, 16 Sep 2018 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KG9abdepOmoFPAcSzJxIV+MRBaWtlKYKyiFP9mecLSM=;
        b=CWQIAKG+212BEqjwv4lU6ootpFNAjl7B5aCWLLa12CIAZSg0snGKF2PPywe6Wj1m4j
         Dq/DoWMgFTHsX+F1ptbLE8M1N7rHMtGnKgQsdOi8cxrhF1BZmPG5NMH8gNh1qbeXFu+u
         DkYcnwH6dAkwDjY4wz060eNkSjpHuDOAKMoT3erKda95+VPtCRUatsZdOfYHAG5ooAcc
         ko4+3WGlhWxcb0xPmbU9Y/Ytoe9jmygTBx23We3+BeOWWfGR5NZSLfPE1HUnsuTgzjTJ
         h4LJ06FSbZgFQq0WTJKuZF3ev70G7jtThQPGTwttKHrnAR7DgSi+5UvKKXS8yAFpUGlM
         74Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KG9abdepOmoFPAcSzJxIV+MRBaWtlKYKyiFP9mecLSM=;
        b=IPVP+pTpg2cfutreCi5ARWnllD7u8LrQoUvj0wCtDU8E+/50DbwpDbk9Z8Uco6y2X2
         s/uCB3Q22EUDasOFAcIV2lXRg7L9CxSKnkZRkcxnrtWkl4WqMOOeMTdU1mc8LdUV8ss/
         LHbpB2WrXocyzCyEjpLSE1efuEvbbMj0a0DuRaiHmItyqiOFJg71a5yIDZWyxan3ldY4
         1Nx73jSkNf7+j/3NwD4SnYUrfhrp6hSWdJlcfTkEiKBlrUwk5/TI44AYm7+DBqLJIDUA
         VmJinaNrajRs1cffH6w3RCtzehC/4pCAkLqTU9DDhMx+IcwQCs2q7sPFPSj4aW3KENnh
         5bNw==
X-Gm-Message-State: APzg51CODsPY8bD8XNw46GRC7uiFl1PNYN4x4QkofSqLWrOsp5N1qbr8
        rUL8HcBj1HPUE3Z8lK6UpP5nvbG4
X-Google-Smtp-Source: ANB0VdZlaHX3trG3tBt+Py3Vqg5IFZ0t7jOh6iEnp3OMecAKX/sAjEMKqsIVLORCPho9t8tvUSOvCw==
X-Received: by 2002:a63:2043:: with SMTP id r3-v6mr21258449pgm.105.1537146342947;
        Sun, 16 Sep 2018 18:05:42 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id b73-v6sm21135598pfj.93.2018.09.16.18.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 18:05:42 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v3 5/5] io_pgetevents: use __kernel_timespec
Date:   Sun, 16 Sep 2018 18:04:58 -0700
Message-Id: <20180917010458.23159-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917010458.23159-1-deepa.kernel@gmail.com>
References: <20180917010458.23159-1-deepa.kernel@gmail.com>
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
 fs/aio.c                 | 85 ++++++++++++++++++++++++++++++++++++++--
 include/linux/compat.h   |  6 +++
 include/linux/syscalls.h | 10 ++++-
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b81c216534d6..72dbce38a628 100644
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
@@ -2173,4 +2219,37 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 
 	return ret;
 }
+
+#endif
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

