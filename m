Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524148998-2-8156997837833823888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524148997; b=nN7C2qKYIOweDat1bGwi1m1WUr/hYM2kOmwF4LaqQpDkx4ekS2
    IS7rDqyw0eFk63hxBLfyVupzblRxT+Zpd6FCSM0sdIjfBbWrFEGXTGWwmsrXFeB1
    /oL1ZcHulfHo+XiUFzIF0CDbkZ7f61FjIU93tJdHEgNkLQGbqnQgEo/5N+vyoTjy
    eFi37qaT70KgdlwrVORloS3dg7+N9qEfbOU4woHfnEftvGmFJQo5YCV3hlhTVRtt
    FFqU7aNKZtLS8vkNwpOU09e/mXaOuqUdcmU3Um66Izdl5/qIBmoyPN1N5n8N9oQ+
    6m5Llqrx3wBv+XpVay71L0zJ9yDMb0T5xLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148997; bh=
    o0tR1e+eBQPV5jbS0xxBWb4mTZcW/DooVkUVHXFw0gw=; b=gLu9OfpDNsdyizPo
    YIAORL9tJxkeKjjSLMeYVh7pGXxfWlJ125eNsp5lpDrtIvymiPvEmRh1blFvM6yK
    VE3E4qqeWR8ILTl5IAHGtHQZBZU1u9aZxwI/lXd748i9TZDz7kWAQtMIkiqpRXt2
    h3LTeGZHqMPMypY0h1X3bmBLe/jHS/P8+E9Q5vizzswuzjt/CvBqCrv/gvhfWOPt
    Q/H9PrFAw8JGLtL0HvA/Toe/aERgUHn37jKWIXCVxo/DiEQ9Og/qT0BnLD5Z+ovb
    8U7Pb5YlvdcCjKXAX93pf2cgyMOJwl66IVIb4xqXStpCQd0h4aElO+f3S9ajKodi
    KFzgkA==
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
X-CM-Envelope: MS4wfOpTWRuMLVKCbZ+9Wwgllb5h6uTxo1uPVyTqa+jaYOcIvRU7aCxJPFs4FLGk077SZvgB4vIw69hFgqdTg4oqzaMVsd7Jx5y2CHmCEuCwVv7gF6bRPGx4
    MbUblcMgEj1HV1cCO1wgGQUQZ479brtD2e0b5N1iJ+CMzjJC74JG/dUhQ0pghOEt2rMqUusKyIBF+yg7UnyIXp3tstBubmL3i2HdWpprOVdzHRncY3craQ2n
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=9aIODNJXDyEBx6x27aYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDSOnM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:43:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDSOit (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:49 -0400
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
Subject: [PATCH v3 13/17] y2038: ipc: Report long times to user space
Date: Thu, 19 Apr 2018 16:37:33 +0200
Message-Id: <20180419143737.606138-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:3A5M6Zx0aSI7FLgzswFugGqVRIPzZO9S1bYu8R0NYJoypyo0ad7
 b7z06cg8/ZlV3L6cRq418zAr9FuQF5ziKPFEysSL8OBRemybuT4Vzo1SYFagBR1XgOEHO7H
 CMsi8rcOg0L02HTgdxn2el1BV2MELg8r6FCs4s0LU9naq+n8UWpA6uxawxj1kTk4CUP8R/T
 FouJ1HNyvhJfHxzLyIq6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gxdyLn+WgI8=:QrwmH4QYo+vDf32UyJdn7U
 GSXwOq8Z1P7oZctcw2SmS9F5NIQmA0QoW4HwdLoapUoWwk/u8gl7dIE1rRkTMnaHq4j/fGxPo
 hOk4JleURV63Logc0B8S1Cg40e4uLjhoQb18E27t0iANqBK6qEIYhQBAFt/1v1Uf08kG2PFF2
 jerMAjzenIdfTTE2EPhmO0I/q9a7+K+JH6t49M2eEwV+KnEPvip8TROI6rrgheWzfYTspKmZv
 oM3PjuC7K8J9PBGzlbyUC1Sbh5+c4uTdJpLR/1FP3PFCChiCP3+5aidqaKeksqFaQLlKZKHwA
 oKcXDoJ/VvjVfodTK0nC5V75BAkAzAsSAcfJZ57jU0jZgQ7NSJPiuUzrRO+flHJhgvwZWUKcz
 OqrkZR9cA6dn8Ixql3KIAGaFJQ+EgMsDxJIbjtJrm8aAMN6hzkL8CtGSS44JUx3Uut+nAJVXq
 zFn8dlpNU+5Q7RBIm9/uYgAJU+Tn9Iw2vOxrQrJQd9HrkgqTCwdKgJSYi+Ln7BRP2Njg54f3P
 gFgTEKRnrCf/3ipwryqF+06ElwS5qGmKFhUL1Lb+YKsyqgwMJ28krqyHeje9ZTYIe1wQfH2c1
 zgGOg7RQd9CWXv4b8OKcv+BS+8IXsCi9pLW3AxaC2S64mz+5Fb9ymNfbH0GnQuyCTRO5FSu1R
 1zHcMUlI33FRxF6KJmfI6q3XHKaFgG1XRS820YwMaFhxt2bTgWie/p3f0wWuDk6sCRdtde6/0
 op3uJXKZvCvI42H8ci3022Ijj8oeqLWvpdeOow==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The shmid64_ds/semid64_ds/msqid64_ds data structures have been extended
to contain extra fields for storing the upper bits of the time stamps,
this patch does the other half of the job and and fills the new fields on
32-bit architectures as well as 32-bit tasks running on a 64-bit kernel
in compat mode.

There should be no change for native 64-bit tasks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 14 +++++++++++---
 ipc/sem.c | 14 +++++++++++---
 ipc/shm.c | 14 +++++++++++---
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 574f76c9a2ff..3b6545302598 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -537,6 +537,11 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_stime  = msq->q_stime;
 	p->msg_rtime  = msq->q_rtime;
 	p->msg_ctime  = msq->q_ctime;
+#ifndef CONFIG_64BIT
+	p->msg_stime_high = msq->q_stime >> 32;
+	p->msg_rtime_high = msq->q_rtime >> 32;
+	p->msg_ctime_high = msq->q_ctime >> 32;
+#endif
 	p->msg_cbytes = msq->q_cbytes;
 	p->msg_qnum   = msq->q_qnum;
 	p->msg_qbytes = msq->q_qbytes;
@@ -646,9 +651,12 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		struct compat_msqid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.msg_perm, &in->msg_perm);
-		v.msg_stime = in->msg_stime;
-		v.msg_rtime = in->msg_rtime;
-		v.msg_ctime = in->msg_ctime;
+		v.msg_stime	 = lower_32_bits(in->msg_stime);
+		v.msg_stime_high = upper_32_bits(in->msg_stime);
+		v.msg_rtime	 = lower_32_bits(in->msg_rtime);
+		v.msg_rtime_high = upper_32_bits(in->msg_rtime);
+		v.msg_ctime	 = lower_32_bits(in->msg_ctime);
+		v.msg_ctime_high = upper_32_bits(in->msg_ctime);
 		v.msg_cbytes = in->msg_cbytes;
 		v.msg_qnum = in->msg_qnum;
 		v.msg_qbytes = in->msg_qbytes;
