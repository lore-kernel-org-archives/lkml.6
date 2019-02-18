Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B068C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762D82175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfBRKbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:31:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39338 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:31:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so18571442qtk.6;
        Mon, 18 Feb 2019 02:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeAiCwTdj8ylL6sF0x2uByC9gBRqCOAVMEnpZGUkBbU=;
        b=s6cNxLf6t5MiOYZH8QTTV8YarjrGMITf3kmgv+CxoWEjDoi7arZYB0JWu2+wTh4vJT
         MTJr9cArlGuoG7FJ/Wb/3DUQTWp0LWm5yt65cWI47eag/DI+YTuE2WOl+2MaoMEr6NmO
         m7urO9/N9yEld+4NieQtVi/iZctE4hXqqWqMP++lwLf+1rp0NEzEm/3WI3JCto0HqJBq
         rtQqrEryDryTczbru0rXvn0yjf4D21s33Fn7wG3LkCqtWpKt4WGKNiO0tOmgF4+bB64K
         02CYKX8HzJqiocvwfGpW/oi8xnn4QfMk4Hc2DDST+cS0HLAXr1a+6701g2Kx8skPvkdJ
         ggvg==
X-Gm-Message-State: AHQUAuarQ+pPZUP4jeIyGsmSnVr2ytfpFFoQuEvKDPA82XWTSL6/hKx+
        w+nHm305nwlmw/IdUj5YFX64PBHYCYdCHAtygEE=
X-Google-Smtp-Source: AHgI3IZjx670/rKQSNrH8eBwkan7S+nY3zbrV1tknWzuZbWoqV5NUEmuqmCi/hYmoX8yMTiCvNurMGPgE2hy0HBWVrw=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16997325qtm.96.1550485909026;
 Mon, 18 Feb 2019 02:31:49 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com> <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
In-Reply-To: <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 11:31:32 +0100
Message-ID: <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >
> > > >  Client:
> > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > -The two cells in order are:
> > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > +The three cells in order are:
> > > >  1. A phandle pointing to the DMA controller.
> > > >  2. The channel id.
> > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > +automatically.
> > >
> > > I notice that this is an incompatible binding change. Is that necessary?
> > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > and <3>, and then implementing both in the driver.
> >
> > Yes, this is necessary.
> >
> > Yes, current code can work, but the problem is that the DMA clients
> > must add one property (something like "sprd,slave-id") to specify the
> > slave id. So considering this, we want to change the dma-cells to 2,
> > including dma channel and dma slave id, which can avoid introducing
> > some similar properties for DMA clients.
> >
> > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > we want to upstream our first DMA clients: SPI controller. So no other
> > drivers need to change when we changing dma cells. Thanks.
>
> Do you have any other concerns about this patch set? If not, I think
> Vinod can apply this patch set. Thanks.

Sorry for the late reply. Yes, this makes sense since there are no
existing users then. For the DT changes going through the dmaengine
tree

Acked-by: Arnd Bergmann <arnd@arndb.de>

One more question, to make sure we don't need to edit it again:
Why do you need both a 'channel id' and a 'slave id' here? Is this
a strict hardware requirement for your DMA engine? In many
other designs, only a DMA request line number needs to
be described, and I think this would correspond to what you
call the 'hardware slave id' in your documentation.

Does each request line here correspond to a fixed channel
id as well, or can a channel be shared between multiple
slave devices?

      Arnd
