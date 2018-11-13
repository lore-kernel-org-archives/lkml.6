Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ACFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371D42082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YS8KyDd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371D42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbeKNJPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:15:25 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:45785 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeKNJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:15:24 -0500
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wADNEUPf022942;
        Wed, 14 Nov 2018 08:14:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wADNEUPf022942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542150871;
        bh=egkPrPm7fr2RnhQfGC47q1IDiOoK95w9GCgiJdQsYV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YS8KyDd/vFyAMLIfdcLHnHR8lxJAiuh0LH0iU2uff5BIJLoxQ8c0geH7SQrefi+Ek
         qZfZq51RtPfe80HtnSdcmGenORAH9c2vZLGZJ+Dv07YlBRJ8ITzz9xuxDkKDGU40vA
         fq/+9SpYjgpTrskBCTqRvoTLw/kSKfvG4qtKLMJ6ye9QQONs1Lv2XOndGsZzSE94wS
         ISCRx7HUFKQ8qSrLHQUCXR38khUKmpCPJvYveStwFkOXTRWSP8fyV1ttlR+/EIyeuC
         /c1xIlKyBJohKB7Na8Qoj4Qnsy1KMSIV09Vr3U+z6ib044oFai9OU6QQY5y18SSlyJ
         24843lE2dFTgQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id e16so3797451uam.12;
        Tue, 13 Nov 2018 15:14:31 -0800 (PST)
X-Gm-Message-State: AGRZ1gJqIeNana0CzeEVUxbXl6H0ItdVd7u9e5YK98FGJ8PUjodsk0me
        FDBDRwu9/G72T+GwHTN/ZZhL3vTiDl/A4Jm33lA=
X-Google-Smtp-Source: AJdET5fmG9wP7IFnOD6PCoJ4vzdJoz4K7+2BW6m0pZw6kZGDvlW2ACpkDNb627LEB83DXF7pp2z2P6NrQIeJmMMdpDA=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr3484772uam.89.1542150870271;
 Tue, 13 Nov 2018 15:14:30 -0800 (PST)
MIME-Version: 1.0
References: <1541995285-11144-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1541995285-11144-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 14 Nov 2018 08:13:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASevj4QQ5-J4QRbwS-vGkvb8VBrvzXVZDUhbHoA=auMxA@mail.gmail.com>
Message-ID: <CAK7LNASevj4QQ5-J4QRbwS-vGkvb8VBrvzXVZDUhbHoA=auMxA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove 'prepare' and 'scripts' dummies for
 external module build
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 1:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Make is lenient enough to ignore missing rules as long as they are marked
> as PHONY. Remove dummy targets.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>
>  Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 766a64e..7508243 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1610,10 +1610,7 @@ help:
>         @echo  '  clean           - remove generated files in module directory only'
>         @echo  ''
>
> -# Dummies...
>  PHONY += prepare scripts
> -prepare: ;
> -scripts: ;
>  endif # KBUILD_EXTMOD
>
>  clean: $(clean-dirs)
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
