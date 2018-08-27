Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88AAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA89208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBeqARXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA89208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeH0Xqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeH0Xqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:46:49 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3417E208EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535399924;
        bh=yfV6MujTmif/z/8GtZtzONwcByqgY7LXbibozEpy4VY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oBeqARXTv1m0aUlxYnB3uYGFTw03zbU5EkFs3wQxnjiHK3Gg0hgK99EnmDFWCvUYu
         7MGejzb0sRjB1c9JTXeF7l6tmmxqzCYUi38Ig9lIAXA78NRm190g4h1gKMFZwO/ojz
         TosZCitV4ahD7IcMkJcy/ucxNy4pGCJZn9tjfCQQ=
Received: by mail-wr1-f42.google.com with SMTP id k5-v6so133209wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:58:44 -0700 (PDT)
X-Gm-Message-State: APzg51A3VyrxHl/QsT/XgYfnPoeRLo4lf1wzdAG94Ju9RyfUeXWlSRTK
        9lg8pkt1SXV/GC2UlDpBMSI7ilzK79eIhQ6CHx2CdQ==
X-Google-Smtp-Source: ANB0VdZ21tccdtyufRUBVkKUlNk7nmyMpp62dgRqh2OEZqPs3d/vLpJUAPWt/gGBbxJHgZDC8paXfQgNCRcF+q2L8/8=
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr9946045wrm.21.1535399922606;
 Mon, 27 Aug 2018 12:58:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 12:58:22 -0700 (PDT)
In-Reply-To: <E5B40DF6-C28A-4EB2-84C3-146BC5B8B312@gmail.com>
References: <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net> <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com> <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org> <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <20180826090958.GT24124@hirez.programming.kicks-ass.net> <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
 <4BF82052-4738-441C-8763-26C85003F2C9@gmail.com> <20180827170511.6bafa15cbc102ae135366e86@kernel.org>
 <01DA0BDD-7504-4209-8A8F-20B27CF6A1C7@gmail.com> <CALCETrWxwpr+Xx0mCK1HUkanmCDOSRbw50VmebgoAgeNaaPAKg@mail.gmail.com>
 <0000D631-FDDF-4273-8F3C-714E6825E59B@gmail.com> <CALCETrUoNdwDuNSHb3haw9-fYk+sNC_M4r+5EMVVzJ8HWeSsOQ@mail.gmail.com>
 <823D916E-4056-4A36-BDD8-0FB682A8DCAE@gmail.com> <E5B40DF6-C28A-4EB2-84C3-146BC5B8B312@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Aug 2018 12:58:22 -0700
