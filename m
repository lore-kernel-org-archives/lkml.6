Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFC421B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PT/UqOtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfBKTgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:36:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46044 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfBKTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:36:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so18988pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVzpvAJvjpQL4Es27inEggBpY91ag7jLqVqfEBJ5Hv4=;
        b=PT/UqOtZrV5FiiZaPUihmeuhLesoLtjN0rErln4Zs0u6nleLaElueFPUmJ3r3GH3sc
         0j7X4kgNAGrfshLqhtDusJt9xjDLbtnmeli9HDltkHn4bR3CBFM3XwJvXQyz2YD+HId1
         Z4THK6naCtDJbNGnB37k2onJYkhyeJYCnZuQ/VI5GQz2DWk1x0NmfdgvwyMjXusO2++u
         IvSRu3ABrBRD8El+xAfR5w9vDDDcd5oKTNI441JwHQ+bvguKfF2WFUXuY9NhcidMGiKI
         nL5Hkjh97W7cabtvccPHZnHrnvULCtbjF632RQcH1EWkVXXyc2tKXCgpM2+2NtqkPbt0
         /Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVzpvAJvjpQL4Es27inEggBpY91ag7jLqVqfEBJ5Hv4=;
        b=MnWiyTUAvH4pDK8vhbfrPtwz4McTirUaP0GyLPCgE9AiUTFp0QeFHCONy4BCqqMrM6
         cVCbhqNOXE9nLJfW0F9laCcHOsyMJp2wAUbHkSPd5WQmZ5Gdb58Tv7YYUZJGHn+PLFft
         hkHhIKL7QzZADMyG9qwzfjLOONghGh8SQCR2dbnHtWg53lfgb6wjf1rwVubkkXGA2b8y
         BCOwJa1gZnBGowEnKCURQMpFHJ9bZaZ5LxGAL6DLBc9XF/zm6jYdUyHTV4KXQ97/GPNJ
         dkuJvv5Wtjj1CAdpIcxbasN41DHGg+NJIST76E58HUr+Fr2LmlJTpI+LMRYO/SZu/OQ8
         DSOA==
X-Gm-Message-State: AHQUAuZkpAo5AtGtE16xcGKAmlE7apAhKALOQ9KQkXp47kARwze2/3Bc
        JosqHRbOuD176hUPxbAbc9ZMEGlaINULBG1sK9n3qQ==
X-Google-Smtp-Source: AHgI3IYSBIN4V47O/qBATiOootrjNvy5pLW8CkOF+aVkwvg4xLtoELclDDJvCLwYTff9cDI//pkDDN7MwxLEjNHGbQw=
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr39037584pll.217.1549913412530;
 Mon, 11 Feb 2019 11:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com> <20190208055059.GD9647@archlinux-ryzen>
 <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com>
 <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com> <CA+icZUV2NnXQxu57PeQgOjiQm_LMjfDKY+AJKn-K9i7gG6PAfQ@mail.gmail.com>
In-Reply-To: <CA+icZUV2NnXQxu57PeQgOjiQm_LMjfDKY+AJKn-K9i7gG6PAfQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Feb 2019 11:30:01 -0800
Message-ID: <CAKwvOdkapB7Epiv=X7rWSF5qD7R=F3JfgbdnT2UrhhA3Jt2b1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:05 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Feb 11, 2019 at 4:33 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> [ ... ]
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > > > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > ---
> > > > >  Makefile | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 0eae4277206e..6307c17259ea 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -502,6 +502,9 @@ endif
> > > > >  CLANG_FLAGS  += -no-integrated-as
> > > > >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > > > >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > > > > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > > > > +CLANG_FLAGS  += -fuse-ld=lld
> > >
> > > Sorry, Sedat reports [0] that this is not quite correct; if $(LD)
> > > matches LLD, then we need to set -fuse-ld=$(LD), not -fuse-ld=lld,
> > > since you may have lld installed as lld-7 or lld-8, for example:
> > > https://github.com/ClangBuiltLinux/linux/issues/358
> >
> >
> > Hmm, $(LD) might be a full path.
> >
> > Looks like Clang can take a full-path for -fuse-ld=,
> > but does it work for GCC?
> >
>
> Nope. GCC expects "-fuse-ld={bfd,gold,lld} ".
> Adding suffix "$-VER" was not recognized while building a
> llvm-toolchain, so I guess this will be the same for the Linux kernel
> side.

Well for now, let's add support for just `ld.lld` since a build of
llvm will create such a symlink.  If folks really need to
differentiate between different versions of lld, let's cross that
bridge when we get there.
-- 
Thanks,
~Nick Desaulniers
