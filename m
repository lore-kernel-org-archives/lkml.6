Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37022C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3357217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mTRFvt1Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RQzI+0+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbeLQFeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:34:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLQFeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:34:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 126B360854; Mon, 17 Dec 2018 05:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545024840;
        bh=pbiDjBKSRJ9yO8fi+OYcUacsniMhZvr3BdKWyMXRxws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTRFvt1YTGf/DHsmCTHad76WY1aGnmj718IibIXgkMR8bEy1SwHwgSKWr2mh649g8
         +nK86MHIJo86lVMMb0Dclw9Apxlo3FhfeCNtxdR8HMkxs86N5XL7EN1xN3BqizSgm2
         U53t3S1EdxIj17rucOuY6sx0MkGNf/HzqVQB8wQY=
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D93760595;
        Mon, 17 Dec 2018 05:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545024839;
        bh=pbiDjBKSRJ9yO8fi+OYcUacsniMhZvr3BdKWyMXRxws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RQzI+0+mHuRLbSnMkOK5S5PjBGbU7dOwKSHtd/m6V4xs3mn+0kj8jIKg2BfQCUo9/
         TUx8EK4aOHgpRnfcs4vRU8GWhMLtDuTDvtygs8Vv6GHV+daWEWYFGMgxRerq3Rj1YK
         LJ+29YufttB3mfBO37iLdIIZinn0gmDl2/aM3Awg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D93760595
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f172.google.com with SMTP id y20so12783838qtm.13;
        Sun, 16 Dec 2018 21:33:59 -0800 (PST)
X-Gm-Message-State: AA+aEWbaneodRme1z7aofIFOldPASXOwXS826Dd4w3iNDwb44WrjnrdR
        i6/SXdnDPnpQMkPquw19jrp3SMHVjjNDJmXxIIE=
X-Google-Smtp-Source: AFSGD/VwNtZZsYrkEX2wLZsEbA9vZV7ybQpVrqjbZcVd9YtPVNDB/u6WwGv1jk7ru7fbX7IWpzAO9t/kpxr0oif0OBw=
X-Received: by 2002:ac8:2353:: with SMTP id b19mr11904535qtb.187.1545024838423;
 Sun, 16 Dec 2018 21:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20181213090507.6269-1-vivek.gautam@codeaurora.org> <20181213104524.GA31177@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181213104524.GA31177@edgewater-inn.cambridge.arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 17 Dec 2018 11:03:46 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHGANAkp+uKRsYHHsaY204SL0_Y5dbRu+D2SdzD69GOSQ@mail.gmail.com>
Message-ID: <CAFp+6iHGANAkp+uKRsYHHsaY204SL0_Y5dbRu+D2SdzD69GOSQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/1] dt-bindings: arm-smmu: Add binding doc for
 Qcom smmu-500
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 4:16 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Dec 13, 2018 at 02:35:07PM +0530, Vivek Gautam wrote:
> > Qcom's implementation of arm,mmu-500 works well with current
> > arm-smmu driver implementation. Adding a soc specific compatible
> > along with arm,mmu-500 makes the bindings future safe.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >
> > Hi Joerg,
> > I am picking this out separately from the sdm845 smmu support
> > series [1], so that this can go through iommu tree.
> > The dt patch from the series [1] can be taken through arm-soc tree.
> >
> > Hi Will,
> > As asked [2], here's the resend version of dt binding patch for sdm845.
> > Kindly ack this so that Joerg can pull this in.
>
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks a lot Will for the Ack.

Regards
Vivek

>
> Joerg -- please can you take this on top of the pull request I sent already?
> Vivek included it as part of a separate series which I thought was going
> via arm-soc, but actually it needs to go with the other arm-smmu patches
> in order to avoid conflicts.
>
> Cheers,
>
> Will
>
> >  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > index a6504b37cc21..3133f3ba7567 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -27,6 +27,10 @@ conditions.
> >                    "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
> >                    "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
> >
> > +                  Qcom SoCs implementing "arm,mmu-500" must also include,
> > +                  as below, SoC-specific compatibles:
> > +                  "qcom,sdm845-smmu-500", "arm,mmu-500"
> > +
> >  - reg           : Base address and size of the SMMU.
> >
> >  - #global-interrupts : The number of global interrupts exposed by the
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
