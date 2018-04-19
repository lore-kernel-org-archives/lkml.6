Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524148780-2-13392405559984488142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524148779; b=SUNoO/3+rvrPf4OLdijWDo9XR2wm0pToaXGIc4GvqrtVcsnNmu
    D1qcXPGxhAonH9DgzRXnlUVQqSb1pMyNBRUWeULqdMA8mySrLUaV7oR3qXH0mn4w
    43u6tkTnbMh03xb9Q9CZpydPZdbWdWUgWYQ5ogJwg/MbhVId183M4bxRHHRRR83P
    7GB80ZsX/Fhsytt8B+M9zEMHoIT/bj5kHu5F6dVBTr1vBIb6YULPSF1DZcMWUw/L
    k7h/p30cna3gty26rjYAFZpjHu/ysJkfaG08D1mwBThl+/wxFSZK3/K2nyUtzrCn
    IDDwaFkNBJh1hyIABHhh+Bd1+OII8QVU35CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148779; bh=
    l0jyEFY+hkPMnUceLQIWEALESZeX15JkgRWAQrHiulM=; b=ftMhq1Y3nXvWMQjN
    WQdmpo6IrUXd2j8CjWCTNYsVcuEg7eHwZYuTCwJKindHft+9TR0tRH3m6kg9qvzp
    xKqV/nIotqCsKsmC8YzV+/siKQhWrVa4iHk0bXmhDKU143EdjnrF7PSv4SG8ZKrd
    ezxDfwa3Ck65kTCeAtYneMX0ioPnGQ8CvDoleGWhSosA+k7Lg4TmUCuTDQ4i02eI
    /p27/7dZy3D1cNqM0KRQiAwzsmnpI6fFgRFOVEOXbfBgnG/DWRK3gPfZfCYX4/rK
    yR2eBRIuWFg9OxXgPDXOAKVHSPDMwr+uo2rXgVaUqFAQtsNfUwoSbp1737ulgsbT
    8gNkrw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIj3yM7U6a1jyXnujxZeafLalHSJzDP5Kv6KqxrzByGgv2bk4FO1wlgMpCXSh4T82Zmi+jNrSsfB8z0CdAMMgzwmzeDpykNH3Ct4+8QOq4a3JDuWQdGS
    AVxZhFvGJEdOuFyBXvebbAPTzjqXSjevKUFV7pSfK0dbB+4ZP3PfmnhryZ3+GLdFroIHHWWjbEuXRdVsFySXnbK6bg9vgPulJe0l5yPnTDqYE1ZKkd/EKWho
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=uoltoFHUlbKcE8_BlpwA:9 a=5m7Ad2VrR9ME0qSz:21 a=arKeV7zCrVa9cqf6:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeDSOjW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:39:22 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeDSOjU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:39:20 -0400
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
Subject: [PATCH v3 14/17] y2038: ipc: Use __kernel_timespec
Date: Thu, 19 Apr 2018 16:37:34 +0200
Message-Id: <20180419143737.606138-15-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:ZKYAuxGMajmvaIzfwCYhsflzK2XPcYERcA468TieefZU0vLGepf
 2Wkz/HafOKlcUAFLzYD6udPmDsM4igRQ/uZeeH4BUCYDLRKQrHXMrNXHy81qCzVtqu8vyib
 Ej60fgyqLctnHauTwS87L0KUPZ0gsh/r+GKkP4ajkDdAwnGI2bENXQy0ps800t8LhB1TklK
 +2gYPRu7eB9PsIa0tiEZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l+iPWJPC3Ww=:pRP4OdoG+L/xHdLq5sx8nH
 ZEjmszxrElDS4mrhmDfVuwsWQQIcmXTxMPYYJPBfywlkPTOYDOkBVvUid83ExOG1NpoInac9+
 NtnVPiNQdiU7fvJF4Bu/aRCqCJRcPjqPNpFpVQyYxb/UlYSPv7xKcz86uSBGbjUsErUzaAuox
 ETVykYxFODKrZ/JGrlu7009d58rwCKzqYh/popmsB3odf/J6+JFpGIanjwdMxvkbBX8Dd7rc8
 7TiXdK5LhYgp9iKvzwAylR5h8EE5AfQH3V5VBMXdVYN/uW8KpG6ccWvyO+gzs1nlTa40Dv8MO
 BHUUxDny8CwA+BNw8Ayi+T40Ggj19duYs/p9DE3rakubI5NgETmKB772YZAoogzo6HoIh5jkU
 rNBbirHafjlRZhzKyik607r2/XaFxVeHqn+D7Ph02hqPZX4EiNAYsDt7B80zrOOJ/q8C0MDbs
 vZycorTJplY1842oJYoEPJCDfPgPOsMcNiINo0lcmV/IYgnaKIkaDvT/MYcIFd4s3k9fhn0g9
 SJSXKjp1om6EvM11S9zOfU1BFbRjCNDaDCfEisWPkQr/cM9oFmnYho3Ug/KCfUstMgnVfAK0P
 1xzCQEFOWa5MvXDU2YofbMMUZtGN/MlrXWZaQOWNtzthMgx+rk9FNHPIvzEKNss8QxgufJwuJ
 cnfKGd632K9MeC8AFcDTKypzd2LavyAtd7ZQP3YyC8D1F7nyEaRrSOMz0enMG1TDWCWuOEgJ7
 Wx//PEk5yXaiY/kbl8qxtMqKCS+jk852IQHwWg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a preparatation for changing over __kernel_timespec to 64-bit
