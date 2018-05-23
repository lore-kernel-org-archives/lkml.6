Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-685316-1527109043-2-15130447457905770655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527109042; b=mHglztVXfLGP91Orl9mA4ZoRLpFxggfQIZjjZjtRLwy320KPJh
    KHa7ddbyQeGQfCWeNvy3x4ZGsaImpuskHP7bycGqrsvZWsUm/VfGhUpHOWQZ7efu
    LG/tDdFZwc+9iquYNahT01kbyOjCbF09YW+19IEGsc1gxcAATaixhCfvE7ubP6VP
    cUYRbY88SvgwYlMVBKHrGbNu9lFgOhtYob/jflZ9sJ0mRWFzYreHAFPQYLt977uS
    iv6Ib45DYQ0J5JMagrdX4T5A0+qudSswhhanJJbH18/DhQpsQ06MOkzw4S/sG9xI
    s9qOHh1a+PxJRhTD+wbJ68e06a83DJCIetsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527109042; bh=7VYmBk1NWQOzZyd6HAihBmD
    txfclm/SHRBqc401gCQY=; b=cRdjse5eA2l9fs1Z23rqYilITQFeHmT6vplJcWS
    Gt+gx78NJEPYxSWjRddAYh0bqYXX/0N+T3fgq6uly4e/BXZS9V1+iREzP2UAONU6
    fIyS/xy2yPJOHiXLQqIJVS5T2uLONmLT3DdS9HrmKEmt9ivMvy1ixrEgSj8JW2hp
    sjqWn+j5X3U1IMev9xvvm/eMoVlrtur84d0Jy5NLaS/5sZe9fzb+9xfLWsvJcdjc
    Znhec7h3YNOB7kOKYkq4wBT4GbGQB1xwcGAiDiS4UyUkKgSJQk9wUKDbqexupMPa
    tDxUTUS9euXUWRJ5opAcKlALt5PoHc0fViAjHOK1Rrne68g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJA+wfPg+pJzluzEE7ZJtePwJ0eFrbW3eDR6i1ikrAigJOTEqkNqZesrFCLGvZa0Ll8zZQ5OsNDgFgHt8sKS0cBvDTz/k/GP4rAygQ2V4n+6U8BI4+HQ
    hjSUl/KWwaeiNbMiB/SjXpCIGwycPo6TRmW2EiAOrSE9oSVvzgwtpTpgWvlmPGvyL/OHyvQ0RQ8Cm8k8SIU481UCl8Q38t6kzzNx1KqJtzI00G8BynyOVekd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=lTbjQzD5AAAA:8 a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8
    a=KEwWs3Db2y54usqRODwA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=w8YF5asEQ23juLwKoPR8:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934805AbeEWU5S (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 16:57:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934470AbeEWU5O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 16:57:14 -0400
Date: Wed, 23 May 2018 13:46:35 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 07/14] powerpc: Add support for restartable sequences
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <20180516161837.GI12198@hirez.programming.kicks-ass.net>
 <112970629.1913.1526501596485.JavaMail.zimbra@efficios.com>
 <20180517011949.GA1121@tardis>
 <277374719.2144.1526570889798.JavaMail.zimbra@efficios.com>
 <1526601043.1338308.1376191416.0444B8C5@webmail.messagingengine.com>
 <418003803.516.1526667437396.JavaMail.zimbra@efficios.com>
 <20180520140811.GB1121@tardis>
 <1928158599.1541.1527106479862.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1928158599.1541.1527106479862.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052320-0028-0000-0000-000009AD77B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009073; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036651; UDB=6.00530338; IPR=6.00815779;
 MB=3.00021264; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 20:57:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052320-0029-0000-0000-00003AF932C8
