Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69EDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F7D20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F7D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLGVSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:18:21 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGVST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:18:19 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N6KML-1hXEVe16zZ-016eTl; Fri, 07 Dec 2018 22:18:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/5] y2038: futex: Add support for __kernel_timespec
Date:   Fri,  7 Dec 2018 22:18:05 +0100
Message-Id: <20181207211808.328719-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207211808.328719-1-arnd@arndb.de>
References: <20181207211808.328719-1-arnd@arndb.de>
X-Provags-ID: V03:K1:7ftGwTPI7nF5tkVyrja5NNO8XIM3pe9wwKW0ivr2EU7CWAR7+sJ
 HNlClwPMuAFys8UuHBQ8XVzUZPxvyoUwUYSmHgMcm5M2RHVe0Ko0liKUc5Sf6yXL2T1wcl6
 +4aUBv0+pmN2/m3i4kS2ikZfyMvprft3rNiGo+FGJVBYc+lcyMApCz1fidszd6Oznu99YG0
 iqxpFDS+Kwss9rPv0bPQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E5NpT+phjsU=:P4Ju90ZAdT3wAhcNFqTgPF
 8kD2ckQI6TG/iR5mudT5GuZolIXK9+Vydv9z4xVuhUrQ14rCGPlCaIcevQe6Sfi+cLyV1aQyU
 KbkfWQdC1XWX2sSQSRz/hmxBgC7ykqeUwtw/ajywquDNipbQk0h1tvpiP1+UkpD8WCwHdEymg
 im50plQBOhKRe5jZa11bbiCn5cn+KDkHw1aCCbzHFSb62kqEuiWhGAfXOPECSsYqMUXC+NAvi
 EXLkO0z9Q9Fpfa7FsehGHpXcbokjy7rGQ2VM8uJzzFVpEe5tACPrc6uyoJccXsjAm1iqez7DC
 0kJUp2D2nQ0xMb4R12OhMhpFA0hdrCDi8dIAWXTAtG0YQ0QtSq2Tmj4u4Sg1XWjTL30Th2Uqm
 kWnVf4SvNzf1gaW4eH1LxjDFSpi2cPzuA1PxzTHuPlH/35orgXjiuYywwLowMpaAoYReEU6FQ
 A/Wswtkj1FY5FdT7j3nwu9B+hND9PqN9DkjDvQjGPvuUKitH+xRsLSWQGZiA0G7b0NtYxC1V9
 nAhkLiGbZZHbnTsQnouMs3nui/lv2I0Udps21cNfMIRenbD+bncNj/i0dMHNZhgoox67Q2jUz
 1z97Fzgq95IcbXlZzxg8D2V2AaF3uGBnuwiky/x5+Prk+N6Iy5Q8UcO7yRnTPP+HyUdcYr6cp
 UiCdB/uxYPWJi6H0o1AuBzRfbsmaEJYeyAlGjDxfEwm03WUvADluCg+5vGa7UBZmNVZ+R8T/C
 kTzF43/O01HePHZT2rrAb20Wr5lKKfPUPET2WA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares sys_futex for y2038 safe calling: the native
syscall is changed to receive a __kernel_timespec argument, which
will be switched to 64-bit time_t in the future. All the internal
time handling gets changed to timespec64, and the compat_sys_futex
entry point is moved under the CONFIG_COMPAT_32BIT_TIME check
to provide compatibility for existing 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |  2 +-
 kernel/futex.c           | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a27cf407de92..247ad9eca955 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -553,7 +553,7 @@ asmlinkage long sys_unshare(unsigned long unshare_flags);
 
 /* kernel/futex.c */
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
-			struct timespec __user *utime, u32 __user *uaddr2,
+			struct __kernel_timespec __user *utime, u32 __user *uaddr2,
 			u32 val3);
 asmlinkage long sys_get_robust_list(int pid,
 				    struct robust_list_head __user * __user *head_ptr,
diff --git a/kernel/futex.c b/kernel/futex.c
index 5cc7c3b098e9..b305beaab739 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3558,10 +3558,10 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
-		struct timespec __user *, utime, u32 __user *, uaddr2,
+		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
 	u32 val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
@@ -3571,12 +3571,12 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
-		if (copy_from_user(&ts, utime, sizeof(ts)) != 0)
+		if (get_timespec64(&ts, utime))
 			return -EFAULT;
-		if (!timespec_valid(&ts))
+		if (!timespec64_valid(&ts))
 			return -EINVAL;
 
-		t = timespec_to_ktime(ts);
+		t = timespec64_to_ktime(ts);
 		if (cmd == FUTEX_WAIT)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
@@ -3747,12 +3747,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 
 	return ret;
 }
+#endif /* CONFIG_COMPAT */
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	ktime_t t, *tp = NULL;
 	int val2 = 0;
 	int cmd = op & FUTEX_CMD_MASK;
@@ -3760,12 +3762,12 @@ COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
 		      cmd == FUTEX_WAIT_BITSET ||
 		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
-		if (compat_get_timespec(&ts, utime))
+		if (get_old_timespec32(&ts, utime))
 			return -EFAULT;
-		if (!timespec_valid(&ts))
+		if (!timespec64_valid(&ts))
 			return -EINVAL;
 
-		t = timespec_to_ktime(ts);
+		t = timespec64_to_ktime(ts);
 		if (cmd == FUTEX_WAIT)
 			t = ktime_add_safe(ktime_get(), t);
 		tp = &t;
@@ -3776,7 +3778,7 @@ COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_COMPAT_32BIT_TIME */
 
 static void __init futex_detect_cmpxchg(void)
 {
-- 
2.18.0

