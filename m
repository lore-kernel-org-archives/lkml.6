Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83112C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FAC217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LaX7zbR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfBFVXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:23:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46439 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:23:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so7172339edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFEIBubFtM9Rt2PFGbyxo47yogIA7OLrfIEavljBuKY=;
        b=LaX7zbR/uy3XUDTO61apcwTZae5KQvy+yx+DUb9gFImdMCw6Az6e3NJMs6ZtFOc0Uh
         KxXsAl+3jVzw5oJT6YPqgcyqVtUW3fSZu6h53bzrDpD13oE+C6wv2mfMAZLLbJChsoFi
         ngIS7IEh8stu+arNf2e9FpWRE9OJ7L6MidhDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFEIBubFtM9Rt2PFGbyxo47yogIA7OLrfIEavljBuKY=;
        b=fqJ7PfYk8zbF3zGKe3Sezb0ywv7LxMWpbvN1wVsgMY4HgiqZeBLIoskEQK4tjrxWBi
         P5MJB/waNBY+1epfSmTDt5fGXY+dYua80FTb5T70hBPpEUF9L4yYxKK0zUTv9BUPo6tK
         AXts1RgDnLWIh8QYhfi1JXDYdMVi9pu74mC/QOkpUjs3hNAIBEKVV59ykFJTp9CWCJ5F
         /jrdLMierENFkyKqXOib3jiY6YU+H4/ET6+HwINknogneQE/92a3Kb8XuVWk5maNVtJ3
         E1RMsyPreeVus9plrAvc5jSOwYXSeLCXGkbu0gyuKQbsl5y2T2uIB5RSQj5K3D7yYEql
         MLVw==
X-Gm-Message-State: AHQUAuYaDUr7Ls2EgULj/Q5O2kr1MzxK0Y8TuR4wLidV/YY7JE31m59S
        wt5vkrj1f31WY1CxbJsDgPYUuUJd7/E=
X-Google-Smtp-Source: AHgI3IaUiJmY/VeceSaUEXU3/9Ksp4BzD5+syq7WmY5lKu1UlC1LeLJYj8T+bdPjKgF13E0Fmk1iQg==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr9430839edr.256.1549488224718;
        Wed, 06 Feb 2019 13:23:44 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id i8sm1477401edg.21.2019.02.06.13.23.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 13:23:44 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id z5so4020749wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:23:43 -0800 (PST)
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr4578711wmn.108.1549488223205;
 Wed, 06 Feb 2019 13:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-20-thgarnie@chromium.org>
 <20190206195642.GD9575@linux.intel.com>
In-Reply-To: <20190206195642.GD9575@linux.intel.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Wed, 6 Feb 2019 13:23:31 -0800
X-Gmail-Original-Message-ID: <CAJcbSZGhPej6=jroABPtR00Z46LY-vd-dmiw71Sx3Dj8UxmD+g@mail.gmail.com>
Message-ID: <CAJcbSZGhPej6=jroABPtR00Z46LY-vd-dmiw71Sx3Dj8UxmD+g@mail.gmail.com>
Subject: Re: [PATCH v6 19/27] kvm: Adapt assembly for PIE support
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 11:56 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:26AM -0800, Thomas Garnier wrote:
> > Change the assembly code to use only relative references of symbols for the
> > kernel to be PIE compatible. The new __ASM_MOVABS macro is used to
> > get the address of a symbol on both 32 and 64-bit with PIE support.
> >
> > Position Independent Executable (PIE) support will allow to extend the
> > KASLR randomization range below 0xffffffff80000000.
> >
> > Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 8 ++++++--
> >  arch/x86/kernel/kvm.c           | 6 ++++--
> >  arch/x86/kvm/svm.c              | 4 ++--
> >  arch/x86/kvm/vmx/vmx.c          | 2 +-
> >  4 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 4660ce90de7f..fdb3307d5fe1 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1498,9 +1498,13 @@ asmlinkage void kvm_spurious_fault(void);
> >       ".pushsection .fixup, \"ax\" \n" \
> >       "667: \n\t" \
> >       cleanup_insn "\n\t"                   \
> > -     "cmpb $0, kvm_rebooting \n\t"         \
> > +     "cmpb $0, kvm_rebooting" __ASM_SEL(, (%%rip)) " \n\t" \
> >       "jne 668b \n\t"                       \
> > -     __ASM_SIZE(push) " $666b \n\t"        \
> > +     __ASM_SIZE(push) "$0 \n\t"              \
> > +     __ASM_SIZE(push) "%%" _ASM_AX " \n\t"           \
> > +     _ASM_MOVABS " $666b, %%" _ASM_AX "\n\t" \
> > +     _ASM_MOV " %%" _ASM_AX ", " __ASM_SEL(4, 8) "(%%" _ASM_SP ") \n\t" \
> > +     __ASM_SIZE(pop) "%%" _ASM_AX " \n\t"            \
>
> This blob isn't very intuitive to begin with, and the extra stack
> shenanigans are a bit much when PIE is disabled.  What about breaking
> out the behavior to separate helper macros to keep the simpler code
> for non-PIE and to make the code somewhat self-documenting?  E.g.:
>
> #ifndef CONFIG_X86_PIE
> #define KVM_PUSH_FAULTING_INSN_RIP       __ASM_SIZE(push) " $666b \n\t"
> #else
> #define KVM_PUSH_FAULTING_INSN_RIP                                         \
>         __ASM_SIZE(push) "$0 \n\t"                                         \
>         __ASM_SIZE(push) "%%" _ASM_AX " \n\t"                              \
>         _ASM_MOVABS " $666b, %%" _ASM_AX "\n\t"                            \
>         _ASM_MOV " %%" _ASM_AX ", " __ASM_SEL(4, 8) "(%%" _ASM_SP ") \n\t" \
>         __ASM_SIZE(pop) "%%" _ASM_AX " \n\t"
> #endif
>
> #define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)      \
>         "666: " insn "\n\t" \
>         "668: \n\t"                           \
>         ".pushsection .fixup, \"ax\" \n" \
>         "667: \n\t" \
>         cleanup_insn "\n\t"                   \
>         "cmpb $0, kvm_rebooting" __ASM_SEL(, (%%rip)) " \n\t" \
>         "jne 668b \n\t"                       \
>         KVM_PUSH_FAULTING_INSN_RIP              \
>         "jmp kvm_spurious_fault \n\t"         \
>         ".popsection \n\t" \
>         _ASM_EXTABLE(666b, 667b)
>
> >       "jmp kvm_spurious_fault \n\t"         \
> >       ".popsection \n\t" \
> >       _ASM_EXTABLE(666b, 667b)
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 5c93a65ee1e5..f6eb02004e43 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
>
> This change to arch/x86/kernel/kvm.c should be done in a separate patch
> as it affects the kernel itself when running as a guest under KVM,
> whereas arch/x86/kvm/**/* and arch/x86/include/asm/kvm_host.h affect
> KVM as a host, i.e. the KVM module.  Case in point, the below bug causes
> a kernel panic when running as a KVM guest but has no impact on the KVM
> module.

