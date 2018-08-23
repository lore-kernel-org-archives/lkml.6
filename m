Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ABCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E95208E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN9wNyJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E95208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeHWQvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbeHWQvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:51:32 -0400
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com [209.85.220.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5B7208E8;
        Thu, 23 Aug 2018 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535030510;
        bh=USO/Y8AHjw5OVWesm6RS66FPWrYenf0jv5CKATNn1MU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KN9wNyJWHD97qwS3pCKeN9W9nRkQ0Hr/+u6hzrGzCS6ch9yHGUg/Clp5flsxELpFP
         TDjn4TWz5ULoPVrQbrfjrs4W6dIQUWfVw+/ZEg9TSQN6oq97ZEYfYPkXUYnL2b4Ucr
         StgLc5qVOSp3DquayaPABgQxdy1kUy4Dwk0cQj30=
Received: by mail-qk0-f174.google.com with SMTP id z125-v6so3542169qkb.12;
        Thu, 23 Aug 2018 06:21:49 -0700 (PDT)
X-Gm-Message-State: AOUpUlGO6jvBzBEljo1RFlPmdqqIu1OkWzVoQ2FGP98pBxieVjDuk7nj
        RNIDFcM5yAr7FCDLOiGu+kb6mnfuXPGuB8NUpg==
X-Google-Smtp-Source: ANB0VdbPIgAXt9y2TkI47YhWuWh+ByW6sDMi2hK0diZaLJejTl8/tLjoMSkXk5tzu5aAlRmSmWfXyxhhgqmYSwq0d6o=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr26071000qkw.184.1535030509053;
 Thu, 23 Aug 2018 06:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
 <CAJe_ZhdZbUa2njAvSazGzv+7UgG+QHCTS+-Y-Ckqze+pMf9KQA@mail.gmail.com>
 <CAK7LNAT3MufLZhFB8HDnch09WUdEcLyDCU05dTYroOwWYcx=pQ@mail.gmail.com> <CAJe_ZheNp9t0DNQjmiQKMyZsbHBjMxqV87mE_3nQ1N_RS9znYQ@mail.gmail.com>
In-Reply-To: <CAJe_ZheNp9t0DNQjmiQKMyZsbHBjMxqV87mE_3nQ1N_RS9znYQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Aug 2018 08:21:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ppQP9icJVhpUYGj_JCyxudi0Z4=+mKiBueMKZftrQ7A@mail.gmail.com>
Message-ID: <CAL_Jsq+ppQP9icJVhpUYGj_JCyxudi0Z4=+mKiBueMKZftrQ7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 12:38 AM Jassi Brar <jaswinder.singh@linaro.org> wrote:
>
> On 23 August 2018 at 10:48, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > Hi Jassi,
> >
> >
> > 2018-08-21 19:44 GMT+09:00 Jassi Brar <jaswinder.singh@linaro.org>:
> >> On 21 August 2018 at 15:17, Masahiro Yamada
> >> <yamada.masahiro@socionext.com> wrote:
> >>> (+CC Rob, DT, LKML)
> >>>
> >>> I forgot to CC this to DT community...
> >>>
> >>>
> >>> 2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> >>>> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
> >>>> Pro4, and sLD8 SoCs.
> >>>>
> >>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>>> ---
> >>>>
> >>>>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 28 ++++++++++++++++++++++
> >>>>  1 file changed, 28 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> >>>> new file mode 100644
> >>>> index 0000000..a9e969e
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> >>>> @@ -0,0 +1,28 @@
> >>>> +UniPhier Media IO DMA controller
> >>>> +
> >>>> +This works as an external DMA engine for SD/eMMC controllers etc.
> >>>> +found in UniPhier LD4, Pro4, sLD8 SoCs.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible: should be "socionext,uniphier-mio-dmac".
> >>>> +- reg: offset and length of the register set for the device.
> >>>> +- interrupts: a list of interrupt specifiers associated with the DMA channels.
> >>>> +- clocks: a single clock specifier
> >>>> +- #dma-cells: should be <1>. The single cell represents the channel number.
> >>>> +- dma-channels: specify the number of the DMA channels. This should match to
> >>>> +  the number of tuples in the interrupts property.
> >>>> +
> >> Can we not infer the number of channels from interrupt tuples? After
> >> all the driver assumes they are same.
> >
> >
> > It would be possible to count the number of tuples
> > in "interrupts".
> >
> >
> >
> > I know of_irq_count(), but I do not see any driver
> > in drivers/dma/ that calls it.
> >
> >
> > I guess the reason is that of_irq_count() is not exported,
> > so tristate drivers like this cannot use it.
> >
> >
> > I checked Documentation/devicetree/bindings/dma/,
> > and some controllers specify _redundant_ dma-channels property.
> >
> > fsl-mxs-dma.txt
> > renesas,rcar-dmac.txt
> > renesas,usb-dmac.txt
> >
> :) I am not sure "because others are doing it" is a good reason to
> introduce redundancy.
>
>
> > I also see counter-implementation.
> >
> >
> > bcm2835-dma.c hard-codes the number of channels in the driver.
> > tegra210-adma.c associates nr_channels with compatible string.
> >
> >
> >
> > I will wait for comments from the maintainers.
> >
> > If desired, I will export of_irq_count()
> > and use it from my driver.
> >
> If you don't want to leave too much footprint, you could do
>
>   count = 0;
>   while (of_irq_parse_one(dev, count, &irq) == 0) count++
>
> of_irq_parse_one() is already exported.

Yes, but we really don't more users and drivers shouldn't be using it.
Grepping DT functions and when the only users are pretty much powerpc,
that's a good indication not to use the function.

And you don't want to use of_irq_count either. platform_irq_count is
what should be used here. It's already exported.

Rob
