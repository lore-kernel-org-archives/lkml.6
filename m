Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E623C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A5C21902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550578840;
	bh=36FC+JnFT1126d6LGkSQevFrJ78somWW99q4F4lSsCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OhhiCrMDeG77XHZaSvopD1jGMpo2PHDcHxtUWP9ponzuc6wXkm4hn9XkcdF0vfq2Y
	 ULtMLXJgnzG0X4/0mesqOgr0AnRQZvZTpfKsn2XbSFgI3zu3oVBJ/SAeNo0ZU/qnAf
	 A4iXkCQSD7Pg3MTquN7cP8+jmcNAlx52aUAzsj0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfBSMUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSMUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:20:38 -0500
Received: from localhost (unknown [106.200.226.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D238217D7;
        Tue, 19 Feb 2019 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550578837;
        bh=36FC+JnFT1126d6LGkSQevFrJ78somWW99q4F4lSsCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bmnf+N+CPPdO9GKQApbN/GKlEq7bjDQ9bSOSPyVwZpzULrQPFanI94SRqDiyq0Tdn
         JcPOLLauzJn/nmQ6b1D2aUlonZJbHqaQ51JQzDNjFc1GEe9fXjrNTiNgZwRpEBWcN5
         dxQ8XMYhGQQalBIu9iznA9ZeuWyvLIVPJ3R4bdPQ=
Date:   Tue, 19 Feb 2019 17:50:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
Message-ID: <20190219122027.GA21884@vkoul-mobl>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
 <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
 <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
 <CAMuHMdWPZGYpvANL_V=YszPWjtTA+ZnU6GVDmn188LC=eC005Q@mail.gmail.com>
 <CAMz4ku+yzwaww5o06tz9-8n99UfiVh6d5UB2L12RYMpTow6K3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4ku+yzwaww5o06tz9-8n99UfiVh6d5UB2L12RYMpTow6K3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-19, 17:49, Baolin Wang wrote:
> Hi Geert,
> 
> On Tue, 19 Feb 2019 at 17:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Baolin,
> >
> > On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > >
> > > > > > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > >  Client:
> > > > > > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > > > > > -The two cells in order are:
> > > > > > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > > > > > +The three cells in order are:
> > > > > > > > > >  1. A phandle pointing to the DMA controller.
> > > > > > > > > >  2. The channel id.
> > > > > > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > > > > > +automatically.
> > > > > > > > >
> > > > > > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > > > > > and <3>, and then implementing both in the driver.
> > > > > > > >
> > > > > > > > Yes, this is necessary.
> > > > > > > >
> > > > > > > > Yes, current code can work, but the problem is that the DMA clients
> > > > > > > > must add one property (something like "sprd,slave-id") to specify the
> > > > > > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > > > > > including dma channel and dma slave id, which can avoid introducing
> > > > > > > > some similar properties for DMA clients.
> > > > > > > >
> > > > > > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > > > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > > > > > drivers need to change when we changing dma cells. Thanks.
> > > > > > >
> > > > > > > Do you have any other concerns about this patch set? If not, I think
> > > > > > > Vinod can apply this patch set. Thanks.
> > > > > >
> > > > > > Sorry for the late reply. Yes, this makes sense since there are no
> > > > > > existing users then. For the DT changes going through the dmaengine
> > > > > > tree
> > > > > >
> > > > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > Thanks for your reviewing.
> > > > >
> > > > > >
> > > > > > One more question, to make sure we don't need to edit it again:
> > > > > > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > > > > > a strict hardware requirement for your DMA engine? In many
> > > > > > other designs, only a DMA request line number needs to
> > > > > > be described, and I think this would correspond to what you
> > > > > > call the 'hardware slave id' in your documentation.
> > > > >
> > > > > I try to explain why we need the slave id.
> > > > >
> > > > > For our DMA engine driver, we have software request mode and hardware
> > > > > request mode. For software request mode, the DMA engine driver need
> > > > > trigger DMA to start transfer manually. But for hardware request mode,
> > > > > we just set one unique slave id corresponding to the slave hardware to
> > > > > the DMA engine, then the slave hardware can trigger DMA automatically.
> > > > > And the slave id is not always same with the channel id according to
> > > > > the SoC design, so we add one cell to specify the slave id.
> > > >
> > > > I did understand the need for a slave-id, I was instead wondering about
> > > > the channel-id number. On many SoCs, all channels are equal, and you
> > > > just have to pick one of those with the right capabilities for a particular
> > > > slave.
> > >
> > > Yes, all channels are equal. We just set a unique slave id for the
> > > channel for a particular slave. For example, the SPI slave can use
> > > channel 10 for tx transfer by setting slave id 11, or it also can use
> > > channel 9 for tx transfer by setting same slave id 11.
> >
> > So the channel selection is software policy, not hardware description, and
> > thus doesn't belong in DT?
> >
> > Can't the DMA engine driver allocate channels dynamically, removing the
> > need to specify this in DT?
> 
> In theory we can do as you suggested. But we still want to
> manage/assign the DMA channel resources manually for one SoC, we can
> make sure some important DMA slaves (such as audio)  can request a DMA
> channel at runtime firstly, another benefit is that it is easy to
> debug since we can easily know which channel is assigned for this
> slave.

Are  you suggesting that you have more users than channels available?

I dont think it is hard to debug if channels are dynamic in
nature (for example we can print channel number and you know which one
are you talking about, fwiw i have worked on a such a system where we
grabbed the free channel)

-- 
~Vinod
