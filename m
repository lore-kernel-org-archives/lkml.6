Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B6821531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQYM7Tgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B6821531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeHTKKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:10:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51252 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeHTKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:10:19 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so19223556itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 23:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wNBiPGyL/XnTh4OSVfFE68FB6NUfgjH2ICrY3jbXRCE=;
        b=eQYM7Tgjr4wuclczpCFU+VHukgxoN4rrTCnMApUBG+tpLMDkgOMrhMNfym/7t2VOny
         mc+6EmGk7VDq7Iz5pi+Zr5R/Ie9C8vKPoceYsFOuxJmsDJiSLhj7zSP8oFnEd68X1ozX
         UMvO+n2TXri+ehNGbtMjrLNuIEZqqNbSA03wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wNBiPGyL/XnTh4OSVfFE68FB6NUfgjH2ICrY3jbXRCE=;
        b=WiIeH/RMTcqqk3+0wHRGOAqDyMQ9n+gwjBvODOhKr+KckIzdsUg7UWauDSNqwOBa9Q
         UPlRPIavu186oU1LPIVzhU8puwnRrHntLMcPaJXlJsSDYhJslO4Y0LOya6TDPBuhTBRm
         P+Nc38YtkK6wi/zuWJrkeyLIXQg+TqlHaonmkoQgtN3WDTn0BYiey0XnGLv1WM774hVk
         3cpj+ttBfGDZauX7QymHZJUhLgn7bwBosQvLzOuVuPIWQCSZMk6gmv/Cmtjaih9CIq5i
         3paq222lokfZke01IWG3kRmE9rI06UrcUH3hhpYa5k/O0IOF5OBB9/oiQE5MkK7GsqrP
         E9Dg==
X-Gm-Message-State: AOUpUlE6P68gbiGuvfBjX9dh8nLWqCwFaG8/Eznl9iCyXnp3YvRBeMyo
        Xa+dKuRYu0eiyaGPSuRy3sFNBlTrjKj1NMfdf/Zm0w==
X-Google-Smtp-Source: AA+uWPyarV+u75UcHm2kxbdbYxVEKO6YBy2sX4KxA8NgmjrTZVoj2keroaMXjfe81fWGjZyQpvcbD1tOPsgw/ceEN1w=
X-Received: by 2002:a24:9686:: with SMTP id z128-v6mr11608865itd.58.1534748154339;
 Sun, 19 Aug 2018 23:55:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 23:55:53
 -0700 (PDT)
In-Reply-To: <20180817102724.022FB68EF4@newverein.lst.de>
References: <20180817102544.C628D68EF4@newverein.lst.de> <20180817102724.022FB68EF4@newverein.lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 20 Aug 2018 08:55:53 +0200
Message-ID: <CAKv+Gu8kBak__5RYhJ-Y-gdYMxN8RQ09tjFW0KPJ3g=WwRCFtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 August 2018 at 12:27, Torsten Duwe <duwe@lst.de> wrote:
> Check for compiler support of -fpatchable-function-entry and use it
> to intercept functions immediately on entry, saving the LR in x9.

Could you please add a note that this is safe because IPA register
allocation is turned off as well by that option? I had to go and find
the GCC patches to confirm that this is the case.

