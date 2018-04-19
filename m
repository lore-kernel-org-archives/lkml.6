Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524148794-3-11073128259921003432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524148793; b=aN8YTZe3tO0VJllbA7z7jcnMUqJi/ir5b+HmaNwMkSkALqrK5d
    Gwgnbp37fzVqspjUYhfIMXLErgSRQ4Ii5Q1LuarLWskOIZ2x4vKWHTx8Zkd0g7Qr
    VgyD8HkqdxTpkdsRA0lKaVxbkkLE3Cf4ZOaAOvmi3H6BODfAMu7wxLEsYXkYiA6S
    Ok9D/UZwnSmNMcd2lCe7IvYXTCBJHCtNf+/cXSlYyh5jxHBYIWMkTpXSKJQqwyla
    2Bgpe6CBrAv1PXBF40jqsZrQ0VQ44AiTRQJCM0tgG5ngVHJVoMhtJjN2AK/a7+sd
    Ev0Plg6sd9Y0ne/9R05oI/yVQLaiJyzUBikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148793; bh=
    iRn/i6epmg64Ec8HU8CF0yvAYrySPlYn89ZCQvLszXs=; b=rEoSeqdmPTiVTDhQ
    lGpT1rx7j7LBi4PbjN/W2JGHRokXuZI8YWtHghRcDChj7Q4u1nfq1xXTuNMKl/mE
    6jESKUfggLl0noGv0AODY4o++l5tciiFF7WfCnvoC3XKN62Lfda5gMPDwE3rN0le
    aGrVG42mdq6j67xdUtghVYvfD1MOpSLLgQ1uQdJ7CbvHTJR6cBWezYsE0oTxJA40
    7z/qD5C4WKftMqTsz+1l6yygCwmtXrgAMD7W1A3obEd9MF+bJuJkOVKSWK5fVQtE
    UVWmGo+SecE/r0ES9I3JNNeLdW+7i8tYxitvJPaI6fCmXE4BMn4NuWYFjFnGueVq
    z+E0Jg==
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
X-CM-Envelope: MS4wfFsl0KlmvmjbKGm6dx6fHW/P5tyvt4sTPcXhZWRrsnGqhqdp1dTGzTmcukfWKjDu9Ievob1ENa+5aSiciy1yItdK3zuEwJLogdmATvoHiZ+f+73rD8gS
    ucc1/N0fQh/mqKZldMhhlpOHPhmheGy86dL3luX6GrxhNdsptmXYCvQIAbSOZAcRvtCWfagaWn4F3KzOcfnG7a6k+zpPXS0v/sDJlkS+4znbk2QVl0yzhT2s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=-62I0VEe1g7b62UyLp8A:9 a=bD5fCAVWQrLJxWHt:21 a=EHmufYiOh7nJZiMG:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeDSOjh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:39:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbeDSOjW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:39:22 -0400
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
Subject: [PATCH v3 10/17] y2038: powerpc: Extend sysvipc data structures
Date: Thu, 19 Apr 2018 16:37:30 +0200
Message-Id: <20180419143737.606138-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:RCd5sWbjjJLXnkZMtAoyJ7y6nM6w16+IHNA/SHAoP8x60OtCrTu
 xYFyOL2cctNKPSsJ8+XehyGvZPwhGChyhaG42mejxHzZ7wQIsPQlBHYy+tjfj//5BKnTfw8
 c278yelwa7Kw0L0KGB3DSeI8npmUvt+YbhkskWKB8QOdYYFzL12DeEO4l1ORZxP8X+ASpAN
 RwRe6y47/RGushgpBSa1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B6FxIiDaqlM=:VUZGWFRlSa4W6ocQ75t4iQ
 e7eZ0H2yFtpKT/Hei9Z/XXGMzg8BdMKRE3qOc160oCcx6HKvgXffELdPmEZHyptm5VR3Qpc9x
 5X5H/mE316Qn7VJe6fVAwTzt7OvEx5ZAIQaecMyw3S0SLE1fTHa8OqvlcSUUMB4l966PGutpQ
 vklonlggKU2uv1IdxG0sePYqkVB4bkmIZ7e/gUN3Dqg12RJcmAkDrqj2VQfpHTz976S499zI6
 8zOtarGa2yM4RbKfzc8UPTt0TN96v7aN7prKTII7g1Wmr5zfKDtV5cIrWe8oi45iAZrGpTdgO
 mhLH5uLEpkXjU8NFRnWS4iSYaSf+h347t9iiSoZEZ9HV9uqWROOfWg39XmqBB7Pl+PQIFglJS
 p8ZUbFxSSwqjTo4ROK6tbMhTwVKgchC3ugzrh8PaUExk+LhaReoYW/AjzKYbPHJ6XHFt38+x+
 M8HcliNtW60eRPgJiRmQKm5HzLzbxKI7vrSaDYlflrsHv8zjsDD6wxp3Il+iyDi3T7i8dn+G0
 p94W1U92xw0yFbUmdQv3sjb33kZ9Ba/gbAhQCK7dxIniDyp6E0A0n3Nq0MnjrWUtrZmoVSg8W
 Aoxa2WnvY/uU/wgbmdNWcfASCqgsMg4IS5UxE8QaZSc+6mqDORWqxaVHeQZFP6qK4NEidQXrX
 Fs0vNJtvOo+0S1uESzlMTAfovL228Z7E9/QRhlarn2ok1MqelqE1cgQ2PUfDZvHpAnGeS7jmk
 iRn9GrDYuVhYupMujd+JGspAP617wW8JgSSCeg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

