Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A842145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A842145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbeKPRJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:09:27 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9295 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727370AbeKPRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:09:27 -0500
X-UUID: ea1c98a43e1a4c62b12c0876858d8edc-20181116
X-UUID: ea1c98a43e1a4c62b12c0876858d8edc-20181116
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 177332613; Fri, 16 Nov 2018 14:58:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 16 Nov
 2018 14:58:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 16 Nov 2018 14:58:07 +0800
Message-ID: <1542351487.26982.28.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <davem@davemloft.net>, <honghui.zhang@mediatek.com>,
        <yt.shen@mediatek.com>, <liguo.zhang@mediatek.com>,
        <mark.rutland@arm.com>, <sean.wang@mediatek.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>,
        <andrew@lunn.ch>
Date:   Fri, 16 Nov 2018 14:58:07 +0800
In-Reply-To: <20181112162204.GA8910@bogus>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
         <1540782294-27721-3-git-send-email-biao.huang@mediatek.com>
         <20181112162204.GA8910@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

Thanks for your comments.

On Mon, 2018-11-12 at 10:22 -0600, Rob Herring wrote:
> On Mon, Oct 29, 2018 at 11:04:54AM +0800, Biao Huang wrote:
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >  .../devicetree/bindings/net/mediatek-dwmac.txt     |   49 ++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > new file mode 100644
> > index 0000000..8baf0e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > @@ -0,0 +1,49 @@
> > +MediaTek DWMAC glue layer controller
> > +
> > +This file documents platform glue layer for stmmac.
> > +Please see stmmac.txt for the other unchanged properties.
> > +
> > +The device node has following properties.
> > +
> > +Required properties:
> > +- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
> > +- reg:  Address and length of the register set for the device
> > +- interrupts:  Should contain the MAC interrupts
> > +- interrupt-names: Should contain a list of interrupt names corresponding to
> > +	the interrupts in the interrupts property, if available.
> > +	Should be "macirq" for the main MAC IRQ
> > +- clocks: Must contain a phandle for each entry in clock-names.
> > +- clock-names: the name of the clock listed in the clocks property. These are
> > +	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> > +	for MT2712 SoC
> 
> Clocks should represent the physical clocks connected to a block. Parent 
> clocks are not in that category.
There are two categories of physical clocks related to MAC.
1. axi/apb/ptp_top, these clks are from clk gates, so only on/off is
needed.
2. mac_ext/ptp_ref, these clks are from mux. If different source is
selected, the clk frequecy will be different. So it's necessary to set a
proper parent for them, i.e. mac_parent/ptp_parent.

How should I handle parent clocks if not defined here? Any examples I
can refer to?
> 
> > +- mac-address: See ethernet.txt in the same directory
> > +- phy-mode: See ethernet.txt in the same directory
> > +
> > +Example:
> > +
> > +	eth: ethernet@1101c000 {
> > +		compatible = "mediatek,mt2712-gmac";
> > +		reg = <0 0x1101c000 0 0x1300>;
> > +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-names = "macirq";
> > +		phy-mode ="rgmii-id";
> > +		mac-address = [00 55 7b b5 7d f7];
> > +		clock-names = "axi",
> > +			      "apb",
> > +			      "mac_ext",
> > +			      "mac_parent",
> > +			      "ptp_ref",
> > +			      "ptp_parent",
> > +			      "ptp_top";
> > +		clocks = <&pericfg CLK_PERI_GMAC>,
> > +			 <&pericfg CLK_PERI_GMAC_PCLK>,
> > +			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
> > +			 <&topckgen CLK_TOP_ETHERPLL_125M>,
> > +			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
> > +			 <&topckgen CLK_TOP_APLL1_D3>,
> > +			 <&topckgen CLK_TOP_APLL1>;
> > +		snps,txpbl = <32>;
> > +		snps,rxpbl = <32>;
> > +		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> > +		snps,reset-active-low;
> > +	};
> > -- 
> > 1.7.9.5
> > 
> 
Best Regards!
Biao

