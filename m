Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523906496-2-5279136330510719859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523906495; b=qZZl+pLQ0TSyQJT0lNefefF/3GsydDrSpzPSNyy39/4/I8Rk16
    sJuFvWhQTyMkJMYcnvGE6p7zIK+vB73d+XBqJYdt2tNPfDy1F1ms+d+gWoEjC4+B
    KE/0gMiMd80ASGd3iL9BBQNtH4qmiXk7uKYskMB303wcyx/G+RcYpnwVgvBYPicr
    9mHHv9QIExDUaxUn05L5rU23G4+KrYTlTHCUd0OX4yxfpgwKa9oxW8+RAxUlXq/5
    ig15f8O7LFdSZyX7Hxd4Aaa9EAB+k8uV0RUSOOGb46d5ckyXsuUGGAA6pzIi891h
    fwdbL34s6O1IGq8ML1GZTar524h3mqKc92fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523906495;
    bh=1j8OZQBW1r+f/PbYdveKd//VrIsExT1gP1mxUKTz/d8=; b=M/x/y5p4SMa2
    x85lGFhzbZ/VqhqccaNOxpgrqNMjx3eptaD8XYVQOR2f1ARWhoTd0gdsWQ+0yXA4
    MP1DWFmdNrhNw4Mvt3MFW82QSYKSy1CoqRZ0QpDitPt4gZ2iiXaypsjUnNFlyG+i
    50dMbuqXRC6nhVWKK4/e0GyhkO+X8u0oVwtM1TC/ybj3A5hNw8K8jG4bW+2aEkSb
    rAfjbBaFjc+KoQq1zCQd0Kv6pMmJ5NjersYyMax1s3hsaUnPJ8EChPx5K7NIqHCl
    tUJQ3qid0BfnZhkkyVRYwCeXFVo2zfWa7w9jcQZsEyqVQ8wRffKwJA3+9LoOpC86
    VeGjZ28GrA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfAHGo/L4ZryhqWsS28hjY9jfkTJXO1hradsCA8h7RHsPKiz7/xjWB0FUJhNR6cqZkBRUhaBj5xPgG3DoIFewcSGLQ449lEaoPvPCtag8MBuPz6+CZ1h1
    uW054tswhRR2C0cB6MiHX4zQdt61jo/xa02Qki711V7y7PXHBVRSCvzdQL01mNnCWRQqGwGCUt5i3YsFa91IGB+LCPOaRa8l0xVQKgoHlak278XvlOrdCHLc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=Z4Rwk6OoAAAA:8
    a=7d_E57ReAAAA:8 a=MIM8LbP3AAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
    a=NJYkrO2c28-5KqFRin4A:9 a=QEXdDO2ut3YA:10 a=DebVZ97QW_0A:10 a=x8gzFH9gYPwA:10
    a=9hryqLgqqyEA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=qPukjlzad2ENK56mnR_v:22 a=_FVE-zBwftR9WsbkzFJk:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDPTVW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:21:22 -0400
Received: from mail.efficios.com ([167.114.142.138]:48204 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeDPTVV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 15:21:21 -0400
Date: Mon, 16 Apr 2018 15:21:19 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <435471300.11403.1523906479091.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzZtY5ELKc+TGf9BA6px300BNzedadm_yNXzODTKN=HgQ@mail.gmail.com>
References: <20180412192800.15708-1-mathieu.desnoyers@efficios.com> <20180412192800.15708-13-mathieu.desnoyers@efficios.com> <CA+55aFxcJ2V_1BoW0Cct=Kkp7REkgiU_BTimGdmoFmWHaWaZ-g@mail.gmail.com> <CALCETrVvaMWUJKx+bxXdEm3oVBzn2r5RuJ4JcXNzOPSgJAC5PA@mail.gmail.com> <542721578.11358.1523903708510.JavaMail.zimbra@efficios.com> <CA+55aFzZtY5ELKc+TGf9BA6px300BNzedadm_yNXzODTKN=HgQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 12/23] cpu_opv: Provide cpu_opv system call
 (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: cpu_opv: Provide cpu_opv system call (v7)
Thread-Index: Ff77n1/BvNFIfE8ClB/Y79KRWce7Gg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 16, 2018, at 2:39 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Apr 16, 2018 at 11:35 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Specifically for single-stepping, the __rseq_table section introduced
>> at user-level will allow newer debuggers and tools which do line and
>> instruction-level single-stepping to skip over rseq critical sections.
>> However, this breaks existing debuggers and tools.
> 
> I really don't think single-stepping is a valid argument.
> 
> Even if the cpu_opv() allows you to "single step", you're not actually
> single stepping the same thing that you're using. So you are literally
> debugging something else than the real code.
> 
> At that point, you don't need "cpu_opv()", you need to just load
> /dev/urandom in a buffer, and single-step that. Ta-daa! No new kernel
> functionality needed.
> 
> So if the main argument for cpu_opv is single-stepping, then just rip
> it out. It's not useful.

No, single-stepping is not the only use-case. Accessing remote cpu
data is another use-case fulfilled by cpu_opv, which I think is more
compelling.

> 
> Anybody who cares deeply about single-stepping shouldn't be using
> optimistic algorithms, and they shouldn't be doing multi-threaded
> stuff either. They won't be able to use things like transactional
> memory either.
> 
> You can't single-step into the kernel to see what the kernel does
> either when you're debugging something.
> 
> News at 11: "single stepping isn't always viable".

I don't mind if people cannot stop the program with a debugger and
observe the state of registers manually at each step though a rseq
critical section.

I do mind breaking existing tools that rely on single-stepping
approaches to automatically analyze program behavior [1,2].
Introducing a rseq critical section into a library (e.g. glibc
memory allocator) would cause existing programs being analyzed
with existing tools to hang.

And I try very hard to avoid being told I'm the one breaking
user-space. ;-)

Thanks,

Mathieu

[1] http://rr-project.org/
[2] https://www.gnu.org/software/gdb/news/reversible.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
