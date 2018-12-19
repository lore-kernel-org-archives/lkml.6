Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BA8217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VpLOK74s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X9B92esc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeLSSto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:49:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeLSSto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:49:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2B5161B52; Wed, 19 Dec 2018 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545245383;
        bh=dNp2eZV4j9GiMr4qaE11NrLvy7q85BsWWNJ9YdmSx0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpLOK74sfBrRrS11ylgyt3d5xL+//QN0BPXi6v/7jZHZfw5NmXLfkEtDRzomkWwRa
         5hpRxeRat44i0q7EjWlODC98KS3rkjnKa/1Y4ol12qwWWfQXaItdZdxeiHMjjg8fJM
         npHzCGsQ8RsJVfLWrHKB0XZ9UJprBsykPocnShy8=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EAB2661188;
        Wed, 19 Dec 2018 18:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545245380;
        bh=dNp2eZV4j9GiMr4qaE11NrLvy7q85BsWWNJ9YdmSx0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9B92esc/9ky8sHkj6+aEgsORwI5b8Dc9/O1tTuSllqyprFWBkVV5NnxirZShwzjq
         1w+GsjKdhrBI+OqlKRdI1AxPJrQdfha6H13xjY0Y4TTsuzNACsfJHlnb3a3JEvcSNE
         2PC5ObGJa/ZZOp0m9P0zkuByMon1zlPekkXrElH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAB2661188
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 19 Dec 2018 10:49:38 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181219184938.GC1997@jackp-linux.qualcomm.com>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com>
 <20181204060104.GA11391@dragon>
 <20181217003434.GA7208@dragon>
 <c5ccf173-d0f3-70f4-f8e3-777fd3339b68@ti.com>
 <20181219010733.GA13489@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219010733.GA13489@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn, Kishon,

On Wed, Dec 19, 2018 at 09:07:36AM +0800, Shawn Guo wrote:
> On Tue, Dec 18, 2018 at 07:46:13PM +0530, Kishon Vijay Abraham I wrote:
> > 
> > 
> > On 17/12/18 6:04 AM, Shawn Guo wrote:
> > > On Tue, Dec 04, 2018 at 02:01:07PM +0800, Shawn Guo wrote:
> > >> Hi Kishon,
> > >>
> > >> On Tue, Dec 04, 2018 at 10:38:19AM +0530, Kishon Vijay Abraham I wrote:
> > >>> Hi,
> > >>>
> > >>> On 27/11/18 3:37 PM, Shawn Guo wrote:
> > >>>> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> > >>>> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> > >>>
> > >>> Is this Synopsys PHY specific to Qualcomm or could it be used by other vendors
> > >>> (with just changing tuning parameters)? If it could be used by other vendors
> > >>> then it would make sense to add this PHY driver in synopsys directory.
> > >>
> > >> My knowledge is that this Synopsys PHY is specific to Qualcomm SoCs.
> > >> @Sriharsha, correct me if I'm wrong.
> > > 
> > > Kishon,
> > > 
> > > Do you have any further comments on the patches?  We are close the 4.21
> > > merge window, and I really hope they can hit mainline with 4.21 release.
> > > Thanks.
> > 
> > Aren't we waiting for feedback from Sriharsha?
> 
> I think no correction means that I'm right :)

I'm sorry Sriharsha has not yet responded but I can confirm that this
PHY driver would only be specific to Qualcomm SoCs simply because of our
custom register mapping used to control and initialize it. These are
only defined as as HW signals by the Synopsys IP, which have been
synthesized to map to our own IO register space. So really it can be
treated as just a "Qualcomm USB PHY" with acknowledgement that the core
design is licensed from SNPS.

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
