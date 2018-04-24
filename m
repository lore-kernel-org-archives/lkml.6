Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3668839-1524604855-2-6153959076904050642
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524604855; b=O4UUhLk4RtYrA1/TGP8vohlo2XE8utXoB4YnCG4QvRsynjlrWk
    3MuDU6x/4aN7KmmUfF+fHfWDW31yyxXdrLm/SDYNCOdRhjpdPt+RuUg6UupE5XKS
    eP7ArP55J/79mUVlUVsUGD1M5xLx/ebOAP4FTlqJQztf76HWtyz9guOAXMSShZ7n
    TKnpXXVXHBiXjjhEbpntnN2ClMyluc8avDJBI82EZSSHbiMwJTFk/xnLyy73Rn7w
    1YUG3O3hn05PouDsxc6bTMQH3/d7lux1Y1iGFIzxxxJGa5HQc/oS4KzWAyZiXDw8
    hpm96jE4wxmwriEhEyO0TkGks+I4FqmvIVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524604855; bh=HyWjAyZAYEKxxXx2e98O/lN3wBIM2T
    ZdPx1QGVgSsy8=; b=ZSPNhOCiChwrf10nGeAXTi3k9FkBmskCrQt7txEhMeVf5g
    5Oyb5bT92pFyTwIgnfQyvoDB8/fBQzmUrtRPWeJcAlJlcQ8lbm6jQ+eMXyuuUz1O
    LDRCOl6KoJHORhtrpMaEHRRTR3tE/vX1D8m13arwF96ubb16qdT3OQbtVMRCmXfT
    +vpStC8VgHZxOj2Qd3t63S0qlA7lPoInXnBtZoe3nSqOqXMp2DwTnecctKZYaBS8
    6i0R9UC+gt5iFOqQ7a6IpuKZCpKNOII58MhVOnNTYqSNj2D3G0myiuWXGNenhy+f
    Gv6bS3ZblnvZWQy3/92xCl+YXJ3Z/vSsmrEpOSzQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIrmzm5E2JcAepYul/QGcKCPIQWpn0Yp7erhQ9cxhNyaRyvEKDFirfrp83CfJcJuqmUI2Ss5h75oarIAI5imlVVZpNPwrDcJ8BHcIWF3kOkV6kW/j7cr
    4zedEL+rJrMemBlLmIdWQ5Dju0UpWNrrsai3FJX1FlRx/8CNQYyh/6hUAvLasA796h6HPhrIOXDl9kuD0nRFB4Bl8b3EYNpT9mlg8PtYc3lkAooeLYiKAq0A
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=NEAV23lmAAAA:8
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ss1IfW1GVHqlzswJ9RYA:9
    a=j989yhf2OVntgRqC:21 a=9AvV5YGB0ofTFpJB:21 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbeDXVUw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 17:20:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeDXVUv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 17:20:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
Date: Tue, 24 Apr 2018 23:19:51 +0200
Message-Id: <20180424212013.3967461-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:/B1clfbv4/dc4y1z9J6EuQiZHbn4LUucCK9uu0Hni1HUV7ZfI6q
 ZUM1vIcdk8Ext41oHW71rHZiGZslfHtLoKDnArgFBvR2YuXPGkQD8UP/7SOIi2sE053mRjN
 YALjXUpGtbdAG9WflH5mEEHDek3TnOQ0S/OOq8xyihD8MKxZF/YS0kmMKxM1R5gFThiJ3Ov
 NWncsPkqcR5UOc0XTreFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N/2nFo6Hc7Q=:DgbZx3k6oMVG8kCIjgSBgE
 fvmm/ZTEc9aAoHvYCtLOifoKvmTkXfGykpsQyA+f90gAkF36NgroNd8FvCM83ZeV+wk9SZ48Q
 SCoAqZjDfadm8J6S0p27hCcm995nLu6YC11Xu1sYMgp10mud0sgj0vyLx9EDs+8B5r/lKSozb
 R6LrAWsfR3o6osMGeG6GMlpx0q6fepyXm4CvHnYuIxgYC26xRYveONI8bjGPMeKjxd9vHFvAs
 J1iA3Ogmjula0f1Dv3LtYASO4ed9z2YvflkR9GwY4V296BCcScJSNaGiiA1z4AW7phfFnDxGq
 ioBNX6vfnNiWSr3D2HTVrKdwWAR7vlv9OGHQPQ8XyxA+e1AzDEFhOCQVPqwrZPp/+tqg2gNBj
 RjtjFF1I3en0lTWcu0BqChM+j5eLvuG76R7GxFROsyE2xp6Ny02RY9WZLwG1w28hN2pllLWPC
 5atV9tcgbYlWu2jHXX3o+Ta5o8mVH8n03VumG2Hw5D6DyBJVZ+shCebG1W9sjMHYKWOtrTa2t
 qp7lmQXwyaGkLGZuJPAD6Q0cjqDDu8Lephz2KLfJ7i2ekJ71DXmQM/lFI7PKjtwOK6XB1ZHoV
 yRhtPTDs/MpM2M1wo6EEWk5e3g/Eu6A7dzF4gOgmThEfJU0/USjuE05LpWJWAzos596+LgT3M
 /W+U6shZOD45LOQ4bCgO6McjSbSgW2QvLU1GEaR6yNY2C5vZ0fVAmRZoz/eFlKJwVoetR3D11
 SEFUTJwRAzPaSpaR/hXsKKUy1Xy3eH1dfMdQ9A==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A bugfix broke the x32 shmid64_ds and msqid64_ds data structure layout
