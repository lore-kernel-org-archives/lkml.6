Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCMHuK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:50:10 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:54798 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeCMHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:50:07 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2D7o2w8005176
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELu1UDFbAm+/ahC3hNIk0cx+0bXTZdcVxlTcURfdymWUXCULukjV10Y8p2NXblYGpYNlTgiC5CaVYaiFvbeGNrA=
MIME-Version: 1.0
In-Reply-To: <20180313061109.72629-1-dianders@chromium.org>
References: <20180313061109.72629-1-dianders@chromium.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Mar 2018 16:49:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQn1qM7zQvtUxiN-wG64RypmbHiE0ybzsXcc4aRvzmFCA@mail.gmail.com>
Message-ID: <CAK7LNAQn1qM7zQvtUxiN-wG64RypmbHiE0ybzsXcc4aRvzmFCA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kbuild: Fix corner caches with .cache.mk
To: Douglas Anderson <dianders@chromium.org>
Cc: malat@debian.org, dave.hansen@intel.com,
        Yang Shi <yang.s@alibaba-inc.com>, Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,


2018-03-13 15:11 GMT+09:00 Douglas Anderson <dianders@chromium.org>:
> This two-patches fixes two corner cases with .cache.mk that have been
> reported.  Neither problem was catastrophic, but certainly several
> people ran into the problem solved by the first patch (can't build
> after gcc upgrade) and wasted time debugging, so it's really a good
> idea to fix.
>
> Sorry for the big delay between v2 and v3.  I never quite caught up
> with email after the holidays, but hopefully better late than never...


If v3 had been sent in time for v4.15
I would have immediately queued it up.

But, the situation has changed.

The direction of the development is
to move the compiler flags evaluation to the Kconfig phase,
and remove the Kbuild cache.


If you are interested in the background,
here are some of resources:

Linus' comment that finally moved this work forward:
https://lkml.org/lkml/2018/2/7/527

Tons of discussion about the initial version:
https://patchwork.kernel.org/patch/10207385/

The core patch in the latest version:
https://patchwork.kernel.org/patch/10225355/


And, I am removing the Kbuild cache entirely:
https://patchwork.kernel.org/patch/10225437/


I do not know how to handle your patches
since I am removing the addressed code for 4.17-rc1,
which is comming in a month or so.

If this is a fatal problem, we can queue it up
only for 4.16, but I do not hear problem reports these days...



> Changes in v3:
> - Fix as per Masahiro Yamada (move change to main Makefile)
> - Use "uid 0" as the heuristic instead of install
> - Do the checking in the main Makefile instead of Kbuild.include
>
> Changes in v2:
> - Don't error if MAKECMDGOALS is blank.
>
> Douglas Anderson (2):
>   kbuild: Require a 'make clean' if we detect gcc changed underneath us
>   kbuild: Don't mess with the .cache.mk when root
>
>  Makefile               | 15 +++++++++++++++
>  scripts/Kbuild.include |  2 ++
>  2 files changed, 17 insertions(+)
>
> --
> 2.16.2.660.g709887971b-goog
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
