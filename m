Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD56C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFEE21741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFEE21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbeHNO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:26:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbeHNO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:26:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B56ED7A9;
        Tue, 14 Aug 2018 04:40:03 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85D413F73C;
        Tue, 14 Aug 2018 04:40:03 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 232EE1AE015E; Tue, 14 Aug 2018 12:40:09 +0100 (BST)
Date:   Tue, 14 Aug 2018 12:40:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, andy.gross@linaro.org, robin.murphy@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
        mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
Message-ID: <20180814114009.GF28664@arm.com>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
> errata [1] because of which the TCU cache look ups are stalled during
> invalidation cycle. This is mitigated by serializing all the invalidation
> requests coming to the smmu.

How does this implementation differ from the one supported by qcom_iommu.c?
I notice you're adding firmware hooks here, which we avoided by having the
extra driver. Please help me understand which devices exist, how they
differ, and which drivers are intended to support them!

Also -- you didn't CC all the maintainers for the firmware bits, so adding
Andy here for that, and Rob for the previous question.

Thanks,

Will
