Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B912073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j7gL4WOK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="drmaEKp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B912073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeH3SC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:02:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3SC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:02:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 02FA260912; Thu, 30 Aug 2018 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535637609;
        bh=xlnDAfHcLt8P6yv5162XbShaDXF2IfadAZMQKVnM8jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j7gL4WOKyuzpY89wKdKtYbaEHyAfQt5BY1aChMJa6dSw94FQWmRedJGa5DIIMyvvO
         dRz4yXGTKYf+ViEeIYOPaMtDGItEFsOJyi7lvnAD5bW8TtC0MupXSk1iMi6YGf/Z1k
         Ork9hGxgDnVW5kiSHSzoazVEDFYBZKGd4kv7QSAw=
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4437060A98;
        Thu, 30 Aug 2018 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535637600;
        bh=xlnDAfHcLt8P6yv5162XbShaDXF2IfadAZMQKVnM8jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=drmaEKp13ZaJrAVmZWSLja7tAZX2XTGQmM20lwu2dqcIso1I4gkCT8HxcyUrtsfL/
         LviJuIlxoaREVvBuBRjoTpTzAcbBRIY+sjflhy7PWFo5hY1KiTkxbNJVCyKZ1ictNF
         yeJ+UnZ9BFsgxNl4TUODhENBMqwX1+1bQh0EDSnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4437060A98
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f179.google.com with SMTP id k38-v6so9882848qtk.11;
        Thu, 30 Aug 2018 07:00:00 -0700 (PDT)
X-Gm-Message-State: APzg51DCXBlUUYzJIVU6fgDPsKcJxgFE/qLSiBwYPeJDhpz+ALd1vTTs
        dK/eKR73sC8bE6dymxnzYE7mYXgYCWy/1p2GLUo=
X-Google-Smtp-Source: ANB0Vdah9aFzfS7HamP4azknvNbjrsrSigIPUZOUZc4deWG0KxqJWksSCaZu3csiL8HdL5GVgVyrPIGB3icJy4WrE1M=
X-Received: by 2002:ac8:435e:: with SMTP id a30-v6mr11796351qtn.261.1535637599087;
 Thu, 30 Aug 2018 06:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-3-vivek.gautam@codeaurora.org> <CAFp+6iGbfHZQjG5oEVKhQ=4rOaaU=5ePykEuwMqYbPTryX6DnA@mail.gmail.com>
 <CAAFQd5BrJppNSo8ETT6ywjuLEULk4nAvWDQEuNiMCvdddeUq1A@mail.gmail.com>
In-Reply-To: <CAAFQd5BrJppNSo8ETT6ywjuLEULk4nAvWDQEuNiMCvdddeUq1A@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 30 Aug 2018 19:29:46 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGgePK14WGOdrE2cHLMpZ0JbS6qUvVoP-0mW55xh5haHg@mail.gmail.com>
Message-ID: <CAFp+6iGgePK14WGOdrE2cHLMpZ0JbS6qUvVoP-0mW55xh5haHg@mail.gmail.com>
Subject: Re: [Patch v15 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 3:04 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Thu, Aug 30, 2018 at 6:22 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > On Mon, Aug 27, 2018 at 4:27 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> > >
> > > From: Sricharan R <sricharan@codeaurora.org>
> > >
> > > The smmu device probe/remove and add/remove master device callbacks
> > > gets called when the smmu is not linked to its master, that is without
> > > the context of the master device. So calling runtime apis in those places
> > > separately.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > [vivek: Cleanup pm runtime calls]
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >
> > > Changes since v14:
> > >  - none.
> > >
> > >  drivers/iommu/arm-smmu.c | 101 +++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 93 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index a81224bc6637..23b4a60149b6 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> >
> > [snip]
> >
> > > @@ -2131,6 +2188,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> > >         if (err)
> > >                 return err;
> > >
> > > +       /*
> > > +        * We want to avoid touching dev->power.lock in fastpaths unless
> > > +        * it's really going to do something useful - pm_runtime_enabled()
> > > +        * can serve as an ideal proxy for that decision. So, conditionally
> > > +        * enable pm_runtime.
> > > +        */
> > > +       if (dev->pm_domain)
> > > +               pm_runtime_enable(dev);
> > > +
> > > +       err = arm_smmu_rpm_get(smmu);
> >
> > We shouldn't be doing a runtime_get() yet, as this eventually calls
> > arm_smmu_device_reset().
> > arm_smmu_device_reset() should be called only after arm_smmu_device_cfg_probe().
> > So, I plan to replace the pm_runtime_get/put() calls in probe() with
> > simple clk_bulk_enable()
> > to let the driver initialize smmu, and at the end of the probe we can
> > disable the clocks and
> > enable runtime pm over the device to let it take care of the device further-on.
> >
>
> We can avoid the explicit clock disable by just calling
> pm_runtime_set_active() before pm_runtime_enable(), assuming that what
> probe does is symmetrical with the suspend callback, which would be
> called after the latter.

Sure, that sounds reasonable. Will use pm_runtime_set_active() instead
of explicitly disabling the clocks.Thanks.

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
