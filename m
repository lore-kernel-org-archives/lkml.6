Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747CBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1920858
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j236c19d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE1920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeKQKgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbeKQKgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:36:02 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C532146D;
        Sat, 17 Nov 2018 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542414088;
        bh=Z/9HB9ifOQhhnyCN1fkZXxbs7Z2YfN5leD7Xg1ToI3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j236c19d0Tnjn2wYvG1JFaLH9dLV3NLjjFRDExFNV8y1fMm/d9T3Hyu3rkDQQzwuS
         NC/teEhTDai+DkYrqWIORTqSDZkETIYEJtUHzjWPKNxNDcT44RoeukzlRKzgnLSI32
         PHqd34A0eyyZf0QhbdGuIoJmBFV/W2OT/sZ4gVTs=
Received: by mail-wr1-f43.google.com with SMTP id j26-v6so26527193wre.1;
        Fri, 16 Nov 2018 16:21:28 -0800 (PST)
X-Gm-Message-State: AA+aEWYuY/0/oaeXLz+dcpEYT8/53IIu80FgwRmstV0tucNVlrpv5RQA
        ZbobM/kJgOlPTa4H4a7d4BIln9slhZu8Z3+qHI0=
X-Google-Smtp-Source: AFSGD/VxT73VqZ75DTrDtkiKVzzcxeymEXFgI37ih2SCMt0GblkVl38oI7tDyjzKhPGSD+1/qKRBFPFGoDb7hiV8m+Y=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr9431314wro.78.1542414086959;
 Fri, 16 Nov 2018 16:21:26 -0800 (PST)
MIME-Version: 1.0
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com> <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
In-Reply-To: <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Fri, 16 Nov 2018 16:21:15 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrHm-ympV2zAKZKcEfA25aJp8BSS+=01B6G=sP_HiSSdA@mail.gmail.com>
Message-ID: <CAGp9LzrHm-ympV2zAKZKcEfA25aJp8BSS+=01B6G=sP_HiSSdA@mail.gmail.com>
Subject: Re: [v3, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
To:     biao.huang@mediatek.com
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, nelson.chang@mediatek.com,
        andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 1:19 AM Biao Huang <biao.huang@mediatek.com> wrote:
>
> The commit adds the device tree binding documentation for the MediaTek DWMAC
> found on MediaTek MT2712.
>
> Change-Id: I3728666bf65927164bd82fa8dddb90df8270bd44

Drop change-id

> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  .../devicetree/bindings/net/mediatek-dwmac.txt     |   77 ++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
>
> diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> new file mode 100644
> index 0000000..7fd56e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> @@ -0,0 +1,77 @@
> +MediaTek DWMAC glue layer controller
> +
> +This file documents platform glue layer for stmmac.
> +Please see stmmac.txt for the other unchanged properties.
> +
> +The device node has following properties.
> +
> +Required properties:
> +- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
> +- reg:  Address and length of the register set for the device
> +- interrupts:  Should contain the MAC interrupts
> +- interrupt-names: Should contain a list of interrupt names corresponding to
> +       the interrupts in the interrupts property, if available.
> +       Should be "macirq" for the main MAC IRQ
> +- clocks: Must contain a phandle for each entry in clock-names.
> +- clock-names: The name of the clock listed in the clocks property. These are
> +       "axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> +       for MT2712 SoC

About not including these parent clocks to the controller, you can
refer to assigned-clocks, assigned-clock-parents, assigned-clock-rates
noted in Documentation/devicetree/bindings/clock/clock-bindings.txt to
determine what speed these MUXs should be run at and see [1] as the
example how applied in dts.

[1]
https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/mt7623.dtsi#L660

> +- mac-address: See ethernet.txt in the same directory
> +- phy-mode: See ethernet.txt in the same directory
> +
> +Optional properties:
> +- tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> +       It should be defined for rgmii/rgmii-rxid/mii interface.
> +- rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> +       It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> +- fine-tune: This property will select coarse-tune delay or fine delay
> +       for rgmii interface.
what is the property's type?

> +       If fine-tune delay is enabled, tx-delay/rx-delay is 170+/-50ps
> +       per stage.
> +       Else coarse-tune delay is enabled, tx-delay/rx-delay is 0.55+/-0.2ns
> +       per stage.
> +       This property do not apply to non-rgmii PHYs.
> +       Only coarse-tune delay is supported for mii/rmii PHYs.
> +- rmii-rxc: Reference clock of rmii is from external PHYs,
what is the property's type?

> +       and it can be connected to TXC or RXC pin on MT2712 SoC.
> +       If ref_clk <--> TXC, disable it.
> +       Else ref_clk <--> RXC, enable it.
> +- txc-inverse: Inverse tx clock for mii/rgmii.
what is the property's type?

> +       Inverse tx clock inside MAC relative to reference clock for rmii,
> +       and it rarely happen.
> +- rxc-inverse: Inverse rx clock for mii/rgmii interfaces.
what is the property's type?

> +       Inverse reference clock for rmii.

If these optional properties look like generic enough, it would be
good that place them to stmmac.txt. Otherwise, they should be added
"mediatek," as the prefix string for these vendor-specific things.

> +
> +Example:
> +       eth: ethernet@1101c000 {
> +               compatible = "mediatek,mt2712-gmac";
> +               reg = <0 0x1101c000 0 0x1300>;
> +               interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-names = "macirq";
> +               phy-mode ="rgmii-id";
> +               mac-address = [00 55 7b b5 7d f7];
> +               clock-names = "axi",
> +                             "apb",
> +                             "mac_ext",
> +                             "mac_parent",
> +                             "ptp_ref",
> +                             "ptp_parent",
> +                             "ptp_top";
> +               clocks = <&pericfg CLK_PERI_GMAC>,
> +                        <&pericfg CLK_PERI_GMAC_PCLK>,
> +                        <&topckgen CLK_TOP_ETHER_125M_SEL>,
> +                        <&topckgen CLK_TOP_ETHERPLL_125M>,
> +                        <&topckgen CLK_TOP_ETHER_50M_SEL>,
> +                        <&topckgen CLK_TOP_APLL1_D3>,
> +                        <&topckgen CLK_TOP_APLL1>;
> +               snps,txpbl = <32>;
> +               snps,rxpbl = <32>;
> +               snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> +               snps,reset-active-low;
> +               tx-delay = <9>;
> +               rx-delay = <9>;
> +               fine-tune;
> +               rmii-rxc;
> +               txc-inverse;
> +               rxc-inverse;
> +       };
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
