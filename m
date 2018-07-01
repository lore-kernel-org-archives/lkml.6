Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D004C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 10:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0882513B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 10:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0882513B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeGAKnX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 06:43:23 -0400
Received: from mailoutvs58.siol.net ([185.57.226.249]:34451 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751628AbeGAKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 06:43:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 164A6520F70;
        Sun,  1 Jul 2018 12:43:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aP9U-iHP6gz6; Sun,  1 Jul 2018 12:43:15 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5F1AD520F72;
        Sun,  1 Jul 2018 12:43:15 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 9C966520F70;
        Sun,  1 Jul 2018 12:43:13 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
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
Subject: Re: [linux-sunxi] Re: [PATCH v3 23/24] ARM: dts: sun8i: r40: Add HDMI pipeline
Date:   Sun, 01 Jul 2018 12:41:44 +0200
Message-ID: <3055462.VmN8MJVs7V@jernej-laptop>
In-Reply-To: <CAGb2v66q3a9nNjkSP1rgh9voMToutDxHtY1x1Wpkf8eEmLWLAA@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <21259128.K3MyN3b6Bq@jernej-laptop> <CAGb2v66q3a9nNjkSP1rgh9voMToutDxHtY1x1Wpkf8eEmLWLAA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 28. junij 2018 ob 08:51:07 CEST je Chen-Yu Tsai napisal(a):
> On Thu, Jun 28, 2018 at 1:15 PM, Jernej Škrabec <jernej.skrabec@siol.net> 
wrote:
> > Dne četrtek, 28. junij 2018 ob 04:50:09 CEST je Chen-Yu Tsai napisal(a):
> >> On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > wrote:
> >> > Add all entries needed for HDMI to function properly.
> >> > 
> >> > Since R40 has highly configurable pipeline, both mixers and both TCON
> >> > TVs are added. Board specific DT should then connect them together
> >> > trough TCON TOP muxers to best fit the purpose of the board.
> >> > 
> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> > ---
> >> > 
> >> >  arch/arm/boot/dts/sun8i-r40.dtsi | 269 +++++++++++++++++++++++++++++++
> >> >  1 file changed, 269 insertions(+)
> >> > 
> >> > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> >> > b/arch/arm/boot/dts/sun8i-r40.dtsi index 173dcc1652d2..a2a75fb04caf
> >> > 100644
> >> > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> >> > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> >> > @@ -42,8 +42,11 @@
> >> > 
> >> >   */
> >> >  
> >> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> > 
> >> > +#include <dt-bindings/clock/sun8i-de2.h>
> >> > 
> >> >  #include <dt-bindings/clock/sun8i-r40-ccu.h>
> >> > 
> >> > +#include <dt-bindings/clock/sun8i-tcon-top.h>
> > 
> > Maxime, above line breaks compilation for build robot, sorry.
> > 
> >> >  #include <dt-bindings/reset/sun8i-r40-ccu.h>
> >> > 
> >> > +#include <dt-bindings/reset/sun8i-de2.h>
> >> > 
> >> >  / {
> >> >  
> >> >         #address-cells = <1>;
> >> > 
> >> > @@ -99,12 +102,76 @@
> >> > 
> >> >                 };
> >> >         
> >> >         };
> >> > 
> >> > +       de: display-engine {
> >> > +               compatible = "allwinner,sun8i-r40-display-engine",
> >> > +                            "allwinner,sun8i-h3-display-engine";
> >> 
> >> Given that the display pipeline looks different, they should not be
> >> compatible.
> > 
> > Ok.
> > 
> >> > +               allwinner,pipelines = <&mixer0>, <&mixer1>;
> >> > +               status = "disabled";
> >> > +       };
> >> > +
> >> > 
> >> >         soc {
> >> >         
> >> >                 compatible = "simple-bus";
> >> >                 #address-cells = <1>;
> >> >                 #size-cells = <1>;
> >> >                 ranges;
> >> > 
> >> > +               display_clocks: clock@1000000 {
> >> > +                       compatible = "allwinner,sun8i-r40-de2-clk",
> >> > +                                    "allwinner,sun8i-h3-de2-clk";
> >> > +                       reg = <0x01000000 0x100000>;
> >> > +                       clocks = <&ccu CLK_DE>,
> >> > +                                <&ccu CLK_BUS_DE>;
> >> > +                       clock-names = "mod",
> >> > +                                     "bus";
> >> > +                       resets = <&ccu RST_BUS_DE>;
> >> > +                       #clock-cells = <1>;
> >> > +                       #reset-cells = <1>;
> >> > +               };
> >> > +
> >> > +               mixer0: mixer@1100000 {
> >> > +                       compatible = "allwinner,sun8i-r40-de2-mixer-0";
> >> > +                       reg = <0x01100000 0x100000>;
> >> > +                       clocks = <&display_clocks CLK_BUS_MIXER0>,
> >> > +                                <&display_clocks CLK_MIXER0>;
> >> > +                       clock-names = "bus",
> >> > +                                     "mod";
> >> > +                       resets = <&display_clocks RST_MIXER0>;
> >> > +
> >> > +                       ports {
> >> > +                               #address-cells = <1>;
> >> > +                               #size-cells = <0>;
> >> > +
> >> > +                               mixer0_out: port@1 {
> >> > +                                       reg = <1>;
> >> > +                                       mixer0_out_tcon_top: endpoint {
> >> > +                                               remote-endpoint =
> >> > <&tcon_top_mixer0_in_mixer0>; +                                      
> >> > };
> >> > +                               };
> >> > +                       };
> >> > +               };
> >> > +
> >> > +               mixer1: mixer@1200000 {
> >> > +                       compatible = "allwinner,sun8i-r40-de2-mixer-1";
> >> > +                       reg = <0x01200000 0x100000>;
> >> > +                       clocks = <&display_clocks CLK_BUS_MIXER1>,
> >> > +                                <&display_clocks CLK_MIXER1>;
> >> > +                       clock-names = "bus",
> >> > +                                     "mod";
> >> > +                       resets = <&display_clocks RST_WB>;
> >> > +
> >> > +                       ports {
> >> > +                               #address-cells = <1>;
> >> > +                               #size-cells = <0>;
> >> > +
> >> > +                               mixer1_out: port@1 {
> >> > +                                       reg = <1>;
> >> > +                                       mixer1_out_tcon_top: endpoint {
> >> > +                                               remote-endpoint =
> >> > <&tcon_top_mixer1_in_mixer1>; +                                      
> >> > };
> >> > +                               };
> >> > +                       };
> >> > +               };
> >> > +
> >> > 
> >> >                 nmi_intc: interrupt-controller@1c00030 {
> >> >                 
> >> >                         compatible = "allwinner,sun7i-a20-sc-nmi";
> >> >                         interrupt-controller;
> >> > 
> >> > @@ -451,6 +518,163 @@
> >> > 
> >> >                         #size-cells = <0>;
> >> >                 
> >> >                 };
> >> > 
> >> > +               tcon_top: tcon-top@1c70000 {
> >> > +                       compatible = "allwinner,sun8i-r40-tcon-top";
> >> > +                       reg = <0x01c70000 0x1000>;
> >> > +                       clocks = <&ccu CLK_BUS_TCON_TOP>,
> >> > +                                <&ccu CLK_TCON_TV0>,
> >> > +                                <&ccu CLK_TVE0>,
> >> > +                                <&ccu CLK_TCON_TV1>,
> >> > +                                <&ccu CLK_TVE1>,
> >> > +                                <&ccu CLK_DSI_DPHY>;
> >> > +                       clock-names = "bus",
> >> > +                                     "tcon-tv0",
> >> > +                                     "tve0",
> >> > +                                     "tcon-tv1",
> >> > +                                     "tve1",
> >> > +                                     "dsi";
> >> > +                       clock-output-names = "tcon-top-tv0",
> >> > +                                            "tcon-top-tv1",
> >> > +                                            "tcon-top-dsi";
> >> > +                       resets = <&ccu RST_BUS_TCON_TOP>;
> >> > +                       #clock-cells = <1>;
> >> > +
> >> > +                       ports {
> >> > +                               #address-cells = <1>;
> >> > +                               #size-cells = <0>;
> >> > +
> >> > +                               tcon_top_mixer0_in: port@0 {
> >> > +                                       reg = <0>;
> >> > +
> >> > +                                       tcon_top_mixer0_in_mixer0:
> >> > endpoint { +
> >> > remote-endpoint = <&mixer0_out_tcon_top>; +
> >> > 
> >> >         };
> >> > 
> >> > +                               };
> >> > +
> >> > +                               tcon_top_mixer0_out: port@1 {
> >> > +                                       #address-cells = <1>;
> >> > +                                       #size-cells = <0>;
> >> > +                                       reg = <1>;
> >> > +
> >> > +                                       tcon_top_mixer0_out_tcon_lcd0:
> >> > endpoint@0 { +                                               reg = <0>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_mixer0_out_tcon_lcd1:
> >> > endpoint@1 { +                                               reg = <1>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_mixer0_out_tcon_tv0:
> >> > endpoint@2 { +                                               reg = <2>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_mixer0_out_tcon_tv1:
> >> > endpoint@3 { +                                               reg = <3>;
> >> > +                                       };
> >> > +                               };
> >> > +
> >> > +                               tcon_top_mixer1_in: port@2 {
> >> > +                                       reg = <2>;
> >> > +
> >> > +                                       tcon_top_mixer1_in_mixer1:
> >> > endpoint { +
> >> > remote-endpoint = <&mixer1_out_tcon_top>; +
> >> > 
> >> >         };
> >> > 
> >> > +                               };
> >> > +
> >> > +                               tcon_top_mixer1_out: port@3 {
> >> > +                                       #address-cells = <1>;
> >> > +                                       #size-cells = <0>;
> >> > +                                       reg = <3>;
> >> > +
> >> > +                                       tcon_top_mixer1_out_tcon_lcd0:
> >> > endpoint@0 { +                                               reg = <0>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_mixer1_out_tcon_lcd1:
> >> > endpoint@1 { +                                               reg = <1>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_mixer1_out_tcon_tv0:
> >> > endpoint@2 { +                                               reg = <2>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_mixer1_out_tcon_tv1:
> >> > endpoint@3 { +                                               reg = <3>;
> >> > +                                       };
> >> > +                               };
> >> > +
> >> > +                               tcon_top_hdmi_in: port@4 {
> >> > +                                       #address-cells = <1>;
> >> > +                                       #size-cells = <0>;
> >> > +                                       reg = <4>;
> >> > +
> >> > +                                       tcon_top_hdmi_in_tcon_tv0:
> >> > endpoint@0 { +                                               reg = <0>;
> >> > +                                       };
> >> > +
> >> > +                                       tcon_top_hdmi_in_tcon_tv1:
> >> > endpoint@1 { +                                               reg = <1>;
> >> > +                                       };
> >> > +                               };
> >> > +
> >> > +                               tcon_top_hdmi_out: port@5 {
> >> > +                                       reg = <5>;
> >> > +
> >> > +                                       tcon_top_hdmi_out_hdmi:
> >> > endpoint {
> >> > +                                               remote-endpoint =
> >> > <&hdmi_in_tcon_top>; +                                       };
> >> > +                               };
> >> > +                       };
> >> > +               };
> >> > +
> >> > +               tcon_tv0: lcd-controller@1c73000 {
> >> > +                       compatible = "allwinner,sun8i-r40-tcon-tv",
> >> > +                                    "allwinner,sun8i-a83t-tcon-tv";
> >> > +                       reg = <0x01c73000 0x1000>;
> >> > +                       interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> >> > +                       clocks = <&ccu CLK_BUS_TCON_TV0>, <&tcon_top
> >> > 0>;
> >> > +                       clock-names = "ahb", "tcon-ch1";
> >> > +                       resets = <&ccu RST_BUS_TCON_TV0>;
> >> > +                       reset-names = "lcd";
> >> > +
> >> > +                       ports {
> >> > +                               #address-cells = <1>;
> >> > +                               #size-cells = <0>;
> >> > +
> >> > +                               tcon_tv0_in: port@0 {
> >> > +                                       reg = <0>;
> >> > +                               };
> >> > +
> >> > +                               tcon_tv0_out: port@1 {
> >> > +                                       reg = <1>;
> >> > +                               };
> >> > +                       };
> >> > +               };
> >> > +
> >> > +               tcon_tv1: lcd-controller@1c74000 {
> >> > +                       compatible = "allwinner,sun8i-r40-tcon-tv",
> >> > +                                    "allwinner,sun8i-a83t-tcon-tv";
> >> > +                       reg = <0x01c74000 0x1000>;
> >> > +                       interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> >> > +                       clocks = <&ccu CLK_BUS_TCON_TV1>, <&tcon_top
> >> > 1>;
> >> > +                       clock-names = "ahb", "tcon-ch1";
> >> > +                       resets = <&ccu RST_BUS_TCON_TV1>;
> >> > +                       reset-names = "lcd";
> >> > +
> >> > +                       ports {
> >> > +                               #address-cells = <1>;
> >> > +                               #size-cells = <0>;
> >> > +
> >> > +                               tcon_tv1_in: port@0 {
> >> > +                                       reg = <0>;
> >> > +                               };
> >> > +
> >> > +                               tcon_tv1_out: port@1 {
> >> > +                                       reg = <1>;
> >> 
> >> You are missing the remote-endpoints for all the TCON-TOP <-> TCON
> >> connections. Also, on the driver side, there's no code to handle
> >> dynamically mapping mixers to the TCONs that are being used. In the past
> >> we
> >> had simple 1:1 mappings. This is no longer the case, and it needs to be
> >> dealt with.
> > 
> > How would TCON TOP driver know how to set muxes? There are no appropriate
> > bingings for muxes, except for V4L2 subsystem, which doesn't really work
> > here.
> This will end up being a bunch of custom functions exported from the TCON
> TOP driver to the TCON driver. As for bindings, the stuff you already have
> is mostly enough. You do have to specify the endpoint ID vs component
> mapping, so you can find the correct one.
> 
> For example, you would specify that the IDs for TCON LCDs be 0 and 1, and
> TCON TVs be 2 and 3. Matching the actual register values is a nice
> convenience. These would be used by the driver as the TCON ID.

So something that's already done (minus full connections).

> 
> Also, we might want to consider them as two pairs of two TCONs (LCD + TV).
> The CRTC in DRM land is actually the mixer + TCON on our platform. This
> means we only have two CRTCs. So we could have CRTC 0 = mixer 0 + TCON LCD
> 0 + TCON TV 0. The "TCON_TVx_OUTSEL" and "DE_PORTx PERH Select" muxes would
> be set at run time in the mode set function, selecting either LCD or TV
> based on what encoder is attached.

That proposal would still limit some combinations. For example, that would put 
DSI always on mixer1, since it can be connected to only LCD TCON 1. It can 
also cause undesired combination in laptop solutions. Consider that PCB 
designer connected LCD1 pins to panel for some reason. Panel is definetly main 
screen and should definetly be connected to mixer0, but in that case, it would 
be to mixer1.

Additionaly, since HDMI would became floating between TV TCON 0 and 1, whoever 
would write board DT would need to know this and enable only TV TCON1 if LCD 
is desired to be connected to mixer0 (or vice versa).

If we really want universal solution with full connections, addtional property 
has to be defined and used for that.

> 
> This limitation is a software one, and should not bleed over into the
> hardware representation.
> 
> > Additionaly, how would HDMI know which TCON belongs to it to appropriately
> > set possible_crtcs?
> 
> HDMI is connected to the two TCON TVs through the TCON TOP mux. We handle
> TCON output muxing in the TCON driver, using the set_mux callback in the
> quirks. For R40, this callback would probably call into the TCON TOP driver
> asking it to set the mux to some value.
> 
> > Currently, my idea is that board DT creates wanted connections. Since
> > there is only one valid connection for each mux, driver knows eactly what
> > to write into mux register. HDMI driver can simply check which TCON
> > connection is valid in HDMI input mux and select it in possible_crtcs.
> 
> But that is not how the actual hardware looks like. The device tree should
> model the hardware, not a subset of it just because one thinks the
> implementation is difficult or won't be used at all.
> 
> Furthermore, I think you have it backwards. possible_crtcs is generated
> based on (in our case) the connections between TCON and HDMI based on the
> device tree graph. So if you have both hooked up, both will show up in
> possible_crtcs, but only one crtc will actually be selected to feed the
> HDMI encoder. If you really need to access the current crtc, the
> drm_encoder struct contains a pointer to it.
> 
> In DE 1.0 driver, we leave all the muxing to the TCON driver. See
> 
>    
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/sun4i_
> tcon.c#L537
> 
> So in a sense, the HDMI encoder should be and is hooked up to both TCONs,
> but only one is active at any given time.

So something like that I had in v1 series. I'll implement something similar. 
That would also mean we need R40 specific TV TCON compatible. I'll restore 
that.

Just a question on future situation when TVE driver will be implemented. 
Suppose that R40 board has TVE0 and HDMI as outputs. This would mean that TVE0 
has possible crtcs set as 0b01 and HDMI 0b11. Will be DRM framework smart 
enough that it will put HDMI on second crtc because TVE0 can be connected to 
only to first crtc?

> 
> > Please also note that mixer0 and mixer1 don't have same capabilities and
> > you generally want mixer0 to be connected to main output. This is in
> > contrast to DE1 SoCs, where both backends and both frontends have same
> > capability.
> Yes. But who's to say the two display outputs can't be reversed or swapped
> around? With fixed singular connections, you also rule out mirrored output.

I don't think there is standard way to swap around mixers at runtime, 
expecially if crtcs are represented as mixer + TCON pair.

I'm not sure what do you mean with mirrored output or at least why singular 
connections would prevent mirroring. HW mirroring needs DRM writeback support 
which is currently in RFC phase if I'm not mistaken. Once implemented in DRM 
framework and in sun4i-drm, it would be possible only to mirror mixer0 -> 
mixer1, because mixer1 doesn't support writeback (at least on existing SoCs).

Best regards,
Jernej

> 
> ChenYu
> 
> >> ChenYu
> >> 
> >> > +                               };
> >> > +                       };
> >> > +               };
> >> > +
> >> > 
> >> >                 gic: interrupt-controller@1c81000 {
> >> >                 
> >> >                         compatible = "arm,gic-400";
> >> >                         reg = <0x01c81000 0x1000>,
> >> > 
> >> > @@ -461,6 +685,51 @@
> >> > 
> >> >                         #interrupt-cells = <3>;
> >> >                         interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4)
> >> >                         |
> >> >                         IRQ_TYPE_LEVEL_HIGH)>;
> >> >                 
> >> >                 };
> >> > 
> >> > +
> >> > +               hdmi: hdmi@1ee0000 {
> >> > +                       compatible = "allwinner,sun8i-r40-dw-hdmi",
> >> > +                                    "allwinner,sun8i-a83t-dw-hdmi";
> >> > +                       reg = <0x01ee0000 0x10000>;
> >> > +                       reg-io-width = <1>;
> >> > +                       interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> >> > +                       clocks = <&ccu CLK_BUS_HDMI0>, <&ccu
> >> > CLK_HDMI_SLOW>, +                                <&ccu CLK_HDMI>;
> >> > +                       clock-names = "iahb", "isfr", "tmds";
> >> > +                       resets = <&ccu RST_BUS_HDMI1>;
> >> > +                       reset-names = "ctrl";
> >> > +                       phys = <&hdmi_phy>;
> >> > +                       phy-names = "hdmi-phy";
> >> > +                       status = "disabled";
> >> > +
> >> > +                       ports {
> >> > +                               #address-cells = <1>;
> >> > +                               #size-cells = <0>;
> >> > +
> >> > +                               hdmi_in: port@0 {
> >> > +                                       reg = <0>;
> >> > +
> >> > +                                       hdmi_in_tcon_top: endpoint {
> >> > +                                               remote-endpoint =
> >> > <&tcon_top_hdmi_out_hdmi>; +                                       };
> >> > +                               };
> >> > +
> >> > +                               hdmi_out: port@1 {
> >> > +                                       reg = <1>;
> >> > +                               };
> >> > +                       };
> >> > +               };
> >> > +
> >> > +               hdmi_phy: hdmi-phy@1ef0000 {
> >> > +                       compatible = "allwinner,sun8i-r40-hdmi-phy",
> >> > +                                    "allwinner,sun50i-a64-hdmi-phy";
> >> > +                       reg = <0x01ef0000 0x10000>;
> >> > +                       clocks = <&ccu CLK_BUS_HDMI1>, <&ccu
> >> > CLK_HDMI_SLOW>, +                                <&ccu 7>, <&ccu 16>;
> >> > +                       clock-names = "bus", "mod", "pll-0", "pll-1";
> >> > +                       resets = <&ccu RST_BUS_HDMI0>;
> >> > +                       reset-names = "phy";
> >> > +                       #phy-cells = <0>;
> >> > +               };
> >> > 
> >> >         };
> >> >         
> >> >         timer {
> >> > 
> >> > --
> >> > 2.18.0
> > 
> > --
> > You received this message because you are subscribed to the Google Groups
> > "linux-sunxi" group. To unsubscribe from this group and stop receiving
> > emails from it, send an email to
> > linux-sunxi+unsubscribe@googlegroups.com. For more options, visit
> > https://groups.google.com/d/optout.




