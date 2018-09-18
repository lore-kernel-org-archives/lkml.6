Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF83ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3859F20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3859F20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIRGo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:44:29 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62658 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725859AbeIRGo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:44:29 -0400
X-UUID: 34823f01a11144788c5b106e753c8ff9-20180918
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1186083808; Tue, 18 Sep 2018 09:14:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 18 Sep
 2018 09:14:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 18 Sep 2018 09:14:19 +0800
Message-ID: <1537233259.12247.3.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] dt-binding: mediatek: Add binding document for
 MediaTek GMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 18 Sep 2018 09:14:19 +0800
In-Reply-To: <fb327132-0830-9df0-434e-06bb0033bac4@cogentembedded.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
         <1537165763-13112-2-git-send-email-biao.huang@mediatek.com>
         <fb327132-0830-9df0-434e-06bb0033bac4@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 11:33 +0300, Sergei Shtylyov wrote:
> On 9/17/2018 9:29 AM, Biao Huang wrote:
> 
> > The commit adds the device tree binding documentation for the MediaTek
> > GMAC found on Mediatek MT2712.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >   .../devicetree/bindings/net/mediatek-gmac.txt      |   45 ++++++++++++++++++++
> >   1 file changed, 45 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/net/mediatek-gmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-gmac.txt b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
> > new file mode 100644
> > index 0000000..14876ed
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-gmac.txt
> > @@ -0,0 +1,45 @@
> > +MediaTek Gigabit Ethernet controller
> > +=========================================
> > +
> > +The gigabit ethernet controller can be found on MediaTek SoCs.
> > +
> > +* Ethernet controller node
> > +
> > +Required properties:
> > +- compatible: Should be
> > +	"mediatek,mt2712-eth": for MT2712 SoC
> > +- reg: Address and length of the register set for the device
> > +- interrupts: Should contain the MAC interrupts
> > +- interrupt-names: the name of interrupt in the interrupts property. These are
> > +	"macirq": For MT2712 SoC
> > +- clocks: the clock used by the controller
> > +- clock-names: the names of the clock listed in the clocks property. These are
> > +	"axi", "apb", "mac_ext", "ptp", "ptp_parent", "ptp_top": For MT2712 SoC
> > +- mac-address: See ethernet.txt in the same directory
> > +- power-domains: phandle to the power domain that the ethernet is part of
> 
>     This (required) prop is absent in your example.
thanks for your comments, power-domains is not a required property, and
I'll modify this property in next version.
> 
> > +- phy-mode: See ethernet.txt file in the same directory.
> > +- reset-gpio: gpio number for phy reset.
> > +
> > +Example:
> > +
> > +eth: eth@1101c000 {
> 
> eth: ethernet@1101c000 {
> 
> > +		compatible = "mediatek,mt2712-eth";
> > +		reg = <0 0x1101c000 0 0x1200>;
> > +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-names = "macirq";
> > +		phy-mode ="rgmii";
> > +		mac-address = [00 55 7b b5 7d f7];
> > +		clock-names = "axi",
> > +			      "apb",
> > +			      "mac_ext",
> > +			      "ptp",
> > +			      "ptp_parent",
> > +			      "ptp_top";
> > +		clocks = <&pericfg CLK_PERI_GMAC>,
> > +			 <&pericfg CLK_PERI_GMAC_PCLK>,
> > +			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
> > +			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
> > +			 <&topckgen CLK_TOP_APLL1_D3>,
> > +			 <&topckgen CLK_TOP_APLL1>;
> > +		reset-gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
> > +	};
> 
> MBR, Sergei
Best Regards!
Biao


