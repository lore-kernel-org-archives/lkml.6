Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B0DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DD2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D/rT3Fao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5DD2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeJBFEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:04:12 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42434 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBFEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:04:12 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w91MO3FM026845;
        Tue, 2 Oct 2018 07:24:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w91MO3FM026845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538432644;
        bh=APW72edIsf5za1McjeYIQhpOhdTX0xqRziHQwzpUJQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D/rT3FaoVCIGqA14EEFvPmoRoyV+GXb60hY+bNmEDVJhG9UcR/sX+ezVrBFjsEL4z
         vbbTZWK1lKhjKExlPFFY7j+H+n1ly8tZgmBWEyRbxPcrFmPRweR+ftmk4mbBIqxszW
         PSDG0SLRk2igClA8j1IpgAumyOBdZvqzFNZvepIfw+Qn03+QBnXCuqYICdItye1SNk
         n3XubqfE036kEmgxsTz0pQxVPijlVVgoeD+Qk/KwpN7qCo0ldkhyU20XcGAlZr1f+R
         yJw0YqG8970ymBuLZrRel0eEDr6OAKSYTnJe5KjnKrh2dPqH5dzsksQ21+OT0HsiAy
         XKLjK0TzVPM8g==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id w8-v6so8535840vsl.4;
        Mon, 01 Oct 2018 15:24:04 -0700 (PDT)
X-Gm-Message-State: ABuFfoh113BS6/IV3ezjtyxGFQEY+Rqfwlz7xQPcxPWswlKaWhjcmCBG
        Cw5GopKdYhpUMSEuFqKG1rCN2Q22oWeSdhH9RRQ=
X-Google-Smtp-Source: ACcGV63dwmk/cRDe8NzhBlecmEIYApqyZtWItgRT6EUND25KNzuM3oozYQbbGrzuma9WnFOLxGqiViaw68RXGONEVAI=
X-Received: by 2002:a67:6146:: with SMTP id v67-v6mr4806602vsb.179.1538432643286;
 Mon, 01 Oct 2018 15:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
 <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=R1FN_nmR4Wkpb=nTt+v2f2+uWOcQCFoB+B1hWzCXCXA@mail.gmail.com>
 <CAK7LNAT=2k=v6C9q4oGNWY3WjfswtD60NVEzgkF4ACkxNYjRug@mail.gmail.com> <CAKwvOdm9VA-MqM0M+m-y0On9jN3cfRZOHev_8PWc7TFTA9F3xg@mail.gmail.com>
In-Reply-To: <CAKwvOdm9VA-MqM0M+m-y0On9jN3cfRZOHev_8PWc7TFTA9F3xg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 2 Oct 2018 07:23:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARuyo89pK9Fmd4s6CG8yhjpmzmiOVrN1fGmWkSyHDbfgA@mail.gmail.com>
Message-ID: <CAK7LNARuyo89pK9Fmd4s6CG8yhjpmzmiOVrN1fGmWkSyHDbfgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: add -Wno-unused-but-set-variable compiler
 flag unconditionally
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 4:58 Nick Desaulniers <ndesau=
lniers@google.com>:
>
> On Mon, Oct 1, 2018 at 12:02 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Nick,
> >
> > 2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 2:18 Nick Desaulniers <nd=
esaulniers@google.com>:
> > >
> > > On Mon, Oct 1, 2018 at 2:45 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > We have raised the compiler requirement from time to time.
> > > > With commit cafa0010cd51 ("Raise the minimum required gcc version
> > > > to 4.6"), the minimum for GCC is 4.6 now.
> > > >
> > > > This flag was added by GCC 4.6, and it is recognized by Clang and
> > > > ICC as well.
> > >
> > > This doesn't seem to be the case for Clang:
> > > https://godbolt.org/z/qesF5o
> > >
> > > Nacked-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Hmm, I tested this patch with pre-built Clang 6.0.1 / 7.0.0
> > downloaded from http://releases.llvm.org/download.html
> >
> > Was this option dropped by clang 8 ?
>
> From the Godbolt link above, it seems all versions of Clang do not
> recognize this flag.  It doesn't look like the kernel sets
> -Wno-unknown-warning-option to prevent this warning.  Can you please
> triple check that compiling with Clang and this patch causes no
> warnings?  I suspect something might be amiss then if this patch
> doesn't produce warnings with Clang, since on the smaller Godbolt
> example it does.


I got it.

Clang does NOT recognize -Wno-unused-but-set-variable.

But, the code I changed is not parsed for clang.
That is why I did not see any problem with this patch.

See the following code.



ifeq ($(cc-name),clang)
KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specifier)
KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member)
# Quiet clang warning: comparison of unsigned expression < 0 is always fals=
e
KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as =
the
# source of a reference will be _MergedGlobals and not on of the
whitelisted names.
# See modpost pattern 2
KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
KBUILD_CFLAGS +=3D $(call cc-option, -fcatch-undefined-behavior)
else

# These warnings generated too much noise in a regular build.
# Use make W=3D1 to enable them (see scripts/Makefile.extrawarn)
KBUILD_CFLAGS +=3D -Wno-unused-but-set-variable
endif





--=20
Best Regards
Masahiro Yamada
