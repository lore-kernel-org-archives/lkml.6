Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68818C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356121567
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdOJarsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356121567
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHYDu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:50:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34457 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHYDu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:50:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so5236982pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cqotwkbbjdDNPceWNHyhve3xPi3PKZG7wpSfhz8SoM0=;
        b=QdOJarsAaNG1oHcm292At7zxdpfCdROd681xtT9jp4Tbrce4xvdW3+BPy97aekok8f
         TxfaBGgdGK2zzAFow5Jnow6wkVzWOv0y2cnwPDcXBVO9HhQCjP+pcYJyYb8qQOUsfBdf
         QrDb3pogKqWZOC1xX33aZh51K//2B9jxypFTE+Jt4kHGpUVnNDeaG9l0Csj/z42Jn5Cl
         Uui7DcmA/VZmkLkQNymQQudhKT8BlM9Tiw6c89LliE/7HfTHH3HMfGI0gayADYs7kWUq
         wC7G4uEERngLcNmQz+yS6r1MStLKTp7TAjMq7LsZKM6B7eFq0zsRfRIlHjc2H04TQvuj
         yxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cqotwkbbjdDNPceWNHyhve3xPi3PKZG7wpSfhz8SoM0=;
        b=WPuzS5wf/zwP8EfjELqj8iRQJhYJ40K+r0f5XZcr9fbYCqbNOMNSMEOZeuCAHU/AIO
         D7cPtlO6ww99ADLrDcDpNJZZXR4mKbKB+DnEQ5XoMYZCZcJDQPQ29rofrjltbOfdwYdD
         2lhd8nxMkFTRSVjy8wbJoUpmjWQff13/gQlsDEImO6TodkgtzU+p4LJAD8lgZle4MaaJ
         rwdgNKHSmGd1jY6OpkBiVoVNvSyH88mVWJJJ76RDKmf4h20WTnWSqzMKSbFzlD3ERInY
         c7lcQQXUZoHzF7JeEEAPP5zPJjqzZRUYPhRX7LEU+btxNlMN1MJF8Ai261N3OMT94ia4
         q0rQ==
X-Gm-Message-State: APzg51BxKw6SEIufrRGkIZrl5w1IJqeKfn/Bkepnn13m813462nPBQ9Z
        GoDhQCfVZiC06B4rKtr1mC7F6COcy2Wx9c+SqEwVBg==
X-Google-Smtp-Source: ANB0VdYIKCy2eMKueePGPQ5gzJhC2nbIcx6bETVQbH6xl0yVoP2/D8R4UO5WbHUIe4NmHGp6qpZaVIvGu3b9yDakQkQ=
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr3527406pgm.227.1535156044014;
 Fri, 24 Aug 2018 17:14:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 24 Aug 2018 17:13:43
 -0700 (PDT)
In-Reply-To: <20180824235826.62741-1-jannh@google.com>
References: <20180824235826.62741-1-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Aug 2018 17:13:43 -0700
Message-ID: <CACT4Y+YPh3QqononWCyXBByuzjFHrDz_PZrbh9XK7toiJMA82g@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: wipe KASAN stack shadow in rewind_stack_do_exit()
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:58 PM, Jann Horn <jannh@google.com> wrote:
> Reset the KASAN shadow state of the task stack when rewinding RSP.
> Without this, a kernel oops will leave parts of the stack poisoned, and
> code running under do_exit() can trip over such poisoned regions and cause
> nonsensical false-positive KASAN reports about stack-out-of-bounds bugs.
>
> This patch is 64-bit only because KASAN doesn't exist on 32-bit.
>
> This patch does not wipe exception stacks; if you oops on an exception
> stack, you might get random KASAN false-positives from other tasks
> afterwards. This is probably relatively uninteresting, since if you're
> oopsing on an exception stack, you likely have bigger things to worry
> about. It'd be more interesting if vmapped stacks and KASAN were
> compatible, since then handle_stack_overflow() would oops from exception
> stack context.
>
> Fixes: 2deb4be28077 ("x86/dumpstack: When OOPSing, rewind the stack before do_exit()")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> I have manually tested that an oops that previously triggered this bug
> doesn't trigger it anymore.
>
> It would be possible to rewrite this assembly to use fewer instructions
> in non-KASAN builds, but I think it's clearer this way.
>
> If anyone thinks that this thing should also be wiping exception stacks:
> I did write some (entirely untested) code that should take care of that
> (before realizing that it's rather unlikely to occur in practice because
> vmapped stacks and KASAN are mutually exclusive), but I'm not sure
> whether it's worth complicating this code for that.
> In case anyone's curious how that would look:
> https://gist.github.com/thejh/c91f9b4e3cc4c58659bb3cd056c4fa40
>
>  arch/x86/entry/entry_64.S | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 957dfb693ecc..92d3ad5bd365 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1673,9 +1673,25 @@ ENTRY(rewind_stack_do_exit)
>         /* Prevent any naive code from trying to unwind to our caller. */
>         xorl    %ebp, %ebp
>
> +       movq    %rdi, %r14
> +
>         movq    PER_CPU_VAR(cpu_current_top_of_stack), %rax
> -       leaq    -PTREGS_SIZE(%rax), %rsp
> +       leaq    -PTREGS_SIZE(%rax), %r15
> +
> +#ifdef CONFIG_KASAN
> +       /*
> +        * Remove stack poisons left behind by our old stack.
> +        * Do this before updating RSP to avoid problems in case we get some
> +        * interrupt that is not handled on an exception stack before we're done
> +        * with the unpoisoning.
> +        */
> +       movq    %r15, %rdi
> +       call    kasan_unpoison_task_stack_below
> +#endif
> +
> +       movq    %r15, %rsp
>         UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
>
> +       movq    %r14, %rdi
>         call    do_exit
>  END(rewind_stack_do_exit)
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>
