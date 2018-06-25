Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5101C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B042574B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lIqzOp9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B042574B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755177AbeFYKP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:15:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35356 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755055AbeFYKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:15:54 -0400
Received: by mail-io0-f196.google.com with SMTP id q4-v6so12024688iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uAKZ/Uy6xq8TI9LyEbNpaoQsCs8X747jG867goRmwB0=;
        b=lIqzOp9yZDvMZaSsc1Yp0eLOGm0GwTid6GiJK99yyKr6JdN9sTXackT6xIOIWd5ZPM
         RQSz0bNPhU0Z3GSRpW4tbqOSIMQk2jzmCWAWRLAC1F4PNFPwd/I0YZmVAaRVxgXWHSaY
         Ie/l3QJXoZlC5mhedEDDq/4TvWq1dqAjZ+ODhJEcFL6FMR2p2qIMvgqIcfP5uh07kBGs
         RwhoFpcw6b4wvwie3ezszi0Mc74LNb3l2LKd3qFDnFeZHia4sD3B8dqTohPQjCbhtUjv
         QXTHUDXdU4BOWU22qdrljByzpYqZ++mWQlUF4iskHJ0DQxlDflZYu/HeYu0hYAxOMH7Q
         V9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uAKZ/Uy6xq8TI9LyEbNpaoQsCs8X747jG867goRmwB0=;
        b=sOmsxSGf6qYl/YqSIGa7a59sW5D4/7EV7y88Td/XQUyaUbvx6zDrdE+jU1IfY2/CdO
         yQqoj1Mf6YjoDmr/iCne4ikTaYRheb+4FKwtCsQl2/Rl+pQH2WyKoDltAYw6dYeUzqgT
         hn1hxMqraZadTBBwshQfHS5fNEm9fvdS6z0bUEZkLBsUXEXIhX/s5UU3nQIFjyMfyszH
         n8b3OcR98ssI2Cj+ClrA5Ia9f+RN/NEitYoWSGxJL9sS+di4eE3E4mItC2KS9sRJbIF3
         DSmmay7pjgHJHwoWoTDvWuk0493t2aEhQIjITIwuoGzDqWlxnvkvhrd65aW3/Tgu8iA/
         PoWw==
X-Gm-Message-State: APt69E2HoeB6ia6HRE2m+wGYBRj/nS7FXcVJjHPLJR+BmaQyFwPdbXF2
        Rk5Ege4dn6h8PO07Vh0UtK7wywj7eDbduXtBlcFa+A==
X-Google-Smtp-Source: AAOMgpfuAywsVx3/7qnAkC6ofXmgL0FpN2eY2KcwVw6R6WQyHKdX2QS4RmNXwxAcx3E/umT01mKc+XM8RjbqZpBWUmE=
X-Received: by 2002:a6b:ec12:: with SMTP id c18-v6mr5291550ioh.128.1529921754141;
 Mon, 25 Jun 2018 03:15:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:4642:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 03:15:53
 -0700 (PDT)
In-Reply-To: <CAKv+Gu-M4vJfppfQ8PYv3hFR6a1FuOAEKpvyisYSZBe-ubMvHQ@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-4-ard.biesheuvel@linaro.org> <CAB0TPYGd1jQzgc2q+fJZif4LVQTPnOrD4b6w0YSAzgAB0oL86g@mail.gmail.com>
 <CAKv+Gu-M4vJfppfQ8PYv3hFR6a1FuOAEKpvyisYSZBe-ubMvHQ@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 25 Jun 2018 12:15:53 +0200
Message-ID: <CAB0TPYHrx=tcOmzT2_4QpDG-reSJVX3BYEZcH0-X1m30WEADNw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] module: use relative references for __ksymtab entries
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:14 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Because struct kernel_symbol is only 8 bytes in size after this
> change, and aligning a 8 byte quantity to 16 bytes wastes 8 bytes.

I get that, but then that means the 16-byte alignment wasn't actually
necessary in the first place.

> The x86 ABI may require it, but we don't actually adhere to it in the
> kernel. Also, these structures never occur on the stack anyway.

Ok, makes sense.

Thanks,
Martijn

