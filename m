Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1AFC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A471B2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfA3QwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:52:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35100 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfA3QwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:52:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so146666qka.2;
        Wed, 30 Jan 2019 08:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Txd3GsWvhF9L3tb39fYpPffEJr9NibpUfMc5wNUUcHs=;
        b=kfj5LVN0lPUfKkTt7koaa3lew9soFdONfBlV+LLMs1ohIMIIulEjbomAvMVvEDj2kt
         L+TPTZQMQ/scRMXV2Of3vHMtGjdzrrbIrNHQTx/I1gYiQ16iL2GRDUAa24zqfsry3XRr
         XVIU4PEcBPYplMw6Gr2ofXrqYnxThEkrLnW2Cf/b7AbVbGJgQZLytpD2XSLd9Ejy1dmf
         asO89XnzTek01yj6ZsHxLJOpFkF2oCPFHNh3c4I1mN3K8R/T+lAqqferdTok9pctvPrY
         xZunVbDnaZ7vydpPnUHfuoCRuuoR+jzz68nmzRnV79nxh3bEftxBeDK4NrFbDz3FNW8n
         TP8g==
X-Gm-Message-State: AJcUukdnlmdlbTGLPsXpC/r0JzgKNC+jzHbHgRwZwAHBaQlzVrXYHCfq
        66Orws0L1duK7j+ISXF37CZBCpW+7l78YBHAu9VT3A==
X-Google-Smtp-Source: ALg8bN4Z9oDX+Knbk9so27sMmfvH84XqmZnR9QnaKYAn3naGHLmyoR8NJAAZJBn6qz9xFpp2Zh8ItPf50lBYabp+taw=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr27031253qkf.107.1548867122620;
 Wed, 30 Jan 2019 08:52:02 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 17:51:46 +0100
Message-ID: <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
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

On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> The DMA engine clients can trigger DMA engine automatically by setting
> the corresponding hardware slave id for the DMA engine. Thus add one
> cell to present the hardware slave id for DMA clients.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> index 7a10fea..7812cf0 100644
> --- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> @@ -6,8 +6,8 @@ Required properties:
>  - compatible: Should be "sprd,sc9860-dma".
>  - reg: Should contain DMA registers location and length.
>  - interrupts: Should contain one interrupt shared by all channel.
> -- #dma-cells: must be <1>. Used to represent the number of integer
> -       cells in the dmas property of client device.
> +- #dma-cells: must be <2>. Used to represent the channel id and slave id
> +       of integer cells in the dmas property of client device.
>  - #dma-channels : Number of DMA channels supported. Should be 32.
>  - clock-names: Should contain the clock of the DMA controller.
>  - clocks: Should contain a clock specifier for each entry in clock-names.
> @@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
>
>  Client:
>  DMA clients connected to the Spreadtrum DMA controller must use the format
> -described in the dma.txt file, using a two-cell specifier for each channel.
> -The two cells in order are:
> +described in the dma.txt file, using a three-cell specifier for each channel.
> +The three cells in order are:
>  1. A phandle pointing to the DMA controller.
>  2. The channel id.
> +3. The hardware slave id which is used for clients to trigger DMA engine
> +automatically.

I notice that this is an incompatible binding change. Is that necessary?
If the current code works, I'd suggest allowing both #dma-cells=<2>
and <3>, and then implementing both in the driver.

     Arnd
