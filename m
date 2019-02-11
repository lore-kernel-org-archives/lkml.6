Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82541C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E405218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0PqT7xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfBKT1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:27:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37648 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbfBKT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:27:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so29698pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNDCAdXK5WwzSSlG7lMjdTQ2ibEWaEc6ZQu2po9nEM0=;
        b=P0PqT7xLj5zeJXUuD/tUXOHefZC17cCQlVyOxsOC4ooVCULHGQXirYouvRmw4C9QDW
         A/t8CmKiCkLb/m8cQ1yzTUascDLpMR9KW8/qAJQDycAhcBQikRS1Np9vx/gfmDDGNtVJ
         RpxRo0c9Zp/r9dDOAEznSDlygOc5hblQsIBJcuSmOzh8PUH95afKlgHW81tyHOU0zy4J
         zjoRr2G6hqYgTJJMDaXMYD65RU99I84/yzvxd1nVdKI1PYX8gOIDkFib/ueJ820rltD5
         TbF/0A3B5OYuIqvgaHP2kYy9Ys1iyeJJEM4iPFuQvR0NtIwZGcD4EAkN6QTYtiywSSPH
         OKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNDCAdXK5WwzSSlG7lMjdTQ2ibEWaEc6ZQu2po9nEM0=;
        b=cozDuhmZ2lKy1wmJZkX7rwnUjokvp08PypihJikWbj3NS8XVt2HY+qZQyv7ZZR7AyO
         c/RNqYHPNZqsF/3sPeQMiod8/7HEIh3WQzBOmO0BSuVG+aZdIXs3FR6AeQShyZDOai4B
         ET3WOGFqoybjoJZJaQxZtHKxUBMfYGO+cpw4HRrfJhDr+xlCfCeiK5Ng91N/GOgNIavH
         SKnXGYoG9nVbnfA66/yXDqsV6Vw/OrAI4FlKE2+BtBzoAhDMdWZmXwwa/0i1SFTD6pw5
         PPmLav9wIi9lt5ihj9gMiN8kyYChPvgv2R+NHBhU/7hdkJj0A34Q8r2Bw3cqvPrDVG/S
         q6Dg==
X-Gm-Message-State: AHQUAubfhYDJenfvj4D2u/jfiVIGac3wCcuGzkSpoexzWb3Cek8zkm+u
        bGNo0Yj9AyWQNXQIu0Zh2Z1BNH5YGMkoU3Jo2UcFpg==
X-Google-Smtp-Source: AHgI3IZ007fXkqJrkaNyxZ/Ub8wtD9Zj1oMrGI0q72DeSdnz1SSC3WJqvffvdevp5uqqfmE+lCNcBUMy8EaQnpgQ54s=
X-Received: by 2002:a62:2c81:: with SMTP id s123mr37868430pfs.174.1549913252158;
 Mon, 11 Feb 2019 11:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com> <20190208055059.GD9647@archlinux-ryzen>
 <CAKwvOd=ytsXYDzVZHUEjokHmW5kpqmCq4cnToOFJ4gwz8j7W=Q@mail.gmail.com> <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQD=ZVcbn3cz2bcW0KrkL9ZOU44SHrmf2aRZwhYdmQrqQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Feb 2019 11:27:20 -0800
Message-ID: <CAKwvOdn1BDsYCrjUVDqKyiZA8pvENOWaOvkYN3kcVfWZof9Esw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:33 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Feb 9, 2019 at 2:27 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Thu, Feb 7, 2019 at 9:51 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Thu, Feb 07, 2019 at 02:01:51PM -0800, ndesaulniers@google.com wrote:
> > > > This is needed because clang doesn't select which linker to use based on
> > > > $LD but rather -fuse-ld=$(LD). This is problematic especially for
> > > > cc-ldoption, which checks for linker flag support via invoking the
> > > > compiler, rather than the linker.
>
> What do you mean by 'problematic' ?
>
> I see no build error in
> arch/arm64/kernel/vdso/Makefile, at least.
>
> Clang uses BFD linker by default,
> which may not match to the $(LD) passed in.
>
> Is this what you mean?

Right, when using a linker other than BFD, we want cc-ldoption to tell
us whether that linker supports a linker flag or not.

-- 
Thanks,
~Nick Desaulniers
