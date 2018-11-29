Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA862C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE2221019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QTsRUWIA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YjXHY3Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE2221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbeK3CBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:01:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38174 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbeK3CBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:01:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2715B60B7F; Thu, 29 Nov 2018 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543503336;
        bh=iUVWaFYMsbu4rPMh/T2kg2TRo1s9xfns0KVJYkocPtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QTsRUWIANyMYYAVdNWdQYiX7/r9DxKCjNkVBz4+AFBnx9WEZht3O1c1Qw+L5zVYYF
         1manra32KmqDpeCC8EVk9m83aap+tlNLK942X3zIo0KdpPGOwjHUmZe3S1lkrvizjK
         bLj9/ylYEYqEPhESMcvUg6Fttkp18YRW320o7hZA=
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 967C360159;
        Thu, 29 Nov 2018 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543503335;
        bh=iUVWaFYMsbu4rPMh/T2kg2TRo1s9xfns0KVJYkocPtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YjXHY3Rnl8X/jNjlZwzWt9j0VmhA6wbcWij49/dm5eY0D+tbf+b/dXJLavReL3Hiw
         AfMABjUvG3n4bPVTH16g6Tt9xNjFbv7SLT/Rzvv6/B7b6FfEZb6YXihHR9RbmuYevM
         kPWJ2FxCVfwm3G6ReGIAmeFRlV8q6IjWPd/nyaTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 967C360159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f180.google.com with SMTP id i7so2204123qtj.10;
        Thu, 29 Nov 2018 06:55:35 -0800 (PST)
X-Gm-Message-State: AA+aEWYh66dNrQUdfweEacGS17I0RUtDpon8+FLOieFc+DaF2LI+SAv3
        af0jfzfUgX6tuxEZmU6je/p/t9GTlSS+AYBVvJI=
X-Google-Smtp-Source: AFSGD/VauDmD0Yx/TUa6pTO1UI7Ofq+09fbbQoH87CMd2oNtLraNCl5jsK0Hm0e6eE1VrquFMnr/xqNk4SE901dpeY0=
X-Received: by 2002:a0c:f9c3:: with SMTP id j3mr1709969qvo.107.1543503334904;
 Thu, 29 Nov 2018 06:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org> <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
 <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
In-Reply-To: <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 29 Nov 2018 20:25:20 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
Message-ID: <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     sboyd@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:07 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 28/11/2018 16:24, Stephen Boyd wrote:
> > Quoting Vivek Gautam (2018-11-27 02:11:41)
> >> @@ -1966,6 +1970,23 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >>   };
> >>   MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >>
> >> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> >> +                                  const char * const *clks)
> >> +{
> >> +       int i;
> >> +
> >> +       if (smmu->num_clks < 1)
> >> +               return;
> >> +
> >> +       smmu->clks = devm_kcalloc(smmu->dev, smmu->num_clks,
> >> +                                 sizeof(*smmu->clks), GFP_KERNEL);
> >> +       if (!smmu->clks)
> >> +               return;
> >> +
> >> +       for (i = 0; i < smmu->num_clks; i++)
> >> +               smmu->clks[i].id = clks[i];
> >
> > Is this clk_bulk_get_all()?

From what I remember, and now I could go back to v7 and check [1], we parked
clk_bulk_get out of OF's sole purview as we also have
arm_smmu_device_acpi_probe() besides arm_smmu_device_dt_probe().

arm_smmu_device_dt_probe() could get the clocks from dt and fill in
the clock bulk data, and
similarly, arm_smmu_device_acpi_probe() could fill the clock bulk data
by getting it from ACPI.

clk_bulk_get_all() seems like going only the OF way.
Is there another way here to have something common between ACPI
and OF, and then do the clk_bulk_get?

[1] https://lore.kernel.org/patchwork/patch/881365/

Thanks & regards
Vivek

>
> Ooh, did that finally get merged while we weren't looking? Great!
>
> Much as I don't want to drag this series out to a v19, it *would* be
> neat if we no longer need to open-code that bit...
>
> Robin.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
