Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E58C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ED82086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ik0HNHBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeLSVNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:13:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37066 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:13:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so8493039pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 13:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gxe5tDmAX5HbXU5DbKPWLD6YT+6MIthlRyYzvWy4fNM=;
        b=Ik0HNHBdiU2cc7061JU6CZnT6oNNvNKBT0WfycjwrIkoCzISPrKY+VQg5lfBU0pSCz
         L+cBuBSEtJ2ERQ0gS2+zEFy3RTyvEo727l44YHj98Z5Ii2DZxvqPh6tH/3slqQrt4vGJ
         HNsFBCJ5FlP5A0HCvzLqQrUImJWc87OmTEuHE6TohqEWpXrW5Ca29f21bfGt8CWE3pgz
         i6CVMXT0O0ZfaJeI94KdTgXdVDCQjmkUQyV7KH3F8mDx3hjRYsnaVejHXup4Bgy/BFKT
         9YdmMEcdPWDRAHRpe3GYdBk3VH1odNSsReq+JffUr7hFQcPAjhlJMiyR8ZjKIZVrl9fP
         I3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gxe5tDmAX5HbXU5DbKPWLD6YT+6MIthlRyYzvWy4fNM=;
        b=BbnxvE4wli0vparHcG1KLCSkhBXe+0BKnXpOL50Hg5DB3tOtxvhzMv/VosLZD/guMO
         oeExGdvjwnMT9qCEqCMJzzhcgOapkBVvUXCJwGWBT5OYMJnbJN2/kxRP0vklX2jjTQUH
         d604UKykOvtnyqF+NFd6c9DZfPp6cN22rEfRSOmzDKJk63mVrtKiioRHFT4EyjcTV0fT
         0ReBG3i6H16v8U0RBnUgbx2EMUZNfWt4K+H5Lw+2zyBHT2VuntyjBqh7cIrleO2ORqg6
         ZFjjJftuTgubVY585NdWegpr+pY/ZgyuhK/tY/75ObBlSLYVvWS0CkPxghe5Y+DRugjG
         Nfcw==
X-Gm-Message-State: AA+aEWaVNZlA1O7XgMVhPd59xtDCzVu5SafBcnkeBWNT2wyo42XFAcpp
        OLrouVOBjUhKmdJCVnRr11jZcw==
X-Google-Smtp-Source: AFSGD/Wbe7fZxlDXVHW+ypzr4AQF7n5oUke4S9y1JkwPfk1/lQbYZdJ/DSTGlUnWdDyAfi58rsmHAw==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr20983812pgb.242.1545253986316;
        Wed, 19 Dec 2018 13:13:06 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id l70sm21142905pgd.20.2018.12.19.13.13.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 13:13:05 -0800 (PST)
Date:   Wed, 19 Dec 2018 13:12:58 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Paul Burton <paul.burton@mips.com>
cc:     Andy Lutomirski <luto@kernel.org>, Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Rich Felker <dalias@libc.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
In-Reply-To: <20181219043155.nkaofln64lbp2gfz@pburton-laptop>
Message-ID: <alpine.LSU.2.11.1812191249560.24428@eggly.anvils>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com> <20181219043155.nkaofln64lbp2gfz@pburton-laptop>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018, Paul Burton wrote:
> On Sat, Dec 15, 2018 at 11:19:37AM -0800, Andy Lutomirski wrote:
> > The really simple but possibly suboptimal fix is to get rid of
> > VM_WRITE and to use get_user_pages(..., FOLL_FORCE) to write to it.
> 
> I actually wound up trying this route because it seemed like it would
> produce a nice small patch that would be simple to backport, and we
> could clean up mainline afterwards.
> 
> Unfortunately though things fail because get_user_pages() returns
> -EFAULT for the delay slot emulation page, due to the !is_cow_mapping()
> check in check_vma_flags(). This was introduced by commit cda540ace6a1
> ("mm: get_user_pages(write,force) refuse to COW in shared areas"). I'm a
> little confused as to its behaviour...
> 
> is_cow_mapping() returns true if the VM_MAYWRITE flag is set and
> VM_SHARED is not set - this suggests a private & potentially-writable
> area, right? That fits in nicely with an area we'd want to COW. Why then
> does check_vma_flags() use the inverse of this to indicate a shared
> area? This fails if we have a private mapping where VM_MAYWRITE is not
> set, but where FOLL_FORCE would otherwise provide a means of writing to
> the memory.
> 
> If I remove this check in check_vma_flags() then I have a nice simple
> patch which seems to work well, leaving the user mapping of the delay
> slot emulation page non-writeable. I'm not sure I'm following the mm
> innards here though - is there something I should change about the delay
> slot page instead? Should I be marking it shared, even though it isn't
> really? Or perhaps I'm misunderstanding what VM_MAYWRITE does & I should
> set that - would that allow a user to use mprotect() to make the region
> writeable..?

