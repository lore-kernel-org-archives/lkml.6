Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99015C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0582156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hAQdJclo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nOydEYGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0582156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeI0NMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:12:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeI0NMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:12:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9418B60BE3; Thu, 27 Sep 2018 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538031362;
        bh=kowJIzV5pprjZ5kKilk2KvbUp/im9X3RVTAuoIONTZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hAQdJclo1QBh+0pBVvS1PonEjxGnB2dYX9KtDyIrLICCfMw9py7wT4T+mG3/vREkt
         cWoZCVxaqZQ0FqNDHr10QiKl+2ZzDOirFLzzMXnjMpvXUAKuvGGdmGZUVZMNmrrbld
         hXhhOMKq3A2VZQlKHcBB239HpGRGrGXegCIWMBkU=
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9DF7609A8;
        Thu, 27 Sep 2018 06:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538031357;
        bh=kowJIzV5pprjZ5kKilk2KvbUp/im9X3RVTAuoIONTZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nOydEYGm6afx6EsO6bkBvkgnst8dUp7vg009ZR2FncUntVpHlEc06k8T8K5m3zMmm
         boom3smAV1i9XoOTDWtGJQo60fIt/1Ju8Y5ks41hIcE5rDF8ypJ/ybtN/rrmJTdMM+
         5Wn42+njqOYYmvebxwwo8BinVeXFKyhncaYJwRbk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9DF7609A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f181.google.com with SMTP id m15-v6so1612799qtp.8;
        Wed, 26 Sep 2018 23:55:56 -0700 (PDT)
X-Gm-Message-State: ABuFfohq5Ug26q3GnVjVD1XU2PxnZ8kgfSlkqU70xZ2pEHlgtpa6eLPr
        ICzkK6pa2PdTK2Pe4iHeV+LmGBZwGxL3oFwyv6Q=
X-Google-Smtp-Source: ACcGV60T4+/nj1o8BqCoa8Mbvn9LxBNcgRPvcqh9IDpty23bUKC068VoF1a8Tl4VmI6Kt9hmtZUitiAkE38+S88knEQ=
X-Received: by 2002:a0c:8563:: with SMTP id n90-v6mr6967836qva.93.1538031356060;
 Wed, 26 Sep 2018 23:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-6-vivek.gautam@codeaurora.org> <80f7a7df-9a6d-9de3-4c7c-261d96fb04e4@arm.com>
In-Reply-To: <80f7a7df-9a6d-9de3-4c7c-261d96fb04e4@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 27 Sep 2018 12:25:43 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGrvVL-tbD=Mx3NV2BqRQo=7f5qh8raaYNT-oFEav+2Ug@mail.gmail.com>
Message-ID: <CAFp+6iGrvVL-tbD=Mx3NV2BqRQo=7f5qh8raaYNT-oFEav+2Ug@mail.gmail.com>
Subject: Re: [PATCH v16 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Sep 26, 2018 at 9:29 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/08/18 15:45, Vivek Gautam wrote:
> > qcom,smmu-v2 is an arm,smmu-v2 implementation with specific
> > clock and power requirements.
> > On msm8996, multiple cores, viz. mdss, video, etc. use this
> > smmu. On sdm845, this smmu is used with gpu.
> > Add bindings for the same.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >   drivers/iommu/arm-smmu.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 166c8c6da24f..411e5ac57c64 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -119,6 +119,7 @@ enum arm_smmu_implementation {
> >       GENERIC_SMMU,
> >       ARM_MMU500,
> >       CAVIUM_SMMUV2,
> > +     QCOM_SMMUV2,
>
> Hmm, it seems we don't actually need this right now, but maybe that just
> means there's more imp-def registers and/or errata to come ;)
>
> Either way I guess there's no real harm in having it.

Thanks for the review.

Best regards
Vivek

>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> >   };
> >
> >   struct arm_smmu_s2cr {
> > @@ -1970,6 +1971,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> >   ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> >   ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> >
> > +static const char * const qcom_smmuv2_clks[] = {
> > +     "bus", "iface",
> > +};
> > +
> > +static const struct arm_smmu_match_data qcom_smmuv2 = {
> > +     .version = ARM_SMMU_V2,
> > +     .model = QCOM_SMMUV2,
> > +     .clks = qcom_smmuv2_clks,
> > +     .num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
> > +};
> > +
> >   static const struct of_device_id arm_smmu_of_match[] = {
> >       { .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
> >       { .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
> > @@ -1977,6 +1989,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >       { .compatible = "arm,mmu-401", .data = &arm_mmu401 },
> >       { .compatible = "arm,mmu-500", .data = &arm_mmu500 },
> >       { .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
> > +     { .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
> >       { },
> >   };
> >   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
