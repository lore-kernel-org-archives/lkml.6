Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34326C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADC2215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zuv4+wfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADC2215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeI1SXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:23:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33209 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeI1SXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:23:43 -0400
Received: by mail-it1-f194.google.com with SMTP id h6-v6so38951ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cfAi6cLY5StfphmrK8e7JbfFGi0q2KFfmMHsIsRg4TI=;
        b=Zuv4+wfyvnmFHJZl7dHaphFMIA3lE7rcTe4qFDxae5HowADo2MFcigzgoq++udzuJ9
         WsXcLtfstVFQtIdncDHSZFSQLq3L9wGokSUlOcbI7KcTdkU++a9Mrr0pbbJgRA6HgA3B
         lUsxAhTexyYT5PP7emOdEp5hFFUtKw4v+q5Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cfAi6cLY5StfphmrK8e7JbfFGi0q2KFfmMHsIsRg4TI=;
        b=fcoSH3vSH7q66BLZWl6u99z+HyEFqab3LuVof4pzr3fjJg10sMWbZ1JCUE4GAD4OcL
         +5ZaLkYACtNn1g5LG1lEo71eBckmELp6Aer62yPDyYKiUCd9tpTlGikPdbNOIkbG8iFc
         W/aQBravexxlnfuYvwUXdAuhIIti9YxdbagwatkwPFSj7fU+JAQ6TnMosdDHn5XFfTyl
         1jpyvvf3d0qgJWBs/kCS6Ki1Iem/BihfG4EdKf187/4lMRmq1l1wX2Bqc6rt+cHKXyh3
         WEJCuV0Y6uq4SZ9JxjV3re9facRslwdDMTP68rL3O5Ejjdx1BakRO1OULsURS6nWLZ1B
         EPqg==
X-Gm-Message-State: ABuFfohOdNIfS2Iiec1PE4N9jhRop9WcYRN063Q2wzkv/y3XNN51qVH5
        SB4cZkb2t2E9l2k1cHrc5ImIPagMmUFp7oeNGp3IGA==
X-Google-Smtp-Source: ACcGV635tdHJW8V8L1IiwDQyYK8JYogZon6MLC+inVNv7WTFNIvdaTgCsiS5yYgoQyzdq39BJnen73hNTXcAhk2HxSw=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr1303690itd.45.1538136015830;
 Fri, 28 Sep 2018 05:00:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 04:59:35
 -0700 (PDT)
In-Reply-To: <20180830144541.17740-2-vivek.gautam@codeaurora.org>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org> <20180830144541.17740-2-vivek.gautam@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Sep 2018 13:59:35 +0200
Message-ID: <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, robdclark@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sricharan <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        architt@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu needs to be functional only when the respective
> master's using it are active. The device_link feature
> helps to track such functional dependencies, so that the
> iommu gets powered when the master device enables itself
> using pm_runtime. So by adapting the smmu driver for
> runtime pm, above said dependency can be addressed.
>
> This patch adds the pm runtime/sleep callbacks to the
> driver and also the functions to parse the smmu clocks
> from DT and enable them in resume/suspend.
>
> Also, while we enable the runtime pm add a pm sleep suspend
> callback that pushes devices to low power state by turning
> the clocks off in a system sleep.
> Also add corresponding clock enable path in resume callback.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> [vivek: rework for clock and pm ops]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 3 deletions(-)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c

[...]

> -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>  {
>         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
> +       if (ret)
> +               return ret;
>
>         arm_smmu_device_reset(smmu);
> +
>         return 0;
>  }
>
> -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +       clk_bulk_disable(smmu->num_clks, smmu->clks);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;

Looks like you should be able use pm_runtime_force_resume(), instead
of using this local trick. Unless I am missing something, of course.

In other words, just assign the system sleep callbacks for resume, to
pm_runtime_force_resume(). And vice verse for the system suspend
callbacks, pm_runtime_force_suspend(), of course.

> +
> +       return arm_smmu_runtime_resume(dev);
> +}
> +
> +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
> +{
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +
> +       return arm_smmu_runtime_suspend(dev);
> +}
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)

I am wondering if using the ->suspend|resume() callback is really
"late/early" enough in the device suspend phase?

Others is using the noirq phase and some is even using the syscore
ops. Of course it depends on the behavior of the consumers of iommu
device, and I guess not everyone is using device links, which for sure
improves things in this regards as well.

> +       SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +                          arm_smmu_runtime_resume, NULL)
> +};
>
>  static struct platform_driver arm_smmu_driver = {
>         .driver = {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

BTW, apologize for very late review comments.

Besides the above comments, the series looks good to me.

Kind regards
Uffe
