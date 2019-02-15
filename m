Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9193C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716A62089F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="voC3wZzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390396AbfBOHpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:45:11 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18075 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBOHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:45:10 -0500
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1F7iuCe000847;
        Fri, 15 Feb 2019 16:44:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1F7iuCe000847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550216697;
        bh=Y4dNF/RxX3MyGbFoqnUshXrtG1OoIFFX3Cshg6WbBGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=voC3wZzWmGkf4oIfJ5VuvWuGwdoQqiwIpvgMZPqfQ3ON0O5b8fCTETQM2M+79iPYs
         ih5yKwMYf0F3JmxhH6SrmVhohU9Ysv1dq8HgP3t7cyg9ClVj6GUSnVjP728iQkoUS5
         U86HcanXgi1dynef0tBrNson5h1CyG9Y48jAddYsgAN251xIHFQGTNH0d9JidZjida
         2G+/1RAxeoNM32bSZpuQadqM9OAaYiWH9p+9A7nbVz2oiKhD42dyZQzdU90Is6Adg0
         M9bo4WOk5/J8LidFvrGahPZnGhlvJXiep75InAb/WhQzxYbPDFAOEijPF+bQ7SbA9Q
         CAnXGIvouUzbQ==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id z11so2920800uaa.10;
        Thu, 14 Feb 2019 23:44:56 -0800 (PST)
X-Gm-Message-State: AHQUAub1Twba2Wlp22T8GxKrebl7GMRlH8JYWkswI/NUtxU7ztoHUsaP
        vxccW3sVWGZUxiZhcOBB1B4TwQb83B+JiCkHyJQ=
X-Google-Smtp-Source: AHgI3Ia57sZJUh0aDDMa4VhfpTpdjrTfmUBZjQBSj2E7ZBi3yv9XX3+lVFomDn/M0BocUuSx0lJsybIQCmRYC5ggw7A=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr3963841uaj.42.1550216695582;
 Thu, 14 Feb 2019 23:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-12-hch@lst.de>
In-Reply-To: <20190213174005.28785-12-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 16:44:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRv4ksk_bryE_PsHtiojEQos2BY8vQQ1sDcKkdypYH8A@mail.gmail.com>
Message-ID: <CAK7LNAQRv4ksk_bryE_PsHtiojEQos2BY8vQQ1sDcKkdypYH8A@mail.gmail.com>
Subject: Re: [PATCH 11/11] s390: don't redefined the HAS_IOMEM symbol
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
> Rely on the common defintion instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9a25e19364f5..0f62e33ffcb2 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -159,6 +159,7 @@ config S390
>         select MODULES_USE_ELF_RELA
>         select NEED_DMA_MAP_STATE       if PCI
>         select NEED_SG_DMA_LENGTH       if PCI
> +       select NO_IOMEM                 if !PCI


This does not work because NO_IOMEM is defined
in arch/um/Kconfig.


If you want to do this,
you must move NO_IOMEM  to lib/Kconfig.



>         select OLD_SIGACTION
>         select OLD_SIGSUSPEND3
>         select PCI_DOMAINS              if PCI
> @@ -708,9 +709,6 @@ config PCI_NR_FUNCTIONS
>
>  endif  # PCI
>
> -config HAS_IOMEM
> -       def_bool PCI
> -
>  config CHSC_SCH
>         def_tristate m
>         prompt "Support for CHSC subchannels"
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
