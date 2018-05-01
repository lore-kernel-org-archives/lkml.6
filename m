Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3231568-1525184717-2-17285934062992064887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525184717; b=WJ68ETcF/uJtk3YiVylK57gb6mcZ9eaVEkdb5UhG240i7b7lOr
    wBMYIUxo/Gkz+VcyE/rONjzxw7RNQzyHH36/rhIT9KoAEPEDQsBYIMcSMKEzLfhR
    MfAFaWSE3Alx8Mk4Zv9xfwcNfz/41nSzYjquulSYDub/9C40Cpqj/SATavZdlP+f
    DNfDfJkzRxowGqi2Y3QwAHfLGXbcgkrUB5odmqgkIV24d1rzlAWSO90DakoizC7Y
    mTCEGELPikz466TZEVLczylNGKr2D7kJ+U7hJZ9eYm7nG4IpBKzBp61Tt8jzyi1Y
    jI/rYIccOqNeS5/KLguGPC7gZR1pUOOVOLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525184717; bh=kDEG4QOb3qMU/NVVo5h6sKIX6N8ti7
    GDcNPI9RSko0E=; b=TRg+31pFmvhK7nxUjLY84ZxlHLKVmINZH3li2bhxAul+w3
    CYlQMOboCZxRBVNtruaOrFSA/ymXX7AXrVuR4iwalSD5FABb1NN4VfuN06yGWUbG
    U2wpCw9RePr4wrzYX+i7kiqYKcQQ2efnFjJNuLifWKcIds2gQhEgVQWyU+YX6itA
    /aBSiAsueR6p7PAUDGaVvUjhk8t2vBmn++0a5YFWVxfkbKOAm++d+gAN84NTaSCU
    KwwNNwA/vZNVoFpspDl1orJt/EmEbePgaXppbhG46xIt+h8Z9KWiYRMw9E64Bnxf
    RhsvMZXx4cHdsgD4tv8sd1IaxHDa9QBqbJ6SLE2A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Qy7pbpUj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Qy7pbpUj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAafZA4OlAOoTOpRII5rV4zEpZGVtX+5RZYx8adAiHqOYvjEqNf9KrzmgFkvyPM3gxP/RrCGF4IBmWhichtdIpE3rgYdUMUhzYM0s7nCVuYmTe50lJnk
    pNxLdEYcqANaG/qpi6+KRFTCWffd04xgtPphWu86AKxb8W8d2JM61t66Ge/jsYHE5APQGeHjhhR57y6x5tEkV+S53NBeuWc43JAAjKlJJVgQC9r5KTvOsze6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=tVaqGy0I8dfdsQBSeVsA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=MZW6jlzsxC-FaFGX:21 a=3ZR1zfXFT3XX5b3R:21
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755993AbeEAOZE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 10:25:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43402 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755877AbeEAOZB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 10:25:01 -0400
X-Google-Smtp-Source: AB8JxZqkZ1WDhm9B81FHQF9Ps4p/BhQFIpXr6skND7shoiCJKGsqpNQ2S8l8FP1TjMoAP3dp4ewIQQ==
Date: Tue, 1 May 2018 09:24:59 -0500
From: Rob Herring <robh@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
Message-ID: <20180501142459.GA10534@rob-hp-laptop>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
 <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 03:45:28PM +0800, Chunfeng Yun wrote:
> Add a DT binding documentation of XS-PHY for MediaTek SoCs
> with USB3.1 GEN2 controller
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  127 ++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> new file mode 100644
> index 0000000..23c51a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> @@ -0,0 +1,127 @@
> +MediaTek XS-PHY binding
> +--------------------------
> +
> +The XS-PHY controller supports physical layer functionality for USB3.1
> +GEN2 controller on MediaTek SoCs.
> +
> +Required properties (controller (parent) node):
> + - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
> + 		  soc-model is the name of SoC, such as mt2712 etc;

Please list all valid SoCs.

> +		  when using "mediatek,xsphy" compatible string, you need SoC specific
> +		  ones in addition.
> +
> +Required nodes	: a sub-node is required for each port the controller
> +		  provides. Address range information including the usual
> +		  'reg' property is used inside these nodes to describe
> +		  the controller's topology.

This should go afer the parent optional properties.

