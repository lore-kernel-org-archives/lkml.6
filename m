Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D394FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA6C2192C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="17XROPBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392541AbfBPC4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:56:41 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59129 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBPC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:56:40 -0500
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1G2uTUN013382;
        Sat, 16 Feb 2019 11:56:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1G2uTUN013382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550285790;
        bh=jb71YwEcih/Oh3kNqhObZaVeFASBVZFRN7G9/LiDCHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=17XROPBu0TY5x029gj/BOKo6Eqw814/2E/SP+RYwLNVmmCiU2zlFuO3rx50TKsLnS
         RTxZm02zwdGYhrM6CwKY4ABnGtW0Tc7CVj90Gd/LjCvaLS6Wzqz7Wf6ukx3I2b2BJk
         BZoggAGhBE+SKbYULiQoaXFFVIETqfczDOsRP+bRLf/WoLKm/ce3I+jak/NUp2yEYI
         tLx6n9wNoaV0rHyUrWpuurWPnOMW3SVowckjeF4AGD00fTOLmxKflZSywwpErUjgAo
         2J9g+YmuaLhG+WpwVjUPeelpq3EavUkxYXDAFSV3tImCqAR1qMEBFFNfscLM2lhbt/
         g+UR/w3zRxuUA==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id d21so4204170uap.9;
        Fri, 15 Feb 2019 18:56:29 -0800 (PST)
X-Gm-Message-State: AHQUAuZonkETU0NRfEeruyMg4Tn0KoFalODHOOi3ijLGuDzBFNdqiAqT
        yp68vSzpBsaPwUfa4tPFKpz3mwmeOUMV8/jdkG8=
X-Google-Smtp-Source: AHgI3IYOT7yoMgbtu9xcav+TvxmivAmIPkOPF0IqxZuMXihVk0Xq9eMoVM1X7m0orxhSlNpz0ws+0+zmaYK++cRUOqk=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr6575761uap.6.1550285788559;
 Fri, 15 Feb 2019 18:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com> <20190211193008.24101-4-ndesaulniers@google.com>
In-Reply-To: <20190211193008.24101-4-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Feb 2019 11:55:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbCfB9pW8f5B-1YmSw41ExWohhRT=y0m5Osb++9cZCFg@mail.gmail.com>
Message-ID: <CAK7LNARbCfB9pW8f5B-1YmSw41ExWohhRT=y0m5Osb++9cZCFg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Makefile: lld: set -O2 linker flag when linking
 with LLD
To:     Nick Desaulniers <ndesaulniers@google.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Ueyama <ruiu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
>
> For arm64:
> 0.34% size improvement with lld -O2 over lld for vmlinux.
> 3.3% size improvement with lld -O2 over lld for Image.lz4-dtb.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/343
> Suggested-by: Rui Ueyama <ruiu@google.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1->V2:
> * add tested and reviewed by tags.
>
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 00e8e01d23fc..8011555745aa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -718,6 +718,10 @@ else
>  KBUILD_CFLAGS += -Wno-unused-but-set-variable
>  endif
>
> +ifdef CONFIG_LD_IS_LLD
> +KBUILD_LDFLAGS += -O2
> +endif
> +


I wondered why this option should be added only for lld,
and I found the answer in the "Link:"

"for bfd, didn't seem to change the size at all (I can't recall if
this was arm64 or x86 I had tested with though)."


Hmm, I see.
My 'man ld' says it is currently effective only for shared libraries.


       -O level
           If level is a numeric values greater than zero ld optimizes the
           output.  This might take significantly longer and therefore
           probably should only be enabled for the final binary.  At the
           moment this option only affects ELF shared library generation.
           Future releases of the linker may make more use of this option.
           Also currently there is no difference in the linker's behaviour for
           different non-zero values of this option.  Again this may change
           with future releases.



I am fine with adding it unconditionally
as long as it is harmless for bfd, gold.






>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


-- 
Best Regards
Masahiro Yamada
