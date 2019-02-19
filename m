Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA634C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8382C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLQH/9ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfBSDPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:15:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38309 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfBSDPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:15:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id n15so13802088lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdLUwKcokxRXXPlKQmoqNF6GD0kvrlp4gDbhl0FFC/I=;
        b=XLQH/9ymu8qh8L/POSn+XYvYovnWZdMpr+aUpTSXKpaSZVTA6mVdnUezm4SEqRu2hM
         MvOZ6Lj+Eytgr8yr8/lROc450iMU6j0qUcAh4NMW8bAfuOwGiqsaQTpETQW9BaV/Td1u
         GZmaH7+G5PtZ2IFLmKLSGbqs+AI2bMWVx4BbyNY7q6AH7DpBRPUz8Rr4oz3Jqh+dcFaS
         E3i1TVjquKOpj4RwTE9vXwT0i1BsESm+rlYZq/AGRVo6mGYql5X/EYqqRDDf3VJGGXYE
         R4BD56opgWhKDjN3mu3+S2tCErVtwS2HuA3VAurl/s6UiS8OvHRfX5eLTvaI3+GECu/3
         kGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdLUwKcokxRXXPlKQmoqNF6GD0kvrlp4gDbhl0FFC/I=;
        b=Rl9efXPraHngbditrxWAD4Ijs4QQgrbxsK5T5/ioDDvLqgfdWurkCMTKsPmd6SarVm
         ak7sWo/4LTfDJXC3TyPHCcjY9B06pDLjHRVT100QQm9zGjVWSJ7szNCcZlh3qqZuKJkw
         xoBWs33fPxlT2hJ9ZRDHiZjcKvd5N5nadZkXhBjS75Eh6KdbogzNLDtAcLWUUw76fN6S
         Poqbf3T8y/LTe05QduYNCTdccJ5FrL4/1EhxAy0oyn0LhmfphWA7Vc7SEvPHnQAW2NUw
         ZrXOX830ss24HhuTgegfkBcc0/EmXu+IwBPYxkRkJHCg0PCCkkeLxJBbqz6vI3arr9OM
         eNFQ==
X-Gm-Message-State: AHQUAuZMc6u7wkPNBtbCnSJ719pU6pTsL5XtCdBUrv18EjsMOReHb6rn
        y3ts50g96hF6pdq+TOpHCqUrJbY+HqegHK5/xBw1uQ==
X-Google-Smtp-Source: AHgI3IYf9jlsfP7yffLtGOuw872rkg3k9NN6vlY7WDqxUmPkbrGWtyJ7hlT5m/yQKgtcCrB8IKI9/xGmxpb3wIcCpuE=
X-Received: by 2002:a19:e601:: with SMTP id d1mr16582477lfh.71.1550546103805;
 Mon, 18 Feb 2019 19:15:03 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com> <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
In-Reply-To: <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 19 Feb 2019 11:14:52 +0800
Message-ID: <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Arnd Bergmann <arnd@arndb.de>
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

On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > >
> > > > > > >  Client:
> > > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > > -The two cells in order are:
> > > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > > +The three cells in order are:
> > > > > > >  1. A phandle pointing to the DMA controller.
> > > > > > >  2. The channel id.
> > > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > > +automatically.
> > > > > >
> > > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > > and <3>, and then implementing both in the driver.
> > > > >
> > > > > Yes, this is necessary.
> > > > >
> > > > > Yes, current code can work, but the problem is that the DMA clients
> > > > > must add one property (something like "sprd,slave-id") to specify the
> > > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > > including dma channel and dma slave id, which can avoid introducing
> > > > > some similar properties for DMA clients.
> > > > >
> > > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > > drivers need to change when we changing dma cells. Thanks.
> > > >
> > > > Do you have any other concerns about this patch set? If not, I think
> > > > Vinod can apply this patch set. Thanks.
> > >
> > > Sorry for the late reply. Yes, this makes sense since there are no
> > > existing users then. For the DT changes going through the dmaengine
> > > tree
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Thanks for your reviewing.
> >
> > >
> > > One more question, to make sure we don't need to edit it again:
> > > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > > a strict hardware requirement for your DMA engine? In many
> > > other designs, only a DMA request line number needs to
> > > be described, and I think this would correspond to what you
> > > call the 'hardware slave id' in your documentation.
> >
> > I try to explain why we need the slave id.
> >
> > For our DMA engine driver, we have software request mode and hardware
> > request mode. For software request mode, the DMA engine driver need
> > trigger DMA to start transfer manually. But for hardware request mode,
> > we just set one unique slave id corresponding to the slave hardware to
> > the DMA engine, then the slave hardware can trigger DMA automatically.
> > And the slave id is not always same with the channel id according to
> > the SoC design, so we add one cell to specify the slave id.
>
> I did understand the need for a slave-id, I was instead wondering about
> the channel-id number. On many SoCs, all channels are equal, and you
> just have to pick one of those with the right capabilities for a particular
> slave.

Yes, all channels are equal. We just set a unique slave id for the
channel for a particular slave. For example, the SPI slave can use
channel 10 for tx transfer by setting slave id 11, or it also can use
channel 9 for tx transfer by setting same slave id 11.

-- 
Baolin Wang
Best Regards
