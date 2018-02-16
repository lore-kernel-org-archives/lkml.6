Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeBPJg0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:36:26 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35581 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeBPJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:36:24 -0500
X-Google-Smtp-Source: AH8x225wVIQtlO0pwAvUuGVLVopV8VyICP+RgYGPEglYNI2U+9JiP5Rql1llLcwwN+xx53oWIuveTUKmC0l3EqaSAbo=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2018 10:36:23 +0100
X-Google-Sender-Auth: JWXj0bu2iNv5BCPpb718W80SaLk
Message-ID: <CAMuHMdXQQqRTir-3wgorh_QX060K_CyQNStA46Ph+hnrikqCaw@mail.gmail.com>
Subject: Re: [PATCH 05/15] ARM64: dts: Add R-Car Salvator-x M3-N support
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add initial support for R-Car M3-N Salvator-x and r8a77965 SoC in
> device tree with cpg-mssr, reset and clock nodes.
>
> Add place-holder device nodes for all nodes referred by
> "salvator-common.dtsi"
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi

> +               gic: interrupt-controller@f1010000 {
> +                       compatible = "arm,gic-400";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0x0 0xf1010000 0 0x1000>,
> +                             <0x0 0xf1020000 0 0x20000>,
> +                             <0x0 0xf1040000 0 0x20000>,
> +                             <0x0 0xf1060000 0 0x20000>;
> +                       interrupts = <GIC_PPI 9
> +                                       (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;

Given you have 2 CPU cores, it should say GIC_CPU_MASK_SIMPLE(2).

> +                       clocks = <&cpg CPG_MOD 408>;
> +                       clock-names = "clk";
> +                       power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +                       resets = <&cpg 408>;
> +               };
> +
> +               timer {
> +                       compatible = "arm,armv8-timer";
> +                       interrupts = <GIC_PPI 13
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 14
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 11
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 10
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;

This one is correct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