Message-Id: <20180523204635.GF3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230204
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 04:14:39PM -0400, Mathieu Desnoyers wrote:
> ----- On May 20, 2018, at 10:08 AM, Boqun Feng boqun.feng@gmail.com wrote:
> 
> > On Fri, May 18, 2018 at 02:17:17PM -0400, Mathieu Desnoyers wrote:
> >> ----- On May 17, 2018, at 7:50 PM, Boqun Feng boqun.feng@gmail.com wrote:
> >> [...]
> >> >> > I think you're right. So we have to introduce callsite to rseq_syscall()
> >> >> > in syscall path, something like:
> >> >> > 
> >> >> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> >> >> > index 51695608c68b..a25734a96640 100644
> >> >> > --- a/arch/powerpc/kernel/entry_64.S
> >> >> > +++ b/arch/powerpc/kernel/entry_64.S
> >> >> > @@ -222,6 +222,9 @@ system_call_exit:
> >> >> > 	mtmsrd	r11,1
> >> >> > #endif /* CONFIG_PPC_BOOK3E */
> >> >> > 
> >> >> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
> >> >> > +	bl	rseq_syscall
> >> >> > +
> >> >> > 	ld	r9,TI_FLAGS(r12)
> >> >> > 	li	r11,-MAX_ERRNO
> >> >> > 	andi.
> >> >> > 		r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> >> >> > 
> >> 
> >> By the way, I think this is not the right spot to call rseq_syscall, because
> >> interrupts are disabled. I think we should move this hunk right after
> >> system_call_exit.
> >> 
> > 
> > Good point.
> > 
> >> Would you like to implement and test an updated patch adding those calls for ppc
> >> 32 and 64 ?
> >> 
> > 
> > I'd like to help, but I don't have a handy ppc environment for test...
> > So I made the below patch which has only been build-tested, hope it
> > could be somewhat helpful.
> 
> Hi Boqun,
> 
> I tried your patch in a ppc64 le environment, and it does not survive boot
> with CONFIG_DEBUG_RSEQ=y. init gets killed right away.
> 
> Moreover, I'm not sure that the r3 register don't contain something worth
> saving before the call on ppc32. Just after there is a "mr" instruction
> which AFAIU takes r3 as input register.
> 
> Can you look into it ?

Hello, Boqun,

You can also request access to a ppc64 environment here:

	http://osuosl.org/services/powerdev/request_hosting/

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > Regards,
> > Boqun
> > 
> > --------------------------------->8
> > Subject: [PATCH] powerpc: Add syscall detection for restartable sequences
> > 
> > Syscalls are not allowed inside restartable sequences, so add a call to
> > rseq_syscall() at the very beginning of system call exiting path for
> > CONFIG_DEBUG_RSEQ=y kernel. This could help us to detect whether there
> > is a syscall issued inside restartable sequences.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > arch/powerpc/kernel/entry_32.S | 5 +++++
> > arch/powerpc/kernel/entry_64.S | 5 +++++
> > 2 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> > index eb8d01bae8c6..2f134eebe7ed 100644
> > --- a/arch/powerpc/kernel/entry_32.S
> > +++ b/arch/powerpc/kernel/entry_32.S
> > @@ -365,6 +365,11 @@ syscall_dotrace_cont:
> > 	blrl			/* Call handler */
> > 	.globl	ret_from_syscall
> > ret_from_syscall:
> > +#ifdef CONFIG_DEBUG_RSEQ
> > +	/* Check whether the syscall is issued inside a restartable sequence */
> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
> > +	bl      rseq_syscall
> > +#endif
> > 	mr	r6,r3
> > 	CURRENT_THREAD_INFO(r12, r1)
> > 	/* disable interrupts so current_thread_info()->flags can't change */
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 2cb5109a7ea3..2e2d59bb45d0 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -204,6 +204,11 @@ system_call:			/* label this so stack traces look sane */
> >  * This is blacklisted from kprobes further below with _ASM_NOKPROBE_SYMBOL().
> >  */
> > system_call_exit:
> > +#ifdef CONFIG_DEBUG_RSEQ
> > +	/* Check whether the syscall is issued inside a restartable sequence */
> > +	addi    r3,r1,STACK_FRAME_OVERHEAD
> > +	bl      rseq_syscall
> > +#endif
> > 	/*
> > 	 * Disable interrupts so current_thread_info()->flags can't change,
> > 	 * and so that we don't get interrupted after loading SRR0/1.
> > --
> > 2.16.2
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

