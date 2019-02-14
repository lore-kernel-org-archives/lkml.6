Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC5DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396D8222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CakEYHXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393799AbfBNCIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:08:42 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:51004 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfBNCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:08:42 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1E28WJ0021712;
        Thu, 14 Feb 2019 11:08:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1E28WJ0021712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550110113;
        bh=LbXS/W5GGdwbY2WB5CsZrdiL8plxaZO+pwGAUwkcY7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CakEYHXjh8q8N4Iz/wVaRa7V/bNEEq+tQvKCI5ptcOUrbNe6mbNmzm7oxIP15EbWk
         HpStEg6dRdamai3dg3Kac2xUbpU4L0qI7V/FFPNxeMXCorFp+lDolicpr3OYz5HSLe
         rbXDEJd1DYg/2x75tEbSVrBOz4ucIVIBiQ4Ojj060SmNWInGlbfEZDH1S/uPewv+fL
         jzmlUCuEtWJk+Jf5JysF0Q2LqznCZjbbzQwDrCIULrGG4YVtMa06D0sdCA7mL18qm6
         +zccH3ywpAZsD+I9rAFzA4NeZWZwDCBUkt0XpVbiFJbrF1UziBAJtcOJkuImcM9BdR
         /qrUY9JEoOQDw==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id j8so1493013uae.13;
        Wed, 13 Feb 2019 18:08:33 -0800 (PST)
X-Gm-Message-State: AHQUAubeBFZwMZwhYeGnlqpcFKK95yRys4gQVO+e/g1ORNLCWvcdMF6L
        YEFIyS7MlLgy0KrVdCQ/bo1TFc2X856Brs+EKGA=
X-Google-Smtp-Source: AHgI3IZTBfCoe+Yi5DwauicJTtgC9cSSqX5IbAARfKG4/l8EXvEozpWhgPJIynLc5JLWBq2IfFnHx4hUG+YOZXnnNJg=
X-Received: by 2002:ab0:748a:: with SMTP id n10mr720800uap.89.1550110111866;
 Wed, 13 Feb 2019 18:08:31 -0800 (PST)
MIME-Version: 1.0
References: <1549271455-19292-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1549271455-19292-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Feb 2019 11:07:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASPPB-_yVa4+A+w2fqezPGc5GRSwesDebKXrB8m+6U8Eg@mail.gmail.com>
Message-ID: <CAK7LNASPPB-_yVa4+A+w2fqezPGc5GRSwesDebKXrB8m+6U8Eg@mail.gmail.com>
Subject: Re: [PATCH v2] sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 6:11 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I fixed a similar build error in commit 1b1e4ee86e00 ("sh: fix build
> error for empty CONFIG_BUILTIN_DTB_SOURCE"), but it came back again.
>
> Since commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb
> build rules"), the combination of CONFIG_OF_EARLY_FLATTREE=y and
> CONFIG_USE_BUILTIN_DTB=n results in the following build error:
>
> make[1]: *** No rule to make target 'arch/sh/boot/dts/.dtb.o', needed by 'arch/sh/boot/dts/built-in.a'.  Stop.
> make: *** [Makefile;1727: arch/sh/boot/dts/] Error 2
>
> Prior to that commit, there was only one path to descend into
> arch/sh/boot/dts/, and arch/sh/Makefile correctly guards it with
> CONFIG_USE_BUILTIN_DTB:
>
>   core-$(CONFIG_USE_BUILTIN_DTB)  += arch/sh/boot/dts/
>
> Now, there is another path to descend there from the top Makefile
> when CONFIG_OF_EARLY_FLATTREE=y. If CONFIG_USE_BUILTIN_DTB is disabled,
> CONFIG_BUILTIN_DTB_SOURCE is invisible instead of defined as "".
>
> Add obj-$(CONFIG_USE_BUILTIN_DTB) guard to avoid the attempt to build
> the non-existing file.
>
> Fixes: 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Applied to linux-kbuild/fixes.



> ---
>
> Observant reviewers may point out another problem.
> There is a race condition when CONFIG_OF_EARLY_FLATTREE=y.
>
> Some architectures (sh, xtensa, etc.) embed a DTB in vmlinux,
> so there are two paths to descend into arch/*/boot/dts/.
> For parallel build with -j<N> option, two threads may build
> under arch/*/boot/dts/ simultaneously.
>
> Yes, this is a problem, and it is in my TODO list.
> For some reasons, I will postpone it by the next development cycle.
>
> For now, I want to fix this sh build error first because kbuild test
> robot is still complaining about it.
>
>
> Changes in v2:
>   - Change the subject a bit because the cause of the error is different
>
>  arch/sh/boot/dts/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
> index 01d0f7f..2563d1e 100644
> --- a/arch/sh/boot/dts/Makefile
> +++ b/arch/sh/boot/dts/Makefile
> @@ -1,3 +1,3 @@
>  ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
> -obj-y += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
> +obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
>  endif
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
