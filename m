Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6668AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30433218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJu1cE0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfBKQFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:05:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfBKQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:05:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so182256wmb.0;
        Mon, 11 Feb 2019 08:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=isK88eLBkgZCz+mq9eV6d8holQbqw/zSRKL8Krc/Qas=;
        b=dJu1cE0x8glkxeosBDR2lYkqys9OqHe1qx/br1JL+iFNMhFfxWv4/4bduM1w7k8cBS
         I1NEnAV0P4CRpfm/l3yEHYGMwOs/l4d7alSQ2hVkNmhUCP3a08WbVkE+VhAfDqW41hpX
         xAJug3MdEOf9BbWSsnLg/ns+r80Ob6zyu7ymHkswzWGOJ2mG6meaoD7oC8nXaZia9plG
         1a+WSI1eoT0GPcvblk2CBKFqm+CHOhIKmYm47LY4F8JpcF4hHWoNX9VPyRI4KPj1D6CV
         CRJ938Y16i9tR9b9LVzXJbGEheppAiOHlob91r24zPOcdYh2H6WD+BvBzc0Kax7B4eyf
         j3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=isK88eLBkgZCz+mq9eV6d8holQbqw/zSRKL8Krc/Qas=;
        b=HhH5fXR+SUNivIXxciJ/uLhwfHjf4gynXMOE1JJOf+oaOsGKhYmyqlFyVgYp5kCigf
         muqJo3cWvO0V7ZSik1Xir4qhRdyAA0towUzjmK0srnH5w/nikkLWq/UGiaXyRmdwuiGG
         J9gxVgHMb1gXVpUM3awaFbxt/ZfV6ks5PdlKy9jveR9WCZT3zzP+hBLfV7L885Pd7K4X
         cTxLaJmwj8wEx7xje2QOlENFLCAC50Mc4kLSUq1hVETbWqbsYLZ9x8fiwI72aPiTywQU
         kV803PyojB8kTUVSq2RBhuzq9URAmNnfts97+LKuE0iRu/mJJqqDrdC0C4Zof+y+NJZn
         d1Mg==
X-Gm-Message-State: AHQUAuZUTzOtT87YhsUxaD4S1vbVY4IXlcysJagAAUGGGtzqw0PgNKis
        /RX/UMc697BRUfeETnwd0zdDKg1Fja1HR6YfVJ3wxNq4N0g=
X-Google-Smtp-Source: AHgI3IZ9OMkOykoJ9FF+Gd0MPAoqAQk4eazCR1y7hkRGBeghZ4gVae7qNx4c4WvMIqPXFfClmgHTyh5mrRV+nl5z1j4=
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr143872wme.73.1549901133820;
 Mon, 11 Feb 2019 08:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com> <20190208055059.GD9647@archlinux-ryzen>
 <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com> <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 11 Feb 2019 17:05:22 +0100
Message-ID: <CA+icZUV2NnXQxu57PeQgOjiQm_LMjfDKY+AJKn-K9i7gG6PAfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:33 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
[ ... ]
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > ---
> > > >  Makefile | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 0eae4277206e..6307c17259ea 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -502,6 +502,9 @@ endif
> > > >  CLANG_FLAGS  += -no-integrated-as
> > > >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > > >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > > > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > > > +CLANG_FLAGS  += -fuse-ld=lld
> >
> > Sorry, Sedat reports [0] that this is not quite correct; if $(LD)
> > matches LLD, then we need to set -fuse-ld=$(LD), not -fuse-ld=lld,
> > since you may have lld installed as lld-7 or lld-8, for example:
> > https://github.com/ClangBuiltLinux/linux/issues/358
>
>
> Hmm, $(LD) might be a full path.
>
> Looks like Clang can take a full-path for -fuse-ld=,
> but does it work for GCC?
>

Nope. GCC expects "-fuse-ld={bfd,gold,lld} ".
Adding suffix "$-VER" was not recognized while building a
llvm-toolchain, so I guess this will be the same for the Linux kernel
side.

- Sedat -

[1] https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html
[2] https://github.com/ClangBuiltLinux/linux/issues/358
