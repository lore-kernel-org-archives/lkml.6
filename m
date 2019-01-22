Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4417020866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548187963;
	bh=9akGmmtaOdopjNkPcQSBQ9Qnp9/7y4w/jQA3+Olur48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xHm259vhnaXxUkzsm5btMYADQqqVkhbJHP9paOPqyuOIh5rFFouKHlHeqlrAE3kxF
	 4CLpubsXagaVdvieIgKgOrymn2UOopEdUhp1VKbOs7WwUY2IXMRWD+tDmlW/u9Ze0k
	 CdY87tB4WrorjwyW7kCf1qiz0MbGUN858C4uLGJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfAVUMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfAVUMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:12:41 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED8821841;
        Tue, 22 Jan 2019 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548187960;
        bh=9akGmmtaOdopjNkPcQSBQ9Qnp9/7y4w/jQA3+Olur48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V1LNpTqNN+UOaqLCkAE9cmgivjzvHfqrjwbIsTgBTQ0RfE5gbLyEy2kx3JVRCAgII
         8/Mstcra0RK/iPsPc7kXClOqT7ypTSbbGq4JvsMwE5RAUKUDRNrr7swhREfacDNWRR
         C3JC9A3hg5v0ou4DcZnt3zjGORoI7WGA0ZHeJwhI=
Received: by mail-qt1-f169.google.com with SMTP id p17so29155465qtl.5;
        Tue, 22 Jan 2019 12:12:39 -0800 (PST)
X-Gm-Message-State: AJcUukdG/wFuhyZEE/ClRaZ6Igimpkv4YhB9WA9pRA+UWF1jUPEhLV8Z
        kJ09qvZmPzYQFEiRxjIXtgy1ptf3J1w3f1le4g==
X-Google-Smtp-Source: ALg8bN6EP1GdwThMzlyo1Q8vlpBEcDXwx4RsCqogkkwwoPdIvUEHAzgCrpAPApWAUuZZK51Hw0PeGNjSsWlBP4YCf0g=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr31281478qvk.106.1548187959020;
 Tue, 22 Jan 2019 12:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20190122180729.1834-1-ben.whitten@lairdtech.com> <20190122180729.1834-4-ben.whitten@lairdtech.com>
In-Reply-To: <20190122180729.1834-4-ben.whitten@lairdtech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Jan 2019 14:12:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJfm6Pbg0CEzfNtd-aXMi8nAwt_8nZA0_Xs=4p1=cB1Kw@mail.gmail.com>
Message-ID: <CAL_JsqJfm6Pbg0CEzfNtd-aXMi8nAwt_8nZA0_Xs=4p1=cB1Kw@mail.gmail.com>
Subject: Re: [PATCH v2 lora-next 3/4] dt-bindings: lora: sx125x: add clock bindings
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-lpwan@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:07 PM Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> The SX125x consumes a clock (FXOSC) ranging from 32 to 36 MHz.
> If the radio is coupled with an SX130x the radio is therefor operating in
> master mode and it may also provide a gated version of this clock for the
> concentrator. In this case the concentrator is expecting a 32 MHz input
> clock.
>
> In the example we connect to the "txco" clock source, represented by a
> fixed clock. The radio also provides a clock output named "clk32m" for
> consumption by the SX130x concentrator.

You can squash the clock patches into the 1st 2 patches if you want.

> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v1 -> v2:
> * Fixed incorrect usage of clock cells
> * Fixed wording in commit and descriptions
> * Dropped enforced clock names
> ---
>  .../bindings/net/lora/semtech,sx125x.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> index 4a51a251d97f..8287472fd545 100644
> --- a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> @@ -27,12 +27,36 @@ properties:
>      description: The chip select on the SPI bus or radio number in concentrator
>        , with radio A = 0 and radio B = 1.
>
> +  clocks:
> +    maxItems: 1
> +    description: Input clock (FXOSC) provider with output ranging from 32 MHz
> +      to 36 MHz.
> +
> +  clock-names:
> +    maxItems: 1

This needs to say what the names are:

items:
  - const: txco

With that, you can drop maxItems as that is implied if we list the items.

Just to be clear, this name should be what the clock input is called,
not what drives the input. Seems like that would be 'fxosc'?

> +    description: Input clock (FXOSC) name from provider.
> +
> +  clock-output-names:
> +    maxItems: 1

This too should list the actual names.

> +    description: Output clock (CLK_OUT) name, clock is gated version of the
> +      input (FXOSC). Used in master mode operation.
> +
> +  '#clock-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
>
>  examples:
>    - |
> +    tcxo: dummy32m {
> +      compatible = "fixed-clock";
> +      clock-frequency = <32000000>;
> +      clock-output-names = "tcxo";
> +      #clock-cells = <0>;
> +    };
> +
>      spi {
>        #address-cells = <1>;
>        #size-cells = <0>;
> @@ -40,5 +64,9 @@ examples:
>        radio0: lora@0 {
>          compatible = "semtech,sx1257";
>          reg = <0>;
> +        clocks = <&tcxo>;
> +        clock-names = "tcxo";
> +        clock-output-names = "clk32m";
> +        #clock-cells = <0>;
>        };
>      };
> --
> 2.17.1
>
