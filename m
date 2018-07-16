Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C041AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E85208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dypok3fB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E85208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeGPJRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:17:36 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35025 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeGPJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:17:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so73342821oik.2;
        Mon, 16 Jul 2018 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+NCDFUmOVhTwMczuB/ChB9RTdQygGOdGA3wFK1UmzyM=;
        b=dypok3fB9pw/hdsvpcjHp99DlOdspGGaQCpgOpOPMSTugmQzwD8i/WNvQbkTN+AlZd
         MZ6H8hHDzGTbA3CYL5OmUUPTL5kjvCWUfLlxo8S1tLaY4ao+PeGySJsER9CdBl0wFULz
         jnfQxJRXragLu06csNbODVq3b2BP7SL1woKKXFfbtAAVXtwwRmtmRYg7MNa9m5BSC05w
         5WrN94XP7dgBjbGFcH7adTzLVVmHOY2LI0WOrl46HZymqu6XmcDXN8zbLRf+Fb27miKg
         DvL2MPfSvNXK8N6RZWkom2+gXEDblQIeSLN+VqJNG3pYSmhxR81yJELuucJXcdNJ4O58
         mkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+NCDFUmOVhTwMczuB/ChB9RTdQygGOdGA3wFK1UmzyM=;
        b=pkFAbmCIIeqHtCYuloyr1XmxQYvvk9urSuXptf0yXHpSKawE6BeQlOPDz0ybI+ARls
         nviQ8kxb3Cf9u4rJXgej15LzwIZ3OEagHHzz8/W/7xzabFSRuS/Wh0oSuDwfYwFHFd1S
         IKY2DLpyQHC9MbA8gyFF65ap0Knn1wq4BQY+mySH0ujcTX+Chj0N4m5PgEGmek+S4LDk
         9NFhEm1UTmJNDiFKSF421Cbv3iUL4xtkjiBfL4fGYGOFSElg9CzSDKx/Wy98daYsgXLa
         Q1kqXu89pid06F87xDXXlnNvNh7ai3pAxTT4Dx4tEk1TQxYwNkzrIRyrPIml1iDEYtUB
         OqMA==
X-Gm-Message-State: AOUpUlHmGJSoq1Bbq30DME7VlYz+YeJ2QPYWbrlvlZb/NCYqWWr5PEm4
        mLWBLX04h367MsSB+9GHRzC767R/PPNk9cn5jRQ=
X-Google-Smtp-Source: AAOMgpfhpPv0Yor0+eJFDvW1XICbPfZBhrg2TbpVDzg0dAkmx7JJsFd5LHc365B2YiaOCdt2n3lxyk5+dhkGDQ9QsNk=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr15758538oif.358.1531731073859;
 Mon, 16 Jul 2018 01:51:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 01:51:13
 -0700 (PDT)
In-Reply-To: <CAFp+6iFxiM0DDnRqUameH6XOYjgdAF8ysuXXAjkc8zsod-dVcQ@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
 <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
 <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
 <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com> <CAFp+6iFxiM0DDnRqUameH6XOYjgdAF8ysuXXAjkc8zsod-dVcQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Jul 2018 10:51:13 +0200
X-Google-Sender-Auth: ImVvC317nXyCkxFEbL0c5PBblKM
Message-ID: <CAJZ5v0hq3bLUbXNsr_ig7D72td_wqRP063x1AseP85F5UWs8VA@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
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

