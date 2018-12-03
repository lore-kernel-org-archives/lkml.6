Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CDB214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="M5Ps/4Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CDB214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeLCKZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:25:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40703 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:25:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so13022093qtf.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOwRlFEtKUX0nfoeZ2XPbc477wBa9aEEuwSfpux+fcc=;
        b=M5Ps/4WlD8OWnqjLkvlE9jOoK4B/1n5XftBvYEP5DufCDRy6rLzqWfQ59gIcJ3O1uO
         eMjbm7qplwMDfhZsGqvqbdKtQASxbcqfmY47xUCDv801HJDxs/VRuoPEWetMDVBtKe9O
         H9wwAccrEEm0Ha9aqeDkMrR7UTCkZKkkKHvc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOwRlFEtKUX0nfoeZ2XPbc477wBa9aEEuwSfpux+fcc=;
        b=fgpq6SIWWH8z/swOvsh/NBqB/T72gMs7hZvdwnAv6H3CpxmESKiTsKJp71EgYtxZm3
         0rSRFkh96yrfMnLRbkUeiNVP4rIY8yWc5FXwT1aeLWccl5ZSMWENW96yTnfRn4+cpPTo
         NvP1L5eYtctm+OHKFcKIJ8K1Lc1vEaRlsCktrPVQi1RZuuxwaDSayz+5c1HWSJGd5CiX
         YZtffZdHpxJiO1UomIx29ggQm1U/s0kgKOE3fnltm5WNImePjQPdvZMxkvGMKjSgcgf/
         DGWfigk0rZv29noaetw7rs9wlrrF3v+Mhd6mHJv7iKFMo5wyofsupZb0S0QXahCrEomV
         9tXg==
X-Gm-Message-State: AA+aEWbeHiM54/+NabecAiQsLNHENPMgMKgO0MbK7MVa6/jsPo4iWE7j
        tith5ICo185nX/4DqYBKcPRVqpDjWaKAKHcUYXM=
X-Google-Smtp-Source: AFSGD/Uf27UBNgRJGqS5PdA5FZJL9TiF5oJTx8q3CD1OFjdv4rG5tkyf3M+ki8nQsSex7S8FlaAvWtc6WE+QB3LOHIQ=
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr14602422qts.266.1543832691764;
 Mon, 03 Dec 2018 02:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au> <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
In-Reply-To: <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 3 Dec 2018 20:54:40 +1030
Message-ID: <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, Jinsong Ji <jji@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 at 04:04, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Nov 1, 2018 at 5:45 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > We cannot build these files with clang as it does not allow altivec
> > instructions in assembly when -msoft-float is passed.
> >
> > Jinsong Ji <jji@us.ibm.com> wrote:
> > > We currently disable Altivec/VSX support when enabling soft-float.  So
> > > any usage of vector builtins will break.
> > >
> > > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > > I guess this is currently a limitation.
> > >
> > > Removing -msoft-float will make it work (and we are lucky that no
> > > floating point instructions will be generated as well).
> >
> > This is a workaround until the issue is resolved in clang.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> > Link: https://github.com/ClangBuiltLinux/linux/issues/239
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v2: fix typo in comment, thanks Jinsong
> >
> >  lib/raid6/Makefile | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> > index 2f8b61dfd9b0..7ed43eaa02ef 100644
> > --- a/lib/raid6/Makefile
> > +++ b/lib/raid6/Makefile
> > @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
> >
> >  ifeq ($(CONFIG_ALTIVEC),y)
> >  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> > +
> > +ifdef CONFIG_CC_IS_CLANG
> > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > +# enabled. A future release of clang will resolve this
> > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > +endif
>
> Hi Joel, thanks for this patch!  My same thoughts about
> CONFIG_CC_IS_CLANG vs cc-option from
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> apply here as well.  I don't feel strongly about either though.  What
> are your thoughts?

I'm not sure that we can test for this one with cc-option. The result
of having -maltivec with -msoft-float is a error about the internals
of clang, which isn't something that kbuild is set up to test for.

When clang is fixed to allow this combination we will still build this
code in the same way, so in that sense it fails "open".

Cheers,

Joel