diff --git a/ipc/sem.c b/ipc/sem.c
index c6a8a971769d..8935cd8cf166 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1214,6 +1214,7 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			 int cmd, struct semid64_ds *semid64)
 {
 	struct sem_array *sma;
+	time64_t semotime;
 	int id = 0;
 	int err;
 
@@ -1257,8 +1258,13 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	}
 
 	kernel_to_ipc64_perm(&sma->sem_perm, &semid64->sem_perm);
-	semid64->sem_otime = get_semotime(sma);
+	semotime = get_semotime(sma);
+	semid64->sem_otime = semotime;
 	semid64->sem_ctime = sma->sem_ctime;
+#ifndef CONFIG_64BIT
+	semid64->sem_otime_high = semotime >> 32;
+	semid64->sem_ctime_high = sma->sem_ctime >> 32;
+#endif
 	semid64->sem_nsems = sma->sem_nsems;
 
 	ipc_unlock_object(&sma->sem_perm);
@@ -1704,8 +1710,10 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		struct compat_semid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.sem_perm, &in->sem_perm);
-		v.sem_otime = in->sem_otime;
-		v.sem_ctime = in->sem_ctime;
+		v.sem_otime	 = lower_32_bits(in->sem_otime);
+		v.sem_otime_high = upper_32_bits(in->sem_otime);
+		v.sem_ctime	 = lower_32_bits(in->sem_ctime);
+		v.sem_ctime_high = upper_32_bits(in->sem_ctime);
 		v.sem_nsems = in->sem_nsems;
 		return copy_to_user(buf, &v, sizeof(v));
 	} else {
diff --git a/ipc/shm.c b/ipc/shm.c
index 3cf48988d68c..0075990338f4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1002,6 +1002,11 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_atime	= shp->shm_atim;
 	tbuf->shm_dtime	= shp->shm_dtim;
 	tbuf->shm_ctime	= shp->shm_ctim;
+#ifndef CONFIG_64BIT
+	tbuf->shm_atime_high = shp->shm_atim >> 32;
+	tbuf->shm_dtime_high = shp->shm_dtim >> 32;
+	tbuf->shm_ctime_high = shp->shm_ctim >> 32;
+#endif
 	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
 	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
@@ -1233,9 +1238,12 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		struct compat_shmid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.shm_perm, &in->shm_perm);
-		v.shm_atime = in->shm_atime;
-		v.shm_dtime = in->shm_dtime;
-		v.shm_ctime = in->shm_ctime;
+		v.shm_atime	 = lower_32_bits(in->shm_atime);
+		v.shm_atime_high = upper_32_bits(in->shm_atime);
+		v.shm_dtime	 = lower_32_bits(in->shm_dtime);
+		v.shm_dtime_high = upper_32_bits(in->shm_dtime);
+		v.shm_ctime	 = lower_32_bits(in->shm_ctime);
+		v.shm_ctime_high = upper_32_bits(in->shm_ctime);
 		v.shm_segsz = in->shm_segsz;
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
-- 
2.9.0

