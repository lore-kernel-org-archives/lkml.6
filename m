Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F988C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9382083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXZsG/im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9382083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeJBVmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbeJBVmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:42:12 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8896420666;
        Tue,  2 Oct 2018 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538492304;
        bh=eRcL97bhXOkWjQ6OyVA7gzgNan6huZP041wu6qH2sWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXZsG/im7ZwKhpPQdZJ5ytSthuGPFJiZvYU7QqGmiAdhhw5B5ujeXHWPp7E4xBpla
         PKUC6f4+FGRu68cNjaNdegOl0yjzLqJvyr5GIlw2iHNH+m9WOjb8khCD0ipWe5Ybjh
         sxg1/yX9GYOgxAXktM6Hqu8vLgfv+smwI3eD5hnQ=
Date:   Tue, 2 Oct 2018 20:28:20 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v5 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
Message-ID: <20181002145820.GH19792@vkoul-mobl>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-2-andrea.merello@gmail.com>
 <20180918162105.GC2613@vkoul-mobl>
 <CAN8YU5PWB0sRskcirCcYnY5vG5A_W6pcOMpgyOD3faWfMeu5Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5PWB0sRskcirCcYnY5vG5A_W6pcOMpgyOD3faWfMeu5Rg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-18, 09:11, Andrea Merello wrote:
> On Tue, Sep 18, 2018 at 6:21 PM Vinod <vkoul@kernel.org> wrote:

> > > @@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
> > >                        * Calculate the maximum number of bytes to transfer,
> > >                        * making sure it is less than the hw limit
> > >                        */
> > > -                     copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
> > > +                     copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
> >
> > why not keep chan in patch 1 and add only handling in patch 2, seems
> > less churn to me..
> 
> Indeed this was something I was unsure about.. I ended up in feeling
> better not to add introduce a function that takes an unused (yet)
> argument, but I can change this of course :)

IMO It is fine to add a user in subsequent patch in a series. Not fine to
add something and not use in "that" series :)

-- 
~Vinod
