Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEEC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED27020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080006;
	bh=2jCVUvZBfffaFn5qDL+A4UhoS97Tq71uV01sR7ApKtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=16zqZ+onmoIGl6sRP25NtAX63RDMF8StpuIXRINcSl9vMIP/YABIp2pku9xU8Am4T
	 4aaDTMBkQ6kGC0nhGLNO9Bxk/PweLmPR4IYxdEVP3ch28pqKNc2qVezJ5dLSN87HQF
	 hJHByPvXwNkHFqKaHL5U9PCQvD/RerE3frvej8e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfAUONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731212AbfAUNxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:09 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9122089F;
        Mon, 21 Jan 2019 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078789;
        bh=2jCVUvZBfffaFn5qDL+A4UhoS97Tq71uV01sR7ApKtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fwttrSLA5ncqXTrvGhqQSBS3/f+HSmviRwL1EC/ngeDLVh9ufapyEnraIHeFgOm5r
         bMlWCzuPDsFfA+iyX/L9U0c1wyuThC5E0ygjlHBJNwCBV68f7s6FPzusfUJhCcggA5
         1uL34h67SzbiHinIQRriSxU+JjCW066K+9CgufJY=
Received: by mail-qk1-f182.google.com with SMTP id y16so12263975qki.7;
        Mon, 21 Jan 2019 05:53:09 -0800 (PST)
X-Gm-Message-State: AJcUukfaWtGImSB0q9F6XJvu4sdgH2TUK3Y4XPzZ+NSjJqfTvODSlZho
        0eO1VtsAcjJhYnt/h3T5ABwPdta8sEwKObTipQ==
X-Google-Smtp-Source: ALg8bN771V6ZLQ3DMCZdNTKSOA2M+Vq3tsmbKHAc9Pb4RGQ7jDoy9jca3BIw5/GJ/Xkk4+PPHUBTLYYjP52E+Iqpke4=
X-Received: by 2002:a37:5686:: with SMTP id k128mr23266558qkb.29.1548078788409;
 Mon, 21 Jan 2019 05:53:08 -0800 (PST)
MIME-Version: 1.0
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
In-Reply-To: <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 07:52:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com>
Message-ID: <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI
 dma mode
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

On Tue, Jan 15, 2019 at 7:47 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>

The email address should be updated with unisoc.com.

> Add the DMA properties for the SPI dma mode.
>
> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> index bad211a..01ef53f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> @@ -14,6 +14,12 @@ Required properties:
>         address on the SPI bus. Should be set to 1.
>  - #size-cells: Should be set to 0.
>
> +Optional properties:
> +dma-names: Should contain names of the SPI used DMA channel.
> +dmas: Should contain DMA channels which the SPI used sorted in the
> +       same order as the dma-names property.
> +sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
> +
>  Example:
>  spi0: spi@70a00000{
>         compatible = "sprd,sc9860-spi";
> @@ -21,6 +27,9 @@ spi0: spi@70a00000{
>         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>         clock-names = "spi", "source","enable";
>         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> +       dma-names = "rx_chn", "tx_chn";
> +       dmas = <&apdma 11>, <&apdma 12>;
> +       sprd,dma-slave-ids = <11 12>;

When would this be different values from what's in 'dmas'?

>         #address-cells = <1>;
>         #size-cells = <0>;
>  };
> --
> 1.7.9.5
>
