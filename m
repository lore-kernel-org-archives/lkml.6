Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422AAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E1A20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TbPSpcsn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nkRX3OqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E1A20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502867AbeKWUUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:20:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387987AbeKWUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:20:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CEA1361385; Fri, 23 Nov 2018 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542965803;
        bh=J1MzUFUdQYVZ2dZZ9GBsro77cbb3hNvQAK6giLwbHUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TbPSpcsnFS6mNy62H4w/C/YSvccu6oQTxj4RMxRnYesU7P58UdLzK5ow963edWOXO
         kR6KncKV2LE4eQdsqbO1NaL0T5ivIyuWsyHvL7EGuVaIfSNFdOYM7c7wXgZDHRQffp
         +/2MGc3dxEg9h8sGgMglBsLbYlMXK/ULd7NX6uEw=
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B8B61385;
        Fri, 23 Nov 2018 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542965802;
        bh=J1MzUFUdQYVZ2dZZ9GBsro77cbb3hNvQAK6giLwbHUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nkRX3OqEL0XB7cvHuzoqayc2vUa5ROAAPsdfYt6yRWDeCpjK2iLuXvx7VDABptGcY
         hTK5Z66nX1Ptfs+o6w7W034fAeEc4iDzSFcl7Wz+GS3kl512O15ut94PP7HKY4nUSg
         Hwlrp6cUGTZ3Z67SOHuxWqHlCSaWKJ0BkfzkNfNs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3B8B61385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f173.google.com with SMTP id r71so8127256qkr.10;
        Fri, 23 Nov 2018 01:36:41 -0800 (PST)
X-Gm-Message-State: AA+aEWbaSA+6M4uZZnf9Ud0bQvqn5AuzYCVyySD7D9jdyNdIFR/ptbik
        oEiH3LQrShqPje7lSzicRXsq4mZDukYnC3icqaM=
X-Google-Smtp-Source: AFSGD/WJIFnktlPsodp5bB4H7tUAoMPcMR+MIBoGhuOJ6AKXiZ0uBy58sG0F5+5UFbr5lvBhF0T6IK1elRQ9CMvhfeE=
X-Received: by 2002:a37:6084:: with SMTP id u126mr12613436qkb.118.1542965800993;
 Fri, 23 Nov 2018 01:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org> <20181121173803.GB9801@arm.com>
 <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com> <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
In-Reply-To: <CAAFQd5B-bZR8dmjARb8L4oqgET2YAjXhexAO0GKAvU4JoVU=7g@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 23 Nov 2018 15:06:29 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
Message-ID: <CAFp+6iFhBRJWGY4Hj30tWedGpEUcnkBJrOvffmbpD2m9QMZB3A@mail.gmail.com>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
To:     Will Deacon <will.deacon@arm.com>, thor.thayer@linux.intel.com,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        alex.williamson@redhat.com, "robh+dt" <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Fri, Nov 23, 2018 at 2:52 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Vivek, Will,
>
> On Fri, Nov 23, 2018 at 6:13 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > Hi Will,
> >
> > On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > [+Thor]
> > >
> > > On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
> > > > qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> > > > clock and power requirements.
> > > > On msm8996, multiple cores, viz. mdss, video, etc. use this
> > > > smmu. On sdm845, this smmu is used with gpu.
> > > > Add bindings for the same.
> > > >
> > > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > >  drivers/iommu/arm-smmu.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > > index 2098c3141f5f..d315ca637097 100644
> > > > --- a/drivers/iommu/arm-smmu.c
> > > > +++ b/drivers/iommu/arm-smmu.c
> > > > @@ -120,6 +120,7 @@ enum arm_smmu_implementation {
> > > >       GENERIC_SMMU,
> > > >       ARM_MMU500,
> > > >       CAVIUM_SMMUV2,
> > > > +     QCOM_SMMUV2,
> > > >  };
> > > >
> > > >  struct arm_smmu_s2cr {
> > > > @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> > > >  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> > > >  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> > > >
> > > > +static const char * const qcom_smmuv2_clks[] = {
> > > > +     "bus", "iface",
> > > > +};
> > > > +
> > > > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > > > +     .version = ARM_SMMU_V2,
> > > > +     .model = QCOM_SMMUV2,
> > > > +     .clks = qcom_smmuv2_clks,
> > > > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > > > +};
> > >
> > > These seems redundant if we go down the route proposed by Thor, where we
> > > just pull all of the clocks out of the device-tree. In which case, why
> > > do we need this match_data at all?
> >
> > Which is better? Driver relying solely on the device tree to tell
> > which all clocks
> > are required to be enabled,
> > or, the driver deciding itself based on the platform's match data,
> > that it should
> > have X, Y, & Z clocks that should be supplied from the device tree.
>
> The former would simplify the driver, but would also make it
> impossible to spot mistakes in DT, which would ultimately surface out
> as very hard to debug bugs (likely complete system lockups).

Thanks.
Yea, this is how I understand things presently. Relying on device tree
puts the things out of driver's control.

Hi Will,
Am I unable to understand the intentions here for Thor's clock-fetch
design change?

>
> For qcom_smmuv2, I believe we're eventually going to end up with
> platform-specific quirks anyway, so specifying the clocks too wouldn't
> hurt. Given that, I'd recommend sticking to the latter, i.e. what this
> patch does.
>
> Best regards,
> Tomasz


Best regards
Vivek

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
