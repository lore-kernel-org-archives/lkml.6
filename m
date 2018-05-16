Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526501601-5-13596784800232329778
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
    1526501600; b=S2q3puY8Spm5CbDKTMT+CzWmQlcXvLLgVrA2JFECYHoj1MUgIZ
    +Ako+dqnYm3aAm7+LZaSe6JQlKyTcpuqu6k/x1+js938Uc7RBSOLeOJ6WVd61ICp
    OfWEAA+OvEFZbSs3dhznon9PdLvBgHju2X1GYIt3CkU2lFeMRy+RxCYIZHdCOGDv
    pDovWxWEFAvuJcCqvm1x0oEX6/RlTqK0BQje+075dRZZf3tm67V4jTv5gW5C8FdQ
    xeHDaxNKNxGc8xL70+0HwswNiZGoAOSfGPSx0ZnqYyhIek+YYZaWG0MphU3naXYG
    btGW5n0exGqMNOZaEy54rR79qjM3WIYfXM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526501600;
    bh=LUGLyLDrMA20Yegjrg834RnwgploRGWICbOmqVz7IXA=; b=Z6dzws0l5K/q
    QQOnIaoz91Y9HSwGOXWp/3cnzoXwMHOpgaxwxXim+aS0ZdSO+nGu+LMHuRFrnYnN
    65zeDkKEEk/jyQacwq6FIoe2qLL3zejsr18/RwOKdQPlcHWYMU0QXkY5kHD1l3kx
    OyffUDxriebUiXcutpi4LjtOlnrUh9QZdY9b1F9Prn0RR1MSsSNTZurSRc9s7ooC
    VX9URHghxK/G6JiRF7/1f4rfcqPrqKok1f1rJmnjSTNpDP4U932LHrCusxvUVKFi
    tDuESKOyjKJtxioTvhv9EVDfJyS4poHDsYhNwQnYZNXe3S3DzYyIzI1UJEprl4Zu
    eqM8pwHL0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=lhoNwRoT
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=efficios.com header.i=@efficios.com header.b=lhoNwRoT
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
X-CM-Envelope: MS4wfKq21YT2DEqPsZnm5nOD6eJMSgd3TSioBikraPAHjmzsyeVgdOq9Svcf8T1sgAqr0U7sy5I05E4UU04WxqNKTXS30hGQ8nhEU2HSbj2WP2mSZPkoPqpo
    jW6H5//5LSyV9ZfcOY2tJoN1rVJWSAUQ9Cr/2WffaMTXmI2s7BeTmHWgVPK16n7x7pxIReirO8w1NAaPMJKB4uHwdEr04YHOEZpJN3xQ9FRZ2J3Svo8gVZWW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10 a=JfrnYn6hAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=UlISJEd_NE5-wBVr7UcA:9
    a=hrTRQMypYtcHsaX2:21 a=v-_w8YCsWm8L3jkF:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeEPUNR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:13:17 -0400
Received: from mail.efficios.com ([167.114.142.138]:60836 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeEPUNP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 May 2018 16:13:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1AB961C0548
Date: Wed, 16 May 2018 16:13:13 -0400 (EDT)
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
        Joel Fernandes <joelaf@google.com>
Message-ID: <670368504.1912.1526501593893.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180516161809.GH12198@hirez.programming.kicks-ass.net>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180430224433.17407-4-mathieu.desnoyers@efficios.com> <20180516161809.GH12198@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 03/14] arm: Add restartable sequences support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2026 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: Add restartable sequences support
Thread-Index: JwDnrosDtRXGkL2/HdIoZluMjdpT5w==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 16, 2018, at 12:18 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Apr 30, 2018 at 06:44:22PM -0400, Mathieu Desnoyers wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a7f8e7f4b88f..4f5c386631d4 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -91,6 +91,7 @@ config ARM
>>  	select HAVE_PERF_USER_STACK_DUMP
>>  	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
>>  	select HAVE_REGS_AND_STACK_ACCESS_API
>> +	select HAVE_RSEQ
>>  	select HAVE_SYSCALL_TRACEPOINTS
>>  	select HAVE_UID16
>>  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
>> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
>> index bd8810d4acb3..5879ab3f53c1 100644
>> --- a/arch/arm/kernel/signal.c
>> +++ b/arch/arm/kernel/signal.c
>> @@ -541,6 +541,12 @@ static void handle_signal(struct ksignal *ksig, struct
>> pt_regs *regs)
>>  	int ret;
>>  
>>  	/*
>> +	 * Increment event counter and perform fixup for the pre-signal
>> +	 * frame.
>> +	 */
>> +	rseq_signal_deliver(regs);
>> +
>> +	/*
>>  	 * Set up the stack frame
>>  	 */
>>  	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
>> @@ -660,6 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int
>> thread_flags, int syscall)
>>  			} else {
>>  				clear_thread_flag(TIF_NOTIFY_RESUME);
>>  				tracehook_notify_resume(regs);
>> +				rseq_handle_notify_resume(regs);
>>  			}
>>  		}
>>  		local_irq_disable();
> 
> I think you forgot to hook up rseq_syscall() checking.

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
this on ARM ? I was under the impression that ARM return to userspace
fast-path was not calling C code unless work flags were set, but I might
be wrong.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