powerpc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

powerpc has the same definition as parisc and sparc, but now also
supports little-endian mode, which is now wrong because the
padding is made for big-endian user space.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/powerpc/include/uapi/asm/msgbuf.h | 18 +++++++++---------
 arch/powerpc/include/uapi/asm/sembuf.h | 14 +++++++-------
 arch/powerpc/include/uapi/asm/shmbuf.h | 19 ++++++++-----------
 4 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index b4773c81f7d5..85c8af2bb272 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -162,10 +162,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
+	unsigned int sem_otime_high;
+	unsigned int sem_otime;
+	unsigned int sem_ctime_high;
+	unsigned int sem_ctime;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -173,12 +173,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
+	unsigned int msg_stime_high;
+	unsigned int msg_stime;
+	unsigned int msg_rtime_high;
+	unsigned int msg_rtime;
+	unsigned int msg_ctime_high;
+	unsigned int msg_ctime;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -190,12 +190,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
+	unsigned int shm_atime_high;
+	unsigned int shm_atime;
+	unsigned int shm_dtime_high;
+	unsigned int shm_dtime;
+	unsigned int shm_ctime_high;
+	unsigned int shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
 	compat_pid_t shm_cpid;
diff --git a/arch/powerpc/include/uapi/asm/msgbuf.h b/arch/powerpc/include/uapi/asm/msgbuf.h
index 65beb0942500..2b1b37797a47 100644
--- a/arch/powerpc/include/uapi/asm/msgbuf.h
+++ b/arch/powerpc/include/uapi/asm/msgbuf.h
@@ -10,18 +10,18 @@
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#ifndef __powerpc64__
-	unsigned int	__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __powerpc64__
-	unsigned int	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __powerpc64__
-	unsigned int	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 8f393d60f02d..3f60946f77e3 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -15,20 +15,20 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * - 2 miscellaneous 32/64-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
 #ifndef __powerpc64__
-	unsigned long	__unused1;
-#endif
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;	/* last change time */
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
-#ifndef __powerpc64__
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
+#endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
 	unsigned long	__unused4;
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index deb1c3e503d3..b591c4d7e4c5 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -16,25 +16,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#ifndef __powerpc64__
-	unsigned long		__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __powerpc64__
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __powerpc64__
-	unsigned long		__unused3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __powerpc64__
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned long		__unused4;
 #endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
-- 
2.9.0

