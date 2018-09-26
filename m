Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C220C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E7C2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZNIGG9gZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZNIGG9gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E7C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeIZMfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:35:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:35:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C07E260B19; Wed, 26 Sep 2018 06:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537943042;
        bh=cGizbNDmSpPBFo/90//dFYdJjrvucWkuEIzkrEEdLl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZNIGG9gZA+3aKe/8kxpuTO5KeH5nt+UPn6m2c1OLjXktv6cv5c/23+26Mm1EB+sld
         iwJJE9ou2m2+GqnkY1Izb5UYnwYumNlOLJcMFzj+EPw3+5HZ+pEwL6wkbbpXoQBZJ6
         gfvYKwvGFK6a0Rfxoe+xq9r5ZurXMCdAHXsD6QN4=
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01214609A5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537943042;
        bh=cGizbNDmSpPBFo/90//dFYdJjrvucWkuEIzkrEEdLl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZNIGG9gZA+3aKe/8kxpuTO5KeH5nt+UPn6m2c1OLjXktv6cv5c/23+26Mm1EB+sld
         iwJJE9ou2m2+GqnkY1Izb5UYnwYumNlOLJcMFzj+EPw3+5HZ+pEwL6wkbbpXoQBZJ6
         gfvYKwvGFK6a0Rfxoe+xq9r5ZurXMCdAHXsD6QN4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01214609A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f180.google.com with SMTP id w73-v6so9246879qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:24:01 -0700 (PDT)
X-Gm-Message-State: ABuFfogm8JbsGlUic3HWrRXRA7iBZxlmNJneacpAyMZLUoo21C1CtD+l
        0CaflklDJcSOhb/nLv8uWfXty23e7yWYlKxfJig=
X-Google-Smtp-Source: ACcGV63JMI3rIZn1RstxA8re46q37a/LsA2Vc//CiaMTfMf8JfV+7GnhHQPIAWjqazN4S9WP7bydv2ETVAL2LNANdUo=
X-Received: by 2002:a37:c44c:: with SMTP id h12-v6mr3217245qkm.279.1537943041266;
 Tue, 25 Sep 2018 23:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180925120933.54xd72sv65d63tkl@8bytes.org> <20180925163928.GA1839@brain-police>
In-Reply-To: <20180925163928.GA1839@brain-police>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 26 Sep 2018 11:53:49 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEdyBKcQ=ikOaqJGHcmsjWJdDMWGgzFdW54aSqpQ-EE3Q@mail.gmail.com>
Message-ID: <CAFp+6iEdyBKcQ=ikOaqJGHcmsjWJdDMWGgzFdW54aSqpQ-EE3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
To:     Will Deacon <will.deacon@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, swboyd@chromium.org,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:09 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Sep 25, 2018 at 02:09:34PM +0200, Joerg Roedel wrote:
> > On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> > > Vivek Gautam (4):
> > >   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
> > >   firmware/qcom_scm: Add atomic version of io read/write APIs
> > >   firmware/qcom_scm: Add scm call to handle smmu errata
> > >   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> > >
> > >  drivers/firmware/qcom_scm-32.c |  17 ++++
> > >  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
> > >  drivers/firmware/qcom_scm.c    |  18 ++++
> > >  drivers/firmware/qcom_scm.h    |   9 ++
> > >  drivers/iommu/arm-smmu-regs.h  |   2 +
> > >  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
> > >  include/linux/qcom_scm.h       |   6 ++
> > >  7 files changed, 320 insertions(+), 46 deletions(-)
> >
> > Should this go through the iommu-tree? In that case I need Acked-by's
> > for the firmware code changes.
>
> Yup, and I'd also like Robin's ack on the arm-smmu*.c changes (I see he has
> some comments on the code as it stands).

Thanks Joerg, and Will for taking a look at it. I will answer and
address Robin's comments
for smmu part.

Best regards
Vivek

>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
