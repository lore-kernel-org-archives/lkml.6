Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8E720867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8E720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeIYWsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:48:01 -0400
Received: from foss.arm.com ([217.140.101.70]:54268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbeIYWsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:48:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 761F77A9;
        Tue, 25 Sep 2018 09:39:42 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAAC53F5BD;
        Tue, 25 Sep 2018 09:39:38 -0700 (PDT)
Date:   Tue, 25 Sep 2018 17:39:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>, andy.gross@linaro.org,
        robin.murphy@arm.com, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, david.brown@linaro.org,
        tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
Message-ID: <20180925163928.GA1839@brain-police>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180925120933.54xd72sv65d63tkl@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925120933.54xd72sv65d63tkl@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:09:34PM +0200, Joerg Roedel wrote:
> On Mon, Sep 10, 2018 at 11:55:47AM +0530, Vivek Gautam wrote:
> > Vivek Gautam (4):
> >   firmware: qcom_scm-64: Add atomic version of qcom_scm_call
> >   firmware/qcom_scm: Add atomic version of io read/write APIs
> >   firmware/qcom_scm: Add scm call to handle smmu errata
> >   iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
> > 
> >  drivers/firmware/qcom_scm-32.c |  17 ++++
> >  drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
> >  drivers/firmware/qcom_scm.c    |  18 ++++
> >  drivers/firmware/qcom_scm.h    |   9 ++
> >  drivers/iommu/arm-smmu-regs.h  |   2 +
> >  drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
> >  include/linux/qcom_scm.h       |   6 ++
> >  7 files changed, 320 insertions(+), 46 deletions(-)
> 
> Should this go through the iommu-tree? In that case I need Acked-by's
> for the firmware code changes.

Yup, and I'd also like Robin's ack on the arm-smmu*.c changes (I see he has
some comments on the code as it stands).

Will
