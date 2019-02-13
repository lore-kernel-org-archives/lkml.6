Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91138C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600302175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH9XcIHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbfBMRmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:42:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34841 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfBMRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:42:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1516001plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAqxNwpQHX0RbUVVTpU1bUftf8Y780zKRfbuxZ/UYqA=;
        b=PH9XcIHlUBrV3S1bbS0YF9xN/j5PW/NfF2ElR25NGWFcxYja1oeftIA5NmjkVoCot2
         bLLRYl8sN2Bi13AXepiszRHFhwCKsiv7ikPXb/l/qP4n55yZuUFs0SQymbHZ4odWhbhv
         jMBSHKzQANV3tqa5LI9LIOCzaqxvDzK2YsHVxDsqnq3y45tufHPIDGOQX8T8fpllBvFB
         djlfEHShCgJc+4IYnwpxt0Ew46DW4J5+HNWedZjPBjaOVq6Qg7jvAOpzGQCDLUoP893b
         8vuQ3gvxpIkJaA8t+Lvdc2deNhmerdiEaFU8BgslEXz4lfuWM0k3zDTxJCd4i8C59igI
         zAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAqxNwpQHX0RbUVVTpU1bUftf8Y780zKRfbuxZ/UYqA=;
        b=BV7yryXSmk75bLJr0MxTALPIEZJVKgC9+HF1vuo5rsj9jwOhRsMpcWzAzfjRcaPrlm
         +iSkodvA3hZsx8fPDke4yl/lZM7vB7iDi4NzcqQdFWB5fwKVbKKe74e30fACgsi4qQWN
         Zj0UzK0KLsTyeigDKtEoOeMWgPg3tu0rTvg5kuye8toiNwmL5KRQf6m1U2KP4e7PRLaU
         zNUs4lse230llOrGWLUhfQa871433RvTv25yun4A5m7P9ll8DaU40klXLyxcr4zJU5l8
         IL+n/Mljxb3pf7Y8h4aeObYsDE4X920Xy+xPjIWpc+M/7YC9Tj+EHS1qj5iGjEyZ0vDT
         ZbuA==
X-Gm-Message-State: AHQUAuZGl3Ay3q+teklr+5btSouhlzzx5o+zsQEo0rUTai/HqUJ9lUzr
        76ThTYzzG6YDUpUmFTaRw/1oomEaGm2ilcKU5iwOrA==
X-Google-Smtp-Source: AHgI3IbNTajVhcBmddSBQkk5grCy+PlRY/N+iMLIx2w3GiUBRm+Bx26SnRovEBrTdbkd1SEQJHx6qOGWu4VT4Ro7LIY=
X-Received: by 2002:a17:902:64:: with SMTP id 91mr1649589pla.229.1550079723392;
 Wed, 13 Feb 2019 09:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
 <20190211193008.24101-3-ndesaulniers@google.com> <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
In-Reply-To: <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Feb 2019 09:41:52 -0800
Message-ID: <CAKwvOdmyNFsV=67eLQtETSDJJyDZ8aEJY1+LHuoP4OtpdQOdWQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile: lld: tell clang to use lld
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 6:59 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
> >
> > This is needed because clang doesn't select which linker to use based on
> > $LD but rather -fuse-ld=lld. This is problematic especially for
> > cc-ldoption, which checks for linker flag support via invoking the
> > compiler, rather than the linker.
>
>
> Sorry, please explain what kind of problem
> this patch solves.
>
>
>
> [1] $(LD) is used to link vmlinux, modules, etc.
>
> [2] $(CC) is used to link vdso, etc.
>     and -fuse-ld= selects which linker is invoked from $(CC)

It solves case 2.

>
>
> Is it a problem to use a different
> type of linker for [1] and [2] ?

Ideally, no, but I can think of at least one case where it might be
problematic to mix linkers like that:
You might be mixing linker flags added via ld-option from one linker
that aren't actually supported by the other linker.

-- 
Thanks,
~Nick Desaulniers
