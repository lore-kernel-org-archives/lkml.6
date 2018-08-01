Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A9EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66D20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CptNIIwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB66D20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbeHBA6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:58:55 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:59160 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeHBA6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:58:55 -0400
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w71NAem7009166;
        Thu, 2 Aug 2018 08:10:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w71NAem7009166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533165041;
        bh=XlYhzQNfDtlLZ3X3s069FCdtFnMdyAsBO6I6OQe4Nx8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CptNIIwpuPKalkLQVi2ndF0i3dbkAHoM8+7kGBs6aorB4Es0lHz7Sj6aY4fJ56eCp
         fypyjaWo/vLGDHDdviv02H6Z21dMvwEEVn4VS5OVBH7BOAkxlHEEw/GNnoyANYeoJ4
         Dzsb6no1Epk8+S/SyN1WPOVQULejkZeJ/7+9ak0KwKWU/eyjJtaXG3BFshzXvGau2t
         BdNkDUkAIEwCOyo9Ftkt60L9l8+WW44M5GXeTjfbunnpvkvSbAe9Cl1bR7wO1tMaNq
         fnV7O16gxHEBY3jwACJdKLPVzppd8g4+U27APHs6AC2snfRSBa+WzzlKKgXgx2EnMd
         8GFA5jQTqVu/w==
X-Nifty-SrcIP: [209.85.217.177]
Received: by mail-ua0-f177.google.com with SMTP id y10-v6so209868uao.4;
        Wed, 01 Aug 2018 16:10:41 -0700 (PDT)
X-Gm-Message-State: AOUpUlGXROQiE+fo4nmp99sVAyHw9p7RwiGHExjZWVmvhEE2mBlOKEhp
        o0/AUvIT9JxNDCOLywubgMxVTZRWXK4E+oB04/o=
X-Google-Smtp-Source: AAOMgpcblDs6U0xtcMBddII/AgGKkOnQaF2J9AsFQbBU5BMG+1Kx1XmsDn2BWl4r3QBL+Eu2chOdDre3/rmAxfpRc9c=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr257532ual.141.1533165040441;
 Wed, 01 Aug 2018 16:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 16:10:00 -0700 (PDT)
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 2 Aug 2018 08:10:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASpOWQqNREQ_XN22QQM6Jx4F1Lrf76=_WHupPCFmOB2gA@mail.gmail.com>
Message-ID: <CAK7LNASpOWQqNREQ_XN22QQM6Jx4F1Lrf76=_WHupPCFmOB2gA@mail.gmail.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-31 20:39 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Hi Masahiro,
>
> what do you think about the series below, which moves the includes
> of all the architecture independ Kconfig files to the top-level
> Kconfig instead of duplicating the includes in all architectures?
>
> Note that this only handles the low-hanging fruite, there are a lot
> of other bits that should probably be cleaned up to be common,
> but those will be not entirely trivial.
>
> Changes since v3:
>  - don't allow to select PREEMPT_COUNT for architectures that don't
>    implement it
>  - fix usage of SUBARCH=i386 and SUBARCH=x86_64 for um
>
> Changes since v2:
>  - fix the missing sh conversion
>  - handle the lack of CONFIG_SWAP support in microblaze and nios2
>    properly
>
> Changes since v1:
>  - add back a remove source statement from arch/arm/Kconfig
>  - various fixes from Randy
>  - various UML patches to be able to use the common Kconfig
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Applied.  Thanks!

-- 
Best Regards
Masahiro Yamada
