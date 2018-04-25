Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524669167-2-6374544422193614047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524669164; b=QqLpfJqYvs6X9v3RM5FgnejCWMoXzN/A/W2DmAiPCh/y13mmKL
    1AygDML53VHw8T6cAWCMgfRRsxXqx5C+kKW6Z1AvZvs5k69V4bLfPWCTYyUiboxj
    n0Xnl+kBgKKH0oz67TUxcKBalKIKAEAQW1LI29G/ms1qPBKGJAwMO9aWSnWldsXx
    HA9rmtrRjZWVPkKU+m5Xa3/7UlJ/707iHO6wvOmsCv3rHdSvXyHnlJyFB9oiD8kS
    UVomyr7sxSMAiIgn2qJ69jJquhtPxq+xalHPwuhwRvaf05G+L4ifmr3UWQG+Oovj
    KS6+Z/aTpdup+Nb1IzcDzpCLf7xhOJ8sNpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669164; bh=
    jhL3aVt+c/UKYTcjmYGEpdfxR/fhS9fWi01sNMXuEU0=; b=whq4ftNRhg/Ydb/h
    beJSpqXoGzASCXfW5M+eZ7S6gBtMDmblaRu4OfG9LjPa66u7oCpAh/MvQRJCMLOD
    UQDDYvS7PX/m7LoYnzzqKlCbGhwqPDn4eK7WcDd5hFnR2jc4wA4/qg06tR54dYcs
    RMB9fVo+JCEn9g8ZQxIEd1PDqdSzJSspS8wgz7p6p3pOCtDDHdsUNiv4PCM3dRzn
    hIj1TXIR0nR4Bwj3BjQEaaF5u9ymioCBsydorEKVrfxCV4CHrADucBTt7G+tkmy4
    m8HWW+mQqaSb7pbjSx6/2TtbXJkIBYiTWfGRqdsDpo/oo0jPIN3vE/snJdpOY9Sv
    6iO4lQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfErseGGLyjqxO3BbUOMUECazcdebtakCpseM8SfsA8kFcneFAwX0t+/wCihZBE6/1iTrGLxdeF7RtJCJy2ZyKWnKTLsI5IeVmH6UeaWd0HLbUNxOiXBD
    8nzpIB/5oNo7VkJ+dLh3VNvaA6HAB1IwnfanotKj0F+nNQqHy6r7zWIF6EJficYc018CQxIOOA6ZCy8o4I3izVd1L8Otda87JBGket3C2U4fQDH0gPHkHVj5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=gPkY2qt6JDp1UgQM5MoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeDYPHR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:07:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754807AbeDYPHN (ORCPT
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
Subject: [PATCH v4 11/16] y2038: xtensa: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 17:06:01 +0200
Message-Id: <20180425150606.954771-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:i9UA0urn16lH5JDePVWaotJn6MyPgLR5FfVVrzw5nnNPxOm4u+m
 riIT88wp+mhan2hKzci9CR3aFUrUbzlqeokKS47rOWVrdtHsVQuvjSOnovuLXAj+H7J7Aw9
 RyM3AfCErlZJqOrqV2ujx3kKosgfMIKHftIfYa4cI56loqLmcCuYokhVYKrtE4ew0SIDzXE
 PFRkWR80Y2WN+Q+3jvDqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMC6hV4Smk4=:Ri6ksbuau+5BNTCbTyMUCj
 d/CCHE71Lb4RthMXlTF73W2Kb6JRAMhq60rPHWcJDIY3WZJO4TZJtgqueFD//r5L4fZ1zNMnu
 iOtCjozl35j0/FyW63KO86fBfoXTgu6DtOJhB6IRVxZl1kXXmPNWAOLuvNtdGWL1si5cTlh9g
 1aDEQlN6RFs2S2yBmVL+YGXOfcbqNc+TAcYLBAX2jft4Sk17RthUFG5u/hWMwv4YyjekLzTbt
 sprBskLIXjTTaT4PZdRjfXoMbcP/6qwRCj6/KA+SWVTXU5S3N9/hBYu1SWwumjWSZVBHLR1tN
 ea3HFSRM2gCMzepL5PV9Kdgo4BZkNQJrLrozrqPrbGJMDPweuUA1N35bu4k3m+Rn90FWW7qnr
 vUJ6DJZZ9o4fFnCYxppPvtV6rpVnSXFA/4a8rZbKiw///CwHqyq8/RopFnz+gcZamMxa/dq0r
 UDDMQhnnWaKK+JoYaEBYBSLzJQGKnUBIr2RqYW1pKaYF0hlVS2ro7iYl1TmnfseQ0EE8TyH3W
 wDSds8RLaUBjYs1q7tP1jpd9toP1fVzntejOnWOhNsTsFE23jHdXhumBPAMcF7eoCtXtAWYnM
 I49KOYJ8dW8/bRY8anU+WLYJpeuneNl4AE6tiOX0sa/o5DQREOgZsIWQx5IdZl8FY3AJpJXji
 9dc6tTPNfpO5OekU6oMM8YMTOf61mTSHD7Ap9iH192PGQ1xnwO74HnAPgg9tFE8noJemzUatP
 zkbAELc0yLPQMjgoPlTnk47Z8iuZZt11Ms/ejw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

xtensa, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

xtensa tries hard to define the structures so they work
in both big-endian and little-endian systems with padding
on the right side.
However, they only succeeded for for two of the three structures,
and their struct shmid64_ds ended up being defined in two
identical copies, and the big-endian one is wrong.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/include/uapi/asm/msgbuf.h | 25 ++++++++++++-----------
 arch/xtensa/include/uapi/asm/sembuf.h | 17 ++++++++--------
 arch/xtensa/include/uapi/asm/shmbuf.h | 37 ++++++++---------------------------
 3 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/arch/xtensa/include/uapi/asm/msgbuf.h b/arch/xtensa/include/uapi/asm/msgbuf.h
index 36e2e103ca38..d6915e9f071c 100644
--- a/arch/xtensa/include/uapi/asm/msgbuf.h
+++ b/arch/xtensa/include/uapi/asm/msgbuf.h
@@ -7,7 +7,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -21,19 +20,19 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #ifdef __XTENSA_EB__
-	unsigned int	__unused1;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused3;
-	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
 #elif defined(__XTENSA_EL__)
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused1;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned int	__unused3;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
 #else
 # error processor byte order undefined!
 #endif
diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/uapi/asm/sembuf.h
index f61b6331a10c..09f348d643f1 100644
--- a/arch/xtensa/include/uapi/asm/sembuf.h
+++ b/arch/xtensa/include/uapi/asm/sembuf.h
@@ -14,7 +14,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  */
@@ -27,15 +26,15 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 #ifdef __XTENSA_EL__
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused1;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	__unused2;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;		/* last change time */
+	unsigned long	sem_ctime_high;
 #else
-	unsigned long	__unused1;
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused2;
-	__kernel_time_t	sem_ctime;		/* last change time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
 #endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index 26550bdc8430..554a57a6a90f 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -4,10 +4,10 @@
  *
  * The shmid64_ds structure for Xtensa architecture.
  * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
+ * between kernel and user space, but the padding is on the wrong
+ * side for big-endian xtensa, for historic reasons.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -20,42 +20,21 @@
 #ifndef _XTENSA_SHMBUF_H
 #define _XTENSA_SHMBUF_H
 
-#if defined (__XTENSA_EL__)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
 	unsigned long		__unused4;
 	unsigned long		__unused5;
 };
-#elif defined (__XTENSA_EB__)
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-#else
-# error endian order not defined
-#endif
-
 
 struct shminfo64 {
 	unsigned long	shmmax;
-- 
2.9.0