Got it, will split in next iteration.

>
> > @@ -826,8 +826,10 @@ asm(
> >  ".global __raw_callee_save___kvm_vcpu_is_preempted;"
> >  ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
> >  "__raw_callee_save___kvm_vcpu_is_preempted:"
> > -"movq        __per_cpu_offset(,%rdi,8), %rax;"
> > -"cmpb        $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
> > +"leaq        __per_cpu_offset(%rip), %rax;"
> > +"movq        (%rax,%rdi,8), %rax;"
> > +"addq        " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rax;"
>
> This is wrong, it's directly accessing the per-cpu offset of 'steal_time'
> as a virtual address, e.g. without PIE enabled:
>
>     0xffffffff8104820b <+11>:    add    0x7efccffe(%rip),%rax        # 0x15210 <steal_time+16>
>
> This results in kernel panics due to unhandled page faults:
>
>     [    0.001453] BUG: unable to handle kernel paging request at 0000000000015210
>     [    0.001453] #PF error: [normal kernel read fault]

Yes, I think something went wrong in rebasing. Thanks for pointing it out.

>
> I think you want something like the following, except that the whole
> point of handcoded assembly is to avoid modifying registers other than
> RAX, i.e. modifying RDI is a no-no.
>
>     "leaq   " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rip), %rdi;"
>     "cmpb   $0, (%rax,%rdi,1);"
>
>
> And similar to the comment on ____kvm_handle_fault_on_reboot(), what
> about wrapping the PIE-specific version in an ifdef?

I will look into this and try your approach.

>
> > +"cmpb        $0, (%rax);"
> >  "setne       %al;"
> >  "ret;"
> >  ".popsection");
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index f13a3a24d360..26abb82b1b67 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -706,12 +706,12 @@ static u32 svm_msrpm_offset(u32 msr)
> >
> >  static inline void clgi(void)
> >  {
> > -     asm volatile (__ex("clgi"));
> > +     asm volatile (__ex("clgi") : :);
> >  }
> >
> >  static inline void stgi(void)
> >  {
> > -     asm volatile (__ex("stgi"));
> > +     asm volatile (__ex("stgi") : :);
> >  }
> >
> >  static inline void invlpga(unsigned long addr, u32 asid)
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 4341175339f3..3275761a7375 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -2161,7 +2161,7 @@ static void vmclear_local_loaded_vmcss(void)
> >   */
> >  static void kvm_cpu_vmxoff(void)
> >  {
> > -     asm volatile (__ex("vmxoff"));
> > +     asm volatile (__ex("vmxoff") :::);
> >
> >       intel_pt_handle_vmx(0);
> >       cr4_clear_bits(X86_CR4_VMXE);
> > --
> > 2.20.1.495.gaa96b0ce6b-goog
> >

Thanks for the feedback.
