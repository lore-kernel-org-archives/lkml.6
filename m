Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-701366-1526299097-2-3958848633367566203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526299097; b=BeOJV5tx8O+rS3eRxtTZdIaIECsmpRbaDyBIQa6AV2Fu8WhEBh
    1O9bdx1ZWvp4MxjmBqZtcVoGSIWWktjPpBZxgAWlHQGiPGOZXrHaRSbSzwpEBVhF
    DLtz9ea62hR4vY3f8aJkSc4DrFYBaSvtPSBtT5AKkx2sN1rmlO6GeUp2XlM1bWoe
    xEoKsjB4c+hVWzY3PbRX+456ZoDZAbZkCWCwzZnmUP5e1GywOExJPMSZrLmdq4QI
    3QWO+OZxISgzJGafCih9CuyCxyxRXIStPUj9eScbMY0Xe/1bMc7xGDUplI9gJIOh
    vDWfKQC4GUwgw2/ZhVPAjyy1vEL4nZjf61tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526299097; bh=rdqIMK0fc0ue3y68Bm9Tu77hBWh8qZ
    FOd9q20oKxFBk=; b=ML7uynVvwKTLYv4YjD4c6YvgGza/jggieYdkq09ci1Jg+v
    4gFAdEF+hFvu3BGAklgJIUHYXTi9fWi8/OEfLYyenRJCnVdWstqeDfsqqZhubYId
    88e0LDuwYVPrDsXq7z3dVtBwwrUSMr72q878djQpT1wej7ZE7p7Zd+QibV9m+ET5
    weKn1MccbdYAgC4DaBESl4MvnHU2TI8W3pQ3kP7ylu5z98FgbZzYmfiOdN6rNuxI
    9fkBCcv6RtvNCo3XXEpvaHai4lMo7AvZQGvggPQCgqWSUuWbBpffYAFL002ypKhn
    ighOfIQ8pkJ1UfRt2J7HYAC2vK1KH8jPTu3G9Y4A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEB+1ntIRLn4OLh7JekUHwhC0vXZUfeTNHP1cXWK7/Wg3jt/7VO1V9iwsCyGcBNEQJt7qdpUarke9GyiZQDyBsk/ew2oTDBTvZbRdReCKWqdNAdSRp6K
    InxQNLby26fhBHNENpQ5b/C85q4FA7EFosI8f82B+eJBabVVvZd9RqiAMRGghePyjJluwmUjjUE4ZRaGFV5ELY02R2rbbkZnKzsLRHtre2uhdLRJfMS86GPn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=HPKU4i4SiSdbk1Wbcb8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeENL6N (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 07:58:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40978 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbeENL6N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 07:58:13 -0400
Date: Mon, 14 May 2018 12:58:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/18] arm64: convert native/compat syscall entry to C
Message-ID: <20180514115805.bdlcxsw6q3xsbjb7@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-11-mark.rutland@arm.com>
 <20180514110729.GF7753@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514110729.GF7753@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 12:07:30PM +0100, Dave Martin wrote:
> On Mon, May 14, 2018 at 10:46:32AM +0100, Mark Rutland wrote:

> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 5df857e32b48..4706f841e758 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -6,7 +6,9 @@
> >  #include <linux/ptrace.h>
> >  
> >  #include <asm/daifflags.h>
> > +#include <asm/fpsimd.h>
> >  #include <asm/thread_info.h>
> > +#include <asm/unistd.h>
> >  
> >  long do_ni_syscall(struct pt_regs *regs);
> >  
> > @@ -41,8 +43,8 @@ static inline bool has_syscall_work(unsigned long flags)
> >  int syscall_trace_enter(struct pt_regs *regs);
> >  void syscall_trace_exit(struct pt_regs *regs);
> >  
> > -asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > -			       syscall_fn_t syscall_table[])
> > +static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > +			   syscall_fn_t syscall_table[])
> >  {
> >  	unsigned long flags = current_thread_info()->flags;
> >  
> > @@ -79,3 +81,37 @@ asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> >  trace_exit:
> >  	syscall_trace_exit(regs);
> >  }
> > +
> > +static inline void sve_user_reset(void)
> 
> Static function with no caller...

Ugh, this was intended to be called below in el0_svc_handler().

> > +{
> > +	if (!system_supports_sve())
> > +		return;
> > +
> > +	/*
> > +	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> > +	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> > +	 * happens if a context switch or kernel_neon_begin() or context
> > +	 * modification (sigreturn, ptrace) intervenes.
> > +	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
> > +	 */
> > +	if (test_and_clear_thread_flag(TIF_SVE))
> > +		sve_user_disable();
> 
> sve_user_disable() is already inline, and incorporates the if()
> internally via sysreg_clear_set().
> 
> So, should this just be
> 
> 	clear_thread_flag(TIF_SVE);
> 	sve_user_disable();

Sure. That does mean we'll unconditionally read cpacr_el1, but I assume
you're happy with that. I'll note the difference in the commit message.

> > +}
> > +
> > +extern syscall_fn_t sys_call_table[];
> > +
> > +asmlinkage void el0_svc_handler(struct pt_regs *regs)
> > +{
> 
> if (system_supports_sve()) ?
> 
> > +	sve_user_disable();
> 
> Or should this be replaced by a call to sve_user_reset()?
> 
> I suspect the latter, since we do want to be clearing TIF_SVE here too.

Yes, this was mean to be sve_user_reset().

Thanks,
Mark.
