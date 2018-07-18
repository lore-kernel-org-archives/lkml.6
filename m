Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E17ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3L4UqpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643AA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeGRStJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:49:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50595 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeGRStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:49:09 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so5463577ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/E83Syk8+hnVa1HqNr8j+oDXN2CZfz/+cRo3A7lJVA=;
        b=P3L4UqpC3p8r8PYORiOVgpW2lCFgfSm/YACp0UMj7COUPoGunWQsx1NkhNdKrPypk4
         0Xi2qLyAWXRQ0M+2KBh8YZncnUbJkVGn9la1s4UcrZ2fsF5IQMqQawhFLn/VIPcJmWZw
         DyJqrcwN6zYSwjt9wREuakfOE+yo4kBksVBVKznT+7Sqk8hXuvGvDkNqSQJaMgOkl7Cb
         CSvQ4vaAPFn3nleiVjTATze3yYRFQ1FbflNsSY7Ai5ZSwdyFtGhhmI/OpXX4gVuG/Gzz
         nP2JYXb2dJXyqgMVgxGZByB56+FQMsrucIx9diqrOKHaB5A7gLIaPX9SSPHOrjhP+4Ve
         LROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/E83Syk8+hnVa1HqNr8j+oDXN2CZfz/+cRo3A7lJVA=;
        b=jL442w13WvUUyO285lZQXcxSmI5hyhaq79+LsNCgCnHGAP2TlKc0nLTeKMto89BMsC
         sXAHTaTOjRIynXr6lWEYaERPUUxDrIu2gkLWQt7vcot6z/aqWnOzqsNHbiGAzjJjDb/f
         N3ccIWJ+4NrA78kL0AvaY30nM7NZqwDEcZEFUI+/NhY+YoyZEVp1vqTvo0bRcMA6173r
         H1u+9Z4yF3QgWvbHahm2IY/0wn64qtN5/deoLdCBIHWACX+5AYpxtLYbyh+XmvieFz8/
         l624/2W7X8fjAWQq7JztPHvPZC7HjotqcE2Z4FBjQ96QrPdlMeCSiBcPX9WQnsvBVEZL
         aFmg==
X-Gm-Message-State: AOUpUlHfX08AqbbRQ8WcUCgkMKpDQfduv+WJ7T3cbiVa9yBMJCzxtzS+
        1Ooqx6GfDkHue83g7ZBYF3mxwqPcn5EetfNxzA==
X-Google-Smtp-Source: AAOMgpfj4ytS1ruQyDvJHPjoqn/O52AjJDWifm6w3yAq0TCtSEMqgPwmkseMHqPquQMW/V+Ae6n4R3DyhmxYLCqpPSA=
X-Received: by 2002:a24:eb0e:: with SMTP id h14-v6mr3194226itj.69.1531937405296;
 Wed, 18 Jul 2018 11:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <1531906876-13451-1-git-send-email-joro@8bytes.org> <1531906876-13451-8-git-send-email-joro@8bytes.org>
In-Reply-To: <1531906876-13451-8-git-send-email-joro@8bytes.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 18 Jul 2018 14:09:53 -0400
Message-ID: <CAMzpN2gqxu7rgVj8rfweanLNgHBci+nqZMqEYpvgRUd1828umQ@mail.gmail.com>
Subject: Re: [PATCH 07/39] x86/entry/32: Enter the kernel via trampoline stack
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        dhgutteridge@sympatico.ca, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 5:41 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Use the entry-stack as a trampoline to enter the kernel. The
> entry-stack is already in the cpu_entry_area and will be
> mapped to userspace when PTI is enabled.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/entry/entry_32.S        | 119 ++++++++++++++++++++++++++++++++-------
>  arch/x86/include/asm/switch_to.h |  14 ++++-
>  arch/x86/kernel/asm-offsets.c    |   1 +
>  arch/x86/kernel/cpu/common.c     |   5 +-
>  arch/x86/kernel/process.c        |   2 -
>  arch/x86/kernel/process_32.c     |   2 -
>  6 files changed, 115 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 7251c4f..fea49ec 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -154,7 +154,7 @@
>
>  #endif /* CONFIG_X86_32_LAZY_GS */
>
> -.macro SAVE_ALL pt_regs_ax=%eax
> +.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
>         cld
>         PUSH_GS
>         pushl   %fs
> @@ -173,6 +173,12 @@
>         movl    $(__KERNEL_PERCPU), %edx
>         movl    %edx, %fs
>         SET_KERNEL_GS %edx
> +
> +       /* Switch to kernel stack if necessary */
> +.if \switch_stacks > 0
> +       SWITCH_TO_KERNEL_STACK
> +.endif
> +
>  .endm
>
>  /*
> @@ -269,6 +275,73 @@
>  .Lend_\@:
>  #endif /* CONFIG_X86_ESPFIX32 */
>  .endm
> +
> +
> +/*
> + * Called with pt_regs fully populated and kernel segments loaded,
> + * so we can access PER_CPU and use the integer registers.
> + *
> + * We need to be very careful here with the %esp switch, because an NMI
> + * can happen everywhere. If the NMI handler finds itself on the
> + * entry-stack, it will overwrite the task-stack and everything we
> + * copied there. So allocate the stack-frame on the task-stack and
> + * switch to it before we do any copying.
> + */
> +.macro SWITCH_TO_KERNEL_STACK
> +
> +       ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
> +
> +       /* Are we on the entry stack? Bail out if not! */
> +       movl    PER_CPU_VAR(cpu_entry_area), %ecx
> +       addl    $CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
> +       subl    %esp, %ecx      /* ecx = (end of entry_stack) - esp */
> +       cmpl    $SIZEOF_entry_stack, %ecx
> +       jae     .Lend_\@
> +
> +       /* Load stack pointer into %esi and %edi */
> +       movl    %esp, %esi
> +       movl    %esi, %edi
> +
> +       /* Move %edi to the top of the entry stack */
> +       andl    $(MASK_entry_stack), %edi
> +       addl    $(SIZEOF_entry_stack), %edi
> +
> +       /* Load top of task-stack into %edi */
> +       movl    TSS_entry2task_stack(%edi), %edi
> +
> +       /* Bytes to copy */
> +       movl    $PTREGS_SIZE, %ecx
> +
> +#ifdef CONFIG_VM86
> +       testl   $X86_EFLAGS_VM, PT_EFLAGS(%esi)
> +       jz      .Lcopy_pt_regs_\@
> +
> +       /*
> +        * Stack-frame contains 4 additional segment registers when
> +        * coming from VM86 mode
> +        */
> +       addl    $(4 * 4), %ecx
> +
> +.Lcopy_pt_regs_\@:
> +#endif
> +
> +       /* Allocate frame on task-stack */
> +       subl    %ecx, %edi
> +
> +       /* Switch to task-stack */
> +       movl    %edi, %esp
> +
> +       /*
> +        * We are now on the task-stack and can safely copy over the
> +        * stack-frame
> +        */
> +       shrl    $2, %ecx

This shift can be removed if you divide the constants by 4 above.
Ditto on the exit path in the next patch.

--
Brian Gerst
