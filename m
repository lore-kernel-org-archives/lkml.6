Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35819C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF5D21580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ld9Nw5fQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UHsLZpYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF5D21580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeI0Ost (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:48:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0Ost (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:48:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FD4060A98; Thu, 27 Sep 2018 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538037103;
        bh=V+LGGfcvvf/8oHCFhtuvD+2A1ymlys4Bz5TY4YXLEI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ld9Nw5fQdFV+89YQ8Br5cKV83b4IH111nqxGfnrhypMiWdAPNZRuDHld2Apyft72L
         iMl3SkfJjGwp+ZG0zo2A6e3jXH/28mQWunNfa2jM0ZEGubA5hKqTfwh0DlN733+A24
         j2WI0youN6/XgEM6xfaDc6S0Urev1ovL+jzv6Cgo=
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F193960A98;
        Thu, 27 Sep 2018 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538037098;
        bh=V+LGGfcvvf/8oHCFhtuvD+2A1ymlys4Bz5TY4YXLEI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UHsLZpYShVaUCPXsxOQMnDEZ5SUZmJ5DvvMLmhCVbyxeAgu7yfPZr6hXdy7eslohm
         lUMvOpFlzP+NoxCKSuVlpiFYdJdN8/2w4ObufoipDPzbHY7eq++h2cqnsKuotKVKh0
         eINNejH5y0KManWNeR0ysRLh+RAbazl/LcGv7gQI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F193960A98
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f175.google.com with SMTP id e26-v6so1852936qtq.3;
        Thu, 27 Sep 2018 01:31:37 -0700 (PDT)
X-Gm-Message-State: ABuFfogQfC/6HyrKvXowxjBx648xaRNkb7G2SJ6QUWm86ALwSHOahpQm
        +Ra5RMUIEvOz8JMPyqmlotyDrWFMcRkxM9PEl2w=
X-Google-Smtp-Source: ACcGV61tXsXbGFLyUloRevNBdO2HuJjTVuUZi8wtq0B+Buag4OYwoCaaZ02lzu6sxKoQJKbZHxx+OMrJ1xUFAiycNoI=
X-Received: by 2002:ac8:218d:: with SMTP id 13-v6mr7215922qty.122.1538037097177;
 Thu, 27 Sep 2018 01:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org> <1a918f99-83b0-2f51-7634-126639a220de@arm.com>
In-Reply-To: <1a918f99-83b0-2f51-7634-126639a220de@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 27 Sep 2018 14:01:24 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEwKv3oHPX-Muc8f6fcUkDNyQDLGFv4=fvZgAKQ9nZMBw@mail.gmail.com>
Message-ID: <CAFp+6iEwKv3oHPX-Muc8f6fcUkDNyQDLGFv4=fvZgAKQ9nZMBw@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
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

On Wed, Sep 26, 2018 at 8:57 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/08/18 15:45, Vivek Gautam wrote:
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
> >   drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 74 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index fd1b80ef9490..d900e007c3c9 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -48,6 +48,7 @@
> >   #include <linux/of_iommu.h>
> >   #include <linux/pci.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> >
> > @@ -205,6 +206,8 @@ struct arm_smmu_device {
> >       u32                             num_global_irqs;
> >       u32                             num_context_irqs;
> >       unsigned int                    *irqs;
> > +     struct clk_bulk_data            *clks;
> > +     int                             num_clks;
> >
> >       u32                             cavium_id_base; /* Specific to Cavium */
> >
> > @@ -1896,10 +1899,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >   struct arm_smmu_match_data {
> >       enum arm_smmu_arch_version version;
> >       enum arm_smmu_implementation model;
> > +     const char * const *clks;
> > +     int num_clks;
> >   };
> >
> >   #define ARM_SMMU_MATCH_DATA(name, ver, imp) \
> > -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> > +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
> >
> >   ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> >   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> > @@ -1918,6 +1923,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >   };
> >   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >
> > +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> > +                                const char * const *clks)
> > +{
> > +     int i;
> > +
> > +     if (smmu->num_clks < 1)
> > +             return;
> > +
> > +     smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> > +                               sizeof(*smmu->clks), GFP_KERNEL);
> > +     if (!smmu->clks)
> > +             return;
> > +
> > +     for (i = 0; i < smmu->num_clks; i++)
> > +             smmu->clks[i].id = clks[i];
> > +}
> > +
> >   #ifdef CONFIG_ACPI
> >   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> >   {
> > @@ -2000,6 +2022,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
> >       data = of_device_get_match_data(dev);
> >       smmu->version = data->version;
> >       smmu->model = data->model;
> > +     smmu->num_clks = data->num_clks;
> > +
> > +     arm_smmu_fill_clk_data(smmu, data->clks);
> >
> >       parse_driver_options(smmu);
> >
> > @@ -2098,6 +2123,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >               smmu->irqs[i] = irq;
> >       }
> >
> > +     err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
> > +     if (err)
> > +             return err;
> > +
> > +     err = clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
> > +     if (err)
> > +             return err;
> > +
>
> Hmm, if we error out beyond here it looks like we should strictly
> balance that prepare/enable before devres does the clk_bulk_put(),
> however the probe error path is starting to look like it needs a bit of
> love in general, so I might just spin a cleanup patch on top (and even
> then only for the sake of not being a bad example; SMMU probe failure is
> never a realistic situation for the system to actually recover from).

Sure Robin. Thanks for the review on the series.
Let me know, I can spin a change for probe failure path cleanup.

Best regards
Vivek

>
> Otherwise,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> >       err = arm_smmu_device_cfg_probe(smmu);
> >       if (err)
> >               return err;
> > @@ -2184,6 +2217,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >
> >       /* Turn the thing off */
> >       writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> > +
> > +     clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> > +
> >       return 0;
> >   }
> >
> > @@ -2192,15 +2228,50 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
> >       arm_smmu_device_remove(pdev);
> >   }
> >
> > -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> >   {
> >       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> > +     if (ret)
> > +             return ret;
> >
> >       arm_smmu_device_reset(smmu);
> > +
> >       return 0;
> >   }
> >
> > -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > +{
> > +     struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > +
> > +     clk_bulk_disable(smmu->num_clks, smmu->clks);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> > +{
> > +     if (pm_runtime_suspended(dev))
> > +             return 0;
> > +
> > +     return arm_smmu_runtime_resume(dev);
> > +}
> > +
> > +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> > +{
> > +     if (pm_runtime_suspended(dev))
> > +             return 0;
> > +
> > +     return arm_smmu_runtime_suspend(dev);
> > +}
> > +
> > +static const struct dev_pm_ops arm_smmu_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
> > +     SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> > +                        arm_smmu_runtime_resume, NULL)
> > +};
> >
> >   static struct platform_driver arm_smmu_driver = {
> >       .driver = {
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
