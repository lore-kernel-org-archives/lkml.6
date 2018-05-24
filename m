Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-936554-1527123822-2-16016494980735649452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527123821; b=GcKZn2nYR8IBWKyWflTpzqu5a6FaAvUOujTHLqES4gN6f1VVLf
    JCpJf/6JGZYWFDzp0LFo5E/JKwe5EF23sLb4SW2/V6auvNMJ9M/MVMyM/RDXvxJ0
    QCdSWIf2j6+CXB4XB2WSIt+uIsi08i458rWm9TZku4n7UF2WPfmQVw38qf1GX4dF
    rRsS5wwrqVVMLGNB7fCYA56JKWcZd+dFTVqZb4iYHCyim7E4Y68QDa0QsNkoXyYb
    hc/GDLg4radxOLGrIAdkx2+Qa9L2cUhWgfSV87mSZBtyOTLQ6arf5mCAO5Rw6bQm
    wLjrc8+g3h4ul1SdzeGlVAIVeHsU8H3Yab7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1527123821; bh=97pcmgHz19I/PTa9GUBZk8/fQeT4eiH5BsWlxRBy7e
    o=; b=hOTAot4RjAxJr+dkO9SdXVa0HQWORY6OAIUaTOv7wt550XyqTXnd0nXfFf
    QuTiFsSkRLb6F2STHAQWyo2U1DCFROvSmxUjb4R/zF2HGEJSwpAAz1Pjod0apmST
    RfbiT8yVcvEluThMx9i8Yj1A4NLlD7x1qS9R3q334DSjSD31sSdgjZoREX/0h7zU
    zpjjtYbnQYeInRlqmZtBSAIHdgVkgCVKlbBWZDL5iZezzV+rJlwesXrrRY8XvgdF
    JP2lWWhn3VC0SsuOG85xANr3vMpYtx1epNzCz0P9Vlq4MW3NQP3/7n+NRoECUo+7
    FOvSbBkYL9QhvnGvC//Wl5knCzrg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ4rAHmiYgljFANRi7kK+Uf55C02oLc+u7zVfZCme7iFz2UuB+pxbcYETyfWQV6lvWfcUkhz3dSenpSfiBRi80UVVsFq7AEujGVzIeWVES9YMZtFzq69
    kbVLzJwmy3sgSkp30qoEQPiaiHxtCrm1dEzu2HYKupG3Ew/UWtaDxLu0R2eYe2fm8NRgRCyhx1aqwJeQSZjAORhnXMzpZyEMT2WgOD6xGopPsR6RAsw77UX9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7d_E57ReAAAA:8
    a=Ixqt2FsUAAAA:8 a=VwQbUJbxAAAA:8 a=VDRPkFbQ9hqd-elkI78A:9 a=xtgkuJUu8JAA:10
    a=x8gzFH9gYPwA:10 a=9eWGACQJV1QA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=wbNHd7AAyUN6gYWAVcba:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935263AbeEXBDj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 21:03:39 -0400
Received: from ozlabs.org ([203.11.71.1]:40887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935260AbeEXBDi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 21:03:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
In-Reply-To: <37442352.1577.1527110985175.JavaMail.zimbra@efficios.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com> <20180517011949.GA1121@tardis> <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com> <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com> <418003803.516.1526667437396.JavaMail.zimbra@efficios.com> <20180520140811.GB1121@tardis> <1928158599.1541.1527106479862.JavaMail.zimbra@efficios.com> <37442352.1577.1527110985175.JavaMail.zimbra@efficios.com>
Date: Thu, 24 May 2018 11:03:29 +1000
Message-ID: <87o9h5sw4e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On May 23, 2018, at 4:14 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
...
>> 
>> Hi Boqun,
>> 
>> I tried your patch in a ppc64 le environment, and it does not survive boot
>> with CONFIG_DEBUG_RSEQ=y. init gets killed right away.


Sorry this code is super gross and hard to deal with.

> The following fixup gets ppc64 to work:
>
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -208,6 +208,7 @@ system_call_exit:
>         /* Check whether the syscall is issued inside a restartable sequence */
>         addi    r3,r1,STACK_FRAME_OVERHEAD
>         bl      rseq_syscall
> +       ld      r3,RESULT(r1)
>  #endif
>         /*
>          * Disable interrupts so current_thread_info()->flags can't change,

I don't think that's safe.

If you look above that, we have r3, r8 and r12 all live:

.Lsyscall_exit:
	std	r3,RESULT(r1)
	CURRENT_THREAD_INFO(r12, r1)

	ld	r8,_MSR(r1)
#ifdef CONFIG_PPC_BOOK3S
	/* No MSR:RI on BookE */
	andi.	r10,r8,MSR_RI
	beq-	.Lunrecov_restore
#endif


They're all volatile across function calls:

  http://openpowerfoundation.org/wp-content/uploads/resources/leabi/content/dbdoclet.50655240_68174.html


The system_call_exit symbol is actually there for kprobes and cosmetic
purposes. The actual syscall return flow starts at .Lsyscall_exit.

So I think this would work:

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index db4df061c33a..e19f377a25e0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -184,6 +184,14 @@ system_call:			/* label this so stack traces look sane */
 
 .Lsyscall_exit:
 	std	r3,RESULT(r1)
+
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Check whether the syscall is issued inside a restartable sequence */
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      rseq_syscall
+	ld	r3,RESULT(r1)
+#endif
+
 	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)


I'll try and get this series into my test setup at some point, been a
bit busy lately :)

cheers
