Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7078DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2D92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2D92133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeLLOKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:10:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLLOKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:10:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D74080D;
        Wed, 12 Dec 2018 06:10:39 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C87F3F614;
        Wed, 12 Dec 2018 06:10:39 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 873571AE0A0D; Wed, 12 Dec 2018 14:11:02 +0000 (GMT)
Date:   Wed, 12 Dec 2018 14:11:02 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        robh+dt <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom
 smmu-500
Message-ID: <20181212141101.GD23641@edgewater-inn.cambridge.arm.com>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-2-vivek.gautam@codeaurora.org>
 <20181011221630.GA5841@bogus>
 <9ca4bb4f-3e6e-21cc-819e-80b979b934d0@codeaurora.org>
 <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iF80P-o=Z-aNOMQwWMTcO4jcgSR0wOzd4GvmB3zTvWZLw@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 03:18:06PM +0530, Vivek Gautam wrote:
> On Fri, Oct 12, 2018 at 11:37 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> > On 10/12/2018 3:46 AM, Rob Herring wrote:
> > > On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
> > >> Qcom's implementation of arm,mmu-500 works well with current
> > >> arm-smmu driver implementation. Adding a soc specific compatible
> > >> along with arm,mmu-500 makes the bindings future safe.
> > >>
> > >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > >> ---
> > >>
> > >> Changes since v3:
> > >>   - Refined language more to state things directly for the bindings
> > >>     description.
> > >>
> > >>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
> > >>   1 file changed, 4 insertions(+)
> > >>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Thank you Rob.
> >
> 
> Can you please pick this one as well to your tree? This goes on top of the
> bindings patch for "qcom,smmu-v2". So, it can't go through Andy's tree.
> Will ask Andy to pick the second patch of the series, that adds the dt node.
> 
> I guess as I sent this one along with the dt patch, I would have
> mistakenly added
> you to 'cc' list rather than 'to' list.
> Let me know if you would like me to resend it.

I've already sent my stuff to Joerg, so it's too late for 4.21.
Perhaps resend this patch standalone to Joerg with me on CC so that I can
ack it.

Will
