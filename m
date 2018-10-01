Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06F3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181022084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CSWCXs5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181022084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJBBlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:41:21 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49115 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:41:20 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w91J1kuI028433;
        Tue, 2 Oct 2018 04:01:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w91J1kuI028433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538420507;
        bh=JdTeeUraUh6RfDZSlfVbmXUng5Nv7bacmyQB6o/ezFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CSWCXs5E8I3Ig8DZyuR+LGYIoi3g2KJTVnRKLQIE61GkN41U3+gbuJlkxHNNZ9S/H
         V4MSxBnOHp+DEYsGLwB1U1AtcX9DdR2PCBrQs0haKC5eK2u9sm4pkQYOIiR4i5yjvl
         uyz5usea9wPVjuF4HO2orC58ptseDA/LgaGcGR7JbaIaBAscvujMou8I3wjXWdAYO3
         iYlq6/UFHN6QIN1NYO+d/X2VrfIakPa80Fi969dQUYUpTfDzpIv042bDv6jCE+kfeX
         n6kJfc96aIfleHXYPGb0In6n+38Oggi/YuWSAfw7jVdx7vQcy0FC4R3xpkDDvB8WGe
         PtYwb3Nm4aO4w==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id v12-v6so8223947vsc.1;
        Mon, 01 Oct 2018 12:01:47 -0700 (PDT)
X-Gm-Message-State: ABuFfoh7Bfy3oOK1apUfvl1tor6UBOo3JfYWRiDULxcYv+3IYimHdpsS
        L+35Lm+wDpDk6Bg1CbsbaB9J7js9i9q/+zoqbSA=
X-Google-Smtp-Source: ACcGV62g83MXX+sZQIf4NcXtzj9IjTUJeMaO9PLw25M5xNGC5l885yz5uCNB3nzuog6lOK9kpC4xQmS1U9oeT2c2jqc=
X-Received: by 2002:a67:6146:: with SMTP id v67-v6mr4514099vsb.179.1538420505999;
 Mon, 01 Oct 2018 12:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
 <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com> <CAKwvOd=R1FN_nmR4Wkpb=nTt+v2f2+uWOcQCFoB+B1hWzCXCXA@mail.gmail.com>
In-Reply-To: <CAKwvOd=R1FN_nmR4Wkpb=nTt+v2f2+uWOcQCFoB+B1hWzCXCXA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 2 Oct 2018 04:01:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=2k=v6C9q4oGNWY3WjfswtD60NVEzgkF4ACkxNYjRug@mail.gmail.com>
Message-ID: <CAK7LNAT=2k=v6C9q4oGNWY3WjfswtD60NVEzgkF4ACkxNYjRug@mail.gmail.com>
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

Hi Nick,

2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 2:18 Nick Desaulniers <ndesau=
lniers@google.com>:
>
> On Mon, Oct 1, 2018 at 2:45 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > We have raised the compiler requirement from time to time.
> > With commit cafa0010cd51 ("Raise the minimum required gcc version
> > to 4.6"), the minimum for GCC is 4.6 now.
> >
> > This flag was added by GCC 4.6, and it is recognized by Clang and
> > ICC as well.
>
> This doesn't seem to be the case for Clang:
> https://godbolt.org/z/qesF5o
>
> Nacked-by: Nick Desaulniers <ndesaulniers@google.com>

Hmm, I tested this patch with pre-built Clang 6.0.1 / 7.0.0
downloaded from http://releases.llvm.org/download.html

Was this option dropped by clang 8 ?


>
> >
> > Let's rip off the cc-disable-warning switch, and see if somebody
> > complains about it.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 8a23fee..2627266 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -716,7 +716,7 @@ else
> >
> >  # These warnings generated too much noise in a regular build.
> >  # Use make W=3D1 to enable them (see scripts/Makefile.extrawarn)
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
> > +KBUILD_CFLAGS +=3D -Wno-unused-but-set-variable
> >  endif
> >
> >  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
Masahiro Yamada
