Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1AC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09522085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aIjJ6pxo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MKtPIAZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfAUKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:17:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAUKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:17:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 29DA76083E; Mon, 21 Jan 2019 10:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548065851;
        bh=8LIht97H1AgIOgZUi4NvRsOkdsUaK0MY0BQfKfBJ3PM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aIjJ6pxosNo97S3NQYePgftR21HrydbpuRH9YSi5q4CmjYQEsUlWCe2IWd5aVlE7f
         xymyzl57ca5SGgGEaTsgjNoaOEnjBb2gVJ8qul1svTYGIFqH6pSnpnLMAVOC7OHWG2
         5KTyvWfeLwe4zlYAdNX+Rbi1MzmGGYTtiW+fBOTU=
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 402626083E;
        Mon, 21 Jan 2019 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548065850;
        bh=8LIht97H1AgIOgZUi4NvRsOkdsUaK0MY0BQfKfBJ3PM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MKtPIAZcdaik5jMzzI2dkY/eXAJsYiKTHHmk4BZSt5ES85NSRSNyQegPkWx+kaeZ2
         owZUq+B4frFLPCRlWKseXwO5kVA5Wg+nQos5ZQoXhMVml3W8luGMLQJPt4KJnTMYm4
         NpkRD2vCKb2BZvRhUkWiznBxnbRnmC6yPT+T0XdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 402626083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f45.google.com with SMTP id y20so16095156edw.9;
        Mon, 21 Jan 2019 02:17:30 -0800 (PST)
X-Gm-Message-State: AJcUukfQwkf7suobDoDheavhAcDqgQ8cqDw/8+bxOODQPR3yvBT5XVSm
        kdpKdhWHu3lOiRN253IHbOnrLz6G3eoZBQnL1Ss=
X-Google-Smtp-Source: ALg8bN5bgnBUvp7KNeLdx419CF5OcZUCrV68jGUPzczNnqeykMwOedhNTX8LnTt4d/1y6T0/5H5u1VS5a+F7UxZsDkA=
X-Received: by 2002:a17:906:4e14:: with SMTP id z20-v6mr23716988eju.187.1548065848901;
 Mon, 21 Jan 2019 02:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org> <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 21 Jan 2019 15:47:17 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
Message-ID: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>, pratikp@codeaurora.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >
> > Qualcomm SoCs have an additional level of cache called as
> > System cache, aka. Last level cache (LLC). This cache sits right
> > before the DDR, and is tightly coupled with the memory controller.
> > The clients using this cache request their slices from this
> > system cache, make it active, and can then start using it.
> > For these clients with smmu, to start using the system cache for
> > buffers and, related page tables [1], memory attributes need to be
> > set accordingly. This series add the required support.
> >
>
> Does this actually improve performance on reads from a device? The
> non-cache coherent DMA routines perform an unconditional D-cache
> invalidate by VA to the PoC before reading from the buffers filled by
> the device, and I would expect the PoC to be defined as lying beyond
> the LLC to still guarantee the architected behavior.

We have seen performance improvements when running Manhattan
GFXBench benchmarks.

As for the PoC, from my knowledge on sdm845 the system cache, aka
Last level cache (LLC) lies beyond the point of coherency.
Non-cache coherent buffers will not be cached to system cache also, and
no additional software cache maintenance ops are required for system cache.
Pratik can add more if I am missing something.

To take care of the memory attributes from DMA APIs side, we can add a
DMA_ATTR definition to take care of any dma non-coherent APIs calls.

Regards
Vivek
>
>
>
> > This change is a realisation of following changes from downstream msm-4.9:
> > iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> > iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
> >
> > Changes since v2:
> >  - Split the patches into io-pgtable-arm driver and arm-smmu driver.
> >  - Converted smmu domain attributes to a bitmap, so multiple attributes
> >    can be managed easily.
> >  - With addition of non-coherent page table mapping support [4], this
> >    patch series now aligns with the understanding of upgrading the
> >    non-coherent devices to use some level of outer cache.
> >  - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
> >  - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
> >    stage-1 mapping.
> >  - Added change to disable the attribute from arm_smmu_domain_set_attr()
> >    when needed.
> >  - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
> >    level.
> >
> > Goes on top of the non-coherent page tables support patch series [4]
> >
> > [1] https://patchwork.kernel.org/patch/10302791/
> > [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> > [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> > [4] https://lore.kernel.org/patchwork/cover/1032938/
> >
> > Vivek Gautam (3):
> >   iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
> >   iommu/io-pgtable-arm: Add support to use system cache
> >   iommu/arm-smmu: Add support to use system cache
> >
> >  drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
> >  drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
> >  drivers/iommu/io-pgtable.h     |  4 ++++
> >  include/linux/iommu.h          |  2 ++
> >  4 files changed, 43 insertions(+), 6 deletions(-)
> >
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
