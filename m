Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669167-2-5304965033442132720
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
    1524669164; b=nPbTB0MHvzRjQzJnGOCe12v1wpbaUGzUod2b6hFO7/TipuOIOY
    T33of/uDJ+q9uwQBwh3yyPK0ALmEusoVo7DA7TVZw8N6gGTcH8bO6xT0imGW0jLC
    JpB6hpx7v8mzxe2kUAX+vT5lI38+SIHtM18Ce2D5XQCtpt6wxNEh/a4AOoH3dxyE
    tMaZPlCU1N6LYc59LjouHm6zc2SibSIR3dQ/gt9ym6vORSLIM6v4LpwArz8iU7Xj
    HoJcxasvQqIMsSvGLlVVKGvt7lEkCI72KtcGjlCX4lXH6ZYZKU5WyBBNXwanOqVA
    AXZRyWK4hxXGlxA8BEQniNqsxYL09yOrgCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669164; bh=
    dGwXU2YYbFGN3n2zVogv3JYSdyY1t2A0C1v37sp35N0=; b=Jl61oY1/pKnG0J6c
    Pqq4BQ+441ur385SfQmSZNIgoWUStzfWS6BebHE1ijOhThYcwx71gL9eTjaufpy+
    zcoa/ZD34GbRADndETPPqEJlBZYI/k2VbxK3Jx837iPUDum00w4wrJD3d/HJQV8q
    4SzydCe2O+Nqxh21e4bX05RlnUXpJ/9nrenjbWmkAaoEdDDlTZHY0FAYS7C565W1
    1pu37hT8qYdm1+j5nClVwpfS+9IjEQqe/SLAXrr/9mryhMQ/SXRoyQMlAYow4hl8
    TYESyr/chRLfrxoLPZ+UKfkFz2m9DON6AkaEfvxktct/4qiuPR2u+aVk2qODQTsg
    704DkA==
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
    8nzpIB/5oNo7VkJ+dLh3VNvaA6HAB1IwnfanotKj0F+nNQqHy6r7zWIFDwojKEHMVDDO2d2dABOcNFOCLUma4FTLDE2U6kWzisfxF3TmuuLlDumr4QVU0iFf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=vU9PliCp18fCzx_BohAA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754960AbeDYPMk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:12:40 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeDYPHR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:17 -0400
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
Subject: [PATCH v4 02/16] y2038: x86: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 17:05:52 +0200
Message-Id: <20180425150606.954771-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:9M4OIQPEi5yzqZ0O/d7f/sTPBFWbwKIJIxL1cS7FymAPahP+/PZ
 fCENTLpok6HumSyjM4fkgb05zQM4d5SEeRJmZ5GLvZiCt4vc2pZYX+F3bnYm534yg0Qi6xp
 A4ivRIFHrY2iOqX5J5faBuvwk/Xma6NreSw26uwJbQf6aiwkasMqKNa0NlNMcwOHVyrChpD
 mZSzp/p2l3Ts5TPvkS4LQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Td6jEn/6kk=:Io2npe3+BCzZPd1rBwwJz5
 i4e0YrozGCqkH6NOck6RGlipii1e0qfkFvTINUqi4LusfB9BRcXgGE4U6GNmIQO777JPUTUW1
 eV9HN8hsQqHX7rytFkZtf6qs2FRu0jubK24HXT60/eZnQgZuQQoDbK5YbBhUjqADTAnpYj7Hy
 /ntWuezVNb832KbbSLyqVtBWPjMnqST28136Svr2OjgrM6t8GkV9n/XULuGOiMWoIcr9o7zup
 P22ZWSj6Nmh72zJHocLxjVMNYrPifBncvumAk6y0w7T7LQsBmBzzuyTdUxA2MHkhp5r9YDv+N
 kdLy0IiymTEcQnmVkEH71kiSvxecdy8FXNOTEMG38OzkQMdM0pQX8Mp2KWg+Mp+ch8lYF2jtH
 +euXRMGE66teCMuRFxE4uSmVCNXYw1ca/FxsDt17p4gCKpOcGJRgtKfYTw4PkRbr7LluF5O35
 c2ST6xx1cEIPu0pwp0fc7aCrJ3ELyiWFEo5RA4pRqAuxnvaq3Gn4EWibmqs5rhs7eJygee5PA
 O5t9zqMEPW7C34j4plnS/ZHA1uQxwI4bDMV8YKeA/J9BXQvJRxEo3koBMu3oCAXgt4POgJSX6
 c/btpd+Ip2uojMlqfDdBp4FMdXHWbJZ9hMDKqYQTXP1W0qpnXnYgVWaAtI+AsbsqeJPezYmFA
 IOOEqgiNYZmOu8BBynm6BxelZMTJHyn2MCPWDIED7emgwRdeznUEY90G9sVGxC6Gt4oe5BogN
 A9FIvXDyw7/t2LFgl3Wj+2/SRllgg02bKHRxZA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This extends the x86 copy of the sysvipc data structures to deal with
32-bit user space that has 64-bit time_t and wants to see timestamps
beyond 2038.

Fortunately, x86 has padding for this purpose in all the data structures,
so we can just add extra fields. With msgid64_ds and shmid64_ds, the
data structure is identical to the asm-generic version, which we have
already extended.

For some reason however, the 64-bit version of semid64_ds ended up with
extra padding, so I'm implementing the same approach as the asm-generic
version here, by using separate fields for the upper and lower halves
of the two timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/x86/include/uapi/asm/sembuf.h | 11 ++++++++++-
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 7cd314b71c51..fb97cf7c4137 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -134,10 +134,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -145,12 +145,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -163,12 +163,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index cabd7476bd6c..89de6cd9f0a7 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -8,15 +8,24 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
+ *
+ * x86_64 and x32 incorrectly added padding here, so the structures
+ * are still incompatible with the padding on x86.
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#ifdef __i386__
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
 	__kernel_ulong_t __unused1;
 	__kernel_time_t	sem_ctime;	/* last change time */
 	__kernel_ulong_t __unused2;
+#endif
 	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
 	__kernel_ulong_t __unused3;
 	__kernel_ulong_t __unused4;
-- 
2.9.0

