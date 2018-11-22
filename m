Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616120645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l/Is0Bm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A616120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbeKVL5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:57:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38658 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeKVL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:57:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so7928286plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY50ASSszLl+1vzvxGdI84lcKB+OUhBjBYlnXec7Dwc=;
        b=l/Is0Bm7fq1nYq4Ms2TcRuSPOZjKRBcviK6QkkHBvwP9c5O1X7jRhTTwhWpmAWKSWf
         +1hMIZR+GXyr0CjpjVQvnIimhANhO9D/+0n0EYxX0eYEGNkdDF1KpH4HjedpD1RM2zZe
         eehtdQmL/xS57WY8yrL776vlr7hJ7PMXmgS/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY50ASSszLl+1vzvxGdI84lcKB+OUhBjBYlnXec7Dwc=;
        b=F1XVuIfZgkGAtJHFsg039WOoffsocRIqOG7Ehj6vhmlNby8IA55zLx3kKYLAKoSDGH
         I50rN8NxLieLiigi15+L3YZB4BgUf+YkB9A7j48/p8gxB8VyIdoY0+nlfOIJyT7aZ9XX
         9OqwRyO0H7fiXUYptSGVQMfzJS2I6zk4YvRv90r4SHzhXqJ5EDhIhYkdXnRxBQ/z6V+S
         z8lK03Ya7L/TwBKQRAn0G1xPMmNRRNDRaZ3TdBw+cw8z8y2PmQof8MIckO2Hdc7X/E/h
         tLBxsnmKfybsdPR4xBwuYYNdEVnifIpLFFDPF9ltMiWk07p04RwDlobIlaj7hCoyB66R
         NCEg==
X-Gm-Message-State: AA+aEWYhsS34JXduYLo6Fy+qKRWKrPGwvcIDNr91HlwhriYsj2MeF0K1
        0ZAZFSlMis8e2tdwN29IlRm8Te4P475xEbhUWL9lbw==
X-Google-Smtp-Source: AFSGD/UHL8K7Hdrwm6mhxjCawXnuexwqyf0H3T03YfLhcOJ2gF18MnLMDF6D5ZNUNIZ+UP6PFyz5eyY0lm/yV2e7oIM=
X-Received: by 2002:a63:4c04:: with SMTP id z4mr8240260pga.312.1542849657837;
 Wed, 21 Nov 2018 17:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-4-drinkcat@chromium.org> <20181121164638.GD24883@arm.com>
 <20181121180000.GU12932@dhcp22.suse.cz>
In-Reply-To: <20181121180000.GU12932@dhcp22.suse.cz>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 22 Nov 2018 09:20:46 +0800
Message-ID: <CANMq1KCHGZ2vEWg+OQQ-SwvHcU-oMp4qKzEYfLwRYD5ZmRdRsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
To:     mhocko@kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 2:02 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 21-11-18 16:46:38, Will Deacon wrote:
> > On Sun, Nov 11, 2018 at 05:03:41PM +0800, Nicolas Boichat wrote:
> > > For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
> > > is defined (e.g. on arm64 platforms).
> > >
> > > For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32.
> > >
> > > Also, print an error when the physical address does not fit in
> > > 32-bit, to make debugging easier in the future.
> > >
> > > Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > ---
> > >
> > > Changes since v1:
> > >  - Changed approach to use SLAB_CACHE_DMA32 added by the previous
> > >    commit.
> > >  - Use DMA or DMA32 depending on the architecture (DMA for arm,
> > >    DMA32 for arm64).
> > >
> > > drivers/iommu/io-pgtable-arm-v7s.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > > index 445c3bde04800c..996f7b6d00b44a 100644
> > > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > > @@ -161,6 +161,14 @@
> > >
> > >  #define ARM_V7S_TCR_PD1                    BIT(5)
> > >
> > > +#ifdef CONFIG_ZONE_DMA32
> > > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> > > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32
> > > +#else
> > > +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> > > +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA
> > > +#endif
> >
> > It's a bit grotty that GFP_DMA32 doesn't just map to GFP_DMA on 32-bit
> > architectures, since then we wouldn't need this #ifdeffery afaict.
>
> But GFP_DMA32 should map to GFP_KERNEL on 32b, no? Or what exactly is
> going on in here?

GFP_DMA32 will fail due to check_slab_flags (aka GFP_SLAB_BUG_MASK
before patch 1/3 of this series)... But yes, it may be neater if there
was transparent remapping of GFP_DMA32/SLAB_CACHE_DMA32 to
GFP_DMA/SLAB_CACHE_DMA on 32-bit arch...

> --
> Michal Hocko
> SUSE Labs
