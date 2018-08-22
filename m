Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39F0208DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozVOMdGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39F0208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeHVVXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:23:13 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46113 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeHVVXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:23:13 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so4600731oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+Duo5Zd3dc2U2bmtFSOK65PK3BsP/GWImhAiwC5ulM=;
        b=ozVOMdGLX1CMFwqXsupwbyOx7vnJ2JfyjwrfbGhxcF+XUWBtJ/jJwBRCwiOdNAr/26
         90vWlmXbBCNTSUslmkkb43ucBGB3f4lK9Pap7Foclypt68sI2epyQ+TD2nfy4zBfbZde
         1AnwLR4sdlVSopCfQ7WCNxtrmAHBCw6evEmEKSq7BGozy0kvWJPf5O7I3COyOo+HUYE4
         GUo4qmmoxCwcbX2Kop4EIyWeIbmSKjm4eOMXr7euMjJEtmYninAKL5eIfoW2L9nEDZJv
         TA/gPYC4x6okdhOPDH6geIzuEXD6Wll4qjrrTXXjjbQnFgapcI4LDW+wXFJxKAtZdlDR
         Vo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+Duo5Zd3dc2U2bmtFSOK65PK3BsP/GWImhAiwC5ulM=;
        b=bzJunkZsWN+fDCmWY+3G0/irQjQsoeb6MBr8nOBgemRTNt+qdGbDmAgGZXc8ikjTpB
         xgJvMpU6Y7dgnnrUbmkdbPc/4tWK77W3e3RRYm5pGoIzguQg/DALX8jt5dZyQIYSuHQA
         8+K349FgHXw6MfntRMyq35kcE/499x04VIL3EOS7tjJF2wmwuqaRIlmksuKfEksWNFhi
         ChygW5KtdjwaEU46WIZx9TEJqvfIe8tMP2hbXCRqHJF1fvcuDePRgt3Oja9YrS/HJgmG
         AUwZZJYahUUWp+hyXBa0uGyUUhlExAVFErrKzHXNyXemqTc50xhHcsBVhijE1sS1GsnO
         rjWw==
X-Gm-Message-State: APzg51B9Vx7xMiFyRoUjkZSDq1k3pbDkMOPn6+MROLszmM80Jh4G6hKN
        IZo8JFma6v+qxX6bSo9xLddCzw60Rn3fQCEdS4k=
X-Google-Smtp-Source: ANB0VdbL5ZBQahBU/hJM1c/Z1hc6gEtBlK8496R8CJA6ULSHMUBbTNgRk6PkodHyZdc8F7drM6O9B0usWmQ251ufB0M=
X-Received: by 2002:aca:a12:: with SMTP id 18-v6mr5263336oik.292.1534960639722;
 Wed, 22 Aug 2018 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
 <452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com> <a7fc1e43-3652-562a-1e59-499be80b567c@arm.com>
 <ec57224a-7673-97d8-bb0c-c612080625bc@huawei.com>
In-Reply-To: <ec57224a-7673-97d8-bb0c-c612080625bc@huawei.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Wed, 22 Aug 2018 10:57:07 -0700
Message-ID: <CAKTKpr7XbZAZ8XRJ2r97N+AQP_DM8_OrqYC=4Pstf-vRW85rng@mail.gmail.com>
Subject: Re: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
 NUMA systems
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Will Deacon <Will.Deacon@arm.com>, Tomasz.Nowicki@cavium.com,
        Robert Richter <Robert.Richter@cavium.com>, mhocko@suse.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        jnair@caviumnetworks.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 9:08 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/08/2018 15:56, Robin Murphy wrote:
> > Hi John,
> >
> > On 22/08/18 14:44, John Garry wrote:
> >> On 21/09/2017 09:59, Ganapatrao Kulkarni wrote:
> >>> Adding numa aware memory allocations used for iommu dma allocation and
> >>> memory allocated for SMMU stream tables, page walk tables and command
> >>> queues.
> >>>
> >>> With this patch, iperf testing on ThunderX2, with 40G NIC card on
> >>> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.
> >>>
> >>> Ganapatrao Kulkarni (4):
> >>>   mm: move function alloc_pages_exact_nid out of __meminit
> >>>   numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
> >>>     translation tables
> >>>   iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
> >>>     comamnd queues
> >>>   iommu/dma, numa: Use NUMA aware memory allocations in
> >>>     __iommu_dma_alloc_pages
> >>>
> >>>  drivers/iommu/arm-smmu-v3.c    | 57
> >>> +++++++++++++++++++++++++++++++++++++-----
> >>>  drivers/iommu/dma-iommu.c      | 17 +++++++------
> >>>  drivers/iommu/io-pgtable-arm.c |  4 ++-
> >>>  include/linux/gfp.h            |  2 +-
> >>>  mm/page_alloc.c                |  3 ++-
> >>>  5 files changed, 67 insertions(+), 16 deletions(-)
> >>>
> >>
> >> Hi Ganapatrao,
> >>
> >> Have you any plans for further work on this patchset? I have not seen
> >> anything since this v1 was posted+discussed.
> >
>
> Hi Robin,
>
> Thanks for the info. I thought I remembered 4b12 but couldn't put my
> finger on it.
>
> > Looks like I ended up doing the version of the io-pgtable change that I
> > suggested here, which was merged recently (4b123757eeaa). Patch #3
> > should also be effectively obsolete now since the SWIOTLB/dma-direct
> > rework (21f237e4d085). Apparently I also started reworking patch #4 in
> > my tree at some point but sidelined it - I think that was at least
> > partly due to another thread[1] which made it seem less clear-cut
> > whether this is always the right thing to do.
>
> Right, so #4 seems less straightforward and not directly related to
> IOMMU driver anyway.
>

thanks Robin for pulling up the patch. I couldn't followup with this
due to other tasks.

> Cheers,
> John
>
> >
> > Robin.
> >
> > [1]
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1693026.html
> >
> > .
> >
>
>
thanks,
Ganapat
