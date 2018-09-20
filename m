Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206CFECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18872152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jeZwaDwe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mb1uwwxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18872152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeITRZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:25:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeITRZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:25:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0937F60BEE; Thu, 20 Sep 2018 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537443728;
        bh=LXuN8sf4Xb1DbMfVeGntMFHnOqZkMKV4LzkptQXkONA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jeZwaDwelFghtEBO2VPFb0ZG16yR76gkypxxXIj9D7vUK+l/xBIHzlh+wZe/h2f1M
         VWZgJHGCi1Biq18YqVi9lN2enmp74t1E+Toa0UXXi4TubCgBkEp+LofVB635+5g+DL
         +gAWqS2620i5SH556TLrBbMpeK2cv6sP0nG2+y6Y=
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 439B460C4F;
        Thu, 20 Sep 2018 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537443727;
        bh=LXuN8sf4Xb1DbMfVeGntMFHnOqZkMKV4LzkptQXkONA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mb1uwwxW76dGZVBJDEciRLDzgJoXwLobu1i3gCJMKZJMv1rNwsZnG+QTubwK5hfPS
         M8W3J5Own0RQGyrqR2cwqK+hsiQOL3USVuQaXxn7N1cRkdmhEi4H+/+8ZwtJp/2zTM
         bslhpSvi8mAdf2JDGkLJg5zSvNjclC1LZecqE7FE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 439B460C4F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f179.google.com with SMTP id l194-v6so776377qke.13;
        Thu, 20 Sep 2018 04:42:07 -0700 (PDT)
X-Gm-Message-State: APzg51BzKSWlvhmY9Kc9I8C08rbrTdUrEO1fK57k6IE6YDNxhew+aJMp
        o5juLLs8dOsJHebOY22DBwCtKs/sBLot6exmfQg=
X-Google-Smtp-Source: ANB0VdY+ZuTbPDJAikXpyc3tpW6eudszXWbdKjVF9vZ/7aKVc45ylRZcoySxbR+GWQILmKQUqUKneuficIXEg2ewak4=
X-Received: by 2002:a37:ad03:: with SMTP id f3-v6mr27338748qkm.140.1537443726475;
 Thu, 20 Sep 2018 04:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com> <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
 <20180627163749.GA8729@arm.com>
In-Reply-To: <20180627163749.GA8729@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 20 Sep 2018 17:11:53 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFNhk7xZRHp0hNb2S7Cdn3muvsWqTEX-vjPGmxM8TNM9A@mail.gmail.com>
Message-ID: <CAFp+6iFNhk7xZRHp0hNb2S7Cdn3muvsWqTEX-vjPGmxM8TNM9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Will Deacon <will.deacon@arm.com>
Cc:     pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jordan Crouse <jcrouse@codeaurora.org>, pratikp@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Jun 27, 2018 at 10:07 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Vivek,
>
> On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
> > On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> > >> Qualcomm SoCs have an additional level of cache called as
> > >> System cache or Last level cache[1]. This cache sits right
> > >> before the DDR, and is tightly coupled with the memory
> > >> controller.
> > >> The cache is available to all the clients present in the
> > >> SoC system. The clients request their slices from this system
> > >> cache, make it active, and can then start using it. For these
> > >> clients with smmu, to start using the system cache for
> > >> dma buffers and related page tables [2], few of the memory
> > >> attributes need to be set accordingly.
> > >> This change makes the related memory Outer-Shareable, and
> > >> updates the MAIR with necessary protection.
> > >>
> > >> The MAIR attribute requirements are:
> > >>     Inner Cacheablity = 0
> > >>     Outer Cacheablity = 1, Write-Back Write Allocate
> > >>     Outer Shareablity = 1
> > >
> > > Hmm, so is this cache coherent with the CPU or not?
> >
> > Thanks for reviewing.
> > Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
> > The different masters such as GPU as able to allocated and activate a slice
> > in this Last Level Cache.
>
> What I mean is, for example, if the CPU writes some data using Normal, Inner
> Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> Read/Write-allocate and a device reads that data using your MAIR encoding
> above, is the device guaranteed to see the CPU writes after the CPU has
> executed a DSB instruction?

No, these MAIR configurations don't guarantee that devices will have
coherent view
of what CPU writes. Not all devices can snoop into CPU caches (only IO-Coherent
devices can).
So a normal cached memory configuration in CPU MMU tables, and SMMU page tables
is valid only for few devices that are IO-coherent.

Moreover, CPU can lookup in system cache, and so do all devices;
allocation will depend on h/w configurations and memory attributes.
So anything that CPU caches in system cache will be coherently visible
to devices.

>
> I don't think so, because the ARM ARM would say that there's a mismatch on
> the Inner Cacheability attribute.
>
> > > Why don't normal
> > > non-cacheable mappings allocated in the LLC by default?
> >
> > Sorry, I couldn't fully understand your question here.
> > Few of the masters on qcom socs are not io-coherent, so for them
> > the IC has to be marked as 0.
>
> By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> so I don't understand the problem. What goes wrong if non-coherent devices
> use your MAIR encoding for their DMA buffers?
>
> > But they are able to use the LLC with OC marked as 1.
>
> The issue here is that whatever attributes we put in the SMMU need to align
> with the attributes used by the CPU in order to avoid introducing mismatched
> aliases.

Not really, right?
Devices can use Inner non-Cacheable, Outer-cacheable (IC=0, OC=1) to allocate
into the system cache (as these devices don't want to allocate in
their inner caches),
and the CPU will have a coherent view of these buffers/page-tables.
This should be
a normal cached non-IO-Coherent memory.

But anything that CPU writes using Normal, Inner Shareable,
Inner/Outer Cacheable,
Inner/Outer Write-back, Non-transient Read/Write-allocate, may not be visible
to the device.

Also added Jordan, and Pratik to this thread.

Thanks & Regards
Vivek

> Currently, we support three types of mapping in the SMMU:
>
> 1. DMA non-coherent (e.g. "dma-coherent" is not set on the device)
>         Normal, Inner Shareable, Inner/Outer Non-Cacheable
>
> 2. DMA coherent (e.g. "dma-coherent" is set on the device) [IOMMU_CACHE]
>         Normal, Inner Shareable, Inner/Outer Cacheable, Inner/Outer
>         Write-back, Non-transient Read/Write-allocate
>
> 3. MMIO (e.g. MSI doorbell) [IOMMU_MMIO]
>         Device-nGnRE (Outer Shareable)
>
> So either you override one of these types (I was suggesting (1)) or you need
> to create a new memory type, along with the infrastructure for it to be
> recognised on a per-device basis and used by the DMA API so that we don't
> get mismatched aliases on the CPU.
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
