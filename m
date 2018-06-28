Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D32A25642
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D32A25642
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeF1Cue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:50:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46257 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeF1Cuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:50:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id r17-v6so4217112edo.13;
        Wed, 27 Jun 2018 19:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=10FHMlxtX3BDDHibvwWvPRJCAd1lWcmxAtkQvprAeGw=;
        b=mLeaj/SJO2u+OhrKMyMkXX2egSsE9RguUmK4waskb4V9CWHUVKgvG34ZLk/S6B9un1
         V75uCDlz9xa2DvfebCC2xF+kOiQp8VeYPDx2kMJwzlqPOiWhuLjcafJnr1pgfYpr/uQV
         ajGBC5ALXC8TPvVyPwD/DWwIWQM0q7dbzW+uOMpptET6vk2WSX3keoQKsKx6/w78/xRT
         /pp5Q21+89I+wHrgnzLbDr8BrSzhHV3P3Awnn+o9YmKkuaD7H0wxMZKUqh5NE9wTiqGH
         6b4Sa9BvejQZQHX2BCwm7Eyg5C6jEaHEXAx5pnjkZFggHWehMNOh/MSgTX2Hzk9EKvZx
         Sz1A==
X-Gm-Message-State: APt69E0ClQelNs4APt5mTjvNHkYHdUUhcjUW4o4PmiRrasBxlZyZGnBl
        tgdbat9RTzkxEOVrt2LBdpb3Ftp1
X-Google-Smtp-Source: AAOMgpcm9pClZYibWaYg9adN7cpPim0uL9YAp4vDLbAYTn7cHTZOD73cxKpLyHM5pMylk3mu9+Rojg==
X-Received: by 2002:a50:9a64:: with SMTP id o91-v6mr7552831edb.173.1530154230614;
        Wed, 27 Jun 2018 19:50:30 -0700 (PDT)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id b15-v6sm2373915eda.88.2018.06.27.19.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:50:30 -0700 (PDT)
