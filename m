Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE26C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD64A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZEMultMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393357AbfBOJcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:32:55 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:18004 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393007AbfBOJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:32:48 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1F9WiWP021101;
        Fri, 15 Feb 2019 18:32:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1F9WiWP021101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550223165;
        bh=HfSfrFBcRoJyhIErWqGfFXClcePQGFMvuVUjWFMMlwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZEMultMubw6PTbXnOiQ4j3Am7weTwSeLXQS5wA15OdLXom6Z7hqHzkekuo+I2blcO
         vAR+pDmWobHMj4YUEW96gHKUa+tKtSTGAu170G6lj+erX2FPQRTcRO2swsBMHbJD+j
         zsiA9oDXMV/yqZsTbGuAFg0JgYMh42veLkJsQeO38UQ2pHT91bqAtmTKn0WfrC0De8
         uKPfhF/si37hpmFxGXDIJ08rmHgx4ntU77RGTUARpl/zVj5ubm6rTCbKKoCfPqjwZh
         fjjQWhOVbHdHKVy4G7GRG5DiO6qO87ZFj59ejtNXraidnHh1tZMa7Zz9wbFqKM7sDZ
         p4yvvsn7gUjvQ==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id z24so2995721ual.8;
        Fri, 15 Feb 2019 01:32:44 -0800 (PST)
X-Gm-Message-State: AHQUAua39Ip+GB0COURzIhuSNbFSVqQDWSgL4onQt14hpFaCUrUhd1p9
        13QlWlZuIU8cwpwML9lcgNftsQsI6tMPHbnlAYQ=
X-Google-Smtp-Source: AHgI3Iad6W2GsRyuHvKDtKafwtV+B2R19XzTGZgV2/dVRurEYChtPO2shkuyCewm1zFfnDvGU1M6QFYs6DCodW81UKs=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr4355489uap.6.1550223163654;
 Fri, 15 Feb 2019 01:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-3-hch@lst.de>
In-Reply-To: <20190213174005.28785-3-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 18:32:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
Message-ID: <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
Subject: Re: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xtensa@linux-xtensa.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
> should just select it if supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Do you want this patch picked up by me?

Or, by Palmer?



> ---
>  arch/riscv/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 515fc3cc9687..b60f4e3e36f4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -94,9 +94,6 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
>
> -config HAVE_KPROBES
> -       def_bool n
> -
>  menu "Platform type"
>
>  choice
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Best Regards
Masahiro Yamada
