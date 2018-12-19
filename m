Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9BAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D84921871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z3mUSPpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeLSISv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:18:51 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41657 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeLSISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:18:50 -0500
Received: by mail-yb1-f196.google.com with SMTP id e124so7541763ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhHRctd/XqQnCYeEth+JKGS9rV5kdfu9x8MbR/nYHqA=;
        b=Z3mUSPpMBqrVISWypSsUV3Uk7yalWO+6tVXRckFg0hFhHekN9Go+A8p1WcSRDadDVJ
         tY73oeOzdvEyF+QrGrIzRpOMpUJ1Kj4CLNTIjopc6pbdSdELm6l8GIbofaNrmjxnkEKz
         +m5axO0v9jVp+ueBvx7W2goRn5L3Hy/RZQLIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhHRctd/XqQnCYeEth+JKGS9rV5kdfu9x8MbR/nYHqA=;
        b=nRwYQa3fN4KRDlPkzF2MlshMQoIEPmDX3A3fDF4740nozZudGB0/0zK61jFEXyaHDh
         uJvtCPGHuCdwOFZmjr8I+zm0y23j5IPKu56gRKiB0aC5yhQ1jdPRNZLYrgABM/LqrnMc
         2PNlw4WB3AF9iJSEYwzzNGpaj/2YMLi4d9ZWKom86ASWIst3g9K27WcXDGD8TcfdtY85
         vp1o8BDJuV+xOzrWsARJpKNTLjgSh63VWjxIspF2LeeC+5yUh+/4sfYEa/6iMtNKMnWu
         w/o8dUBdkJ3ZJOkjVXb/bKoOsYWelT1y79RrxFOizaEXcNXTpnZuO7K2sIPOuusy+gI4
         oQqw==
X-Gm-Message-State: AA+aEWYlwyPEopop/OBZxPxg5BHkJ2BQC6skmVEOZnmeKZkMqWnfdAVq
        uStLWMS7MUA9Be+slLmgXWHj35gycgg=
X-Google-Smtp-Source: AFSGD/U4lYbeD4OnsFsKRwOv4UACAM8l2VAycmxnJHdBYT9Fe2Ptq7L6R9feBX2MM04DT7Cfc/Hi9w==
X-Received: by 2002:a25:8582:: with SMTP id x2mr19249812ybk.199.1545207529609;
        Wed, 19 Dec 2018 00:18:49 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id o14sm9214421ywo.52.2018.12.19.00.18.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:18:48 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id d2so7550156ybs.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:18:47 -0800 (PST)
X-Received: by 2002:a25:910f:: with SMTP id v15mr20413719ybl.285.1545207526870;
 Wed, 19 Dec 2018 00:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20181212090917.GA30598@infradead.org> <CAAFQd5DhDOfk_2Dhq4MfJmoxpXP=Bm36HMZ55PSXxwkTAoCXSQ@mail.gmail.com>
 <20181212135440.GA6137@infradead.org> <CAAFQd5C4RbMxRP+ox+BDuApMusTD=WUD9Vs6aWL3u=HovuWUig@mail.gmail.com>
 <20181213140329.GA25339@infradead.org> <CAAFQd5BudF84jVaiy7KwevzBZnfYUZggDK=4W=g+Znf5VJjHsQ@mail.gmail.com>
 <20181214123624.GA5824@infradead.org> <CAAFQd5BnZHhNjOc6HKt=YVBVQFCcqN0RxAcfDp3S+gDKRvciqQ@mail.gmail.com>
 <20181218073847.GA4552@infradead.org> <CAAFQd5AT3ixnbZRm3TOjoWrk2UNH0bXqgR+Z8wyjMhr0xHtSOg@mail.gmail.com>
 <20181219075150.GA26656@infradead.org>
In-Reply-To: <20181219075150.GA26656@infradead.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 19 Dec 2018 17:18:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DJPDpFDxU_m2r02bA59J8RCHW7iE8zYQUmkL4sFSz05Q@mail.gmail.com>
Message-ID: <CAAFQd5DJPDpFDxU_m2r02bA59J8RCHW7iE8zYQUmkL4sFSz05Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>, hdegoede@redhat.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        rostedt@goodmis.org, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 4:51 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Dec 18, 2018 at 06:48:03PM +0900, Tomasz Figa wrote:
> > > So as I said you can call dma_alloc_attrs with DMA_ATTR_NON_CONSISTENT
> > > in a loop with a suitably small chunk size, then stuff the results into
> > > a scatterlist and map that again for the device share with if you don't
> > > want a single contigous region.  You just have to either deal with
> > > non-contigous access from the kernel or use vmap and the right vmap
> > > cache flushing helpers.
> >
> > The point is that you didn't have to do this small chunk loop without
> > DMA_ATTR_NON_CONSISTENT, so it's at least inconsistent now and not
> > sure why it could be better than just a loop of alloc_page().
>
> You have to do it if you want to map the addresses for a second device.
>

The existing code that deals with dma_alloc_attrs() without
DMA_ATTR_NON_CONSISTENT would just call dma_get_sgtable_attrs() like
here:

https://elixir.bootlin.com/linux/v4.20-rc7/source/drivers/media/common/videobuf2/videobuf2-dma-contig.c#L366

and then dma_map_sg() for the other device like here;

https://elixir.bootlin.com/linux/v4.20-rc7/source/drivers/media/common/videobuf2/videobuf2-dma-contig.c#L283

> > > I would advice against new non-consistent users until this series
> > > goes through, mostly because dma_cache_sync is such an amazing bad
> > > API.  Otherwise things will just work at the allocation side, you'll
> > > just need to be careful to transfer ownership between the cpu and
> > > the device(s) carefully using the dma_sync_* APIs.
> >
> > Just to clarify, the actual code isn't very likely to surface any time
> > soon. so I assume it would be after this series lands.
> >
> > We will however need an API that can transparently handle both cases
> > of contiguous (without IOMMU) and page-by-page allocations (with
> > IOMMU) behind the scenes, like the current dma_alloc_attrs() without
> > DMA_ATTR_NON_CONSISTENT.
>
> Is the use case to then share the memory between multiples devices
> or just for a single device?  The latter case is generally easy, the
> former is rather more painful.

The former, but the convention has been to assume that the userspace
will choose the right (the most constrained typically) device to
allocate from or otherwise handle the import failure (e.g. by falling
back to copying into a buffer allocated from the importer).

Best regards,
Tomasz