Received: by mail-wm0-f53.google.com with SMTP id w137-v6so7839152wmw.1;
        Wed, 27 Jun 2018 19:50:29 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr51020wmc.58.1530154229721;
 Wed, 27 Jun 2018 19:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:50:09
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-24-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-24-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:50:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v66d-L4+TAgOMoPfpK2WAc3LKfprLB7tiAFL4YeL3Ogoow@mail.gmail.com>
Message-ID: <CAGb2v66d-L4+TAgOMoPfpK2WAc3LKfprLB7tiAFL4YeL3Ogoow@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] ARM: dts: sun8i: r40: Add HDMI pipeline
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Add all entries needed for HDMI to function properly.
>
> Since R40 has highly configurable pipeline, both mixers and both TCON
> TVs are added. Board specific DT should then connect them together
> trough TCON TOP muxers to best fit the purpose of the board.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 269 +++++++++++++++++++++++++++++++
>  1 file changed, 269 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index 173dcc1652d2..a2a75fb04caf 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -42,8 +42,11 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun8i-de2.h>
>  #include <dt-bindings/clock/sun8i-r40-ccu.h>
> +#include <dt-bindings/clock/sun8i-tcon-top.h>
>  #include <dt-bindings/reset/sun8i-r40-ccu.h>
> +#include <dt-bindings/reset/sun8i-de2.h>
>
>  / {
>         #address-cells = <1>;
> @@ -99,12 +102,76 @@
>                 };
>         };
>
> +       de: display-engine {
> +               compatible = "allwinner,sun8i-r40-display-engine",
> +                            "allwinner,sun8i-h3-display-engine";

Given that the display pipeline looks different, they should not be
compatible.

> +               allwinner,pipelines = <&mixer0>, <&mixer1>;
> +               status = "disabled";
> +       };
> +
>         soc {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
>
> +               display_clocks: clock@1000000 {
> +                       compatible = "allwinner,sun8i-r40-de2-clk",
> +                                    "allwinner,sun8i-h3-de2-clk";
> +                       reg = <0x01000000 0x100000>;
> +                       clocks = <&ccu CLK_DE>,
> +                                <&ccu CLK_BUS_DE>;
> +                       clock-names = "mod",
> +                                     "bus";
> +                       resets = <&ccu RST_BUS_DE>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
> +               mixer0: mixer@1100000 {
> +                       compatible = "allwinner,sun8i-r40-de2-mixer-0";
> +                       reg = <0x01100000 0x100000>;
> +                       clocks = <&display_clocks CLK_BUS_MIXER0>,
> +                                <&display_clocks CLK_MIXER0>;
> +                       clock-names = "bus",
> +                                     "mod";
> +                       resets = <&display_clocks RST_MIXER0>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               mixer0_out: port@1 {
> +                                       reg = <1>;
> +                                       mixer0_out_tcon_top: endpoint {
> +                                               remote-endpoint = <&tcon_top_mixer0_in_mixer0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               mixer1: mixer@1200000 {
> +                       compatible = "allwinner,sun8i-r40-de2-mixer-1";
> +                       reg = <0x01200000 0x100000>;
> +                       clocks = <&display_clocks CLK_BUS_MIXER1>,
> +                                <&display_clocks CLK_MIXER1>;
> +                       clock-names = "bus",
> +                                     "mod";
> +                       resets = <&display_clocks RST_WB>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               mixer1_out: port@1 {
> +                                       reg = <1>;
> +                                       mixer1_out_tcon_top: endpoint {
> +                                               remote-endpoint = <&tcon_top_mixer1_in_mixer1>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
>                 nmi_intc: interrupt-controller@1c00030 {
>                         compatible = "allwinner,sun7i-a20-sc-nmi";
>                         interrupt-controller;
> @@ -451,6 +518,163 @@
>                         #size-cells = <0>;
>                 };
>
> +               tcon_top: tcon-top@1c70000 {
> +                       compatible = "allwinner,sun8i-r40-tcon-top";
> +                       reg = <0x01c70000 0x1000>;
> +                       clocks = <&ccu CLK_BUS_TCON_TOP>,
> +                                <&ccu CLK_TCON_TV0>,
> +                                <&ccu CLK_TVE0>,
> +                                <&ccu CLK_TCON_TV1>,
> +                                <&ccu CLK_TVE1>,
> +                                <&ccu CLK_DSI_DPHY>;
> +                       clock-names = "bus",
> +                                     "tcon-tv0",
> +                                     "tve0",
> +                                     "tcon-tv1",
> +                                     "tve1",
> +                                     "dsi";
> +                       clock-output-names = "tcon-top-tv0",
> +                                            "tcon-top-tv1",
> +                                            "tcon-top-dsi";
> +                       resets = <&ccu RST_BUS_TCON_TOP>;
> +                       #clock-cells = <1>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               tcon_top_mixer0_in: port@0 {
> +                                       reg = <0>;
> +
> +                                       tcon_top_mixer0_in_mixer0: endpoint {
> +                                               remote-endpoint = <&mixer0_out_tcon_top>;
> +                                       };
> +                               };
> +
> +                               tcon_top_mixer0_out: port@1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +
> +                                       tcon_top_mixer0_out_tcon_lcd0: endpoint@0 {
> +                                               reg = <0>;
> +                                       };
> +
> +                                       tcon_top_mixer0_out_tcon_lcd1: endpoint@1 {
> +                                               reg = <1>;
> +                                       };
> +
> +                                       tcon_top_mixer0_out_tcon_tv0: endpoint@2 {
> +                                               reg = <2>;
> +                                       };
> +
> +                                       tcon_top_mixer0_out_tcon_tv1: endpoint@3 {
> +                                               reg = <3>;
> +                                       };
> +                               };
> +
> +                               tcon_top_mixer1_in: port@2 {
> +                                       reg = <2>;
> +
> +                                       tcon_top_mixer1_in_mixer1: endpoint {
> +                                               remote-endpoint = <&mixer1_out_tcon_top>;
> +                                       };
> +                               };
> +
> +                               tcon_top_mixer1_out: port@3 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <3>;
> +
> +                                       tcon_top_mixer1_out_tcon_lcd0: endpoint@0 {
> +                                               reg = <0>;
> +                                       };
> +
> +                                       tcon_top_mixer1_out_tcon_lcd1: endpoint@1 {
> +                                               reg = <1>;
> +                                       };
> +
> +                                       tcon_top_mixer1_out_tcon_tv0: endpoint@2 {
> +                                               reg = <2>;
> +                                       };
> +
> +                                       tcon_top_mixer1_out_tcon_tv1: endpoint@3 {
> +                                               reg = <3>;
> +                                       };
> +                               };
> +
> +                               tcon_top_hdmi_in: port@4 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <4>;
> +
> +                                       tcon_top_hdmi_in_tcon_tv0: endpoint@0 {
> +                                               reg = <0>;
> +                                       };
> +
> +                                       tcon_top_hdmi_in_tcon_tv1: endpoint@1 {
> +                                               reg = <1>;
> +                                       };
> +                               };
> +
> +                               tcon_top_hdmi_out: port@5 {
> +                                       reg = <5>;
> +
> +                                       tcon_top_hdmi_out_hdmi: endpoint {
> +                                               remote-endpoint = <&hdmi_in_tcon_top>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               tcon_tv0: lcd-controller@1c73000 {
> +                       compatible = "allwinner,sun8i-r40-tcon-tv",
> +                                    "allwinner,sun8i-a83t-tcon-tv";
> +                       reg = <0x01c73000 0x1000>;
> +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top 0>;
> +                       clock-names = "ahb", "tcon-ch1";
> +                       resets = <&ccu RST_BUS_TCON_TV0>;
> +                       reset-names = "lcd";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               tcon_tv0_in: port@0 {
> +                                       reg = <0>;
> +                               };
> +
> +                               tcon_tv0_out: port@1 {
> +                                       reg = <1>;
> +                               };
> +                       };
> +               };
> +
> +               tcon_tv1: lcd-controller@1c74000 {
> +                       compatible = "allwinner,sun8i-r40-tcon-tv",
> +                                    "allwinner,sun8i-a83t-tcon-tv";
> +                       reg = <0x01c74000 0x1000>;
> +                       interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_TCON_TV1>, <&tcon_top 1>;
> +                       clock-names = "ahb", "tcon-ch1";
> +                       resets = <&ccu RST_BUS_TCON_TV1>;
> +                       reset-names = "lcd";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               tcon_tv1_in: port@0 {
> +                                       reg = <0>;
> +                               };
> +
> +                               tcon_tv1_out: port@1 {
> +                                       reg = <1>;

You are missing the remote-endpoints for all the TCON-TOP <-> TCON connections.
Also, on the driver side, there's no code to handle dynamically mapping mixers
to the TCONs that are being used. In the past we had simple 1:1 mappings. This
is no longer the case, and it needs to be dealt with.

ChenYu

> +                               };
> +                       };
> +               };
> +
>                 gic: interrupt-controller@1c81000 {
>                         compatible = "arm,gic-400";
>                         reg = <0x01c81000 0x1000>,
> @@ -461,6 +685,51 @@
>                         #interrupt-cells = <3>;
>                         interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
> +
> +               hdmi: hdmi@1ee0000 {
> +                       compatible = "allwinner,sun8i-r40-dw-hdmi",
> +                                    "allwinner,sun8i-a83t-dw-hdmi";
> +                       reg = <0x01ee0000 0x10000>;
> +                       reg-io-width = <1>;
> +                       interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_HDMI0>, <&ccu CLK_HDMI_SLOW>,
> +                                <&ccu CLK_HDMI>;
> +                       clock-names = "iahb", "isfr", "tmds";
> +                       resets = <&ccu RST_BUS_HDMI1>;
> +                       reset-names = "ctrl";
> +                       phys = <&hdmi_phy>;
> +                       phy-names = "hdmi-phy";
> +                       status = "disabled";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               hdmi_in: port@0 {
> +                                       reg = <0>;
> +
> +                                       hdmi_in_tcon_top: endpoint {
> +                                               remote-endpoint = <&tcon_top_hdmi_out_hdmi>;
> +                                       };
> +                               };
> +
> +                               hdmi_out: port@1 {
> +                                       reg = <1>;
> +                               };
> +                       };
> +               };
> +
> +               hdmi_phy: hdmi-phy@1ef0000 {
> +                       compatible = "allwinner,sun8i-r40-hdmi-phy",
> +                                    "allwinner,sun50i-a64-hdmi-phy";
> +                       reg = <0x01ef0000 0x10000>;
> +                       clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
> +                                <&ccu 7>, <&ccu 16>;
> +                       clock-names = "bus", "mod", "pll-0", "pll-1";
> +                       resets = <&ccu RST_BUS_HDMI0>;
> +                       reset-names = "phy";
> +                       #phy-cells = <0>;
> +               };
>         };
>
>         timer {
> --
> 2.18.0
>
