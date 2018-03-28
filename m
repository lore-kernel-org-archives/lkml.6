Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2532849-1522248503-2-12658632116128713161
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
    t=1522248502; b=GNec3JMd27zL02mp71bO5ZiEOqx7Jo7/KvfgFc7SxqUP5fr
    NfQDZ6csQaJFxbrOUvzVRbrn3Wu2wkTBN4us/TFviUM0gycjymEUnEnLuqR9TqfU
    FIBJ39Gr/w2ahCFE+S4B03JPFhQgVJpmBsDdRuRo5bN+WTDR8uVF7J/Ibbelv5Zx
    IIkB2FctZ1WfdkixetdwrgTp7zts3c3oMSRECJLSyVgf+9N61AT1W5FevUZz/hJx
    YgHXx9Iwa7YF0Api6DRwAUJ1+IT/1aB9hRHeGR+0ZIzc4GcBhSPQcWYinjHLHvmm
    3P76FvfxeFJVcRZnLlV3MILGhDL4zYa3HQENkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522248502; bh=zPy55IiGyDbBxOnLyAmAYHE9A5S7i4+mA09YOLLw8W4=; b=O
    hK6kxGg4wudo1naoemmGIxDh/gMyhDzYb+1oruB1o7IL2xRQ0UEktdQ/G/ox4rk5
    K/VRCLUljV1d9dNX/ThgfuQBFPCxWbap8hInNHKpejOZmjPxdNV3hY/LvEucsU7x
    lbft+xBLA1J6eud1zQV+bKRV7HDk5QgExXEzTba/B6Y2bcncMaFsyaJnPrMRmFGe
    NrXnJQk8QnOuQ5BGfpIqD2jrbS6vj388J/k0gNzJG1lZix93+pOJqJMTqN6rbJNX
    4mG+7x0tLeAmuHwvP/Cc59fb72rnZGWnfOL6q24EIKfiorzhP60+nDNO3kGCF0Nj
    wnTNh4cKlvkS4MGIYqejg==
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
X-CM-Envelope: MS4wfMoWPNAVrM80tlJgNh6iBF/OaFXQ7e9evuMAFIiTwQTe8W0jsuLc2jmta/cEuTPWX5QLuxQuq4NmhtjFS8oJ3cACZfECzbhIPj1lRh3WMMv4HbiP4ebV
    fSmfhQ3efbdAavRe6EGB+Wo95VRNvJU2TWaX+T/GANLUbcKkoQwuPD2qYrkff+x6fawe6o8DQ/jk1rxV/z4rNvfZKxDx06UMErhvMhX2eTnP66lh8FhhfzVk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=A3FP38jFBYwwCQduu2EA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeC1Or7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 10:47:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:38264 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeC1Or4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 10:47:56 -0400
Date: Wed, 28 Mar 2018 10:47:54 -0400 (EDT)
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
Message-ID: <1523662633.2105.1522248474778.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328125004.GV4043@hirez.programming.kicks-ass.net>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328125004.GV4043@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: g8G18zlpGluv5V0WfpsSPI+DeO7luw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 8:50 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index fb5fc458547f..66b070444a7e 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1249,6 +1249,7 @@ static inline void __set_task_cpu(struct task_struct *p,
>> unsigned int cpu)
>>  #endif
>>  	p->wake_cpu = cpu;
>>  #endif
>> +	rseq_migrate(p);
>>  }
> 
> I think you want that in set_task_cpu(), right next to nr_migrations++.

This would miss the __set_task_cpu() call from sched_fork() and wake_up_new_task().
Those cases are not accounted as explicit "migrations", but it does change the CPU
of the current task. So if for some weird reason userspace wants to fork() while in
a rseq critical section, we want to trigger a rseq restart.

Note that rseq_fork() implies rseq_preempt(), but userspace can request to
track only migrations for a given rseq critical section (by using the
RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT flag), so the rseq_preempt() in rseq_fork()
is not enough to restart if a migration between CPUs is done across a fork.

An alternative to this would be to call rseq_migrate() in rseq_fork().

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
