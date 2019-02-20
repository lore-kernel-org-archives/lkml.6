Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CD6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80085208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBTJIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:08:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42163 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:08:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so26317082qtr.9;
        Wed, 20 Feb 2019 01:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mUECuGflbT+3OtT6Ql/vTgnLCOiUQ5tsdWlat+sv/Y=;
        b=G7doco4S0uSlTFap4JtpMtDxSRGPTtXJTyAf1Pr5Jh1VFIjaN4tfcb5vOGeqmOozdK
         pIp7iYsPwtGqhqKa8nzdsm5xGVMtQ4CyZOCyFxiez1K59NIQLf7uzYy8z4zyL91unTU5
         Qp2a/qsRt7ItaTDwYvcejYHoOOYfZy7JWFdlA+tQJiqWQQZJw7tzHjguS0nc2bFtPeZg
         EHl5LkhMWIjbAyej7DwrA0Nh4QRXjERSen+wb2IUKLNsriPqzi5lKJSkvcVJ+YOcc+Tm
         YdXvGzaSti5H2yF6WfhlN526OIRag5hcQEJBBfVHs8Tw5eSc3gi8mWh6+YBCfw/ywFQt
         uCEg==
X-Gm-Message-State: AHQUAuY+hS/2UMq1jvLJbMHuSCm13a0D2D6U8ypJQwv8O3BasEd0wzMN
        qahMQLYBreMzUEJ3DHnjacgDZguFFu7KXZwXb0s=
X-Google-Smtp-Source: AHgI3IZWXZxDXh+oD/tkm0U25m4N156z1aOGikcR6Ar0JR2Zc7I+/44wb6s1Aub2dRK2i/9nNcSLWUWa4b4WDaEaffM=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr25849852qtn.212.1550653682931;
 Wed, 20 Feb 2019 01:08:02 -0800 (PST)
MIME-Version: 1.0
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
 <20190219122027.GA21884@vkoul-mobl> <CAMz4kuK89AyL6PA2dRF1t=tR6-fKXKp+x3oi+cKDqSqi08xv0Q@mail.gmail.com>
In-Reply-To: <CAMz4kuK89AyL6PA2dRF1t=tR6-fKXKp+x3oi+cKDqSqi08xv0Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 10:07:45 +0100
Message-ID: <CAK8P3a0z4YSr2BCnM91gBNduhODmx25fF7y6_wgsc_u3i_5YEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Wed, Feb 20, 2019 at 4:13 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Tue, 19 Feb 2019 at 20:20, Vinod Koul <vkoul@kernel.org> wrote:
> > On 19-02-19, 17:49, Baolin Wang wrote:
> > > On Tue, 19 Feb 2019 at 17:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > I did understand the need for a slave-id, I was instead wondering about
> > > > > > the channel-id number. On many SoCs, all channels are equal, and you
> > > > > > just have to pick one of those with the right capabilities for a particular
> > > > > > slave.
> > > > >
> > > > > Yes, all channels are equal. We just set a unique slave id for the
> > > > > channel for a particular slave. For example, the SPI slave can use
> > > > > channel 10 for tx transfer by setting slave id 11, or it also can use
> > > > > channel 9 for tx transfer by setting same slave id 11.
> > > >
> > > > So the channel selection is software policy, not hardware description, and
> > > > thus doesn't belong in DT?
> > > >
> > > > Can't the DMA engine driver allocate channels dynamically, removing the
> > > > need to specify this in DT?
> > >
> > > In theory we can do as you suggested. But we still want to
> > > manage/assign the DMA channel resources manually for one SoC, we can
> > > make sure some important DMA slaves (such as audio)  can request a DMA
> > > channel at runtime firstly, another benefit is that it is easy to
> > > debug since we can easily know which channel is assigned for this
> > > slave.
> >
> > Are  you suggesting that you have more users than channels available?
>
> Until now we have not met this issue, but we can not make sure if this
> can happen in future. Moreover DMA channel resources are belonging to
> the DMA engine's hardware resources, I think it should be described in
> DT like many other drivers did.

As far as I can tell, most platforms do not describe the assignment
of resources in DT for dma engines, the numbers in there are meant to
describe whatever is fixed, and most platforms should do it that way.

The naming is sometimes a bit confusing, as a dma request line
assignment can be called a slave-id or a channel-id depending whose
documentation you read. The drivers/dma/virt-dma.c implementation
is used in some cases to represent request numbers as virtual
channels, so a dmaengine driver can allow one dma_request_chan()
per slave, and then assign the hardware channels dynamically
while doing a transfer, rather than having a fixed channel assignment
when we first ask for a channel.

       Arnd
