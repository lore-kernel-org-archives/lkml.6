Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669252-2-9901049809981425096
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524669252; b=GhL5xIhUwez3Npa6RTETaEuAKDAHVuxaLvND/74MbqhRmQtxaG
    3xOJzRuVLWSHcPk3tCcawVoMIfjTfehhV1QM44NMNKHnuUFZVT1Xj69XxJeAblxw
    1FT1eh0dssXdLz9k9LqKPm9v6MQkUE5Hw1Fve7N+8XmOcBB4oFZM8UB+1kYW/yso
    CHrG/3kbsLVjZnKJgHpGYhvqBemI3+N28nSqqSa6raFg/eS9UNL3+hoNZPisf3+5
    X5eprpmadUYHv9K6FBzuaPXw3thnnj7YjmG4aebyte5tlBexCpl2rD99N5+Aoi5S
    DkB9lWMIZ9nL7QJsAEh31EbHrypV0zayacUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669252; bh=
    /7aCIcCXVdJLpUPcwlYSkLCpFHX8Zruveb+PNffayXw=; b=KNKAIhozAfgrSQXr
    XDRhphNkYR/ar2BP7AqWZsw0IjT6fIP35dOPskmcmxlpxapqkHWxHMTkagi3V7SV
    bxRIomf5tdAQE+I9KmPgJC0nzuxP6IvdjB9+zcRP5Rj5o6H2XSm3dJ3yzvwv0K0U
    rFT2Pjerutm9aiUKeMaTNqZb33UYkrdotdltTKnbyLXV12rQTwNZyI8esmpwAkxT
    8k6C4/YaPBOdJYgIpHEqrVzRxx81Ia0VjxMP5vEvcHerwKHR5O+pSeWKiA8ilmW+
    tZImIHr0O/7fcqRIsz0rRWAC/GKM5UWSv0cKFDhmnLcjAeWLjIWazMaWI6CuY1an
    nxrQog==
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
X-CM-Envelope: MS4wfHtf1y5KHw0tu8tQVCtsfLMd+6okZm2DjyikhY+vAADhWWABWLKavZM00MObo+CWJyF2ixAYAAvlqSTBOSBDhntBc3XOFSncFOnx17iSDHj69IjayM3B
    8NX24YkraZ9JxwHqgA8kmfgeexq7TW30Pg+gYTJzZkiZRBrWccPN1ghqIBmfT8AKJAuHqZGkil9g+Iy8W4g2HqFX+QO9566VQ1yOezaAi1bzqGavf6jxwg1q
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=vDQ7Dej8Tvy-y2caQbYA:9 a=e_lYM9qDvl6HNi0W:21 a=9n5EW_OoauLO9zaq:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeDYPN5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:13:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbeDYPHI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:08 -0400
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
Subject: [PATCH v4 09/16] y2038: sparc: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 17:05:59 +0200
Message-Id: <20180425150606.954771-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:tLk18dKIGh9ambcNqe/FwCmwXfsZ8dYBXYyM5gql8kEpVaxBSIH
 Lmy1XQ1ksj0jDLxL4xNhTcs50VtQbyXhjXKcsszDRuujGTtKamwCX4KaJp0DI990S0GHyhC
 agKFb0VKFJWYUi3g6d6TOPjzvq2LIpEtgvbUFTbbLgaP/nzX6y9VcO03pNFCxlyrfzZ5F+U
 huB8w1i3MgxPJWkcpl7gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PzUKc9u1xWE=:XSzvdo2ti9w1jTjjG84qD8
 bgcxcjXkHeYnWMkiVkviKTVKqnEooE2t5/dtXsk9b3Gp+T9iwDA8/ZZaWKWwj20DFyDAXSPpl
 Rs2T4F7pbInrLiO7/lhJ267ijTKYt32D6OWJtu+fYu7j0tAdN4rLPntey1EIzvhBP01M1oTHU
 wzr+tRnQFMyj02t7ZDpmKvtw28IbXhZAwQPMEk1EwNWiuCT9Xka07B7FP1FvYF/nJc0oZtLNr
 Q9c1JFrbon/lQntY6JpzRLeRO1FIDZN+00236diQ2JeKmjMf6bZw/AfscQCF+0UMDl6tDuE9I
 AhzPKHojPGBBvzhr0RvJHLPeZ2R/tciXru29074ksukjNBuFr5T2XgrD/0qWdY6h2Ji9hsaAz
 ytskhtHM07AdJOdFnupXQ+gNeovUA/ROBZE4jp9Ijh2d/fv74O3pLh22J/7YLq9T2KrNoNNv5
 DETxa1Y3d2LAkqtWKVdHvgjV8BMnOZgcFru6oOuR9rMDbhJQkve4BvZ34276UYVR9A4UIPLTN
 +VCNLalDLgYhpyl8f0m2wq2NpWUUogjvIJ6ljBqS9q3m03EAldcjmolb9jkXG8ks0/KmbG8vd
 uy3Ed2FxUadDu5J/76Ifv8evBZkS2pNtgWDqyREOTKL5QoJiLy+w2ACXkOctimtNZm3sXvW+x
 ImNJj34NfFLB/3t3Z8HraD43bPBvi8nyR4sfnxv6FgRSKakPoCXwB3jXMxX5YEO9iCx4whmH6
 5xdHo46wYuFxkn6qj7uAhPjkY05n2hk+7FFTSw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

