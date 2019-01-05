Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D9EC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816A21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlfTdupx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfAEE6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:58:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39683 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAEE6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:58:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so38263693wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfjuXuv9vLvmQ5OLb5z5uhCsBHOO8XsPxoJxiadsbiw=;
        b=PlfTdupxNJkgOt1wcVBYTsEhpElJJcrc/iAeTNWsYXJz58GYipwzdGX3+zvG0Gkhh+
         NAWYCK3LijAnmvKwx916LOmVqrJlD/TBCWWMQb0yc12cYF4RokOJqA7h3BBiVDBb8WA7
         wpI0H2lYKPw9wYgIoXww3AzkrmOmgbVmbb310=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfjuXuv9vLvmQ5OLb5z5uhCsBHOO8XsPxoJxiadsbiw=;
        b=WVzjaGkwOpgSKwsLVwsx+8EZem3mKmKGN22IRnY+/a79jgFbUTLrAoDDY7qHdLiVxf
         vtY+TBfKNiGw4pIgmoTxfDgGLR6cNR9u/m/V0eXaAJfwd2qb7Qsyr+BQbJ48lSnzDUpH
         BBkN8lwD44/xiYPx/CNbZ1ojj91iSAVQnp7eU9ZIIAZe/kIQgpQJqvWoiz8IEctgXIrT
         FUw1rugr05/KkH0lhnNnvnshs63AxQtArsRxeWgCYeTeluJYhAy2WYq7fIquRpb23H54
         GABQ/eT5u49ZCbiwNhslZ3psJsH3iXg36mSx+1HlZdoDvHa6QkWCrUSjU0z8CtiJ+8U8
         i9jg==
X-Gm-Message-State: AJcUukd0+/1K0W1T/gNUaOtb/b/h4/QCpVFn840lWeL4I5/XHemIpyq+
        8EjCOUZ9WPNc58THlbMjtFn8apjnTRL0/8caQuCZQw==
X-Google-Smtp-Source: ALg8bN7TcyXRscXvBgUaigszjj9H8gwqrZYW1NJrHMrfCrIvyUWgF4UCAygoAyVZ3xo3B9dmlu6FbJ3pQzD8huBPHr0=
X-Received: by 2002:adf:9521:: with SMTP id 30mr43316660wrs.192.1546664296502;
 Fri, 04 Jan 2019 20:58:16 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-3-git-send-email-john.stultz@linaro.org>
 <20190105040030.GF2477@Mani-XPS-13-9360> <CALAqxLUZ=6_tELtZPEjYwV+BNNBcZj4Z=dq9UyrRXuPhs_uGUw@mail.gmail.com>
 <20190105045320.GA3761@Mani-XPS-13-9360>
In-Reply-To: <20190105045320.GA3761@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 20:58:03 -0800
Message-ID: <CALAqxLVEJvkJVEK82SzhZtvYwhvj99UWU_KB9jeXBXd0Bc=Z5Q@mail.gmail.com>
Subject: Re: [PATCH 2/8 v2] Documentation: bindings: k3dma: Add binding for dma-avail-chan
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 8:53 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Jan 04, 2019 at 08:39:34PM -0800, John Stultz wrote:
> > On Fri, Jan 4, 2019 at 8:00 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Hi John,
> > >
> > > On Fri, Jan 04, 2019 at 12:56:22PM -0800, John Stultz wrote:
> > > > Some dma channels can be reserved for secure mode or other
> > > > hardware on the SoC, so provide a binding for a bitmask
> > > > listing the available channels for the kernel to use.
> > > >
> > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > > Cc: Ryan Grachek <ryan@edited.us>
> > > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Cc: dmaengine@vger.kernel.org
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > > index 10a2f15..1c466c1 100644
> > > > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > > > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > > > @@ -14,6 +14,9 @@ Required properties:
> > > >               have specific request line
> > > >  - clocks: clock required
> > > >
> > > > +Optional properties:
> > > > +- dma-avail-chan: Bitmask of available physical channels
> > > > +
> > >
> > > This property looks too generic. Since this is specific to HiSi SoCs,
> > > this could be "hisi-dma-avail-chan"?
> >
> > I'm fine to change it, but I'm not sure I fully understand the
> > rational. Can you help me understand?
> > Are device node-binding names supposed to have global scope? I assumed
> > the node property names are basically scoped to the entry?
>
> IIUC properties documented in subsystem binding (dma.txt in this case)
> will have global scope. Those which are not documented in this binding
> are specific to vendor IPs and should be prefixed with the vendor
> prefix (hisi in this case).

Thanks I appreciate the explanation here. I hadn't really understood
this point, and really haven't developed much "taste" in what makes a
good or bad binding.

> > Further, having some dma channels be reserved doesn't seem to be too
> > unique a concept, so I'm not sure what we gain long term by prefixing
> > it?
> >
>
> Right, but this brings up the point of having this functionality in
> generic DMA engine so that the DMA controller drivers need not handle.
> So either we should move this available channel check to DMA Engine
> and document the property in dma.txt so that other IPs can also use it
> or keep the functionality in K3 driver and use HiSi prefix for the
> property.
>
> But I'd like to hear Vinod/Rob's opinion on this!

Sure. Though for now I'll prefix it as the logic is handled at the
driver level.

thanks
-john
