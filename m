Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92474ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 05:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5415208BA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 05:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5415208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeGOFcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 01:32:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54864 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725743AbeGOFcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 01:32:41 -0400
X-UUID: 20c566fc75f94df79515a0c32af67e48-20180715
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1918835454; Sun, 15 Jul 2018 13:10:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sun, 15 Jul 2018 13:10:49 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sun, 15 Jul 2018 13:10:49 +0800
Message-ID: <1531631449.26214.28.camel@mtkswgap22>
Subject: Re: [PATCH v5 1/7] dt-bindings: net: bluetooth: Add
 mediatek-bluetooth
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 15 Jul 2018 13:10:49 +0800
In-Reply-To: <7E55939D-7F8A-4832-9DD5-EFB3B19ACF0B@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
         <d8a5b34513cf2187a2b23a513feaa358d719bc14.1531150733.git.sean.wang@mediatek.com>
         <7E55939D-7F8A-4832-9DD5-EFB3B19ACF0B@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-14 at 18:26 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > Add binding document for a SoC built-in device using MediaTek protocol.
> > Which could be found on MT7622 SoC or other similar MediaTek SoCs.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > .../devicetree/bindings/net/mediatek-bluetooth.txt | 35 ++++++++++++++++++++++
> > 1 file changed, 35 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > new file mode 100644
> > index 0000000..1335429
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> > @@ -0,0 +1,35 @@
> > +MediaTek SoC built-in Bluetooth Devices
> > +==================================
> > +
> > +This device is a serial attached device to BTIF device and thus it must be a
> > +child node of the serial node with BTIF. The dt-bindings details for BTIF
> > +device can be known via Documentation/devicetree/bindings/serial/8250.txt.
> > +
> > +Required properties:
> > +
> > +- compatible:	Must be one of
> > +		  "mediatek,mt7622-bluetooth"": for MT7622 SoC
> 
> this does not match with the example below. And one of, should be normally be a list.
> 

Thanks! I'll remove the words "one of" from the compatible description,
and the extra " being added accidentally.

And the below example fully shows the bluetooth device and its attached
bus (mediatek,mt7622-btif) to let people know clearly how to enable the
bluetooth device.

The current document just describes the bluetooth device and as for the
attached bus, it is already present at
Documentation/devicetree/bindings/serial/8250.txt.

	Sean


> > +- clocks:	Should be the clock specifiers corresponding to the entry in
> > +		clock-names property.
> > +- clock-names:	Should contain "ref" entries.
> > +- power-domains: Phandle to the power domain that the device is part of
> > +
> > +Example:
> > +
> > +	btif: serial@1100c000 {
> > +		compatible = "mediatek,mt7622-btif",
> > +			     "mediatek,mtk-btif";
> > +		reg = <0 0x1100c000 0 0x1000>;
> > +		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&pericfg CLK_PERI_BTIF_PD>;
> > +		clock-names = "main";
> > +		reg-shift = <2>;
> > +		reg-io-width = <4>;
> > +
> > +		bluetooth {
> > +			compatible = "mediatek,mt7622-bluetooth";
> > +			power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
> > +			clocks = <&clk25m>;
> > +			clock-names = "ref";
> > +		};
> > +	};
> 
> Regards
> 
> Marcel
> 


