Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2261920870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YtV5r3l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2261920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbeKTL5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:57:52 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48906 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:57:51 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wAK1V9P2027970
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:31:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAK1V9P2027970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542677470;
        bh=qCUhewSzIc2GeOtflP1a7oilJ1RZJ0wDQCNS/6YM6Yg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YtV5r3l2kkWeDtL2eGy0VyB6iZYp/HmBsdRlqvcknkJRJwLhY24MM2G6kXbYWKl2J
         KGlWnd6D8hsDsiZuBL+5Gn7jMX87ZttYRAht7L9v2wbLD+aoNeTu10AT7wMdIuoBFO
         Lc8TKnkZVSiTnMpXgm7BjBEMy+L+ryuisJ1QCm1pC0TjVbTDlZLAfvIoIa9CHU8fM+
         0gXP5olJB9zh5vEmXkyi8sAXnfTvtFDFlb7VVtXx3FbLX35VnFqjX1vqGBHUK5K4SC
         b3H00+HXP2gngT49v07ROk3zVjTa16jJpEdyiWt1NHs6fFOoWJfptB+NNA2xfZWo6E
         CQrODutR+MxIA==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id z11so85817uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 17:31:10 -0800 (PST)
X-Gm-Message-State: AA+aEWZSJD9yMT4aRnlS/yoM+eYjTQ32NGbbdZTRSpY91xTr65ER1ndQ
        gzXEUI+b31kB8WuRVWdoi11L3dG3fBL+vYuyh1w=
X-Google-Smtp-Source: AFSGD/X3tikce7l6zz7DnotMNJTvdVs9aHWAiQWIByGTF9EsIbSZYBzsOeoZvAMcqUZaPLxxky9rPS0SWN+GRKpeXVg=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr26427uaj.42.1542677469177;
 Mon, 19 Nov 2018 17:31:09 -0800 (PST)
MIME-Version: 1.0
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
 <1542623503-3755-3-git-send-email-yamada.masahiro@socionext.com>
 <20181119123732.zcb6axl25bixgtly@ltop.local> <CAKwvOdk7WAeLPibZojsPFjvnnWWL8xE0D8=SxxWjNeoO3EY9rQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk7WAeLPibZojsPFjvnnWWL8xE0D8=SxxWjNeoO3EY9rQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 20 Nov 2018 10:30:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUgKUa+h_YuD+dyrBVB6aCw-QbJNe8MTQC9yc3MzwZPw@mail.gmail.com>
Message-ID: <CAK7LNASUgKUa+h_YuD+dyrBVB6aCw-QbJNe8MTQC9yc3MzwZPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] build_bug.h: remove most of dummy BUILD_BUG_ON
 stubs for sparse
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 3:02 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Nov 19, 2018 at 4:37 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Mon, Nov 19, 2018 at 07:31:43PM +0900, Masahiro Yamada wrote:
> > > The introduction of these dummy BUILD_BUG_ON stubs dates back to
> > > commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
> > > for sparse").
> > >
> > > At that time, BUILD_BUG_ON() was implemented with the negative array
> > > trick *and* the link-time trick, like this:
> > >
> > >   extern int __build_bug_on_failed;
> > >   #define BUILD_BUG_ON(condition)                                \
> > >           do {                                                   \
> > >                   ((void)sizeof(char[1 - 2*!!(condition)]));     \
> > >                   if (condition) __build_bug_on_failed = 1;      \
> > >           } while(0)
> > >
> > > Sparse is more strict about the negative array trick than GCC because
> > > Sparse requires the array length to be really constant.
> > >
> > > Here is the simple test code for the macro above:
> > >
> > >   static const int x = 0;
> > >   BUILD_BUG_ON(x);
> > >
> > > GCC is absolutely fine with it (-Wvla was not enabled at that time),
> > > but Sparse warns like this:
> > >
> > >   error: bad constant expression
> > >   error: cannot size expression
> > >
> > > (If you are using a newer version of Sparse, you will see a different
> > > warning message, "warning: Variable length array is used".)
> > >
> > > Anyway, Sparse was producing many false positive warnings, hence
> > > silenced.
> > >
> > > With the previous commit, the leftover negative array trick is gone.
> > > Sparse is fine with the current BUILD_BUG_ON(), which is implemented
> > > by using the 'error' attribute. (assuming your Sparse version supports
> > > -Wno-unknown-attribute option)
> > >
> > > I am keeping the stub for BUILD_BUG_ON_ZERO(). Otherwise, Sparse
> > > would complain about the following code, which GCC is fine with:
> > >
> > >   static const int x = 0;
> > >   int y = BUILD_BUG_ON_ZERO(x);
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>
> Clang builds not affected. Tested a quick arm64 defconfig build with
> Clang + this patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>


This patch can go in only when 1/3 is acceptable.

But, I see 1/3 is controversial.



-- 
Best Regards
Masahiro Yamada
