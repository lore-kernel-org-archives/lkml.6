Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C15ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97A120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U4EDmaMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97A120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbeGRXzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:55:48 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:30736 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGRXzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:55:47 -0400
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com [209.85.217.170]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6INFNeO015849;
        Thu, 19 Jul 2018 08:15:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6INFNeO015849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531955724;
        bh=/7HPWBOHRbkbVqVORlVexDZgQaff4CHlTZAU268Wbtg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=U4EDmaMJDWNYHozj4U43O0BWFasX1OHdbPepRhwTpbUtLA6+mIz95U3DZx8fY8LSK
         AbUoklVIaiJyhUCJj8n0vYBVQmm+wDWJtqEdYHssn1zEnJs/5IgJ96ib0DP46fljos
         yBxplhxjEgIDMsYOcAY7drXLqKZM0u3R8UrtonC/qOciVnkkUrJzaTvXtCNnU8ufUu
         wQwg+8b1tbcWhu7eYtKYm/LqCmXbolIV9E9HJiRxnM3M94zLw0QHx+5gWqksR+tR33
         yOBy4LhkpIZxbJ+ozJvadaQRjxogfII+rH0P5ry+ytdJLDLw7F9LYnFC6NT9QoDRpa
         AZdIcdLsVW0IQ==
X-Nifty-SrcIP: [209.85.217.170]
Received: by mail-ua0-f170.google.com with SMTP id k25-v6so4002893uao.11;
        Wed, 18 Jul 2018 16:15:24 -0700 (PDT)
X-Gm-Message-State: AOUpUlF0XTBMxwd5lLLAGarsV3dHPynHJuPWgUJ8aDg1jmZtVzl/9Ejs
        9W3si9EC/llZG9ZvQvhesgHr43iXOV5/20A1NH4=
X-Google-Smtp-Source: AAOMgpc6vIBEvQ8tiwgfqWBeSXItJ99gLW/7etDvLVraMbI6/WTn2ZlPkIkkTG5RaANck3g5R4nh7U7hcW49KsbCKj4=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr5184101uaf.199.1531955723133;
 Wed, 18 Jul 2018 16:15:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:14:42
 -0700 (PDT)
In-Reply-To: <20180713162458.22154-1-olof@lixom.net>
References: <20180713162458.22154-1-olof@lixom.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:14:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-xU_YOw2ox8iZvguj8w6yVZmiG560rPxnVh2DyDjvCg@mail.gmail.com>
Message-ID: <CAK7LNAT-xU_YOw2ox8iZvguj8w6yVZmiG560rPxnVh2DyDjvCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: buildtar: remove crufty vax pieces
To:     Olof Johansson <olof@lixom.net>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-14 1:24 GMT+09:00 Olof Johansson <olof@lixom.net>:
> ARCH=vax isn't in mainline; it can be added back if/when it shows up.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---

Applied to linux-kbuild. Thanks!


>  scripts/package/buildtar | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index e8cc72a51b32..55887ac84ee4 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -84,10 +84,6 @@ case "${ARCH}" in
>                 [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>                 [ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
>                 ;;
> -       vax)
> -               [ -f "${objtree}/vmlinux.SYS" ] && cp -v -- "${objtree}/vmlinux.SYS" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.SYS"
> -               [ -f "${objtree}/vmlinux.dsk" ] && cp -v -- "${objtree}/vmlinux.dsk" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}.dsk"
> -               ;;
>         mips)
>                 if [ -f "${objtree}/arch/mips/boot/compressed/vmlinux.bin" ]; then
>                         cp -v -- "${objtree}/arch/mips/boot/compressed/vmlinux.bin" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
