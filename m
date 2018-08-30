Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E71C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B892082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mcsTDsdm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YdhOjbp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B892082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeH3NX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:23:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbeH3NX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:23:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B1E56053D; Thu, 30 Aug 2018 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535620936;
        bh=Kf3w/av/yLP3d0By/0vVXzz86NBMVrFNM8h9fShqe2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mcsTDsdmlRx6Vtcy49yOpcMvHuK/YfVckRU6l7LlZexHCx2yBErsz+HbzYx0eh2Qo
         0tf+4FoylOUnt1N20sUbs44ZjCnwvu8ffyD8Ew7XeREne4ptjO0elDInSl2+VGf+qM
         bD3bVcbscCx935B5vOMngZbNTBH7cQVYCEbNcoOY=
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 328B5606FA;
        Thu, 30 Aug 2018 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535620935;
        bh=Kf3w/av/yLP3d0By/0vVXzz86NBMVrFNM8h9fShqe2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YdhOjbp6fK8q70lzV1Ltbkp2ITKz6c74+An5iAgCdaZ8jAtOuoyVxcwNXGBByBLM7
         1zxQ1BEJ6O9239x0amk+YUz+7/j3BkZxBLkPYAm7WW7gZXjDIlv+rVoAF9R8qd8zye
         ddAswSPHTQdV/yNIcxDZMdiu8hzMiuRvn36rEVKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 328B5606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f174.google.com with SMTP id j7-v6so9005162qtp.2;
        Thu, 30 Aug 2018 02:22:15 -0700 (PDT)
X-Gm-Message-State: APzg51BHbMDP4oUHT6B8YLuhCrVn2SeQV5DWhywH0oKDWPONY65vGrgj
        wHdc4/fh35sOdWSBAB7LNGVorPl5BgRvbbvLE8c=
X-Google-Smtp-Source: ANB0VdaPX3qrK0JI4FGSODwqziIV3ffimsR/zUWXy8QwxjvJ9pWbaPOcXtAaYlMnCz4BIM61TiV3tCbC5NYLE0MIrSk=
X-Received: by 2002:a0c:ada8:: with SMTP id w37-v6mr10497810qvc.107.1535620934270;
 Thu, 30 Aug 2018 02:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org> <20180827105551.16346-3-vivek.gautam@codeaurora.org>
In-Reply-To: <20180827105551.16346-3-vivek.gautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 30 Aug 2018 14:52:01 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGbfHZQjG5oEVKhQ=4rOaaU=5ePykEuwMqYbPTryX6DnA@mail.gmail.com>
Message-ID: <CAFp+6iGbfHZQjG5oEVKhQ=4rOaaU=5ePykEuwMqYbPTryX6DnA@mail.gmail.com>
Subject: Re: [Patch v15 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 4:27 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu device probe/remove and add/remove master device callbacks
> gets called when the smmu is not linked to its master, that is without
> the context of the master device. So calling runtime apis in those places
> separately.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [vivek: Cleanup pm runtime calls]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>
> Changes since v14:
>  - none.
>
>  drivers/iommu/arm-smmu.c | 101 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 93 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a81224bc6637..23b4a60149b6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c

[snip]

> @@ -2131,6 +2188,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>         if (err)
>                 return err;
>
> +       /*
> +        * We want to avoid touching dev->power.lock in fastpaths unless
> +        * it's really going to do something useful - pm_runtime_enabled()
> +        * can serve as an ideal proxy for that decision. So, conditionally
> +        * enable pm_runtime.
> +        */
> +       if (dev->pm_domain)
> +               pm_runtime_enable(dev);
> +
> +       err = arm_smmu_rpm_get(smmu);

We shouldn't be doing a runtime_get() yet, as this eventually calls
arm_smmu_device_reset().
arm_smmu_device_reset() should be called only after arm_smmu_device_cfg_probe().
So, I plan to replace the pm_runtime_get/put() calls in probe() with
simple clk_bulk_enable()
to let the driver initialize smmu, and at the end of the probe we can
disable the clocks and
enable runtime pm over the device to let it take care of the device further-on.

> +       if (err < 0)
> +               return err;
> +
> +       /* Enable clocks explicitly if runtime PM is disabled */
> +       if (!pm_runtime_enabled(dev)) {
> +               err = clk_bulk_enable(smmu->num_clks, smmu->clks);
> +               if (err)
> +                       return err;
> +       }
> +
>         err = arm_smmu_device_cfg_probe(smmu);
>         if (err)
>                 return err;

[snip]

Best regards
Vivek
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
