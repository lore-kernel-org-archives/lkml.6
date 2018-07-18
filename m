Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565C2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LJK26YYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6565C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeGSAAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:00:01 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59011 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbeGSAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:00:01 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w6INJiKe017474;
        Thu, 19 Jul 2018 08:19:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w6INJiKe017474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531955985;
        bh=TVuOblHdBPLgFZ+jZWnXvvI1L5ZkTEbEvuAoEAlFXhE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LJK26YYfeD3qD6+8C6M0EoxRBR05rhs7dYYW1T94SFYY9bZhW3UrjA/md3YTQr2W6
         C6pxCYf8ZWQVanxE/tOj0t8X0ibX/ZiDqhtHyOl/8tvIPBVKvaPvMQlByHNphhCizd
         rZtNIFtxqjWSAmmhNDguHgnd7MzlUiMPQUWlC7oTBMIJoIGkUmXeTgHqo7nmzXPlfo
         o+AHNMELliUP42R0lDf4jCiR0qUeWrNJEThD6MtPa3iLDQC4A2dzfgL8Awhf7IDEK2
         IvotJsDloLneVEHxoaor6l3K14RWFr96/Pmgxv29j9VGeh92QWH0dbQlqKjGrVHuHf
         xNTGe7c6j+Q6A==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id b77-v6so3429576vkb.5;
        Wed, 18 Jul 2018 16:19:44 -0700 (PDT)
X-Gm-Message-State: AOUpUlGxHOPXE1nveXqOeK3x6jfjXKFwRs4v9ikDk36QKuztuNJGRwoC
        9yn7e6aajZrT81mY6Y9K5p2LygTrvbE5P2jV+Hs=
X-Google-Smtp-Source: AAOMgpeTZ1u+4ukFzYxmoH0c73Qdq0EE4lVFa0bjDYIXIVFkbk//BCPxe9XdkDwODtx9/EHfH9pBXtxyidZcfb6cXc0=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr4584402vkj.160.1531955983726;
 Wed, 18 Jul 2018 16:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 16:19:03
 -0700 (PDT)
In-Reply-To: <20180718171507.4837-1-major@redhat.com>
References: <20180718171507.4837-1-major@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 19 Jul 2018 08:19:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTdQq4fT_jonzdkQ4rQQQC+zaE0c5gwmrfs3=PrUsNGA@mail.gmail.com>
Message-ID: <CAK7LNATTdQq4fT_jonzdkQ4rQQQC+zaE0c5gwmrfs3=PrUsNGA@mail.gmail.com>
Subject: Re: [PATCH] buildtar: Copy vmlinuz for arm64
To:     Major Hayden <major@redhat.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 2:15 GMT+09:00 Major Hayden <major@redhat.com>:
> Copy the architecture-specific compressed kernel image to the
> directory used to make the tar package.
>
> Signed-off-by: Major Hayden <major@redhat.com>
> ---


Thanks for the patch,
but I applied Olof's one, which copy more files.

https://patchwork.kernel.org/patch/10523811/



>  scripts/package/buildtar | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index e8cc72a51b32..a87c8cbc1ba3 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -80,6 +80,9 @@ case "${ARCH}" in
>         alpha)
>                 [ -f "${objtree}/arch/alpha/boot/vmlinux.gz" ] && cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>                 ;;
> +       arm64)
> +               [ -f "${objtree}/arch/arm64/boot/Image.gz" ] && cp -v -- "${objtree}/arch/arm64/boot/Image.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +               ;;
>         parisc*)
>                 [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>                 [ -f "${objtree}/lifimage" ] && cp -v -- "${objtree}/lifimage" "${tmpdir}/boot/lifimage-${KERNELRELEASE}"
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
