Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06CFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562C120C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BHV8bBG/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6pyyL2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562C120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeGLLGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:06:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeGLLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:06:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19BF460250; Thu, 12 Jul 2018 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531393048;
        bh=x2Cj04znTIlEyFw2OjKouNW+nqiq5lK0hIbRo9/8nZY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=BHV8bBG/Z4+yTR8xsaoc0ngId3JBzXy3zTq4NThtxHNH91RQc3+smCY3BGBIIU9mX
         bFOT27GQ4XgLfDAB9BF2/TxnNwePHMrq8Fa/GIgNGekp1PtbYlmlFLywOo9+Z9Bgrt
         oUuLOKq7UjSyy6lRiDgczTm9GWH9oPW2z3zAMXdM=
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com [209.85.220.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1621D60B10;
        Thu, 12 Jul 2018 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531393047;
        bh=x2Cj04znTIlEyFw2OjKouNW+nqiq5lK0hIbRo9/8nZY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=P6pyyL2/mevargweiR7MgNMGYet8xPiNnOl6lewNO1NN8BtxbnB8ouNi38EqILzPd
         JEipuZe1XtIngivgVOYyb4J1uP4SLufTKezZJgx2kzXCfBnKwl5aU7v1b2SAJBnlJG
         9GzgnJ7PZ8Hhfej48+zNIFYN+ZzDCoRc6eWmOGDE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1621D60B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f179.google.com with SMTP id d22-v6so15164782qkc.8;
        Thu, 12 Jul 2018 03:57:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlEYHgh4BkOJW/x/CsVD6n9V/CZasfonBxkspRoBDqveQL5r72aw
        xH6cX4a3o8vN5c8Lf26XQ0BA2FFKPp6B+5g3nO4=
X-Google-Smtp-Source: AAOMgpciMDBZwrufQRkH/mYD0rOJcCHW2U1RpmyBUPtnTm+Fs0XDarACjrGrdiWSgg+GrxyqCt2uiAajyCzvaQ31Yyw=
X-Received: by 2002:a37:5942:: with SMTP id n63-v6mr1272795qkb.28.1531393046282;
 Thu, 12 Jul 2018 03:57:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 03:57:25
 -0700 (PDT)
In-Reply-To: <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
 <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
 <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com> <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 12 Jul 2018 16:27:25 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFxiM0DDnRqUameH6XOYjgdAF8ysuXXAjkc8zsod-dVcQ@mail.gmail.com>
Message-ID: <CAFp+6iFxiM0DDnRqUameH6XOYjgdAF8ysuXXAjkc8zsod-dVcQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Jul 11, 2018 at 6:21 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Wed, Jul 11, 2018 at 8:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>> > Hi Rafael,
>> >
>> >
>> > On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>> >>> From: Sricharan R <sricharan@codeaurora.org>
>> >>>
>> >>> The smmu needs to be functional only when the respective
>> >>> master's using it are active. The device_link feature
>> >>> helps to track such functional dependencies, so that the
>> >>> iommu gets powered when the master device enables itself
>> >>> using pm_runtime. So by adapting the smmu driver for
>> >>> runtime pm, above said dependency can be addressed.
>> >>>
>> >>> This patch adds the pm runtime/sleep callbacks to the
>> >>> driver and also the functions to parse the smmu clocks
>> >>> from DT and enable them in resume/suspend.
>> >>>
>> >>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> >>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>> >>> [vivek: Clock rework to request bulk of clocks]
>> >>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> >>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> >>> ---
>> >>>
>> >>>  - No change since v11.
>> >>>
>> >>>  drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>> >>>  1 file changed, 58 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> >>> index f7a96bcf94a6..a01d0dde21dd 100644
>> >>> --- a/drivers/iommu/arm-smmu.c
>> >>> +++ b/drivers/iommu/arm-smmu.c
>> >>> @@ -48,6 +48,7 @@
>> >>>  #include <linux/of_iommu.h>
>> >>>  #include <linux/pci.h>
>> >>>  #include <linux/platform_device.h>
>> >>> +#include <linux/pm_runtime.h>
>> >>>  #include <linux/slab.h>
>> >>>  #include <linux/spinlock.h>
>> >>>
>> >>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>> >>>       u32                             num_global_irqs;
>> >>>       u32                             num_context_irqs;
>> >>>       unsigned int                    *irqs;
>> >>> +     struct clk_bulk_data            *clks;
>> >>> +     int                             num_clks;
>> >>>
>> >>>       u32                             cavium_id_base; /* Specific to Cavium */
>> >>>
>> >>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>> >>>  struct arm_smmu_match_data {
>> >>>       enum arm_smmu_arch_version version;
>> >>>       enum arm_smmu_implementation model;
>> >>> +     const char * const *clks;
>> >>> +     int num_clks;
>> >>>  };
>> >>>
>> >>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>> >>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>> >>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>> >>>
>> >>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>> >>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> >>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>> >>>  };
>> >>>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>> >>>
>> >>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>> >>> +                                const char * const *clks)
>> >>> +{
>> >>> +     int i;
>> >>> +
>> >>> +     if (smmu->num_clks < 1)
>> >>> +             return;
>> >>> +
>> >>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>> >>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>> >>> +     if (!smmu->clks)
>> >>> +             return;
>> >>> +
>> >>> +     for (i = 0; i < smmu->num_clks; i++)
>> >>> +             smmu->clks[i].id = clks[i];
>> >>> +}
>> >>> +
>> >>>  #ifdef CONFIG_ACPI
>> >>>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>> >>>  {
>> >>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>> >>>       data = of_device_get_match_data(dev);
>> >>>       smmu->version = data->version;
>> >>>       smmu->model = data->model;
>> >>> +     smmu->num_clks = data->num_clks;
>> >>> +
>> >>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>> >>>
>> >>>       parse_driver_options(smmu);
>> >>>
>> >>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>> >>>               smmu->irqs[i] = irq;
>> >>>       }
>> >>>
>> >>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>> >>> +     if (err)
>> >>> +             return err;
>> >>> +
>> >>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>> >>> +     if (err)
>> >>> +             return err;
>> >>> +
>> >>>       err = arm_smmu_device_cfg_probe(smmu);
>> >>>       if (err)
>> >>>               return err;
>> >>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>> >>>
>> >>>       /* Turn the thing off */
>> >>>       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> >>> +
>> >>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>> >>> +
>> >>>       return 0;
>> >>>  }
>> >>>
>> >>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> >>>       return 0;
>> >>>  }
>> >>>
>> >>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> >>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>> >>> +{
>> >>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> >>> +
>> >>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>> >>> +}
>> >>> +
>> >>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>> >>> +{
>> >>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> >>> +
>> >>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>> >>> +
>> >>> +     return 0;
>> >>> +}
>> >>> +
>> >>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>> >>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>> >>
>> >> This is suspicious.
>> >>
>> >> If you need a runtime suspend method, why do you think that it is not necessary
>> >> to suspend the device during system-wide transitions?
>> >
>> > Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
>> > In that case the clocks have to be enabled in the resume path too.
>> >
>> > I remember Tomasz pointed to that we shouldn't need clock enable in resume
>> > path [1].
>> >
>> > [1] https://lkml.org/lkml/2018/3/15/60
>
> That was an answer for a different question. I don't remember
> suggesting having no suspend function.

