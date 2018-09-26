Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B352086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bpUpFp5S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yp7v20IJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B352086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIZMdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:33:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:33:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F83B60B0D; Wed, 26 Sep 2018 06:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942943;
        bh=cColSOZeWqz+e4w+QIQd9W/GExXWxE5US+i5UY5TMLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bpUpFp5SOjPWRtTTjOqoBrUuVS/VKZJFnUhOLJEUvnkHPQbu8EY2RU4ZfJFNuJJG/
         BIJJdLDe+slhDJCUPxBVppJr6vq/mH0WbjB9PytIIUmm327+/Of24PoEqCbej9vNc9
         4b+F6+8hjZhCiepzuL8A+DGqFPrG0fk9lqd4ggmE=
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8AF3600C1;
        Wed, 26 Sep 2018 06:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942936;
        bh=cColSOZeWqz+e4w+QIQd9W/GExXWxE5US+i5UY5TMLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yp7v20IJwyzOlaBlP7y3u+WF8hYd7udiZR6WGwkp1JnrOnB5kY0EG1XFTJo8DdNF8
         EMFWnDVs8y+j/P1gA0D/vyTqFWovROIGxyQ5Q9xOUQ+Qc7Sy4V2T0iSZNgHGGuNL2Q
         +qR5eylP7bspx2xBX9bnx3pTy7E+fbP1YDvCyuKM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8AF3600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f178.google.com with SMTP id z13-v6so16087375qts.5;
        Tue, 25 Sep 2018 23:22:16 -0700 (PDT)
X-Gm-Message-State: ABuFfogSfZkjiC8yfk7w09QYgAIXEZxC0To7stbJrxiB5cGblc334GGo
        8MG1lGbwobEgMXMfNkPJ1U2yIzJEswN1PgoyASI=
X-Google-Smtp-Source: ACcGV612WNoxPYXRHn7IqX/MbaVGLrjpXdHgI0rGMR3B+Yf5eEDkFAGDdzl7dY4hEp1OuVZVBxLKM7cNlS3ORoT5Tn4=
X-Received: by 2002:aed:37a6:: with SMTP id j35-v6mr3320627qtb.261.1537942935910;
 Tue, 25 Sep 2018 23:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org> <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
 <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org> <CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
 <CAFp+6iE3+qn6-gpXEzxfoP5yPMARmUcJNn0AZk-kA2AreTLnng@mail.gmail.com>
 <CAFp+6iHnHj_PkPFBUSTdJTW57K51wLqSEw6VOMKxAVo7O+ms9g@mail.gmail.com>
 <CAFp+6iFvhdSq7upbvsEWgMewhAaaRM91iw9p7qOFPYrUxis0Hg@mail.gmail.com> <aedf3f32-68ae-566a-3735-ca4ec5c7559a@arm.com>
In-Reply-To: <aedf3f32-68ae-566a-3735-ca4ec5c7559a@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 26 Sep 2018 11:52:03 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEDiH5rb8Hnza19q-+X7WBHfG5PZS9Pj+wfEcDTikMtUg@mail.gmail.com>
Message-ID: <CAFp+6iEDiH5rb8Hnza19q-+X7WBHfG5PZS9Pj+wfEcDTikMtUg@mail.gmail.com>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        alex.williamson@redhat.com, "robh+dt" <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Sep 26, 2018 at 12:25 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Vivek,
>
> On 2018-09-25 6:56 AM, Vivek Gautam wrote:
> > Hi Robin, Will,
> >
> > On Tue, Sep 18, 2018 at 8:41 AM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >>
> >> Hi Robin,
> >>
> >> On Fri, Sep 7, 2018 at 3:52 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>
> >>> On Fri, Sep 7, 2018 at 3:22 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >>>>
> >>>> On Fri, Sep 7, 2018 at 6:38 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>
> >>>>> Hi Tomasz,
> >>>>>
> >>>>>
> >>>>> On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> >>>>>> Hi Vivek,
> >>>>>>
> >>>>>> On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> >>>>>> <vivek.gautam@codeaurora.org> wrote:
> >>>>>>> From: Sricharan R <sricharan@codeaurora.org>
> >>>>>>>
> >>>>>>> The smmu device probe/remove and add/remove master device callbacks
> >>>>>>> gets called when the smmu is not linked to its master, that is without
> >>>>>>> the context of the master device. So calling runtime apis in those places
> >>>>>>> separately.
> >>>>>>> Global locks are also initialized before enabling runtime pm as the
> >>>>>>> runtime_resume() calls device_reset() which does tlb_sync_global()
> >>>>>>> that ultimately requires locks to be initialized.
> >>>>>>>
> >>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >>>>>>> [vivek: Cleanup pm runtime calls]
> >>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >>>>>>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>>>>>> ---
> >>>>>>>    drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> >>>>>>>    1 file changed, 81 insertions(+), 8 deletions(-)
> >>>>>> [snip]
> >>>>>>> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >>>>>>>           if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
> >>>>>>>                   dev_err(&pdev->dev, "removing device with active domains!\n");
> >>>>>>>
> >>>>>>> +       arm_smmu_rpm_get(smmu);
> >>>>>>>           /* Turn the thing off */
> >>>>>>>           writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >>>>>>> +       arm_smmu_rpm_put(smmu);
> >>>>>>> +
> >>>>>>> +       if (pm_runtime_enabled(smmu->dev))
> >>>>>>> +               pm_runtime_force_suspend(smmu->dev);
> >>>>>>> +       else
> >>>>>>> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
> >>>>>>>
> >>>>>>> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> >>>>>>> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> >>>>>> Aren't we missing pm_runtime_disable() here? We'll have the enable
> >>>>>> count unbalanced if the driver is removed and probed again.
> >>>>>
> >>>>> pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not
> >>>>> wrong.
> >>>>> And, as mentioned in a previous thread [1], we were seeing a warning
> >>>>> which we avoided
> >>>>> by keeping force_suspend().
> >>>>>
> >>>>> [1] https://lkml.org/lkml/2018/7/8/124
> >>>>
> >>>> I see, thanks. I didn't realize that pm_runtime_force_suspend()
> >>>> already disables runtime PM indeed. Sorry for the noise.
> >>>
> >>> Hi Tomasz,
> >>> No problem. Thanks for looking back at it.
> >>>
> >>> Hi Robin,
> >>> If you are fine with this series, then can you please consider giving
> >>> Reviewed-by, so that we are certain that this series will go in the next merge
> >>> window.
> >>> Thanks
> >>
> >> Gentle ping.
> >> You ack will be very helpful in letting Will pull this series for 4.20.
> >> Thanks.
> >
> > I would really appreciate if you could provide your ack for this series.
> > Or if there are any concerns, I am willing to address them.
>
> Apologies, I thought I'd replied to say I'd be getting to this shortly,
> but apparently not :(
>
> FWIW, "shortly" is now tomorrow - I don't *think* there's anything
> outstanding, but given the number of subtleties we've turned up so far I
> do just want one last thorough double-check to make sure.

Cool. TIA for the review. I hope we have something that we can land :),
and then work further to take care of addressing other needs of this driver.
Thanks.

Best regards
Vivek
>
> Thanks,
> Robin.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
