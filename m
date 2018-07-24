Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0191C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438D920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="B8lRkYhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438D920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbeGXJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:02:01 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52287 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbeGXJCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:02:01 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so2560928itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pi/UE2betognqtskU2pid92n5K+PUpBTZPurlr03/9c=;
        b=B8lRkYhLm1Zx+2bjneCOM/ooU+ODkW+c6Cv0OcQqKmEeF3PqqmnK/OinFdwaXabqmv
         wheG6STDBRGtSbATqWDlJR+dhF5KU41cxa6+D+K7pUgbTN/VWQmV5IxQtYmXMXC3w+dw
         tBLTOq4tERSFZL5uFgFvHjWCXZWX9HdnZD9R7Dl96mfVUl8ognLt8wtl7tOw81WMI7VO
         8KMFhidi3jvOrT0fDhMf0u9AQd/s++ZVLbCrNXWMjINfGESaT1wD8sfYBhzDRp4r6ejK
         OG3TGMxwLhd2d3nbdoD235WPYTiX9EpIpoIa8jKeXJcqlLovFQBf6EAdCmfA3o95a2Kj
         q9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pi/UE2betognqtskU2pid92n5K+PUpBTZPurlr03/9c=;
        b=FUeyW5eB2FprI/3Wp4PwKnj9x2vhN/6Q10pQ3Vu71cJVFccKirqTodxFd5wPbsB+F6
         OGLZuP9vXS9TlwJCG0gzriHx2K5Z+OsRqZPrLEJmOXoB7rEGw9MJPeYEFKpD2BzFm3d8
         1mX8RzJipTZnV0VARqMUpGZ6yG89HzsDPrXGlXQOEgTL7iqVtwMX3ac/96ZAxStP+bXv
         2WAEyT//1nmAthf6gyW2Xr8LZR3zh51LQ92EJWNFxzUovIb8mNzUgVljJN8o678kPbJ6
         bhtUp0nPNLz755CO5YgYWMp2mLsY79tpe/R0hSOBZ73J4RD3bt7zyuJ4vlV/Zlrh5gYZ
         ZhlA==
X-Gm-Message-State: AOUpUlElRnlNy7EW4Mb9o+hTy8J2JCb1mPjxUAYpl3I2McbJH52tNq5n
        T5PYqlvESNs4qP7GkSVkgwJ8GudLkuULBfLfEteIqAf2
X-Google-Smtp-Source: AAOMgpdU0xt4qshVbDfj5mtyU7E4K9TqcxIYD4GjbUTdUenHpVcAAuHbV8MAZ8A1qjVKjzz6ssn3Mn0LTSQ+rc6bSzY=
X-Received: by 2002:a24:d0cd:: with SMTP id m196-v6mr1937101itg.9.1532419008113;
 Tue, 24 Jul 2018 00:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:56:47
 -0700 (PDT)
In-Reply-To: <20180716122125.175792-3-maco@android.com>
References: <20180716122125.175792-1-maco@android.com> <20180716122125.175792-3-maco@android.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 24 Jul 2018 09:56:47 +0200
Message-ID: <CAB0TPYEOVHcFGFLTjVvk7R0VSgSnXZRi1PjSYXONJSjqd4NewQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] module: add support for symbol namespaces.
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        linux-scsi@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Iliyan Malchev <malchev@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did find an issue with my approach:

On Mon, Jul 16, 2018 at 2:21 PM, Martijn Coenen <maco@android.com> wrote:
> The ELF symbols are renamed to include the namespace with an asm label;
> for example, symbol 'usb_stor_suspend' in namespace USB_STORAGE becomes
> 'usb_stor_suspend.USB_STORAGE'.  This allows modpost to do namespace
> checking, without having to go through all the effort of parsing ELF and
> reloction records just to get to the struct kernel_symbols.

depmod doesn't like this: if namespaced symbols are built-in to the
kernel, they will appear as 'symbol.NS' in the symbol table, whereas
modules using those symbols just depend on 'symbol'. This will cause
depmod to warn about unknown symbols. I didn't find this previously
because all the exports/imports I tested were done from modules
themselves.

One way to deal with it is to change depmod, but it looks like it
hasn't been changed in ages, and it would also introduce a dependency
on userspaces to update it to avoid these warnings. So, we'd have to
encode the symbol namespace information in another way for modpost to
use. I could just write a separate post-processing tool (much like
genksyms), or perhaps encode the information in a discardable section.
Any other suggestions welcome.

Thanks,
Martijn

