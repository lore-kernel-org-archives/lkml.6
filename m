Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2056830-1525128473-2-10071765606020894382
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
    1525128472; b=TzV0yPdXBVhBTtsTpoOowson9dXR3KwuLg/vmwPE1UBF4TCrJq
    BMKMyWad8rru4sOZnYl5WSBLEhXwenSKolBbm9sxStsWcaSVUUkfjLJNz3kBC/Tk
    Vl/BIFQzzvHREGGv8sJYN6o4P3cFvq7aunnRDZ8KhZ/lNJLDdbxsFPyQUW+9NvdY
    ATEGP/NbTDWqEqCBUwnilIXw7hmOeeDzvTs7w8y2fPSQuF0LV/AOLCGz7g8Q7lQE
    hhhNKxhpsQJ366ZFYU19LB2ca96LEHAZZwko94wbliTzmeb0i/isALJzAPau0pLT
    /OboAZEjJCB0Rm/zbhP0+HU6unzoEnBs24ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525128472; bh=
    uS06LarinKMA7Z7yWjK4Sigx5XGJhTypSg+kiwdAlqc=; b=lk+zshPfgvCqckIc
    CsMbjP/4xmBuadFwzQSb4JrjVEstjOlfqp4/jEOVu+T4pPRJRcbC4DnGC+7Mc8S4
    +z9y+KGxkA9kJcz8PI937jkSFTedBLN0zq9YOaz2QFfrMzKka3nt77wVRS2/GIK3
    rFR928z12BDY5PVVJELgPiRyAEsoG7U4uUdAP9vPb0ZvkweIhtv78f7ZeSnYi75X
    qli1VWbhFFTrwVl+f9jZeh1LMSO6FjDDSPqTBa9Y3S8Jq4LXEMS8pTnI/bYHC1Sb
    UlbIR9XVH9C0VCritOsbYILR4kT2fQ9Hq7Zf+UjMq+AvUXSEo636BzrSAwocQeHK
    yheoqA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJDCaGuV1nKgOa2yJm8SU/QivHcCKbozs3DXo4VGjfyewVGinlb4H/3BVOdMqjHrB/1y7lfjK5Qc0+z5Zz4Mm92sekGu7xdDv8M1UUtw92a/n+bz0Ju+
    gkZUQle0ltAapdUahPO0jTq2vTWOTaDUAEWn7eW98u6/gD7wGo4PJ+a27ol6J7tzwLsgXjHmP6fzjway9ca+jJrOuDNciQVYGF9reypNsuZMx1LuIM1bXLJX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=7d_E57ReAAAA:8
    a=drOt6m5kAAAA:8 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=SOq6UgPBAAAA:8 a=WfulkdPnAAAA:8 a=FOH2dFAWAAAA:8 a=NufY4J3AAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8
    a=UPm3pfgAAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=UyVg9twnpGBeDI6iwygA:9 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=3hv5r9HjGAh9o5iR9qwG:22 a=56QPVbyS4OZCpcuOg7Z9:22 a=i3VuKzQdj-NEYjvDI-p3:22
    a=TPcZfFuj8SYsoCJAFAiX:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=uD9XBtlS4o1URY3aiGdj:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755660AbeD3WrX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:47:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:53032 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755416AbeD3Wop (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Apr 2018 18:44:45 -0400
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
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 06/14] x86: Wire up restartable sequence system call
Date: Mon, 30 Apr 2018 18:44:25 -0400
Message-Id: <20180430224433.17407-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wire up the rseq system call on x86 32/64.

This provides an ABI improving the speed of a user-space getcpu
operation on x86 by removing the need to perform a function call, "lsl"
instruction, or system call on the fast path, as well as improving the
speed of user-space operations on per-cpu data.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Paul Turner <pjt@google.com>
CC: Andrew Hunter <ahh@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d6b27dab1b30..db346da64947 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -396,3 +396,4 @@
 382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
 383	i386	statx			sys_statx			__ia32_sys_statx
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
+385	i386	rseq			sys_rseq			__ia32_sys_rseq
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 4dfe42666d0c..41b082b125c3 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -341,6 +341,7 @@
 330	common	pkey_alloc		__x64_sys_pkey_alloc
 331	common	pkey_free		__x64_sys_pkey_free
 332	common	statx			__x64_sys_statx
+333	common	rseq			__x64_sys_rseq
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.11.0

