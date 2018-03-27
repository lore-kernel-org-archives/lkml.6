Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4170472-1522167666-2-7365730842869744885
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522167666; b=urRUFcS7XwQAozsJc488T9HAOcnvrgJFei4sHfwJ2q7Fnvc
    7S2E9CPjLfs+4ug2aS8J5nfWL7yh7XOVgfc506pDsMB5hbLeGSQg2BxY2ZsiZCHH
    g+3vL2xTjuxPl7UVQ7V4u+HRY4J9r1GUju2ZA3B295nZBOi6UAEXD3PDcBhNq7c1
    KnXy89jRHBbKjGp6ZCrd7X0VQ9+tAeLvnO8gH6jl2sGtJa9QMtvDMtHLAd5XNztg
    NUh1rTFhNKfsqPdwCvOXuCgeXbIogYcciVrUMlAct/o3bTsaczM/QxJbeafpLdAi
    5w1gQcytXiidq71gKYn8BZysM5WrHCRcpLQ/hMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522167666;
    bh=CnLgISNtKLORhO6CDUCTk3YDYRw7HMvHKYN9JsMI/Y0=; b=VkKqVUB1SHIB
    AJzkNhR8ni67N+SPO4ti5HihQX/wS3/2tj/4lNW+2E5/+N+Ry1uFJRfx59/Q82pA
    iPak4E524rUhjMo9KZrOAJXqQIZIalbzZiGGosXgX+4cOZufMjCM/H9vMxj4kV3G
    HWDrmDD/QoFmf0H4PNU4u0LyRysYnDSmXI9qo0sLtK8005nCH2M8dQGli9iLZerr
    ciWDQt7YSquAfyChiLgc4QDMkL/SOuzzH95Zu27CThxuV69GZsmf96ASIRM7/7mM
    H9VCPVzZ9O6FJ3Hrw1GV5J51xeB5GpTSAdCXQpkYn3UUF6zH41un5RQjMkPjRl4o
    coLD2HDNAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCY/0zuk9tSihV9NoF7fCF6sshkdYQdSjuMLoIyI5Bs+30qIk4J9HxYGBOAFMslbQiS0QLLBIlb4cMWz5cEFM6YnVkd2fF2O6L/NeU5OexxLyRMCIpOJ
    6YxA08ZqYMDIsFqWmXJAwqmlqxBxZ6esKZJwa1ZqTM0nCoWqMXZ1F/CWh8GPATV0/fOmEiXFbTKT22LYXaBM0xeBOZ2e+2z+X711Em38DCASBs/fbje/Dh5G
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=7d_E57ReAAAA:8
    a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8
    a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=HmvUrT-d3P1Or3OYpdIA:9
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=FUarYpL4UH3yWsho8X8J:22
    a=HvKuF1_PTVFglORKqfwH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeC0QVC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:21:02 -0400
Received: from mail.efficios.com ([167.114.142.138]:53952 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeC0QVA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Mar 2018 12:21:00 -0400
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
Subject: [RFC PATCH for 4.17 12/21] powerpc: Wire up cpu_opv system call
Date: Tue, 27 Mar 2018 12:05:33 -0400
Message-Id: <20180327160542.28457-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 45d4d37495fd..4131825b5a05 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -393,3 +393,4 @@ SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
 SYSCALL(rseq)
+SYSCALL(cpu_opv)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 1e9708632dce..c19379f0a32e 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		388
+#define NR_syscalls		389
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index ac5ba55066dd..f7a221bdb5df 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_cpu_opv		388
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.11.0