>
> On x86_64 I saw no difference in binary size (compression), but at
> runtime this will require a word of memory per export to hold the
> namespace. An alternative could be to store namespaced symbols in their
> own section and use a separate 'struct namespaced_kernel_symbol' for
> that section, at the cost of making the module loader more complex.
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  include/asm-generic/export.h |  2 +-
>  include/linux/export.h       | 83 +++++++++++++++++++++++++++---------
>  include/linux/module.h       | 13 ++++++
>  kernel/module.c              | 79 ++++++++++++++++++++++++++++++++++
>  4 files changed, 156 insertions(+), 21 deletions(-)
>
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 68efb950a918..4c3d1afb702f 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -29,7 +29,7 @@
>         .section ___ksymtab\sec+\name,"a"
>         .balign KSYM_ALIGN
>  __ksymtab_\name:
> -       __put \val, __kstrtab_\name
> +       __put \val, __kstrtab_\name, 0
>         .previous
>         .section __ksymtab_strings,"a"
>  __kstrtab_\name:
> diff --git a/include/linux/export.h b/include/linux/export.h
> index ad6b8e697b27..9f6e70eeb85f 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -22,6 +22,11 @@ struct kernel_symbol
>  {
>         unsigned long value;
>         const char *name;
> +       const char *namespace;
> +};
> +
> +struct namespace_import {
> +       const char *namespace;
>  };
>
>  #ifdef MODULE
> @@ -54,18 +59,28 @@ extern struct module __this_module;
>  #define __CRC_SYMBOL(sym, sec)
>  #endif
>
> +#define NS_SEPARATOR "."
> +
> +#define MODULE_IMPORT_NS(ns)                                           \
> +       static const struct namespace_import __knsimport_##ns           \
> +       asm("__knsimport_" #ns)                                         \
> +       __attribute__((section("__knsimport"), used))                   \
> +       = { #ns }
> +
>  /* For every exported symbol, place a struct in the __ksymtab section */
> -#define ___EXPORT_SYMBOL(sym, sec)                                     \
> +#define ___EXPORT_SYMBOL(sym, sec, ns, nspost, nspost2)                        \
>         extern typeof(sym) sym;                                         \
>         __CRC_SYMBOL(sym, sec)                                          \
> -       static const char __kstrtab_##sym[]                             \
> +       static const char __kstrtab_##sym##nspost[]                     \
>         __attribute__((section("__ksymtab_strings"), aligned(1)))       \
>         = #sym;                                                         \
> -       static const struct kernel_symbol __ksymtab_##sym               \
> +       static const struct kernel_symbol __ksymtab_##sym##nspost       \
> +       asm("__ksymtab_" #sym nspost2)                                  \
>         __used                                                          \
> -       __attribute__((section("___ksymtab" sec "+" #sym), used))       \
> +       __attribute__((section("___ksymtab" sec "+" #sym #nspost)))     \
> +       __attribute__((used))                                           \
>         __attribute__((aligned(sizeof(void *))))                        \
> -       = { (unsigned long)&sym, __kstrtab_##sym }
> +       = { (unsigned long)&sym, __kstrtab_##sym##nspost, ns }
>
>  #if defined(__KSYM_DEPS__)
>
> @@ -76,52 +91,80 @@ extern struct module __this_module;
>   * system filters out from the preprocessor output (see ksym_dep_filter
>   * in scripts/Kbuild.include).
>   */
> -#define __EXPORT_SYMBOL(sym, sec)      === __KSYM_##sym ===
> +#define __EXPORT_SYMBOL(sym, sec, ns, nspost, nspost2) === __KSYM_##sym ===
>
>  #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
>
>  #include <generated/autoksyms.h>
>
> -#define __EXPORT_SYMBOL(sym, sec)                              \
> -       __cond_export_sym(sym, sec, __is_defined(__KSYM_##sym))
> -#define __cond_export_sym(sym, sec, conf)                      \
> -       ___cond_export_sym(sym, sec, conf)
> -#define ___cond_export_sym(sym, sec, enabled)                  \
> -       __cond_export_sym_##enabled(sym, sec)
> -#define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
> -#define __cond_export_sym_0(sym, sec) /* nothing */
> +#define __EXPORT_SYMBOL(sym, sec, ns, nspost, nspost2)                 \
> +       __cond_export_sym(sym, sec, ns, nspost, nspost2,                \
> +                         __is_defined(__KSYM_##sym))
> +#define __cond_export_sym(sym, sec, ns, nspost, nspost2, conf)         \
> +       ___cond_export_sym(sym, sec, ns, nspost, nspost2, conf)
> +#define ___cond_export_sym(sym, sec, ns, nspost, nspost2, enabled)     \
> +       __cond_export_sym_##enabled(sym, sec, ns, nspost, nspost2)
> +#define __cond_export_sym_1(sym, sec, ns, nspost, nspost2)             \
> +       ___EXPORT_SYMBOL(sym, sec, ns, nspost, nspost2)
> +#define __cond_export_sym_0(sym, sec, ns, nspost, nspost2) /* nothing */
>
>  #else
>  #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
>  #endif
>
>  #define EXPORT_SYMBOL(sym)                                     \
> -       __EXPORT_SYMBOL(sym, "")
> +       __EXPORT_SYMBOL(sym, "", NULL, ,)
>
>  #define EXPORT_SYMBOL_GPL(sym)                                 \
> -       __EXPORT_SYMBOL(sym, "_gpl")
> +       __EXPORT_SYMBOL(sym, "_gpl", NULL, ,)
>
>  #define EXPORT_SYMBOL_GPL_FUTURE(sym)                          \
> -       __EXPORT_SYMBOL(sym, "_gpl_future")
> +       __EXPORT_SYMBOL(sym, "_gpl_future", NULL, ,)
> +
> +#define EXPORT_SYMBOL_NS(sym, ns)                               \
> +       __EXPORT_SYMBOL(sym, "", #ns, __##ns, NS_SEPARATOR #ns)
> +
> +#define EXPORT_SYMBOL_NS_GPL(sym, ns)                               \
> +       __EXPORT_SYMBOL(sym, "_gpl", #ns, __##ns, NS_SEPARATOR #ns)
>
>  #ifdef CONFIG_UNUSED_SYMBOLS
> -#define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
> -#define EXPORT_UNUSED_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_unused_gpl")
> +#define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused", , ,)
> +#define EXPORT_UNUSED_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_unused_gpl", , ,)
>  #else
>  #define EXPORT_UNUSED_SYMBOL(sym)
>  #define EXPORT_UNUSED_SYMBOL_GPL(sym)
>  #endif
>
> -#endif /* __GENKSYMS__ */
> +#endif /* __KERNEL__ && !__GENKSYMS__ */
> +
> +#if defined(__GENKSYMS__)
> +/*
> + * When we're running genksyms, ignore the namespace and make the _NS
> + * variants look like the normal ones. There are two reasons for this:
> + * 1) In the normal definition of EXPORT_SYMBOL_NS, the 'ns' macro
> + *    argument is itself not expanded because it's always tokenized or
> + *    concatenated; but when running genksyms, a blank definition of the
> + *    macro does allow the argument to be expanded; if a namespace
> + *    happens to collide with a #define, this can cause issues.
> + * 2) There's no need to modify genksyms to deal with the _NS variants
> + */
> +#define EXPORT_SYMBOL_NS(sym, ns)                              \
> +       EXPORT_SYMBOL(sym)
> +#define EXPORT_SYMBOL_NS_GPL(sym, ns)                          \
> +       EXPORT_SYMBOL_GPL(sym)
> +#endif
>
>  #else /* !CONFIG_MODULES... */
>
>  #define EXPORT_SYMBOL(sym)
> +#define EXPORT_SYMBOL_NS(sym, ns)
> +#define EXPORT_SYMBOL_NS_GPL(sym, ns)
>  #define EXPORT_SYMBOL_GPL(sym)
>  #define EXPORT_SYMBOL_GPL_FUTURE(sym)
>  #define EXPORT_UNUSED_SYMBOL(sym)
>  #define EXPORT_UNUSED_SYMBOL_GPL(sym)
>
> +#define MODULE_IMPORT_NS(ns)
>  #endif /* CONFIG_MODULES */
>  #endif /* !__ASSEMBLY__ */
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index d44df9b2c131..afab4e8fa188 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -268,6 +268,12 @@ void *__symbol_get(const char *symbol);
>  void *__symbol_get_gpl(const char *symbol);
>  #define symbol_get(x) ((typeof(&x))(__symbol_get(VMLINUX_SYMBOL_STR(x))))
>
> +/* namespace dependencies of the module */
> +struct module_ns_dep {
> +       struct list_head ns_dep;
> +       const char *namespace;
> +};
> +
>  /* modules using other modules: kdb wants to see this. */
>  struct module_use {
>         struct list_head source_list;
> @@ -359,6 +365,13 @@ struct module {
>         const struct kernel_symbol *gpl_syms;
>         const s32 *gpl_crcs;
>
> +       /* Namespace imports */
> +       unsigned int num_ns_imports;
> +       const struct namespace_import *ns_imports;
> +
> +       /* Namespace dependencies */
> +       struct list_head ns_dependencies;
> +
>  #ifdef CONFIG_UNUSED_SYMBOLS
>         /* unused exported symbols. */
>         const struct kernel_symbol *unused_syms;
> diff --git a/kernel/module.c b/kernel/module.c
> index f475f30eed8c..63de0fe849f9 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1166,6 +1166,51 @@ static inline int module_unload_init(struct module *mod)
>  }
>  #endif /* CONFIG_MODULE_UNLOAD */
>
> +static bool module_has_ns_dependency(struct module *mod, const char *ns)
> +{
> +       struct module_ns_dep *ns_dep;
> +
> +       list_for_each_entry(ns_dep, &mod->ns_dependencies, ns_dep) {
> +               if (strcmp(ns_dep->namespace, ns) == 0)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static int add_module_ns_dependency(struct module *mod, const char *ns)
> +{
> +       struct module_ns_dep *ns_dep;
> +
> +       if (module_has_ns_dependency(mod, ns))
> +               return 0;
> +
> +       ns_dep = kmalloc(sizeof(*ns_dep), GFP_ATOMIC);
> +       if (!ns_dep)
> +               return -ENOMEM;
> +
> +       ns_dep->namespace = ns;
> +
> +       list_add(&ns_dep->ns_dep, &mod->ns_dependencies);
> +
> +       return 0;
> +}
> +
> +static bool module_imports_ns(struct module *mod, const char *ns)
> +{
> +       size_t i;
> +
> +       if (!ns)
> +               return true;
> +
> +       for (i = 0; i < mod->num_ns_imports; ++i) {
> +               if (!strcmp(mod->ns_imports[i].namespace, ns))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static size_t module_flags_taint(struct module *mod, char *buf)
>  {
>         size_t l = 0;
> @@ -1415,6 +1460,18 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
>                 goto getname;
>         }
>
> +       /*
> +        * We can't yet verify that the module actually imports this
> +        * namespace, because the imports themselves are only available
> +        * after processing the symbol table and doing relocation; so
> +        * instead just record the dependency and check later.
> +        */
> +       if (sym->namespace) {
> +               err = add_module_ns_dependency(mod, sym->namespace);
> +               if (err)
> +                       sym = ERR_PTR(err);
> +       }
> +
>  getname:
>         /* We must make copy under the lock if we failed to get ref. */
>         strncpy(ownername, module_name(owner), MODULE_NAME_LEN);
> @@ -3061,6 +3118,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>                                      sizeof(*mod->gpl_syms),
>                                      &mod->num_gpl_syms);
>         mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
> +
> +       mod->ns_imports = section_objs(info, "__knsimport",
> +                                      sizeof(*mod->ns_imports),
> +                                      &mod->num_ns_imports);
> +
>         mod->gpl_future_syms = section_objs(info,
>                                             "__ksymtab_gpl_future",
>                                             sizeof(*mod->gpl_future_syms),
> @@ -3381,6 +3443,19 @@ static int post_relocation(struct module *mod, const struct load_info *info)
>         return module_finalize(info->hdr, info->sechdrs, mod);
>  }
>
> +static void verify_namespace_dependencies(struct module *mod)
> +{
> +       struct module_ns_dep *ns_dep;
> +
> +       list_for_each_entry(ns_dep, &mod->ns_dependencies, ns_dep) {
> +               if (!module_imports_ns(mod, ns_dep->namespace)) {
> +                       pr_warn("%s: module uses symbols from namespace %s,"
> +                               " but does not import it.\n",
> +                               mod->name, ns_dep->namespace);
> +               }
> +       }
> +}
> +
>  /* Is this module of this name done loading?  No locks held. */
>  static bool finished_loading(const char *name)
>  {
> @@ -3682,6 +3757,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>         if (err)
>                 goto free_module;
>
> +       INIT_LIST_HEAD(&mod->ns_dependencies);
> +
>  #ifdef CONFIG_MODULE_SIG
>         mod->sig_ok = info->sig_ok;
>         if (!mod->sig_ok) {
> @@ -3730,6 +3807,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>         if (err < 0)
>                 goto free_modinfo;
>
> +       verify_namespace_dependencies(mod);
> +
>         flush_module_icache(mod);
>
>         /* Now copy in args */
> --
> 2.18.0.203.gfac676dfb9-goog
>
