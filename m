Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2CE2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xnk2GnVW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8GLxgxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2CE2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJBK4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:56:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeJBK4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:56:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 745BA60C1B; Tue,  2 Oct 2018 04:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538453708;
        bh=7y/x1RS4D0d0PWDLdliZbR09//VM70ZNHNOmcl13ARE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xnk2GnVWQ62pkU3p/Pbd4ljw3OVNYv5sElzxwg6ROh4N37BKbfpU9m0R8JdsXG+jn
         wKoIKt4nPXL3VJioJwChzDjKXRCejZ99UMV0QgdUvLpkJulTREWSUWyI6PYQSKTxhq
         4p8U2rxWKdbPc3GoDw/cRCxMHXja7aGB2COvDDNk=
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C3C760C1D;
        Tue,  2 Oct 2018 04:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538453707;
        bh=7y/x1RS4D0d0PWDLdliZbR09//VM70ZNHNOmcl13ARE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8GLxgxiLbI+VzPFZTbtolJz2PioW95U2MwVvKs4Ioq6plA8zaS1MvWdMvS/8K6VE
         nQtbxJpDNA5cLqxCH7k9rFQ2ZXdheyUNqcQBGCskcYBRmSdUum16E6pYWLJfkWHo63
         Oeb5xSD90nT08rVCtoaWAPWbg2KVs52656xaBNc0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C3C760C1D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f173.google.com with SMTP id q5-v6so351753qki.6;
        Mon, 01 Oct 2018 21:15:07 -0700 (PDT)
X-Gm-Message-State: ABuFfoj4sCkkIJhjCK42YCyD6JEuYIE6jScQ7Qd5xqayvKJL51J4huQV
        qlpSYUpVBzGKnc28sDQaHI2YoMvlyfvRMVK1iGI=
X-Google-Smtp-Source: ACcGV60Rrh1q8OV/iKGTFGbtE6SbVBZMr3JlPvxk2FyNZxIe1/Lli4afCiY60coMa0Bcz1zoqSjXlzeZwOkVneK8MOw=
X-Received: by 2002:a37:6388:: with SMTP id x130-v6mr10673451qkb.118.1538453706523;
 Mon, 01 Oct 2018 21:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org> <20181001125854.GB31488@arm.com>
In-Reply-To: <20181001125854.GB31488@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 2 Oct 2018 09:44:54 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw@mail.gmail.com>
Message-ID: <CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw@mail.gmail.com>
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

Hi Will,

On Mon, Oct 1, 2018 at 6:29 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Vivek,
>
> On Thu, Aug 30, 2018 at 08:15:38PM +0530, Vivek Gautam wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> >
> > The smmu device probe/remove and add/remove master device callbacks
> > gets called when the smmu is not linked to its master, that is without
> > the context of the master device. So calling runtime apis in those places
> > separately.
> > Global locks are also initialized before enabling runtime pm as the
> > runtime_resume() calls device_reset() which does tlb_sync_global()
> > that ultimately requires locks to be initialized.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > [vivek: Cleanup pm runtime calls]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 89 +++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 81 insertions(+), 8 deletions(-)
>
> This doesn't apply on my tree[1], possibly because I've got Robin's non-strict
> invalidation queued there. However, that got me thinking -- how does this
> work in conjunction with the timer-based TLB invalidation? Do we need to
> rpm_{get,put} around flush_iotlb_all()? If so, do we still need the calls
> in map/unmap when non-strict mode is in use?

I haven't tested things with flush queues, but from what it looks like
both .flush_iotlb_all, and .iotlb_sync callbacks need rpm_get/put().
I will respin the patches.

Thanks
Vivek
>
> Will
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
