Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523480257-2-16495028003660829217
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
    1523480256; b=gakFHMP2QYOBBNBkVnavnx/TIAggSQ9lFkHK/HOd5Zww6CZITE
    3BerG3Vy8nch+FdiLuTePWgq1RfsoULPgmtteGUE7RvHSpxTykzXrzGI5VMwX/q6
    0WCDt8OtNUuG/teURX24VqtIu9jpTo+QI2Doiu492FQ3z+qCV+mWgh3Ux8YlGsQj
    bTZrHylMDCFFjYBVKJZSOdsMbx2riThd/+LcGO3SYARQf06NMJdkuzeaFP8D+QnZ
    qATrZDAABa/pSeUyQy7ZLWPfAcs6Vtp1y0NLCl+XGQ8Gmg5BtsAshGmqc5SsBgWQ
    9A71XxaXvQllliUwXyBWl46eh5W19R4gWt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480256; bh=/ZpuUvSAbJwqc9D4jEDIMfwj9OskU+
    HoSYsvIQ1YLe8=; b=iyXpmo06538+ULKj8NJYon46C0jvMtkM+cl+hGFgWKlVTd
    RW9SR8vh9t9SfAlFqPcnAI9jCggRp+1zY+ELAMMJAbePzAF349JwpkV+OHXDeA+l
    qxq4M/7vr7dzAYSRvWrOx3lwt0iWSbrFdAk/68nv3I29hKEtOHivS4jBFUYgwzNb
    f44ts1jtwQnbffrs3f976mrU4jR4n9J4A1iuErH7hMZ8080/P4C2KrvkmcwtOuEy
    Qih70KoOdwxwXegfhLnpuOg2tkyzO95a6qpngPoBlKhIuI8S6fSrD7H5IlVgCa1M
    Rth6/9Rfe+41S3EFCjLeiSFx7wWU310X9jH4HWGA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfAP6WxeXhdxdIZ2Gju4J9RGZTM0RZb2RvvegDbtr6HjIolqZ6Lirf58vmwQKNAbE0MySKtbCI7w77Td7oLLl25nUYb0i6Wbnn1t6Je8LhfRsWYzKZ6Vu
    WshDeKebhHyWUG7GUhVUDfmkQpt7rvvq9+DnOhvCzcqBXYQUFtXP9dc645c0ZenXNOGIqem8KPMMPBi6qZUhOoskDi2PVwyyE+LOiaH/oXB7ZCXI89H4RbLp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=Z4Rwk6OoAAAA:8 a=vmLDa1wCAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
    a=4RBUngkUAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=VLsEIhHLWAUXoIV3lX8A:9
    a=t18etBAExu2XA1lv:21 a=AnXVmS_SF5hm0Qph:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=HkZW87K1Qel5hWWM3VKY:22 a=h8Bt5HTj68qkN2fS7gvA:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755404AbeDKSo0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbeDKSoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlad Yasevich <vyasevich@gmail.com>,
        linux-sctp@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 004/190] x86/asm: Dont use RBP as a temporary register in csum_partial_copy_generic()
Date: Wed, 11 Apr 2018 20:34:10 +0200
Message-Id: <20180411183550.335450079@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>


[ Upstream commit 42fc6c6cb1662ba2fa727dd01c9473c63be4e3b6 ]

Andrey Konovalov reported the following warning while fuzzing the kernel
with syzkaller:

  WARNING: kernel stack regs at ffff8800686869f8 in a.out:4933 has bad 'bp' value c3fc855a10167ec0

The unwinder dump revealed that RBP had a bad value when an interrupt
occurred in csum_partial_copy_generic().

That function saves RBP on the stack and then overwrites it, using it as
a scratch register.  That's problematic because it breaks stack traces
if an interrupt occurs in the middle of the function.

Replace the usage of RBP with another callee-saved register (R15) so
stack traces are no longer affected.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: linux-sctp@vger.kernel.org
Cc: netdev <netdev@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
Link: http://lkml.kernel.org/r/4b03a961efda5ec9bfe46b7b9c9ad72d1efad343.1493909486.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/csum-copy_64.S |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -55,7 +55,7 @@ ENTRY(csum_partial_copy_generic)
 	movq  %r12, 3*8(%rsp)
 	movq  %r14, 4*8(%rsp)
 	movq  %r13, 5*8(%rsp)
-	movq  %rbp, 6*8(%rsp)
+	movq  %r15, 6*8(%rsp)
 
 	movq  %r8, (%rsp)
 	movq  %r9, 1*8(%rsp)
@@ -74,7 +74,7 @@ ENTRY(csum_partial_copy_generic)
 	/* main loop. clear in 64 byte blocks */
 	/* r9: zero, r8: temp2, rbx: temp1, rax: sum, rcx: saved length */
 	/* r11:	temp3, rdx: temp4, r12 loopcnt */
-	/* r10:	temp5, rbp: temp6, r14 temp7, r13 temp8 */
+	/* r10:	temp5, r15: temp6, r14 temp7, r13 temp8 */
 	.p2align 4
 .Lloop:
 	source
@@ -89,7 +89,7 @@ ENTRY(csum_partial_copy_generic)
 	source
 	movq  32(%rdi), %r10
 	source
-	movq  40(%rdi), %rbp
+	movq  40(%rdi), %r15
 	source
 	movq  48(%rdi), %r14
 	source
@@ -103,7 +103,7 @@ ENTRY(csum_partial_copy_generic)
 	adcq  %r11, %rax
 	adcq  %rdx, %rax
 	adcq  %r10, %rax
-	adcq  %rbp, %rax
+	adcq  %r15, %rax
 	adcq  %r14, %rax
 	adcq  %r13, %rax
 
@@ -121,7 +121,7 @@ ENTRY(csum_partial_copy_generic)
 	dest
 	movq %r10, 32(%rsi)
 	dest
-	movq %rbp, 40(%rsi)
+	movq %r15, 40(%rsi)
 	dest
 	movq %r14, 48(%rsi)
 	dest
@@ -203,7 +203,7 @@ ENTRY(csum_partial_copy_generic)
 	movq 3*8(%rsp), %r12
 	movq 4*8(%rsp), %r14
 	movq 5*8(%rsp), %r13
-	movq 6*8(%rsp), %rbp
+	movq 6*8(%rsp), %r15
 	addq $7*8, %rsp
 	ret
 
