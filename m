Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486815-1522348545-2-7050100446219535335
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522348544; b=Ruu442ZEW54iqCXo8A3K40F12z6noNjd1A4mkdRrYmNcQPELmx
    ObtooUYds7ANMXhHYo+9QA40VE8sgF7ecU2i9fYGpHpwsxhkEMOB2KWwTI13by68
    Es3Q6CUSoH777f3b7HKKY8m6ia3CqMcNK1mY/GpTOZMaSODTia2rValGyQQeyqsZ
    ZDogv/KWxoEs2R2IeP8Uav4jE7F+g9ZP1Vr60hjyd4F+wwSGbmnCt03SGct08zoB
    WYbog06e8tQfWrJR0FUHWKAzaopv818J38gkkhCzFEAWiKXy4m4PyoG8aIsW5/cn
    PqvwWA0CWNMCK36vHqJQUGkPjdniHbfhwQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522348544;
    bh=0AbDpXB1M8mi52SDXzhuRIHUp38TzunQTDj8XKfEAnw=; b=fI9YDt2KtdJ1
    24zVCp6HQ88Kt8PrkuoGhjexLboTuVitmAlHLxJ4Pdb5b7dfmDs5KR5bavZnd4vD
    T12JLutWKNncYc/FMRy1teEgInEf3mAA+5VSeJ++UZ6791E8pHWrqf3fAgko/pes
    es0EjNoe6QMVsy+3YOeJQzZkq7M8OY++GtqzYYXtexf3tVgxPivRAvD7duSGuvqf
    LXgEWndFPg+Z75kbRHyubbCY/o+y6qcFMi+vMmqB6FivDxq0+MOP5GjIam9NeMOw
    BOXRpVluTExLVLm80Vh0LNPWfNLJiR29inNULW+L/+P8moWkjfbAfbfr7T5wMr02
    CDmwpzFRhw==
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
X-CM-Envelope: MS4wfKngE5QcDmxk8CwOQu4clPkvI6epguWiPGc0aTn4mi7o2hyXlgVCmWdNJo+DiLjqG85in1qYMUzWneey2p1UTZjWvg2cNN4psCkpVEqzrPcCxpJP6B6T
    rEoV8kSYR8hWI+J5zuo9eZMgXFs3vMFtP0QlbAXiNENxlG1+3hA1DOCR+/+D2batwsehW/rhEpvJLnkd1AsUD/3W/FngYbWsr4aYMrPDAtC8RtDzs6xOYYC6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=meVymXHHAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=ew_ytPshZF2nGxeuS7kA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeC2SfU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:35:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:52096 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeC2SfS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 14:35:18 -0400
Date: Thu, 29 Mar 2018 14:35:16 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <1657598086.875.1522348516598.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180329140752.12661138@gandalf.local.home>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1803282305030.1496@nanos.tec.linutronix.de> <87410797.545.1522331641598.JavaMail.zimbra@efficios.com> <20180329142338.GD4043@hirez.programming.kicks-ass.net> <544124089.623.1522337940950.JavaMail.zimbra@efficios.com> <20180329122439.4a909c72@gandalf.local.home> <21903915.856.1522346553810.JavaMail.zimbra@efficios.com> <20180329140752.12661138@gandalf.local.home>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: gA/dD3LVfqsnqJskpVlD2WUe2Cj1VA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 29, 2018, at 2:07 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 29 Mar 2018 14:02:33 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Currently, anyone using ptrace on a process has pretty much given up all
>> hopes of performance. Processes will use rseq to gain performance, not the
>> opposite, so this deterioration will be unwelcome.
> 
> The ptrace path has nothing to do with ptrace anymore, and probably be
> hard to notice the performance hit. You simply set a TIF flag, and on
> exit of the syscall it jumps to a path that checks special cases
> (tracing system calls being one of them). It's called the ptrace path
> because ptrace was the first one to use it (I'm guessing, I haven't
> actually looked at the history).

Last time I checked, it's not only a jump, it's actually saving/restoring
tons of registers. Did this change recently ?

I use it for LTTng syscall tracing too. My experience so far is that it's really
terribly slow. I've been waiting on Andy Lutomirski to complete his changes in that
area to look into making this faster for syscall tracepoints.

> 
> This is used to add any system call checks that are not done during
> normal operation. And this certainly falls under that category.

I know it's used for stuff like seccomp too. My guess has always been that security
people care much more about robustness than performance.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
