Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936261-1525120377-2-3828708306991956691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525120376; b=Ci0r2vJaWFpCyCG+2rTeOm95h3NIhzVTi854dfqZhYxjYyZssd
    u+6UyC4YJ7JLXyV7mIx2JFxVQoZRMSE63eVZlJszfWsqOK4uh+SrFxFhLzNDSWGl
    qNlt7mYNbE3F8utxaE7wB4FyCi6uLVXLiY5QugkWFlWG75Q5JBAp4sdkTh7laKx8
    RmCqxLfmHDC3Us/IoJqHsUg+x/kNoUx12OYJCz/L0To0lQnsAranEnGQYJaTk5eX
    FHeLs4CQBBSQdT3ZupqYxyLIODn3gQm42xrssly7GwAduAeVypJ36mLx+ZgMWecL
    ztCiEcG1/3QrmGw+7UemkUR7GPLX36tmdIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525120376; bh=CUB5hP4f4EppAgt3EDMBTi6HnRRmvW
    QNzBPnoH0I3E4=; b=eaBCAHNhUxgliynRab5vw1TT8iBrTjp6kyrDIqPvWPUWxy
    keW+8FIFM/4wU5odvu4JHjqNz4OIkh6Omsm8XCsJ0jeHlxpMBrcG11W52TcCU2pF
    9NgIupkXTmh+ZizQevUbIpXQ6MjAoggaU0JyrOPAswZ1LWJCJaEE4w0oYTCTYUX4
    MEMllUoBOwVZZ/uZQhLyF1rXSFQeFZuChp8GeDiU6JIdZ6Yt5Kx+5M7bC+OTkXAz
    pQ9VnZu9V0XSsmXTwragCa3pYV9yAnKLlqxOwyzXtps4aeG9igzyLLKIkF6wtE00
    2CiXmnAPTXkIa9ZYRRrSbwHsseRm/e57L8JbTZCg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJpvrY6qtRJtfKLroUI23Xhg9v/DZ/cLjrlOb02ljteB/pKogAs1Rw84KKUlOoZtO7YXZ1BrsuLftCZtkOTIDOmoOVG3WBnCkfRE3OmrANncegU6SJ2R
    WmeNB8xKtKVuaowPwTXdTijPYcowyCjHRIqXWjkqEFML5KqH4I5oZ7j5fyoytpOLyx9MHT0XMNAycHJB4u7wF7mrIwMeg4MXXx1b++V9bOZrUV5s71y/+4ur
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=oGMlB6cnAAAA:8
    a=ag1SF4gXAAAA:8 a=ss1IfW1GVHqlzswJ9RYA:9 a=zGUh9En-MpgNVJL1:21
    a=-XQGgGSnVC_UC14g:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755292AbeD3Uc2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 16:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755494AbeD3T0F (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B16022DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4.4 40/44] x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds
Date: Mon, 30 Apr 2018 12:24:51 -0700
Message-Id: <20180430190947.931137994@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1a512c0882bd311c5b5561840fcfbe4c25b8f319 upstream.

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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . J . Lu" <hjl.tools@gmail.com>
Cc: Jeffrey Walton <noloader@gmail.com>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180424212013.3967461-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/uapi/asm/msgbuf.h |   31 +++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/shmbuf.h |   42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

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
