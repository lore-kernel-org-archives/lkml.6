Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524148829-3-9057734723571192047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524148828; b=KS+KnEphw2IkkY22r/WAaSB71aBxd/tvQKuf8dHW94DcfnOw4J
    LHn31Vr81085bnrv1MNlYlVxEE1Q+Pvq2wCeeSu/tLaQVn3GPa2beAnz2bgKgQwL
    pApTOQ/oqkfkZoLIBLfIvGobHEgNy9Kp1xILL9BbAY/TUdSSGREPqSelBJPSdyO8
    e22QdbBIYxh/fPgLcpUmn8OcG3dxp38KZ0d7zC0xR9do1POpdQ7M+8vtkANW1PPj
    bVSFo7F7nrPeodT6bHTFtDSb8EO7RPF84OSlIbsvKdiKqCMs9NN6XpQ2laGJK5nS
    NrlIOn3vnjEyvixQDGXOJhAETodXfHvTBZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148828; bh=
    MZP3sGLwm1NblX8U4ZvKgIIeS2IE5Ryo8wjfJbe50Xg=; b=EyCpntiQm7xhgy+x
    Dtzl8k2L83PcCWsC82YIScVemUjqbujl1yjl+ExUN9jf6n4g4tjYpsFe6ptjoBL2
    faxjlpaopDBmb6O2HzS/parcTqoQ97rL3Ai1vnNItlwkXCgC8Vebph2FS7HFscOZ
    V9fce3iAN7Iq4b0hCXunqGOWh0RsEudL8yfy3Ch6Wqh9kvDy9OyxCqFnE7wxxdnG
    6PBr+aNCesUsb/RiDj2H6vN7VaQKNwHVVgEf5rvFDtpJ527tITjpSP3Ui72xy/hR
    /lbFQrstOFWTC2Clf6YXc3f813vQuSN8SUVYTVTyumHnBM7qBAKcltvxxkavzt9F
    BWk8dw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfEB7+YfWWzVsGNd68krapSaJ5OjaGqS7v2FH2/cDpGDm4Pntyqf6iZzbrBUBsyvazK3/3Gx8pgechd2mFyywyM6/thfrsWEkbavHkbCYeA13Ms2o+XTm
    RWvbxVqAXy5ejfMFx6mCX3TN1P6Gozy5ALm+WgBHvAPIuZqYkJJZB+4j3dIuNyq9U8AjpjW/++jX/9gB+VVaD2FRR+MZ6O9Kfmdu44KXbk5NgjpLa+4zcRYc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=9Ps21RGOg5B95ZpLxHMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeDSOkL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:40:11 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeDSOjN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:39:13 -0400
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
Subject: [PATCH v3 07/17] y2038: x86: Extend sysvipc data structures
Date: Thu, 19 Apr 2018 16:37:27 +0200
Message-Id: <20180419143737.606138-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:kr5T3sYJMDxHLG6BCKgJMRLERUUnififeq+jqPm5HLCsBc3KKjJ
 LdmMBTyXs2Bch1x1+jTRkJgMg1oo6rer0Ofx3S09R6VjFPrBfZBVNn4bDXZJ9ZprRWsSrtL
 vmdN8MhR2khm3/N02qcosa3Eaqk02jJ/qbRE66FEPXOg3jLbiAtjgpdiZmyX4dQu5pXcxp+
 zIq/c2Mgaknxi6xJpdciA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GbQub4+8MnE=:y+JOVso3O/uAXnAGYxBtA5
 HfAisuk1Y/lSUt0cybR2y3nSmZ4gVeW+f8FymwqiLAe92V1iF/c2eWYVq4sTZWM3Ab5j8afpw
 Xq/6yfKiZs7f8LWQnN87iHqxiREK0LclrBEfdKK+yf8BnOSTXUoWemzDz8QQI2q3YPpX51Are
 3FMnWoNg+x63SCmDReXomvoHSNywfQC4Zdk8oN1nAh5b63Y7gZGBOv9mpg6ntlbDIcmi42qqA
 1AQt5jpv/GFQd4k6OxSko8IL5ZugTJIWWpaP7givaIZIz6t1wsR14kuHnenaFKEqyjkOUsBrc
 n8ovl7Z8+QkV/4LCkYBl/BSdP5BEWWhPisw7lRo39s5UxeDtLIvJ2i92Lgqj2LBGOfKvuhFBb
 9GzLIVQdXW/j7E7S146jAH9q6jHb8dvDuZ40DK3LG4H3Df+oNzB/cGcZQvyAc75S6iY6OWoLp
 vmMFAqCXP73DH+AgwHJ5JftQTUVmx/UALouNlWuwV1AHxqB+uyBIjaa0hdRMBxQvee/gJ4qQc
 Y/Oe9ZTjOpi7Xk1pCskgIaJyID4DLw0tWfsMSjaPpG162OcemGp+kCGh9DvAnPGzfH8/kpDUI
 I/BX5me2eywHqv0Z+YsmjU23fYzh42ovAIBdmHX3fP9ldmFfwlowcXn47TYcuvSjCSCgDBOjo
 dAb5LhSck1KqK+uinAPJhjxOpx8vKMaAVI4aZNrYpBmhRxpTbSLI7CGlwYU5RACeM/AW8nzOK
 cOFj3sMWWTAfDbeezHDxLS2BHne+YWwfiylVOA==
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
 arch/x86/include/uapi/asm/Kbuild   |  5 ++++-
 arch/x86/include/uapi/asm/msgbuf.h |  1 -
 arch/x86/include/uapi/asm/sembuf.h | 11 ++++++++++-
 arch/x86/include/uapi/asm/shmbuf.h |  1 -
 5 files changed, 30 insertions(+), 20 deletions(-)
 delete mode 100644 arch/x86/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/x86/include/uapi/asm/shmbuf.h

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
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 322681622d1e..d1d883e304f7 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -2,7 +2,10 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += shmbuf.h
+
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
-generic-y += poll.h
diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 809134c644a6..000000000000
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/msgbuf.h>
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
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 83c05fc2de38..000000000000
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/shmbuf.h>
-- 
2.9.0

