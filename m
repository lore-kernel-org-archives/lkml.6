Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B75CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDACF20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YKh700kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfAREPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:15:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17469 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfAREPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:15:08 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x0I4EpkA017166;
        Fri, 18 Jan 2019 13:14:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x0I4EpkA017166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547784894;
        bh=ttKlhcFkpGF4pdfTDFFX1T7NV8+xPF2wA22wMDNBnHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YKh700kTotPcbz9C6IraQRQJTpQVt6AkbQ3wkj3rerb6xuKg3m/vT8QvjujG1EUCC
         +Vq27wjgXv+dllD0ympxZrgVEGonjFwfd+1Dq94A9MoHO9ovP35aWtupPupM3uKyOL
         mkOj40W0xKtI2LVzOUFD94J70PiYWM0LXG+53/nktb5+O+l+rm1eWPEJ1AyLbO+5rI
         Cgz2gWC+eUAQoom2iIXs4WtTCDacRK0mo4XtPb2DOXSGTzcSKx59TbKiZaIXX9bSt7
         FJbBDuADBty6UbKNRjOl1kiBgvJzpCl48bvYgevCIIGNP5LDDy46dpIvj3IjQnbfF5
         sWq/hYiIrd4iw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id z24so4251365ual.8;
        Thu, 17 Jan 2019 20:14:53 -0800 (PST)
X-Gm-Message-State: AJcUukeiqub4Lf5Bxwmx+1R4v3LJO9p90wc20RFzXc56RiatSsCMJS5e
        A+E/+xL6D+7QbPrtUMTMifM99cIjgWKhPnbH7pI=
X-Google-Smtp-Source: ALg8bN7d2tUtNJDuY/WJeR27RrrNXJTbvRMzz3E9HxRj99DBRcA59IDF8F4PLS+2I5TnbLTRrXyAXa6rDxc/3FSucu8=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr6403745uaj.42.1547784890430;
 Thu, 17 Jan 2019 20:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20190114135144.26096-1-geert+renesas@glider.be>
In-Reply-To: <20190114135144.26096-1-geert+renesas@glider.be>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 18 Jan 2019 13:14:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdA+5_pdTjr1dY-cKGSDq804Huc_CX_8-Gg+ypFCmajQ@mail.gmail.com>
Message-ID: <CAK7LNASdA+5_pdTjr1dY-cKGSDq804Huc_CX_8-Gg+ypFCmajQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] selftests: Miscellaneous fixes
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Shuah Khan <shuah@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:52 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series contains several build fixes and cleanups for issues I
> encountered when trying to cross-build an rtctest binary in a separate
> output directory (like I use for all my kernel builds).

Geert,
Thanks for working on this!


My fundamental question is,
why did tools/ opt out Kbuild?

I think lots of mess comes in
in order to support
  cd tools/gpio; make

instead of

  make tools/gpio/


Lots of files are duplicated in tools/build/
in order to invent a different build system for tools/


Similar, but not exactly the same files. For example,

diff -u scripts/basic/fixdep.c tools/build/fixdep.c




> Most patches are independent. Exceptions are:
>   - Patch 3 depends on patch 2,
>   - Patch 7 depends on patch 6,
>   - Patch 11 depends on patches 2 and 3,
>
> This has been tested with native (amd64):
>   - make kselftest-build
>   - make -C tools/testing/selftests
>   - make O=/tmp/kselftest kselftest-build
>   - make O=/tmp/kselftest -C tools/testing/selftests
> and cross-builds (arm):
>   - make kselftest-build (from a separate output directory).
>
> Known remaining issues (not introduced by this patch series):
>   - tools/lib/bpf fails to build in some cases (cfr.
>     https://lore.kernel.org/lkml/CAMuHMdXRN=mSKTjZNBSxQi-pkgSrKqeANxD-GB+hqC8pDjx7nQ@mail.gmail.com/),
>   - tools/gpio is not always built correctly,
>   - When building in a separate output directory, there are still files
>     created in the source directory under:
>         - arch/x86/include/generated/,
>         - arch/x86/tools/,
>         - include/generated/uapi/linux,
>         - scripts (fixdep and unifdef),
>   - Some tests may fail to find the installed header files,
>   - There may be^H^H^H^H^H^Hare more.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (12):
>   selftests: gpio-mockup-chardev: Check asprintf() for error
>   selftests: Fix output directory with O=
>   selftests: Fix header install directory with O=
>   selftests: android: ion: Fix ionmap_test dependencies
>   selftests: seccomp: Fix test dependencies and rules
>   selftests: lib.mk: Add rule to build object file from C source file
>   selftests: memfd: Fix build with O=
>   selftests: timestamping: Remove superfluous rules
>   selftests: sparc64: Remove superfluous rules
>   selftests: intel_pstate: Remove unused header dependency rule
>   selftests: Add kselftest-build target
>   [RFC] selftests: gpio: Fix building tools/gpio from kselftests
>
>  Documentation/dev-tools/kselftest.rst             |  4 ++++
>  Makefile                                          |  9 +++++++--
>  tools/testing/selftests/android/ion/Makefile      |  6 +-----
>  tools/testing/selftests/gpio/Makefile             | 12 +++++++-----
>  .../testing/selftests/gpio/gpio-mockup-chardev.c  |  9 ++++++---
>  tools/testing/selftests/intel_pstate/Makefile     |  2 --
>  tools/testing/selftests/lib.mk                    |  4 ++++
>  tools/testing/selftests/memfd/Makefile            |  8 +++-----
>  .../selftests/networking/timestamping/Makefile    |  5 -----
>  tools/testing/selftests/seccomp/Makefile          | 15 +++------------
>  tools/testing/selftests/sparc64/drivers/Makefile  |  4 ----
>  11 files changed, 35 insertions(+), 43 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds



-- 
Best Regards
Masahiro Yamada
