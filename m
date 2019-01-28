Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A85C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C550E21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699721;
	bh=minqxleUCdZFINR50Zp2RJs/hYe3aH2rXsBNL59YXVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XrpUQIR6F1KhJIoDjKvtF/EzVn83pODsMnTbU4W4sKH+wQ5xznhbAxzp3purqPpib
	 svoTooAY/XmCnXI1DqZj7BmS12VYiifyy6b/GSuT7hmAkzGtZkUiPjILnDPJZ3WSR5
	 YWu2VaEPvrHkHp85d2HKxGcTspj4rH1Nbl+XeVDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfA1SWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1SV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:21:59 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A27C21741;
        Mon, 28 Jan 2019 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548699718;
        bh=minqxleUCdZFINR50Zp2RJs/hYe3aH2rXsBNL59YXVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ctiozCTDzdmDXWIAkACbpuv0pXLvi371XS/AujWzc8vLZlVrZZm2XQ0+EfEJBZ9rA
         H1Sm5Zmh7hL1oOYfs0iKhRLZc4UHUHtz0TmRMtk6G7CGD6BIjz6BmgBUWcBctgCBIO
         4rrx3lehM7kDQhAvGFegrKSaJbBtIXf/2Ss+LPvg=
Received: by mail-qt1-f169.google.com with SMTP id t13so19360407qtn.3;
        Mon, 28 Jan 2019 10:21:58 -0800 (PST)
X-Gm-Message-State: AJcUukeS4ZgpMV5XQzQrj5EdlYa+lN8XpQJNZ5MEoq789RcbuHJzY7tA
        jWDYgaBgHKH+vqdDX8oFkiNAiqPc9cQ+D4XtNg==
X-Google-Smtp-Source: ALg8bN6lZh62Fp2+/HlsRY4UiL8E/JIqtwWkG9oVmZfYOPJ3RiUqc2l1eKqXn22gzN/1vqgceee4U0uat+DY8iWR0EE=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr21710017qta.38.1548699717383;
 Mon, 28 Jan 2019 10:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-4-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-4-ben.whitten@lairdtech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Jan 2019 12:21:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8GpAd-e0Dv1jjkbXuF+wNw5yhY6u9zxiQwvfxy7Qjiw@mail.gmail.com>
Message-ID: <CAL_JsqL8GpAd-e0Dv1jjkbXuF+wNw5yhY6u9zxiQwvfxy7Qjiw@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 3/4] dt-bindings: lora: sx125x: add clock bindings
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        David Miller <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 8:54 AM Ben Whitten <ben.whitten@gmail.com> wrote:
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

The example has a single clock. Is that valid? If so, then you need to
add minItems and maxItems.

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
