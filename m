Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E320663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m5QsZAt2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B/IQahsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6E320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408852AbeKWT4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:56:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbeKWT4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:56:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F016660791; Fri, 23 Nov 2018 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542964403;
        bh=kCBEZX08k4UqHeLsykR5vTaa9uPIRtP5NlqPfpWPBt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m5QsZAt2Bu4oOtzyrKai9/oo2GEqdk9dqzCPp/oPDD85re4Nub59/wZ7G8Ivqzotg
         ecUllfsOo4V142HMwJ1YyPbNQZOPeC/XidmCiGm8geAUU6XxlaVaJF/clLvoeJNeNP
         pIdTiHE3J6DBocA0BtQ8/vmqy68K7WaqSJlOHP74=
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D10160913;
        Fri, 23 Nov 2018 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542964401;
        bh=kCBEZX08k4UqHeLsykR5vTaa9uPIRtP5NlqPfpWPBt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B/IQahsEe6S55hsx9RIFQs+QXBB789t211mHdZpoaTXqEeWWVn8mEmDWEhUPlmqDM
         AW+SeUdyVYJID/Wez0dMnOboZrML/v3LQBhoyLPjJMCFE2pID7+i1JRyahbmeVx8eH
         6h1et7f0Pke6FQWM9pSoanFJOVh9ET3AbOcMdIso=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D10160913
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f171.google.com with SMTP id z16so9816852qtq.4;
        Fri, 23 Nov 2018 01:13:21 -0800 (PST)
X-Gm-Message-State: AA+aEWZvq9BBrCkVmr+OWeB2nvNJCKWR4AiN2HaVqpA1IjoNAgrcdIU0
        qVOrTEeuJUbHzNsaBkRuS3tfqwRXYGhuJ9dR3hY=
X-Google-Smtp-Source: AFSGD/U4I2pyDJEYLYxTLY/6fx2ixQYJJBHEmsfV5LyumFYo9ugffdPfxaC37kt97lZaKeNBY/8CCodJgBjwrlzgT+w=
X-Received: by 2002:a0c:c60b:: with SMTP id v11mr13520315qvi.198.1542964400710;
 Fri, 23 Nov 2018 01:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-6-vivek.gautam@codeaurora.org> <20181121173803.GB9801@arm.com>
In-Reply-To: <20181121173803.GB9801@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 23 Nov 2018 14:43:06 +0530
X-Gmail-Original-Message-ID: <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
Message-ID: <CAFp+6iELH7Mw3Ue2ksEyV+Ac8hG8--Ki69xrPCA4F-AcireRow@mail.gmail.com>
Subject: Re: [RESEND PATCH v17 5/5] iommu/arm-smmu: Add support for
 qcom,smmu-v2 variant
To:     Will Deacon <will.deacon@arm.com>, "robh+dt" <robh+dt@kernel.org>
Cc:     thor.thayer@linux.intel.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
>
> [+Thor]
>
> On Fri, Nov 16, 2018 at 04:54:30PM +0530, Vivek Gautam wrote:
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
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 2098c3141f5f..d315ca637097 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -120,6 +120,7 @@ enum arm_smmu_implementation {
> >       GENERIC_SMMU,
> >       ARM_MMU500,
> >       CAVIUM_SMMUV2,
> > +     QCOM_SMMUV2,
> >  };
> >
> >  struct arm_smmu_s2cr {
> > @@ -2026,6 +2027,17 @@ ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> >  ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> >  ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
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
>
> These seems redundant if we go down the route proposed by Thor, where we
> just pull all of the clocks out of the device-tree. In which case, why
> do we need this match_data at all?

Which is better? Driver relying solely on the device tree to tell
which all clocks
are required to be enabled,
or, the driver deciding itself based on the platform's match data,
that it should
have X, Y, & Z clocks that should be supplied from the device tree.

Thanks
Vivek

>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
