Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF06208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVCB+1Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF06208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJBChh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:37:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34014 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBChh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:37:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so10033300pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UwvTRIHYEEzIfvgEQWQQDEXO70ZETue4ghx7acE9HAU=;
        b=pVCB+1Sat9pPA4MeDw1JKpO+yA7fd3P+oyR5vSYuNMtvDqXPInO6HlH+dNYy9cdMZB
         rQl9DC9ZfNJdd9hvlw0rYKbti9P8WKH4x44Kn5OtnDUcfrNdeKthXf4iccpr/yttMF6S
         eS94xfSClnx0MZfOQN4Eb2qcVczyoa56wveyhFXUa9wy7JDRRHIW7IQexUS2afR5WRWa
         XU6fX2G8jc5XeFw44O61PMou4d2aRRimq/qxADnPCCRJ0EaS3X/cUfFBfu2T+KSA0moX
         LgXNUj7WvWUvcTtAZEMmkiZeThxA+sZzj/uZEF2b4PNjpgs6hX41ld/l7k2AudQ2jTOr
         w1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UwvTRIHYEEzIfvgEQWQQDEXO70ZETue4ghx7acE9HAU=;
        b=LMjmoPpyB4Y+stZ+MfYddWP1gqRvwTsIQodf/fqvR9Knr7QzbwuIGAz7h2pi/6dcNP
         4Afk+Qq/AJBYXtDV2T5sDV8oSt7Fz3OqJk6nsJlXtFvG0kRf5hEZaRpgN8Inh3V9jroE
         BPsoaHp6uGQ+5bPJyE8Jys+m0icoWHN2u+BL5Ju4abhsMUTBpW5e/L0BWcHmS88VFGSu
         otBXPiaMVwyj7JBoLxtmtE+h4IVJvKRzjGtrqfsbly6IBUmjA69GglORKEamjA9+KsbG
         JIT3P6wGAEujqO8e4LIw7foy88BOtSmX2eUy5ludAuJIvDpvv0QEJt5PBpBzbIAEyV2e
         DakQ==
X-Gm-Message-State: ABuFfojhg9upwK7G6JNTuu6LAIKyIw5HH+zaKUujMpAPrtK6jDV7hrit
        3BbhDW2mnzJAX0mHJsZaWrgLGm+4zOiLNeuddoT/AQ==
X-Google-Smtp-Source: ACcGV62RPFQQ8bwYsnBr+k5SBVzyyCr/zCFyVF49M6ICiYCyIgzM9yOwvaweFd7Sl5KCnZMD6wqXFVFdWoJVefCMSfY=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr11767181pgl.302.1538423891860;
 Mon, 01 Oct 2018 12:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com>
 <1538387078-21892-3-git-send-email-yamada.masahiro@socionext.com>
 <CAKwvOd=R1FN_nmR4Wkpb=nTt+v2f2+uWOcQCFoB+B1hWzCXCXA@mail.gmail.com> <CAK7LNAT=2k=v6C9q4oGNWY3WjfswtD60NVEzgkF4ACkxNYjRug@mail.gmail.com>
In-Reply-To: <CAK7LNAT=2k=v6C9q4oGNWY3WjfswtD60NVEzgkF4ACkxNYjRug@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 12:58:00 -0700
Message-ID: <CAKwvOdm9VA-MqM0M+m-y0On9jN3cfRZOHev_8PWc7TFTA9F3xg@mail.gmail.com>
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

On Mon, Oct 1, 2018 at 12:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Nick,
>
> 2018=E5=B9=B410=E6=9C=882=E6=97=A5(=E7=81=AB) 2:18 Nick Desaulniers <ndes=
aulniers@google.com>:
> >
> > On Mon, Oct 1, 2018 at 2:45 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > We have raised the compiler requirement from time to time.
> > > With commit cafa0010cd51 ("Raise the minimum required gcc version
> > > to 4.6"), the minimum for GCC is 4.6 now.
> > >
> > > This flag was added by GCC 4.6, and it is recognized by Clang and
> > > ICC as well.
> >
> > This doesn't seem to be the case for Clang:
> > https://godbolt.org/z/qesF5o
> >
> > Nacked-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Hmm, I tested this patch with pre-built Clang 6.0.1 / 7.0.0
> downloaded from http://releases.llvm.org/download.html
>
> Was this option dropped by clang 8 ?

From the Godbolt link above, it seems all versions of Clang do not
recognize this flag.  It doesn't look like the kernel sets
-Wno-unknown-warning-option to prevent this warning.  Can you please
triple check that compiling with Clang and this patch causes no
warnings?  I suspect something might be amiss then if this patch
doesn't produce warnings with Clang, since on the smaller Godbolt
example it does.

>
>
> >
> > >
> > > Let's rip off the cc-disable-warning switch, and see if somebody
> > > complains about it.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 8a23fee..2627266 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -716,7 +716,7 @@ else
> > >
> > >  # These warnings generated too much noise in a regular build.
> > >  # Use make W=3D1 to enable them (see scripts/Makefile.extrawarn)
> > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variabl=
e)
> > > +KBUILD_CFLAGS +=3D -Wno-unused-but-set-variable
> > >  endif
> > >
> > >  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Thanks,
~Nick Desaulniers
