Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABAAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F080E21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="akpFbhXr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RPQI6RlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F080E21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeIYMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:02:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIYMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:02:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 536ED607DC; Tue, 25 Sep 2018 05:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537854979;
        bh=VBJtdc5abMID1376NKVyjQlHwtIh4KAr4awMZ/0z/+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=akpFbhXrcKwLyveIqgTOy1NoYAC+PeJO4VZ4+mNKcuN524SgRWoUpD0ej1f376bgF
         Nv8GE4FxuhfAFgP3rh30UxEuV2YPStPH6rym5IWyOuPNbcG4M5BqGnYO2MMyT/Peoy
         G6yORPvleEGIDN9DFLb7VyqSYMaFOCy9zau1o5/s=
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCBDF607DC;
        Tue, 25 Sep 2018 05:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537854978;
        bh=VBJtdc5abMID1376NKVyjQlHwtIh4KAr4awMZ/0z/+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RPQI6RlOi3WtUIkQpZ0h/Z0ZtvD2qPM0E9JfViRliCbdzAwmU87yeoUOvQtYOHjcl
         0cYQWa3xMCfCGQ18wf98dfU42rW9KP/0+n/rILrmhbfdYsPO0Qsqq9th49OT4zBvoe
         SgBse0GDHpXBpb7cJX9QzmuKQJf1oSU9JjtofU7g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCBDF607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f179.google.com with SMTP id b19-v6so12809637qkc.6;
        Mon, 24 Sep 2018 22:56:17 -0700 (PDT)
X-Gm-Message-State: ABuFfoixEvF2zwFz8/c8BGBUTO5sVHjib+lROKhP+ar4Y8GayrHAUZFA
        zDSeCcsNlc12ciM71N29AQ3DLSeStdPzMlj8oEA=
X-Google-Smtp-Source: ACcGV622tsRI3Uys7O+mzkxrdqxW9eaXn3zif7m+Lo5AedQETIuZN+4dIIQ5jn0etrtL1YVcL26Z+9Z3UATYEl9TKeE=
X-Received: by 2002:a37:c44c:: with SMTP id h12-v6mr1486652qkm.279.1537854977014;
 Mon, 24 Sep 2018 22:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org> <CAAFQd5B7YR03Jm1upOg2nsaKOb1iDD7-WGo-qx7S8m-nounCvA@mail.gmail.com>
 <3ccc3690-dc9d-56e7-e2d1-62e73a189bff@codeaurora.org> <CAAFQd5DMDWEeBU=fg6arye3pXnrCqOA4tDtMSGutXk7vSz-EtQ@mail.gmail.com>
 <CAFp+6iE3+qn6-gpXEzxfoP5yPMARmUcJNn0AZk-kA2AreTLnng@mail.gmail.com> <CAFp+6iHnHj_PkPFBUSTdJTW57K51wLqSEw6VOMKxAVo7O+ms9g@mail.gmail.com>
In-Reply-To: <CAFp+6iHnHj_PkPFBUSTdJTW57K51wLqSEw6VOMKxAVo7O+ms9g@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 25 Sep 2018 11:26:04 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFvhdSq7upbvsEWgMewhAaaRM91iw9p7qOFPYrUxis0Hg@mail.gmail.com>
Message-ID: <CAFp+6iFvhdSq7upbvsEWgMewhAaaRM91iw9p7qOFPYrUxis0Hg@mail.gmail.com>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Will,

On Tue, Sep 18, 2018 at 8:41 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Robin,
>
> On Fri, Sep 7, 2018 at 3:52 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >
> > On Fri, Sep 7, 2018 at 3:22 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > >
> > > On Fri, Sep 7, 2018 at 6:38 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > >
> > > > Hi Tomasz,
> > > >
> > > >
> > > > On 9/7/2018 2:46 PM, Tomasz Figa wrote:
> > > > > Hi Vivek,
> > > > >
> > > > > On Thu, Aug 30, 2018 at 11:46 PM Vivek Gautam
> > > > > <vivek.gautam@codeaurora.org> wrote:
> > > > >> From: Sricharan R <sricharan@codeaurora.org>
> > > > >>
> > > > >> The smmu device probe/remove and add/remove master device callbacks
> > > > >> gets called when the smmu is not linked to its master, that is without
> > > > >> the context of the master device. So calling runtime apis in those places
> > > > >> separately.
> > > > >> Global locks are also initialized before enabling runtime pm as the
> > > > >> runtime_resume() calls device_reset() which does tlb_sync_global()
> > > > >> that ultimately requires locks to be initialized.
> > > > >>
> > > > >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > > >> [vivek: Cleanup pm runtime calls]
> > > > >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > > >> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > > >> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > >> ---
> > > > >>   drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> > > > >>   1 file changed, 81 insertions(+), 8 deletions(-)
> > > > > [snip]
> > > > >> @@ -2215,10 +2281,17 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> > > > >>          if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
> > > > >>                  dev_err(&pdev->dev, "removing device with active domains!\n");
> > > > >>
> > > > >> +       arm_smmu_rpm_get(smmu);
> > > > >>          /* Turn the thing off */
> > > > >>          writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> > > > >> +       arm_smmu_rpm_put(smmu);
> > > > >> +
> > > > >> +       if (pm_runtime_enabled(smmu->dev))
> > > > >> +               pm_runtime_force_suspend(smmu->dev);
> > > > >> +       else
> > > > >> +               clk_bulk_disable(smmu->num_clks, smmu->clks);
> > > > >>
> > > > >> -       clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
> > > > >> +       clk_bulk_unprepare(smmu->num_clks, smmu->clks);
> > > > > Aren't we missing pm_runtime_disable() here? We'll have the enable
> > > > > count unbalanced if the driver is removed and probed again.
> > > >
> > > > pm_runtime_force_suspend() does a pm_runtime_disable() also if i am not
> > > > wrong.
> > > > And, as mentioned in a previous thread [1], we were seeing a warning
> > > > which we avoided
> > > > by keeping force_suspend().
> > > >
> > > > [1] https://lkml.org/lkml/2018/7/8/124
> > >
> > > I see, thanks. I didn't realize that pm_runtime_force_suspend()
> > > already disables runtime PM indeed. Sorry for the noise.
> >
> > Hi Tomasz,
> > No problem. Thanks for looking back at it.
> >
> > Hi Robin,
> > If you are fine with this series, then can you please consider giving
> > Reviewed-by, so that we are certain that this series will go in the next merge
> > window.
> > Thanks
>
> Gentle ping.
> You ack will be very helpful in letting Will pull this series for 4.20.
> Thanks.

I would really appreciate if you could provide your ack for this series.
Or if there are any concerns, I am willing to address them.
Thanks.

Best regards
Vivek



>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
