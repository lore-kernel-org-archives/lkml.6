Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2532849-1522250051-2-3275843219038294100
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
    t=1522250051; b=mmJZyAZvkmgyYj16gmywjiTm4nsa4W8VvLQoynz4BnTrXRp
    hDLk3N0fVtPwZpV7ca9bIH76cKSDsBMjNGlOamFnL6L2NJ+LpeIaM2d+zBNIbqTK
    nYNZaIauGdRozhwJ9nYWYnrsoZW4t57jjkrApS6IhbXcn5qXWbvu0PINHEpmrizx
    602GYtC+gRA4ioVt1UdoLq0v1lM9JwI2fFQj8C86DwAs0fde2J3M7hSzIKB6tq/J
    gpVHEbDKUNyQCRB8VoEF0RA2k/2uU0PoWuy8JJLcNZQTGh2mtEOCq8h3OmWrjVAu
    zAhFr9USAZM69v9bNghgIOw3wNIvx7YtfGID6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522250051; bh=F0wDELhtxpPn9IJk9T3a8tfiX5oN5pUs63t0Q5OoPXQ=; b=w
    S6lWRHYTveICbZ0TZXaK29RFXmkU0eAYlhRcHOKZsHCwWMUpgXb3IvAByKcDbOLV
    OZREKOJvITYUXLwxi3DDGoicGTa7XBqCZCmyBk/7Y+eZc9oUotIXi+f4ULyvmnqs
    tuhHWPATaSda9AjuwEChr4PVEU5+8SdUV6IfvD8izUj/tGnwTGK4dJoBPGUtAK5E
    rrBm4qhteQIk6JhEtq/SNl637eboOrmcCKFWgY0HSEPeejW9UMHLD2q83gd1xnZB
    3I3Dd/8APQXF8bHDxe9an//Pr/ENtxl6CYL6WV23yJsq6oE5CbveGwkmHP+NSqHs
    q5pWWiTiN5wiwLVHqRaxQ==
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
X-CM-Envelope: MS4wfPkJDQrAEuDSiNgX0VqFqyq7Db91ZVqtTibW9KuG2+0+QhLGBnFx+EEiKYQ0aIaDl+spbt8TKp/ig1wfzV/oyzPumu+Ap33x8G8n41vpXdAOVvP38AMb
    MSoGmFGzjEP/3cr4yb0ebySf2v5AfCAHrNDBJITI49EgoCdLdwspJhFbxWcNywu/xMt0zdjKxWsSmhbXLXYV/VvnNmPa60Y510bEtXsTfihCxNIbmfljRJOG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=20Wlc2fOwMFx8HnaCNoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeC1POI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:14:08 -0400
Received: from mail.efficios.com ([167.114.142.138]:40438 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeC1POH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 11:14:07 -0400
Date: Wed, 28 Mar 2018 11:14:05 -0400 (EDT)
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
Message-ID: <265889560.1.1522250045589.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328145946.GH4082@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328125004.GV4043@hirez.programming.kicks-ass.net> <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com> <20180328145946.GH4082@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: Ik1ojtJFElSzQ4s6o7/12obPRpQ/aQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 10:59 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Mar 28, 2018 at 10:47:54AM -0400, Mathieu Desnoyers wrote:
>> ----- On Mar 28, 2018, at 8:50 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
>> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> >> index fb5fc458547f..66b070444a7e 100644
>> >> --- a/kernel/sched/sched.h
>> >> +++ b/kernel/sched/sched.h
>> >> @@ -1249,6 +1249,7 @@ static inline void __set_task_cpu(struct task_struct *p,
>> >> unsigned int cpu)
>> >>  #endif
>> >>  	p->wake_cpu = cpu;
>> >>  #endif
>> >> +	rseq_migrate(p);
>> >>  }
>> > 
>> > I think you want that in set_task_cpu(), right next to nr_migrations++.
>> 
>> This would miss the __set_task_cpu() call from sched_fork() and
>> wake_up_new_task().
> 
> Correct; but since those are _new_ tasks they _SHOULD_ not have an
> active RSEQ to begin with.

As long as fork() can be issued from a rseq critical section, nothing
actually prevents this. This is a fork(), not an exec(), so the new tasks
may very well be going through a restartable sequence when fork() happens.

> 
>> Those cases are not accounted as explicit "migrations", but it does change the
>> CPU
>> of the current task. So if for some weird reason userspace wants to fork() while
>> in
>> a rseq critical section, we want to trigger a rseq restart.
> 
> If at all possible I would make it SIGSEGV when issueing SYSCALL()s from
> within an RSEQ.

What's the goal there ? rseq critical sections can technically do system calls
if they wish. Why prevent this ?

How would you handle signal handlers that issue system calls while nested
on top of a rseq critical section in the userspace thread ? SIGSEGV on
SYSCALLs will break this case.

> 
>> An alternative to this would be to call rseq_migrate() in rseq_fork().
>> 
>> Thoughts ?
> 
> Yes, don't try and support that at all. It's _insane_.

Thomas told me those fork corner-cases should be correctly handled
in a previous version of the patchset. I'm following his advice here.

So either we disallow fork() within rseq critical sections completely with
some kind of validation, or we need to provide a non-bogus behavior when this
happens. Given that fork(2) is async-signal-safe, this means a signal handler
can do a fork() while nested on top of a userspace thread's rseq critical section.

So prohibiting fork() from being called over a rseq c.s. does not seem like
something we can do here.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
