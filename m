Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-257651-1525244685-2-12441381756316887512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525244684; b=b2WvDXj2xLXKXo+xOlNgAL5ybET98eG8ut3FAo/a0vZIivfG/0
    2MDDZQnZZQ51Kdpq5Ayi4nER8FIEbnaOFuqXbRcYjrQDwFkaEMQbvGtz2QMre/iI
    oZiur9VnGaKwQ0DBmSIs2Rxl8WCbJwJQJKRPyKIPT3TUk6MKA1/mO/ApeDPVZ2qM
    /oXvsTikaGKyu2/rSkJaddOoCV5HgD9C54/mB7/5vgNqdVu/+pnBFFcLUDze4QHN
    I8Wr0C7bvHuStyHhs8LxT/Xj7i70VLfxJi+w5QB4dsH9RRnL6T0fOCGp0qert7qK
    2PgfNb6mdfw63/7EVlwnHuZxKK5751xyDAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525244684; bh=YXXgG0R27V
    bcn3pYc2TkVd/z44YNUj4vQq8NlrepUL8=; b=WjZBuD7xOoB7el7xgNl7Huj0Ie
    mWWR9H/eQzpeJQg5IBpx4VTewGyr7V5QUEVryqs3d6fnp9KFMqw5D3xqets//tq4
    Ff6TetuMw/eyYEN9D/O+6LCQo5jBovPUDYNvFQfQG5OVCzfWzgb/P/34VnS7M4mg
    Gxgm6pns331kTTe6x9Me3gAtfZp0H7S2A3EpN4I/CkaXU13mt+pgUkdGf9YI9GEw
    QggBnv5BhYIVl3uSDPg6Wwrmr60ryLq4R/0XBtvv839gBf5+cUAy8arTQhxTWnYH
    fdKzgXffvRZM5nt5uHe+6p8apTmNL2t7M3n9XIa6WTl21DUUAMGgibiRvfbw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLESlJtulnK7TlOwIgnte5tnezD3g/X2QRKNHekIdi4aRbx7cLpgE1YsUQl+fON/ZPpSiTOU2WJPSQ9xgiRr+nt0a4iMhNHBZ52YyxENaxm2dShW6axC
    U1x4XRAunDwkyESLg22IwN0tbmB8Fux0Egww0VeuCBPPHSKKyms7wcWbqbuDmqdRrCCVcP1dejrW+pbY+hw3Ar5S5SZS0e5L/qfoEPiV0GIEtqDKB0LrR0bR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=gyM0O4V3ZNn9ojZ2YgwA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=7SnK_UgW5Y3FSvhZ:21 a=wwE2GQOhNV4tldSu:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeEBHEa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 03:04:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39238 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750800AbeEBHE2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 03:04:28 -0400
X-UUID: 51e88b18553945cb882e09c440d65c38-20180502
Message-ID: <1525244660.25162.12.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date: Wed, 2 May 2018 15:04:20 +0800
In-Reply-To: <20180501142459.GA10534@rob-hp-laptop>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
         <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
         <20180501142459.GA10534@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,
