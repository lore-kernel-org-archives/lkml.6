Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B904C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560720850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjkAZUF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeLCWzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:55:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34795 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeLCWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:55:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so7231277plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obRrg9rAKQUkvbX4DNcGu49eavX10jLobDBdHEgdouo=;
        b=IjkAZUF5Z3+b+H0hRs2KJJiEkImw364FYfRX1RfNTe4LO+brr9aAkGnKSAB3fO/XKd
         0YzhcKz5LyYfgQ22bnqhLejw+mPTlnHX8SJRxWpgu9ms6dRHb7GWinhlYxGMGMg43dlh
         8NnWVZOv7NTmvoJ92HalXpkzsaI2W1B3UKyOenYOAPFFo8KiRsYCPv6v3NnNRZK/7OVo
         mllQO8kH3aoRk80njWH9ON/9uHWRLXY9+hdu/M/DJWs/FLtqPiVUPzCROQkKTMAOMwqp
         322+2y/LFgHKcTcWTyAy92O1nA6lobkJOWksfnPU3qDnQJOydiA969KDovyfdCQUHvH3
         aPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obRrg9rAKQUkvbX4DNcGu49eavX10jLobDBdHEgdouo=;
        b=kClke6Lc8z4NfrRRp3d/NIY+l3+j31UrlM2tCpzngSLwFL7rHSpyi8VO1Lk1qqS7Is
         B2PHbRHT9qC5Rt7NwOQRkRQSpjH7Js0lt/g809tWctWZ1GfP3TM+tl0RbK5G7V3mwYpF
         fpqWnqfnj+ap7s4tyszmn1s1Z85AjJD3SipwRevwWv2lGt88g5V2FM6u3ffhJcX11AwA
         8NZbsh3c1511ehqZpO61DotW19o3HgzcPtsgej7Iswghn8jyVkPqXVIunpE9wUrgGO92
         r8CEE6slGf509zANqxmG16SE/sKgefMEqA3pCeIqMu/Tm4Mr5TgC5Pigr1R2SojC6OyC
         keCw==
X-Gm-Message-State: AA+aEWbhKnz7al+l4VrH8KYWE0yUDnK3FEFfRNruihc61k75rSl5gjQP
        slKTuXRV1qN1dSdhLD2d9H1wHblFb6vtjE81UCpxbA==
X-Google-Smtp-Source: AFSGD/W3qXwXJMsvkEYh7rj1gNeRHfyqwNLOcril4ge7vSKBbH8Kf2u9OvSQJLFmlnCrzy7qqMAqMfdCVJCigbpJWTc=
X-Received: by 2002:a17:902:820d:: with SMTP id x13mr18272982pln.229.1543877748297;
 Mon, 03 Dec 2018 14:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au> <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com>
 <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com> <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
In-Reply-To: <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Dec 2018 14:55:37 -0800
Message-ID: <CAKwvOdm953JFNaR6wMtDJDiwkaqXM83s2Qr=RFJ5OZAzeNQwEA@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 2:14 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 4 Dec 2018 at 05:15, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > +ifdef CONFIG_CC_IS_CLANG
> > > > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > > > +# enabled. A future release of clang will resolve this
> > > > > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > > > > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > > > > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > > > > +endif
> > > >
> > > > Hi Joel, thanks for this patch!  My same thoughts about
> > > > CONFIG_CC_IS_CLANG vs cc-option from
> > > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> > > > apply here as well.  I don't feel strongly about either though.  What
> > > > are your thoughts?
> > >
> > > I'm not sure that we can test for this one with cc-option. The result
> > > of having -maltivec with -msoft-float is a error about the internals
> > > of clang, which isn't something that kbuild is set up to test for.
> >
> > As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?
>
> The developer gets something like this:
>
> SplitVectorResult #0: t196: v16i8 = llvm.ppc.altivec.vcmpgtsb
> TargetConstant:i64<4823>, t146, t195
> fatal error: error in backend: Do not know how to split the result of
> this operator!
> clang-8: error: clang frontend command failed with exit code 70 (use
> -v to see invocation)
>
> >
> > >
> > > When clang is fixed to allow this combination we will still build this
> > > code in the same way, so in that sense it fails "open".
> > >

Eek, that means cc-option is not hardened against flags that crash the
compiler (misbehaving compiler).  We'll have to get some version check
in place should we ever want to use those flags for these object
files, but for now:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
