Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-147225-1526667443-2-3842309631412599985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526667442; b=alJT5VkLGAmZzfN8cI0VnivMv8LrRbVycRaNbeWJc6zctHrQQD
    UbFH5fcFrDSwjfqWhh3w1uK6tvjaOlqRmSBui1PksR631Yp66F7+xVL+QZJdo9oG
    By+Om91n87eCJleErE5F0kRXzsGR5g7JmD4Cxd0ZziVNI5YZ/QbaPn6Fmf8DMjbU
    hU5ApGhooTxD+CuBJtNYTLhKXl/L0UcR06uk/kHnBguTIyyCMZMXWYp+SbrJxaof
    ZSQ4sZcJh3JVVvR7oqe+AOv9MW5CKXgVwDIBXH6sGMjXkjrNaL6OTYtiF4vtisVd
    TqzlVULLyfHo9bVihpnm82ypaS+7qDzhAerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526667442;
    bh=fcyKwUTg4EcMfj7vyb38ddbV1C98nCZjo9k2RgWxD44=; b=Q49JVbDR7S7y
    K9IRn9ysSjod33bIz2eOlyygtuSeba3JXdpe87uKEfBpi2ll3oexWXmjq5j/HxyS
    miqDqIPmNi/a6kTfgNTpCzbrKFPvrMWmnKpxAhVPCqB3awVm72r9+QmGmtNvJdpK
    GcCxjmr53e3Haz8k3qUzZlk/kiZLCjrmLUDTP7sl4UB/2kenjym5Y79ILaovC3DR
    1/bhG3rXAOpb5VaPkeyGPrpSEktksvltXfV+Z43jYDV8cpSMeH61HqivGdglbpbl
    sxPV5EKW3LbNvCJGHurzU7SP6RCpdDJ7i3WRY25U157gYrSLLEuNC09+N6ThKVqg
    Pe2GlCl3AA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=Wf2XlopA
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=efficios.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=efficios.com header.i=@efficios.com header.b=Wf2XlopA
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=efficios.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOd5AsWPguRBWJMoRptHzgh2zY2nz7IhJZthR+/QWx9xVsI5e/vlPdRJ4iwsvPoOEw1nEAYEJS0O3il5egngwROYHinLBEw9CPetIrnX9HRrteI+BHV/
    lRK+l93GvEPkbyCcQ2CGA+P7NIOt03BGLn99KlZSXIViYXbgt90wzM39QUgHBxMIOnw5RjCUT2o9/wk+Ea7dgeq0V67eW3rDTqqeku3yTxBSkrZOA3JCscQ4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10
    a=pGLkceISAAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=qbjRPukCw1cQcatMnskA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeERSRU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 14:17:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:44342 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeERSRT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 14:17:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A7A6A1C1969
Date: Fri, 18 May 2018 14:17:17 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <418003803.516.1526667437396.JavaMail.zimbra@efficios.com>
In-Reply-To: <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-8-mathieu.desnoyers@efficios.com> <20180516161837.GI12198@hirez.programming.kicks-ass.net> <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com> <20180517011949.GA1121@tardis> <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com> <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: powerpc: Add support for restartable sequences
Thread-Index: 1A7RFRrmRo3xEcnLH0Co3AU++l91gQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 17, 2018, at 7:50 PM, Boqun Feng boqun.feng@gmail.com wrote:
[...]
>> > I think you're right. So we have to introduce callsite to rseq_syscall()
>> > in syscall path, something like:
>> > 
>> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> > index 51695608c68b..a25734a96640 100644
>> > --- a/arch/powerpc/kernel/entry_64.S
>> > +++ b/arch/powerpc/kernel/entry_64.S
>> > @@ -222,6 +222,9 @@ system_call_exit:
>> > 	mtmsrd	r11,1
>> > #endif /* CONFIG_PPC_BOOK3E */
>> > 
>> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
>> > +	bl	rseq_syscall
>> > +
>> > 	ld	r9,TI_FLAGS(r12)
>> > 	li	r11,-MAX_ERRNO
>> > 	andi.
>> > 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
>> > 

By the way, I think this is not the right spot to call rseq_syscall, because
interrupts are disabled. I think we should move this hunk right after system_call_exit.

Would you like to implement and test an updated patch adding those calls for ppc 32 and 64 ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