Exactly, in that last sentence above you come to the right understanding
of VM_MAYWRITE: it allows mprotect to add VM_WRITE whenever.  So I think
your issue in setting up the mmap, is that you're (rightly) doing it with
VM_flags to mmap_region(), but giving it a combination of flags that an
mmap() syscall from userspace would never arrive at, so does not match
expectations in is_cow_mapping().  Look for VM_MAYWRITE in mm/mmap.c:
you'll find do_mmap() first adding VM_MAYWRITE unconditionally, then
removing it just from the case of a MAP_SHARED without FMODE_WRITE.

> 
> The work-in-progress patch can be seen below if it's helpful (and yes, I
> realise that the modified condition in check_vma_flags() became
> impossible & that removing it would be equivalent).
> 
> Or perhaps this is only confusing because it's 4:25am & I'm massively
> jetlagged... :)
> 
> > A possibly nicer way to accomplish more or less the same thing would
> > be to allocate the area with _install_special_mapping() and arrange to
> > keep a reference to the struct page around.
> 
> I looked at this, but it ends up being a much bigger patch. Perhaps it
> could be something to look into as a follow-on cleanup, though it
> complicates things a little because we need to actually allocate the
> page, preferrably only on demand, which is handled for us with the
> current mmap_region() code.
> 
> Thanks,
>     Paul
> 
> ---
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 48a9c6b90e07..9476efb54d18 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -126,8 +126,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  
>  	/* Map delay slot emulation page */
>  	base = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
> -			   VM_READ|VM_WRITE|VM_EXEC|
> -			   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +			   VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYEXEC,

So, remove the VM_WRITE by all means, but leave in the VM_MAYWRITE.

