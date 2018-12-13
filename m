Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B12C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A7D20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A7D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeLMKpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:45:01 -0500
Received: from foss.arm.com ([217.140.101.70]:58848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeLMKpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:45:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB2FA78;
        Thu, 13 Dec 2018 02:45:01 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C6203F6A8;
        Thu, 13 Dec 2018 02:45:01 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DBA681AE0D04; Thu, 13 Dec 2018 10:45:24 +0000 (GMT)
Date:   Thu, 13 Dec 2018 10:45:24 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/1] dt-bindings: arm-smmu: Add binding doc for
 Qcom smmu-500
Message-ID: <20181213104524.GA31177@edgewater-inn.cambridge.arm.com>
References: <20181213090507.6269-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213090507.6269-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:35:07PM +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 works well with current
> arm-smmu driver implementation. Adding a soc specific compatible
> along with arm,mmu-500 makes the bindings future safe.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> 
> Hi Joerg,
> I am picking this out separately from the sdm845 smmu support
> series [1], so that this can go through iommu tree.
> The dt patch from the series [1] can be taken through arm-soc tree.
> 
> Hi Will,
> As asked [2], here's the resend version of dt binding patch for sdm845.
> Kindly ack this so that Joerg can pull this in.

Acked-by: Will Deacon <will.deacon@arm.com>

Joerg -- please can you take this on top of the pull request I sent already?
Vivek included it as part of a separate series which I thought was going
via arm-soc, but actually it needs to go with the other arm-smmu patches
in order to avoid conflicts.

Cheers,

Will

>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index a6504b37cc21..3133f3ba7567 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -27,6 +27,10 @@ conditions.
>                    "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
>                    "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
>  
> +                  Qcom SoCs implementing "arm,mmu-500" must also include,
> +                  as below, SoC-specific compatibles:
> +                  "qcom,sdm845-smmu-500", "arm,mmu-500"
> +
>  - reg           : Base address and size of the SMMU.
>  
>  - #global-interrupts : The number of global interrupts exposed by the
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
