Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94202C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A252082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A252082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLGVSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:18:24 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:18:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJV9M-1gkiXU0plQ-00Jp7U; Fri, 07 Dec 2018 22:18:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] y2038: signal: Add compat_sys_rt_sigtimedwait_time64
Date:   Fri,  7 Dec 2018 22:18:08 +0100
Message-Id: <20181207211808.328719-6-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207211808.328719-1-arnd@arndb.de>
References: <20181207211808.328719-1-arnd@arndb.de>
X-Provags-ID: V03:K1:jaYEvBfisS0VH6w5saqRe9sT8/XD5lZ11dVe3XVzU/Ndgu+b6m/
 5f0AKwRVduUQJNEgwEsPlH1qf3xV07PTRj6bgLonKVxVhTvwXKjaTTEA74SzOUI88WlUGk4
 DFvuQM4IUYcbVnhTuMZCrBwLvaZxJRCktBLK36xV/Piard5WrCAyioBdghpyNeu2eSTwoFi
 W3HCDot4zg0KIiunb8z4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/KDsyr0jmQw=:DqxU95dJYhhoXYeHZtYGXi
 g9Exk5h5cFbIecgVxX+9WCH07VLNbhZ1RyXnXiH4+Lw/uPt7So8SjfRvjZ37KSDMMMYDs0frx
 xvubZGF9wKeyRHsuLy5TPGRadoSCmAUprQAfKXENgZ6E84UxD4EQJh0XjOUEd5StKUO7aQPgm
 hgwqKiQuDzvXYl+Y83PH5fWO7VaD5C47yu6380li+xVe72uFYn92pK+giga4DTuYuRO8hURpg
 xz+f7xDUnGBD3RyiG1l88mujdC0cYtyiNbWQNBH0Vl1K0oeG8kZhQg92nIFxHeP+xCcXiTRbn
 QhAb/Zj6+B4c2gIZntpyHxZIP/hrImvH5rEc8bixo62C2LNJQ7JRXe68loV7oH+gpBqCfrmYJ
 2xnkAuR0y+8LDaTQGNftp9XE/MyJKeE3NKT7tVr/UvHb5SC1h0TsCkQL/lZ6D9BWICFKuyO3H
 rhLIqHjV0jsjpf0fn5g8ueOuv1GY3jsiuT5nUALzxY8mEg1GSGWOlZ4biMizGKiCvkTnKeWdv
 kx3AGInoMpy6Ndqfc25+IDCPTDHRE0TjnjBFhywcmckzo10Eb1x4F9I6LkTBRIiOjg1ZnkBEf
 ff8BO9o20AmnzehQtNBJBQ3kKeQ/b9QuL9LHQ85GpxeNp6D21Tg48VdJKwvrIleRNVoGapBKY
 lD6JadOk5mCxaPRwvF1qL5fVrnhS9Bdx/b7xTzRF6uEsgptlYsgBE6uFS4mAjlfLerRRoXcrW
 cglDz0j240NbrKFgPvNZozatpUCdglVTXzsLww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 32-bit architectures have two variants of sys_rt_sigtimedwaid()
for 32-bit and 64-bit time_t, we also need to have a second compat system
call entry point on the corresponding 64-bit architectures.

The traditional system call keeps getting handled
by compat_sys_rt_sigtimedwait(), and this adds a new
compat_sys_rt_sigtimedwait_time64() that differs only in the timeout
argument type.

The naming remains a bit asymmetric for the moment. Ideally we would
want to have compat_sys_rt_sigtimedwait_time32() for the old version
and compat_sys_rt_sigtimedwait() for the new one to mirror the names
of the native entry points, but renaming the existing system call
tables causes unnecessary churn. I would suggest renaming all such
system calls together at a later point.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compat.h |  3 +++
 kernel/signal.c        | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 72969d303434..3bc5f218efd8 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -788,6 +788,9 @@ asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
 asmlinkage long compat_sys_rt_sigtimedwait(compat_sigset_t __user *uthese,
 		struct compat_siginfo __user *uinfo,
 		struct old_timespec32 __user *uts, compat_size_t sigsetsize);
+asmlinkage long compat_sys_rt_sigtimedwait_time64(compat_sigset_t __user *uthese,
+		struct compat_siginfo __user *uinfo,
+		struct __kernel_timespec __user *uts, compat_size_t sigsetsize);
 asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
 				struct compat_siginfo __user *uinfo);
 /* No generic prototype for rt_sigreturn */
diff --git a/kernel/signal.c b/kernel/signal.c
index be6744cd0a11..53e07d97ffe0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3366,6 +3366,37 @@ SYSCALL_DEFINE4(rt_sigtimedwait_time32, const sigset_t __user *, uthese,
 #endif
 
 #ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time64, compat_sigset_t __user *, uthese,
+		struct compat_siginfo __user *, uinfo,
+		struct __kernel_timespec __user *, uts, compat_size_t, sigsetsize)
+{
+	sigset_t s;
+	struct timespec64 t;
+	kernel_siginfo_t info;
+	long ret;
+
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (get_compat_sigset(&s, uthese))
+		return -EFAULT;
+
+	if (uts) {
+		if (get_timespec64(&t, uts))
+			return -EFAULT;
+	}
+
+	ret = do_sigtimedwait(&s, &info, uts ? &t : NULL);
+
+	if (ret > 0 && uinfo) {
+		if (copy_siginfo_to_user32(uinfo, &info))
+			ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		struct compat_siginfo __user *, uinfo,
 		struct old_timespec32 __user *, uts, compat_size_t, sigsetsize)
@@ -3396,6 +3427,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 	return ret;
 }
 #endif
+#endif
 
 /**
  *  sys_kill - send a signal to a process
-- 
2.18.0