X-Gmail-Original-Message-ID: <CALCETrW+nx7kRWov_+hCAxJRUSsUUJuVqvRP7KoVUxvFFTqi5Q@mail.gmail.com>
Message-ID: <CALCETrW+nx7kRWov_+hCAxJRUSsUUJuVqvRP7KoVUxvFFTqi5Q@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:43 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> at 12:10 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>
>> at 11:58 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>
>>> On Mon, Aug 27, 2018 at 11:54 AM, Nadav Amit <nadav.amit@gmail.com> wrote:
>>>>> On Mon, Aug 27, 2018 at 10:34 AM, Nadav Amit <nadav.amit@gmail.com> wrote:
>>>>> What do you all think?
>>>>
>>>> I agree in general. But I think that current->mm would need to be loaded, as
>>>> otherwise I am afraid it would break switch_mm_irqs_off().
>>>
>>> What breaks?
>>
>> Actually nothing. I just saw the IBPB stuff regarding tsk, but it should not
>> matter.
>
> So here is what I got. It certainly needs some cleanup, but it boots.
>
> Let me know how crappy you find it...
>
>
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index bbc796eb0a3b..336779650a41 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -343,4 +343,24 @@ static inline unsigned long __get_current_cr3_fast(void)
>         return cr3;
>  }
>
> +typedef struct {
> +       struct mm_struct *prev;
> +} temporary_mm_state_t;
> +
> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> +{
> +       temporary_mm_state_t state;
> +
> +       lockdep_assert_irqs_disabled();
> +       state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +       switch_mm_irqs_off(NULL, mm, current);
> +       return state;
> +}
> +
> +static inline void unuse_temporary_mm(temporary_mm_state_t prev)
> +{
> +       lockdep_assert_irqs_disabled();
> +       switch_mm_irqs_off(NULL, prev.prev, current);
> +}
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 5715647fc4fe..ef62af9a0ef7 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -976,6 +976,10 @@ static inline void __meminit init_trampoline_default(void)
>         /* Default trampoline pgd value */
>         trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
>  }
> +
> +void __init patching_mm_init(void);
> +#define patching_mm_init patching_mm_init
> +
>  # ifdef CONFIG_RANDOMIZE_MEMORY
>  void __meminit init_trampoline(void);
>  # else
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 054765ab2da2..9f44262abde0 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -116,6 +116,9 @@ extern unsigned int ptrs_per_p4d;
>  #define LDT_PGD_ENTRY          (pgtable_l5_enabled() ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
>  #define LDT_BASE_ADDR          (LDT_PGD_ENTRY << PGDIR_SHIFT)
>
> +#define TEXT_POKE_PGD_ENTRY    -5UL
> +#define TEXT_POKE_ADDR         (TEXT_POKE_PGD_ENTRY << PGDIR_SHIFT)
> +
>  #define __VMALLOC_BASE_L4      0xffffc90000000000UL
>  #define __VMALLOC_BASE_L5      0xffa0000000000000UL
>
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 99fff853c944..840c72ec8c4f 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -505,6 +505,9 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  /* Install a pte for a particular vaddr in kernel space. */
>  void set_pte_vaddr(unsigned long vaddr, pte_t pte);
>
> +struct mm_struct;
> +void set_mm_pte_vaddr(struct mm_struct *mm, unsigned long vaddr, pte_t pte);
> +
>  #ifdef CONFIG_X86_32
>  extern void native_pagetable_init(void);
>  #else
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index 2ecd34e2d46c..cb364ea5b19d 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -38,4 +38,6 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>
> +extern struct mm_struct *patching_mm;
> +
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index a481763a3776..fd8a950b0d62 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -11,6 +11,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/slab.h>
>  #include <linux/kdebug.h>
> +#include <linux/mmu_context.h>
>  #include <asm/text-patching.h>
>  #include <asm/alternative.h>
>  #include <asm/sections.h>
> @@ -701,8 +702,36 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>                 WARN_ON(!PageReserved(pages[0]));
>                 pages[1] = virt_to_page(addr + PAGE_SIZE);
>         }
> -       BUG_ON(!pages[0]);
> +
>         local_irq_save(flags);
> +       BUG_ON(!pages[0]);
> +
> +       /*
> +        * During initial boot, it is hard to initialize patching_mm due to
> +        * dependencies in boot order.
> +        */
> +       if (patching_mm) {
> +               pte_t pte;
> +               temporary_mm_state_t prev;
> +
> +               prev = use_temporary_mm(patching_mm);
> +               pte = mk_pte(pages[0], PAGE_KERNEL);
> +               set_mm_pte_vaddr(patching_mm, TEXT_POKE_ADDR, pte);
> +               pte = mk_pte(pages[1], PAGE_KERNEL);
> +               set_mm_pte_vaddr(patching_mm, TEXT_POKE_ADDR + PAGE_SIZE, pte);
> +
> +               memcpy((void *)(TEXT_POKE_ADDR | ((unsigned long)addr & ~PAGE_MASK)),
> +                      opcode, len);
> +
> +               set_mm_pte_vaddr(patching_mm, TEXT_POKE_ADDR, __pte(0));
> +               set_mm_pte_vaddr(patching_mm, TEXT_POKE_ADDR + PAGE_SIZE, __pte(0));
> +               local_flush_tlb();

Hmm.  This is stuff busted on SMP, and it's IMO more complicated than
needed.  How about getting rid of all the weird TLB flushing stuff and
instead putting the mapping at vaddr - __START_KERNEL_map or whatever
it is?  You *might* need to flush_tlb_mm_range() on module unload, but
that's it.

> +               sync_core();

I can't think of any case where sync_core() is needed.  The mm switch
serializes.

Also, is there any circumstance in which any of this is used before at
least jump table init?  All the early stuff is text_poke_early(),
right?
