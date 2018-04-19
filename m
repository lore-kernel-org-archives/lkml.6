Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524148971-2-7218949390418701648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524148970; b=IVwUN1OQBG0P3MBU3R7sbjRcTdGa9FzieaKnAGpsj2yOpFu4qv
    KC5tibsd75kIvSb+v2F3w6ANGre7cQIofUKNIvglmVTadLH70nFp9l3/1Hg0JZdV
    ISxtEqsXyZg3PmxUNNCAxFLcIlxiIwB5WfqRbNvZy8NU1T12JJLsydCb1y9bwn2r
    jaN7BtGLVK1jkEnwskuoIdHszdtKfrtssSnxSzVWQ4mdyUNfRDIMK2WJm+sC0EU5
    d8918deiODuGsQSt6tDlsPqccYkpWnlPSovKwq03dkx+LoqJZhpg1ByiWKM7gHGJ
    +zmP7S4XdsNShqrSUllwdNua4njx27sC3/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148970; bh=
    /7cjMyPyz/2ilGwrBzZk/va2y1xHCDn/1ucxs0b4Jt8=; b=KV7ox+eSvHfbKqIc
    P9pMCUH/nG57wJlTwI0/0t14Kr5QTUPkPAsRfsXCr/IzP69ggJLTw9r8WPYYq4yM
    sZA9xZCbluFll5+hDABB8i1aFswRgXoRRXJeqXipxFCr4HjRbhyycf1XrSeqCWqG
    cJwNsXEcTJapsZK/9XXaFtK6X273yuBH3leBJKw6gcdIsiovbjS/B9wNXQHMC2yh
    BlfbigueMY712GUMhTWxN1lca4BmNAYDyTmOQxrgzgbdfrjLj+VuVczt9JwNuyfO
    v5Vd6GyU0F4qDYYpaJZuMissOejhjU64PlivSlL8H8SrHb1gkqGweIoaZ7HRsDM7
    ZKzXhg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD+G3O350Y10wN0XkpBLWSByEPzI8K/xYSwd4rftuUIUhygkLhnMNeJj6polWIMX+hiMEEiuR/Qmd/SXKIhB1omYs3tqKf3JAMWFhaNOUnlo/ZJxQSRb
    PI8fYu9KSHd51q9ZWfGZlLBryMFoK4nBQ1J2m+0w6W5L+0AMdq8Shtd4fyZyeqtenrG/IbaAJD351cBoHzkksDCYYlWMiL6i7dyqfaPsTmOtokRbcZloO7OZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=Atj0wPqo01Ckh-GV-4YA:9 a=PSyshAn7aqplwmko:21 a=XUQPuvub0HF8LQCv:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753613AbeDSOmh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:42:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbeDSOiv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 15/17] y2038: ipc: Enable COMPAT_32BIT_TIME
Date: Thu, 19 Apr 2018 16:37:35 +0200
Message-Id: <20180419143737.606138-16-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:hTc/tiy+Hysq7Qezx00qPc3pSW3JxV9JMzmbP4EF+StwAcj79kc
 0TMq2vq1ymiJZHIxBh2mRObbcYc3Jl/AssGWTR0N0UAOSENbGWY4OOUG+WB7T8eJlbNuXDf
 EPrNYNJVCS55yz6uGdXKcbK+k0HzUyOwnxwmHsY8Ax5PT+eeh8wRjVS1rH45CgQHRkfp28a
 S/3OM/8MDTzrB+HtmZyrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:28YI5D+IHS0=:xWOSR6zBUn8BQ/UqyYRXhL
 2jZ4Ua5Tfz9y0nGYuNgtJ9AoCf9UVNlxLpbksG0+sz62morHm8WPh3bFcloBjOtBrSOUr/vPG
 DhWUmefNuknVVKQuU4o/SKwwfiH7kMuQX+ZjQP2U7OmH+OnsrEUi4pAU/GpmJDw1+qXMb8M5F
 W/gGGNG0MmcZT6KcXRkibJFlATILysA2vPaIC9NFHW18BEoIvPdnRMW/IdbxxuzO1KJl0Kpvw
 LA+SsUdEVQqcAZYYv2QeM7MpebnMa9uzx8iGyyOqpQODHQ5zsJbm+057hZLmy4BcDVwvJgegB
 p7ttbRHoJxZmSuD+hSWZQAXSoLqRHJ1fAzLcrROj0F7D7XmgC7Nk9duydcz2tasnKj5ewVXn1
 VITs/xOJttlXqNsGlFsw2dzpOG7SlDOuQ9Ufo0iS0sCj+xqFCEVdlSjB/KmPTS7aEeZU2jnib
 tyDfbE5G2DAt7k6CngpfxCGzCvSIi/QnhVRFJfLoTm4e+a78viD7ju8kMhUGx8IMijdKR89Tk
 sG4xFXBUB2v2iQ/4IzISz2jPK67F5LyVl2AY7dyE1dunUwbATjPl6OAdKVp7Sb03hin35+S52
 pqzB073jE4UpbbeZWd/xK6Xlv0xmOWQooe1DptZpGLTJpg1JvjE1+cvVF3AnA+S6AglSphNXY
 ehylfKumwMRdgYeuwfQGzJ7KEy+QNKGtTQh37Q8B+2nMycuNvNE/VU4vX1BmlewA11eET4EmW
 3JshkqEEpZa2OxYUdnRuu9OsKgy5C8SQB1uUfw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Three ipc syscalls (mq_timedsend, mq_timedreceive and and semtimedop)