> +
> +Optional properties (controller (parent) node):
> + - reg		: offset and length of register shared by multiple U3 ports,
> +		  exclude port's private register, if only U2 ports provided,
> +		  shouldn't use the property.
> + - mediatek,src-ref-clk-mhz	: u32, frequency of reference clock for slew rate
> +		  calibrate
> + - mediatek,src-coef	: u32, coefficient for slew rate calibrate, depends on
> +		  SoC process
> +
> +Required properties (port (child) node):
> +- reg		: address and length of the register set for the port.
> +- clocks	: a list of phandle + clock-specifier pairs, one for each
> +		  entry in clock-names
> +- clock-names	: must contain
> +		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
> +			reference clock for SuperSpeedPlus analog phy, sometimes is
> +			24M, 25M or 27M, depended on platform.
> +- #phy-cells	: should be 1 (See second example)
> +		  cell after port phandle is phy type from:
> +			- PHY_TYPE_USB2
> +			- PHY_TYPE_USB3

Is the type a property of the connection to the host? If not, this 
shouldn't be part of the phy cells. I would add compatible strings to 
the child nodes to define this. I think that would simplify the driver 
too as then you can parse DT properties in probe rather than phy_init.

> +
> +The following optional properties are only for debug or HQA test
> +Optional properties (PHY_TYPE_USB2 port (child) node):
> +- mediatek,eye-src	: u32, the value of slew rate calibrate
> +- mediatek,eye-vrt	: u32, the selection of VRT reference voltage
> +- mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
> +- mediatek,efuse-intr	: u32, the selection of Internal Resistor
> +
> +Optional properties (PHY_TYPE_USB3 port (child) node):
> +- mediatek,efuse-intr	: u32, the selection of Internal Resistor
> +- mediatek,efuse-tx-imp	: u32, the selection of TX Impedance
> +- mediatek,efuse-rx-imp	: u32, the selection of RX Impedance
> +
> +Example:
> +
> +u3phy: usb-phy@11c40000 {
> +	compatible = "mediatek,mt36xx-xsphy", "mediatek,xsphy";

Is mt36xx a specific SoC? Don't use wildcards in compatible strings.

> +	reg = <0 0x11c43000 0 0x0200>;
> +	mediatek,src-ref-clk-mhz = <26>;
> +	mediatek,src-coef = <17>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;

Really need 64-bit sizes?

> +	ranges;

Limiting the range to only the phy addresses is preferred.

> +	status = "disabled";

Don't show status in examples.

> +
> +	u2port0: usb-phy@11c40000 {
> +		reg = <0 0x11c40000 0 0x0400>;
> +		clocks = <&clk48m>;
> +		clock-names = "ref";
> +		mediatek,eye-src = <4>;
> +		#phy-cells = <1>;
> +		status = "okay";
> +	};
> +
> +	u3port0: usb-phy@11c43000 {
> +		reg = <0 0x11c43400 0 0x0500>;
> +		clocks = <&clk26m>;
> +		clock-names = "ref";
> +		mediatek,efuse-intr = <28>;
> +		#phy-cells = <1>;
> +		status = "okay";
> +	};
> +};
> +

> +Specifying phy control of devices
> +---------------------------------
> +
> +Device nodes should specify the configuration required in their "phys"
> +property, containing a phandle to the phy port node and a device type;
> +phy-names for each port are optional.
> +
> +Example:
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +ssusb: usb@112a0000 {
> +	...
> +	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
> +	phy-names = "usb2-0", "usb3-0";
> +	...
> +};

This section is not necessary. We've already explained how to use the 
phy binding elsewhere.

> +
> +
> +Banks layout of xsphy

Put this before the example.

> +-------------------------------------------------------------
> +port        offset    bank
> +u2 port0    0x0000    MISC
> +            0x0100    FMREG
> +            0x0300    U2PHY_COM
> +u2 port1    0x1000    MISC
> +            0x1100    FMREG
> +            0x1300    U2PHY_COM
> +u2 port2    0x2000    MISC
> +            ...
> +u31 common  0x3000    DIG_GLB
> +            0x3100    PHYA_GLB
> +u31 port0   0x3400    DIG_LN_TOP
> +            0x3500    DIG_LN_TX0
> +            0x3600    DIG_LN_RX0
> +            0x3700    DIG_LN_DAIF
> +            0x3800    PHYA_LN
> +u31 port1   0x3a00    DIG_LN_TOP
> +            0x3b00    DIG_LN_TX0
> +            0x3c00    DIG_LN_RX0
> +            0x3d00    DIG_LN_DAIF
> +            0x3e00    PHYA_LN
> +            ...
> +
> +DIG_GLB & PHYA_GLB are shared by U31 ports.
> -- 
> 1.7.9.5
> 