times, which involves assigning new system call numbers for mq_timedsend(),
mq_timedreceive() and semtimedop() for compatibility with future y2038
proof user space.

The existing ABIs will remain available through compat code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 6 +++---
 ipc/mqueue.c             | 6 +++---
 ipc/sem.c                | 4 ++--
 ipc/util.h               | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c9a2a2601852..b92cb79d38c3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -680,8 +680,8 @@ asmlinkage long sys_sysinfo(struct sysinfo __user *info);
 /* ipc/mqueue.c */
 asmlinkage long sys_mq_open(const char __user *name, int oflag, umode_t mode, struct mq_attr __user *attr);
 asmlinkage long sys_mq_unlink(const char __user *name);
-asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
-asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct __kernel_timespec __user *abs_timeout);
+asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
 asmlinkage long sys_mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
 
@@ -698,7 +698,7 @@ asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
-				const struct timespec __user *timeout);
+				const struct __kernel_timespec __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
 
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a808f29d4c5a..9610afcfa2e5 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -691,7 +691,7 @@ static void __do_notify(struct mqueue_inode_info *info)
 	wake_up(&info->wait_q);
 }
 
-static int prepare_timeout(const struct timespec __user *u_abs_timeout,
+static int prepare_timeout(const struct __kernel_timespec __user *u_abs_timeout,
 			   struct timespec64 *ts)
 {
 	if (get_timespec64(ts, u_abs_timeout))
@@ -1128,7 +1128,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int, msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1142,7 +1142,7 @@ SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes, const char __user *, u_msg_ptr,
 
 SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 		size_t, msg_len, unsigned int __user *, u_msg_prio,
-		const struct timespec __user *, u_abs_timeout)
+		const struct __kernel_timespec __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
diff --git a/ipc/sem.c b/ipc/sem.c
index 8935cd8cf166..b951e25ba2db 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2176,7 +2176,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
-		     unsigned int nsops, const struct timespec __user *timeout)
+		     unsigned int nsops, const struct __kernel_timespec __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
@@ -2188,7 +2188,7 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 }
 
 SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
-		unsigned int, nsops, const struct timespec __user *, timeout)
+		unsigned int, nsops, const struct __kernel_timespec __user *, timeout)
 {
 	return ksys_semtimedop(semid, tsops, nsops, timeout);
 }
diff --git a/ipc/util.h b/ipc/util.h
index acc5159e96d0..975c6de2df9d 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -251,7 +251,7 @@ static inline int compat_ipc_parse_version(int *cmd)
 /* for __ARCH_WANT_SYS_IPC */
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
-		     const struct timespec __user *timeout);
+		     const struct __kernel_timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
-- 
2.9.0

