Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A11C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AA22075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJHjd2PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AA22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeIEOe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:34:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33874 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeIEOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:34:28 -0400
Received: by mail-it0-f65.google.com with SMTP id x79-v6so16440683ita.1;
        Wed, 05 Sep 2018 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63ZKR31PoYewKsPI3k7I/J3X5xgypycIBvU0xihko18=;
        b=AJHjd2PRluNq5jSIt9RzzyRK8T7fBw6/jxoDm0LMGLhWWgQjMjwQG92KoPebMU3YTe
         lmRyS14hW1cCIWVLHt3F3qRnZMTWMhG1oSvwtHV3bOXom9zKLfJxkM1pvc0T496aRQx2
         +LU/GYbzamz9M2WLmSu5VJk/VAsVbiNdtf1vQNvtxZx7Sj7i5kt6epAfz3o1VKpAH3yM
         oByTIEYIFqqA9BnE80Yquo4/wpAgK4JlafP1rLQ87IFhqaQ3LJcNRkmJYgVpM0pD8Fax
         QD+B1FFTWtfnoRaUXPmmswoJAKFlFnBsXHCfEA2FGIt7X1pLXwSJMEMKysJQArflUioK
         O5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63ZKR31PoYewKsPI3k7I/J3X5xgypycIBvU0xihko18=;
        b=k0IPNHURmA73lHQF3ZbfhH8o3geb3s/cQeHhSW4mtl640/fOV82SxMObkeuybBAk56
         joBfAN3kHfhrcg9jQXXv1ytEa6wpqOJcGxGZGxLN26PNVFFL32MD8pMlx/VLbcSTorp7
         dbHUVXaSQ4om3j5aVWSKMgBpO/hlZRzVTSsyemI4d/X6O4lHAZe7jkvQ71A3r0XQcObM
         cj7WQ3veXdNINd2Vpf5E85q2be4+N5SC4I8SfAAMtTfQIGUk22zr23ceWxzNaW2Hu4oJ
         RK0hunPnt6x72urwBHDe+DSPlNw0XOEDM9O2PKsbmtlV+c+qe0ogaPXp2Goq8rXAAdxy
         Xkow==
X-Gm-Message-State: APzg51A7OCRZqEWHpDOfUua1f5/2QtWfaiYTRyzeOitkCwODknIWQTzx
        BrhCbI+mSJNJA84dZz0F6ettnGRgpvXyL1G65oY=
X-Google-Smtp-Source: ANB0VdZ3DXPorqB61VCUg99FPWxyWBUErdfYom/3GprFqMWnYW2CgnsioUcjsZNHJyoFnku7zqTj2W+ZWhr2UXuqFLw=
X-Received: by 2002:a02:b5bd:: with SMTP id m58-v6mr7078692jaj.145.1536141897476;
 Wed, 05 Sep 2018 03:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814114009.GF28664@arm.com> <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
 <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
In-Reply-To: <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 5 Sep 2018 06:04:44 -0400
Message-ID: <CAF6AEGsuAXXtUbeteQk5ssZEqk8XLViDZH5PfxQjn6sg8+B08A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 5:22 AM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
>
> On 8/14/2018 5:54 PM, Vivek Gautam wrote:
> > Hi Will,
> >
> >
> > On 8/14/2018 5:10 PM, Will Deacon wrote:
> >> Hi Vivek,
> >>
> >> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
> >>> Qcom's implementation of arm,mmu-500 on sdm845 has a
> >>> functional/performance
> >>> errata [1] because of which the TCU cache look ups are stalled during
> >>> invalidation cycle. This is mitigated by serializing all the
> >>> invalidation
> >>> requests coming to the smmu.
> >> How does this implementation differ from the one supported by
> >> qcom_iommu.c?
> >> I notice you're adding firmware hooks here, which we avoided by
> >> having the
> >> extra driver. Please help me understand which devices exist, how they
> >> differ, and which drivers are intended to support them!
> >
> > IIRC, the qcom_iommu driver was intended to support the static context
> > bank - SID
> > mapping, and is very specific to the smmu-v2 version present on
> > msm8916 soc.
> > However, this is the qcom's mmu-500 implementation specific errata.
> > qcom_iommu
> > will not be able to support mmu-500 configurations.
> > Rob Clark can add more.
> > Let you know what you suggest.
>
> Rob, can you please comment about how qcom-smmu driver has different
> implementation
> from arm-smmu driver?

sorry, I missed this thread earlier.  But yeah, as you mentioned, the
purpose for qcom_iommu.c was to deal with the static context/SID
mapping.

(I guess it is all just software, and we could make qcom_iommu.c
support dynamic mapping as well, but I think then it starts to
duplicate most of arm_smmu.c, so that doesn't seem like the right
direction)

BR,
-R

> Will, in case we would want to use arm-smmu driver, what would you
> suggest for
> having the firmware hooks?
> Thanks.
>
> Best regards
> Vivek
