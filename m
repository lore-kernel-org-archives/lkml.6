Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB40C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1902086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MBVoqKuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1902086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJKB1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:27:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40280 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKB1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:27:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so6762667wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1shNk7n2oOgD9+BO00oSqO5Hb98+635hkuFoxp4xFkI=;
        b=MBVoqKuqCpi/HjZ28fUwBU/eHrKf7RnLF90cKeOgJ7vfBGIhQmWMlZUNg3SvjKeI/v
         RZH9bEQu10rjQd4P45imZQeEXALihEDVhJlOQpr+NoGcbewcgZam4Lw+2TChUFnYBmBY
         vDnwpRKCNo757wPMYDolbu9yZABRKnkPyLk171p8+bUOCyR9HdpmCSTNeihQ2mLcmdcp
         cDqMcYIC0A2LhvIXh582ojR0bGpI/H8DifqxS4zk0GiHc+Gb0qw5O2Pc/BvZgB62tITt
         iKo9GYVOSsJb1eOYPIH4+Y1hTuzLXPKQoQbRD/JPmR39Lb76dbgc6hDRYkMdQpGIr3Ab
         8Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1shNk7n2oOgD9+BO00oSqO5Hb98+635hkuFoxp4xFkI=;
        b=n4Od97ToDk+WPsfpsc425OqL6ar4ydLwJnjpvXFL0UmrPylFyDP/GBOgcQAHNPPZ6Y
         /wYfN5po9wVE6mJkJ8ISHhQmTYDLAbFfedNkurDZU/8srXTOAjDwyIwiDWH/KqvN7l1A
         NA18AKV/2FfWjdLyNEFcFuwWu4131XBa8zKZHVShcOSNyrmIB2QEKlU2tHWvnVv8QWft
         gWRKtZsAEFI08o57EEm3hTYaJihh+yBrW4uIJN8WcDM3RINjietO8UuUOJAFS3lC/Tsn
         LFpeN1yHDFsJf8qzDgPFJcPF9uTfW1vVqA+qW+CQ12bin23hhSIsDYlH2mr5byQHlx5a
         IpYg==
X-Gm-Message-State: ABuFfoiNguvRFNs+eEXv2BRj8AdUd4r+iDRq2roF7/OXjEPpCYu4uhw4
        NUzXyg0e4OQAoH1H/iAfk2JSiosEWsOV0KcYMVrqUg==
X-Google-Smtp-Source: ACcGV60KWyfm7cQOzNDgBo2Hz6y93HAGZOWRNvdnRSOpw874kTXctmuLeFpUL0jO9JPWWvbOcs5+1K/SAHjm+h7aSmY=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr23421227wrc.131.1539194635834;
 Wed, 10 Oct 2018 11:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181009021710.qwt5hpntyeps44h3@treble> <20181008235750.59da83ae@gandalf.local.home>
 <20181010175237.e7m3sldcu2maoqcq@treble>
In-Reply-To: <20181010175237.e7m3sldcu2maoqcq@treble>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Oct 2018 11:03:43 -0700
Message-ID: <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:52 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Oct 08, 2018 at 11:57:50PM -0400, Steven Rostedt wrote:
> > On Mon, 8 Oct 2018 21:17:10 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > I'm not really convinced we need objtool for this, maybe I'll try
> > > whipping up a POC.
> >
> > Awesome!
> >
> > I wasn't thinking of actually having objtool itself perform this task,
> > but instead breaking the internals of objtool up into more of a generic
> > infrastructure, that recordmcount.c, objtool, and whatever this does
> > can use.
>
> So I had been thinking that we could find the call sites at runtime, by
> looking at the relocations.  But I managed to forget that vmlinux
> relocations are resolved during linking.  So yeah, some kind of tooling
> magic would be needed.
>
> I worked up a POC using objtool.  It doesn't *have* to be done with
> objtool, but since it's already reading/writing all the ELF stuff
> anyway, it was pretty easy to add this on.
>
> This patch has at least a few issues:
>
> - No module support.
>
> - For some reason, the sync_cores in text_poke_bp() don't always seem to
>   be working as expected.  Running this patch on my VM, the test code in
>   cmdline_proc_show() works *most* of the time, but it occasionally
>   branches off into the weeds.  I have no idea what the problem is yet.
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9d329608913e..20ff5624dad7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -865,6 +865,9 @@ config HAVE_ARCH_PREL32_RELOCATIONS
>           architectures, and don't require runtime relocation on relocatable
>           kernels.
>
> +config HAVE_ARCH_STATIC_CALL
> +       bool
> +
>  source "kernel/gcov/Kconfig"
>
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5136a1281870..1a14c8f87876 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -128,6 +128,7 @@ config X86
>         select HAVE_ARCH_COMPAT_MMAP_BASES      if MMU && COMPAT
>         select HAVE_ARCH_PREL32_RELOCATIONS
>         select HAVE_ARCH_SECCOMP_FILTER
> +       select HAVE_ARCH_STATIC_CALL            if X86_64
>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
> new file mode 100644
> index 000000000000..40fec631b760
> --- /dev/null
> +++ b/arch/x86/include/asm/static_call.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_STATIC_CALL_H
> +#define _ASM_STATIC_CALL_H
> +
> +#ifdef CONFIG_X86_64
> +
> +#include <linux/frame.h>
> +
> +void static_call_init(void);
> +extern void __static_call_update(void *tramp, void *func);
> +
> +#define DECLARE_STATIC_CALL(tramp, func)                               \
> +       extern typeof(func) tramp;                                      \
> +       static void __used __section(.discard.static_call_tramps)       \
> +               *__static_call_tramp_##tramp = tramp
> +

