Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF37C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzo+iIuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfAXPEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:04:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38619 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:04:10 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so4959019ioj.5;
        Thu, 24 Jan 2019 07:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVStppILDqJFCatA02SDzdVkHoEqWAQnR0PVTlB9408=;
        b=Wzo+iIuJrfEPnVSnODH526jSVLbZv7QLtpqNIzYIX59aPA2wkfcWFjNKc6xJl0hlLP
         XDFB+ukLaFZaBZn4Hj5T+XMB5MD0s7Ya0E/IM6Hh+G8C/HaJjyzduuAstz4UCcDda1/w
         PHc05qWHH7LRsAaqGIkZcr0zOPQmGtM7FikiJYdEqkG1PZMZj12dTfyC9rEd74IuFAoA
         cqaTJzXUIkKS4k8mUPqwrFgE9RIUJGrkOu5cAeyNLNnA4Xha3rhZmcH2opLxQV8VWEKU
         bJkgF2PIErBNKg+Cd7fmQhsbt2o/4F7A5uQ3cIs0p86uC9XmNYOfYlbGHkzYHtkPE7tr
         1sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVStppILDqJFCatA02SDzdVkHoEqWAQnR0PVTlB9408=;
        b=fmGaU1pUblbcbQIZdEG94J2K2Cchbsd9+C6WzKdv5UuV0ZamCIElJyBMLHHACm3myI
         GDk94jM05UAsr2kBpb95sy7PGj+Iz+pKBbcwg+qDP2/eLcClucAwDiHNfoeLr5j2Z37C
         xDqrNNky4AQsaqFy0gHmzkEwGbtwgoan9yR5Bv1+xV/yw+DuwkXLOUNMaimRIl+PLKmo
         z+pn0tL79DMQrq5TogPRYuX/C4PveLe70WDWztop5Gh585lv0BUVc5EhQcDQ5E4+VUVL
         63Z3UKH2ZJnlj5NYG6vvuoBbllKGgOz3aML3A4DkMv7LGmIpdoZyLn6ftOf4WcaFWAT3
         QqqQ==
X-Gm-Message-State: AHQUAuaQspUPDjzKYi5Qt0HHHhVbYkEUwHw5N0yYV0HuV4RPY3jJKzaE
        TW9RhDXV2hA7mK7tn+BMA2WxiJWY6RplySgs9FQ=
X-Google-Smtp-Source: AHgI3IZ6zUOqSHFxEBHr/oFCyLYpXNgEX1E+6g4Ys+FHh/rsGb6Ht9DLMEMvr1Kwk2DHL4iQLx0QzhrPs44DGceI9Oc=
X-Received: by 2002:a6b:c9ce:: with SMTP id z197mr4049520iof.287.1548342248942;
 Thu, 24 Jan 2019 07:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-4-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-4-ben.whitten@lairdtech.com>
From:   Ben Whitten <benwhitten@gmail.com>
Date:   Thu, 24 Jan 2019 15:03:57 +0000
Message-ID: <CAF3==isnHSCAS=Q7HjUgOgjTyYs=xBbK69J7QUEv7i9kVZjPNg@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 3/4] dt-bindings: lora: sx125x: add clock bindings
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
> The SX125x consumes a clock (FXOSC) ranging from 32 to 36 MHz as its main
> XTAL. It may also consume a clock for the TX synthesizer or DAC input clock
> (FCLK_IN).
> If the radio is coupled with an SX130x the radio is therefor operating in
> master mode and it may also provide a gated version of FXOSC clock for the
> concentrator. In this case the concentrator is expecting a 32 MHz input
> clock.
>
> In the example we connect fxosc to the "txco" clock source, represented by a
> fixed clock. The radio also provides a clock output "fclk_out" for
> consumption by the SX130x concentrator.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v2 -> v3:
> * Name clock inputs and outputs
> * Add FCLK_IN
> v1 -> v2:
> * Fixed incorrect usage of clock cells
> * Fixed wording in commit and descriptions
> * Dropped enforced clock names
> ---
>  .../bindings/net/lora/semtech,sx125x.yaml     | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> index fe2d2a23c28b..be45bcfd97be 100644
> --- a/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> +++ b/Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
> @@ -27,12 +27,41 @@ properties:
>      description: The chip select on the SPI bus or radio number in concentrator
>        , with radio A = 0 and radio B = 1.
>
> +  clocks:
> +    maxItems: 2
> +    description: Input clock (FXOSC) provider with output ranging from 32 MHz
> +      to 36 MHz. TX synthesizer or DAC input clock (FCLK_IN) provider with
> +      output ranging from 32 MHz to 36 MHz.
> +
> +  clock-names:
> +    items:
> +      - const: fxosc
> +      - const: fclk_in
> +    description: Input clock (FXOSC), TX synthesizer or DAC input clock
> +      (FCLK_IN)
> +
> +  clock-output-names:
> +    items:
> +      - const: fclk_out
> +    description: Output clock (FCLK_OUT) name, clock is gated version of the
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
> @@ -40,5 +69,9 @@ examples:
>        radio0: radio@0 {
>          compatible = "semtech,sx1257";
>          reg = <0>;
> +        clocks = <&tcxo>;
> +        clock-names = "fxosc";
> +        clock-output-names = "fclk_out";
> +        #clock-cells = <0>;
>        };
>      };
> --
> 2.17.1
>
