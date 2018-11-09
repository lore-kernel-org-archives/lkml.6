Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4275C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCBC20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dTaE2r/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCBC20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeKJAow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:44:52 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51611 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeKJAow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:44:52 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wA9F3n81003024;
        Sat, 10 Nov 2018 00:03:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wA9F3n81003024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541775830;
        bh=lnl0k8/exJjW0C8pJHoI2ZQSB0LBILxRMe+ld0cwDL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dTaE2r/7qYAia5IdOxt0b0cXlHNmddyE3jw2GTkAsvDlJzUiSskqCpUeb0jF6Bs48
         sNv362YmpnOaRZY7GNt5EBEcNJoq9ETQ3bxrTU6NdQ2WLKgAFjrNB9Mns4vUc3ETfM
         yXV35FLCpBDjxGdtFRieYN96PoUrZCIMyOmPEnCZDpfOG7zZaAxgrRnh9EQ18PdR2f
         C7/kmk31Iz9SDoYDHG14ShuwA1O7ZUt1zF/igOPXD7gaar0cz69MYDzvSl15x53pdh
         Xu5GA3dC+UhYCgfTAvvDMaL7OIVwcibQPtbOjxDVQdHzlVbnOrAU8QbEay3Z2zqoXW
         uY8jtPz5hTjwA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h78so1184688vsi.6;
        Fri, 09 Nov 2018 07:03:50 -0800 (PST)
X-Gm-Message-State: AGRZ1gLcEZA4wYnBSI1BioEganXukD0dSjnkE46riZFAeGrt0fK2SGFk
        qnZn/LQGtsZlVopxHQRCtgDWlgSXAtwyJU0q/to=
X-Google-Smtp-Source: AJdET5diGZjjgsoIQg5UtwR1iRoSHjCpZhCDIPI6f5DgVhHs5RPh2C8zbvvNaS9poF1HR47FE9ArO0hXne8er+uv7PU=
X-Received: by 2002:a67:385a:: with SMTP id f87mr3948463vsa.179.1541775829153;
 Fri, 09 Nov 2018 07:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20181105151719.4552-1-changbin.du@gmail.com>
In-Reply-To: <20181105151719.4552-1-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 00:03:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFMPn2SN5vShCWX94UbTGF5WY6fjnVnS8ZFmFpXj-TpQ@mail.gmail.com>
Message-ID: <CAK7LNARFMPn2SN5vShCWX94UbTGF5WY6fjnVnS8ZFmFpXj-TpQ@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: make CC_OPTIMIZE_FOR_DEBUGGING visible only
 for GCC
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 12:18 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Currently CC_OPTIMIZE_FOR_DEBUGGING is only able to build with GCC.
> For clang, -Og optimization level could break kernel build. So make
> CC_OPTIMIZE_FOR_DEBUGGING visible only for GCC.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---

I squashed this into the previous patch in the kbuild tree.

Thanks!


>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 0fb9c0b5f1a1..d5fb0ee1400a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1107,6 +1107,7 @@ config CC_OPTIMIZE_FOR_SIZE
>
>  config CC_OPTIMIZE_FOR_DEBUGGING
>         bool "Optimize for better debugging experience (-Og)"
> +       depends on CC_IS_GCC
>         depends on $(cc-option,-Og)
>         select NO_AUTO_INLINE
>         help
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
