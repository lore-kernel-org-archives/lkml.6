Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9611C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71C7208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ApMvS+P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71C7208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHTST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:19:57 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:47591 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeHTST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:19:56 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7KF3nnc020496
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 00:03:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7KF3nnc020496
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534777430;
        bh=nR5DtJy+O7ogwNcWy066ETtMzfWxlgbRh8aMZI7pNmI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ApMvS+P5EbtpoTRBD/HFFAbw1J6DIv+SElcruwtPyTU4bZi+BjZ7MV4Jv3iNGlklQ
         XcKzWROInAbj7hXUIsOniPxCJpphbgTxwbpFFnaKwu0R5hPHdGd+HP2e/BPTr2WwY5
         iAsWrYoJVp/YOztIW8GSEXfm4rv4AmYyGklXrzQEiIfhxu3CE3USLx4+lvdPSKqAWI
         qNPX0acfUmfxNKTC1fZDPuHluUroycHdWjG3cIRQi/vJWuswzTVsqyx+y1oNCs8rjL
         aEKIBWXFVYJ6IdJntRt2ohRKCW/7dD9Why/o3tL8fcJTZuZSFXVxFgwTmXjKefzJSK
         QwbV7yS27gieA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id h1-v6so9895647uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 08:03:49 -0700 (PDT)
X-Gm-Message-State: AOUpUlHVmWt+iYCjJHs6ud/W4erDZcLwby0TZ2S+emRnMMy1baDNzpzT
        Jsxs5x/reWj7ZLDDPXbWxiBa9XmyHIKDIZndHPk=
X-Google-Smtp-Source: AA+uWPwqFGrsOdBDjFOJdUbHcJ/vtPvg61uL4J7IiJwgZcSM2iDxQl+hDxQAD3AXITwTwwwxKpgWDCbGh780AccsUdk=
X-Received: by 2002:ab0:30ce:: with SMTP id c14-v6mr30352420uam.58.1534777428424;
 Mon, 20 Aug 2018 08:03:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 08:03:08
 -0700 (PDT)
In-Reply-To: <20180817120319.21002-1-andrzej.p@samsung.com>
References: <CGME20180817120447eucas1p1dde0176cf7d824e8a42e2d39ac5531f9@eucas1p1.samsung.com>
 <CAK7LNASUsZB--DWMB4hpw74OnTiz+d2jrdp+CA9L=AOdkbEmhg@mail.gmail.com> <20180817120319.21002-1-andrzej.p@samsung.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 00:03:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3K3Z=R3=UdKh22LVLDKDfBReYWT1mtep=2DteonTnJw@mail.gmail.com>
Message-ID: <CAK7LNAT3K3Z=R3=UdKh22LVLDKDfBReYWT1mtep=2DteonTnJw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: make sorting initramfs contents independent of locale
To:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-17 21:03 GMT+09:00 Andrzej Pietrasiewicz <andrzej.p@samsung.com>:
> Some LANG values (e.g. pl_PL.UTF-8) cause the sort command to output
> files before their parent directories, which makes them inaccessible for
> the kernel. In other words, when the kernel populates the rootfs, it is
> unable to create files whose parent directories have not been yet created.
>
> This patch makes sorting use the default (LANG=C) locale, which results in
> correctly laid out initramfs images (parent directories before files).
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> ---


Applied to linux-kbuild. Thanks!


>  scripts/gen_initramfs_list.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
> index 10e528b..0aad760 100755
> --- a/scripts/gen_initramfs_list.sh
> +++ b/scripts/gen_initramfs_list.sh
> @@ -174,7 +174,7 @@ dir_filelist() {
>         ${dep_list}header "$1"
>
>         srcdir=$(echo "$1" | sed -e 's://*:/:g')
> -       dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" | sort)
> +       dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" | LANG=C sort)
>
>         # If $dirlist is only one line, then the directory is empty
>         if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
