Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93863C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430B320896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVrF+Ken"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430B320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeIZDW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:22:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34062 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeIZDW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:22:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so12081090pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nGcnp4srVdPA0TBGDKtv9XxaLlEgIWwiu9wfh448n8=;
        b=iVrF+KenXQZfAUQPvdcm3wgK0zQMfVEaNqtv96Bhd6OyCyQyaDTSWQKOiTcJ4z6AC2
         GsXHA07k6ny3s67ZY5cpDHsBxcMqbpVEtywabMBQju32Qpcc9QmcpSqX9EET1g873f9w
         tfNWNW/IoCK+/e4LOQIL3TL0E60YJzL72D70SUBDZhp6gxufSDzXMaScrwrob/V8yicP
         +a7slStYRj594wYM+2wcZJr5hOJ2HN4r7LlpgSZ/j6FyXHip3hDYcpjv2p6uwwEmyg1e
         YhjIr5gdvCLhWsSvQC262TlL66kAXYVVL0sVG+/zrudHr4pw0p+/8B4npIYEpF1SqWRO
         Cdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nGcnp4srVdPA0TBGDKtv9XxaLlEgIWwiu9wfh448n8=;
        b=sFsk09P+SABIR0I7lokd2wP9ROlY9Pm6kyIUWfep5vf92vQD0jJY/+M9yIlkF8ssmU
         CSiCJbubB8JSVeAtQinnB8Hvk5dyP9GUjWER62SlTe5Q75Lr0PjrXHSkA/FEKp2zntRV
         Allm2JAwQt6CHd1Lzfz1Ed3/OB9QTeqNapllG2diK1u4p1/GzDPPamGgx4k495qsI1Kt
         JHy+ajyrN0kJse76HM21gBgaPmaNjnlw6G57OUGK/ddr8iGBybY9jhCmyRtlSqMiOOc7
         Y8xRwDM2RU9xrddwiG0r+15sQri4Z+/UppWMbeVih+P2qVtdRa0iennLDjb2wA8dRIDP
         /gdg==
X-Gm-Message-State: ABuFfoiDoBb6IzaTgS+U+N3Htd5Pr9K+9dKjPKKqgT1zy1zeAsJ0RFmd
        ngVnicDzQ48o57EPxaHME70nFynbKRRg5NoqHlD1tw==
X-Google-Smtp-Source: ACcGV6032URy8uHcF7g21hN5IchsNWeZBDYDdxEJBesXaHa5Wjp2xzDKmXGkPUo0x/NjlqvqxwYOrhSasLXuVEDtR7s=
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr2562976pgm.225.1537910007557;
 Tue, 25 Sep 2018 14:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180907202618.258569-1-ndesaulniers@google.com>
 <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
 <20180925190829.GC15464@zn.tnic> <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
In-Reply-To: <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Sep 2018 14:13:16 -0700
Message-ID: <CAKwvOdmLSVH7EVGY1ExU1Fh_hvL=FUzhq-80snDfZ+QhCT2FOA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: define CC_HAVE_ASM_GOTO
To:     bp@suse.de
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 25, 2018 at 12:08 PM Borislav Petkov <bp@suse.de> wrote:
> >
> > On Tue, Sep 25, 2018 at 11:41:19AM -0700, Nick Desaulniers wrote:
> > > bumping for review.
> > >
> > > On Fri, Sep 7, 2018 at 1:26 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > Since this file steamrolls KBUILD_CFLAGS, we have to redefine these
> > > > symbols.

Orthogonally, do you know *why* this Makefile overwrites
KBUILD_CFLAGS?  We take great care to set various compiler flags in
the top level Makefile, so to reset them lower in the tree seems
troublesome on first glance.  Take for instance the fact that GCC
changed the default C standard from gnu89 to gnu11 in GCC 5.  So a
kernel dev with gcc 5+ is now building a kernel with some translation
units built as gnu89, and some as gnu11.

> >
> > Why do we have to redefine these symbols?
> >
> > I don't see arch/x86/boot/ using asm_volatile_goto() and
> > CC_HAVE_ASM_GOTO anywhere.
>
> They may not explicitly invoke asm_volatile_goto(), but many
> translation units under arch/x86/boot/compressed/ share this include
> path, triggering this warning:
>
> In file included from arch/x86/boot/compressed/misc.h:20:
> In file included from ./include/linux/elf.h:5:
> In file included from ./arch/x86/include/asm/elf.h:8:
> In file included from ./include/linux/thread_info.h:38:
> In file included from ./arch/x86/include/asm/thread_info.h:53:
> ./arch/x86/include/asm/cpufeature.h:150:2: warning: "Compiler lacks
> ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
> [-W#warnings]
> #warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to
> your compiler arguments"
>  ^
>
> specifically 6 instances from:
> In file included from arch/x86/boot/compressed/early_serial_console.c:1:
> In file included from arch/x86/boot/compressed/cmdline.c:2:
> In file included from arch/x86/boot/compressed/error.c:7:
> In file included from arch/x86/boot/compressed/kaslr.c:29:
> In file included from arch/x86/boot/compressed/kaslr_64.c:22:
> In file included from arch/x86/boot/compressed/misc.c:15:
>
> Note that the check in arch/x86/include/asm/cpufeature.h has the check:
>
> 143 #if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)
>
> so this is hidden from GCC.  I can include this information in the
> commit message for a v2 if you'd like?
>
> >
> > > > This will prevent warnings in source files in this directory
> > > > when Clang supports asm goto.
> >
> > This statement I can't grok either. Maybe I'm slow or maybe I need more
> > background info...
>
> We're in the process of adding asm goto support to Clang.  I'm helping
> test by working through compiling the Linux kernel with Clang for
> x86_64.  The patch set still has some kinks we're working out, but
> having this fix in place will make for smoother sailing once we're
> good to go, and we would appreciate having it.
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
