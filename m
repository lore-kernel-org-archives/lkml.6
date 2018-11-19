Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D38C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B8C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEUKMJ/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B8C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeKTJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:48:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34266 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbeKTJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:48:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so7116227wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+76HqNzklzlm65oF4A5Eop034lSD84dJemyLiDCL+M=;
        b=DEUKMJ/DZkeKu8RXYBli00CKPIjndnspaEqpoq8oJuJ3ici/KT0juh6NtyHT0bOUH2
         v2sfSmCcnvYruKVUOJeCcfRu6h2JI+Acl/3cKhOShUWdC0FiJjEsTb2QauKhMyN1D5A2
         C6mcGGIhpmAiRkBUSgZtkbQqyx77sRzlqZWBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+76HqNzklzlm65oF4A5Eop034lSD84dJemyLiDCL+M=;
        b=pPqrqi1HhOuo6KCSIVyVuBPGLY+9KxnQH6uxluDCYu2jFSd65Nf0tRf6UGPJ24BPoz
         SuKXnPUT04Pgan/g2HXbBIBA+8xx4ofGjQ5CRmE7qqM9FUe9A3bPsGGH8LF3d/PbfIyW
         md5xUsmVTESYCZ8swsEoWeFJgaWOuU/NTSNscvOuhKuOHlxR2Awp1EZ828h0zLFU1sap
         Mq/K8nORszXiHO3z6Fl1QWWSNF/4dnyje4hT6k90rbDFttSOuPdec5hgXur7gOMp0Dol
         wdXSwgyikSYt8k7XYPxmtYKm8orcPGcSFP2flo2ly8Tfkoic7ysCJXtZaXX6jsU8Qb5h
         nqCw==
X-Gm-Message-State: AGRZ1gLaZAI6C+yuevn9PG8yJVOvZyV4ibV38B9E16z1eoWavLNCIcGB
        EZa0GvS8HFSOSOnGJT5wBQI6TUU3H1YyIr4IYKUPoA==
X-Google-Smtp-Source: AJdET5eNoI8HxXNI/Ycu3fmK1+pX61hviAhcnS1B8agMkMtbE4r4I5FmpPDlyY2imDW0YijjEANHniMrBzmSWuv4aWE=
X-Received: by 2002:a1c:7fc1:: with SMTP id a184mr79282wmd.55.1542669746703;
 Mon, 19 Nov 2018 15:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de> <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
 <20181114141311.GA26677@lst.de> <20181114161239.GA29462@lst.de>
In-Reply-To: <20181114161239.GA29462@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 19 Nov 2018 15:22:13 -0800
Message-ID: <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in swiotlb_map_sg_attrs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 8:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 14, 2018 at 03:13:11PM +0100, Christoph Hellwig wrote:
> > Does the patch below make a difference for you?  Assigning an
> > address to the S/G list is the only functional difference I could
> > spot.  Drivers really should never look at the S/G list on an
> > error return, but..
>
> And that was obviously just the second half of the patch, so here
> is the full one:
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5731daa09a32..a896f46d0c31 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -786,10 +786,13 @@ swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
>         int i;
>
>         for_each_sg(sgl, sg, nelems, i) {
> -               sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
> +               dma_addr_t dma_addr;
> +
> +               dma_addr = swiotlb_map_page(dev, sg_page(sg), sg->offset,
>                                 sg->length, dir, attrs);
> -               if (sg->dma_address == DIRECT_MAPPING_ERROR)
> +               if (dma_addr == DIRECT_MAPPING_ERROR)
>                         goto out_error;
> +               sg->dma_address = dma_addr;
>                 sg_dma_len(sg) = sg->length;
>         }

I know Robin has already replied with more detailed info, but just to
close the loop as I'm finally home, applying this patch didn't seem to
help with the IO hangs I'm seeing w/ HiKey960.

thanks
-john
