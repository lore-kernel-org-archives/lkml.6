Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B21C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FACD2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lt74//5P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DNA3rPqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FACD2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeGKK7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:59:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGKK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:59:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 64EC060A06; Wed, 11 Jul 2018 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531306530;
        bh=QElUyx46Aht79+FKFLgjBILlI7T/mr6Fv0XmWuE7GqI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Lt74//5PGlgvgrXgHJrplJI4lKSi6sisHpYWpO7f6zDdE90aVJGvNB4C58fvI/IYA
         bCOoJm4DK+aYBKZM/gKeP9/E2Uz6o5Y9QJphcWS2Yztu14OL8j+s5nuH/sGt2jNuoM
         4Js6m0cyxqNPHt+RXxnjP6mrGTdOuM+AcFxDa3uQ=
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D54F60B25;
        Wed, 11 Jul 2018 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531306528;
        bh=QElUyx46Aht79+FKFLgjBILlI7T/mr6Fv0XmWuE7GqI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=DNA3rPqZzDonkdHn4yao2uQR4hCDy+pvQmVEd7DNL4fLpWr2vF+AcXA/GH5oaJ55S
         HiPHjbTvrC055dBa3G3x6tJD0auGrXYzLl+mvzsCFQeSxebVyxudSy34duckXsFT8J
         lHT9/H4tfI7L+XbzOPG7glQBVgNhkTr2k3AtxEs4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D54F60B25
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f180.google.com with SMTP id u21-v6so13216429qku.2;
        Wed, 11 Jul 2018 03:55:28 -0700 (PDT)
X-Gm-Message-State: APt69E1bmpc0pDrnWjVtnDsoWGk5sbq8qlydf3ssoP5dIzOkGpU8iU/y
        fH7odbbzJnrOAUlXC/I6XUjemW/c2cMBz8EFbyc=
X-Google-Smtp-Source: AAOMgpfFDClP+ngvpYFevbLTmzc8VwHGZFARvisIl6EBQ1W7dmf36axzG5EWqwJlKJgcfxcbm44ALJIp0ADHJTOBfd4=
X-Received: by 2002:a37:6446:: with SMTP id y67-v6mr24873694qkb.309.1531306527383;
 Wed, 11 Jul 2018 03:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 03:55:26
 -0700 (PDT)
In-Reply-To: <17407514.unFVTGoGrn@aspire.rjw.lan>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 11 Jul 2018 16:25:26 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
Message-ID: <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,


On Wed, Jul 11, 2018 at 3:20 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Sunday, July 8, 2018 7:34:10 PM CEST Vivek Gautam wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu needs to be functional only when the respective
>> master's using it are active. The device_link feature
>> helps to track such functional dependencies, so that the
>> iommu gets powered when the master device enables itself
>> using pm_runtime. So by adapting the smmu driver for
>> runtime pm, above said dependency can be addressed.
>>
>> This patch adds the pm runtime/sleep callbacks to the
>> driver and also the functions to parse the smmu clocks
>> from DT and enable them in resume/suspend.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>> [vivek: Clock rework to request bulk of clocks]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>
>>  - No change since v11.
>>
>>  drivers/iommu/arm-smmu.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 58 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index f7a96bcf94a6..a01d0dde21dd 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -48,6 +48,7 @@
>>  #include <linux/of_iommu.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>
>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>       u32                             num_global_irqs;
>>       u32                             num_context_irqs;
>>       unsigned int                    *irqs;
>> +     struct clk_bulk_data            *clks;
>> +     int                             num_clks;
>>
>>       u32                             cavium_id_base; /* Specific to Cavium */
>>
>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>  struct arm_smmu_match_data {
>>       enum arm_smmu_arch_version version;
>>       enum arm_smmu_implementation model;
>> +     const char * const *clks;
>> +     int num_clks;
>>  };
>>
>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)  \
>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> @@ -1919,6 +1924,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>>
>> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
>> +                                const char * const *clks)
>> +{
>> +     int i;
>> +
>> +     if (smmu->num_clks < 1)
>> +             return;
>> +
>> +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
>> +                               sizeof(*smmu->clks), GFP_KERNEL);
>> +     if (!smmu->clks)
>> +             return;
>> +
>> +     for (i = 0; i < smmu->num_clks; i++)
>> +             smmu->clks[i].id = clks[i];
>> +}
>> +
>>  #ifdef CONFIG_ACPI
>>  static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
>>  {
>> @@ -2001,6 +2023,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>       data = of_device_get_match_data(dev);
>>       smmu->version = data->version;
>>       smmu->model = data->model;
>> +     smmu->num_clks = data->num_clks;
>> +
>> +     arm_smmu_fill_clk_data(smmu, data->clks);
>>
>>       parse_driver_options(smmu);
>>
>> @@ -2099,6 +2124,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>               smmu->irqs[i] = irq;
>>       }
>>
>> +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>> +     if (err)
>> +             return err;
>> +
>> +     err = clk_bulk_prepare(smmu->num_clks, smmu->clks);
>> +     if (err)
>> +             return err;
>> +
>>       err = arm_smmu_device_cfg_probe(smmu);
>>       if (err)
>>               return err;
>> @@ -2181,6 +2214,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>
>>       /* Turn the thing off */
>>       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> +
>> +     clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>> +
>>       return 0;
>>  }
>>
>> @@ -2197,7 +2233,27 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>>       return 0;
>>  }
>>
>> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>> +{
>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +     return clk_bulk_enable(smmu->num_clks, smmu->clks);
>> +}
>> +
>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>> +{
>> +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +     clk_bulk_disable(smmu->num_clks, smmu->clks);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>> +     SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>
> This is suspicious.
>
> If you need a runtime suspend method, why do you think that it is not necessary
> to suspend the device during system-wide transitions?

Okay, so you suggest to put clock disabling in say arm_smmu_pm_suspend()?
In that case the clocks have to be enabled in the resume path too.

I remember Tomasz pointed to that we shouldn't need clock enable in resume
path [1].

[1] https://lkml.org/lkml/2018/3/15/60


Best regards
Vivek

>
>> +     SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
>> +                        arm_smmu_runtime_resume, NULL)
>> +};
>>
>>  static struct platform_driver arm_smmu_driver = {
>>       .driver = {
>>
>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
