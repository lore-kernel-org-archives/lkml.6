Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636EAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3371D21905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfBSJbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:31:00 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40062 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:30:59 -0500
Received: by mail-vs1-f68.google.com with SMTP id z18so11304049vso.7;
        Tue, 19 Feb 2019 01:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1hqWke7hSkfFJ5YyU/r7zOfSU7Q3U0kRAuChdTv09k=;
        b=NT9Wuq5WHG4pTEeShqs2b059sor1ESPsqel0z3XcH3l07kASG8pnwcLgO89gLXSRex
         +MVs6wxiQ5Bmlis5t1wvRNouTn0Ib0ZWzsxa4rxipDW1KdV9q94SlEnZsBsl+PprfDlx
         +EJV4tF7mK6ibRcpfWlSITFEYJt1ws3vJBgtchHZREfzb3PwBAnCnIsh9wMOQHk6OFrJ
         Lx8CZ42gcyZOpnUkqeQ+CZR2TSa1msBTYfHE7B2nkyW9dWKTdjgiZ6H7mql2n7m0M0xp
         qY1qwP0jfE4qXN03Guc+SZDrODGDFi1Bvurk2Ffr780JwVDa+zR/s/kHFMgiRB1lcmbE
         zo/g==
X-Gm-Message-State: AHQUAuby76EenFTMYPllksqzRgbM/+IxeB+2n1iCTrt6z1EPu7+DOj2H
        /9hw8N1VXc8UkR7IHM7zOr31qy7b3SuyMXSDsINxQw==
X-Google-Smtp-Source: AHgI3IZxj7k6wDaxcerd0ePfHS8seMidk+JagXGSOdhHtTztuWXrbvTEy0q8/3rY6LdMH7Cx/kyQLIgLFNgKUsYsCGM=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr13575764vsc.152.1550568657733;
 Tue, 19 Feb 2019 01:30:57 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
 <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com> <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
In-Reply-To: <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Feb 2019 10:30:44 +0100
Message-ID: <CAMuHMdWPZGYpvANL_V=YszPWjtTA+ZnU6GVDmn188LC=eC005Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > >
> > > > > > > >  Client:
> > > > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > > > -The two cells in order are:
> > > > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > > > +The three cells in order are:
> > > > > > > >  1. A phandle pointing to the DMA controller.
> > > > > > > >  2. The channel id.
> > > > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > > > +automatically.
> > > > > > >
> > > > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > > > and <3>, and then implementing both in the driver.
> > > > > >
> > > > > > Yes, this is necessary.
> > > > > >
> > > > > > Yes, current code can work, but the problem is that the DMA clients
> > > > > > must add one property (something like "sprd,slave-id") to specify the
> > > > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > > > including dma channel and dma slave id, which can avoid introducing
> > > > > > some similar properties for DMA clients.
> > > > > >
> > > > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > > > drivers need to change when we changing dma cells. Thanks.
> > > > >
> > > > > Do you have any other concerns about this patch set? If not, I think
> > > > > Vinod can apply this patch set. Thanks.
> > > >
> > > > Sorry for the late reply. Yes, this makes sense since there are no
> > > > existing users then. For the DT changes going through the dmaengine
> > > > tree
> > > >
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Thanks for your reviewing.
> > >
> > > >
> > > > One more question, to make sure we don't need to edit it again:
> > > > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > > > a strict hardware requirement for your DMA engine? In many
> > > > other designs, only a DMA request line number needs to
> > > > be described, and I think this would correspond to what you
> > > > call the 'hardware slave id' in your documentation.
> > >
> > > I try to explain why we need the slave id.
> > >
> > > For our DMA engine driver, we have software request mode and hardware
> > > request mode. For software request mode, the DMA engine driver need
> > > trigger DMA to start transfer manually. But for hardware request mode,
> > > we just set one unique slave id corresponding to the slave hardware to
> > > the DMA engine, then the slave hardware can trigger DMA automatically.
> > > And the slave id is not always same with the channel id according to
> > > the SoC design, so we add one cell to specify the slave id.
> >
> > I did understand the need for a slave-id, I was instead wondering about
> > the channel-id number. On many SoCs, all channels are equal, and you
> > just have to pick one of those with the right capabilities for a particular
> > slave.
>
> Yes, all channels are equal. We just set a unique slave id for the
> channel for a particular slave. For example, the SPI slave can use
> channel 10 for tx transfer by setting slave id 11, or it also can use
> channel 9 for tx transfer by setting same slave id 11.

So the channel selection is software policy, not hardware description, and
thus doesn't belong in DT?

Can't the DMA engine driver allocate channels dynamically, removing the
need to specify this in DT?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
