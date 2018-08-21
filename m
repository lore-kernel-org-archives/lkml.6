Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908E4217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQYVKfTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908E4217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeHUWa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeHUWa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:30:56 -0400
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com [209.85.216.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1082183B;
        Tue, 21 Aug 2018 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534878572;
        bh=TLOTLjFsl2P1EjphIo2lPqxbn1A897ahEznjMY67l2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JQYVKfTsQ0eSgf1jCq5Het9dI7nrMf9VzNWQlx3pk3KNZC1KvvDfQN52mzZdxr8VR
         A8xMqolliQD6pV5tMvYXzQRSA+d83WUeXsS3NOPuXhZGRiyZrjWZWZqAxvjOkZciGK
         NI8AWakXQppjwBIaR3wfrcJGdVPxLKz2/COGJ2xc=
Received: by mail-qt0-f171.google.com with SMTP id t5-v6so21525822qtn.3;
        Tue, 21 Aug 2018 12:09:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlF5aDXL+c7Dfk86xGhGhUwDeREeg8KrWE1vh4Xhb3RE7VhNW55t
        k4KVBwszPk7nKG9hhBGZRCkNGYk2SGM9sHPGSA==
X-Google-Smtp-Source: AA+uWPweJYWpu8bbmxBysAJJyNjUdVsY7Zi5JTd3/4mGX0xGGQfGPG7wH/a3sDyh4Vns3xZ/M3HuDqAt1Rran5bj198=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr10948764qtd.101.1534878571851;
 Tue, 21 Aug 2018 12:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com>
 <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com> <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
In-Reply-To: <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Aug 2018 14:09:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwXKx3MKE-8GuHqnJZ-047GxhHUB5LpW3O8j58OsAKuA@mail.gmail.com>
Message-ID: <CAL_JsqJwXKx3MKE-8GuHqnJZ-047GxhHUB5LpW3O8j58OsAKuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 4:48 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> (+CC Rob, DT, LKML)
>
> I forgot to CC this to DT community...

You really need to resend so that patchwork will pick it up and I'll
see it for sure.

>
>
> 2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
> > Pro4, and sLD8 SoCs.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 28 ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> > new file mode 100644
> > index 0000000..a9e969e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> > @@ -0,0 +1,28 @@
> > +UniPhier Media IO DMA controller
> > +
> > +This works as an external DMA engine for SD/eMMC controllers etc.
> > +found in UniPhier LD4, Pro4, sLD8 SoCs.
> > +
> > +Required properties:
> > +- compatible: should be "socionext,uniphier-mio-dmac".
> > +- reg: offset and length of the register set for the device.
> > +- interrupts: a list of interrupt specifiers associated with the DMA channels.
> > +- clocks: a single clock specifier
> > +- #dma-cells: should be <1>. The single cell represents the channel number.
> > +- dma-channels: specify the number of the DMA channels. This should match to
> > +  the number of tuples in the interrupts property.
> > +
> > +Example:
> > +       dmac: dmac@5a000000 {

dma-controller@...

> > +               compatible = "socionext,uniphier-mio-dmac";
> > +               reg = <0x5a000000 0x1000>;
> > +               interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
> > +                            <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
> > +               clocks = <&mio_clk 7>;
> > +               #dma-cells = <1>;
> > +               dma-channels = <8>;
> > +       };
> > +
> > +Note:
> > +In the example above, "interrupts = <0 68 4>, <0 68 4>, ..." is not a typo.
> > +The first two channels share a single interrupt line.
> > --
> > 2.7.4
> >
>
>
>
> --
> Best Regards
> Masahiro Yamada
