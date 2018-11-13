Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652CD2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="afgb2h1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652CD2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbeKNJf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:35:57 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45068 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:35:56 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wADNZHKO031564;
        Wed, 14 Nov 2018 08:35:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wADNZHKO031564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542152118;
        bh=sSXMBgmuxJgcZzkMncWIxAb5vAYpdu3DZF/y0sql7P4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=afgb2h1+ZaZjfXZlkoolypxPd9daW+DJlNqDaz0qBvZHjAFaBgjUguCltYKRDaXuP
         v4e2vafDN1Ywtb0XLOK05VaAFWWIEYmpIl2QnAFSVyo0MMBCfCZg1xTwzpMidvZDuB
         BYab2x3o/F6yTdWZxRUzfpUU27x6BXDT0hlng6tokm1VE/CAkpA/H2UP3fFu+lgMBJ
         iuvl2W6xeHtKeySbyfukqlHzaG01Uf7zAuVyyZ7Fn7n2+WQ/E6L+1H/oTllxapu9O/
         9M0/3AIdxN2bxMQLo7V59x/1dpGE5TB8A8K1WJeRjmfmxf6CoK6UAgPst5JafShbEn
         +zr3x1/P8J6tQ==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id h78so8426540vsi.6;
        Tue, 13 Nov 2018 15:35:18 -0800 (PST)
X-Gm-Message-State: AGRZ1gIQGfj2K6p00ejEAOnX668KG/I38RUvnFAZNodcJgXEJkzlVB2K
        4OVmxhuXi4mcZz2ikbvurTygp6tbpwYKYjmHRN0=
X-Google-Smtp-Source: AJdET5dwinbLOTUOJQJfzWMAe4foUc7O0hjZ62BCis1H+Cga9sGHmY0h1spzq8E89MKq8BeSQEanqi93aOUMxRXOQIo=
X-Received: by 2002:a67:385a:: with SMTP id f87mr3309516vsa.179.1542152117086;
 Tue, 13 Nov 2018 15:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au> <20181112042116.5271-2-joel@jms.id.au>
In-Reply-To: <20181112042116.5271-2-joel@jms.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Nov 2018 08:34:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUCBbjppeLEm83+y69ySV=d0E-MZ9eheFKznbhf4m9sw@mail.gmail.com>
Message-ID: <CAK7LNASUCBbjppeLEm83+y69ySV=d0E-MZ9eheFKznbhf4m9sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Export clang toolchain variables
To:     Joel Stanley <joel@jms.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>, dja@axtens.net,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 1:21 PM Joel Stanley <joel@jms.id.au> wrote:
>
> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Applied to linux-kbuild.
Thanks!


>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 09278330282d..840efe6eb54c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,7 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_FLAGS
>  CLANG_FLAGS    += -no-integrated-as
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
