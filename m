Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CBF2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpvNoSUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CBF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLCSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:45:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38551 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLCSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:45:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so6911085plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz4RpNkAFts865UAXW8DwCyoEd+dqjleopIGrH/AuTc=;
        b=MpvNoSUAkZNzT9UDKsFED7+PSWmlGIKGTyin/3c6lY09+HFuDaQiWQZlGcbjXfjrKM
         d3tveLhB+nGuR45U8IoYFsgJfykUgiwxWmXc5D1UzwwviIw1QKD4HPyWI8aJZnP7pin9
         QN6Gwoim2yL0kCFeAO71NeL4r5SSUkypfyUyYf5+ZTuzCNnBUOj1RhgGYnpGU8w30r6P
         FVFtLNtynLG253MLslHNvI9r1gHvQnX1h3dTzE8VlS8wtjmYhHhi0IK31sVW1H2AmMmo
         uhUO5gJW9c4XLYzMi8xWDD7TSi9RyIbeux5xTzu8j6CbawpKsLAfqYpjA4bn7LJr9uvM
         SFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz4RpNkAFts865UAXW8DwCyoEd+dqjleopIGrH/AuTc=;
        b=d0XTOnnv/kcH+HJnfm1EIDj+0KJfe9ATPNhvfOFUc8ndux+e8++7Inuf4uD6It0cJH
         5aoXdYxnxsB3amaGbkNU1ejK8vWxGG1WWt75ihBJGmM+mStlfBDckJJGV8D7GhO7jbJP
         NCVr2S6x9WH1ia/NO1pWnbgWoZiz7EEv38sqSc/Me0NwgfhEdPVSWLeBrJXlPN6v2fYS
         zpQjHnfxqDCxiaMxpM327k6HMsg/CxEl6VAD2uet/x+eih2DpyOwfdqgcKwHqjN0TTnH
         qby6nd3bcGRMBwKt3AFI0+Xw40ZV0Jm3iBd1C3BLxPJP64dcJxxIH9JGC5BZ4aa/Omax
         eWlw==
X-Gm-Message-State: AA+aEWbM2qu7/7Wy4f6+0uy+y4TbgZCpjo/gVWEPMIdns0T85q65Yy5c
        zD2HjPYB4gZLLkwb4ebnyu6uoFVw8DfsHb49pT5prFsWyWg=
X-Google-Smtp-Source: AFSGD/UyFqTohNcPZfT+W/QTh6VZmuq/cE0JrDEfs+Q4pUtX4iT0u0B6XCvx2oumEIfzz5lmOmcv2l8nb5iIVvCnpzk=
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr16898432plb.238.1543862712734;
 Mon, 03 Dec 2018 10:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au> <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
In-Reply-To: <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Dec 2018 10:45:01 -0800
Message-ID: <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To:     joel@jms.id.au
Cc:     mpe@ellerman.id.au, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, jji@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 2:24 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Sat, 3 Nov 2018 at 04:04, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Thu, Nov 1, 2018 at 5:45 PM Joel Stanley <joel@jms.id.au> wrote:
> > >
> > > We cannot build these files with clang as it does not allow altivec
> > > instructions in assembly when -msoft-float is passed.
> > >
> > > Jinsong Ji <jji@us.ibm.com> wrote:
> > > > We currently disable Altivec/VSX support when enabling soft-float.  So
> > > > any usage of vector builtins will break.
> > > >
> > > > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > > > I guess this is currently a limitation.
> > > >
> > > > Removing -msoft-float will make it work (and we are lucky that no
> > > > floating point instructions will be generated as well).
> > >
> > > This is a workaround until the issue is resolved in clang.
> > >
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/239
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > ---
> > > v2: fix typo in comment, thanks Jinsong
> > >
> > >  lib/raid6/Makefile | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> > > index 2f8b61dfd9b0..7ed43eaa02ef 100644
> > > --- a/lib/raid6/Makefile
> > > +++ b/lib/raid6/Makefile
> > > @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
> > >
> > >  ifeq ($(CONFIG_ALTIVEC),y)
> > >  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> > > +
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > +# enabled. A future release of clang will resolve this
> > > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > > +endif
> >
> > Hi Joel, thanks for this patch!  My same thoughts about
> > CONFIG_CC_IS_CLANG vs cc-option from
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> > apply here as well.  I don't feel strongly about either though.  What
> > are your thoughts?
>
> I'm not sure that we can test for this one with cc-option. The result
> of having -maltivec with -msoft-float is a error about the internals
> of clang, which isn't something that kbuild is set up to test for.

As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?

>
> When clang is fixed to allow this combination we will still build this
> code in the same way, so in that sense it fails "open".
>
> Cheers,
>
> Joel



-- 
Thanks,
~Nick Desaulniers
