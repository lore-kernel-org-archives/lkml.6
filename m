Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1681476-1524229563-2-13587624511892655703
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
    1524229562; b=oYvaz8ud0IEV1OmgfpMXI59AbP1c3PipE/CKO+ReIWCBBurQJR
    XVm1nZaYDN9alHrX4Z97rnSofkkc9hg9shZPoP3uuJExNMdWkTLs/0L2h2nTWa3o
    XT+21HpaG6cBxj6mhxzBuPzo0nUsmzcV/5dCuCktiqRuNriPXl96WlwV2d8p+p3i
    nVn2tFeL9Miwivjh5tVTj/CvSIbvPOvYlR+AUuwvzJrhukIzYCgpuTDEslVpSXwt
    u+HeTWClxbNpoWxHUWngYuvuvU0Wbkt46cfrECNHc3mmwBJ8ML+XAmHydSVLXIkm
    gWbL5QPvk9l0fUquXVJliCh2frXf//Lo3eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524229562; bh=
    lRPDox80EIknxUrKHZMpkCRPN4I10Vculgb2kpFHM3Y=; b=KHr22PJL6b+IBCid
    FkL+kjLG1cGmyb4hKszx82o9r36OjkeriMNTO3LGBCohxYqqLc6v5s3VXQQx92Lc
    Tj1svaJJxkQpWA9IGgQRKV8yxkzELWj8WZOkRxNZJIoqy+mUZpMaUx0qM/IRv4bQ
    eknA3z23vdfjdkCn9pZwNnOiEHkbJhKWUH3SoRl3IdKbwEE6fHa8VNRJX3Ydz5KJ
    sUzSM153a5QTpgbRONzKkILEP2oINwiStzuBvLjpDgTdq5+qEleEYmsBF2pJgcaz
    SaGTFrR0JGxDT2D7NCIKVFplIBC8iXE7Q/24CcDVILtqX4tUzV7+bmyvnYXfcwAI
    KZ1LnA==
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
X-CM-Envelope: MS4wfAnUXcP0sf02teyr/OMwlPz6GNYTPg5DN9jbkXHnWPSAgkhLR3pR7u7pM/nqhf96GJ6sWijPEsAjcj6yCRtobJCFk3fK1KggsAf4I+HoZlyMhc0kwFXK
    EE+76rlSSoGNoq8wnC1gCtPMwdFErsL/NPyTincJhJvawnRUUHA1cd04vSeJMTtMekYhFxzUAqBlYYN532O8Pc090qIhCcVZ199fZHDIwVJtYLb02zIa5tVG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=ss1IfW1GVHqlzswJ9RYA:9 a=SMRuI_uThru93hmM:21 a=JZMq6HhDVfSzc12D:21
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754917AbeDTNF6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 09:05:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754764AbeDTNFy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 09:05:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc: ebiederm@xmission.com, y2038 Mailman List <y2038@lists.linaro.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Jeffrey Walton <noloader@gmail.com>,
        Daniel Schepler <dschepler@gmail.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
Date: Fri, 20 Apr 2018 15:03:29 +0200
Message-Id: <20180420130346.3178914-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
X-Provags-ID: V03:K1:s4pXsIJyLTMXyL6KgDWw8XcyU9mNufw2Dpp+Cebn4jG13dUGY1C
 kn25mDG58Ah63DpYCMjhtr8DYRnDjCfrvfn5jaKQMUHjw1tpPHOJoGc8dZsjw4nAbEt+pif
 yrYJo7Zl6AzsSODDBse03XbXGmH+jIYec0rD1Smc2TO5xWlh3yUKiBil7oCpMcQtlMxFaTB
 SaAS2zRvYqvXwE4IKVchQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZdrNTAdpv9E=:toj5rfEn+T28bZ7LpkA/HI
 cNYVyEd8cQ+9S5H4Gy20PQeDPjv3Cb2Y5eJN2flMvk5PNzUz0xsFUnmFX9SgYpIk/X5UJD8vd
 JMa9EBEHiFW1rWMFCSvBD3NJ7aHps9vbPlX9FUn8v0+6RCkujkg8QW3FKDX7TFB5CWyobkDxC
 T6t8sgGkY04OilcPlQRpoWaKXy4gHM4LD4bqo5HdePlT3fdJAjVnrBqayamHtWChxcn7EWiH5
 lbwfrUanuhRMNJi9BI3IxE94tQLZhFSgAPRrSH3P3xn7rHSGo1touSNrPehKhF1WRgqvSzd3U
 N5LtsxWvT5AKozDqUaEgNS0aV+1xU9R9vx9Xf6cVgljDR/5y2QySg9a1mWaDekGztuBGDg7ZN
 rW5QpWNMlt4Uimic2l1Shp1O09Bz8ZFSmeKWa+DwCaLknI0M9Bxy4l6p7RfcfT2NVydqW177b
 fHktiY4rJb9MV6B+mXRFFRAB23/Hz2BndmJX7bkZkgFcPB/riPq0b2Ezic6yImJAM7vZSwav6
 s49+/3ihU8y1P6ycpG0L/JmuacuSWFTHaPQNQdnNUVLwQx7adRnhMJY9ZVIgW/pQdQLq7kgMf
 qQru3sXaBJddqmAmmF4Az5i9+y3pQp+MCocilev/2IeESmgbRfYZTdAtBL29jU7ngHGki8A+o
 gjINkRAmxFnZHPvaZyNSLrxP93r+9QrzYXBaYgjkp/ba+FGqBeeoJtIpo2nbbTB0vHTJQmBAb
 +FVCERHJJI7o9C4KYnyQ/noDwNW6dHcDlJ+7dA==
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

There are other UAPI interfaces that depend on __BITS_PER_LONG and
that might suffer from the same problem on x32, but I have not tried to
analyse them in enough detail to be sure. If anyone still cares about x32,
that may be a useful thing to do.

Fixes: f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32 builds")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This came out of the y2038 ipc syscall series but can be applied
and backported independently.
---
 arch/x86/include/uapi/asm/msgbuf.h | 29 +++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
index 809134c644a6..5f1604961e6d 100644
--- a/arch/x86/include/uapi/asm/msgbuf.h
+++ b/arch/x86/include/uapi/asm/msgbuf.h
@@ -1 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X64_MSGBUF_H
+#define __ASM_X64_MSGBUF_H
+
+#if !defined(__x86_64__) || !defined(__ilp32__)
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
+#endif /* __ASM_GENERIC_MSGBUF_H */
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index 83c05fc2de38..cdd7eec878fa 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -1 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_X86_SHMBUF_H
+#define __ASM_X86_SHMBUF_H
+
+#if !defined(__x86_64__) || !defined(__ilp32__)
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
+#endif /* __ASM_X86_SHMBUF_H */
-- 
2.9.0
