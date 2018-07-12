Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0389C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEB02147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HG99Uqge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEB02147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeGLPhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:37:45 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49831 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeGLPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:37:44 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6CFRYHT026447;
        Fri, 13 Jul 2018 00:27:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6CFRYHT026447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531409255;
        bh=e9n13aSF4Fm6bkSeoWhOXLx3/CGcLyV4SWKKZqs5QB8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HG99Uqgejcab6r6vSjdQkU7A2YsLDPjMC3wjGJEA5E5gsY/XCoUEX2mwP+Jyndtlx
         Ii71dtk7F1hBqjFh97Yz2RWYwSHgKzzg9EZf3ySDS8wu45EVURB3RYNHOr7hCgy55o
         AYrI1tMbyBGMAk+AKweaZSV2ULTzuNBenvJfhHTIClXqh+LuLyFnKjuehHT+ad38Pu
         kLqCY4tmTEeRaOZbz1fUZXQOBhIe0V3qLVXCKEN2qCCjgVvgIGS24DLofjv3nKEoPW
         QWLd/dy0/a3g2BxGZMC725Kk/gPpyeYLSCkhZcHEu9aQqNCq2aXJo3G03zvogegne5
         6XDha3b2sS2fA==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id q12-v6so18682153ual.2;
        Thu, 12 Jul 2018 08:27:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlHvvNBeXC3r+7UuQpc47RAXn4ihzEh+Px0YpO5PI61CV33ZMhHY
        htITfez9KL9/f+B8POP5UgFhROAT8LsNjJ4LtoE=
X-Google-Smtp-Source: AAOMgpe5y5MHRW7CpV5h0rrVib2VGe1tGcBDIMxy3uHNMiwF7XN41vFe1bcHYHypOqCMTvCtHPeFv2wtZg+4sc/g9nQ=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr1674889ual.141.1531409254359;
 Thu, 12 Jul 2018 08:27:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 08:26:53
 -0700 (PDT)
In-Reply-To: <2d0bd4a4-98cb-380e-36c4-e46dc5d53991@molgen.mpg.de>
References: <89f15a49-d18b-6b01-adb7-1385f2844cb6@molgen.mpg.de>
 <557a23f8-8993-d832-3290-37481c37e340@molgen.mpg.de> <2d0bd4a4-98cb-380e-36c4-e46dc5d53991@molgen.mpg.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 13 Jul 2018 00:26:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATB_hR_S4zQQ-jv=NQEnvNfkSPrZ6xbRE8bKNjNO6VTtQ@mail.gmail.com>
Message-ID: <CAK7LNATB_hR_S4zQQ-jv=NQEnvNfkSPrZ6xbRE8bKNjNO6VTtQ@mail.gmail.com>
Subject: Re: [PATCH v3] tools/build/Build.include: fix # escaping in .cmd
 files for future Make
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zibeon@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-10 23:50 GMT+09:00 Paul Menzel <pmenzel@molgen.mpg.de>:
> Date: Tue, 5 Jun 2018 19:00:22 +0200
>
> In 2016 GNU Make made a backwards incompatible change to the way '#'
> characters were handled in Makefiles when used inside functions or
> macros:
>
> http://git.savannah.gnu.org/cgit/make.git/commit/?id=c6966b323811c37acedff05b57
>
> Due to this change, when attempting to run `make prepare' I get a
> spurious make syntax error:
>
>     /home/earnest/linux/tools/objtool/.fixdep.o.cmd:1: *** missing separator.  Stop.
>
> When inspecting `.fixdep.o.cmd' it includes two lines which use
> unescaped comment characters at the top:
>
>     \# cannot find fixdep (/home/earnest/linux/tools/objtool//fixdep)
>     \# using basic dep data
>
> This is because `tools/build/Build.include' prints these '\#'
> characters:
>
>     printf '\# cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
>     printf '\# using basic dep data\n\n' >> $(dot-target).cmd;           \
>
> This completes commit 9564a8cf (Kbuild: fix # escaping in .cmd files for
> future Make).
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197847
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---



Applied to linux-kbuild/fixes.  Thanks!


> v2: Add stable@vger.kernel.org
> v3: Add tag PATCH to subject
>
>  tools/build/Build.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/Build.include b/tools/build/Build.include
> index a4bbb984941d..d9048f145f97 100644
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -63,8 +63,8 @@ dep-cmd = $(if $(wildcard $(fixdep)),
>             $(fixdep) $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;           \
>             rm -f $(depfile);                                                    \
>             mv -f $(dot-target).tmp $(dot-target).cmd,                           \
> -           printf '\# cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
> -           printf '\# using basic dep data\n\n' >> $(dot-target).cmd;           \
> +           printf '$(pound) cannot find fixdep (%s)\n' $(fixdep) > $(dot-target).cmd; \
> +           printf '$(pound) using basic dep data\n\n' >> $(dot-target).cmd;           \
>             cat $(depfile) >> $(dot-target).cmd;                                 \
>             printf '\n%s\n' 'cmd_$@ := $(make-cmd)' >> $(dot-target).cmd)
>
> --
> 2.16.2
>



-- 
Best Regards
Masahiro Yamada
