Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2379892-1522651575-2-4671567124910505883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522651572; b=dVRVQk6uh+4qZBZwZiNFwd0aTXckd4VnAVSR0ykFuaTx3Wa0rR
    8cGanLCEAdAO6e5OWZqKmWG01UpAuGsJmyWOmqDxKY6IlgTk0MU8OB0fyDQfXZiB
    ylT0gZIkpxfUoYO8zPQwh/CSpw94ObLvp/U2B7DDvovVVeWdfcc85kg6ArK8Zti2
    Dm/L17asxhQ6AeIXuQTuENIYlAqHiHIkI6QMFRORaPlVQGxxDKliY7F8XavPl5yV
    X4CdKx8f+nJMM1tmMmHy8BHX8BifbhT0e/BHFwLllGy3npOLRVxdZw2P2cOuMjHP
    Ee1WphmrPimzoATbwtJPlZc/3I3LhGJK773Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522651572;
    bh=VnBEmhIuUb8OhF0uwbpUSFULR74D0R2fz0gEU/HDxno=; b=s6Fas2BmeRXX
    cz6Tco4/34cAADErPpBibhlUMsc1xOdtOGIqoPUESS/WLkVKGodNWB7h5EcDBtYg
    R7yA9Om3oyDs1brxWokalaTSKBmQDA5WX5+s5V9rkRW9esaAoKUEX45dEfhrNYNb
    PsvGXF8814mJvQfP7vLisVUJah3qD7qo5RSkacFKFc0N/kbyANjy3IqTR1srVB8U
    y6UXCiM0S7rCgETdrVT4ihRj0nPKj4ZYQe2Qyzs98BsbGwJn7rxmGB6g+X4bSgc1
    mlhKL4+JUrEs6j01XKku0qNDM0MToaQUEc26ecWUZiGUNjm8WnH5czOWPQsZJ6IW
    +bTyupSPlw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNXgpc3U1e2Z+YzAZVvwsbuW03fQjvh8HlzzOSJ3bcBcbi4NGZu782bSRRBqjlVQv0KkXie6djnoQvC8HVdxchw9fu2Iely50pMRiqqAdh4YCphLpWt4
    xFYN21wTAdty4RXqY1aZ04wSF0Kx9II28ccsAIP0pEyHcjvylyBU7l6JrdFzyoU+Rdmne2RoSvZRCRkR3IL2xAQkXECzOBTi4IakTMJdt5wWafvfIn2LEKK7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1EsaE_6oAAAA:8 a=VwQbUJbxAAAA:8 a=TYBLyS7eAAAA:8 a=VnNF1IyMAAAA:8
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8
    a=oGMlB6cnAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=t2Ia_ipEZdkkbch-dD0A:9 a=DIW7fAdpEb0joNwS:21
    a=YI-EjKx3a70oA8N8:21 a=QEXdDO2ut3YA:10 a=3ZumFrijQQ-2J9H5h8ct:22
    a=AjGcO6oz07-iQ99wixmX:22 a=zvYvwCWiE4KgVXXeO06c:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeDBGqJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 02:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeDBGqI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 02:46:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439B020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 2 Apr 2018 15:45:57 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 076/134] kprobes/x86: Set kprobes pages read-only
Message-Id: <20180402154557.361168f8f4139bbd2689dc99@kernel.org>
In-Reply-To: <1522599630.2654.59.camel@codethink.co.uk>
References: <20180319171849.024066323@linuxfoundation.org>
        <20180319171900.247219741@linuxfoundation.org>
        <1522599630.2654.59.camel@codethink.co.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 01 Apr 2018 17:20:30 +0100
Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:

> On Mon, 2018-03-19 at 19:05 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > 
> > [ Upstream commit d0381c81c2f782fa2131178d11e0cfb23d50d631 ]
> 
> This caused a regression in mainline, fixed by:
> 
> commit c93f5cf571e7795f97d49ef51b766cf25e328545
> Author: Masami Hiramatsu <mhiramat@kernel.org>
> Date:   Thu May 25 19:38:17 2017 +0900
> 
>     kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Thanks Ben,
Greg, could you please pick above patch too?

Thank you,

> 
> Ben.
> 
> > Set the pages which is used for kprobes' singlestep buffer
> > and optprobe's trampoline instruction buffer to readonly.
> > This can prevent unexpected (or unintended) instruction
> > modification.
> > 
> > This also passes rodata_test as below.
> > 
> > Without this patch, rodata_test shows a warning:
> > 
> >   WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:235 note_page+0x7a9/0xa20
> >   x86/mm: Found insecure W+X mapping at address ffffffffa0000000/0xffffffffa0000000
> > 
> > With this fix, no W+X pages are found:
> > 
> >   x86/mm: Checked W+X mappings: passed, no W+X pages found.
> >   rodata_test: all tests were successful
> > 
> > Reported-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> > Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: David S . Miller <davem@davemloft.net>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ye Xiaolong <xiaolong.ye@intel.com>
> > Link: http://lkml.kernel.org/r/149076375592.22469.14174394514338612247.stgit@devbox
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/x86/kernel/kprobes/core.c |    4 ++++
> >  arch/x86/kernel/kprobes/opt.c  |    3 +++
> >  2 files changed, 7 insertions(+)
> > 
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -406,6 +406,8 @@ static int arch_copy_kprobe(struct kprob
> >  {
> >  	int ret;
> >  
> > +	set_memory_rw((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
> > +
> >  	/* Copy an instruction with recovering if other optprobe modifies it.*/
> >  	ret = __copy_instruction(p->ainsn.insn, p->addr);
> >  	if (!ret)
> > @@ -420,6 +422,8 @@ static int arch_copy_kprobe(struct kprob
> >  	else
> >  		p->ainsn.boostable = -1;
> >  
> > +	set_memory_ro((unsigned long)p->ainsn.insn & PAGE_MASK, 1);
> > +
> >  	/* Check whether the instruction modifies Interrupt Flag or not */
> >  	p->ainsn.if_modifier = is_IF_modifier(p->ainsn.insn);
> >  
> > --- a/arch/x86/kernel/kprobes/opt.c
> > +++ b/arch/x86/kernel/kprobes/opt.c
> > @@ -370,6 +370,7 @@ int arch_prepare_optimized_kprobe(struct
> >  	}
> >  
> >  	buf = (u8 *)op->optinsn.insn;
> > +	set_memory_rw((unsigned long)buf & PAGE_MASK, 1);
> >  
> >  	/* Copy instructions into the out-of-line buffer */
> >  	ret = copy_optimized_instructions(buf + TMPL_END_IDX, op->kp.addr);
> > @@ -392,6 +393,8 @@ int arch_prepare_optimized_kprobe(struct
> >  	synthesize_reljump(buf + TMPL_END_IDX + op->optinsn.size,
> >  			   (u8 *)op->kp.addr + op->optinsn.size);
> >  
> > +	set_memory_ro((unsigned long)buf & PAGE_MASK, 1);
> > +
> >  	flush_icache_range((unsigned long) buf,
> >  			   (unsigned long) buf + TMPL_END_IDX +
> >  			   op->optinsn.size + RELATIVEJUMP_SIZE);
> 
> -- 
> Ben Hutchings
> Software Developer, Codethink Ltd.
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