On Tue, 2018-05-01 at 09:24 -0500, Rob Herring wrote:
> On Wed, Apr 25, 2018 at 03:45:28PM +0800, Chunfeng Yun wrote:
> > Add a DT binding documentation of XS-PHY for MediaTek SoCs
> > with USB3.1 GEN2 controller
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  127 ++++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > new file mode 100644
> > index 0000000..23c51a0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> > @@ -0,0 +1,127 @@
> > +MediaTek XS-PHY binding
> > +--------------------------
> > +
> > +The XS-PHY controller supports physical layer functionality for USB3.1
> > +GEN2 controller on MediaTek SoCs.
> > +
> > +Required properties (controller (parent) node):
> > + - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
> > + 		  soc-model is the name of SoC, such as mt2712 etc;
> 
> Please list all valid SoCs.
Ok
> 
> > +		  when using "mediatek,xsphy" compatible string, you need SoC specific
> > +		  ones in addition.
> > +
> > +Required nodes	: a sub-node is required for each port the controller
> > +		  provides. Address range information including the usual
> > +		  'reg' property is used inside these nodes to describe
> > +		  the controller's topology.
> 
> This should go afer the parent optional properties.
Ok
> 
> > +
> > +Optional properties (controller (parent) node):
> > + - reg		: offset and length of register shared by multiple U3 ports,
> > +		  exclude port's private register, if only U2 ports provided,
> > +		  shouldn't use the property.
> > + - mediatek,src-ref-clk-mhz	: u32, frequency of reference clock for slew rate
> > +		  calibrate
> > + - mediatek,src-coef	: u32, coefficient for slew rate calibrate, depends on
> > +		  SoC process
> > +
> > +Required properties (port (child) node):
> > +- reg		: address and length of the register set for the port.
> > +- clocks	: a list of phandle + clock-specifier pairs, one for each
> > +		  entry in clock-names
> > +- clock-names	: must contain
> > +		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
> > +			reference clock for SuperSpeedPlus analog phy, sometimes is
> > +			24M, 25M or 27M, depended on platform.
> > +- #phy-cells	: should be 1 (See second example)
> > +		  cell after port phandle is phy type from:
> > +			- PHY_TYPE_USB2
> > +			- PHY_TYPE_USB3
> 
> Is the type a property of the connection to the host? If not, this 
> shouldn't be part of the phy cells. I would add compatible strings to 
> the child nodes to define this. I think that would simplify the driver 
> too as then you can parse DT properties in probe rather than phy_init.
Yes, it is.
It's parsed when the phy is got by the host driver.
> 
> > +
> > +The following optional properties are only for debug or HQA test
> > +Optional properties (PHY_TYPE_USB2 port (child) node):
> > +- mediatek,eye-src	: u32, the value of slew rate calibrate
> > +- mediatek,eye-vrt	: u32, the selection of VRT reference voltage
> > +- mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
> > +- mediatek,efuse-intr	: u32, the selection of Internal Resistor
> > +
> > +Optional properties (PHY_TYPE_USB3 port (child) node):
> > +- mediatek,efuse-intr	: u32, the selection of Internal Resistor
> > +- mediatek,efuse-tx-imp	: u32, the selection of TX Impedance
> > +- mediatek,efuse-rx-imp	: u32, the selection of RX Impedance
> > +
> > +Example:
> > +
> > +u3phy: usb-phy@11c40000 {
> > +	compatible = "mediatek,mt36xx-xsphy", "mediatek,xsphy";
> 
> Is mt36xx a specific SoC? Don't use wildcards in compatible strings.
No, will use a specific one

> 
> > +	reg = <0 0x11c43000 0 0x0200>;
> > +	mediatek,src-ref-clk-mhz = <26>;
> > +	mediatek,src-coef = <17>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> 
> Really need 64-bit sizes?
Just an example, 32-bit is also ok, but it's better to use the same
value as the root node
> 
> > +	ranges;
> 
> Limiting the range to only the phy addresses is preferred.
> 
> > +	status = "disabled";
> 
> Don't show status in examples.
Ok
> 
> > +
> > +	u2port0: usb-phy@11c40000 {
> > +		reg = <0 0x11c40000 0 0x0400>;
> > +		clocks = <&clk48m>;
> > +		clock-names = "ref";
> > +		mediatek,eye-src = <4>;
> > +		#phy-cells = <1>;
> > +		status = "okay";
> > +	};
> > +
> > +	u3port0: usb-phy@11c43000 {
> > +		reg = <0 0x11c43400 0 0x0500>;
> > +		clocks = <&clk26m>;
> > +		clock-names = "ref";
> > +		mediatek,efuse-intr = <28>;
> > +		#phy-cells = <1>;
> > +		status = "okay";
> > +	};
> > +};
> > +
> 
> > +Specifying phy control of devices
> > +---------------------------------
> > +
> > +Device nodes should specify the configuration required in their "phys"
> > +property, containing a phandle to the phy port node and a device type;
> > +phy-names for each port are optional.
> > +
> > +Example:
> > +
> > +#include <dt-bindings/phy/phy.h>
> > +
> > +ssusb: usb@112a0000 {
> > +	...
> > +	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
> > +	phy-names = "usb2-0", "usb3-0";
> > +	...
> > +};
> 
> This section is not necessary. We've already explained how to use the 
> phy binding elsewhere.
Will remove it in next version
> 
> > +
> > +
> > +Banks layout of xsphy
> 
> Put this before the example.
Ok

Thanks a lot.
> 
> > +-------------------------------------------------------------
> > +port        offset    bank
> > +u2 port0    0x0000    MISC
> > +            0x0100    FMREG
> > +            0x0300    U2PHY_COM
> > +u2 port1    0x1000    MISC
> > +            0x1100    FMREG
> > +            0x1300    U2PHY_COM
> > +u2 port2    0x2000    MISC
> > +            ...
> > +u31 common  0x3000    DIG_GLB
> > +            0x3100    PHYA_GLB
> > +u31 port0   0x3400    DIG_LN_TOP
> > +            0x3500    DIG_LN_TX0
> > +            0x3600    DIG_LN_RX0
> > +            0x3700    DIG_LN_DAIF
> > +            0x3800    PHYA_LN
> > +u31 port1   0x3a00    DIG_LN_TOP
> > +            0x3b00    DIG_LN_TX0
> > +            0x3c00    DIG_LN_RX0
> > +            0x3d00    DIG_LN_DAIF
> > +            0x3e00    PHYA_LN
> > +            ...
> > +
> > +DIG_GLB & PHYA_GLB are shared by U31 ports.
> > -- 
> > 1.7.9.5
> > 


