Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB3C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B4822539
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B4822539
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbeGGDfr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:35:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42162 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeGGDfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:35:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12-v6so9939078edi.9;
        Fri, 06 Jul 2018 20:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p/0+fCbEcpnZsSRe6IZ6HCBHL3EbBX8LJQIXVzxX+2I=;
        b=l6FKcTvQaDbzgEUyR3kW3Ri3RkgKmT7QufIkzSzabtGKE0SU9xBeTUO0Z4klnfBJDg
         JOqVtXDjYyBsBRo8hg1PQY47HYZIh5PSxuAI22Ga4/pO6w4EUAYrs3WmzRIVHY914Aw2
         2BNk7+uzgXFJX2a9T4jmrEm5VJ4H9s43FEhktcVWSTweiPjOImgtP4a8uzpIgmvxfeac
         mgQhrCjSr7OlZNrUQ1vHTuo0REugotmwrStPA//wQx+UxXGFJUAtzpss06vwxYblW+Q9
         Qc6ArN/tpYSk6mJ/6tYs5OvFyksxDm1Q/56vSYO7C2Qyrnl7V2f7PDhe6Eg6zReihmv2
         MlHw==
X-Gm-Message-State: APt69E28vwP71K6sLbxXAi1L/UBk73cRlYAFbK3Vl+II8tGwBWpKfct7
        aPhLXIm6WBxfu88B8k7ETtBWqyQg
X-Google-Smtp-Source: AAOMgpdoRqGCi78nA5AMqHSqmSH/n0WtvNLWUxX6dgQ0FDEJo+7MnLNol6Eq8OL3M/cXf7LCehjRpg==
X-Received: by 2002:a50:db8d:: with SMTP id p13-v6mr13646237edk.298.1530934543972;
        Fri, 06 Jul 2018 20:35:43 -0700 (PDT)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id u9-v6sm1673445edk.16.2018.07.06.20.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 20:35:43 -0700 (PDT)
Received: by mail-wm0-f53.google.com with SMTP id z6-v6so6653650wma.0;
        Fri, 06 Jul 2018 20:35:43 -0700 (PDT)
X-Received: by 2002:a1c:8c12:: with SMTP id o18-v6mr7260107wmd.120.1530934543475;
 Fri, 06 Jul 2018 20:35:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 20:35:22 -0700 (PDT)
In-Reply-To: <20180706153805.25842-9-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-9-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 7 Jul 2018 11:35:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v67=FeGJ6PJLsru5ScXdTyLdCczQ7BNRmOnh-+4g7iCFqg@mail.gmail.com>
Message-ID: <CAGb2v67=FeGJ6PJLsru5ScXdTyLdCczQ7BNRmOnh-+4g7iCFqg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 8/9] arm64: allwinner: dts: h6: add USB3
 device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:38 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
> a custom PHY.
>
> Add device tree nodes for them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Rebased on top of the USB2 support patch.
> - Dropped the dwc3-of-simple device.
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 62fc0f5e10ba..6738e97ee37f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -229,6 +229,30 @@
>                         status = "disabled";
>                 };
>
> +               dwc3: dwc3 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x5200000 0x10000>;
> +                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +                       /* The only clock is shared. */
> +                       clocks = <&ccu CLK_BUS_XHCI>,
> +                                <&ccu CLK_BUS_XHCI>,
> +                                <&ccu CLK_BUS_XHCI>;
> +                       clock-names = "ref", "bus_early", "suspend";

The diagram in the user manual also shows the low speed 32k oscillator
being fed into DWC3. Maybe someone with more knowledge of what the IP
block expects can give us a clue about which one of these it is.

ChenYu

> +                       resets = <&ccu RST_BUS_XHCI>;
> +                       /*
> +                        * The datasheet of the chip doesn't declare the
> +                        * peripheral function, and there's no boards known
> +                        * to have a USB Type-B port routed to the port.
> +                        * In addition, no one has tested the peripheral
> +                        * function yet.
> +                        * So set the dr_mode to "host" in the DTSI file.
> +                        */
> +                       dr_mode = "host";
> +                       phys = <&usb3phy>;
> +                       phy-names = "usb3-phy";
> +                       status = "disabled";
> +               };
> +
>                 usb3phy: phy@5210000 {
>                         compatible = "allwinner,sun50i-h6-usb3-phy";
>                         reg = <0x5210000 0x10000>;
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
