Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77265C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AF522538
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AF522538
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeGGDdk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:33:40 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45145 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932635AbeGGDdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:33:39 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 137B964150;
        Sat,  7 Jul 2018 03:33:31 +0000 (UTC)
Date:   Sat, 07 Jul 2018 11:33:12 +0800
In-Reply-To: <CAGb2v663fgFQTHGCMmKwuf4RyW59YSbhtyr5nLBRRxakkEfRzw@mail.gmail.com>
References: <20180706153805.25842-1-icenowy@aosc.io> <20180706153805.25842-4-icenowy@aosc.io> <CAGb2v663fgFQTHGCMmKwuf4RyW59YSbhtyr5nLBRRxakkEfRzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH v2 3/9] arm64: allwinner: dts: h6: add USB2-related device nodes
To:     linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>
CC:     devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <01FABE3C-DA8F-4526-9A6C-C89BDA197316@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月7日 GMT+08:00 上午11:31:39, Chen-Yu Tsai <wens@csie.org> 写到:
>On Fri, Jul 6, 2018 at 11:37 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner H6 has two USB2 ports, one OTG and one host-only.
>>
>> Add device tree nodes related to them.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 90
>++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index c72da8cd9ef5..62fc0f5e10ba 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -174,6 +174,96 @@
>>                         status = "disabled";
>>                 };
>>
>> +               usb2otg: usb@5100000 {
>> +                       compatible = "allwinner,sun8i-a33-musb";
>> +                       reg = <0x05100000 0x0400>;
>> +                       clocks = <&ccu CLK_BUS_OTG>;
>> +                       resets = <&ccu RST_BUS_OTG>;
>> +                       interrupts = <GIC_SPI 23
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       interrupt-names = "mc";
>> +                       phys = <&usb2phy 0>;
>> +                       phy-names = "usb";
>> +                       extcon = <&usb2phy 0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               usb2phy: phy@5100400 {
>> +                       compatible = "allwinner,sun50i-h6-usb-phy";
>> +                       reg = <0x05100400 0x14>,
>> +                             <0x05101800 0x4>,
>> +                             <0x05311800 0x4>;
>> +                       reg-names = "phy_ctrl",
>> +                                   "pmu0",
>> +                                   "pmu3";
>> +                       clocks = <&ccu CLK_USB_PHY0>,
>> +                                <&ccu CLK_USB_PHY3>;
>> +                       clock-names = "usb0_phy",
>> +                                     "usb3_phy";
>> +                       resets = <&ccu RST_USB_PHY0>,
>> +                                <&ccu RST_USB_PHY3>;
>> +                       reset-names = "usb0_reset",
>> +                                     "usb3_reset";
>> +                       status = "disabled";
>> +                       #phy-cells = <1>;
>> +               };
>> +
>> +               ehci0: usb@5101000 {
>> +                       compatible = "allwinner,sun50i-h6-ehci",
>"generic-ehci";
>> +                       reg = <0x05101000 0x100>;
>> +                       interrupts = <GIC_SPI 24
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&ccu CLK_BUS_OHCI0>,
>> +                                <&ccu CLK_BUS_EHCI0>,
>> +                                <&ccu CLK_USB_OHCI0>;
>> +                       resets = <&ccu RST_BUS_OHCI0>,
>> +                                <&ccu RST_BUS_EHCI0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               ohci0: usb@5101400 {
>> +                       compatible = "allwinner,sun50i-h6-ohci",
>"generic-ohci";
>> +                       reg = <0x05101400 0x100>;
>> +                       interrupts = <GIC_SPI 25
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&ccu CLK_BUS_OHCI0>,
>> +                                <&ccu CLK_USB_OHCI0>;
>> +                       resets = <&ccu RST_BUS_OHCI0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               usb3phy: phy@5210000 {
>
>Maybe you should split this one out and put it in the USB 3.0 patch?

Sorry, -EREBASE.

>
>ChenYu
>
>> +                       compatible = "allwinner,sun50i-h6-usb3-phy";
>> +                       reg = <0x5210000 0x10000>;
>> +                       clocks = <&ccu CLK_USB_PHY1>;
>> +                       resets = <&ccu RST_USB_PHY1>;
>> +                       #phy-cells = <0>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               ehci3: usb@5311000 {
>> +                       compatible = "allwinner,sun50i-h6-ehci",
>"generic-ehci";
>> +                       reg = <0x05311000 0x100>;
>> +                       interrupts = <GIC_SPI 28
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&ccu CLK_BUS_OHCI3>,
>> +                                <&ccu CLK_BUS_EHCI3>,
>> +                                <&ccu CLK_USB_OHCI3>;
>> +                       resets = <&ccu RST_BUS_OHCI3>,
>> +                                <&ccu RST_BUS_EHCI3>;
>> +                       phys = <&usb2phy 3>;
>> +                       phy-names = "usb";
>> +                       status = "disabled";
>> +               };
>> +
>> +               ohci3: usb@5311400 {
>> +                       compatible = "allwinner,sun50i-h6-ohci",
>"generic-ohci";
>> +                       reg = <0x05311400 0x100>;
>> +                       interrupts = <GIC_SPI 29
>IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&ccu CLK_BUS_OHCI3>,
>> +                                <&ccu CLK_USB_OHCI3>;
>> +                       resets = <&ccu RST_BUS_OHCI3>;
>> +                       phys = <&usb2phy 3>;
>> +                       phy-names = "usb";
>> +                       status = "disabled";
>> +               };
>> +
>>                 r_ccu: clock@7010000 {
>>                         compatible = "allwinner,sun50i-h6-r-ccu";
>>                         reg = <0x07010000 0x400>;
>> --
>> 2.17.1
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
