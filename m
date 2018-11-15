Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A47A2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKOMWU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:22:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34561 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:22:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id w19-v6so15415029eds.1;
        Wed, 14 Nov 2018 18:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=98XJcJHl+bvavCfgNVS8P5aY6JvD6vg232Yegu2dz6k=;
        b=PNe8N29231+W7Zcq6+4VRtirJi6jIYIxi64+rEX/KzKEwfoJkQHUvKWFBfPGZhMPiS
         w4+ftCbK1manUuU5q7v//poUUTFJJZTp0GxJ/E1+0rYMoVtr+ktGNhPtx5AJfgOFWJE4
         aZ9ZOuROEm0I1KfI1chNIrYCuaTIaCKsi7et1VjF2d6oadmHHvRxyKhx7HyVKwuLVXde
         KrWJlJpcK9lqKlzJfvFwWF08Y374s8pu9xyCLWMLy4d3KUzcljrJmebCj3VzilZCdKTI
         2iOXf5P2i2LeAOtXlByMIo+2Eaqp4DyB+VtgA0/UYL49PtQYpw9SVnaFKLzzDuB3yy3i
         n8SA==
X-Gm-Message-State: AGRZ1gJarWcmc4afjGh1slXUwnXg2xgm4vIjEnMEIA1OSa4NYqCX3Ves
        1+QL+V9Ba0KZTF3brsPmHsQXQwbTpAY=
X-Google-Smtp-Source: AJdET5emYdRHeinriyA5xV2MjNPkuyrT3OWJrjPwW1gNpqxQHt1SIQm9+kDDhZ0VoIQnxtY0de50tA==
X-Received: by 2002:a17:906:c801:: with SMTP id cx1-v6mr3772206ejb.145.1542248186901;
        Wed, 14 Nov 2018 18:16:26 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a35-v6sm7129106ede.69.2018.11.14.18.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 18:16:26 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id j10so5213593wru.4;
        Wed, 14 Nov 2018 18:16:26 -0800 (PST)
X-Received: by 2002:adf:b608:: with SMTP id f8mr3827102wre.120.1542248185903;
 Wed, 14 Nov 2018 18:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20181004122855.22981-1-icenowy@aosc.io> <20181004122855.22981-5-icenowy@aosc.io>
 <CAGb2v668dozjLm9mWUw_Y12AZ6DM2ku9dgQ8B8feABNeFf3QSw@mail.gmail.com> <4B5BD39B-22E2-4DEA-A199-29094DB8C317@aosc.io>