On Thu, Jul 12, 2018 at 12:57 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi,
>
>
> On Wed, Jul 11, 2018 at 6:21 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> On Wed, Jul 11, 2018 at 8:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Wed, Jul 11, 2018 at 12:55 PM, Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>> > Hi Rafael,
>>> >
>>> >
>>> > On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> >> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>>> >>> From: Sricharan R <sricharan@codeaurora.org>
>>> >>>
>>> >>> The smmu needs to be functional only when the respective
>>> >>> master's using it are active. The device_link feature
>>> >>> helps to track such functional dependencies, so that the
>>> >>> iommu gets powered when the master device enables itself
>>> >>> using pm_runtime. So by adapting the smmu driver for
>>> >>> runtime pm, above said dependency can be addressed.
>>> >>>
>>> >>> This patch adds the pm runtime/sleep callbacks to the
>>> >>> driver and also the functions to parse the smmu clocks
>>> >>> from DT and enable them in resume/suspend.
>>> >>>
>>> >>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> >>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>> >>> [vivek: Clock rework to request bulk of clocks]
>>> >>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> >>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>> >>> ---
>>> >>>
>>> >>>  - No change since v11.
>>> >>>
>>> >>>  drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>>> >>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>> >>>
>>> >>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> >>> index f7a96bcf94a6..a01d0dde21dd 100644
>>> >>> --- a/drivers/iommu/arm-smmu.c
>>> >>> +++ b/drivers/iommu/arm-smmu.c
>>> >>> @@ -48,6 +48,7 @@
>>> >>>  #include <linux/of_iommu.h>
>>> >>>  #include <linux/pci.h>
>>> >>>  #include <linux/platform_device.h>
>>> >>> +#include <linux/pm_runtime.h>
>>> >>>  #include <linux/slab.h>
>>> >>>  #include <linux/spinlock.h>
>>> >>>
>>> >>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>> >>>       u32                             num_global_irqs;
>>> >>>       u32                             num_context_irqs;
>>> >>>       unsigned int                    *irqs;
>>> >>> +     struct clk_bulk_data            *clks;
>>> >>> +     int                             num_clks;
>>> >>>
>>> >>>       u32                             cavium_id_base; /* Specific to Cavium */
>>> >>>
>>> >>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>> >>>  struct arm_smmu_match_data {
>>> >>>       enum arm_smmu_arch_version version;
>>> >>>       enum arm_smmu_implementation model;
>>> >>> +     const char * const *clks;
>>> >>> +     int num_clks;
>>> >>>  };
>>> >>>
>>> >>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>>> >>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>> >>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>> >>>
>>> >>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>> >>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>>> >>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>> >>>  };
>>> >>>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>> >>>
>>> >>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>>> >>> +                                const char * const *clks)
>>> >>> +{
>>> >>> +     int i;
>>> >>> +
>>> >>> +     if (smmu->num_clks < 1)
>>> >>> +             return;
>>> >>> +
>>> >>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>>> >>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>>> >>> +     if (!smmu->clks)
>>> >>> +             return;
>>> >>> +
>>> >>> +     for (i = 0; i < smmu->num_clks; i++)
>>> >>> +             smmu->clks[i].id = clks[i];
>>> >>> +}
>>> >>> +
>>> >>>  #ifdef CONFIG_ACPI
>>> >>>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>> >>>  {
>>> >>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>> >>>       data = of_device_get_match_data(dev);
>>> >>>       smmu->version = data->version;
>>> >>>       smmu->model = data->model;
>>> >>> +     smmu->num_clks = data->num_clks;
>>> >>> +
>>> >>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>>> >>>
>>> >>>       parse_driver_options(smmu);
>>> >>>
>>> >>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>> >>>               smmu->irqs[i] = irq;
>>> >>>       }
>>> >>>
>>> >>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>>> >>> +     if (err)
>>> >>> +             return err;
>>> >>> +
>>> >>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>>> >>> +     if (err)
>>> >>> +             return err;
>>> >>> +
>>> >>>       err = arm_smmu_device_cfg_probe(smmu);
>>> >>>       if (err)
>>> >>>               return err;
>>> >>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>> >>>
>>> >>>       /* Turn the thing off */
>>> >>>       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>> >>> +
>>> >>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>> >>> +
>>> >>>       return 0;
>>> >>>  }
>>> >>>
>>> >>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>> >>>       return 0;
>>> >>>  }
>>> >>>
>>> >>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>>> >>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>>> >>> +{
>>> >>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>> >>> +
>>> >>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>>> >>> +}
>>> >>> +
>>> >>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>> >>> +{
>>> >>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>> >>> +
>>> >>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>>> >>> +
>>> >>> +     return 0;
>>> >>> +}
>>> >>> +
>>> >>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>>> >>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>>> >>
>>> >> This is suspicious.
>>> >>
>>> >> If you need a runtime suspend method, why do you think that it is not necessary
>>> >> to suspend the device during system-wide transitions?
>>> >
>>> > Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
>>> > In that case the clocks have to be enabled in the resume path too.
>>> >
>>> > I remember Tomasz pointed to that we shouldn't need clock enable in resume
>>> > path [1].
>>> >
>>> > [1] https://lkml.org/lkml/2018/3/15/60
>>
>> That was an answer for a different question. I don't remember
>> suggesting having no suspend function.
>
> My bad, apologies. You are right, we were discussing if we need any additional
> handling of power for arm_smmu_device_reset() in arm_smmu_pm_resume().
>
>> Although, given the PM
>> subsystem internals, the suspend function wouldn't be called on SMMU
>> implementation needed power control (since they would have runtime PM
>> enabled) and on others, it would be called but do nothing (since no
>> clocks).
>>
>>>
>>> Honestly, I just don't know. :-)
>>>
>>> It just looks odd the way it is done.  I think the clock should be
>>> gated during system-wide suspend too, because the system can spend
>>> much more time in a sleep state than in the working state, on average.
>>>
>>> And note that you cannot rely on runtime PM to always do it for you,
>>> because it may be disabled at a client device or even blocked by user
>>> space via power/control in sysfs and that shouldn't matter for
>>> system-wide PM.
>>
>> User space blocking runtime PM through sysfs is a good point. I'm not
>> 100% sure how the PM subsystem deals with that in case of system-wide
>> suspend. I guess for consistency and safety, we should have the
>> suspend callback.
>
> Will add the following suspend callback (same as arm_smmu_runtime_suspend):
>
>  static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>  {
>          struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>
>          clk_bulk_disable(smmu->num_clks, smmu->clks);
>
>          return 0;
>  }

I think you also need to check if the clock has already been disabled
by runtime PM.  Otherwise you may end up disabling it twice in a row.
