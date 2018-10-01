Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E241FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D832089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UbW6DOv9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jXVqhiMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D832089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeJARJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbeJARJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C9D9860C54; Mon,  1 Oct 2018 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538389951;
        bh=Oo5isZtCvLKRVfkbYzOjBJKmxWpiGgsBu+QLrg2QKzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UbW6DOv96+DwRK8lbZ2wL5XFpFuBUnPA+U6bqoQ/63QEyK8Z61dLlWJI68EqGCaun
         y6mAqnAYMTGfHg7ZMaIEwZtKZHRUs4b1R9yGJT+MnF1oBLaFBvDqbOWlnlb0LnibSM
         dZTyDHA87j+5Ypr4spexbKqDsYakidebEJbNRvMQ=
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FA7060C5F;
        Mon,  1 Oct 2018 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538389950;
        bh=Oo5isZtCvLKRVfkbYzOjBJKmxWpiGgsBu+QLrg2QKzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jXVqhiMBgOzkhcXmMjzd8x7dZzGXKLL3rEUxsw2SjmNw/eXbSjUbLmZLN8ZnapcJ8
         wG28TzF/b/ZwERpriE55qnYmsPWaRroJHtlzZzSvSi0SgZNYayRc3jw9Plww0IOZPg
         /slYAutvtjSg33K5y5LcLo9ppwfdsY93kUiO2w8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FA7060C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f182.google.com with SMTP id z8-v6so13288918qto.9;
        Mon, 01 Oct 2018 03:32:30 -0700 (PDT)
X-Gm-Message-State: ABuFfoiQt8NNoyzNxcHdkmtfFRA6gCKwTn0V16T9meVlqleWd2t8vIxR
        G/4/BzZsSyNI4oNY7b/xDJ+kbGrnlcJkyoDHLI8=
X-Google-Smtp-Source: ACcGV61p4rgq9X6DCTHGSa5p2QtiNMKFo6lvCaKG1THZ2wPMaWG5PyR8doQq6Ts+KdcITIlKdlUzdRjfRatb9zw28eE=
X-Received: by 2002:a0c:8563:: with SMTP id n90-v6mr7835378qva.93.1538389949468;
 Mon, 01 Oct 2018 03:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org> <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
 <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
In-Reply-To: <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 1 Oct 2018 16:02:17 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFJbQZ1MrNWD6g+GNp9TOMXuq0oDdzQ9XUMTmY67tNgWg@mail.gmail.com>
Message-ID: <CAFp+6iFJbQZ1MrNWD6g+GNp9TOMXuq0oDdzQ9XUMTmY67tNgWg@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 11:19 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> HI Ulf,
>
> On Fri, Sep 28, 2018 at 5:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > From: Sricharan R <sricharan@codeaurora.org>
> > >
> > > The smmu needs to be functional only when the respective
> > > master's using it are active. The device_link feature
> > > helps to track such functional dependencies, so that the
> > > iommu gets powered when the master device enables itself
> > > using pm_runtime. So by adapting the smmu driver for
> > > runtime pm, above said dependency can be addressed.
> > >
> > > This patch adds the pm runtime/sleep callbacks to the
> > > driver and also the functions to parse the smmu clocks
> > > from DT and enable them in resume/suspend.
> > >
> > > Also, while we enable the runtime pm add a pm sleep suspend
> > > callback that pushes devices to low power state by turning
> > > the clocks off in a system sleep.
> > > Also add corresponding clock enable path in resume callback.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > Signed-off-by: Archit Taneja <architt@codeaurora.org>
> > > [vivek: rework for clock and pm ops]
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 74 insertions(+), 3 deletions(-)
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >
> > [...]
> >
> > > -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> > >  {
> > >         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > +       int ret;
> > > +
> > > +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> > > +       if (ret)
> > > +               return ret;
> > >
> > >         arm_smmu_device_reset(smmu);
> > > +
> > >         return 0;
> > >  }
> > >
> > > -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > +{
> > > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > +
> > > +       clk_bulk_disable(smmu->num_clks, smmu->clks);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > > +{
> > > +       if (pm_runtime_suspended(dev))
> > > +               return 0;
> >
> > Looks like you should be able use pm_runtime_force_resume(), instead
> > of using this local trick. Unless I am missing something, of course.
> >
> > In other words, just assign the system sleep callbacks for resume, to
> > pm_runtime_force_resume(). And vice verse for the system suspend
> > callbacks, pm_runtime_force_suspend(), of course.
>
> Thanks for the review. I will change this as suggested.

Coming back at this - actually Rafael suggested _not_ to use
pm_runtime_force_suspend/resume() when Marek had suggested
the same [1].
He also mentioned few caveats/limitations of using these APIs
for system sleep ops.
Let me know your opinion. Thanks.

[1] https://lkml.org/lkml/2018/7/11/978
[2] https://lkml.org/lkml/2018/7/23/334

Best regards
Vivek
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
