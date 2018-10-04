Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D04C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC621480
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFxCmYry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AC621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJDWHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:07:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37571 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeJDWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:07:21 -0400
Received: by mail-io1-f66.google.com with SMTP id m16-v6so3983946ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFkA/0wrykNoe/6zOrHUhGlT+Q7Jx6eOGkCxdr4cYdk=;
        b=FFxCmYry6eP1yN1ufHNzOppBREw4u/zF406X8tFxqchaGBoGVgsF/1kcm4z8ZECKAX
         4/NMUlx4kQL7yJF/BJx71swkLQt2Jp3klUwoznSDe1v3SUYbNolpwTAMiimEWxJMWp+0
         qXgpMYLrSXgroplVl33QzJbPbBr6sx6SRh5mxhqPuOqg6fLMaKiH7oFRjplEUVAIJuOy
         fb1YjqFlr7DgDgCN9hEV4e5Tw+5LFHdO0h4XpVVQ+sxJTZQzHS9e5GvsJj64IoEhZ1LU
         sXo1z6Q/OJ+BAUrt1jLWrLIxzasExlSoDjv+WYouT8MPb0osWkszYaVIwTQquAP24X9q
         PO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFkA/0wrykNoe/6zOrHUhGlT+Q7Jx6eOGkCxdr4cYdk=;
        b=sHnJOuGVhNkhtEDlyEfQTsmf/CLKyKjWMXsWyz9FHpl66fQg9pMal1ynV2QI83Nuc2
         sgQGH4aT3Sci4edW5mIxDFMSiJ2ASyqOd31sweE4zJvW2pE0kVOq0xpu7Oeo01civ9Az
         g8JVQvA9oRsCvvbb0N8DUHobN4WDmvbs/bEsJHCeBGR5hhlfAPF33/bkb0TLpVt8kgws
         OjGZ9W2zEdtqUikAZKgZ9u1Bze20MaBPLfSqbPxFFh+kL7DdhDT7ST6TwwwkcElp90G5
         vBACTBUfu3xE7DlBvKYh8x4o0/oQEdMvV2IM4zJTuB16dexKgiZSPhSMX8g9R8AseXP2
         1I/Q==
X-Gm-Message-State: ABuFfohiNAb7KpvX6MeKC7jUyBrk8sH2U2h7W9g1p3hT+Z8k6Vv3KFBr
        GaCAHLM2YasLI0YRWY4Vqg3yWtUyfhjkpXQJwtj4pnhmm/A=
X-Google-Smtp-Source: ACcGV62keSvva26IlRF+QlIMv5vQ6CGMfp9ODFrN7mJnnksiY+3GoRWtioauSmtovRhB6mAdu82Xj+U2yVZCAkDxl5Q=
X-Received: by 2002:a6b:e91a:: with SMTP id u26-v6mr4551737iof.200.1538666017780;
 Thu, 04 Oct 2018 08:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181003234746.3586.42014.stgit@localhost.localdomain> <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
In-Reply-To: <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 4 Oct 2018 08:13:26 -0700
Message-ID: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     alexander.h.duyck@linux.intel.com,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 4:25 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 04/10/18 00:48, Alexander Duyck wrote:
> > It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
> > <= physiscal memory size") the logic of the test was changed from a "<" to
> > a ">=" however I don't see any reason for that change. I am assuming that
> > there was some additional change planned, specifically I suspect the logic
> > was intended to be reversed and possibly used for a return. Since that is
> > the case I have gone ahead and done that.
>
> Bah, seems I got hung up on the min_mask code above it and totally
> overlooked that the condition itself got flipped. It probably also can't
> help that it's an int return type, but treated as a bool by callers
> rather than "0 for success" as int tends to imply in isolation.
>
> Anyway, paying a bit more attention this time, I think this looks like
> the right fix - cheers Alex.
>
> Robin.

Thanks for the review.

- Alex

P.S. It looks like I forgot to add Christoph to the original mail
since I had just copied the To and Cc from the original submission, so
I added him to the Cc for this.

> > This addresses issues I had on my system that prevented me from booting
> > with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.
> >
> > Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >   kernel/dma/direct.c |    4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 5a0806b5351b..65872f6c2e93 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
> >
> >       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> >
> > -     if (mask >= phys_to_dma(dev, min_mask))
> > -             return 0;
> > -     return 1;
> > +     return mask >= phys_to_dma(dev, min_mask);
> >   }
> >
> >   int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
