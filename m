Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF3021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NWgKmKJD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CRKme+3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF3021529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeITQIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:08:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeITQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:08:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC51D60BEE; Thu, 20 Sep 2018 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537439134;
        bh=y/wPte5Qs1sIyPnBTasvuk/KdKz9JN8ggLlH9ObaHq0=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=NWgKmKJDTeosjpc2gMbC0qgXu9vYdDD+cJlipYSIgAIC8E1mW0WcufZoDC/qYuGqx
         dX/XGyXGgj8O3iZR2+2cNjgNRynGhFybZQGE/uHuQyXcqCTTlV6v3HzF8vf7fueFIQ
         ORp0iGym/5sSpMk/iaCqRWtdE7Xl9AesbO6h9ptk=
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B25AC60BEE;
        Thu, 20 Sep 2018 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537439132;
        bh=y/wPte5Qs1sIyPnBTasvuk/KdKz9JN8ggLlH9ObaHq0=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=CRKme+3M6L8Fef3OwM5NCYATLOqLhtroNcyuXIMYBODLRkDKbAkAQU7k1BZJ4QpEk
         otQwfl7vXHQ01i9QCVvRr2UQnqtPupLTAWXgW+kLvQTHtTfoar3yefEnPtoFKvwYDn
         XjuLCJ3gmBFSbkC9KKVZQmZLmFrR4SK/DwJIcI7c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B25AC60BEE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f179.google.com with SMTP id g53-v6so7909755qtg.10;
        Thu, 20 Sep 2018 03:25:32 -0700 (PDT)
X-Gm-Message-State: APzg51B0/BSFegpjYVTOb5OErF4bD09xo9wRkwl6KGwBb94Ezlab4E+c
        fT+3JJf7iWpw8TJoCo7V0VCRR3vs0oWeQtPOHNk=
X-Google-Smtp-Source: ANB0VdbHpbcdGf51Yi+LIIFs0vRfWwGtVABTxUHMqRgUUfozXRJ4ldR7BlEKIi3ypfFUe4PY7+1Ez4z5Og6gw3QfoQo=
X-Received: by 2002:ac8:218d:: with SMTP id 13-v6mr26464778qty.122.1537439131938;
 Thu, 20 Sep 2018 03:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com> <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
 <20180627163749.GA8729@arm.com> <CAFp+6iHnA1Jj8wKO08YYEBKVF2_3oEuOQOcW2boL=AYZ9+b=UA@mail.gmail.com>
 <20180919193539.GB809@jcrouse-lnx.qualcomm.com>
In-Reply-To: <20180919193539.GB809@jcrouse-lnx.qualcomm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 20 Sep 2018 15:55:20 +0530
X-Gmail-Original-Message-ID: <CAFp+6iG5s+_vDsXf6+2PCCTizN+-nkGa8O8TSTjkwMMOzkgfNg@mail.gmail.com>
Message-ID: <CAFp+6iG5s+_vDsXf6+2PCCTizN+-nkGa8O8TSTjkwMMOzkgfNg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        pdaly@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 1:05 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Tue, Jul 24, 2018 at 03:13:37PM +0530, Vivek Gautam wrote:
> > Hi Will,
> >
> >
> > On Wed, Jun 27, 2018 at 10:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > Hi Vivek,
> > >
> > > On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> > >> On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > >> > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> > >> >> Qualcomm SoCs have an additional level of cache called as
> > >> >> System cache or Last level cache[1]. This cache sits right
> > >> >> before the DDR, and is tightly coupled with the memory
> > >> >> controller.
> > >> >> The cache is available to all the clients present in the
> > >> >> SoC system. The clients request their slices from this system
> > >> >> cache, make it active, and can then start using it. For these
> > >> >> clients with smmu, to start using the system cache for
> > >> >> dma buffers and related page tables [2], few of the memory
> > >> >> attributes need to be set accordingly.
> > >> >> This change makes the related memory Outer-Shareable, and
> > >> >> updates the MAIR with necessary protection.
> > >> >>
> > >> >> The MAIR attribute requirements are:
> > >> >>     Inner Cacheablity = 0
> > >> >>     Outer Cacheablity = 1, Write-Back Write Allocate
> > >> >>     Outer Shareablity = 1
> > >> >
> > >> > Hmm, so is this cache coherent with the CPU or not?
> > >>
> > >> Thanks for reviewing.
> > >> Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> > >> The different masters such as GPU as able to allocated and activate a slice
> > >> in this Last Level Cache.
> > >
> > > What I mean is, for example, if the CPU writes some data using Normal, Inner
> > > Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> > > Read/Write-allocate and a device reads that data using your MAIR encoding
> > > above, is the device guaranteed to see the CPU writes after the CPU has
> > > executed a DSB instruction?
> > >
> > > I don't think so, because the ARM ARM would say that there's a mismatch on
> > > the Inner Cacheability attribute.
> > >
> > >> > Why don't normal
> > >> > non-cacheable mappings allocated in the LLC by default?
> > >>
> > >> Sorry, I couldn't fully understand your question here.
> > >> Few of the masters on qcom socs are not io-coherent, so for them
> > >> the IC has to be marked as 0.
> > >
> > > By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> > > so I don't understand the problem. What goes wrong if non-coherent devices
> > > use your MAIR encoding for their DMA buffers?
> > >
> > >> But they are able to use the LLC with OC marked as 1.
> > >
> > > The issue here is that whatever attributes we put in the SMMU need to align
> > > with the attributes used by the CPU in order to avoid introducing mismatched
> > > aliases. Currently, we support three types of mapping in the SMMU:
> > >
> > > 1. DMA non-coherent (e.g. "dma-coherent" is not set on the device)
> > >         Normal, Inner Shareable, Inner/Outer Non-Cacheable
> > >
> > > 2. DMA coherent (e.g. "dma-coherent" is set on the device) [IOMMU_CACHE]
> > >         Normal, Inner Shareable, Inner/Outer Cacheable, Inner/Outer
> > >         Write-back, Non-transient Read/Write-allocate
> > >
> > > 3. MMIO (e.g. MSI doorbell) [IOMMU_MMIO]
> > >         Device-nGnRE (Outer Shareable)
> > >
> > > So either you override one of these types (I was suggesting (1)) or you need
> > > to create a new memory type, along with the infrastructure for it to be
> > > recognised on a per-device basis and used by the DMA API so that we don't
> > > get mismatched aliases on the CPU.
> >
> > My apologies for delay in responding to this thread.
> > I have been digging and getting in touch with internal tech teams
> > to get more information on this. I will update as soon as I have enough
> > details.
> > Thanks.
>
> Hi Vivek.  I want to revive this discussion. I believe that Andy has pulled
> in the base LLCC support so this the remaining dependency we need to implement
> the LLCC in the GPU driver.

Hi Jordan, yes I was in process of gathering information about the system cache
usage and the attributes configurations required when devices use system cache.

Let me respond to Will's questions now.

Thanks
Vivek
>
> Thanks,
> Jordan
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
