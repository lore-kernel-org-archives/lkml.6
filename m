Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD20C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0D5206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DeP6iY4i";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EOt6jVHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0D5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeJAMZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:25:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:25:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FA7A60C54; Mon,  1 Oct 2018 05:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538372995;
        bh=FKpTmMWFkmy1kySjdRIY5H/nhVqN2KFTZme0rUjvswA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DeP6iY4i1RH+E0zeoY5sLWHlscU9WQHrMB7BC9QOqL6AOTqRwWOpUM4EwseGEMUpI
         x4mfFRokOXoNvDtwsBr4fvSTbUnB1GXLOigAD7M2dSaN/Iyc5BEeDHLj9WtXlCYuuI
         /5qtHVRQkf+jzMtdE+xaXayhPug0IO2T9TZWGrpk=
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6365360128;
        Mon,  1 Oct 2018 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538372988;
        bh=FKpTmMWFkmy1kySjdRIY5H/nhVqN2KFTZme0rUjvswA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EOt6jVHu6keZVbBVrkWb89kz+T6P6L4W3zLN8+A4FC83e39W8z1LCl8XaWbZD8lhq
         kTr3kEDoWhv8LJWtwJfs6sk1lFy7zZvly6FocgKocy8R5yiJDV7s7mOpuCnzr/wQMC
         ufdTVJg7KH5evfZM7U8UUn6spOilQb8cS9KO0xAw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6365360128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f171.google.com with SMTP id z14-v6so12776663qtn.2;
        Sun, 30 Sep 2018 22:49:48 -0700 (PDT)
X-Gm-Message-State: ABuFfohmlbdg81zp9rQs/lTsvbqyAZ/Vr7xxwirmH+/jMrzk8JqmbyIW
        EOglkOMnSJt7PPOvz+Lw7OieakdQO3rbFInokcc=
X-Google-Smtp-Source: ACcGV61OeC0bjZb2CgPvrVSuLI7sDUEw64RA2nsmtExlG6/dMNHkNILCD7Yfm4sf+m9Z7QEXtBFd3JncqkM/o2en534=
X-Received: by 2002:a0c:d0cc:: with SMTP id b12-v6mr7333463qvh.107.1538372987638;
 Sun, 30 Sep 2018 22:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org> <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
In-Reply-To: <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 1 Oct 2018 11:19:34 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
Message-ID: <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
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

HI Ulf,

On Fri, Sep 28, 2018 at 5:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> >
> > The smmu needs to be functional only when the respective
> > master's using it are active. The device_link feature
> > helps to track such functional dependencies, so that the
> > iommu gets powered when the master device enables itself
> > using pm_runtime. So by adapting the smmu driver for
> > runtime pm, above said dependency can be addressed.
> >
> > This patch adds the pm runtime/sleep callbacks to the
> > driver and also the functions to parse the smmu clocks
> > from DT and enable them in resume/suspend.
> >
> > Also, while we enable the runtime pm add a pm sleep suspend
> > callback that pushes devices to low power state by turning
> > the clocks off in a system sleep.
> > Also add corresponding clock enable path in resume callback.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > Signed-off-by: Archit Taneja <architt@codeaurora.org>
> > [vivek: rework for clock and pm ops]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 74 insertions(+), 3 deletions(-)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>
> [...]
>
> > -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> >  {
> >         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> > +       if (ret)
> > +               return ret;
> >
> >         arm_smmu_device_reset(smmu);
> > +
> >         return 0;
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +       clk_bulk_disable(smmu->num_clks, smmu->clks);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +{
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
>
> Looks like you should be able use pm_runtime_force_resume(), instead
> of using this local trick. Unless I am missing something, of course.
>
> In other words, just assign the system sleep callbacks for resume, to
> pm_runtime_force_resume(). And vice verse for the system suspend
> callbacks, pm_runtime_force_suspend(), of course.

Thanks for the review. I will change this as suggested.

>
> > +
> > +       return arm_smmu_runtime_resume(dev);
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> > +{
> > +       if (pm_runtime_suspended(dev))
> > +               return 0;
> > +
> > +       return arm_smmu_runtime_suspend(dev);
> > +}
> > +
> > +static const struct dev_pm_ops arm_smmu_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
>
> I am wondering if using the ->suspend|resume() callback is really
> "late/early" enough in the device suspend phase?
>
> Others is using the noirq phase and some is even using the syscore
> ops. Of course it depends on the behavior of the consumers of iommu
> device, and I guess not everyone is using device links, which for sure
> improves things in this regards as well.

Well yes, as you said the device links should be able to take care of
maintaining the correct suspend/resume order of smmu and its clients,
or am I missing your point here?
Let me know and I will be happy to incorporate any suggestions.
Thanks

Regards
Vivek

>
> > +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> > +                          arm_smmu_runtime_resume, NULL)
> > +};
> >
> >  static struct platform_driver arm_smmu_driver = {
> >         .driver = {
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
>
> BTW, apologize for very late review comments.
>
> Besides the above comments, the series looks good to me.
>
> Kind regards
> Uffe
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
