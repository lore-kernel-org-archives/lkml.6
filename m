Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1824C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1C2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA1C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeKHQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:26:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36138 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKHQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:26:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id x2-v6so15462735eds.3;
        Wed, 07 Nov 2018 22:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7JATAwSqdhCKMRL7Ivn/NrOHpM8oFlB5hcCybAOerk=;
        b=ObDyWqmrGpi2FCqpTsadM2P1yf4XFK+zQ9fCfLZpwW/rLv9ZMqWAKhfCSezpP3xUay
         ytbqKggGVektayfPqMGEmxqbWjcCpt0zdvrMqqd0AOXHDD67VhXiDrkbwk23IfLAKmbL
         1VFN3OjMsDztjGGtbFNQPYTA2m4mcfN4ShPvAtE7JWDJlcs3Ixkk6bW0BROqTgNc02X2
         RAcoVU8vV1ruRT5qStwLDwbyxNoxtYdwEHjgdQMz3EXbGFhYHvvQqmaF0nqPNO/PXfIK
         PzkV/m65oWweR+Y2ZN5JfxqpvhVjqcTZ+7xwFJV2Mv8+1op/0VAQ+zJp+j/nkqecL5zN
         mI0w==
X-Gm-Message-State: AGRZ1gII0/NFTjARL/J9wZstcK0prA4sO6SfHYrPDDjGECKkFbaPo3S2
        FUARYeliknMd1XBmp83oaaxtSQbi
X-Google-Smtp-Source: AJdET5fHy4PdolknHfEm5+Hx4V3u0GK9t8HipOnH2vqEG6MNRjMfD25x5PLhpSb/FV2Pg9TH5rDqUg==
X-Received: by 2002:a17:906:8314:: with SMTP id j20-v6mr2186408ejx.60.1541659954271;
        Wed, 07 Nov 2018 22:52:34 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id x21-v6sm439693ejf.2.2018.11.07.22.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:52:33 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id k15-v6so16973081wre.12;
        Wed, 07 Nov 2018 22:52:33 -0800 (PST)
X-Received: by 2002:adf:ecc5:: with SMTP id s5-v6mr2720156wro.208.1541659953368;
 Wed, 07 Nov 2018 22:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-2-anarsoul@gmail.com>
In-Reply-To: <20181108063929.29720-2-anarsoul@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 8 Nov 2018 14:52:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v65NQHZ5k8626+cH_kM5==y0yHHWinsyvU8utu6ywKwDJg@mail.gmail.com>
Message-ID: <CAGb2v65NQHZ5k8626+cH_kM5==y0yHHWinsyvU8utu6ywKwDJg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] arm64: dts: allwinner: a64: add nodes necessary
 for analog sound support
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 2:42 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> Add nodes for i2s, digital and analog parts of audiocodec on A64
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..53796a3e6bf3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -173,6 +173,34 @@
>                 compatible = "linux,spdif-dit";
>         };
>
> +       sound: sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "sun50i-a64-audio";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,frame-master = <&cpudai>;
> +               simple-audio-card,bitclock-master = <&cpudai>;
> +               simple-audio-card,mclk-fs = <512>;
> +               simple-audio-card,aux-devs = <&codec_analog>;
> +               simple-audio-card,routing =
> +                               "Left DAC", "AIF1 Slot 0 Left",
> +                               "Right DAC", "AIF1 Slot 0 Right",
> +                               "AIF1 Slot 0 Left ADC", "Left ADC",
> +                               "AIF1 Slot 0 Right ADC", "Right ADC",
> +                               "Left ADC", "ADC",
> +                               "Right ADC", "ADC",

The ADC widget is an overall enable control for the digital part of
the codec's ADC.
It is modeled as a supply widget in sun8i-codec. The routing should be internal
to sun8i-codec. See the following for the DAC routing:

    https://elixir.bootlin.com/linux/v4.20-rc1/source/sound/soc/sunxi/sun8i-codec.c#L474

> +                               "MIC1", "Mic",
> +                               "MIC2", "Headset Mic";

Drop the last two. These belong at the board level. And as previously mentioned,
these two widgets from the sun8i-codec driver are bogus.

> +               status = "disabled";
> +
> +               cpudai: simple-audio-card,cpu {
> +                       sound-dai = <&dai>;
> +               };
> +
> +               link_codec: simple-audio-card,codec {
> +                       sound-dai = <&codec>;
> +               };
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13
> @@ -665,6 +693,30 @@
>                         status = "disabled";
>                 };
>
> +               dai: dai@1c22c00 {
> +                       #sound-dai-cells = <0>;
> +                       compatible = "allwinner,sun50i-a64-codec-i2s";
> +                       reg = <0x01c22c00 0x200>;
> +                       interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +                       clock-names = "apb", "mod";
> +                       resets = <&ccu RST_BUS_CODEC>;
> +                       reset-names = "rst";
> +                       dmas = <&dma 15>, <&dma 15>;
> +                       dma-names = "rx", "tx";
> +                       status = "disabled";
> +               };
> +
> +               codec: codec@1c22e00 {
> +                       #sound-dai-cells = <0>;
> +                       compatible = "allwinner,sun8i-a33-codec";
> +                       reg = <0x01c22e00 0x600>;
> +                       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +                       clock-names = "bus", "mod";
> +                       status = "disabled";
> +               };
> +
>                 uart0: serial@1c28000 {
>                         compatible = "snps,dw-apb-uart";
>                         reg = <0x01c28000 0x400>;
> @@ -902,6 +954,12 @@
>                         #reset-cells = <1>;
>                 };
>
> +               codec_analog: codec-analog@1f015c0 {
> +                       compatible = "allwinner,sun50i-a64-codec-analog";
> +                       reg = <0x01f015c0 0x4>;
> +                       status = "disabled";
> +               };
> +
>                 r_i2c: i2c@1f02400 {
>                         compatible = "allwinner,sun50i-a64-i2c",
>                                      "allwinner,sun6i-a31-i2c";
> --
> 2.19.1
>
