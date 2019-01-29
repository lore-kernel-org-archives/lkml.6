Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3492147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C+nCPt/l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KXjhPqYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfA2Kn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:43:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfA2Kn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:43:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 900B860907; Tue, 29 Jan 2019 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548758606;
        bh=b8SkCNRhjNOfUi0XfdquRN5VpBwkG9P4jLXAjsvZQdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C+nCPt/lF+oxnenPcKCFA5OZAp4MhujiewCbiXiq45IAmoveM+T2Qfj6DJXywNIyc
         ks6DYG4wSrgRiADLjRbIZRElnLeN5jXRlSLLzjvYsnG4GLazNPRCvegzzSWx7tJA5c
         KlJXxU4lDUJuKl2WUyaxGsr+Mc0Z4H5JUyfUIv7E=
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79D3660850;
        Tue, 29 Jan 2019 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548758605;
        bh=b8SkCNRhjNOfUi0XfdquRN5VpBwkG9P4jLXAjsvZQdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KXjhPqYbcmmPih5E5qJpApgRkwMj/jHrkpaTUTqTgQsXD8mMWLDAMeZ5Li1WWXG2V
         NFebdVUSMVeSKcQglGyAOYpR3gkOI46YRGJHfGTP8KKjuxi9CVeeno15UA1SexdY98
         g6lkef0tX/E/IkoSxbNvuHg94hKSPziV/QKzE4hQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79D3660850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f52.google.com with SMTP id g22so15559493edr.7;
        Tue, 29 Jan 2019 02:43:25 -0800 (PST)
X-Gm-Message-State: AJcUukejNepEdKu004RJuZPxoArxNPpphMyx8HkL3G5zt+oOjthpWwx+
        B9AJ1U7fpFU+LrBlsCerzOQ0BZa/WLhuQjNWKFs=
X-Google-Smtp-Source: ALg8bN4wRRQQdDYNNzhSv9KBKIAwkqmbUvcI5Sz6uW5VBaUr5b2J+z2xBius0AjqsCH1Rj0DiXBmii/VvjNGJg/6EoM=
X-Received: by 2002:a17:906:452:: with SMTP id e18mr11493850eja.142.1548758604052;
 Tue, 29 Jan 2019 02:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org> <20190120000117.GH26876@brain-police>
 <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com> <20190122054326.GA6445@brain-police>
In-Reply-To: <20190122054326.GA6445@brain-police>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 29 Jan 2019 16:13:12 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHJ_Ctjh8-y8p4KWGrCVHE+1uv3KX2-rfKkt1uqb0YqHA@mail.gmail.com>
Message-ID: <CAFp+6iHJ_Ctjh8-y8p4KWGrCVHE+1uv3KX2-rfKkt1uqb0YqHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, Jan 22, 2019 at 11:14 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Jan 21, 2019 at 11:35:30AM +0530, Vivek Gautam wrote:
> > On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > > > Adding a device tree option for arm smmu to enable non-cacheable
> > > > memory for page tables.
> > > > We already enable a smmu feature for coherent walk based on
> > > > whether the smmu device is dma-coherent or not. Have an option
> > > > to enable non-cacheable page table memory to force set it for
> > > > particular smmu devices.
> > >
> > > Hmm, I must be missing something here. What is the difference between this
> > > new property, and simply omitting dma-coherent on the SMMU?
> >
> > So, this is what I understood from the email thread for Last level
> > cache support -
> > Robin pointed to the fact that we may need to add support for setting
> > non-cacheable
> > mappings in the TCR.
> > Currently, we don't do that for SMMUs that omit dma-coherent.
> > We rely on the interconnect to handle the configuration set in TCR,
> > and let interconnect
> > ignore the cacheability if it can't support.
>
> I think that's a bug. With that fixed, can you get what you want by omitting
> "dma-coherent"?

Based on the discussion on the first patch in this series [1], I can
update the series.
First thing can be -
if QUIRK_NO_DMA is set (i.e. the IOMMU _is_ coherent) then we use a
cacheable TCR;
So, we may need an additional check for this when setting the TCR.

For the second case -
IOMMUs that are *not* coherent, i.e ones that are omitting
'dma-coherent' property,
anyways have to access the page table directly from memory. We take
care of the CPU
side of this by allocating non-coherent memory, and making sure that we sync the
PTEs from map call.
Shouldn't we mark TCR for these IOMMUs as non-cacheable for inner and outer
cacheability attribute?


[1] https://lore.kernel.org/patchwork/patch/1032939/

Regards
Vivek

>
> Will



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
