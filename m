Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A296AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4807920661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4807920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeHXBYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:24:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38895 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeHXBYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:24:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id o11-v6so4177846uak.5;
        Thu, 23 Aug 2018 14:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFwoNoEPmLbe8W2YiVMYx5Z3YR1vK+8c/BzXFqQ8EeM=;
        b=IbAVC6/wweH15JdJ2B/qJ9MnbXDmHtBxytm3P6/sB4aIc6e9ctnphVocYqYFsFgiCz
         3AcQTDWY+vPRuKpdXK/dOUbuTVYaOgGhShodEPXt1KWyey3Mt2IsnDH47H5/bCOUHLaC
         Gjk/HdLU0gkcpBlEVVy9NXe7Y3Y3cnNJZ6Oawd+UoRmqsjjQy5T2mU1/3YyZFmgvIPy0
         t6Wn3aFEdoRqLT6+I+pItRjQrLLDY+DgGewlzkUaRjuJ+IRqJRHY4Sc8FFvh4CqGUap2
         jPQW9Qsc2uN+an9udPuTNyNrXTENDhM8c9ZDZnBjteTRD6TCu38YnSQFSKFC+xbbiuJx
         1X3w==
X-Gm-Message-State: APzg51CQ6mNMFO9D27FfdBA5o8lknp3twuINoC4JrgOkLjXrxLJu5jNI
        8CJADgzqP2beRscS4Yx/XnOBFzyclPAI7tIcVms=
X-Google-Smtp-Source: ANB0VdZKwDzx0n6Go+YCvcjB6M3WicGa58lXfS4tT+BczHBKHyVPk4SY8RGyfOqesxapxDC4Q1pCU2wRnh020Xy3spw=
X-Received: by 2002:ab0:51e4:: with SMTP id h33-v6mr6033949uaa.137.1535061172085;
 Thu, 23 Aug 2018 14:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
In-Reply-To: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Aug 2018 23:52:40 +0200
Message-ID: <CAMuHMdXPFgp5sLR5-UExEvxNbKSR5H--dk7KMit_XFSFN+1uHw@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Joe Perches <joe@perches.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>, riel@surriel.com,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Aug 20, 2018 at 10:15 PM Joe Perches <joe@perches.com> wrote:
> Various architectures fail to build properly with older versions
> of the gcc compiler.
>
> An example from Guenter Roeck via this thread:
> https://lore.kernel.org/lkml/20180814170904.GA12768@roeck-us.net/
>
> ----------------------
> In file included from ./include/linux/mm.h:17:0,
>                  from ./include/linux/pid_namespace.h:7,
>                  from ./include/linux/ptrace.h:10,
>                  from arch/openrisc/kernel/asm-offsets.c:32:
> ./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct
>
> This is just an example with gcc 4.5.1 for or32. I have seen the problem
> with gcc 4.4 (for unicore32) as well.
> ----------------------
>
> So update the minimum required version of gcc to 4.6.
>
> Miscellanea:
>
> o Update Documentation/process/changes.rst
> o Remove and consolidate version test blocks in compiler-gcc.h
>   for versions lower than 4.6
>
> Signed-off-by: Joe Perches <joe@perches.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for your patch!

I'm willing to upgrade. But there's one thing that's holding me back.

Does gcc 8.x gives again the same warnings as my venerable old gcc 4.1.2,
that no one else seems to see? Or will the real bugs I detect this way stay
unfixed? Polyculture is a good thing, also in compilers.

Reverted locally (incl. the follow-up), applied Andrew's fix, detected new
warnings in v4.18+, and sent patches where it makes sense...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
