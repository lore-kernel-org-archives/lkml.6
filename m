Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B76C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035EC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3AtP8Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfAXPEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:04:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38658 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:04:30 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so4959986ioj.5;
        Thu, 24 Jan 2019 07:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0clqmzoRBRL9AulfBvfyNgJoEOFlKnN26jUXV6HxCc=;
        b=L3AtP8JaIgmYU8k6DOaKcOGmQXN/R2EOKun/tp+FvWwY8O5FatQXX14kiorKZGev8v
         rt73IGMlSlYIAN7zFtjEatYUhE+NLJpSwPliE74pKaFgZu/eP3ZHIav9nqIBWaqi2MR7
         o8BikuHuEPSNW0By9EJHKDKGiJwpTAjRzdLoUf9P6mfhk88JEGsd5I8+hTd5WHCKCb36
         ANeyDxv0Qyi2oNMMTyRvgwsRSQxp3rTHYxnRdTCfp2DlXzXobdvddg/cKkNEcjjRyKiF
         GA1Olnf6PR2TpfgTiT1r08MNJuRvtCFVqSSC2BKTOcFwNmZMD65UmPvl1URwwxenYy0n
         FPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0clqmzoRBRL9AulfBvfyNgJoEOFlKnN26jUXV6HxCc=;
        b=bFijacUWa7HRb1OH4rdnOPg93kwXmiU+h7qU3+qjfbbAWof4FLmGjz97MYPyetqXQj
         uGszdu6pJldqT6OGSSKxED/YxKoEW4DnE2zUWnSZD03EtCJf5MSOvAhw1V2VrYi8iSqP
         lzkxTUFy6vlQhu7ibidsDAMV7PFzr18boj3OKf4dalEIrI08e3gq76wN3EYf46ka5Ljf
         +Zn3+F9JY6LY5Vr+mT3jeCM46wkzb4In7C4us/UcrW8jENGOdMzTGiD7yfZXnxy6yd9T
         /KcfzFv6CFV9S+jKyKW1/SkHh7UcDsUUTv6bf2PmpBK+KSjLja89KrIBYJb63ZxjjAN8
         sUJA==
X-Gm-Message-State: AJcUukd2RFDnKowcu98mJRKUpSrxHHCA0D0a/KarhnEEc23z4//4rJHU
        jQ7+KcJNl6h22GjoE4BU7EnaEJ5sYBQDFagxhGw=
X-Google-Smtp-Source: AHgI3Ib+u9y3sOmUKw1EcmZynzwrmSil/eFUpeVWRvp6vW+Skuj0ccGe8Z/p/1OHWiT5WRVrOSDUHOtenH2p8YO3Uqo=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr3761462ioh.271.1548342268977;
 Thu, 24 Jan 2019 07:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-5-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-5-ben.whitten@lairdtech.com>
From:   Ben Whitten <benwhitten@gmail.com>
Date:   Thu, 24 Jan 2019 15:04:17 +0000
Message-ID: <CAF3==isDBZnsx2SswGU8MbEzDJEz3dcjupMLF=+n7mQni8i3bA@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 4/4] dt-bindings: lora: sx130x: add clock bindings
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed linux-lpwan

On Thu, 24 Jan 2019 at 14:53, Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> The SX130x family consumes two clocks, a 32 MHz clock provided by a
> connected IQ transceiver, and a 133 MHz high speed clock.
> It also provides a 32 MHz clock out to the radio in the TX path.
>
> In the example we connect the concentrator to a fixed clock providing
> the 133 MHz high speed clock, and we connect to a connected transceiver
> 32 MHz clock.
>
> A radio in the TX path is also connected to the 32 MHz clock out from the
> concentrator.
>
> The connected radios are both fed from a fixed 32 MHz clock, with only
> one being the clock source back to the SX130x concentrator.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v2 -> v3:
> * Name input clocks specifically
> * Add output clock for radio in TX path
> v1 -> v2:
> * Fixed incorrect usage of clock cells
> * Fixed wording in commit and descriptions
> ---
>  .../bindings/net/lora/semtech,sx130x.yaml     | 52 ++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> index 24fad1218735..5d32668d6ca9 100644
> --- a/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml
> @@ -15,7 +15,9 @@ description: |
>    demodulating LoRa signals on 8 channels simultaneously.
>
>    It is typically paired with two SX125x IQ radios controlled over an
> -  SPI directly from the concentrator.
> +  SPI directly from the concentrator. One of the radios will provide
> +  a 32 MHz clock back into the concentrator.
> +  The concentrator also outputs a 32 MHz clock to the radio(s) in the TX chain.
>
>    The concentrator itself is controlled over SPI.
>
> @@ -37,6 +39,30 @@ properties:
>      maxItems: 1
>      description: A connection of the reset gpio line.
>
> +  clocks:
> +    maxItems: 2
> +    items:
> +      - description: 32 MHz clock provider (CLK32M)
> +      - description: 133 MHz high speed clock provider (CLKHS)
> +    description: The chip requires two clock inputs; A 32MHz clock at CMOS
> +      level which is provided from a connected radio.
> +      And a 133MHz high speed clock at CMOS level provided by an oscillator.
> +
> +  clock-names:
> +    items:
> +      - const: clk32m
> +      - const: clkhs
> +    description: Input clock (CLK32M) name from provider, Input clock (CLKHS)
> +      name from provider.
> +
> +  clock-output-names:
> +    items:
> +      - const: sp_clk_out
> +    description: Output clock (SP_CLK_OUT) typically connected to the TX radio.
> +
> +  '#clock-cells':
> +    const: 0
> +
>    radio-spi:
>      type: object
>      description: The concentrator can have two radios connected which are
> @@ -73,6 +99,20 @@ examples:
>
>      #include <dt-bindings/gpio/gpio.h>
>
> +    tcxo: dummy32m {
> +      compatible = "fixed-clock";
> +      clock-frequency = <32000000>;
> +      clock-output-names = "tcxo";
> +      #clock-cells = <0>;
> +    };
> +
> +    clkhs: dummy133m {
> +      compatible = "fixed-clock";
> +      clock-frequency = <133000000>;
> +      clock-output-names = "clkhs";
> +      #clock-cells = <0>;
> +    };
> +
>      spi {
>        #address-cells = <1>;
>        #size-cells = <0>;
> @@ -82,6 +122,10 @@ examples:
>          reg = <0>;
>          reset-gpios = <&pioB 27 GPIO_ACTIVE_HIGH>;
>          spi-max-frequency = <8000000>;
> +        clocks = <&radio1>, <&clkhs>;
> +        clock-names = "clk32m", "clkhs";
> +        clock-output-names = "sp_clk_out";
> +        #clock-cells = <0>;
>
>          radio-spi {
>            #address-cells = <1>;
> @@ -90,11 +134,17 @@ examples:
>            radio0: radio@0 {
>              compatible = "semtech,sx1257";
>              reg = <0>;
> +            clocks = <&tcxo>, <&concentrator0>;
> +            clock-names = "fxosc", "fclk_in";
>            };
>
>            radio1: radio@1 {
>              compatible = "semtech,sx1257";
>              reg = <1>;
> +            clocks = <&tcxo>;
> +            clock-names = "fxosc";
> +            clock-output-names = "fclk_out";
> +            #clock-cells = <0>;
>            };
>          };
>        };
> --
> 2.17.1
>
