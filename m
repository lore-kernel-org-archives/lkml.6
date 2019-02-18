Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B03C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6039121900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500028;
	bh=6sbzkspViInVknbHtfHnMOLKmqRq3UyiTAp+IY7mhGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lzSFTyL+70SkEVqoXhIG2N0mJF7p/XOmBHqHDf+K/qTi9TBk2KNdRLgR/8aXRebfs
	 rojWkhmzi38uJfXQIPvncmuYa3PxBF8wPlQnbSRIyqpG27APjfrnZv3jAiavXh73fV
	 425hQ1FpW01GIxqMT8vZdrEUGxr3fJljMD+LNY0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391677AbfBRO1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389275AbfBROCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:20 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42EA921904;
        Mon, 18 Feb 2019 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498539;
        bh=6sbzkspViInVknbHtfHnMOLKmqRq3UyiTAp+IY7mhGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zqm3bUCAPlZCKbohJ7n2BF9kKtsqBZe6jTHO04BbAbHy4BqqmZWtBULEtfdBi+YDU
         bFLLveuJKnX0pwucSNHvTbjLbhwLoPgzxRskBRGncYqE6L5RkVfRJp/zqRnDxMhdNE
         jT733ek2mmvyw/l+PxAeAgvxquxgPpjGq2C0DbX0=
Received: by mail-qk1-f170.google.com with SMTP id f196so9977259qke.10;
        Mon, 18 Feb 2019 06:02:19 -0800 (PST)
X-Gm-Message-State: AHQUAubNKrnFaCiA8llCNXefKTVgv5STlKgydNuit/hhlerWQu/r2PkL
        WAGxsBUlUDcSmgVoyc+EFoqSh+kjcv3GqkEppA==
X-Google-Smtp-Source: AHgI3IYWx+4HcmvsFGsb75VvtKrdIIgBjjao6ulEeRHLDzJjA5VYvwX57xw+N2TZuJVAG1LFdru49JyoRxDr/SmHVtg=
X-Received: by 2002:a37:94d:: with SMTP id 74mr16881117qkj.79.1550498538397;
 Mon, 18 Feb 2019 06:02:18 -0800 (PST)
MIME-Version: 1.0
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
In-Reply-To: <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Feb 2019 08:02:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+x+XgxSn7ks84_JZxTkpQ-irFBmRc3tp3zsfUcHUPpg@mail.gmail.com>
Message-ID: <CAL_JsqK+x+XgxSn7ks84_JZxTkpQ-irFBmRc3tp3zsfUcHUPpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: Add the DMA properties for the
 SPI dma mode
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 1:37 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> From: Lanqing Liu <lanqing.liu@unisoc.com>
>
> Add the DMA properties for the SPI dma mode.
>
> Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Remove sprd,dma-slave-ids property.
> ---
>  Documentation/devicetree/bindings/spi/spi-sprd.txt |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> index bad211a..3c7eacc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> @@ -14,6 +14,11 @@ Required properties:
>         address on the SPI bus. Should be set to 1.
>  - #size-cells: Should be set to 0.
>
> +Optional properties:
> +dma-names: Should contain names of the SPI used DMA channel.
> +dmas: Should contain DMA channels and DMA slave ids which the SPI used
> +       sorted in the same order as the dma-names property.

These need to define the order and names.

> +
>  Example:
>  spi0: spi@70a00000{
>         compatible = "sprd,sc9860-spi";
> @@ -21,6 +26,8 @@ spi0: spi@70a00000{
>         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>         clock-names = "spi", "source","enable";
>         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> +       dma-names = "rx_chn", "tx_chn";

Everyone else uses "rx" and "tx". Do you really need something different?

> +       dmas = <&apdma 11 11>, <&apdma 12 12>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>  };
> --
> 1.7.9.5
>
