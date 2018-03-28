Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2462495-1522245988-2-3238932050922909975
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
    t=1522245987; b=M3PTbkVGoPfRJRQqn0zOMbH2oDu4FjzVomakBVA2UD455GV
    vvdcOkptMuG+MfZHaEMbk+Q+mSDKoSt409M1dRl1CguScd/Rgk3bglyw3R2y5t+h
    718MxqmQghhT/ntfpi2zB0/FQeOQg0cctQrOY9v8D4fmLtJE9s4v5rO+JLIsTB5Y
    YsiPi8XbuLznoX5KgWfcMw/phH/DlB7t3u/zZ4S1i+uMP52WvbmeVtSvZb0lLwOA
    CriSWvZvqpyAhcx+DjTd3tGbdn2jSiBPRNJSxe0Mzv10iw0hKAzTqgXiZNs/1KYe
    T7MbvlqZjPR7g7K6LEgTD5NVoo6tzSNfsc0kqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522245987; bh=Wyvx/ezIcepeQ6QstJ4WtJLspn5CuO45jLs90/GFdb0=; b=s
    M4g6UuzzWzx+w7Yh75w8O3d8BSOSixsTKq3suKtY2WTMMBG4TIGGWjJ4kCyQ10pf
    0l7nOjQsTbZOgDtOTAu0nais6T0gmk+gONopJg47Y60YkpVKIvVitIezmeVxfanA
    DRwxqdbktloyIWT+4/G4b69oI3AeHtVqOfXIox5wkr8qvUsVHDAK2gN39mV4gMXA
    ekVhiFgdsjDHVcViveccqai6cW9Ve9ow5hbNZif7CAbLe54nXoy8fK6LjAh6t6E6
    PKbCPCK/fDDHbS4XUxg5Qx17GeRfx3AbH4BF77AtcAq1YJF3wg0J5bhTS4k0Q65K
    oyy2xrxuQLCcdmkmzS4Xw==
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
X-CM-Envelope: MS4wfK+z5KRYBoc2t5cqCtUh7m5Xy/SJgLlpPUi2G+kRMHoTuWjFjJinYujoB4Z5y1okbUJ++2z0AoDJPb+DyhFLHGtpH3+qytPv13avDjL/f4fUKslmFiwy
    OYLz51N3CvJYOp7Zue4tF4vwiXCAFrzTTNn2fXe/HKrKPUZZ514MjRsn3LwtmUuzs0kTCzf3si6TJ7r7MpHxblSk3v6pztZ2JPezkSI5kB1AT94PlfuPiZi7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10 a=FqpbrowB-PMA:10 a=pGLkceISAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=rN3R6gofztcMVIXaqFUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeC1OGO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 10:06:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:35542 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeC1OGB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 10:06:01 -0400
Date: Wed, 28 Mar 2018 10:06:00 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <777590253.2016.1522245960189.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180328064703.56hsuicmikejg7np@tardis>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180328064703.56hsuicmikejg7np@tardis>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: giprJFg0sw1tC1sJYpw5uUx6Rdd1NA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Mar 28, 2018, at 2:47 AM, Boqun Feng boqun.feng@gmail.com wrote:

> On Tue, Mar 27, 2018 at 12:05:23PM -0400, Mathieu Desnoyers wrote:
> [...]
>> Changes since v11:
>> 
>> - Replace task struct rseq_preempt, rseq_signal, and rseq_migrate
>>   bool by u32 rseq_event_mask.
> [...]
>> @@ -979,6 +980,17 @@ struct task_struct {
>>  	unsigned long			numa_pages_migrated;
>>  #endif /* CONFIG_NUMA_BALANCING */
>>  
>> +#ifdef CONFIG_RSEQ
>> +	struct rseq __user *rseq;
>> +	u32 rseq_len;
>> +	u32 rseq_sig;
>> +	/*
>> +	 * RmW on rseq_event_mask must be performed atomically
>> +	 * with respect to preemption.
>> +	 */
>> +	unsigned long rseq_event_mask;
> 
> s/unsigned long/u32

good point, fixed.

> 
>> +#endif
>> +
>>  	struct tlbflush_unmap_batch	tlb_ubc;
>>  
>>  	struct rcu_head			rcu;
>> @@ -1688,4 +1700,110 @@ extern long sched_getaffinity(pid_t pid, struct cpumask
>> *mask);
>>  #define TASK_SIZE_OF(tsk)	TASK_SIZE
>>  #endif
>>  
> 
> [...]
> 
>> +
>> +static int rseq_ip_fixup(struct pt_regs *regs)
>> +{
>> +	unsigned long ip = instruction_pointer(regs), start_ip = 0,
>> +		post_commit_offset = 0, abort_ip = 0;
>> +	struct task_struct *t = current;
>> +	uint32_t cs_flags = 0;
>> +	bool in_rseq_cs = false;
> 
> This seems unnecessary? Because..
> 
>> +	int ret;
>> +
>> +	ret = rseq_get_rseq_cs(t, &start_ip, &post_commit_offset, &abort_ip,
>> +			&cs_flags);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Handle potentially not being within a critical section.
>> +	 * Unsigned comparison will be true when
>> +	 * ip >= start_ip, and when ip < start_ip + post_commit_offset.
>> +	 */
>> +	if (ip - start_ip < post_commit_offset)
>> +		in_rseq_cs = true;
>> +
>> +	/*
>> +	 * If not nested over a rseq critical section, restart is
>> +	 * useless. Clear the rseq_cs pointer and return.
>> +	 */
>> +	if (!in_rseq_cs)
>> +		return clear_rseq_cs(t);
> 
> we can write
> 
>	if (ip - start_ip >= post_commit_offset)
>		return clear_rseq_cs(t);

Good point. In a previous version, rseq_get_rseq_cs() had to conditionally
update in_rseq_cs, but it's not the case anymore, so your approach
indeed cleans up the code.

Thanks!

Mathieu

> 
> Regards,
> Boqun
> 
>> +	ret = rseq_need_restart(t, cs_flags);
>> +	if (ret <= 0)
>> +		return ret;
>> +	ret = clear_rseq_cs(t);
>> +	if (ret)
>> +		return ret;
>> +	trace_rseq_ip_fixup(ip, start_ip, post_commit_offset, abort_ip);
>> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
>> +	return 0;
>> +}
>> +
> [...]

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