Confused.  What's the __static_call_tramp_##tramp variable for?  And
why is a DECLARE_ macro defining a variable?

> +#define DEFINE_STATIC_CALL(tramp, func)                                        \
> +       DECLARE_STATIC_CALL(tramp, func);                               \
> +       asm(".pushsection .text, \"ax\"                         \n"     \
> +           ".align 4                                           \n"     \
> +           ".globl " #tramp "                                  \n"     \
> +           ".type " #tramp ", @function                        \n"     \
> +           #tramp ":                                           \n"     \
> +           "jmp " #func "                                      \n"     \

I think this would be nicer as an indirect call that gets patched to a
direct call so that the update mechanism works even before it's
initialized.  (Currently static_branch blows up horribly if you try to
update one too early, and that's rather annoying IMO.)

Also, I think you're looking for "jmp.d32", which is available in
newer toolchains.  For older toolchains, you could use .byte 0xe9 or
you could use a different section (I think) to force a real 32-bit
jump.

> +void __init static_call_init(void)
> +{
> +       struct static_call_entry *entry;
> +       unsigned long insn, tramp, func;
> +       unsigned char insn_opcode, tramp_opcode;
> +       s32 call_dest;
> +
> +       for (entry = __start_static_call_table;
> +            entry < __stop_static_call_table; entry++) {
> +
> +               insn = (long)entry->insn + (unsigned long)&entry->insn;
> +               tramp = (long)entry->tramp + (unsigned long)&entry->tramp;
> +
> +               insn_opcode = *(unsigned char *)insn;
> +               if (insn_opcode != 0xe8 && insn_opcode != 0xe9) {
> +                       WARN_ONCE(1, "unexpected static call insn opcode %x at %pS",
> +                                 insn_opcode, (void *)insn);
> +                       continue;
> +               }
> +
> +               tramp_opcode = *(unsigned char *)tramp;
> +               if (tramp_opcode != 0xeb && tramp_opcode != 0xe9) {
> +                       WARN_ONCE(1, "unexpected trampoline jump opcode %x at %ps",
> +                                tramp_opcode, (void *)tramp);
> +                       continue;
> +               }
> +
> +               if (tramp_opcode == 0xeb)
> +                       func = *(s8 *)(tramp + 1) + (tramp + 2);

I realize you expect some instances of 0xeb due to the assembler
messing you up (see above), but this seems a bit too permissive, since
a 0xeb without the appropriate set of NOPs is going to explode.  And:

> +               else
> +                       func = *(s32 *)(tramp + 1) + (tramp + 5);
> +
> +               call_dest = (long)(func) - (long)(insn + 5);
> +
> +               printk("static_call_init: poking %lx at %lx\n", (unsigned long)call_dest, (insn+1));
> +
> +               text_poke_early((void *)(insn + 1), &call_dest, 4);

If you really are going to rewrite an 8-bit jump to a 32-bit jump, I
think you need to actually patch the opcode byte :)