In-Reply-To: <4B5BD39B-22E2-4DEA-A199-29094DB8C317@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 10:16:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Lndq1GMRDda3+2go1snGVS1fKTJTrHpP-B20FtG6VZA@mail.gmail.com>
Message-ID: <CAGb2v66Lndq1GMRDda3+2go1snGVS1fKTJTrHpP-B20FtG6VZA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 04/10] arm64: allwinner: dts: h6: add
 USB2-related device nodes
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 6:31 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> 于 2018年11月14日 GMT+08:00 下午6:21:33, Chen-Yu Tsai <wens@csie.org> 写到:
> >Hi,
> >
> >On Thu, Oct 4, 2018 at 8:30 PM Icenowy Zheng <icenowy@aosc.io> wrote:
> >>
> >> Allwinner H6 has two USB2 ports, one OTG and one host-only.
> >>
> >> Add device tree nodes related to them.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >> No changes in v4.
> >>
> >> Changes in v3:
> >> - Removed the wrongly introduced usb3phy node.
> >> - Added Chen-Yu's Review tag.
> >>
> >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 81
> >++++++++++++++++++++
> >>  1 file changed, 81 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> index 040828d2e2c0..3d60af6cb3ae 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> @@ -258,6 +258,87 @@
> >>                         status = "disabled";
> >>                 };
> >>
> >> +               usb2otg: usb@5100000 {
> >> +                       compatible = "allwinner,sun8i-a33-musb";
> >
> >I added an SoC-specific compatible: "allwinner,sun50i-h6-musb".
> >
> >I'm also curious as to whether the MUSB controller was tested or not,
> >since Allwinner now has EHCI/OHCI host pairs for host mode, and the
> >Pine H64
> >only does host mode.
>
> USB plug-in detection relays on MUSB if it's enabled.

That's not what I meant. Have you actually used the MUSB core in either
device or host mode to know that it is compatible with the A33? And
that it works correctly?

IIRC ID detection is done by the PHY driver, using the GPIO lines.
In host mode, since it's already directly routed to the host pair,
it's the host pair that does plug-in detection. The MUSB core is
completely unused. It should be quite clear if you look at the times
each interrupt line fired.

ChenYu

> >
> >> +                       reg = <0x05100000 0x0400>;
> >> +                       clocks = <&ccu CLK_BUS_OTG>;
> >> +                       resets = <&ccu RST_BUS_OTG>;
> >> +                       interrupts = <GIC_SPI 23
> >IRQ_TYPE_LEVEL_HIGH>;
> >> +                       interrupt-names = "mc";
> >> +                       phys = <&usb2phy 0>;
> >> +                       phy-names = "usb";
> >> +                       extcon = <&usb2phy 0>;
> >> +                       status = "disabled";
> >> +               };
> >> +
> >> +               usb2phy: phy@5100400 {
> >> +                       compatible = "allwinner,sun50i-h6-usb-phy";
> >> +                       reg = <0x05100400 0x14>,
> >> +                             <0x05101800 0x4>,
> >> +                             <0x05311800 0x4>;
> >> +                       reg-names = "phy_ctrl",
> >> +                                   "pmu0",
> >> +                                   "pmu3";
> >> +                       clocks = <&ccu CLK_USB_PHY0>,
> >> +                                <&ccu CLK_USB_PHY3>;
> >> +                       clock-names = "usb0_phy",
> >> +                                     "usb3_phy";
> >> +                       resets = <&ccu RST_USB_PHY0>,
> >> +                                <&ccu RST_USB_PHY3>;
> >> +                       reset-names = "usb0_reset",
> >> +                                     "usb3_reset";
> >> +                       status = "disabled";
> >> +                       #phy-cells = <1>;
> >> +               };
> >> +
> >> +               ehci0: usb@5101000 {
> >> +                       compatible = "allwinner,sun50i-h6-ehci",
> >"generic-ehci";
> >> +                       reg = <0x05101000 0x100>;
> >> +                       interrupts = <GIC_SPI 24
> >IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&ccu CLK_BUS_OHCI0>,
> >> +                                <&ccu CLK_BUS_EHCI0>,
> >> +                                <&ccu CLK_USB_OHCI0>;
> >> +                       resets = <&ccu RST_BUS_OHCI0>,
> >> +                                <&ccu RST_BUS_EHCI0>;
> >> +                       status = "disabled";
> >> +               };
> >> +
> >> +               ohci0: usb@5101400 {
> >> +                       compatible = "allwinner,sun50i-h6-ohci",
> >"generic-ohci";
> >> +                       reg = <0x05101400 0x100>;
> >> +                       interrupts = <GIC_SPI 25
> >IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&ccu CLK_BUS_OHCI0>,
> >> +                                <&ccu CLK_USB_OHCI0>;
> >> +                       resets = <&ccu RST_BUS_OHCI0>;
> >> +                       status = "disabled";
> >> +               };
> >> +
> >> +               ehci3: usb@5311000 {
> >> +                       compatible = "allwinner,sun50i-h6-ehci",
> >"generic-ehci";
> >> +                       reg = <0x05311000 0x100>;
> >> +                       interrupts = <GIC_SPI 28
> >IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&ccu CLK_BUS_OHCI3>,
> >> +                                <&ccu CLK_BUS_EHCI3>,
> >> +                                <&ccu CLK_USB_OHCI3>;
> >> +                       resets = <&ccu RST_BUS_OHCI3>,
> >> +                                <&ccu RST_BUS_EHCI3>;
> >> +                       phys = <&usb2phy 3>;
> >> +                       phy-names = "usb";
> >> +                       status = "disabled";
> >> +               };
> >> +
> >> +               ohci3: usb@5311400 {
> >> +                       compatible = "allwinner,sun50i-h6-ohci",
> >"generic-ohci";
> >> +                       reg = <0x05311400 0x100>;
> >> +                       interrupts = <GIC_SPI 29
> >IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&ccu CLK_BUS_OHCI3>,
> >> +                                <&ccu CLK_USB_OHCI3>;
> >> +                       resets = <&ccu RST_BUS_OHCI3>;
> >> +                       phys = <&usb2phy 3>;
> >> +                       phy-names = "usb";
> >> +                       status = "disabled";
> >> +               };
> >> +
> >
> >This didn't apply cleanly due to the new HDMI nodes. I fixed it up
> >locally.
> >
> >ChenYu
> >
> >>                 r_ccu: clock@7010000 {
> >>                         compatible = "allwinner,sun50i-h6-r-ccu";
> >>                         reg = <0x07010000 0x400>;
> >> --
> >> 2.18.0
> >>
> >> --
> >> You received this message because you are subscribed to the Google
> >Groups "linux-sunxi" group.
> >> To unsubscribe from this group and stop receiving emails from it,
> >send an email to linux-sunxi+unsubscribe@googlegroups.com.
> >> For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
