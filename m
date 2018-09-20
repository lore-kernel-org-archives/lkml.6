Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B56ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC782146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vK0TGaDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC782146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeITJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:40:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43534 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387451AbeITJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:40:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id g53-v6so7243450qtg.10;
        Wed, 19 Sep 2018 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+K2MGlgvBhJZwSb9104yAlKXqp+Nr5/6etFYNZhUqA=;
        b=vK0TGaDyKDrg9nARKDoogokG31cJ2n4IX8gOsde3JGoYukIspXXMbfLpbhMNyyy0BY
         Co/PZIZfbiL6PaX/wM5aImVNj8fCOqvp2mCS0zkcY4vIyokZx6UvGRhBlWPUGC8ajmY0
         dkKl6dJj3TzNqUCDf//e44UHGtVjPTCCQBhm0RCCYVUy8YBTCN8He4MFAdZbfjDwmR7V
         TfP6DBgT66PnWGY3QDY+mHBnZ0JeMXy6gBw/OYCIQhrlP4IcG1Y3zgWI70wYMjBsF8Ig
         19FBS8We0WbS5tcGK2a6c+7JGMAF5TiTHZmlI6aaoV3bLU3+0imuJ4jABIhTe/8pEdEP
         kvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+K2MGlgvBhJZwSb9104yAlKXqp+Nr5/6etFYNZhUqA=;
        b=WOIrAESs8nATenaA9pJ2seCVsYiEikGHckYZuf0u0XzWuUOdA0W5XdGS9SktnSZ6ME
         gSE3qZQEctPyEe3X8sgdJjqpvlGJ/qofAiR2ePz1S58P4g8x2XwHLNyk+ngNlSCCScns
         tucHDrqHDvUbTtISPDwlnEO9sZcbl3ObLXGG+pQyimVs+oRHHVIg8+xFCwDr30LLrQhN
         pamn0aB7ypG9lJSAbgNIKjtTjvRNRcot+Xos7ntkbxwRNddbDogW/l6WsaSzWs7Ebipy
         eymJReggd8l1mw3kQTkjzhtWmrDeCk3c7LIz2jdT3UAxZpbQYB3nqitQpUS5XwbGBlMV
         CRLA==
X-Gm-Message-State: APzg51CvpA1ThFSvUYH2qXbDlDHFCbzOgbIJ07szWEVYhKmNKv0l2A9a
        Q04Y1efFPyCuEu1DNXxUCHnxIuSMng76SYtMAz8=
X-Google-Smtp-Source: ANB0VdbKA30La4tzMIgJoMbxKWmRLtHeekHcDCyTUXpJkRyRGplhyDG9afhoXFMfDFN09wMxYL5V2/dNzae8Xs6TY7s=
X-Received: by 2002:a0c:a91a:: with SMTP id y26-v6mr26899811qva.133.1537415959781;
 Wed, 19 Sep 2018 20:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <877ejh3jv0.fsf@vitty.brq.redhat.com> <20180919100256.GD23172@ming.t460p>
 <8736u53fij.fsf@vitty.brq.redhat.com> <20180920012836.GA27645@ming.t460p>
In-Reply-To: <20180920012836.GA27645@ming.t460p>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Sep 2018 20:59:07 -0700
Message-ID: <CAHbLzkrq-CSBK8p-GbUgkhP0tMbA53=Es3v8Zw26qmf2t_vSQQ@mail.gmail.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     ming.lei@redhat.com
Cc:     vkuznets@redhat.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dchinner@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hch@lst.de, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, Sep 19, 2018 at 01:15:00PM +0200, Vitaly Kuznetsov wrote:
> > Ming Lei <ming.lei@redhat.com> writes:
> >
> > > Hi Vitaly,
> > >
> > > On Wed, Sep 19, 2018 at 11:41:07AM +0200, Vitaly Kuznetsov wrote:
> > >> Ming Lei <tom.leiming@gmail.com> writes:
> > >>
> > >> > Hi Guys,
> > >> >
> > >> > Some storage controllers have DMA alignment limit, which is often set via
> > >> > blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.
> > >>
> > >> While mostly drivers use 512-byte alignment it is not a rule of thumb,
> > >> 'git grep' tell me we have:
> > >> ide-cd.c with 32-byte alignment
> > >> ps3disk.c and rsxx/dev.c with variable alignment.
> > >>
> > >> What if our block configuration consists of several devices (in raid
> > >> array, for example) with different requirements, e.g. one requiring
> > >> 512-byte alignment and the other requiring 256?
> > >
> > > 512-byte alignment is also 256-byte aligned, and the sector size is 512 byte.
> > >
> >
> > Yes, but it doesn't work the other way around, e.g. what if some device
> > has e.g. PAGE_SIZE alignment requirement (this would likely imply that
> > it's sector size is also not 512 I guess)?
>
> Yeah, that can be true if one controller has 4k-byte sector size, also
> its DMA alignment is 4K. But there shouldn't be cases in which the two
> doesn't match.
>
> >
> > >
> > > From the Red Hat BZ, looks I understand this issue is only triggered when
> > > KASAN is enabled, or you have figured out how to reproduce it without
> > > KASAN involved?
> >
> > Yes, any SLUB debug triggers it (e.g. build your kernel with
> > SLUB_DEBUG_ON or slub_debug= options (Red zoning, User tracking, ... -
> > everything will trigger it)
>
> That means the slab always return 512-byte aligned buffer if the buffer
> size is 512byte in case of no any slab debug options enabled.
>
> The question is that if it is one reliable rule in slab. If yes, any
> slab debug option does violate the rule.

Once slub debug (i.e. red zone) is on, it will append extra bytes to
the object, so the object may look like:

-----------------------------------------------------------------
| object   | red zone | FP | owner track | red zone |
------------------------------------------------------------------

This is how slub debug is designed and how it works.

CC to Chris Lameter who is the maintainer of SLUB.

Regards,
Yang

>
> The same is true for 4k alignment and 4k sector size.
>
> I think we need our MM guys to clarify this point.
>
>
> Thanks,
> Ming
>