My bad, apologies. You are right, we were discussing if we need any additional
handling of power for arm_smmu_device_reset() in arm_smmu_pm_resume().

> Although, given the PM
> subsystem internals, the suspend function wouldn't be called on SMMU
> implementation needed power control (since they would have runtime PM
> enabled) and on others, it would be called but do nothing (since no
> clocks).
>
>>
>> Honestly, I just don't know. :-)
>>
>> It just looks odd the way it is done.  I think the clock should be
>> gated during system-wide suspend too, because the system can spend
>> much more time in a sleep state than in the working state, on average.
>>
>> And note that you cannot rely on runtime PM to always do it for you,
>> because it may be disabled at a client device or even blocked by user
>> space via power/control in sysfs and that shouldn't matter for
>> system-wide PM.
>
> User space blocking runtime PM through sysfs is a good point. I'm not
> 100% sure how the PM subsystem deals with that in case of system-wide
> suspend. I guess for consistency and safety, we should have the
> suspend callback.

Will add the following suspend callback (same as arm_smmu_runtime_suspend):

 static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
 {
         struct arm_smmu_device *smmu = dev_get_drvdata(dev);

         clk_bulk_disable(smmu->num_clks, smmu->clks);

         return 0;
 }


Best regards
Vivek

>
> Best regards,
> Tomasz
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
