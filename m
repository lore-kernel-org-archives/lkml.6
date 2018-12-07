Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357F220868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357F220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLGVSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:18:43 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeLGVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:18:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mw9Lw-1hN4Yp3l8m-00s3Tc; Fri, 07 Dec 2018 22:18:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/5] y2038: signal: Add sys_rt_sigtimedwait_time32
Date:   Fri,  7 Dec 2018 22:18:07 +0100
Message-Id: <20181207211808.328719-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207211808.328719-1-arnd@arndb.de>
References: <20181207211808.328719-1-arnd@arndb.de>
X-Provags-ID: V03:K1:9/bXOgXlO7u0sJ91CfOocMwpttHH+17Xfkde7QGcqXCtXbRVlQA
 aCxKzXNfyUMgkD/nEzNaRk6f6zxGFgltNuujLCwBsz6QRGW9tEs58FnD/vunLWBOs7L5XDY
 CeVGkPbfnpP7YIlgQgFreUF/0MvL2y8MZgcMyDTqq+OV4WtBb7Pcq0RRVKniP69gIbUY227
 tOGU9aTjSsfho46XO/L+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZYi/Jb0Y4ww=:FOp45kB5zlBpwkxzYpmhaM
 J/hZGky1w0Q0yc97fAZMHtDHgOfYpkunNiuXthtUdUxJnEnbjAQVj5kJG7gvEYPyRaaJFUWs1
 aQwDLMbC4pKzSmyR4OgfjfXQCS+Jlf+M4fRweMoXR4UlNy53hyY61zYZmtCgcwmDUd1Obx2cn
 NcBT6DrskLhQcL7EktWayR7xDHDlXX8XodcMjaVwXwxnpqTG7CLDulzVhQvTKb6cyavteR60y
 yax+3kEUBsdRKQvCB3Sm/Pnhy2RWFCVl2Ss9JRlAN4YHPVijV3n8WmDQXmvVhdbCKF15p5S+C
 lbKQf3rbApAJ0XcGeOEyD1l/ozkU/5n4nUp5ABH38CoJerpPlRq8tHlRdXVIcs4GgG64TrD9K
 BF6+UE01Xdb83HkjGWN7WV2SyfPv6JHAI3FwGn1hC/46XnfkCpEqzW4WdKaN1zkonbvkA8eOM
 f9TG8UaKlkdTD6FZq9rRcDxQCxJ2wRRdEmBF0YeU18t/HZ8H4HrBRwUZWbf0fUDlP+UF+/G25
 p5Cb3H+OgtzliyO9OXeQjSMEbsvsc8kfmEWuvo/42pHVbcqtB5Nj+zIc+UqggR6iGDcXLfA+K
 Zxn5o+0fV4uaqsD3kZrsX5dNxoBltBp3Uo7bdR0iXi/oyF0OGxTZiXsJ2Wy/iS4WLMxxh9ntK
 FhNpbs4+H4pMTppNeLbCib8FGRmAjL/AVXWF7/T6i5M9HmUOFv0TFaHhYpfZdxVAuwOo8iuPA
 eNu7aFdDJNjhp16YPsTRHbq4d+9yaYj51fOfTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once sys_rt_sigtimedwait() gets changed to a 64-bit time_t, we have
to provide compatibility support for existing binaries.

An earlier version of this patch reused the compat_sys_rt_sigtimedwait
entry point to avoid code duplication, but this newer approach
duplicates the existing native entry point instead, which seems
a bit cleaner.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |  4 ++++
 kernel/signal.c          | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03cda6793be3..251979d2e709 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -649,6 +649,10 @@ asmlinkage long sys_rt_sigtimedwait(const sigset_t __user *uthese,
 				siginfo_t __user *uinfo,
 				const struct __kernel_timespec __user *uts,
 				size_t sigsetsize);
+asmlinkage long sys_rt_sigtimedwait_time32(const sigset_t __user *uthese,
+				siginfo_t __user *uinfo,
+				const struct old_timespec32 __user *uts,
+				size_t sigsetsize);
 asmlinkage long sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t __user *uinfo);
 
 /* kernel/sys.c */
diff --git a/kernel/signal.c b/kernel/signal.c
index 3c8ea7a328e0..be6744cd0a11 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3332,6 +3332,39 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
+SYSCALL_DEFINE4(rt_sigtimedwait_time32, const sigset_t __user *, uthese,
+		siginfo_t __user *, uinfo,
+		const struct old_timespec32 __user *, uts,
+		size_t, sigsetsize)
+{
+	sigset_t these;
+	struct timespec64 ts;
+	kernel_siginfo_t info;
+	int ret;
+
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (copy_from_user(&these, uthese, sizeof(these)))
+		return -EFAULT;
+
+	if (uts) {
+		if (get_old_timespec32(&ts, uts))
+			return -EFAULT;
+	}
+
+	ret = do_sigtimedwait(&these, &info, uts ? &ts : NULL);
+
+	if (ret > 0 && uinfo) {
+		if (copy_siginfo_to_user(uinfo, &info))
+			ret = -EFAULT;
+	}
+
+	return ret;
+}
+#endif
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		struct compat_siginfo __user *, uinfo,
-- 
2.18.0