take a timespec argument. After we move 32-bit architectures over to
useing 64-bit time_t based syscalls, we need seperate entry points for
the old 32-bit based interfaces.

This changes the #ifdef guards for the existing 32-bit compat syscalls
to check for CONFIG_COMPAT_32BIT_TIME instead, which will then be
enabled on all existing 32-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/mqueue.c | 80 +++++++++++++++++++++++++++++++-----------------------------
 ipc/sem.c    |  3 ++-
 ipc/util.h   |  2 +-
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 9610afcfa2e5..c0d58f390c3b 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1420,6 +1420,47 @@ COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
 	return do_mq_open(u_name, oflag, mode, p);
 }
 
+COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
+		       const struct compat_sigevent __user *, u_notification)
+{
+	struct sigevent n, *p = NULL;
+	if (u_notification) {
+		if (get_compat_sigevent(&n, u_notification))
+			return -EFAULT;
+		if (n.sigev_notify == SIGEV_THREAD)
+			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
+		p = &n;
+	}
+	return do_mq_notify(mqdes, p);
+}
+
+COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
+		       const struct compat_mq_attr __user *, u_mqstat,
+		       struct compat_mq_attr __user *, u_omqstat)
+{
+	int ret;
+	struct mq_attr mqstat, omqstat;
+	struct mq_attr *new = NULL, *old = NULL;
+
+	if (u_mqstat) {
+		new = &mqstat;
+		if (get_compat_mq_attr(new, u_mqstat))
+			return -EFAULT;
+	}
+	if (u_omqstat)
+		old = &omqstat;
+
+	ret = do_mq_getsetattr(mqdes, new, old);
+	if (ret || !old)
+		return ret;
+
+	if (put_compat_mq_attr(old, u_omqstat))
+		return -EFAULT;
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
 static int compat_prepare_timeout(const struct compat_timespec __user *p,
 				   struct timespec64 *ts)
 {
@@ -1459,45 +1500,6 @@ COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
 	}
 	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, p);
 }
-
-COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
-		       const struct compat_sigevent __user *, u_notification)
-{
-	struct sigevent n, *p = NULL;
-	if (u_notification) {
-		if (get_compat_sigevent(&n, u_notification))
-			return -EFAULT;
-		if (n.sigev_notify == SIGEV_THREAD)
-			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
-		p = &n;
-	}
-	return do_mq_notify(mqdes, p);
-}
-
-COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
-		       const struct compat_mq_attr __user *, u_mqstat,
-		       struct compat_mq_attr __user *, u_omqstat)
-{
-	int ret;
-	struct mq_attr mqstat, omqstat;
-	struct mq_attr *new = NULL, *old = NULL;
-
-	if (u_mqstat) {
-		new = &mqstat;
-		if (get_compat_mq_attr(new, u_mqstat))
-			return -EFAULT;
-	}
-	if (u_omqstat)
-		old = &omqstat;
-
-	ret = do_mq_getsetattr(mqdes, new, old);
-	if (ret || !old)
-		return ret;
-
-	if (put_compat_mq_attr(old, u_omqstat))
-		return -EFAULT;
-	return 0;
-}
 #endif
 
 static const struct inode_operations mqueue_dir_inode_operations = {
diff --git a/ipc/sem.c b/ipc/sem.c
index b951e25ba2db..cfd94d48a9aa 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -70,6 +70,7 @@
  *   The worst-case behavior is nevertheless O(N^2) for N wakeups.
  */
 
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
@@ -2193,7 +2194,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout)
diff --git a/ipc/util.h b/ipc/util.h
index 975c6de2df9d..0aba3230d007 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -265,10 +265,10 @@ long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
-#ifdef CONFIG_COMPAT
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
+#ifdef CONFIG_COMPAT
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
-- 
2.9.0