> Disable ftracing in efi/libstub, because this triggers cross-section
> linker errors now (-pg is disabled already for those files).
> Add an ftrace_caller which can handle LR in x9, as well as an
> ftrace_regs_caller that additionally writes out a set of pt_regs
> for inspection.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -110,6 +110,7 @@ config ARM64
>         select HAVE_DEBUG_KMEMLEAK
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
> +       select HAVE_DYNAMIC_FTRACE_WITH_REGS
>         select HAVE_EFFICIENT_UNALIGNED_ACCESS
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_FUNCTION_TRACER
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -78,6 +78,15 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
>  KBUILD_LDFLAGS_MODULE  += -T $(srctree)/arch/arm64/kernel/module.lds
>  endif
>
> +ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +  ifeq ($(call cc-option,-fpatchable-function-entry=2),)
> +    $(error Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
> +             -fpatchable-function-entry not supported by compiler)
> +  endif
> +endif
> +
>  # Default value
>  head-y         := arch/arm64/kernel/head.o
>
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -16,6 +16,13 @@
>  #define MCOUNT_ADDR            ((unsigned long)_mcount)
>  #define MCOUNT_INSN_SIZE       AARCH64_INSN_SIZE
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> +#define REC_IP_BRANCH_OFFSET 4
> +#else
> +#define REC_IP_BRANCH_OFFSET 0
> +#endif
> +
>  #ifndef __ASSEMBLY__
>  #include <linux/compat.h>
>
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds    := -DTEXT_OFFSET=$(
>  AFLAGS_head.o          := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_armv8_deprecated.o := -I$(src)
>
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_insn.o = -pg
> -CFLAGS_REMOVE_return_address.o = -pg
> +CFLAGS_REMOVE_ftrace.o = -pg $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_insn.o = -pg $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o = -pg $(CC_FLAGS_FTRACE)
>
>  # Object file lists.
>  arm64-obj-y            := debug-monitors.o entry.o irq.o fpsimd.o              \
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -11,7 +11,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__K
>                                    -fPIC -fno-strict-aliasing -mno-red-zone \
>                                    -mno-mmx -mno-sse -fshort-wchar
>
> -cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
> +cflags-$(CONFIG_ARM64)         := $(filter-out -pg $(CC_FLAGS_FTRACE)\
> +                                 ,$(KBUILD_CFLAGS)) -fpie
>  cflags-$(CONFIG_ARM)           := $(subst -pg,,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic -mno-single-pic-base
>
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -13,6 +13,8 @@
>  #include <asm/assembler.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
>
>  /*
>   * Gcc with -pg will put the following code in the beginning of each function:
> @@ -123,6 +125,7 @@ skip_ftrace_call:                   // }
>  ENDPROC(_mcount)
>
>  #else /* CONFIG_DYNAMIC_FTRACE */
> +#ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
>  /*
>   * _mcount() is used to build the kernel with -pg option, but all the branch
>   * instructions to _mcount() are replaced to NOP initially at kernel start up,
> @@ -162,6 +165,88 @@ ftrace_graph_call:                 // ftrace_graph_cal
>
>         mcount_exit
>  ENDPROC(ftrace_caller)
> +#else /* CC_USING_PATCHABLE_FUNCTION_ENTRY */
> +ENTRY(_mcount)
> +       mov     x10, lr
> +       mov     lr, x9
> +       ret     x10
> +ENDPROC(_mcount)
> +
> +ENTRY(ftrace_regs_caller)
> +       stp     x29, x9, [sp, #-16]!
> +       sub     sp, sp, #S_FRAME_SIZE
> +
> +       stp     x10, x11, [sp, #80]
> +       stp     x12, x13, [sp, #96]
> +       stp     x14, x15, [sp, #112]
> +       stp     x16, x17, [sp, #128]
> +       stp     x18, x19, [sp, #144]
> +       stp     x20, x21, [sp, #160]
> +       stp     x22, x23, [sp, #176]
> +       stp     x24, x25, [sp, #192]
> +       stp     x26, x27, [sp, #208]
> +

Any reason in particular this stack frame is the wrong way around? We
usually keep the frame pointer at the top.

> +       b       ftrace_common
> +ENDPROC(ftrace_regs_caller)
> +
> +ENTRY(ftrace_caller)
> +       stp     x29, x9, [sp, #-16]!
> +       sub     sp, sp, #S_FRAME_SIZE
> +
> +ftrace_common:
> +       stp     x28, x29, [sp, #224]
> +
> +       /* save function arguments */
> +       stp     x0, x1, [sp]
> +       stp     x2, x3, [sp, #16]
> +       stp     x4, x5, [sp, #32]
> +       stp     x6, x7, [sp, #48]
> +       stp     x8, x9, [sp, #64]
> +
> +       /* The link Register at callee entry */
> +       str     x9, [sp, #S_LR]
> +       /* The program counter just after the ftrace call site */
> +       str     lr, [sp, #S_PC]
> +       /* The stack pointer as it was on ftrace_caller entry... */
> +       add     x29, sp, #S_FRAME_SIZE+16       /* ...is also our new FP */
> +       str     x29, [sp, #S_SP]
> +
> +       adrp    x0, function_trace_op
> +       ldr     x2, [x0, #:lo12:function_trace_op]

Please use the ldr_l macro here

> +       mov     x1, x9          /* saved LR == parent IP */
> +       sub     x0, lr, #8      /* function entry == IP */
> +       mov     x3, sp          /* pt_regs are @sp */
> +
> +       .global ftrace_call
> +ftrace_call:
> +
> +       bl      ftrace_stub
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +       .global ftrace_graph_call
> +ftrace_graph_call:                     // ftrace_graph_caller();
> +       nop                             // If enabled, this will be replaced
> +                                       // "b ftrace_graph_caller"
> +#endif
> +
> +ftrace_common_return:
> +       ldp     x0, x1, [sp]
> +       ldp     x2, x3, [sp, #16]
> +       ldp     x4, x5, [sp, #32]
> +       ldp     x6, x7, [sp, #48]
> +       ldp     x8, x9, [sp, #64]
> +
> +       ldp     x28, x29, [sp, #224]
> +
> +       ldr     x9, [sp, #S_PC]
> +       ldr     lr, [sp, #S_LR]
> +       add     sp, sp, #S_FRAME_SIZE+16
> +
> +       ret     x9
> +
> +ENDPROC(ftrace_caller)
> +
> +#endif /* CC_USING_PATCHABLE_FUNCTION_ENTRY */
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>
>  ENTRY(ftrace_stub)
> @@ -197,12 +284,20 @@ ENDPROC(ftrace_stub)
>   * and run return_to_handler() later on its exit.
>   */
>  ENTRY(ftrace_graph_caller)
> +#ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
>         mcount_get_lr_addr        x0    //     pointer to function's saved lr
>         mcount_get_pc             x1    //     function's pc
>         mcount_get_parent_fp      x2    //     parent's fp
>         bl      prepare_ftrace_return   // prepare_ftrace_return(&lr, pc, fp)
>
>         mcount_exit
> +#else
> +       add     x0, sp, #S_LR   /* address of (LR pointing into caller) */
> +       ldr     x1, [sp, #S_PC]
> +       ldr     x2, [sp, #S_X28 + 8]    /* caller's frame pointer */
> +       bl      prepare_ftrace_return
> +       b       ftrace_common_return
> +#endif
>  ENDPROC(ftrace_graph_caller)
>
>  /*
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -70,7 +70,8 @@ int ftrace_update_ftrace_func(ftrace_fun
>   */
>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
> -       unsigned long pc = rec->ip;
> +       unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;

We usually put spaces around arithmetic operators.

> +       int ret;
>         u32 old, new;
>         long offset = (long)pc - (long)addr;
>
> @@ -128,22 +129,54 @@ int ftrace_make_call(struct dyn_ftrace *
>         }
>
>         old = aarch64_insn_gen_nop();
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

Please use IS_ENABLED() so that the code below is visible to the
compiler regardless of whether it is actually enabled.

> +#define INSN_MOV_X9_X30 aarch64_insn_gen_add_sub_imm(AARCH64_INSN_REG_9, \
> +               AARCH64_INSN_REG_30, 0, \
> +               AARCH64_INSN_VARIANT_64BIT, AARCH64_INSN_ADSB_ADD)

Please don't define the macro inline like that, and in fact, I think
you can drop it altogether and add a comment instead to clarify that
add x9, x30, #0 == mov x9, x30

> +       new = INSN_MOV_X9_X30;
> +       ret = ftrace_modify_code(pc-REC_IP_BRANCH_OFFSET, old, new, true);
> +       if (ret)
> +               return ret;
> +       smp_wmb();      /* ensure LR saver is in place before ftrace call */
> +#endif
>         new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
>
>         return ftrace_modify_code(pc, old, new, true);
>  }
>
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +                       unsigned long addr)
> +{
> +       unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
> +       u32 old, new;
> +
> +       old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> +       new = aarch64_insn_gen_branch_imm(pc, addr, true);
> +
> +       return ftrace_modify_code(pc, old, new, true);
> +}
> +
> +
>  /*
>   * Turn off the call to ftrace_caller() in instrumented function
>   */
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>                     unsigned long addr)
>  {
> -       unsigned long pc = rec->ip;
> +       unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
>         bool validate = true;
> +       int ret;
>         u32 old = 0, new;
>         long offset = (long)pc - (long)addr;
>
> +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY

Use IS_ENABLED()

> +       /* -fpatchable-function-entry= does not generate a profiling call
> +        *  initially; the NOPs are already there.
> +        */
> +       if (addr == MCOUNT_ADDR)
> +               return 0;
> +#endif
> +
>         if (offset < -SZ_128M || offset >= SZ_128M) {
>  #ifdef CONFIG_ARM64_MODULE_PLTS

No changes needed at all for modules that are more than 128 MB away
from the core kernel? That seems odd to me, given that we currently
have a single PLT entry per module, and so you cannot mix ordinary
ftrace and ftrace with regs in a single module. Or is that not a
problem?

>                 u32 replaced;
> @@ -188,7 +221,15 @@ int ftrace_make_nop(struct module *mod,
>
>         new = aarch64_insn_gen_nop();
>
> -       return ftrace_modify_code(pc, old, new, validate);
> +       ret = ftrace_modify_code(pc, old, new, validate);
> +       if (ret)
> +               return ret;
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

Use IS_ENABLED()

> +       smp_wmb();      /* ftrace call must not remain without LR saver. */
> +       old = INSN_MOV_X9_X30;

Uhm, ok, you're using this multiple times. You can still keep the
comment and use the add/sub version directly, or introduce a mov
variant in a separate patch.

> +       ret = ftrace_modify_code(pc-REC_IP_BRANCH_OFFSET, old, new, true);
> +#endif
> +       return ret;
>  }
>
>  void arch_ftrace_update_code(int command)
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -115,6 +115,7 @@
>  #define MCOUNT_REC()   . = ALIGN(8);                           \
>                         __start_mcount_loc = .;                 \
>                         KEEP(*(__mcount_loc))                   \
> +                       KEEP(*(__patchable_function_entries))   \
>                         __stop_mcount_loc = .;
>  #else
>  #define MCOUNT_REC()
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -61,8 +61,12 @@ extern void __chk_io_ptr(const volatile
>  #if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
>  #define notrace __attribute__((hotpatch(0,0)))
>  #else
> +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> +#define notrace __attribute__((patchable_function_entry(0)))
> +#else
>  #define notrace __attribute__((no_instrument_function))
>  #endif
> +#endif
>
>  /* Intel compiler defines __GNUC__. So we will overwrite implementations
>   * coming from above header files here
