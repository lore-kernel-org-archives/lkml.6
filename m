Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6AA2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uwb+w+Pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6AA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeJAQPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:15:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41215 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeJAQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:15:37 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so8829519iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xanetU4/5HagGtkISNZ1t3wsrG5htnWymXlhbIcV6OU=;
        b=Uwb+w+Pu2Dz6M0puLAQW6acp+Dta9W8zMzVenK2F7svafrJnj7l/F1CRP83GNB3GZH
         34U2JMPjABVjoi1lMh735gC955YDyxsFmViQmgKN/Z09xE06e8MClThJF5iLazH/yezc
         3aUhjZ9XIulz6h9XURQa7pTCdZVK9a7dq9XhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xanetU4/5HagGtkISNZ1t3wsrG5htnWymXlhbIcV6OU=;
        b=Xm+GvdTbuLyRQo3MDs+ESxuBlDL2WOgf8r7yx1gQI6v9PbOW9ELufdL/euix5eEtIf
         IV9vPpWlPktEXe6ZDV2NExzRAcjAUU6XM2ZZHNov39MAw/1lB0Fmmtt6mQe7AMry0FOL
         e8y6bwUW7+UBa4KjWLcketpzXjCHEr+t6A2tVzyNCiRLZRGptzMbbJWmOcgQidSj2WYk
         0wXbSYvLPFSk582CsZzUXD3ZWGuLqkYOyU/Qvvq6wIlP0o10upKBBjRhJa2uF1QCCMpg
         DY1wC2HpHRUczeRr8qqzf696f94IMbaUEDEpeI3Rc97tzb953CQcMHdJk10iY7ODQ6kA
         Vs8w==
X-Gm-Message-State: ABuFfoi59t3/U9BPyfXbI8KBxl6rNHk8LiFdWT0c9SleK8Ry7+4MAKtK
        sKvKX0WZ7Z5hV5aMaDuZxPN63BP9nYxa4gHYXlCUpA==
X-Google-Smtp-Source: ACcGV63hLu33zNZ5nULLepf4/xdvOl/1FOK9Ibv42hmiRbUTWwg47MkVRvdahyUQRkgWX0AXEtQLVWnLtnnMfHWSgIU=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr6172975ioc.131.1538386723079;
 Mon, 01 Oct 2018 02:38:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:38:02 -0700 (PDT)
In-Reply-To: <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-2-vivek.gautam@codeaurora.org> <CAPDyKFohpvEMfDoDooYEyxPMeQ+9dU71qz7ZAZxQ1rzyW-w8iA@mail.gmail.com>
 <CAFp+6iHZysBmMZj+pZghPocEwDzU7KfR1gLQAQRBui+-gdiSTQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 11:38:02 +0200
Message-ID: <CAPDyKFrCWaeDLbmbrRb23V_mRk8doBjM3u2X9tm0XNXm=-n5vA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
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

On 1 October 2018 at 07:49, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> HI Ulf,
>
> On Fri, Sep 28, 2018 at 5:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 30 August 2018 at 16:45, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>> > From: Sricharan R <sricharan@codeaurora.org>
>> >
>> > The smmu needs to be functional only when the respective
>> > master's using it are active. The device_link feature
>> > helps to track such functional dependencies, so that the
>> > iommu gets powered when the master device enables itself
>> > using pm_runtime. So by adapting the smmu driver for
>> > runtime pm, above said dependency can be addressed.
>> >
>> > This patch adds the pm runtime/sleep callbacks to the
>> > driver and also the functions to parse the smmu clocks
>> > from DT and enable them in resume/suspend.
>> >
>> > Also, while we enable the runtime pm add a pm sleep suspend
>> > callback that pushes devices to low power state by turning
>> > the clocks off in a system sleep.
>> > Also add corresponding clock enable path in resume callback.
>> >
>> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> > Signed-off-by: Archit Taneja <architt@codeaurora.org>
>> > [vivek: rework for clock and pm ops]
>> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> > ---
>> >  drivers/iommu/arm-smmu.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
>> >  1 file changed, 74 insertions(+), 3 deletions(-)
>> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>
>> [...]
>>
>> > -static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> > +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>> >  {
>> >         struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> > +       int ret;
>> > +
>> > +       ret = clk_bulk_enable(smmu->num_clks, smmu->clks);
>> > +       if (ret)
>> > +               return ret;
>> >
>> >         arm_smmu_device_reset(smmu);
>> > +
>> >         return 0;
>> >  }
>> >
>> > -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>> > +{
>> > +       struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> > +
>> > +       clk_bulk_disable(smmu->num_clks, smmu->clks);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
>> > +{
>> > +       if (pm_runtime_suspended(dev))
>> > +               return 0;
>>
>> Looks like you should be able use pm_runtime_force_resume(), instead
>> of using this local trick. Unless I am missing something, of course.
>>
>> In other words, just assign the system sleep callbacks for resume, to
>> pm_runtime_force_resume(). And vice verse for the system suspend
>> callbacks, pm_runtime_force_suspend(), of course.
>
> Thanks for the review. I will change this as suggested.
>
>>
>> > +
>> > +       return arm_smmu_runtime_resume(dev);
>> > +}
>> > +
>> > +static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>> > +{
>> > +       if (pm_runtime_suspended(dev))
>> > +               return 0;
>> > +
>> > +       return arm_smmu_runtime_suspend(dev);
>> > +}
>> > +
>> > +static const struct dev_pm_ops arm_smmu_pm_ops = {
>> > +       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend, arm_smmu_pm_resume)
>>
>> I am wondering if using the ->suspend|resume() callback is really
>> "late/early" enough in the device suspend phase?
>>
>> Others is using the noirq phase and some is even using the syscore
>> ops. Of course it depends on the behavior of the consumers of iommu
>> device, and I guess not everyone is using device links, which for sure
>> improves things in this regards as well.
>
> Well yes, as you said the device links should be able to take care of
> maintaining the correct suspend/resume order of smmu and its clients,
> or am I missing your point here?
> Let me know and I will be happy to incorporate any suggestions.
> Thanks

If it works fine, then you may keep it as is.

Just wanted to point out that if any consumers relies on the iommu to
operational to say until the suspend-late phase, then this doesn't
play. Then you need to move your callbacks to the corresponding same
phase.

[...]

Kind regards
Uffe
