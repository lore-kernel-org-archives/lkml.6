Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684311-1523561559-5-8222116039940980445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523561558; b=Q28Uy0WaC8EAWSjgHnLie6tD3u+kpImigpOLQyNRWtx9+W0YmU
    LiwZiPjJtkqIFZApoDxtFJfvO36sxdBQw7xS/yAUEUZaw1+ipYZdHsR66xxLTr+s
    Y4/AGwwxNmxOctUhtkXhxbyw+G5HQcsZcQFmF1k6M1ze9+6LnpSV8ABUzXUMcYDW
    mJvctytkE5E0Y3FPcvqEuckOt+nAvUatvseJxWFdR91D5RlfjBvpyjxWP5toCkfS
    WshLRYLTZgH2QJaTeyEFErn8sX+jgYA2qbkugP0JLCU57Km+67wcqiFb0vrE7RIh
    6EIgQpi1MVcK4B9oMWxBiIhuc3YCurbV3CgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523561558; bh=
    zYHzw04z6M2S3CSGAWPqc1k3MjSiMGTojCIHSMvy2EI=; b=opdTlIv1emQVPoQG
    pKuxMDvve8YS0F/zNsfikhroEDDyaVMPVyIVzNGg14aWnK2y5vfpfs2ryYn8Jzfl
    fUDWnoMhapI2R7MKgPNFBbub+GrIf+IpfxvNqcdi2VR9m4J/vPyPr+RQ4vTY4Ly6
    UX3BbCQnAqNPBMRtOMmf0Jvq1xD96JixmhW011AvUeJHrUxTMg/dSJyncvKrHzna
    rPUNOKl1Ewj7cpxAYDGC3RkqckvAGx+Df+/AfhUwSk0JOsbxgu8W8/7o4ntSAXGd
    +a0KKSGmKJRu2mC2DIdQBBXQnNthcAE8M3ICzxl9w+Ok51XL0ZehrFKBM6uU6jLH
    ifyCnA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBglavdVWWbVpkncQ02vykB9J45j8d3EUGNUkF3ViCnl51t5cVgh/8NzdPFripyfYcpDQQB+0eA8TKjRMsFUs9ya8atDW/OnURychqDAxgHNXsDX51De
    PP0thAtEyw5/rVklNe7+sw6coCT5TD92gVfC8a40sHrMyPQFHo5BOuKdG8ECV/CgezGGpcYtfrZFDDGBZZ/XDfScWfQXcdXyN8RXn1Q7NkVJspmR5TpGMGKD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=7d_E57ReAAAA:8 a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=JfrnYn6hAAAA:8
    a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=jbeimLwzA9XXGubRsbcA:9
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=FUarYpL4UH3yWsho8X8J:22
    a=HvKuF1_PTVFglORKqfwH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDLTbo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 15:31:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:45604 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeDLT2X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 15:28:23 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH for 4.18 08/23] powerpc: Wire up restartable sequences system call
Date: Thu, 12 Apr 2018 15:27:45 -0400
Message-Id: <20180412192800.15708-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boqun Feng <boqun.feng@gmail.com>

Wire up the rseq system call on powerpc.

This provides an ABI improving the speed of a user-space getcpu
operation on powerpc by skipping the getcpu system call on the fast
path, as well as improving the speed of user-space operations on per-cpu
data compared to using load-reservation/store-conditional atomics.

TODO: wire up rseq_syscall() on return from system call. It is used with
CONFIG_DEBUG_RSEQ=y to ensure system calls are not issued within rseq critical
section

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index d61f9c96d916..45d4d37495fd 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -392,3 +392,4 @@ SYSCALL(statx)
 SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
+SYSCALL(rseq)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index daf1ba97a00c..1e9708632dce 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		387
+#define NR_syscalls		388
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 389c36fd8299..ac5ba55066dd 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_rseq		387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.11.0

