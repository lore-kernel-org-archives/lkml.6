Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC4FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E322083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4Qrtmra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E322083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeIABgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:36:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34882 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeIABgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:36:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so1041885pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBQ1ZoKWYFj4NcZtxQekXOrFHaOketmXxdxkGOfL+s0=;
        b=c4QrtmraIxBojLH4IYr491Wu8YkUn+XFo/7C8DDdI+1Aj1vu/T55q2MFZYI5FGcmAw
         Ml5CX/s5NWrVcvMaG4roR9QlgowsECB7Ipn6Y97AuLRlFFdjdZpFYjhDfdVLE5W6vrW1
         SZ35zVdCPeFcUt8FnbxZOn14Fc/tlBpWQPlSZn+bMKNsGD6FVUDzEjpNtwKxhB4qssW3
         RuEaGlbIOcUd+eA73CECr2wnqjfmouP6wFVl8D+M5dfdc9qybaSLYY5wxiK+qrv4An6W
         sG+kbbzBbTFD3vDtbYmeD78A2quJ0ALOGSxU4ZcD71MeZSZjvJe3fmkt+n5pJkwk4oih
         f6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBQ1ZoKWYFj4NcZtxQekXOrFHaOketmXxdxkGOfL+s0=;
        b=Ma0+kayf/TbSZSHEZNgKTcCiUafWJ+elIosJnPUOIi3AgL1q9OUn2HkxYTgKmkK5N0
         H1xuDJv73Fwgr0bc65ztNJGKlxvFTRarstgeyHZP73JM/SdbwxeKMB5AqiinU4KnNZKw
         u6z3PSrnmqswLhDKltEU2qJvkeC+bDDUL3gJjDPDeSj+ka0K6YkQl0HKE8JNUbCSkvSG
         9NANe0/gxm3oouuv28UGor10A604B12ZglZgitEktaJvLMj+UG66UzgKPevjMbrjuVTZ
         9N/yZcQMlx6Uh/Z4ckJVOOXPqPB+hXHQKWp+/lSbhD1ahfD2N2LXqYNJ5GDQsom/T2l3
         coCQ==
X-Gm-Message-State: APzg51B3ajMtpVOi/MU1jXnsx8zggqm5oNyoBx9X2WT0aiiR9QAGCMzT
        4ax676Q0D4IKnBLda583egNa7q8GWAfHz049pvKYqQ==
X-Google-Smtp-Source: ANB0VdY84tGsvKlcQp13Kw1TOYcO+W6uBL4jIFkkgKq8SsdGCYwgeCpxtB/EXlsyTRmKGUSL+iorAluQrA/b6UQHcXI=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr16254112pgt.202.1535750844810;
 Fri, 31 Aug 2018 14:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
 <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com> <CANiq72kA=hdg00FeWovJcXpY54hJx-bLYy_Cpd9PsOdTEYHGog@mail.gmail.com>
In-Reply-To: <CANiq72kA=hdg00FeWovJcXpY54hJx-bLYy_Cpd9PsOdTEYHGog@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 14:27:13 -0700
Message-ID: <CAKwvOdmYcF3M1kb6B6jAYfL40P56tG_DOsx_cpLDF-Z2+ceGQQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     joe@perches.com, Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 1:23 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 8:43 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Fri, Aug 31, 2018 at 10:28 AM Joe Perches <joe@perches.com> wrote:
> >>
> >> On Fri, 2018-08-31 at 19:05 +0200, Miguel Ojeda wrote:
> >> > __optimize and __deprecate_for_modules are unused in
> >> > the whole kernel tree. Simply drop them.
> >>
> >> Nice series, thanks Miguel.
> >>
> >> It'd be good to have a cover letter for the series.
> >>
> >> And I believe there should be the equivalent of:
> >>
> >> #if GCC_VERSION < 40600
> >> # error Sorry, your compiler is too old - please upgrade it.
> >> #endif
> >>
> >> for compiler-intel.h and compiler-clang.h so that
> >> each supported compiler minimum version is checked.
> >>
> >> Is it clang > 13 and icc > 3 ?
> >
> > Eh, I'm not sure I want to commit yet to a specific minimal version of
> > Clang.  Right now, we're fixing things so depending on arch's and
> > configs, the answer might be Top of Tree clang builds.  For Pixel, we
> > shipped with Clang-4, but pretty quickly we needed Clang-5.
> > https://lkml.org/lkml/2017/11/22/943
> >
> > I had sent patches previously for detecting clang version from the C
> > preprocessor, maybe I should dust those off, then commit to clang 5.
>
> In my opinion, even if you require clang 7, that is fine, as long as
> we get a working build mainlined.

Clang 7 is aggressive.  I need to think more about how to call out
when a specific set of configs for a given arch requires a compiler
upgrade, without ending up with combinatoral explosion.  I don't want
to cross that bridge with this patch set.

>
> By the way, I am testing the series with clang 8 (2018-08-14) (after
> reverting e501ce957a78), and it seems to work. Hopefully that makes
> you happy! ;-)

That makes me very happy.  It indeed does produce a run-able
executable, for some subset of configs, but can't be relied upon until
we complete our implementation (WIP).  CC me on any bugs you find for
your configs.  I'm also trying to keep a handle on things in
https://github.com/ClangBuiltLinux/linux/issues.

>
> >
> > I don't think minimal supported versions are required for these clean
> > ups, and would not block these patches from landing on that.
> >
> > Also, haven't found anyone using ICC yet to comment on minimal version
> > requirements.
>
> For clang, by the way, __naked should go out of -gcc.h.

Yep, Arnd's note in the other thread was a valuable insight and I agree with it.

> I guess that
> is breaking ARM clang builds at the moment (didn't check)?

Huh?


> I will
> include the move for v3.
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
