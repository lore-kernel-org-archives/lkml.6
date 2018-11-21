Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E38C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB192145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB192145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbeKVC1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:27:33 -0500
Received: from foss.arm.com ([217.140.101.70]:53398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731291AbeKVC1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:27:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6487B331A;
        Wed, 21 Nov 2018 07:52:34 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33CD63F5CF;
        Wed, 21 Nov 2018 07:52:34 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id E5E0B1AE100A; Wed, 21 Nov 2018 15:52:49 +0000 (GMT)
Date:   Wed, 21 Nov 2018 15:52:49 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, dianders@chromium.org
Subject: Re: [PATCH v4 0/2] Enable smmu support on sdm845
Message-ID: <20181121155249.GA24883@arm.com>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On Thu, Oct 11, 2018 at 03:19:28PM +0530, Vivek Gautam wrote:
> This series enables apps-smmu, the "arm,mmu-500" instance
> on sdm845.
> Series tested on SDM845 MTP device with related smmu patch series [1],
> and necessary config change, besides one hack to keep LDO14 in LPM mode
> to boot things up (see the commit in the test branch).
> The tested branch is available at [2].

[...]

>  .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)

Given that this doesn't touch any of the driver code, please take this via
the Andy and arm-soc.

Will
