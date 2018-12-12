Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58EC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Rg3SVE+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58EC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeLLTsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:48:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41368 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeLLTsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:48:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so18819388otk.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwbPwjU+jEUyBj8dwC4Zj3N+2ldazEu4kINBGiJ6+xE=;
        b=Rg3SVE+RlCrBdxEm+iN7SC1Narhs06iry7eRVWkv035lEp4hrSJeICPBCIM/JaApOC
         HZSq4g77yKsRqMC6EzzBgK4P91C8sGt3sQJbNpdBwQckMHu2AXYfHA0GEnbDtI1MADIB
         bv34YeosSqmxj7HL355kkWtsJfY26+nxrB40hMvBaEvVBJojkqN83fNjciLBSpWQZhb5
         dH+p6X1hIZ9uprVUHOXruqad7RQMNBHIpXi1hsxqjP1x0iomyQpfWdD93iD4rYfm4Tgl
         kDTCSshxYaqxl9noS+tEWg9iA5rkMGpHvUvWrzuEXCZlxVkefNKJhnRHFxFvyP43IMbu
         YPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwbPwjU+jEUyBj8dwC4Zj3N+2ldazEu4kINBGiJ6+xE=;
        b=OCfR/OXMvh226lUBVJRZWPhCL0hDl/Skd4ymaqDBlkNs1mcFFWcxgwTfgOSAVMQ/mc
         2W9NNZ+XxMhO/P1eTE0FEGizP5MS7O8yZfC7NOBGziqL0aYPQPiOhM9x5wWyhwE/3rKi
         nMXEEbiiVLpa1D/xKfT4Ak/bdrUW5GwzvXUZZPol11Z3mgwEC2yv05VP+WBa1K8qRS4+
         lX8EPRYoZR3+Afa0nP2ZVy7vqNnD9upSbWXHHST+BiRh6QTYxtlH5D3aF7+GqtpwmSuE
         FIve0IB7DXewBbh9pqunVJtDUsDKhnQ+y7hi4obbU0gRV85Fas+wGk/CWCL83LYlRjmZ
         ESHA==
X-Gm-Message-State: AA+aEWZa0QpGaYfmJIK9EOJj0ySNIaWo/uzzvfRZwlQ9Nan0JjTQTUtU
        gcVu0XaYSGUcSlmAa29cXFXElgNvW0pJ3xxuDkYNvQ==
X-Google-Smtp-Source: AFSGD/Vbf0f6HS7IqRB3hp1t+aW0xbEpgDtUzmfi91OqGwx8HyPuIuns0tuyo80aki6X6H2oYh5HGJ63BbLfGoYmMsw=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr14331906otf.98.1544644097660;
 Wed, 12 Dec 2018 11:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20181211005647.104927-1-trong@android.com> <CAKwvOdmSp8PHj+iK5KT1XLC89gzu4vD8tN2eRYMdD9Zw24a_ww@mail.gmail.com>
In-Reply-To: <CAKwvOdmSp8PHj+iK5KT1XLC89gzu4vD8tN2eRYMdD9Zw24a_ww@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 12 Dec 2018 11:48:06 -0800
Message-ID: <CANA+-vC_5W1CZCe99nvM+3wXm=3riw980+3TyHMytP=7sZPEXA@mail.gmail.com>
Subject: Re: [PATCH] x86_64: Mark per-cpu symbols as absolute.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Bill Wendling <morbo@google.com>,
        Rafael Avila de Espindola <rafael.espindola@gmail.com>,
        Dmitry Golovin <dima@golovin.in>, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding appropriate people, lists.
On Tue, Dec 11, 2018 at 11:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Dec 10, 2018 at 4:57 PM Tri Vo <trong@android.com> wrote:
> >
> > From: Rafael Avila de Espindola <rafael.espindola@gmail.com>
> >
> > The kernel has many variables that it wants to have a copy for each
> > cpu. It is similar to how each thread wants a copy of a thread local
> > variable.
> >
> > To access such variable, the code has to find the offset of that
> > variable in the per cpu block and add it to the address of the current
> > brock for that cpu.
> >
> > Finding the offset is a problem. There are no relocations (at least on
> > X86_64) that compute the offset of a symbol in a section. To solve this
> > problem, the kernel linker script puts the .data..percpu section at
> > address 0. By doing this, the fake address is actually the offset.
> >
> > This means that symbols defined in that section are effectively
> > absolute. There is no way for the linker to guess that. So LLD complains
> > when linking the kernel:
> > ```
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:153: at least one side of the expression must be absolute
> > ld.lld: error: ./arch/x86/kernel/vmlinux.lds:154: at least one side of the expression must be absolute
> > Makefile:1040: recipe for target 'vmlinux' failed
> > ```
>
> This fixes the above error for me when linking with LLD with the
> previous patch you sent applied (I'm having trouble finding a public
> mailing list link though; 'x86_64: Add "-m elf_i386" when linking i386
> object files.').  Still looks like there's maybe 2 more unrelated
> issues to track down with LLD, but this gets us closer.
>
> To make sure this doesn't regress anything for ld.bfd, I triple
> checked a more standard build without LLD.
>
> ld.bfd (clang) + this patch:
> -rwxr-xr-x 1 ndesaulniers primarygroup 56931688 Dec 11 11:32 vmlinux
>
> ld.bfd (clang) w/o this patch:
> -rwxr-xr-x 1 ndesaulniers primarygroup 56931688 Dec 11 11:33 vmlinux
>
> ld.bfd (gcc) w/o this patch:
> -rwxr-xr-x 1 ndesaulniers primarygroup 54047232 Dec 11 11:34 vmlinux
>
> ld.bfd (gcc) w/ this patch:
> -rwxr-xr-x 1 ndesaulniers primarygroup 54047232 Dec 11 11:35 vmlinux
>
> so looks like no change in binary size w/ vs w/o this patch.
>
> Further, I did a boot test of ld.bfd (gcc) w/ this patch in QEMU. No
> issue there.  Thanks for sending.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Tell the linker that per-cpu symbols are absolute.
> >
> > Reported-by: Dmitry Golovin <dima@golovin.in>
> > Tested-by: Dmitry Golovin <dima@golovin.in>
> > Signed-off-by: Tri Vo <trong@android.com>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index 0d618ee634ac..ee3b5c7d662e 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -401,7 +401,7 @@ SECTIONS
> >   * Per-cpu symbols which need to be offset from __per_cpu_load
> >   * for the boot processor.
> >   */
> > -#define INIT_PER_CPU(x) init_per_cpu__##x = x + __per_cpu_load
> > +#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
> >  INIT_PER_CPU(gdt_page);
> >  INIT_PER_CPU(irq_stack_union);
> >
> > --
> > 2.20.0.rc2.403.gdbc3b29805-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
