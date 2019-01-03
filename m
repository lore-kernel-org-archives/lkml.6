Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D3206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OmK2D4oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfACAhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:37:51 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31982 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfACAhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:37:50 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x030bMVd010621
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 09:37:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x030bMVd010621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546475843;
        bh=uh5ps1utDJ5VURqXSy7MiMM7oi88HSxDEhMn5YEqpcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OmK2D4ojmOEZySLzC2s19fMtnMomOZHYHlrNHBtYwmkUGOhR/LX0HKNqJwlMwwQw5
         Jy1CRlefZWzIlLahuyLSIEH/ob3vzrXGBpfApi1LXKly6BE/bI9aq4zMyDMU0hP0X0
         nBiRNgCpmahF1Td5IfNXQp56w+dokP/YzJgm2spOcdPLxsP6np/nRyl3prQLBxE5i5
         149q2CQ1TvSz05M8UA+UcHGu8wtZdTykcpXQ+5ZT54B5b9md+iYa5xxvVHLgVWte7B
         dffb17s9Zf1OteK0+Gvomf0eW7Zhb38lFddapTElz8mGtdY9haeYQKJbE2t4v3UWT2
         J6nt9OEE6lsMQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id e7so19908392vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 16:37:23 -0800 (PST)
X-Gm-Message-State: AA+aEWb7uikP2jarOhZAHeNzMgpmXVFQevVSXsknCjh1Qn2Ij0cUihF1
        zBo7RFpHkdcyw+S25dDipDKLhlLcB8a+6rgnZFQ=
X-Google-Smtp-Source: AFSGD/UTiJtmkFFED6ECJa92YHrcO7lom/+MwsxZDPUi3K9TzCXIvjKXbJlevqzTu+evCim7JDHCX92ZYRppc3stfuE=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr18204744vsm.181.1546475842146;
 Wed, 02 Jan 2019 16:37:22 -0800 (PST)
MIME-Version: 1.0
References: <1544976205-18762-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544976205-18762-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Jan 2019 09:36:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsp7Jez3eZxM8Zv642=YS0N8cWPN4XY9CRbD2dXDK3tg@mail.gmail.com>
Message-ID: <CAK7LNATsp7Jez3eZxM8Zv642=YS0N8cWPN4XY9CRbD2dXDK3tg@mail.gmail.com>
Subject: Re: [PATCH] csky: remove meaningless header-y
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 1:07 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit fcc8487d477a ("uapi: export all headers under uapi
> directories"), header-y is meaningless because headers under uapi
> are all exported.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.



>  arch/csky/include/uapi/asm/Kbuild | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
> index e02fd44e..7449fde 100644
> --- a/arch/csky/include/uapi/asm/Kbuild
> +++ b/arch/csky/include/uapi/asm/Kbuild
> @@ -1,7 +1,5 @@
>  include include/uapi/asm-generic/Kbuild.asm
>
> -header-y += cachectl.h
> -
>  generic-y += auxvec.h
>  generic-y += param.h
>  generic-y += bpf_perf_event.h
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
