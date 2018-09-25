Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841E420842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IQy+EWml";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JA9P4Idc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841E420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIYMEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:04:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeIYMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:04:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A44D6021C; Tue, 25 Sep 2018 05:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537855099;
        bh=Bd7kDmEIoX5kBBeeOUg3y/HusxiNSyq9USq10RJaOgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IQy+EWmlbRt5hDEPSxlrodwoGxBBl8sk4GzQR6ztibn1NCAqD/t5EHS0s0yY4bmwh
         PBSBkXKy6kU+2oo0eozTO0jTb6mYQNv/I9mFupG6pWa4vdYCv/cRwBBRvn+old2HZx
         +noJWOiCbMOsItuU8KynD+SXcnxAwNe2Z6vHpTYY=
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57E1C607DD;
        Tue, 25 Sep 2018 05:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537855098;
        bh=Bd7kDmEIoX5kBBeeOUg3y/HusxiNSyq9USq10RJaOgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JA9P4Idckg6XuPZ5g3LcSmR8bQa1PIpG3Qh9pxsYO7ihvTMyBLGzE3NRbEy9GLpVm
         Yh3JNsx0dvnpqIV3+FP3DinVdpdq7tcbxzAsCL0m4PJg+zYmBNIeqDpIpSY2UJY52m
         llSgo2Vc+36uUP5tZtW+wV5UG3kbELMtHd4QRTpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57E1C607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f170.google.com with SMTP id e9-v6so11747298qtp.7;
        Mon, 24 Sep 2018 22:58:18 -0700 (PDT)
X-Gm-Message-State: ABuFfogzKNikv4Glxbw2aCEhurTskNJDPZY2wKxb77ojGzmrdLzknTTM
        ESPXcnIOWKqJAxNdKooBvh85oE35Bp3KbHvgjjk=
X-Google-Smtp-Source: ACcGV60WLBMY7GnaCNvtJTiMde7wD0U9Ik0Lx3GoQsSQ6NNuE1ftX0dWxJY0hTc412Bm+aKY7oVd01dg0Z90WW//lOo=
X-Received: by 2002:a0c:d0cc:: with SMTP id b12-v6mr1620141qvh.107.1537855097569;
 Mon, 24 Sep 2018 22:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org> <4f6e48c4-6fec-b764-6083-fea4133e1fa8@codeaurora.org>
In-Reply-To: <4f6e48c4-6fec-b764-6083-fea4133e1fa8@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 25 Sep 2018 11:28:05 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGgUBPHZZ-nYv3cZ=TPP9oX9Ux6K2RmKv828AXo+HkLxQ@mail.gmail.com>
Message-ID: <CAFp+6iGgUBPHZZ-nYv3cZ=TPP9oX9Ux6K2RmKv828AXo+HkLxQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
To:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Andy Gross <andy.gross@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, swboyd@chromium.org,
        David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,


On Mon, Sep 10, 2018 at 4:08 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> +linux-arm-msm
>
>
> On 09/10/2018 11:55 AM, Vivek Gautam wrote:
> > Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
> > errata [1] because of which the TCU cache look ups are stalled during
> > invalidation cycle. This is mitigated by serializing all the invalidation
> > requests coming to the smmu.
> >
> > This patch series addresses this errata by adding new tlb_ops for
> > qcom,sdm845-smmu-500 [2]. These ops take context bank locks for all the
> > tlb_ops that queue and sync the TLB invalidation requests.
> >
> > Besides adding locks, there's a way to expadite these TLB invalidations
> > for display and camera devices by turning off the 'wait-for-safe' logic
> > in hardware that holds the tlb invalidations until a safe level.
> > This 'wait-for-safe' logic is controlled by toggling a chicken bit
> > through a secure register. This secure register is accessed by making an
> > explicit SCM call into the EL3 firmware.
> > There are two ways of handling this logic -
> >   * Firmware, such as tz present on sdm845-mtp devices has a handler to do
> >     all the register access and bit set/clear. So is the handling in
> >     downstream arm-smmu driver [3].
> >   * Other firmwares can have handlers to just read/write this secure
> >     register. In such cases the kernel make io_read/writel scm calls to
> >     modify the register.
> > This patch series adds APIs in qcom-scm driver to handle both of these
> > cases.
> >
> > Lastly, since these TLB invalidations can happen in atomic contexts
> > there's a need to add atomic versions of qcom_scm_io_readl/writel() and
> > qcom_scm_call() APIs. The traditional scm calls take mutex and we therefore
> > can't use these calls in atomic contexts.
> >
> > This patch series is adapted version of how the errata is handled in
> > downstream [1].

Gentle ping. Please let me know if you have comments on the SCM pieces
in this series.

Thanks & Regards
Vivek

> >
> > Changes since v1:
> >   * Addressed Will and Robin's comments:
> >      - Dropped the patch[4] that forked out __arm_smmu_tlb_inv_range_nosync(),
> >        and __arm_smmu_tlb_sync().
> >      - Cleaned up the errata patch further to use downstream polling mechanism
> >        for tlb sync.
> >   * No change in SCM call patches - patches 1 to 3.
> >
> > [1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842
> > [2] https://lore.kernel.org/patchwork/patch/974114/
> > [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4864
> > [4] https://patchwork.kernel.org/patch/10565349/
> >
> > Vivek Gautam (4):
> >    firmware: qcom_scm-64: Add atomic version of qcom_scm_call
> >    firmware/qcom_scm: Add atomic version of io read/write APIs
> >    firmware/qcom_scm: Add scm call to handle smmu errata
> >    iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> >
> >   drivers/firmware/qcom_scm-32.c |  17 ++++
> >   drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
> >   drivers/firmware/qcom_scm.c    |  18 ++++
> >   drivers/firmware/qcom_scm.h    |   9 ++
> >   drivers/iommu/arm-smmu-regs.h  |   2 +
> >   drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
> >   include/linux/qcom_scm.h       |   6 ++
> >   7 files changed, 320 insertions(+), 46 deletions(-)
> >
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
