Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF34EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBC420851
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYTfXEaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfBTL3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:29:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42454 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfBTL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:29:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so9303240ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ekYov34e3h7u4UagIP+Zwo8KjjfYo+mnO834hleTZ4=;
        b=HYTfXEaPkaICjJnZ4jr8pRdKYfpJNSFMHI8bCK02hqnq5Ibjj4ZZGTU7D4fXTqJzXS
         U5kXaWRwI28r8buinjdqah6lA6jNn2yJU74clGfzkZnViqBKQ45qcvctt20YxUx6cxIm
         s3T5Wc+fci5nTIZdZ4vurnByMBEDoihIfwGDsTf8r7NjcVvr52M3yagkQugubIdiq6Ky
         yfa6ownOi8PUg1lQSUfBfEEsEf8yaa/eheO/9JrIMY000UiwP7WOTzP2SE7sU4/z8Wfy
         giO+nbJr2fM+sctHb7T4UvqhlodCx51nMMkzx/2fE7RwS300qN2ehJGh2Cxs1+ZK3YGS
         AWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ekYov34e3h7u4UagIP+Zwo8KjjfYo+mnO834hleTZ4=;
        b=sw2sgc5CDLo/QZ/mx5weKdWCTxfkp2r0cvWjK+YiBh+mD13FZr75WmXA21bVR+HpO7
         PWnOIVn3DSjp/kh56+9/iqpFKlokaZPwpA23SgmHQYehrRLP3BJKNn2nq74hkhlAni1e
         i6WE1dw4Ga4+K/L7HIfbt/HDd/oU9Uc3azKTpuwzdV6kW2JXyr3JbjrScfD9Gv8zCBRM
         L0IeBZKdmISbFzzCL7C9shUq30LlzJiVjSDJKu0r5qNZoE8Wze123t8pt6BZxpnCwPPY
         rW6UkyfoRCxjJWHaQJmLQoxaEd5zaNlPjz438hBDc2w4hfTBC7lYtGen3ykZJ5ILHO7d
         eCwA==
X-Gm-Message-State: AHQUAubdzhZsfD5zV4QiEeiLKlcXNG7YX0VjD2+OrnO6XpAtw4l0JqG1
        xs0bJN/rJ6+70AHrhiBR1jPmTp+c0P7LUBqIMhky6g==
X-Google-Smtp-Source: AHgI3IZ6DunjBMJqeQTlyzBj4lmU5s4I2BoY2Tz1fFIKZr5d7bdtC1aCzA+7qgcnorplKV0zkhifYj1JTb48/zDEs7k=
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr20131487ljg.146.1550662174696;
 Wed, 20 Feb 2019 03:29:34 -0800 (PST)
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
 <CAK8P3a0z4YSr2BCnM91gBNduhODmx25fF7y6_wgsc_u3i_5YEg@mail.gmail.com>
In-Reply-To: <CAK8P3a0z4YSr2BCnM91gBNduhODmx25fF7y6_wgsc_u3i_5YEg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 20 Feb 2019 19:29:23 +0800
Message-ID: <CAMz4kuLZH2dt5JTB1uYcLkm4EG_Av=7mnAj51s-J1-6E8+R5CA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To:     Arnd Bergmann <arnd@arndb.de>
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

On Wed, 20 Feb 2019 at 17:08, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 20, 2019 at 4:13 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Tue, 19 Feb 2019 at 20:20, Vinod Koul <vkoul@kernel.org> wrote:
> > > On 19-02-19, 17:49, Baolin Wang wrote:
> > > > On Tue, 19 Feb 2019 at 17:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > I did understand the need for a slave-id, I was instead wondering about
> > > > > > > the channel-id number. On many SoCs, all channels are equal, and you
> > > > > > > just have to pick one of those with the right capabilities for a particular
> > > > > > > slave.
> > > > > >
> > > > > > Yes, all channels are equal. We just set a unique slave id for the
> > > > > > channel for a particular slave. For example, the SPI slave can use
> > > > > > channel 10 for tx transfer by setting slave id 11, or it also can use
> > > > > > channel 9 for tx transfer by setting same slave id 11.
> > > > >
> > > > > So the channel selection is software policy, not hardware description, and
> > > > > thus doesn't belong in DT?
> > > > >
> > > > > Can't the DMA engine driver allocate channels dynamically, removing the
> > > > > need to specify this in DT?
> > > >
> > > > In theory we can do as you suggested. But we still want to
> > > > manage/assign the DMA channel resources manually for one SoC, we can
> > > > make sure some important DMA slaves (such as audio)  can request a DMA
> > > > channel at runtime firstly, another benefit is that it is easy to
> > > > debug since we can easily know which channel is assigned for this
> > > > slave.
> > >
> > > Are  you suggesting that you have more users than channels available?
> >
> > Until now we have not met this issue, but we can not make sure if this
> > can happen in future. Moreover DMA channel resources are belonging to
> > the DMA engine's hardware resources, I think it should be described in
> > DT like many other drivers did.
>
> As far as I can tell, most platforms do not describe the assignment
> of resources in DT for dma engines, the numbers in there are meant to
> describe whatever is fixed, and most platforms should do it that way.
>
> The naming is sometimes a bit confusing, as a dma request line
> assignment can be called a slave-id or a channel-id depending whose
> documentation you read. The drivers/dma/virt-dma.c implementation
> is used in some cases to represent request numbers as virtual
> channels, so a dmaengine driver can allow one dma_request_chan()
> per slave, and then assign the hardware channels dynamically
> while doing a transfer, rather than having a fixed channel assignment
> when we first ask for a channel.

Okay, sounds reasonable to me, and I think no issues will happen if we
assign channels dynamically after some slave usages' investigation.

I will remove channel id from DT in next version. Thanks for all your help.

-- 
Baolin Wang
Best Regards