>
>
>>> -#include <asm-generic/export.h>
>>> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>>> index 719db1968d81..97ce606459ae 100644
>>> --- a/include/asm-generic/export.h
>>> +++ b/include/asm-generic/export.h
>>> @@ -5,12 +5,10 @@
>>>  #define KSYM_FUNC(x) x
>>>  #endif
>>>  #ifdef CONFIG_64BIT
>>> -#define __put .quad
>>>  #ifndef KSYM_ALIGN
>>>  #define KSYM_ALIGN 8
>>>  #endif
>>>  #else
>>> -#define __put .long
>>>  #ifndef KSYM_ALIGN
>>>  #define KSYM_ALIGN 4
>>>  #endif
>>> @@ -25,6 +23,16 @@
>>>  #define KSYM(name) name
>>>  #endif
>>>
>>> +.macro __put, val, name
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +       .long   \val - ., \name - .
>>> +#elif defined(CONFIG_64BIT)
>>> +       .quad   \val, \name
>>> +#else
>>> +       .long   \val, \name
>>> +#endif
>>> +.endm
>>> +
>>>  /*
>>>   * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>>>   * since we immediately emit into those sections anyway.
>>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>>> index ab4711c63601..0a9328ea9dbd 100644
>>> --- a/include/linux/compiler.h
>>> +++ b/include/linux/compiler.h
>>> @@ -280,6 +280,25 @@ unsigned long read_word_at_a_time(const void *addr)
>>>
>>>  #endif /* __KERNEL__ */
>>>
>>> +/*
>>> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
>>> + * it from inline assembler. Necessary in case 'sym' could be inlined
>>> + * otherwise, or eliminated entirely due to lack of references that are
>>> + * visible to the compiler.
>>> + */
>>> +#define __ADDRESSABLE(sym) \
>>> +       static void * const __attribute__((section(".discard"), used))  \
>>> +               __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
>>> +
>>> +/**
>>> + * offset_to_ptr - convert a relative memory offset to an absolute pointer
>>> + * @off:       the address of the 32-bit offset value
>>> + */
>>> +static inline void *offset_to_ptr(const int *off)
>>> +{
>>> +       return (void *)((unsigned long)off + *off);
>>> +}
>>> +
>>>  #endif /* __ASSEMBLY__ */
>>>
>>>  #ifndef __optimize
>>> diff --git a/include/linux/export.h b/include/linux/export.h
>>> index 25005b55b079..04c78e6bfec9 100644
>>> --- a/include/linux/export.h
>>> +++ b/include/linux/export.h
>>> @@ -24,12 +24,6 @@
>>>  #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>>>
>>>  #ifndef __ASSEMBLY__
>>> -struct kernel_symbol
>>> -{
>>> -       unsigned long value;
>>> -       const char *name;
>>> -};
>>> -
>>>  #ifdef MODULE
>>>  extern struct module __this_module;
>>>  #define THIS_MODULE (&__this_module)
>>> @@ -60,17 +54,47 @@ extern struct module __this_module;
>>>  #define __CRC_SYMBOL(sym, sec)
>>>  #endif
>>>
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +#include <linux/compiler.h>
>>> +/*
>>> + * Emit the ksymtab entry as a pair of relative references: this reduces
>>> + * the size by half on 64-bit architectures, and eliminates the need for
>>> + * absolute relocations that require runtime processing on relocatable
>>> + * kernels.
>>> + */
>>> +#define __KSYMTAB_ENTRY(sym, sec)                                      \
>>> +       __ADDRESSABLE(sym)                                              \
>>> +       asm("   .section \"___ksymtab" sec "+" #sym "\", \"a\"  \n"     \
>>> +           "   .balign 8                                       \n"     \
>>> +           VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":              \n"     \
>>> +           "   .long " VMLINUX_SYMBOL_STR(sym) "- .            \n"     \
>>> +           "   .long " VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"     \
>>> +           "   .previous                                       \n")
>>> +
>>> +struct kernel_symbol {
>>> +       int value_offset;
>>> +       int name_offset;
>>> +};
>>> +#else
>>> +#define __KSYMTAB_ENTRY(sym, sec)                                      \
>>> +       static const struct kernel_symbol __ksymtab_##sym               \
>>> +       __attribute__((section("___ksymtab" sec "+" #sym), used))       \
>>> +       = { (unsigned long)&sym, __kstrtab_##sym }
>>> +
>>> +struct kernel_symbol {
>>> +       unsigned long value;
>>> +       const char *name;
>>> +};
>>> +#endif
>>> +
>>>  /* For every exported symbol, place a struct in the __ksymtab section */
>>>  #define ___EXPORT_SYMBOL(sym, sec)                                     \
>>>         extern typeof(sym) sym;                                         \
>>>         __CRC_SYMBOL(sym, sec)                                          \
>>>         static const char __kstrtab_##sym[]                             \
>>> -       __attribute__((section("__ksymtab_strings"), aligned(1)))       \
>>> +       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>>>         = VMLINUX_SYMBOL_STR(sym);                                      \
>>> -       static const struct kernel_symbol __ksymtab_##sym               \
>>> -       __used                                                          \
>>> -       __attribute__((section("___ksymtab" sec "+" #sym), used))       \
>>> -       = { (unsigned long)&sym, __kstrtab_##sym }
>>> +       __KSYMTAB_ENTRY(sym, sec)
>>>
>>>  #if defined(__DISABLE_EXPORTS)
>>>
>>> diff --git a/kernel/module.c b/kernel/module.c
>>> index ad2d420024f6..b4782cfbb79b 100644
>>> --- a/kernel/module.c
>>> +++ b/kernel/module.c
>>> @@ -549,12 +549,30 @@ static bool check_symbol(const struct symsearch *syms,
>>>         return true;
>>>  }
>>>
>>> +static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
>>> +{
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +       return (unsigned long)offset_to_ptr(&sym->value_offset);
>>> +#else
>>> +       return sym->value;
>>> +#endif
>>> +}
>>> +
>>> +static const char *kernel_symbol_name(const struct kernel_symbol *sym)
>>> +{
>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>> +       return offset_to_ptr(&sym->name_offset);
>>> +#else
>>> +       return sym->name;
>>> +#endif
>>> +}
>>> +
>>>  static int cmp_name(const void *va, const void *vb)
>>>  {
>>>         const char *a;
>>>         const struct kernel_symbol *b;
>>>         a = va; b = vb;
>>> -       return strcmp(a, b->name);
>>> +       return strcmp(a, kernel_symbol_name(b));
>>>  }
>>>
>>>  static bool find_symbol_in_section(const struct symsearch *syms,
>>> @@ -2198,7 +2216,7 @@ void *__symbol_get(const char *symbol)
>>>                 sym = NULL;
>>>         preempt_enable();
>>>
>>> -       return sym ? (void *)sym->value : NULL;
>>> +       return sym ? (void *)kernel_symbol_value(sym) : NULL;
>>>  }
>>>  EXPORT_SYMBOL_GPL(__symbol_get);
>>>
>>> @@ -2228,10 +2246,12 @@ static int verify_export_symbols(struct module *mod)
>>>
>>>         for (i = 0; i < ARRAY_SIZE(arr); i++) {
>>>                 for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
>>> -                       if (find_symbol(s->name, &owner, NULL, true, false)) {
>>> +                       if (find_symbol(kernel_symbol_name(s), &owner, NULL,
>>> +                                       true, false)) {
>>>                                 pr_err("%s: exports duplicate symbol %s"
>>>                                        " (owned by %s)\n",
>>> -                                      mod->name, s->name, module_name(owner));
>>> +                                      mod->name, kernel_symbol_name(s),
>>> +                                      module_name(owner));
>>>                                 return -ENOEXEC;
>>>                         }
>>>                 }
>>> @@ -2280,7 +2300,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>>>                         ksym = resolve_symbol_wait(mod, info, name);
>>>                         /* Ok if resolved.  */
>>>                         if (ksym && !IS_ERR(ksym)) {
>>> -                               sym[i].st_value = ksym->value;
>>> +                               sym[i].st_value = kernel_symbol_value(ksym);
>>>                                 break;
>>>                         }
>>>
>>> @@ -2540,7 +2560,7 @@ static int is_exported(const char *name, unsigned long value,
>>>                 ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
>>>         else
>>>                 ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
>>> -       return ks != NULL && ks->value == value;
>>> +       return ks != NULL && kernel_symbol_value(ks) == value;
>>>  }
>>>
>>>  /* As per nm */
>>> --
>>> 2.15.1
>>>
