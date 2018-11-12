Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB9EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8A4215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="S3XrCGZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8A4215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbeKLOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:14:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47068 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKLOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:14:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so11233013qkf.13;
        Sun, 11 Nov 2018 20:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVY2dT2YVwO0dKWfYBFbgGQ3c5QgDz+qnJHqdhsjtuw=;
        b=S3XrCGZSOm0EjKb5UMb6m2Pgd4GmXKXFqDOzI9RnpqHlgiYAGdUI1/R3n4enjrOX5E
         R7aYjyjXupapxRMKsI9dKit38mFFwP1CxSnGeigS+m72Ih5fm4vDZgdaSn1+scfYAuUE
         kBpCizHhpm2DfCo+2lOP3evazoIIv3l+WBRUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVY2dT2YVwO0dKWfYBFbgGQ3c5QgDz+qnJHqdhsjtuw=;
        b=CH2SnE1oPcOYXFEkPJ6XFA6vv0zlnFW/e7advSf1qjXGji/QMHNqFp0PoUwbgj4r8X
         DCMbSJonKJ8WTHQV3wFK4X3wuNSplCeB4bYNaY+MfNtXA+xgIdGhu6yKKN/aHDacdzpg
         +D5+pBUT71A/erfKitl5HMBfD902aA34lN65MxcmHqf2xnCoUdPM9H2fd6cxrRxserbV
         kN2pdmUA5gpszmln5XwrXCTpfxQbBF4sHzjC+W8l0IBxFAEmcXAUt9tsPsQFRdZ3xl6h
         U7RYJzSp6XB3KbMLBwdPiZmxSjP7gdOl2+YkuDXVsVgArO01uDNTq8KEWcA8FpscCP1b
         y6ow==
X-Gm-Message-State: AGRZ1gLmTdTpAi3gEokZLkUx81A0lJ24r9bF624gYebAD3I+dCpnQNmM
        jCN7uPJGd+KrSmbmWb5GYURwUGZsl8njdfDUoco=
X-Google-Smtp-Source: AJdET5dho5hBBEREWlkC4/4SRhQWXVL85nlBzJ2nuDfFsDLh3IjeCgEZs3My/7XyOmVXA9lS9nFqFzhtAOrhRHD0Wtg=
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr17951894qvr.85.1541996569443;
 Sun, 11 Nov 2018 20:22:49 -0800 (PST)
MIME-Version: 1.0
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
 <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=JwjVu=uk3egVJxTm9vPcF=Jx2Bexx1Wx=Z-PC38X3Uw@mail.gmail.com>
 <9c4868dd-82fa-aa5c-843e-e1f78ffbc7e2@google.com> <CAK7LNAR32=QWy4jss3M3VSNj0XY=tvgWWTG5ajVEpyYD2J+Z1Q@mail.gmail.com>
 <87pnvb9kc3.fsf@concordia.ellerman.id.au> <CAK7LNATsY3_wy8DL9+g+-AytY6mStwFoeA+CMQdVFkXZ2SKdyA@mail.gmail.com>
In-Reply-To: <CAK7LNATsY3_wy8DL9+g+-AytY6mStwFoeA+CMQdVFkXZ2SKdyA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 12 Nov 2018 14:52:37 +1030
Message-ID: <CACPK8XdkLBT0LWpo=5UZPcfmbrry4941wTULLs8KM4B_-UWPPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, ghackmann@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, stefan@agner.ch, mka@chromium.org,
        linuxppc-dev@lists.ozlabs.org,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        natechancellor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 at 13:59, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, Nov 12, 2018 at 10:05 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > > On Sat, Nov 10, 2018 at 3:35 AM Greg Hackmann <ghackmann@google.com> wrote:
> > >>
> > >> On 11/09/2018 10:29 AM, Nick Desaulniers wrote:
> > >> > On Mon, Nov 5, 2018 at 7:05 PM Masahiro Yamada
> > >> > <yamada.masahiro@socionext.com> wrote:
> > >> >>
> > >> >> Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
> > >> >> -no-integrated-as into a single variable CLANG_FLAGS so that it can be
> > >> >> easily reused in other parts of Makefile.
> > >> >>
> > >> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >> >> ---
> > >> >>
> > >> >> Changes in v2:
> > >> >>   - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway
> > >> >>
> > >> >>   Makefile | 13 ++++++-------
> > >> >>   1 file changed, 6 insertions(+), 7 deletions(-)
> > >> >>
> > >> >> diff --git a/Makefile b/Makefile
> > >> >> index da11700..e173a73 100644
> > >> >> --- a/Makefile
> > >> >> +++ b/Makefile
> > >> >> @@ -487,18 +487,17 @@ endif
> > >> >>
> > >> >>   ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> > >> >>   ifneq ($(CROSS_COMPILE),)
> > >> >> -CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
> > >> >> +CLANG_FLAGS    := --target=$(notdir $(CROSS_COMPILE:%-=%))
> > >> >>   GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> > >> >> -CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
> > >> >> +CLANG_FLAGS    += --prefix=$(GCC_TOOLCHAIN_DIR)
> > >> >>   GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
> > >> >>   endif
> > >> >>   ifneq ($(GCC_TOOLCHAIN),)
> > >> >> -CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
> > >> >> +CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
> > >> >>   endif
> > >> >> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> > >> >> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> > >> >> -KBUILD_CFLAGS += -no-integrated-as
> > >> >> -KBUILD_AFLAGS += -no-integrated-as
> > >> >> +CLANG_FLAGS    += -no-integrated-as
> > >> >> +KBUILD_CFLAGS  += $(CLANG_FLAGS)
> > >> >> +KBUILD_AFLAGS  += $(CLANG_FLAGS)
> > >> >>   endif
> > >> >>
> > >> >>   RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
> > >> >> --
> > >> >> 2.7.4
> > >> >>
> > >> >
> > >> > Thanks for this patch, Masahiro, it's a good simplification.
> > >> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > >> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > >> >
> > >> > Would you mind waiting for a tested-by from Stefan, and maybe an ack
> > >> > from Greg (added to cc)?
> > >> >
> > >>
> > >> Acked-by: Greg Hackmann <ghackmann@google.com>
> > >
> > >
> > > Thanks for your review!
> > >
> > >
> > > So, how to organize this series, and Joel's one together?
> > >
> > > I'd like Joel to use this series as a base for his work.
> > > (https://lore.kernel.org/patchwork/patch/1006696/)
> > >
> > > It will be much cleaner.
> > >
> > >
> > > Shall I merge all the patches to kbuild tree, or
> > > maybe will they go through powerpc tree?
> >
> > Joel's changes are fairly small so you may as well merge them along with
> > the rest of the series, if that's OK with you and Joel.
>
>
> OK, I will.
>
>
> Joel,
> If you send v2, I will merge it to kbuild tree.

Thanks, I've done that now.

Cheers,

Joel
