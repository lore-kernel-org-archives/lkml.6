Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526501612-5-15962643144723786009
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
    1526501612; b=LXJjcqjyD4m2BpO7CQKgTjRPE4BtzELaKr4Nwgvu+pBV1gowXD
    Nn3Txj0XggigY36UGbaqyF12WErwQ2H1vonDjgbPS4FrPKaY+yiwvtOER8qPKQPk
    6IM5XVFlIhmzXxQmTi8wrCEmW+Bw9chg13INvmP50EPLwGezxSqcKeGWeKwzdAF3
    +gmfulH35EXavYcVrvE2kuv0KCWBg3GzKAuY91SK56Bxcp7sO6ddLY9BleEQZdd/
    T8D4T/qY228q4Om7XcmndDtFygrnfr55X+c8XxgrkUo7Ru0LZhZPj7txhd9KHmYx
    JITtFL9Pz1P+J+5ADfgigJdhuq6kZpdOqWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526501612;
    bh=ODraR+EfhfZsCxbA6FxpOIOh7McvXLTrb8L0DW8SnoY=; b=JN3wfCxiRxMI
    RiepmSw2+lZ5/n/Hl2VtF3RzxQpf0f4aatauw+7fhtF/uPUQbyQBxQYZOVseS+Qd
    wtAc77EdoNTU7fY1S46hmSsWXH0bnSP7NhDBuQRTMG6HjEqihJiocuzJf2SYvc7Y
    Dy0tVe3RdK750rLFUS88kGLfP13DN/ZNJGaELV8QONStc1zXwsJRQpLh1o85oWAx
    ugNSRjXSUGP+yYoodzelWD4xaUpQuLg1u5yv4B0UAiJk7xb3Z4Aq7y1Gp4uH28DZ
    /tQ4bz0n0SUuglso5yxGPbmIjcoTo87HphIVXfw+PTKrx5eEkERRE+vePyoZ5v24
    lL5WBaqqvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=jpptCF7n
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
      header.d=efficios.com header.i=@efficios.com header.b=jpptCF7n
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
X-CM-Envelope: MS4wfI54Cu/ivW764TK/O8LG7BpXID39qQqH1vIz7aZ4P0IJVg3ojoMf9bSFPwQ8ulYq1srK+8y9r69QWJI87XiDHHD3tv3Cy8Fwhlis57hk4wBaT5jWaanr
    6Th9jud7X4cp1PCju1TuhhTsz6pN1P/SoPly5mpQ6PNPIZa0ck2en3craJpVu3rPSQaBhJoAm+HaJpB3NuNWUcjfG/HGkXcaeu73Pcjw8lJSzrAsy3gj+dWP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=UlISJEd_NE5-wBVr7UcA:9
    a=P9fjx1FnwWwcalF6:21 a=0NNY3i5wWDI3p9mJ:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeEPUNb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:13:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:60916 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeEPUNR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 16:13:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9B6E41C0560
Date: Wed, 16 May 2018 16:13:16 -0400 (EDT)
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
        Joel Fernandes <joelaf@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180516161837.GI12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-8-mathieu.desnoyers@efficios.com> <20180516161837.GI12198@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: powerpc: Add support for restartable sequences
Thread-Index: PpuTAhPtg5HdKhcrUxmji33zT6zOXw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Apr 30, 2018 at 06:44:26PM -0400, Mathieu Desnoyers wrote:
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index c32a181a7cbb..ed21a777e8c6 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -223,6 +223,7 @@ config PPC
>>  	select HAVE_SYSCALL_TRACEPOINTS
>>  	select HAVE_VIRT_CPU_ACCOUNTING
>>  	select HAVE_IRQ_TIME_ACCOUNTING
>> +	select HAVE_RSEQ
>>  	select IRQ_DOMAIN
>>  	select IRQ_FORCED_THREADING
>>  	select MODULES_USE_ELF_RELA
>> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
>> index 61db86ecd318..d3bb3aaaf5ac 100644
>> --- a/arch/powerpc/kernel/signal.c
>> +++ b/arch/powerpc/kernel/signal.c
>> @@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
>>  	/* Re-enable the breakpoints for the signal stack */
>>  	thread_change_pc(tsk, tsk->thread.regs);
>>  
>> +	rseq_signal_deliver(tsk->thread.regs);
>> +
>>  	if (is32) {
>>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
>> @@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long
>> thread_info_flags)
>>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
>>  		clear_thread_flag(TIF_NOTIFY_RESUME);
>>  		tracehook_notify_resume(regs);
>> +		rseq_handle_notify_resume(regs);
>>  	}
>>  
>>  	user_enter();
> 
> Again no rseq_syscall().

Same question for PowerPC as for ARM:

Considering that rseq_syscall is implemented as follows:

+void rseq_syscall(struct pt_regs *regs)
+{
+       unsigned long ip = instruction_pointer(regs);
+       struct task_struct *t = current;
+       struct rseq_cs rseq_cs;
+
+       if (!t->rseq)
+               return;
+       if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
+           rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+               force_sig(SIGSEGV, t);
+}

and that x86 calls it from syscall_return_slowpath() (which AFAIU is
now used in the fast-path since KPTI), I wonder where we should call
this on PowerPC ?  I was under the impression that PowerPC return to
userspace fast-path was not calling C code unless work flags were set,
but I might be wrong.

Thoughts ?

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
