Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD37C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045892170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nL6Zvu+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045892170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeHUNIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:08:20 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:51467 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeHUNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:08:20 -0400
X-Greylist: delayed 1065 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2018 09:08:18 EDT
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7L9meke005110;
        Tue, 21 Aug 2018 18:48:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7L9meke005110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534844920;
        bh=wFU/SPrD1GFzSsc34HCbIWOgMY3S8H5k/C2qVCK2OIA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nL6Zvu+a1LZnVQGzZEgpZAVvyj10gF6IZjZydgitcSDlq4iDPJO79XjYdAl30Swg5
         CKavgE4ZhfI320thgjWo1f9d0gJ2xyqpX5fPoDbZnHN/Mx+Sq6leF/UQoLnh6RLd1x
         uFpn2p3yI7e6LUM7zS8XOSuw1eg9rP++OLXLqvGzPDzMuHRnQKU4AYf671LWk7UjCt
         YV+D/yt/PgRlYmnPbMGtg5oAow8EnDZTP6C5aeAVJ/QUW8Acay6Tcf8H6qsiUCjoGN
         ZJr4L8OnZVpdVCURwL+DnnUsyuDBta8Lx4iFU+2hpKqUM2UZQQa7+G7HLlj+KfYOWF
         hsj1hubV0sB4A==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id l2-v6so1153064uaf.11;
        Tue, 21 Aug 2018 02:48:40 -0700 (PDT)
X-Gm-Message-State: AOUpUlHa7mfEiPURESmDQiugZAUbaFOVbt+Eu6BGm5eFIBu11FnVgw75
        iWxYGSsdCc9r8r1fUS9pv71jSOAHIw46Xhsz/Pk=
X-Google-Smtp-Source: AA+uWPzzSd78PVezNam5nLJWDgezXCGMLKy2a8W2Jkym9dwXyteK2ltxonCAiXBXDlk0Lu0SAlSfKhUgjHa4/bnZcvs=
X-Received: by 2002:ab0:b:: with SMTP id 11-v6mr32408370uai.19.1534844919514;
 Tue, 21 Aug 2018 02:48:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 02:47:59
 -0700 (PDT)
In-Reply-To: <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
References: <1534843809-4137-1-git-send-email-yamada.masahiro@socionext.com> <1534843809-4137-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 18:47:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
Message-ID: <CAK7LNASr=rf_foQ7PDTNS440rx3TLuY_TBagfQ-gCHxXpFB2vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Rob, DT, LKML)

I forgot to CC this to DT community...


2018-08-21 18:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
> Pro4, and sLD8 SoCs.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
>
> diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> new file mode 100644
> index 0000000..a9e969e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> @@ -0,0 +1,28 @@
> +UniPhier Media IO DMA controller
> +
> +This works as an external DMA engine for SD/eMMC controllers etc.
> +found in UniPhier LD4, Pro4, sLD8 SoCs.
> +
> +Required properties:
> +- compatible: should be "socionext,uniphier-mio-dmac".
> +- reg: offset and length of the register set for the device.
> +- interrupts: a list of interrupt specifiers associated with the DMA channels.
> +- clocks: a single clock specifier
> +- #dma-cells: should be <1>. The single cell represents the channel number.
> +- dma-channels: specify the number of the DMA channels. This should match to
> +  the number of tuples in the interrupts property.
> +
> +Example:
> +       dmac: dmac@5a000000 {
> +               compatible = "socionext,uniphier-mio-dmac";
> +               reg = <0x5a000000 0x1000>;
> +               interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
> +                            <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
> +               clocks = <&mio_clk 7>;
> +               #dma-cells = <1>;
> +               dma-channels = <8>;
> +       };
> +
> +Note:
> +In the example above, "interrupts = <0 68 4>, <0 68 4>, ..." is not a typo.
> +The first two channels share a single interrupt line.
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
