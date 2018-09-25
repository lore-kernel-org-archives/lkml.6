Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD297C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C2420842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlEW7z11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C2420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeIZDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:17:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40683 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZDRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:17:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so5569424pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQXJkA8eWdQST0xgU1XUeqNLapGHHSegYHRAMocC5t0=;
        b=VlEW7z11QyetOilyXhr2lEzxywf2kAzTqy8iB76VPRgXhfe/E9NUMySAzYFQnNiNLN
         7Gr10kaC7PjN9eFn3igrFKd8gVYMZYr+ped8erdVBAjJDurLg8OqB+zILe02INa3O9tQ
         M8Atyk0ewYw2InHI9mgJ0MU3cD2eQoSvJBDkZHeWCj76+GCT7nQk9742ThFeLoiwSevh
         bbU8tKpK3DlZxLrTVyVxHIf6/f+hdgSq68scFPEp7K9oqnFkpC95dMoADv01+MhZc8D0
         cxfealhm6CyQgUgOvTGw9e+tNrJ9LkUQP3jKh2Fu62r3l3S1l7dZZvZsLoVoqMMR1uov
         ObGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQXJkA8eWdQST0xgU1XUeqNLapGHHSegYHRAMocC5t0=;
        b=g4LsdpnNt1K4Ff8NG5pGFs1kwPx6bJpMDqS2GJJWk3Wxt681osPiRn8DPCnRH0qc+6
         vo8Kh6uxnL+KF3IajUNqB9/CKwzaVbiTfbcH+e0Jw2DQuTq/nnNTJObsLZoDvndG5EHl
         O57OoRnL4QTvV8yVqfb/ARcTdD8AK6NRLo+BglltFj5JkenneobnzqQ2LgUH3tTFm4Vg
         Oy3BNMkesFOCUn01TM0Jhg9FEtXzx8JcpFtVY6Jr/25GMtgLV11ksR6a2KEYV/K3IMFZ
         /QpMNSJIMEJ5cn1Z57+TtHqhNUUx32lGmJPJCqXjMtfK3k7U2vzOirmqj8fMjkIfj9x0
         C+8w==
X-Gm-Message-State: ABuFfog/LJgKWa13bDr8yQGBDImCzAiFe4l5zL11/73/uoNMeewUuoKM
        fbBbaRMhMrO9FO/RuNnVNHNjvCw2T73JisSyJ+9JQQ==
X-Google-Smtp-Source: ACcGV60vIvGY9MJEuuOUSwn7Am3DNAbtbscasUJBUooHIi09HdGANjr9KPGnbH7zI3RLhlsE7rqYrzK17B1ApGIXM7s=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr2920908pfi.174.1537909695499;
 Tue, 25 Sep 2018 14:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180907202618.258569-1-ndesaulniers@google.com>
 <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com> <20180925190829.GC15464@zn.tnic>
In-Reply-To: <20180925190829.GC15464@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Sep 2018 14:08:04 -0700
Message-ID: <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
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

On Tue, Sep 25, 2018 at 12:08 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Tue, Sep 25, 2018 at 11:41:19AM -0700, Nick Desaulniers wrote:
> > bumping for review.
> >
> > On Fri, Sep 7, 2018 at 1:26 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Since this file steamrolls KBUILD_CFLAGS, we have to redefine these
> > > symbols.
>
> Why do we have to redefine these symbols?
>
> I don't see arch/x86/boot/ using asm_volatile_goto() and
> CC_HAVE_ASM_GOTO anywhere.

They may not explicitly invoke asm_volatile_goto(), but many
translation units under arch/x86/boot/compressed/ share this include
path, triggering this warning:

In file included from arch/x86/boot/compressed/misc.h:20:
In file included from ./include/linux/elf.h:5:
In file included from ./arch/x86/include/asm/elf.h:8:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
./arch/x86/include/asm/cpufeature.h:150:2: warning: "Compiler lacks
ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
[-W#warnings]
#warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to
your compiler arguments"
 ^

specifically 6 instances from:
In file included from arch/x86/boot/compressed/early_serial_console.c:1:
In file included from arch/x86/boot/compressed/cmdline.c:2:
In file included from arch/x86/boot/compressed/error.c:7:
In file included from arch/x86/boot/compressed/kaslr.c:29:
In file included from arch/x86/boot/compressed/kaslr_64.c:22:
In file included from arch/x86/boot/compressed/misc.c:15:

Note that the check in arch/x86/include/asm/cpufeature.h has the check:

143 #if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)

so this is hidden from GCC.  I can include this information in the
commit message for a v2 if you'd like?

>
> > > This will prevent warnings in source files in this directory
> > > when Clang supports asm goto.
>
> This statement I can't grok either. Maybe I'm slow or maybe I need more
> background info...

We're in the process of adding asm goto support to Clang.  I'm helping
test by working through compiling the Linux kernel with Clang for
x86_64.  The patch set still has some kinks we're working out, but
having this fix in place will make for smoother sailing once we're
good to go, and we would appreciate having it.

-- 
Thanks,
~Nick Desaulniers