>  			   0, NULL);
>  	if (IS_ERR_VALUE(base)) {
>  		ret = base;
> diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
> index 5450f4d1c920..3aa8e3b90efb 100644
> --- a/arch/mips/math-emu/dsemul.c
> +++ b/arch/mips/math-emu/dsemul.c
> @@ -67,11 +67,6 @@ struct emuframe {
>  
>  static const int emupage_frame_count = PAGE_SIZE / sizeof(struct emuframe);
>  
> -static inline __user struct emuframe *dsemul_page(void)
> -{
> -	return (__user struct emuframe *)STACK_TOP;
> -}
> -
>  static int alloc_emuframe(void)
>  {
>  	mm_context_t *mm_ctx = &current->mm->context;
> @@ -139,7 +134,7 @@ static void free_emuframe(int idx, struct mm_struct *mm)
>  
>  static bool within_emuframe(struct pt_regs *regs)
>  {
> -	unsigned long base = (unsigned long)dsemul_page();
> +	unsigned long base = STACK_TOP;
>  
>  	if (regs->cp0_epc < base)
>  		return false;
> @@ -172,8 +167,8 @@ bool dsemul_thread_cleanup(struct task_struct *tsk)
>  
>  bool dsemul_thread_rollback(struct pt_regs *regs)
>  {
> -	struct emuframe __user *fr;
> -	int fr_idx;
> +	struct emuframe fr;
> +	int fr_idx, ret;
>  
>  	/* Do nothing if we're not executing from a frame */
>  	if (!within_emuframe(regs))
> @@ -183,7 +178,12 @@ bool dsemul_thread_rollback(struct pt_regs *regs)
>  	fr_idx = atomic_read(&current->thread.bd_emu_frame);
>  	if (fr_idx == BD_EMUFRAME_NONE)
>  		return false;
> -	fr = &dsemul_page()[fr_idx];
> +
> +	ret = access_process_vm(current,
> +				STACK_TOP + (fr_idx * sizeof(fr)),
> +				&fr, sizeof(fr), FOLL_FORCE);
> +	if (WARN_ON(ret != sizeof(fr)))
> +		return false;
>  
>  	/*
>  	 * If the PC is at the emul instruction, roll back to the branch. If
> @@ -192,9 +192,9 @@ bool dsemul_thread_rollback(struct pt_regs *regs)
>  	 * then something is amiss & the user has branched into some other area
>  	 * of the emupage - we'll free the allocated frame anyway.
>  	 */
> -	if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr->emul)
> +	if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr.emul)
>  		regs->cp0_epc = current->thread.bd_emu_branch_pc;
> -	else if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr->badinst)
> +	else if (msk_isa16_mode(regs->cp0_epc) == (unsigned long)&fr.badinst)
>  		regs->cp0_epc = current->thread.bd_emu_cont_pc;
>  
>  	atomic_set(&current->thread.bd_emu_frame, BD_EMUFRAME_NONE);
> @@ -214,8 +214,8 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
>  {
>  	int isa16 = get_isa16_mode(regs->cp0_epc);
>  	mips_instruction break_math;
> -	struct emuframe __user *fr;
> -	int err, fr_idx;
> +	struct emuframe fr;
> +	int fr_idx, ret;
>  
>  	/* NOP is easy */
>  	if (ir == 0)
> @@ -250,27 +250,31 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
>  		fr_idx = alloc_emuframe();
>  	if (fr_idx == BD_EMUFRAME_NONE)
>  		return SIGBUS;
> -	fr = &dsemul_page()[fr_idx];
>  
>  	/* Retrieve the appropriately encoded break instruction */
>  	break_math = BREAK_MATH(isa16);
>  
>  	/* Write the instructions to the frame */
>  	if (isa16) {
> -		err = __put_user(ir >> 16,
> -				 (u16 __user *)(&fr->emul));
> -		err |= __put_user(ir & 0xffff,
> -				  (u16 __user *)((long)(&fr->emul) + 2));
> -		err |= __put_user(break_math >> 16,
> -				  (u16 __user *)(&fr->badinst));
> -		err |= __put_user(break_math & 0xffff,
> -				  (u16 __user *)((long)(&fr->badinst) + 2));
> +		union mips_instruction _emul = {
> +			.halfword = { ir >> 16, ir }
> +		};
> +		union mips_instruction _badinst = {
> +			.halfword = { break_math >> 16, break_math }
> +		};
> +
> +		fr.emul = _emul.word;
> +		fr.badinst = _badinst.word;
>  	} else {
> -		err = __put_user(ir, &fr->emul);
> -		err |= __put_user(break_math, &fr->badinst);
> +		fr.emul = ir;
> +		fr.badinst = break_math;
>  	}
>  
> -	if (unlikely(err)) {
> +	/* Write the frame to user memory */
> +	ret = access_process_vm(current,
> +				STACK_TOP + (fr_idx * sizeof(fr)),
> +				&fr, sizeof(fr), FOLL_FORCE | FOLL_WRITE);
> +	if (WARN_ON(ret != sizeof(fr))) {
>  		MIPS_FPU_EMU_INC_STATS(errors);
>  		free_emuframe(fr_idx, current->mm);
>  		return SIGBUS;
> @@ -282,10 +286,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
>  	atomic_set(&current->thread.bd_emu_frame, fr_idx);
>  
>  	/* Change user register context to execute the frame */
> -	regs->cp0_epc = (unsigned long)&fr->emul | isa16;
> -
> -	/* Ensure the icache observes our newly written frame */
> -	flush_cache_sigtramp((unsigned long)&fr->emul);
> +	regs->cp0_epc = (unsigned long)&fr.emul | isa16;
>  
>  	return 0;
>  }
> diff --git a/mm/gup.c b/mm/gup.c
> index f76e77a2d34b..9a1bc941dcb9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -587,7 +587,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  			 * Anon pages in shared mappings are surprising: now
>  			 * just reject it.
>  			 */
> -			if (!is_cow_mapping(vm_flags))
> +			if ((vm_flags & VM_SHARED) && !is_cow_mapping(vm_flags))

Then please drop this patch to mm/gup.c: does the result then work
for you?  (I won't pretend to have reviewed the rest of the patch.)

Hugh

>  				return -EFAULT;
>  		}
>  	} else if (!(vm_flags & VM_READ)) {
