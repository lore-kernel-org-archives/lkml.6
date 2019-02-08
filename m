Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4161C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F7320855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UN95Xl9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfBHR1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:27:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38742 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:27:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so1996385plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXLTCFZ1HjRvBrlYWB6YjgU815gezHUat637vTCfepU=;
        b=UN95Xl9N9KKe/fX7/tfYXfC/qk/MpvTjl2b4ga7p8SZKFYIixmQLjM5KYB8QG/DKw4
         BUTUAbpTwdsg2Hq12LOSVVRFOIhGJPk9pynUUWru7thTfHDKaQUzX7GO35yRtyIbRD9g
         d0Y3ZCRJ4GWRRUZlGC46utuDpLDF7Lef9LSVg/JUixYGpwfw3Ebs4y9OPqP6Ps+IKx7H
         LrucdpIRnJjgJknvr4dGs40S5AlWezLo3nvyStOIJZ/zufdd9Qndyz/xhoKx11tRgQkk
         s316x5xOxooNaBGOILoQLjs08W16qMKWLgg+Ju32hy4Ea1EOjTTc45v4mJfipplhHjGt
         vpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXLTCFZ1HjRvBrlYWB6YjgU815gezHUat637vTCfepU=;
        b=fFbHBRsQkGRJJp279JVSPplQu1vunETaFKyGZ556WwUzdj+56+OWp3NWdlX5qtIiG6
         qKc/gihjjN7xDTKmM50fNYKqX0iZW1EtGsJYZefHQXqe7jN8j4whPGBMAHgDIsXnRRbY
         7/4Gkrh7+KwfylBqJNZcIl4EzF5ffJSyV8/VfgpIRVm7nw+GRC796OFvDMMZc1gSBOLQ
         tIZn9O8dz5cg2wjaYKBIRFb5mgjJfafChSBI6jmONKeVPD/cmXjSes0rbFQ3X8zp2NNA
         NlXYDtjkDiCkIrDFYbqhFi/634/yK5ahKj4LUmZ4AEORWszkS+AoCzuvWiy0ENEFOcd5
         JWWw==
X-Gm-Message-State: AHQUAuawviDMAgpD7B7tqGE/EFKffeuqfujS/RXroahhlwOZgl+J/PnO
        5AHAwG2ARKLsfmbswk9XJO35G+eoeI8TkeQaK5GVNQ==
X-Google-Smtp-Source: AHgI3IacxZ8O/7ZZsS7MDcTwTYcwe11XiXUKH4FPViqa8NGU9T+EcXvVIqCY3VfU16kF5vcSJRCASUJW4LzyjCgdPSY=
X-Received: by 2002:a17:902:8b81:: with SMTP id ay1mr17219420plb.320.1549646823136;
 Fri, 08 Feb 2019 09:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com> <20190208055059.GD9647@archlinux-ryzen>
In-Reply-To: <20190208055059.GD9647@archlinux-ryzen>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Feb 2019 09:27:19 -0800
Message-ID: <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sedat.dilek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:51 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Feb 07, 2019 at 02:01:51PM -0800, ndesaulniers@google.com wrote:
> > This is needed because clang doesn't select which linker to use based on
> > $LD but rather -fuse-ld=$(LD). This is problematic especially for
> > cc-ldoption, which checks for linker flag support via invoking the
> > compiler, rather than the linker.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 0eae4277206e..6307c17259ea 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -502,6 +502,9 @@ endif
> >  CLANG_FLAGS  += -no-integrated-as
> >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > +CLANG_FLAGS  += -fuse-ld=lld

Sorry, Sedat reports [0] that this is not quite correct; if $(LD)
matches LLD, then we need to set -fuse-ld=$(LD), not -fuse-ld=lld,
since you may have lld installed as lld-7 or lld-8, for example:
https://github.com/ClangBuiltLinux/linux/issues/358

> > +endif
>
> This section needs to be moved up above KBUILD_CFLAGS otherwise it never
> actually gets passed along.
>
> With that change, please add:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
> >  export CLANG_FLAGS
> >  endif
> >
> > --
> > 2.20.1.791.gb4d0f1c61a-goog
> >



-- 
Thanks,
~Nick Desaulniers
