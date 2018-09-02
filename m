Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A2FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A3320857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A3320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeICAL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:11:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41949 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeICAL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:11:56 -0400
Received: by mail-qt0-f196.google.com with SMTP id t39-v6so19836777qtc.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 12:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YmLB6NtwOplNfhH2/mPHSmNWmmRlhjCayK9oxU9CGI=;
        b=OLAFaeNpMwH0vspa0/R8OxK8Tlhpie3n1tgafTY1svSk5za7szHG8sNA9z8iSry0rC
         pDwbtnRdz7V/3KOkUrKYxiv+n70Fy2FPrSY7pbAk69EFlZDDoy+WEr4YmzpXEZPkF2L7
         oTfLtj2n5jpo+fRjj1V3+cmMJ/vVL2/zVZhMgtZraMETNIhn66PwDhRTpggpPAl1ss2/
         3C0f28O1gZ6Kg+xvL3kFj3is4oZrfsftfwVz0U+w1TzgZZ2TOvjyklaHDFnS4FjlNhvM
         NbefU11r3Sid9ZZpTxhnjUAjvNBC/tTkxnH6UggLR0/Rp0rURS4g7KPaKZx3BGf2wypk
         WXQg==
X-Gm-Message-State: APzg51Co3aoEhjaYmwR5+zXoFljQi60yljxOUZPolu76hQZcVLqNQ3bl
        96jj0rMg/0kVkQCk5rIvnNu8lYAq0JlAqbFcTuow3aLP
X-Google-Smtp-Source: ANB0VdY6GdGo04NX/9i+pFqRzk4Rc3tjMJa8jSyVky4pdWv0v8aG3SIb3I3HennBPAVmhj4OjYkswvVjv488lXZ8bks=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr24675027qtb.75.1535918102943;
 Sun, 02 Sep 2018 12:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com>
 <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
 <CANiq72kA=hdg00FeWovJcXpY54hJx-bLYy_Cpd9PsOdTEYHGog@mail.gmail.com> <CAKwvOdmYcF3M1kb6B6jAYfL40P56tG_DOsx_cpLDF-Z2+ceGQQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmYcF3M1kb6B6jAYfL40P56tG_DOsx_cpLDF-Z2+ceGQQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Sep 2018 21:54:46 +0200
Message-ID: <CAK8P3a2cDhJ_jJwDZwfZV+iKeY4Vwu_PjPp3UPcQjWmrWJGdww@mail.gmail.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, Aug 31, 2018 at 1:23 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Fri, Aug 31, 2018 at 8:43 PM, Nick Desaulniers
> > > I don't think minimal supported versions are required for these clean
> > > ups, and would not block these patches from landing on that.
> > >
> > > Also, haven't found anyone using ICC yet to comment on minimal version
> > > requirements.
> >
> > For clang, by the way, __naked should go out of -gcc.h.
>
> Yep, Arnd's note in the other thread was a valuable insight and I agree with it.
>
> > I guess that
> > is breaking ARM clang builds at the moment (didn't check)?
>
> Huh?

32-bit ARM has a number of problems with clang at the moment,
one of them is the lack of a __naked definition, which causes it
fail building if any of these files are enabled:

arch/arm/mach-exynos/mcpm-exynos.c:static void __naked
exynos_pm_power_up_setup(unsigned int affinity_level)
arch/arm/mach-vexpress/tc2_pm.c:static void __naked
tc2_pm_power_up_setup(unsigned int affinity_level)
arch/arm/mm/copypage-fa.c:static void __naked
arch/arm/mm/copypage-feroceon.c:static void __naked
arch/arm/mm/copypage-v4mc.c:static void __naked
arch/arm/mm/copypage-v4wb.c:static void __naked
arch/arm/mm/copypage-v4wt.c:static void __naked
arch/arm/mm/copypage-xsc3.c:static void __naked
arch/arm/mm/copypage-xscale.c:static void __naked

There is a related problem in all the copypage files: even if we add __naked,
clang refuses to compile them because it is more restrictive than gcc
about enforcing the __naked function rules. I'll send a patch for
that soon.

     Arnd
