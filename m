Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6693BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D35208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrMFl7IJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D35208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeHUTxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:53:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40875 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeHUTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:53:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id e13-v6so8745332pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ta/2NpDc5IV2JLxQO7BawXtgOqdpHbpSj0OOwH9om0Y=;
        b=XrMFl7IJau4pnJz+CVPIIzR27UfOG8bCqnUWZf1jZmlTgyVX+df/oYpHglIpuwdYx2
         32Qm8lnk2Wsyw4aGHsFzTXN/XOZwDyUTJfExfuR5KqlW3RyuWzGt7fOt0PrabW/4yKna
         OYWAs7Dmxxojcqzr+kJxEACEtvwWVnJrRkielRKxfJf+WC2b5I+rIIJQyglpBNCOu+Ub
         CMZ4BFaxDOQLfRtJAKpiyx6JYW0TQeRJml6NVtBlTFfmGmQ9Lor2b6mWBr1d0fh9wfrD
         /nHryPLWCFHWlZVNTH0dpgSd3klOguC+2E6q34zGTEgEyW90YrgRHeVy9G7DlYpLQ+d5
         P1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ta/2NpDc5IV2JLxQO7BawXtgOqdpHbpSj0OOwH9om0Y=;
        b=Y4XgSXesojfSpMalJMiMkN2q5XX2jVlCxQOtGUr6P/42Jx6xc6mILuCHte9Xkd17P/
         xHPM5bDfldeqpcEGQAcRK7UfakMPLsv/lzxC2CNbTNxQP0EFxmMH2AJtfX9rAKy3GU1+
         7FFGs/qbByU+uqbkGV1IS18Hs2R2Kkj4/KOSYScBjFEdFqiR3sFBRaF7i7IrM0gbMeR2
         3LOauqIXy06E6cxuwuMPOLXkgBM5+mJMAFYlcHKkg9GKvwDILnH8EIXk6+J/pOgMEuZ/
         Yi+UTXidfAV/uk5I2T0/T0Y+cVObTpIxF2bNzdDYiGqC0MQdLQu/2OIFnrW5lbI+ZE6s
         TaXg==
X-Gm-Message-State: AOUpUlF+AL9PDj29uiEU4tUxxVxaUT0gwHRmI8vG3A1w7HQAKrZx7Cg5
        IYsLdIER7YVz5O4mYmCkP59L7IPZyUO2hfuEVA3Q4A==
X-Google-Smtp-Source: AA+uWPzneDVDC1OtLPW9ZuhWJC4N5e6unuh76dCsswUAEiSacLuaU/xG2aul3P1xO9lfncD1rA6NoM9wT/WYqFeiM4A=
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr53905803pfb.94.1534869155730;
 Tue, 21 Aug 2018 09:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com> <20180821123832.GA19034@nautica>
In-Reply-To: <20180821123832.GA19034@nautica>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 09:32:24 -0700
Message-ID: <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     asmadeus@codewreck.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        joe@perches.com, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 5:38 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Nick Desaulniers Aug. 21, 2018, 8:09 a.m. UTC:
> > Thanks for noticing, and sending this patch.  I'm happy to see others
> > testing with Clang.  I noticed this too near the end of the day
> > https://github.com/ClangBuiltLinux/linux/issues/27.
>
> FWIW libbcc so many BPF users also use clang, so this has more impact
> than just testing to build linux with clang (not that this would be any
> reason to delay fixing either way)
>
> I would tend to agree havin a compiler-common + make clang/intel not
> include compiler-gcc would probably be best in the long run but we might
> want a quick fix for 4.19 meanwhile..

That's fair. SOP here is quick (full) revert, then come up with a
better fix.  And I do prefer Masahiro's partial revert to a full
revert of Joe's patch.  That will give us more time to develop the
proper fix rather than rush.  I'll try to see how we can more properly
split the compiler specific headers.

Tested with gcc-7 and clang-8.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
