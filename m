Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A48AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548D62075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HRXfz49Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548D62075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeGRX4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:56:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:31021 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGRX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:56:05 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6INFdNf015935;
        Thu, 19 Jul 2018 08:15:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6INFdNf015935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531955740;
        bh=Dja6+Hjd1z6a6C0JA4fEfq/nC8bTxwfB8Tsme7cKm1k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HRXfz49Q7BQXcM93xKjD9OXHRVo1HAdwZJH989V9biIwVfBMFWJQBaKQyGfuHb3gk
         2po2qYTy84dPguUxIa+ArE8Yv3lMaO8X9CABf/OwpkqOhO4yWnA/ze1Zi4zNNJQG2r
         PjHi1f3P6vrjOHmFeKzM0L2MUyqKm2U9+porrL++GABKJECWje/p0LISqNhuZpu5uT
         hdrcmmwDISMXoo3v5TEW6+AhQnQ/WnIfXAvm7Cvfswx/NqQsQl4c949tqAV4H1azqZ
         bxCHHx9ZmtmiaJwSSv8L4q3poZc8DnBb31JrS93pgERjUVEplwc6Uidgq1jQyIVw5I
         w36+QZR4X0ILw==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id o11-v6so4010319uak.5;
        Wed, 18 Jul 2018 16:15:40 -0700 (PDT)
X-Gm-Message-State: AOUpUlFc6+P9RxP8UjCyTHb3+dE8t1cNNIiIOJ8MoGq6TDFQlwa3jzxq
        cI+zs7X8ClHh7gznqEA181DVmojisa4CoZbbKRM=
X-Google-Smtp-Source: AAOMgpdnc1xeFSVQ3DMaYblCw6M3S6zuvBU/o4sSe5R9vJ6AUdR1lb/0xot3zdNfOTMiL9nLHk0qMW2Sp5tkNYhpMy8=
X-Received: by 2002:ab0:e3:: with SMTP id 90-v6mr4939228uaj.52.1531955739275;
 Wed, 18 Jul 2018 16:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:14:58
 -0700 (PDT)
In-Reply-To: <20180713162458.22154-2-olof@lixom.net>
References: <20180713162458.22154-1-olof@lixom.net> <20180713162458.22154-2-olof@lixom.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:14:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNATV78V6EVxAZGsSypD4KrqbkfO2++GP2dMXZ-agzbMMXA@mail.gmail.com>
Message-ID: <CAK7LNATV78V6EVxAZGsSypD4KrqbkfO2++GP2dMXZ-agzbMMXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: buildtar: add arm64 support
To:     Olof Johansson <olof@lixom.net>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-14 1:24 GMT+09:00 Olof Johansson <olof@lixom.net>:
> Make 'make tar-pkg' work on arm64.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---

Applied to linux-kbuild. Thanks!



>  scripts/package/buildtar | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index 55887ac84ee4..d624a07a4e77 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -105,6 +105,14 @@ case "${ARCH}" in
>                         cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>                 fi
>                 ;;
> +       arm64)
> +               for i in Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo ; do
> +                       if [ -f "${objtree}/arch/arm64/boot/${i}" ] ; then
> +                               cp -v -- "${objtree}/arch/arm64/boot/${i}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +                               break
> +                       fi
> +               done
> +               ;;
>         *)
>                 [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
>                 echo "" >&2
> --
> 2.11.0
>



-- 
Best Regards
Masahiro Yamada
