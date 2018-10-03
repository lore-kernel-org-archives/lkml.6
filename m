Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF5F213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAS3H7iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF5F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJDGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:01:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36135 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJDGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:01:21 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so11466153itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkneyoPSzQoLcAs/axE/9Wn7NDHDcegu/815uCyWtMQ=;
        b=aAS3H7iR7tKCn18Bu+R32muRHNGmesECifoN6+HaBzwzWou8RvaJKS5mvdhzMIP50o
         3yBpvLrKH1OBDLET7sSFa3XI+zP37X9cskU3e6dfd6anZTptDHDLbQ+HIey2iu/93dvS
         Ui0s3EsCBaTLwQ/FzIcdINEVUnxqHNCnAo13e1ur0jl9DL1EasnhqEppccKEHMudUSxM
         JdcefefdmeAvHgKKdygewMnQxkLcTdd8MaK/7g04fW2f4KN4EAyGAvC8MnS3hbUtiC08
         p61jtfmN0EeN+oIFyrasdH5vtC8FtRqf0S5Sr4pbsYKIIfeTu1ATQJYrVoc7X1vxG2RV
         3cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkneyoPSzQoLcAs/axE/9Wn7NDHDcegu/815uCyWtMQ=;
        b=CT7eZXNwQ1CZaKlYXEtnTEgA1gGTBn/UjSKc9DcBYRKOM3D3BqP1SxbI5KgyNk+tpR
         ghN+7EXnFoPSC9Mx7M3GqptT1Vonupc2LjimkyvCp4Mpg/qxyO51bzjNGHcvqlZIjNNN
         Cck2UpBjzEL858cXA2IZI7N8BE8fosVp/OGbmyGqMdqTpksxAiWXnOMnXQkbSSS1Ffjk
         tT748QB1/3+yKX+THiMvWTmKJXdoxYpAt9VlHKLOG0hAUvVsjd7xbp+NKD+GdjZWDq8A
         eQRguWQGRRIRPH9NsxmkrGIMgpZOhw7OOTkj54VjMMGepqB0cmPj7q8fT5A2LZPXaN/9
         18uA==
X-Gm-Message-State: ABuFfoiMAqDtGGS90VZYaR0QAsfHa4Kj66TYO7DCLBzx4VH3PTbfX3jB
        hK3y65nDm0/qhJTxYB/L0LrUDS6Sp67eJ6dQe5o=
X-Google-Smtp-Source: ACcGV61yJGqdImxFUQ185ncRCzs26khJfftTvba1wTU1tDyNNhtXksshLE/PMTxBzPFSN0y2EGlBjQoQF4a5iZfz1x0=
X-Received: by 2002:a02:3d8e:: with SMTP id n136-v6mr3010705jan.87.1538608253265;
 Wed, 03 Oct 2018 16:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180927223539.28449-1-hch@lst.de> <20180927223539.28449-6-hch@lst.de>
In-Reply-To: <20180927223539.28449-6-hch@lst.de>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 3 Oct 2018 16:10:42 -0700
Message-ID: <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
To:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This way an architecture with less than 4G of RAM can support dma_mask
> smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
> case on powerpc.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/direct.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 60c433b880e0..170bd322a94a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -284,21 +284,25 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>         return nents;
>  }
>
> +/*
> + * Because 32-bit DMA masks are so common we expect every architecture to be
> + * able to satisfy them - either by not supporting more physical memory, or by
> + * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
> + * use an IOMMU instead of the direct mapping.
> + */
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> -#ifdef CONFIG_ZONE_DMA
> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
> -               return 0;
> -#else
> -       /*
> -        * Because 32-bit DMA masks are so common we expect every architecture
> -        * to be able to satisfy them - either by not supporting more physical
> -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> -        * architecture needs to use an IOMMU instead of the direct mapping.
> -        */
> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> +       u64 min_mask;
> +
> +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> +       else
> +               min_mask = DMA_BIT_MASK(32);
> +
> +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> +
> +       if (mask >= phys_to_dma(dev, min_mask))
>                 return 0;
> -#endif
>         return 1;
>  }

So I believe I have run into the same issue that Guenter reported. On
an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
all probe attempts for various devices were failing with -EIO errors.

I believe the last mask check should be "if (mask < phys_to_dma(dev,
min_mask))" not a ">=" check.

- Alex