(as seen from user space)  a few years ago: Originally, __BITS_PER_LONG
was defined as 64 on x32, so we did not have padding after the 64-bit
__kernel_time_t fields, After __BITS_PER_LONG got changed to 32,
applications would observe extra padding.

In other parts of the uapi headers we seem to have a mix of those
expecting either 32 or 64 on x32 applications, so we can't easily revert
the path that broke these two structures.

Instead, this patch decouples x32 from the other architectures and moves
it back into arch specific headers, partially reverting the even older
commit 73a2d096fdf2 ("x86: remove all now-duplicate header files").

It's not clear whether this ever made any difference, since at least
glibc carries its own (correct) copy of both of these header files,
so possibly no application has ever observed the definitions here.

Based on a suggestion from H.J. Lu, I tried out the tool from
https://github.com/hjl-tools/linux-header to find other such
bugs, which pointed out the same bug in statfs(), which also has
a separate (correct) copy in glibc.

Fixes: f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32 builds")
Cc: stable@vger.kernel.org
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: Jeffrey Walton <noloader@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This came out of the y2038 ipc syscall series but can be applied
and backported independently.

v2: fix typos.
---
 arch/x86/include/uapi/asm/msgbuf.h | 31 ++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
index 809134c644a6..90ab9a795b49 100644
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -1 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X64_MSGBUF_H
+#define __ASM_X64_MSGBUF_H
+
+#if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/msgbuf.h>
+#else
+/*
+ * The msqid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	__kernel_time_t msg_stime;	/* last msgsnd time */
+	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	__kernel_time_t msg_ctime;	/* last change time */
+	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
+	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
+	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	__kernel_ulong_t __unused4;
+	__kernel_ulong_t __unused5;
+};
+
+#endif
+
+#endif /* __ASM_GENERIC_MSGBUF_H */
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index 83c05fc2de38..644421f3823b 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -1 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X86_SHMBUF_H
+#define __ASM_X86_SHMBUF_H
+
+#if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/shmbuf.h>
+#else
+/*
+ * The shmid64_ds structure for x86 architecture with x32 ABI.
+ *
+ * On x86-32 and x86-64 we can just use the generic definition, but
+ * x32 uses the same binary layout as x86_64, which is differnet
+ * from other 32-bit architectures.
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_time_t		shm_atime;	/* last attach time */
+	__kernel_time_t		shm_dtime;	/* last detach time */
+	__kernel_time_t		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
+	__kernel_ulong_t	__unused4;
+	__kernel_ulong_t	__unused5;
+};
+
+struct shminfo64 {
+	__kernel_ulong_t	shmmax;
+	__kernel_ulong_t	shmmin;
+	__kernel_ulong_t	shmmni;
+	__kernel_ulong_t	shmseg;
+	__kernel_ulong_t	shmall;
+	__kernel_ulong_t	__unused1;
+	__kernel_ulong_t	__unused2;
+	__kernel_ulong_t	__unused3;
+	__kernel_ulong_t	__unused4;
+};
+
+#endif
+
+#endif /* __ASM_X86_SHMBUF_H */
-- 
2.9.0
