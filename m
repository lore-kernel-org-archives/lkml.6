Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A69BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898E21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ECJWV4n2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gf7IuF8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898E21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJBMKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:10:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:10:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33D2D60C4E; Tue,  2 Oct 2018 05:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538458126;
        bh=u/bChvMKQYWeEDaSGIQoKrg1Cv4arnCrBf4Cfqx1eq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ECJWV4n2aGslCZv0iz34V6FF4QTCpnkA6V+3K1skM4kdtUkDi5FWyaI4ciHYd4CJw
         6K6p1ij24s8UJ0W017UdENmxhDLI+MjXi2kwaxr/CqDsEeqltt32JZvYObehoykn9/
         v1PDuOFdOCdzwmzL4jj3XHW+riDS+1f75wdl5tB8=
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D06460C5F;
        Tue,  2 Oct 2018 05:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538458124;
        bh=u/bChvMKQYWeEDaSGIQoKrg1Cv4arnCrBf4Cfqx1eq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gf7IuF8Uun/Yc4a/lH5KUkhDDOpAG0Wwo+sXs/0jeHMEmR9d3AofA/bpIQYS0q2DL
         Bo6Y4UJMgAinyqr83zehgjeW3uQMMPFdI0oACwreb1RISkELZJqPvOtwOC1ICyz3s2
         iAKIMXKtSfCGTUuXUk1p2uZEEukJPxx7wmg/Mmjo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D06460C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f170.google.com with SMTP id e9-v6so705141qtp.7;
        Mon, 01 Oct 2018 22:28:44 -0700 (PDT)
X-Gm-Message-State: ABuFfoj0C/TxjYsEKSMtq4Vjx49gjlbz3Ab/N0cm4pMQfyrAeuQmLmul
        jzKN1BBhehXDY6Qni7/k5BAoAv3daI1lFxDw91c=
X-Google-Smtp-Source: ACcGV63a1KqH1DVO6gYc2PyyOuJ1Spzywbm4k6IXJaH+oGncfqMP2Xv0iWF/MZiCwsifOOqiokKeqg7Eu26p5lIRtYc=
X-Received: by 2002:a0c:e803:: with SMTP id y3-v6mr5141524qvn.56.1538458123408;
 Mon, 01 Oct 2018 22:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org> <20181001125854.GB31488@arm.com>
 <CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw@mail.gmail.com>
In-Reply-To: <CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 2 Oct 2018 10:58:31 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFpm05Uu8HkYCC+O+gYwFwvxirc6=e6oOed+ZJk6QLDPw@mail.gmail.com>
Message-ID: <CAFp+6iFpm05Uu8HkYCC+O+gYwFwvxirc6=e6oOed+ZJk6QLDPw@mail.gmail.com>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To:     Will Deacon <will.deacon@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 9:44 AM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi Will,
>
> On Mon, Oct 1, 2018 at 6:29 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Vivek,
> >
> > On Thu, Aug 30, 2018 at 08:15:38PM +0530, Vivek Gautam wrote:
> > > From: Sricharan R <sricharan@codeaurora.org>
> > >
> > > The smmu device probe/remove and add/remove master device callbacks
> > > gets called when the smmu is not linked to its master, that is without
> > > the context of the master device. So calling runtime apis in those places
> > > separately.
> > > Global locks are also initialized before enabling runtime pm as the
> > > runtime_resume() calls device_reset() which does tlb_sync_global()
> > > that ultimately requires locks to be initialized.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > [vivek: Cleanup pm runtime calls]
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >  drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 81 insertions(+), 8 deletions(-)
> >
> > This doesn't apply on my tree[1], possibly because I've got Robin's non-strict
> > invalidation queued there. However, that got me thinking -- how does this
> > work in conjunction with the timer-based TLB invalidation? Do we need to
> > rpm_{get,put} around flush_iotlb_all()? If so, do we still need the calls
> > in map/unmap when non-strict mode is in use?

For map/unmap(), i think there would be no harm in having additional
power.usage_count even for the non-strict mode.
So, I will just add rpm{get,put} in arm_smmu_flush_iotlb_all(), and
arm_smmu_iotlb_sync().

Regards
Vivek

>
> I haven't tested things with flush queues, but from what it looks like
> both .flush_iotlb_all, and .iotlb_sync callbacks need rpm_get/put().
> I will respin the patches.
>
> Thanks
> Vivek
> >
> > Will
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
>
>
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
