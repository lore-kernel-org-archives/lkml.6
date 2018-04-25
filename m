Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-860609-1524668953-2-553628582435810728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524668952; b=mKCsFdSBQ+LzcAhUzfifxClnQ9w4/ep2xJyrN43DzJkp1xrgPT
    E6HRMdNvPhd2rz3ew5ahLfz8Q4eUFcmBENt579/HFnLCMf2pgsnso3MOdyWvtAqo
    2iR+ZE07RlK7peGX22xaMzK4KSvRMtvuz4icJMN8AlPc9fuPVdDkiZ+/KH8RO7tZ
    c2YUFPsaCf1b6z95k8OQGVcbg6U0VK2zfup1VmABHi8r1Fzh7q8yC8DeajreinGD
    2GgCuMmcwb6IozU27A1ckd8kidavO6gQY0stO0cCfZEQ/9TnsETGEWtS58SvtsM0
    yfb94VkbaRJHUx+x4a7quuVAog8rNBOv5i4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524668952; bh=
    /7cjMyPyz/2ilGwrBzZk/va2y1xHCDn/1ucxs0b4Jt8=; b=Q01DfW1wnb+qCBPk
    kvTbNbGOIRSgHLkxcSq7qFBuLx39LajTBtB2J/u9YEH0di0H1X0qvPj31LfA3qAi
    srGO+cs0uRNY3flfwaSzfCqqlhuiOLX+QBmdXQg5ncV1R/nKkWGhUhpg4fZ2BYQ4
    aXMXi2pRwnDoXRSa2VWKlNZD/wVD26Cpgs58ZRMpslTlE0IKEFRwRubU/rBozfio
    qDmRf3J9vCMM0dVxlQxrZ5LyIF798JLTlTQcaemMz0AiqQqsgCUexSyW51TBMNAS
    oLPGZ/3wqD3P0rjErhm/pHRhO5yx6Mw5Kj6TQd5dzhTp+bf/dBVLWSjqk0Enfb1l
    DaxGFA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfCQrf3n2Tzd40G/VpYFIDtfSy7nh/aYYjLFpc2tMksYgW8vAJKDj5nb1JYgxqn9JN7BbFJvE9Z28rMyldhPjlZqU6yMdaYjEx+ifPQ1jb9zsw0cyJtd/
    rt67odjlpdvyVjhl4r/4a7G3DoIZNpbxODKwqKBDApY/E1CVUfuMURhWiAWY1V8629yxuRJ9RSYCCpUgk5hoMLOHK2vfMt22Ig8aeA3or4r8FpteNMubrOQf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=Atj0wPqo01Ckh-GV-4YA:9 a=PSyshAn7aqplwmko:21 a=XUQPuvub0HF8LQCv:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeDYPHW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:07:22 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbeDYPHN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 15/16] y2038: ipc: Enable COMPAT_32BIT_TIME
Date: Wed, 25 Apr 2018 17:06:05 +0200
Message-Id: <20180425150606.954771-15-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:6tCC52ZN5lMBDsH8A5lHpvnnmNi/pWQ4wrRgLK1Mh9LOu1Ytegx
 EVeeF/l3mV8FUpsujf6/us6GIJXncibkkfNo2Ax4tgpULuugY/OR8lXBWu4/P2gYpEgacWX
 I31Ms+v8LE2/0ig8YY8syLttjuzk7V+PCOVw7hofqaU5GktlNhnVo22krD6MivnF23gE/bi
 iaOfymJtuk0pAv8n0gf7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fHlRHjI2exs=:6M9QJXCnsgLzIIphLgy2Mg
 YVxcYM5K2sxLJCbBcNLIEfEm0dZiVNxOGDaS1/tNQZig/GW7QaBsq65EJeoiMh5ANiszKwmGv
 wTStsLMoac0cyQOkfsKsFG4EvjKg6jj5dLzoMHzLdeW1Qvbg2L7hXV5hKkJZoEbVEzC7J9fTW
 aY2PtJzJ01sQdOWT5/1B8dTg6/LhNzIMqJ0X9aQh2cgGO/F9mhpaqh0SxDbmCTQJY2GDtXHCL
 htrKOesBEzylpopwX8XepplncHCjgdiZp48PDjU2UiIS2zV4/OCkNDWsv8vViZoGhYYs0dKR7
 wHAKXu3YZF2nGbOLAuCgtQWKpgW+dNHS/UcyI8AnIzxofWzobwN2mvKjtLCsEApml2GU/MVGZ
 uC1cn1PDIB24E8wrxMXL/BB2e/c1TZ0gTX566qKcjbEKqLVVhYDuRoSbf/dLMADW5ifO3oNxJ
 X+75Wo26Nwg3enfLOEnQoIDOiApg3aDX/Hvb3NcF03X1gCwfXN9EkrVpsUBL2gXJVByvnsgXl
 TfdZuMHxP1cZl2/0gxO207YGyol6t4tI20S7ZiWJFjuIOOcl29wIUNvJBya/Ud6rsmHjJgiIq
 w9Gv1HoW9mEXNMB21iKjsdfsE29wux5c06ucCZfCF/9bpF6cjbVu00eaA+hO5bMxADjmph76l
 QpOpMaklFhjnFMco8gwZLO7I/gcmX59r2XxFkLiDQ274yR89JITAwFmvkSDsDGVCecaPRLoVO
 9CMDmxE/+QSAlEcRDnuhAnjqQImcb4Gav8AdDw==
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

