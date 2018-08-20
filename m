Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64035C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140FF2172D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dkJIaSkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140FF2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeHTTc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:32:28 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:28230 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:32:27 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7KGFnMJ008185
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 01:15:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7KGFnMJ008185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534781750;
        bh=o1ATNNpRni3CjWIWizX7ITmWyLUMAxgbGHCvrl/vMR0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dkJIaSkJrsILApGFkvmcY78xYz3mt10UfLV/SosjTHNO+WwBP6Nhz5VjpEM5bshsN
         meACS8c5//oVfRHY7iESF6089gsI1uoDmAGFPP38+zGJFr0bx1ZGLmb/Yv85PGgibX
         i3EDQ8P2HiSjDV8Ddse8jPVoZ5uw2ZVOMR0Qx51cos2MXqPCWOPcQbXfWYeZcTvkHR
         nGS0O6FZYH/pLwibBPA5rf0AKxl7pLwlIva86lHHtQpmWG318aWXpcQvahJDpOxPog
         Vj7dLWJolPkUtAS2ijrhKod3/vFxFhTUzmtiIyGGcN/OxtDz+V+im0ywTq30BCagTG
         k5PWA1steMOGg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id u11-v6so10030328uan.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:15:50 -0700 (PDT)
X-Gm-Message-State: AOUpUlGW403bj5uVUj/zW0sRpg2s381HdFSEDfre4xSk20hl3Bmywodr
        3T94I7+DfoD+dda8nROImKizy51hq7UdPgswu/g=
X-Google-Smtp-Source: AA+uWPx3bSnUDW7In5lUz8hDo+/5DA4FjvRoGEgxcLupvZanZkxnF3LqEn+AYtb2uDwgS2Bfk+ksl/dcRsjXnsjdb+s=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr30817367uag.16.1534781749029;
 Mon, 20 Aug 2018 09:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 09:15:08
 -0700 (PDT)
In-Reply-To: <20180816070518.10441-1-tklauser@distanz.ch>
References: <20180816070518.10441-1-tklauser@distanz.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 01:15:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASB3RQV=_PbB-RsN3akebnBzc+RbfiyrvfishZfhcTUVQ@mail.gmail.com>
Message-ID: <CAK7LNASB3RQV=_PbB-RsN3akebnBzc+RbfiyrvfishZfhcTUVQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: kconfig: remove duplicate DEBUG_STACK_USAGE symbol defintions
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>,
        nios2-dev@lists.rocketboards.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-16 16:05 GMT+09:00 Tobias Klauser <tklauser@distanz.ch>:
> DEBUG_STACK_USAGE is already defined in lib/Kconfig.debug
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> ---
>  arch/nios2/Kconfig.debug | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> index 7a49f0d28d14..f1da8a7b17ff 100644
> --- a/arch/nios2/Kconfig.debug
> +++ b/arch/nios2/Kconfig.debug
> @@ -3,15 +3,6 @@
>  config TRACE_IRQFLAGS_SUPPORT
>         def_bool y
>
> -config DEBUG_STACK_USAGE
> -       bool "Enable stack utilization instrumentation"
> -       depends on DEBUG_KERNEL
> -       help
> -         Enables the display of the minimum amount of free stack which each
> -         task has ever had available in the sysrq-T and sysrq-P debug output.
> -
> -         This option will slow down process creation somewhat.
> -
>  config EARLY_PRINTK
>         bool "Activate early kernel debugging"
>         default y
> --
> 2.18.0.130.g98da2f6b3e4a
>
>



-- 
Best Regards
Masahiro Yamada