sparc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

Unlike most architectures, sparc actually succeeded in
defining this right for big-endian CPUs, but as everyone else
got it wrong, we just use the same hack everywhere.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/sparc/include/uapi/asm/msgbuf.h | 22 +++++++++-------------
 arch/sparc/include/uapi/asm/sembuf.h | 16 +++++++---------
 arch/sparc/include/uapi/asm/shmbuf.h | 21 +++++++++------------
 4 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 1910c44521e3..4eb51d2dae98 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -192,10 +192,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int	__pad1;
-	compat_time_t	sem_otime;
-	unsigned int	__pad2;
-	compat_time_t	sem_ctime;
+	unsigned int	sem_otime_high;
+	unsigned int	sem_otime;
+	unsigned int	sem_ctime_high;
+	unsigned int	sem_ctime;
 	u32		sem_nsems;
 	u32		__unused1;
 	u32		__unused2;
@@ -203,12 +203,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int	__pad1;
-	compat_time_t	msg_stime;
-	unsigned int	__pad2;
-	compat_time_t	msg_rtime;
-	unsigned int	__pad3;
-	compat_time_t	msg_ctime;
+	unsigned int	msg_stime_high;
+	unsigned int	msg_stime;
+	unsigned int	msg_rtime_high;
+	unsigned int	msg_rtime;
+	unsigned int	msg_ctime_high;
+	unsigned int	msg_ctime;
 	unsigned int	msg_cbytes;
 	unsigned int	msg_qnum;
 	unsigned int	msg_qbytes;
@@ -220,12 +220,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int	__pad1;
-	compat_time_t	shm_atime;
-	unsigned int	__pad2;
-	compat_time_t	shm_dtime;
-	unsigned int	__pad3;
-	compat_time_t	shm_ctime;
+	unsigned int	shm_atime_high;
+	unsigned int	shm_atime;
+	unsigned int	shm_dtime_high;
+	unsigned int	shm_dtime;
+	unsigned int	shm_ctime_high;
+	unsigned int	shm_ctime;
 	compat_size_t	shm_segsz;
 	compat_pid_t	shm_cpid;
 	compat_pid_t	shm_lpid;
diff --git a/arch/sparc/include/uapi/asm/msgbuf.h b/arch/sparc/include/uapi/asm/msgbuf.h
index b601c4f4d956..ffc46c211d6d 100644
--- a/arch/sparc/include/uapi/asm/msgbuf.h
+++ b/arch/sparc/include/uapi/asm/msgbuf.h
@@ -8,25 +8,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
-
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
-
-
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-	PADDING(__pad2)
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	PADDING(__pad3)
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long msg_stime_high;
+	unsigned long msg_stime;	/* last msgsnd time */
+	unsigned long msg_rtime_high;
+	unsigned long msg_rtime;	/* last msgrcv time */
+	unsigned long msg_ctime_high;
+	unsigned long msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
@@ -35,5 +32,4 @@ struct msqid64_ds {
 	unsigned long  __unused1;
 	unsigned long  __unused2;
 };
-#undef PADDING
 #endif /* _SPARC_MSGBUF_H */
diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/uapi/asm/sembuf.h
index f49b0ffa0ab8..f3d309c2e1cd 100644
--- a/arch/sparc/include/uapi/asm/sembuf.h
+++ b/arch/sparc/include/uapi/asm/sembuf.h
@@ -8,25 +8,23 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t	sem_otime;		/* last semop time */
-	PADDING(__pad2)
 	__kernel_time_t	sem_ctime;		/* last change time */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
-#undef PADDING
 
 #endif /* _SPARC64_SEMBUF_H */
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index 286631db705c..06618b84822d 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -8,24 +8,23 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
-#if defined(__sparc__) && defined(__arch64__)
-# define PADDING(x)
-#else
-# define PADDING(x) unsigned int x;
-#endif
-
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	PADDING(__pad1)
+#if defined(__sparc__) && defined(__arch64__)
 	__kernel_time_t		shm_atime;	/* last attach time */
-	PADDING(__pad2)
 	__kernel_time_t		shm_dtime;	/* last detach time */
-	PADDING(__pad3)
 	__kernel_time_t		shm_ctime;	/* last change time */
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
+#endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
@@ -46,6 +45,4 @@ struct shminfo64 {
 	unsigned long	__unused4;
 };
 
-#undef PADDING
-
 #endif /* _SPARC_SHMBUF_H */
-- 
2.9.0

