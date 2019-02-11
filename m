Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A541C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE2D21B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nxt4AgJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbfBKPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:33:45 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48446 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfBKPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:33:39 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x1BFXXNi007774;
        Tue, 12 Feb 2019 00:33:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x1BFXXNi007774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549899214;
        bh=bJBBhfbcbvWKcdPNI7KUzncW0Z59m/08xoYItg1Tzmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxt4AgJcg2Gqph0uYtcvOF9BlIY6TJesAiVG2DZtkE2ABxD9XGkt4iJYxfCgWOt9o
         tDMdEXdHQqw1F1yA4N0qIu0Ex5r8LjbK4YurBJM6t4FyqAp3TrdShFSx1ETmB5SKTh
         O6oNBDRHIb1vfSPYfNQ3zkOZXx9qrHu1ZaPSW+FYKCYmbjLi3RcC1sYz6cyDDn6lhQ
         MTDbthB7h5I2QDAnyBLeescf9K4EEKcaOFXAPEKivA6Uhxkry7zAYVcLq5VxnL5JsE
         TnUJZ8uwq4LTNqq8+imboZXZV4oT1BY0l/nIA8JTR+1c8QgYValjm7UpbOYozW0bgo
         onevri3HVN/pw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id t13so6495434vsk.3;
        Mon, 11 Feb 2019 07:33:33 -0800 (PST)
X-Gm-Message-State: AHQUAuaN7tYUMNdz3ejJ6o7TSrF7AMurg7JHmRZGJ+iQlOOK7M9seN8P
        e0vBS3dST0l41kgGbWOEfL+AdWbx4HmmhTHEj6I=
X-Google-Smtp-Source: AHgI3IaJtzVlWxUxOO31z/EonPhuUiW/pjAbPbTJW3GRCNaYXpnqYVt6rqaEz+jslNcdDPGCz7uO5+jfEP+x+y6Z1VE=
X-Received: by 2002:a67:485:: with SMTP id 127mr15322649vse.54.1549899212779;
 Mon, 11 Feb 2019 07:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com> <20190208055059.GD9647@archlinux-ryzen>
 <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Feb 2019 00:32:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com>
Message-ID: <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 2:27 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Feb 7, 2019 at 9:51 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Feb 07, 2019 at 02:01:51PM -0800, ndesaulniers@google.com wrote:
> > > This is needed because clang doesn't select which linker to use based on
> > > $LD but rather -fuse-ld=$(LD). This is problematic especially for
> > > cc-ldoption, which checks for linker flag support via invoking the
> > > compiler, rather than the linker.

What do you mean by 'problematic' ?

I see no build error in
arch/arm64/kernel/vdso/Makefile, at least.

Clang uses BFD linker by default,
which may not match to the $(LD) passed in.

Is this what you mean?





> > > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 0eae4277206e..6307c17259ea 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -502,6 +502,9 @@ endif
> > >  CLANG_FLAGS  += -no-integrated-as
> > >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > > +CLANG_FLAGS  += -fuse-ld=lld
>
> Sorry, Sedat reports [0] that this is not quite correct; if $(LD)
> matches LLD, then we need to set -fuse-ld=$(LD), not -fuse-ld=lld,
> since you may have lld installed as lld-7 or lld-8, for example:
> https://github.com/ClangBuiltLinux/linux/issues/358


Hmm, $(LD) might be a full path.

Looks like Clang can take a full-path for -fuse-ld=,
but does it work for GCC?






> > > +endif
> >
> > This section needs to be moved up above KBUILD_CFLAGS otherwise it never
> > actually gets passed along.
> >
> > With that change, please add:
> >
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > >  export CLANG_FLAGS
> > >  endif
> > >
> > > --
> > > 2.20.1.791.gb4d0f1c61a-goog
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
