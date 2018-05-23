Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-639720-1527106486-2-15545397104358143434
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
    1527106485; b=C475rhKkkWqOf6aHkazk7+6wzHoeUrt2KWan/ixAWZNx3cQSdA
    AyEsmoNh5Ee0IS4xv3V28N79Hm81jcC1YXeOe85T6bsyxtKaRkB+1PUhzRyFz5c/
    GLJwuoYG4bnKBz/VwBUDIFfitbLp8XPR5731X1yUmpEagcPmK2EIMGo9lFwN37ws
    olji3zS2PJQtRImNfRybq0ujwj8ydWmsgp5enixhQhJK5EZi/LoCdEHT8bAuBTe5
    Kjx/frLnxSHdfMqY41/Pb4hH0p6NRO65Zo4fz2aW0/aKMGcpepDeyw5JO5jNxfoZ
    pwrIkkOkIPhpaZYyPh9lUV21vNe8mZH7UKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527106485;
    bh=ZaJEh28WrjkJkMdIYdK5WRX/o5LxyNaG1+tsuEsiIsE=; b=OC/5Wo9fC6jM
    itBhR5YwMYX3CauOwBXmNBfll1T/pPnBNkMqQfmPZ+Otoi+bNtM9xxQnjadQ78NG
    IhH+jVCTy9v1rQ2SaVa6RzDxIa3ff+5Tk+vx9SGF+zy6v0CAgJYlZvJZ4i3opyB/
    Tgg218m3/NIaY+ZctiY5xlfJCfU8eYZIB5+fzYtJSEmWzNQd3I2ZZaiaPahyIGLz
    xCs8jHxYuPI33GsHUuiORdSB/VtwlrJz2doE/DqfS8yGIHT6J4AdzAX8h4skEWGc
    3luK2GlioPaEqbcIvhMcU2H1/3FY57ULt6bGmlU9r73UtBJVG0Qm5bSU+nVmz95+
    SV04GAq6oA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=efficios.com header.i=@efficios.com header.b=sqbxYvBZ
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=efficios.com header.i=@efficios.com header.b=sqbxYvBZ
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
X-CM-Envelope: MS4wfEBrDIUwWS32KUbnSgnH8lH7jhfetX8HZ2IcPQmA/K6wPn4DwLYDucgoOK+1IAHkFclLTSbdM/+NKvAUS0xSDk9qPxRs8C/9WKNhoabbSTyT5d/WlWkG
    3emuwXLxRdDgDe6r7S+GdcipI0Os4s31ngSY0LyQiVe2ESnjVhmF7nffyfV1VJwa8cnyDXaSadfeHjczEvyvDGrrPIzKKIiXHTXXHTnijf9erRAf87aAdyMI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=FqpbrowB-PMA:10
    a=pGLkceISAAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=fOFtUMjIH-rXi4gATtEA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934319AbeEWUOm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 16:14:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:40436 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934262AbeEWUOl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 16:14:41 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1FBF9222ED7
Date: Wed, 23 May 2018 16:14:39 -0400 (EDT)
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
Message-ID: <1928158599.1541.1527106479862.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180520140811.GB1121@tardis>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com> <20180516161837.GI12198@hirez.programming.kicks-ass.net> <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com> <20180517011949.GA1121@tardis> <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com> <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com> <418003803.516.1526667437396.JavaMail.zimbra@efficios.com> <20180520140811.GB1121@tardis>
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2075 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2031)
Thread-Topic: powerpc: Add support for restartable sequences
Thread-Index: qqWL7CAG0anHYmSjRuZc1e0kK3FL8w==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On May 20, 2018, at 10:08 AM, Boqun Feng boqun.feng@gmail.com wrote:

> On Fri, May 18, 2018 at 02:17:17PM -0400, Mathieu Desnoyers wrote:
>> ----- On May 17, 2018, at 7:50 PM, Boqun Feng boqun.feng@gmail.com wrote:
>> [...]
>> >> > I think you're right. So we have to introduce callsite to rseq_syscall()
>> >> > in syscall path, something like:
>> >> > 
>> >> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> >> > index 51695608c68b..a25734a96640 100644
>> >> > --- a/arch/powerpc/kernel/entry_64.S
>> >> > +++ b/arch/powerpc/kernel/entry_64.S
>> >> > @@ -222,6 +222,9 @@ system_call_exit:
>> >> > 	mtmsrd	r11,1
>> >> > #endif /* CONFIG_PPC_BOOK3E */
>> >> > 
>> >> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
>> >> > +	bl	rseq_syscall
>> >> > +
>> >> > 	ld	r9,TI_FLAGS(r12)
>> >> > 	li	r11,-MAX_ERRNO
>> >> > 	andi.
>> >> > 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
>> >> > 
>> 
>> By the way, I think this is not the right spot to call rseq_syscall, because
>> interrupts are disabled. I think we should move this hunk right after
>> system_call_exit.
>> 
> 
> Good point.
> 
>> Would you like to implement and test an updated patch adding those calls for ppc
>> 32 and 64 ?
>> 
> 
> I'd like to help, but I don't have a handy ppc environment for test...
> So I made the below patch which has only been build-tested, hope it
> could be somewhat helpful.

Hi Boqun,

I tried your patch in a ppc64 le environment, and it does not survive boot
with CONFIG_DEBUG_RSEQ=y. init gets killed right away.

Moreover, I'm not sure that the r3 register don't contain something worth
saving before the call on ppc32. Just after there is a "mr" instruction
which AFAIU takes r3 as input register.

Can you look into it ?

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
> --------------------------------->8
> Subject: [PATCH] powerpc: Add syscall detection for restartable sequences
> 
> Syscalls are not allowed inside restartable sequences, so add a call to
> rseq_syscall() at the very beginning of system call exiting path for
> CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect whether there
> is a syscall issued inside restartable sequences.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> arch/powerpc/kernel/entry_32.S | 5 +++++
> arch/powerpc/kernel/entry_64.S | 5 +++++
> 2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index eb8d01bae8c6..2f134eebe7ed 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -365,6 +365,11 @@ syscall_dotrace_cont:
> 	blrl			/* Call handler */
> 	.globl	ret_from_syscall
> ret_from_syscall:
> +#ifdef CONFIG_DEBUG_RSEQ
> +	/* Check whether the syscall is issued inside a restartable sequence */
> +	addi    r3,r1,STACK_FRAME_OVERHEAD
> +	bl      rseq_syscall
> +#endif
> 	mr	r6,r3
> 	CURRENT_THREAD_INFO(r12, r1)
> 	/* disable interrupts so current_thread_info()->flags can't change */
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 2cb5109a7ea3..2e2d59bb45d0 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -204,6 +204,11 @@ system_call:			/* label this so stack traces look sane */
>  * This is blacklisted from kprobes further below with _ASM_NOKPROBE_SYMBOL().
>  */
> system_call_exit:
> +#ifdef CONFIG_DEBUG_RSEQ
> +	/* Check whether the syscall is issued inside a restartable sequence */
> +	addi    r3,r1,STACK_FRAME_OVERHEAD
> +	bl      rseq_syscall
> +#endif
> 	/*
> 	 * Disable interrupts so current_thread_info()->flags can't change,
> 	 * and so that we don't get interrupted after loading SRR0/1.
> --
> 2.16.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
