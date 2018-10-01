Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A02C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550B12084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwoE4yN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeJBFQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:16:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34254 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBFQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:16:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so337pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Br4vkg1TvGN7TrdNsoF4VUZ6dN4Ss79OeMvzuWPoHJw=;
        b=WwoE4yN1B8lv3/OGLdqJHEo+vbaT22oWWELI+kTDeDCOL/iGQFq5gTGK+8enLmE4y3
         ajPUX8nHOXSEQ94ok6mQ9GAAgssXdEijq+4BamAoQvzTfJ9Ub9Y4MvG/Nkr75BDKOfWV
         gzCFTSVC9AhjRDK8ihG5JdMLX5Yzqdv+UYdLq/P4GxvVYIq7kl/lq2mK70jjoKNy7cbm
         NubPoCUvScqK5/bZzd915C1OIk/HSN7mSGovl0BSQYb/cxwQNATcoqITmvcjEjQZzp8z
         ndAQ+fpwdrJHfkwBrBsxPdBYlBadrKEGMJ3LXrlGZ5hNuuF6/90wNdIrY9IK97WzHhzz
         AILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Br4vkg1TvGN7TrdNsoF4VUZ6dN4Ss79OeMvzuWPoHJw=;
        b=aqdeUb6tJ8MuraL8aP5Lj7DEhUjS27j4+aSG3yjGEKO49VXijarT2W3T3yRiWDIaUo
         zHpxLBdnVymXtiuHceLv53+IMpLCHVcVwDUl87UBIbPHkfqjIFduVDVSg1PRyjr9gVdB
         dXZnaLmUZ6k0FDpab2cn3l9P0/0HxgnRu5LHCnQlubaZ1kp/XCnz5WgZApVNDwuqcYrJ
         2eAi4GaI7PIebW58Gu3nrOtmvHBM++OKI2bhcNKz0E/PRpBSp43fQH8zqVagykegEQuE
         jfBtp+qzNbFj8G9FhnrIN/CtdTCcHsKmcq5S4+C1keOrf/p3ka96bH+YiF5FmWcgKdBk
         hqeg==
X-Gm-Message-State: ABuFfogJcXrVOzWGF6hg3rljdiC1YgDBfDVkJr7K6Z2nhrUGtbhFQLaW
        IMadNYBqSvChJUmaab3mQEnBcgrxtb2R4QTQPz6G2w==
X-Google-Smtp-Source: ACcGV625fmuKGnHsrKSeB7whu2aFaWOFOsKIVWmj9OZVjvmd9H9mh2vjuUxGt/RKYHwFJApvWXHdK7s73+nIJGjnYj8=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9-v6mr7644995plz.320.1538433412845;
 Mon, 01 Oct 2018 15:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
 <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=R1FN_nmR4Wkpb=nTt+v2f2+uWOcQCFoB+B1hWzCXCXA@mail.gmail.com>
 <CAK7LNAT=2k=v6C9q4oGNWY3WjfswtD60NVEzgkF4ACkxNYjRug@mail.gmail.com>
 <CAKwvOdm9VA-MqM0M+m-y0On9jN3cfRZOHev_8PWc7TFTA9F3xg@mail.gmail.com> <CAK7LNARuyo89pK9Fmd4s6CG8yhjpmzmiOVrN1fGmWkSyHDbfgA@mail.gmail.com>
In-Reply-To: <CAK7LNARuyo89pK9Fmd4s6CG8yhjpmzmiOVrN1fGmWkSyHDbfgA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 15:36:41 -0700
Message-ID: <CAKwvOdm9jMAC0sS6hJfCzvZ4B=a6FCQxx2_+GW3Od1NmqdT-kw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: add -Wno-unused-but-set-variable compiler
 flag unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 3:24 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 4:58 Nick Desaulniers <ndes=
aulniers@google.com>:
> >
> > On Mon, Oct 1, 2018 at 12:02 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > Hi Nick,
> > >
> > > 2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 2:18 Nick Desaulniers <=
ndesaulniers@google.com>:
> > > >
> > > > On Mon, Oct 1, 2018 at 2:45 AM Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > > >
> > > > > We have raised the compiler requirement from time to time.
> > > > > With commit cafa0010cd51 ("Raise the minimum required gcc version
> > > > > to 4.6"), the minimum for GCC is 4.6 now.
> > > > >
> > > > > This flag was added by GCC 4.6, and it is recognized by Clang and
> > > > > ICC as well.
> > > >
> > > > This doesn't seem to be the case for Clang:
> > > > https://godbolt.org/z/qesF5o
> > > >
> > > > Nacked-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > Hmm, I tested this patch with pre-built Clang 6.0.1 / 7.0.0
> > > downloaded from http://releases.llvm.org/download.html
> > >
> > > Was this option dropped by clang 8 ?
> >
> > From the Godbolt link above, it seems all versions of Clang do not
> > recognize this flag.  It doesn't look like the kernel sets
> > -Wno-unknown-warning-option to prevent this warning.  Can you please
> > triple check that compiling with Clang and this patch causes no
> > warnings?  I suspect something might be amiss then if this patch
> > doesn't produce warnings with Clang, since on the smaller Godbolt
> > example it does.
>
>
> I got it.
>
> Clang does NOT recognize -Wno-unused-but-set-variable.
>
> But, the code I changed is not parsed for clang.
> That is why I did not see any problem with this patch.
>
> See the following code.
>
>
>
> ifeq ($(cc-name),clang)
> KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
> KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specifier)
> KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
> KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member)
> # Quiet clang warning: comparison of unsigned expression < 0 is always fa=
lse
> KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
> # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, a=
s the
> # source of a reference will be _MergedGlobals and not on of the
> whitelisted names.
> # See modpost pattern 2
> KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
> KBUILD_CFLAGS +=3D $(call cc-option, -fcatch-undefined-behavior)
> else
>
> # These warnings generated too much noise in a regular build.
> # Use make W=3D1 to enable them (see scripts/Makefile.extrawarn)
> KBUILD_CFLAGS +=3D -Wno-unused-but-set-variable

Ah! I see, it's in the else part of an if clang check.  Ok, in that
case I think the commit message can be cleaned up with this detail,
then I'd be happy to sign off on it.  Sorry I didn't notice that
before.

> endif
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Thanks,
~Nick Desaulniers
