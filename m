Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B767217C5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sh/hx+sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B767217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeHMKUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:20:07 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:53224 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:20:07 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7D7cwb8031708
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:38:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7D7cwb8031708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534145939;
        bh=lwj47P6rSPW/NUY7WgUbCmcOCcLfePvNn/67AT15lGU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sh/hx+sHRWqd1ahXUUnZMs7kr5t9o4J9ZM0TmAXzfFMSMGyKOeCod5q4XEVqZqmQg
         wT6quLGKaXnKLiinVykWA5SDKy4Y8n9D4PXFTSl09/C5SsyEtB1zoyS/9Tx9BtF2NW
         jfjKcKLIoaihR+sDig9vhQ83EpvfAqJEzRlpaUWIPfnFAGEXQCgt49QMeycrlWwp4S
         kbBPoM2j4e8zexR2V7RzxzHP01aMG8PEeITyoV5axi55Z2/J+9l9lzhEo44A78+FuV
         +e6m2CoJmNjfy6MWkgP1exNYkmYb/4e8U0KwSEk8qsNwEdHOIT88sif1CgnnvWUxVy
         ux/7skGJYGT6Q==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id q12-v6so8148135ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 00:38:58 -0700 (PDT)
X-Gm-Message-State: AOUpUlG765FLcAn6xeTEftNybS0vFzswpx6G7d/GzmPlbdjan4XZnx64
        CHAnox2ireISYTGEjtJrgqzhpn7+JZONqiqinAY=
X-Google-Smtp-Source: AA+uWPwv9u0c9H2h824jeaEymI3IR7grZPjoO109zW3oVx7FRMtDeKIsBhwNiZdc6CpBj2Xz1o6af0dSWZQF9zT9YMQ=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr10849338uai.17.1534145937911;
 Mon, 13 Aug 2018 00:38:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 00:38:17
 -0700 (PDT)
In-Reply-To: <20180811094853.32167-1-stefan@agner.ch>
References: <20180811094853.32167-1-stefan@agner.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 13 Aug 2018 16:38:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
Message-ID: <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: require GCC
To:     Stefan Agner <stefan@agner.ch>, Kees Cook <keescook@chromium.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, jbacik@fb.com,
        Emese Revfy <re.emese@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-11 18:48 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> Unsurprisingly GCC plugins require GCC as a compiler. This avoids
> GCC plugins being selectable when using clang.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1aa59063f1fd..8c693a837ed7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -422,7 +422,7 @@ config HAVE_GCC_PLUGINS
>
>  menuconfig GCC_PLUGINS
>         bool "GCC plugins"
> -       depends on HAVE_GCC_PLUGINS
> +       depends on HAVE_GCC_PLUGINS && CC_IS_GCC
>         depends on PLUGIN_HOSTCC != ""
>         help
>           GCC plugins are loadable modules that provide extra features to the
> --
> 2.18.0
>

I guess the more correct way is to fix
scripts/gcc-plugin.sh

This shell script should exit 0
only when GCC plugin is supported.

Kees?



-- 
Best Regards
Masahiro Yamada
