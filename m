Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1BCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2519A2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6+R0IfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2519A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeI1EiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:38:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41297 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeI1EiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:38:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so2843922pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSdJ15AqAQ4ze7H3W/naI0ZfU4iBDtCsrCH7owOzOoE=;
        b=c6+R0IfJ5PBjHo1KoYNXbpReHszZDp5S/uI+/CsAilU60YXvNktNuhDFhi8ukRMWGR
         NuGYsavAAkBcHdgjqh3y2RVFrkvJjsEFhobtRAVyEvV+vuokhgVJDolgsf7FNZ6YmizP
         asBeIG7SqJa73H77Wa3Nl2owIMdrQzirDfiN79kI6iG04jfONB30Csx7C66mkKXCqnP5
         1mCn7AIqDU4Qj62MP5WA7HTprOddn68VdzGwG6NrySDhH9bQ/RlrLY85SGGZzBBf5YGl
         gvEB1klOjBVF/WRTQ51sdWK0ESA5rMrPLh6oF+HIRWHq9Ccryg8f4Kj7OS3Iny2gHVZd
         uWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSdJ15AqAQ4ze7H3W/naI0ZfU4iBDtCsrCH7owOzOoE=;
        b=l2THFYQ9nhgnVXDWsLU5JtFgv8goXJttTzLWp9qUqQEjB29DndKSSL+6ky4v+WPLgD
         GtwFthgSjxZgzcE+xZF+t6PiYADEHeXR6MkZskhY0P1zjedoL/LuAc/xlnslN38o0kOR
         l7KTCGbJyUoLYs6rCE90EddzTE1Q2HJX4dgDSxh/Cg6LAuWfPik8wVcH2xf53LhmRPVo
         JBzwy4D0ZnQqpaAzbMjmG6Ay/dA6bLyX9k4Fm2R8RuzTFOHESuMQHlB8retQHLVqNB8e
         rl+1VUX4U5rv4c0H4W6QKG0OBr+0aPNcvg0atDMvlfw1h/blueXmoAxbz7saNYEaKVaw
         JoXg==
X-Gm-Message-State: ABuFfoiB+iQ3v/lnBj59J+4xwz9AVtZdYWqYn/STRogveqiufvIRmozx
        Izw2FbADJV5/16wwbG+SvE38nH89+L9FdDkrIrIo/Q==
X-Google-Smtp-Source: ACcGV63L3sR4i1PtpYM/2lWSdFEMNJtIEr3ZIqyb7w73EsUgMwky7uMUdiwg0EDKui6yxfxB1PJ0SsqbPtsXjg7fuMA=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr12438282pgl.302.1538086673279;
 Thu, 27 Sep 2018 15:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180927204800.32210-1-ndesaulniers@google.com> <20180927215148.GE19687@zn.tnic>
In-Reply-To: <20180927215148.GE19687@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 15:17:41 -0700
Message-ID: <CAKwvOdmXcztP542kADhyJYN2=Fk3qyXif_MCs=kqPGE8QtTjvQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot: define CC_HAVE_ASM_GOTO
To:     bp@alien8.de
Cc:     mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 2:51 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Sep 27, 2018 at 01:47:58PM -0700, ndesaulniers@google.com wrote:
> > Early prototypes of Clang with asm goto support produce 6 instances of
> > the following warning:
> >
> > In file included from arch/x86/boot/compressed/misc.h:20:
> > In file included from ./include/linux/elf.h:5:
> > In file included from ./arch/x86/include/asm/elf.h:8:
> > In file included from ./include/linux/thread_info.h:38:
> > In file included from ./arch/x86/include/asm/thread_info.h:53:
> > ./arch/x86/include/asm/cpufeature.h:150:2: warning: "Compiler lacks
> > ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
> > [-W#warnings]
> > your compiler arguments"
> >  ^
> >
> > Since 6 files under arch/x86/boot/compressed/ include
> > arch/x86/boot/compressed/misc.h AND
> > arch/x86/boot/compressed/Makefile happens to redefine KBUILD_CFLAGS,
> > which set these variables in the top level MAKEFILE.
> >
> > Suggested-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > v1 -> v2:
> >   Updated commit message to provide more context as per Borislav.
> >
> >  arch/x86/boot/compressed/Makefile | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 28764dacf018..158c0b4e178a 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -56,6 +56,13 @@ KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> >  endif
> >  LDFLAGS_vmlinux := -T
> >
> > +# check for 'asm goto'
> > +ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
> > +  CC_HAVE_ASM_GOTO := 1
> > +  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> > +  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
> > +endif
>
> I would still like to know why can't we do the -D_SETUP thing here:
> https://lkml.kernel.org/r/20180926090841.GC5745@zn.tnic

That's another case that I look at and wonder "why does this exist?"
The _SETUP guard exists in only one place:
$ grep -rP 'ifdef\s+_SETUP'
arch/x86/boot/cpucheck.c:#ifdef _SETUP

which is already under arch/x86/boot/. arch/x86/boot/Makefile
unconditionally sets -D_SETUP, so what/who are we guarding against?
Looks like a guard that's ALWAYS true (and thus could be removed).

>
> instead of polluting this Makefile with defines which are not really
> needed in the compressed kernel build, except to silence build warnings.
>
> I mean, we can perpetuate that ugly hack and do:
>
> #define __BPF_TRACING__
>
> here in arch/x86/boot/compressed/misc.h which we could kill once clang
> can do asm goto...

Or, or... we don't redefine KBUILD_CFLAGS in arch/x86/boot/Makefile
(or any Makefile other than the top level one), and simply filter out
the flags we DONT want, a la:

drivers/firmware/efi/libstub/Makefile:
 16 cflags-$(CONFIG_ARM64)    := $(subst -pg,,$(KBUILD_CFLAGS)) ...

ie, using Make's subst function to copy KBUILD_CFLAGS, filter out
results, then use that for cflags-y.
https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

I'm curious to know Masahiro's thoughts on this?  I can't help but
shake the feeling that reassigning KBUILD_CFLAGS should be considered
an anti-pattern and warned from checkpatch.pl.  For the reasons
enumerated above AND in v1:
https://lore.kernel.org/lkml/CAKwvOdmLSVH7EVGY1ExU1Fh_hvL=FUzhq-80snDfZ+QhCT2FOA@mail.gmail.com/
(though there may be additional context from hpa answering
https://lore.kernel.org/lkml/20180926090841.GC5745@zn.tnic/).

Relying on the compiler's default/implicit C standard (which changed
in gcc 5) for parts of the kernel but not others I feel like should be
a big red flag.

Shall I prototype up what such a change might look like (not
reassigning KBUILD_CFLAGS in arch/x86/boot/Makefile)?  Maybe it's
harder/uglier than I imagine?
-- 
Thanks,
~Nick Desaulniers
