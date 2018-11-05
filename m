Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE281C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4972086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMyvzpDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4972086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbeKFDUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:20:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387651AbeKFDUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:20:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id j22-v6so4803060pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJirzculLSk5q3m7YlBP8o38DUdPeBuNIG5Fi2euPRE=;
        b=AMyvzpDVsy805XeIvLCqf/7hRBoNGNo2B+u+ZuxzBjYhG7DvkKkz3tsLVF0xwS8ZKB
         zacRiKG5mc3l6zjB86B8kb5c2XDNTea/RkDrVqP0xfOPLD54oUGULEIA229iAl2XcoT3
         5s0noaU1q1SLuunvoPpe8iFlCPhe0WWIKrEa5cSApLijdzP76hBcYcUZwbL0CdlkmZhY
         FHjoL1tVR2xZEuT5wZ3ZqeXEr4Vr2JM3DfITOXb1kxMbf6Ge1Fu17suQapFEQRprf7Wg
         fqcDstiSxkyziEoRyrwpjwtsIavhq+K8vcD/xtmY3oDaG6xxC6jl2k+kbpYrxiihfGRK
         QfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJirzculLSk5q3m7YlBP8o38DUdPeBuNIG5Fi2euPRE=;
        b=tYHTtrxDqPv/4d6pGQxZ/P8RXsAL8qmekzJAVP0UhWeZtuaMiM4Atw/ejjttUlARKh
         +pWmk+IUwg8HCiy7aj1sUghagRIKndWTJVBme5D3IbV9rKXykSg8+LHrfYS6G0puw3Zh
         eaKofxp9itgtT9IJfKsN4LkF3e7XWP6aIAQqnNVz6y+074ttMoGz3uzpdZUe+erxhpsE
         I3qhLvMKznc7Jcx61P0KQYDYPhohS3JDJz1REhuMNVTyH8jKf5pOA8NR/MuhJdu2Ku2p
         ENeHq/ANwwY0GIZsOQAMh1tO/uAL17hUyT8cn2isfDbMPH/R6hANuqzqRVxcxJfo2e7A
         jbwA==
X-Gm-Message-State: AGRZ1gLgBniAAUCkwTN3BkC7S8jseZ/FItm7Kt/+7c5qZyxQRHcgLICG
        CFy52Ma+BnAjAv10BfxSQkva1TE8/dJSKZlQK6V2BA==
X-Google-Smtp-Source: AJdET5d8ZVBA9vKFQ6mwGljOzTZiwZo8sUTcQ26ya9umPDTFzs4VoEB+h56toMmZuIHc0JxRp35TeY2WdG5SuGXMpaM=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr4550048pgf.302.1541440760891;
 Mon, 05 Nov 2018 09:59:20 -0800 (PST)
MIME-Version: 1.0
References: <1541386099-13118-1-git-send-email-yamada.masahiro@socionext.com>
 <a55e4534ef759585088a037e4cfd8468@agner.ch> <CAK7LNAT3ftcuNDfEhecMnfjG0Fkkh42wR7XQ1R9Tkr9OMrzAng@mail.gmail.com>
In-Reply-To: <CAK7LNAT3ftcuNDfEhecMnfjG0Fkkh42wR7XQ1R9Tkr9OMrzAng@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 5 Nov 2018 09:59:09 -0800
Message-ID: <CAKwvOdn1Shqc3nW6z0Ji_=4uMrOimhUbX3TRG7fQuysja64zog@mail.gmail.com>
Subject: Re: [PATCH] kbuild: consolidate Clang compiler flags
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chris Fries <cfries@google.com>, joel@jms.id.au,
        dja@axtens.net, Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 1:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, Nov 5, 2018 at 6:10 PM Stefan Agner <stefan@agner.ch> wrote:
> >
> > On 05.11.2018 03:48, Masahiro Yamada wrote:
> > > Add basic options for Clang such as --target, --prefix, --gcc-toolchain,
> > > -no-integrated-as to a single variable CLANG_FLAGS.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  Makefile | 13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 93315eb..58c838a 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -487,18 +487,17 @@ endif
> > >
> > >  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> > >  ifneq ($(CROSS_COMPILE),)
> > > -CLANG_TARGET := --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > +CLANG_FLAGS  = --target=$(notdir $(CROSS_COMPILE:%-=%))
> > >  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> > > -CLANG_PREFIX := --prefix=$(GCC_TOOLCHAIN_DIR)
> > > +CLANG_FLAGS  += --prefix=$(GCC_TOOLCHAIN_DIR)
> >
> > So this will expand later now, is this ok?
> >
> > --
> > Stefan
> >
> > >  GCC_TOOLCHAIN        := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> > >  endif
> > >  ifneq ($(GCC_TOOLCHAIN),)
> > > -CLANG_GCC_TC := --gcc-toolchain=$(GCC_TOOLCHAIN)
> > > +CLANG_FLAGS  += --gcc-toolchain=$(GCC_TOOLCHAIN)
> > >  endif
> > > -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> > > -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> > > -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> > > -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> > > +CLANG_FLAGS  += $(call cc-option, -no-integrated-as)
> > > +KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > > +KBUILD_AFLAGS        += $(CLANG_FLAGS)
>
>
> CLANG_FLAGS is expanded here because KBUILD_CFLAGS and KBUILD_AFLAGS
> are defined by using :=
>
> So, it should be OK, but turning CLANG_FLAGS into a simple variable
> will be a little more efficient since $(call cc-option, -no-integrated-as)
> is evaluated just once.
>
> (Or, this cc-option may not be necessary any longer.)
>
> Will send v2.

If the ultimate goal is not evaluate cc-option more than once,
removing cc-option from both KBUILD_CFLAGS and KBUILD_AFLAGS for clang
is the better approach; we always want those for clang
unconditionally. And if you by chance have an ancient version of clang
that doesn't support those flags, you wont be able to compile a kernel
anyways.  Eventually we want to get Clang's integrated assembler in
shape to be used to assemble the kernel, but I think we're a ways off
there still.


-- 
Thanks,
~Nick Desaulniers
