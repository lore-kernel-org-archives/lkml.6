Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FAC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF132087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547982498;
	bh=6JOgy4qD6CGxl1OspXO/aQD9Cs9w19R36CZSfUz0tXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=04ja4BEa66UyMR1IHDArBzf4f+L73TBIzn+8Hd1HfxZEl2OWO8v4y5rw6m5/SBcly
	 KoUePH50zOnMwrTeQkrps6BXYjzWEdz/ewsCVDEecoOL1vRJV5G6vfOy36FjF9nH1n
	 czE9jz8Mc1fhIzLtkqlc9u3Q0RCEblJHpqjqHaqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfATLIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 06:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbfATLIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 06:08:16 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52142084F;
        Sun, 20 Jan 2019 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547982495;
        bh=6JOgy4qD6CGxl1OspXO/aQD9Cs9w19R36CZSfUz0tXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lq8do58y2AIluPJnZqsjM+Byrz0YTx2J+KW/bu1y0UR1hRFl02RUCKOtKcYQQi5NV
         E/GaEaSLuGk48qNxMcfpB9SLKAekA0PrsX/Zn43xR3Oj1w6HOfECHOwtZTWAu2golS
         5ePGcvSgexWDEbxAGDFvLsFZlttU/UXq9+5GsWpc=
Date:   Sun, 20 Jan 2019 16:36:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/8 v4] Documentation: bindings: dma: Add binding for
 dma-channel-mask
Message-ID: <20190120110642.GT4635@vkoul-mobl>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
 <1547658629-25378-3-git-send-email-john.stultz@linaro.org>
 <20190117170829.GJ5283@Mani-XPS-13-9360>
 <CALAqxLXc4dE=65MYR5M_jA-uKeGjsN0CL+JjDYbZUTyi+mKUTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXc4dE=65MYR5M_jA-uKeGjsN0CL+JjDYbZUTyi+mKUTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 09:43, John Stultz wrote:
> On Thu, Jan 17, 2019 at 9:08 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Wed, Jan 16, 2019 at 09:10:23AM -0800, John Stultz wrote:
> > > Some dma channels can be reserved for secure mode or other
> > > hardware on the SoC, so provide a binding for a bitmask
> > > listing the available channels for the kernel to use.
> > >
> > > This follows the pre-existing bcm,dma-channel-mask binding.
> > >
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > Cc: Ryan Grachek <ryan@edited.us>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: dmaengine@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > > v3: Renamed to hisi-dma-avail-chan
> > > v4: Reworked to generic dma-channel-mask
> > > ---
> > >  Documentation/devicetree/bindings/dma/dma.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> > > index 6312fb0..eeb4e4d 100644
> > > --- a/Documentation/devicetree/bindings/dma/dma.txt
> > > +++ b/Documentation/devicetree/bindings/dma/dma.txt
> > > @@ -16,6 +16,9 @@ Optional properties:
> > >  - dma-channels:      Number of DMA channels supported by the controller.
> > >  - dma-requests:      Number of DMA request signals supported by the
> > >                       controller.
> > > +- dma-channel-mask:  Bitmask of available DMA channels in ascending order
> > > +                     that are not reserved by firmware and are available to
> > > +                     the kernel. i.e. first channel corresponds to LSB.
> >
> > A general assumption is, "dma-channel-mask" refers to the bit fields of
> > the channels which needs to be masked. But here, it refers to the channels
> > which are available. Doesn't it contradict?
> 
> Hrm. So while I can sort of understand the common usage of "mask" as
> to "hide", thus the desire to have a bitfield mean "the channels we
> hide" or "don't use", but in my experience bitmasking is more commonly
> used to keep only a portion of the the bits, so from that perspective
> its more intuitive that a mask be the channels we keep to use. So I'm
> not sure if your suggestion makes it more clear.
> 
> But I'm not very particular here, so I'll defer to others on this.

Given the context and documentation which explicitly says it is bitmask
of available channels, i think we are fine :)

-- 
~Vinod
