Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629663-1522251431-2-7372709631314986350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522251430; b=lhfEEUCuppo4RjVIC3MCnuPiDpDQ/JKtAprE8AZ6QqCx3q3
    M/HXs3wgcp5kxo4+G+0C70ulaS7gs1N2ZXy6Qgw2EFZC+P2p5kTADt+AMxGoz1Nd
    EIhOzk0++G7+8sk2m4a1lX1PthB2XGWtYArghIStdDzdy5iqBMP8UTHMXynlZ/ek
    A40ukLzhkaIZf6A2GDJBpRoeXOFz5DCdMMgozEeMG/7xt+V3ZGUVdzl/LaRmDk3t
    /GsAXw5zLl4awmlAyqcd6MsOYkG7E9ViP4rey/89tCCm5Zm65Z0FgXu17RL2NN4x
    0OQ2W1NShshzZBFkylsh6Ru/YNJO+FmRbFCJ0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522251430; bh=UrbRC3x5AQVBEILSHbuypPu/aaaYNmtyZinlYYWqbdU=; b=c
    Md9wWq18nwpPEnc1YNTRrDCjfI8zeywYkeszxvBMiRnMyd/8dPgfF4EaiXmNiW0M
    2YT38ZyuCmkCbBhWZpdXhfPv6eRlHkV7Thee61TSkT4zqDHwx7EgOJq5/qEn9RGL
    F+jH/QcqgbExZhPq843AVO6wEMSzdFvRTad39145QSf0B2dihLdsDymOutqogdd6
    USwbO/BaOTLjzuvWk7tGGqrCMnenTy5aSFgY3zlusdV/EVxUkMwjKcffQpFEXdVg
    FRrM/YhbbDpXxJxzx1XaPn2U+ReiU017W4on0Oe9pLsN/JzPhMb+1Bf73wTdf8Gq
    ccNRZP7TUIWmtN9ogumrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfC2ADEK6SIPv5ZdGl/LFoee/tzhO4T+JPysVo1DwcnS5XLg2MjepqcwytwWcWxzVDCqX/NhSP1d/VsRmNmj/CR1vJyfH86otIG/jEdpeAAiaPrsDrcPZ
    ykBmopn/p8bCCKPRNSShgk08cE7xFSXoTdp82K/OEz3qFnkhn3IKMQIzE/P/aCCZtPdCSrLBlNrHFmVuCc57NcBWNuXettgF9LrV36oaMFvq4SikqLyq2GLI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=48HfJITzWo--25tXGfUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeC1PhJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:37:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:56236 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeC1PhI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 11:37:08 -0400
Date: Wed, 28 Mar 2018 11:37:06 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <533214853.56.1522251426819.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328152814.GI4082@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328125004.GV4043@hirez.programming.kicks-ass.net> <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com> <20180328145946.GH4082@hirez.programming.kicks-ass.net> <265889560.1.1522250045589.JavaMail.zimbra@efficios.com> <20180328152814.GI4082@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: AVjWRlNGt9WFz2erjnsjwdrgt4y+qA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 11:28 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Mar 28, 2018 at 11:14:05AM -0400, Mathieu Desnoyers wrote:
> 
>> > If at all possible I would make it SIGSEGV when issueing SYSCALL()s from
>> > within an RSEQ.
>> 
>> What's the goal there ? rseq critical sections can technically do system calls
>> if they wish. Why prevent this ?
> 
> This all started as a way to do 'small' _fast_ per-cpu ops, System calls
> do NOT fit in that pattern. If you're willing to do a system calls the
> cost of atomics is not a problem.

I'm not arguing that a typical rseq would do a system call. I'm merely
pointing out that if we start putting arbitrary limitations like "SIGSEGV
when a fork or system call is encountered on top of rseq", this will cause
pain in user-space.

> 
>> How would you handle signal handlers that issue system calls while nested
>> on top of a rseq critical section in the userspace thread ? SIGSEGV on
>> SYSCALLs will break this case.
> 
> Have the rseq thing aborted prior to delivering the signal ?

Not if the RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL flag is set either in the TLS
or in the rseq_cs structure.

How about we simply add a rseq_migrate() within rseq_fork() (when
forking to a new process), which will allow me to move the rseq_migrate
from __set_task_cpu() to set_task_cpu() as you request. Is that solution
acceptable for you ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
