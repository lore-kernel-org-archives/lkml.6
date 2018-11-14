Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66CD2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66CD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbeKNUdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:33:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42125 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbeKNUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:33:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so8182196edp.9;
        Wed, 14 Nov 2018 02:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNEjdCVLikpNeeUkQbfxY1fxnsUARJ8Ol2mbOl2f/OY=;
        b=B3ZxKO5QoEckBBv2FtpUBK8b0SCtJWmgoIAgTm/qUtZNVLh3jTXY2xl7H/RAdlP1hC
         ZIzErp7SIpiQQ/pTDV0RyqELxbct9y09u7vse3xI15sEmK3nqUOAqnoFY4tKsS4JwWw8
         GNHPMXKLg5hqC+XrMT1rGMA5j9L7Xi7HbGU1LNKcTH7YYl3ez1SaAOVGVCj8Kei2AE1Q
         OJdEG+8yHga7aC37ioGhZEOreWIM+qAcO7kQ/01UUwmRaG7cYnf6zWxqznoZ5+8X/wrm
         cAM6pN3OEegy8SqLL0j4/PRUXwvEo2X5Pny3yBPEEHhOGL7puHXR3gE7E/NP8owG13OT
         Pniw==
X-Gm-Message-State: AGRZ1gKmUuik36uSfNyXGwACdzH7tEis+iQHCW0rueM0UfRWA/5x6KpT
        AjhG6SQJFWtcCfooyZaSGVvhqbkGx7o=
X-Google-Smtp-Source: AJdET5eznNtoGgcqfDR7yIZJIaRGsGH1VH5rFRsyADHZdA6xDue0txdAD9A7WXCerRRhBW50jojobg==
X-Received: by 2002:a50:d604:: with SMTP id x4-v6mr1565799edi.178.1542191437260;
        Wed, 14 Nov 2018 02:30:37 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ec19-v6sm1566885ejb.11.2018.11.14.02.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 02:30:37 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id z16-v6so16686910wrv.2;
        Wed, 14 Nov 2018 02:30:36 -0800 (PST)
X-Received: by 2002:a5d:4844:: with SMTP id n4-v6mr1391633wrs.28.1542191436517;
 Wed, 14 Nov 2018 02:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20181103123238.4665-1-icenowy@aosc.io> <20181103123238.4665-3-icenowy@aosc.io>
In-Reply-To: <20181103123238.4665-3-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Nov 2018 18:30:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64nj45kYCdn94eEvk+yQZSh5zy8m3=65q1WRR=d1j_Tgw@mail.gmail.com>
Message-ID: <CAGb2v64nj45kYCdn94eEvk+yQZSh5zy8m3=65q1WRR=d1j_Tgw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 2/3] arm64: allwinner: h6: add EMAC
 device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 8:33 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> Allwinner H6 SoC has an EMAC like the one in A64.
>
> Add device tree nodes for the H6 DTSI file.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Dropped unneeded cells property.
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 28 ++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 040828d2e2c0..11f7ce7d1876 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -149,6 +149,14 @@
>                         interrupt-controller;
>                         #interrupt-cells = <3>;
>
> +                       ext_rgmii_pins: rgmii_pins {
> +                               pins = "PD0", "PD1", "PD2", "PD3", "PD4",
> +                                      "PD5", "PD7", "PD8", "PD9", "PD10",
> +                                      "PD11", "PD12", "PD13", "PD19", "PD20";
> +                               function = "emac";
> +                               drive-strength = <40>;
> +                       };
> +
>                         mmc0_pins: mmc0-pins {
>                                 pins = "PF0", "PF1", "PF2", "PF3",
>                                        "PF4", "PF5";
> @@ -258,6 +266,26 @@
>                         status = "disabled";
>                 };
>
> +               emac: ethernet@5020000 {
> +                       compatible = "allwinner,sun50i-a64-emac",
> +                                    "allwinner,sun50i-h6-emac";

These are in the wrong order. Since this is already merged, please send
a fix for it.

ChenYu

> +                       syscon = <&syscon>;
> +                       reg = <0x05020000 0x10000>;
> +                       interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "macirq";
> +                       resets = <&ccu RST_BUS_EMAC>;
> +                       reset-names = "stmmaceth";
> +                       clocks = <&ccu CLK_BUS_EMAC>;
> +                       clock-names = "stmmaceth";
> +                       status = "disabled";
> +
> +                       mdio: mdio {
> +                               compatible = "snps,dwmac-mdio";
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +               };
> +
>                 r_ccu: clock@7010000 {
>                         compatible = "allwinner,sun50i-h6-r-ccu";
>                         reg = <0x07010000 0x400>;
> --
> 2.18.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
