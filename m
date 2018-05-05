Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1046040-1525486547-2-7381136862658823371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525486547; b=kMrZy+nBY+mdqFGX3WGojtF8Tkz0meRoAR8dFxV/7XY2IACxLX
    9YyxA+/iZhUbHo2O/ZbrfvkykHp6AeTWecXn32wOSYdanDSmt0RjTXbrNE/ZQ01I
    wJHxyaAAw65ijC4g/5wrMEiZvSmMjLUSpcHi1JhN9yVkK+Z855tF3eDo44zQAqgu
    qUwUYpo5yBmEez838ZuoX6nmI5ky+lxC/FGF8cq6Ebd+Qh0udqgMwFsDqs2kejpO
    a37x0j896YBx00LJ0UGWrJDgNoYX97qN3jMZ5hoGcRjBOcM+Wpfl12seO1IYGeQz
    LFM9WNvxxrriELuVM8sVGld5eQLOT2Nk3X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525486547; bh=AuaOgq8mnzXwV80JM9x6gusvuG6v7M
    TZwgUpBsowQ5w=; b=GDEYBdyqcfcJmTBTDBvHq8+0x6HEt1VevcTwvZ+DTW6IGw
    Q/QRGimKZwTA7mD+X5Tcen6F/hm9pOGBNQMxEficCgKPNskx5rBLsajEjINnMkSp
    npfsNuBQWNbQaE4jBcpOZaS7CSwi5MX8osWBSk57puu2rttObsQJugAoBsjmKr1A
    z0SI1etxT94DB2ZBO8KcErz3mrbw8QsSfHdiKok4Zej/ifMbAa82eJKQ7qcuIgcZ
    kGfLUOag7+ouUfsesJxgtPywqz4Yl8N+tA0jHsyWnh7BD+dzZgvdD2zRP0bXyzQk
    DfWfxS80U8tzrm7VCbqB9aWZ2CGSYGvQvxjkG46A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDUvVaBv1KtoqTQm8Liw2jZKfEfpj/y7qp65wl20ubYSRBHJL/+jNGWtZTb2EENLmeOaXwrCJ5U1cgte48PHKnAigppOBvbWPmZIxDnS1jvWlu0hCqZ/
    8uio2Yhf5HIZzDaIVuUYHD7SPJVLktMA6CtPnxGsNpwIFLNtXN3myFfo1pvY5yLmEPmbHplONURY2SRW1frBYcz02/1EiFiVdyH4ubfApolBSqnalpp9Uk01
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=oXkLC81caBgp6ArMsckA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=wlgJe4RvdvBY07QT:21 a=4b5qX6UJXwsoeZqN:21 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeEECPT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:15:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751789AbeEECPP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 22:15:15 -0400
X-UUID: c833640e103d4cb491710216e914ed4b-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: add MediaTek XS-PHY binding
Date: Sat, 5 May 2018 10:15:05 +0800
Message-ID: <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a DT binding documentation of XS-PHY for MediaTek SoCs
with USB3.1 GEN2 controller

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  110 ++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
new file mode 100644
index 0000000..9a95fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
@@ -0,0 +1,110 @@
+MediaTek XS-PHY binding
+--------------------------
+
+The XS-PHY controller supports physical layer functionality for USB3.1
+GEN2 controller on MediaTek SoCs.
+
+Required properties (controller (parent) node):
+ - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
+ 		  soc-model is the name of SoC, such as mt2712 etc;
+		  when using "mediatek,xsphy" compatible string, you need SoC specific
+		  ones in addition, one of:
+		  - "mediatek,mt3611-xsphy"
+
+ - #address-cells, #size-cells : should use the same values as the root node
+ - ranges: must be present
+
+Optional properties (controller (parent) node):
+ - reg		: offset and length of register shared by multiple U3 ports,
+		  exclude port's private register, if only U2 ports provided,
+		  shouldn't use the property.
+ - mediatek,src-ref-clk-mhz	: u32, frequency of reference clock for slew rate
+		  calibrate
+ - mediatek,src-coef	: u32, coefficient for slew rate calibrate, depends on
+		  SoC process
+
+Required nodes	: a sub-node is required for each port the controller
+		  provides. Address range information including the usual
+		  'reg' property is used inside these nodes to describe
+		  the controller's topology.
+
+Required properties (port (child) node):
+- reg		: address and length of the register set for the port.
+- clocks	: a list of phandle + clock-specifier pairs, one for each
+		  entry in clock-names
+- clock-names	: must contain
+		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
+			reference clock for SuperSpeedPlus analog phy, sometimes is
+			24M, 25M or 27M, depended on platform.
+- #phy-cells	: should be 1
+		  cell after port phandle is phy type from:
+			- PHY_TYPE_USB2
+			- PHY_TYPE_USB3
+
+The following optional properties are only for debug or HQA test
+Optional properties (PHY_TYPE_USB2 port (child) node):
+- mediatek,eye-src	: u32, the value of slew rate calibrate
+- mediatek,eye-vrt	: u32, the selection of VRT reference voltage
+- mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
+- mediatek,efuse-intr	: u32, the selection of Internal Resistor
+
+Optional properties (PHY_TYPE_USB3 port (child) node):
+- mediatek,efuse-intr	: u32, the selection of Internal Resistor
+- mediatek,efuse-tx-imp	: u32, the selection of TX Impedance
+- mediatek,efuse-rx-imp	: u32, the selection of RX Impedance
+
+Banks layout of xsphy
+-------------------------------------------------------------
+port        offset    bank
+u2 port0    0x0000    MISC
+            0x0100    FMREG
+            0x0300    U2PHY_COM
+u2 port1    0x1000    MISC
+            0x1100    FMREG
+            0x1300    U2PHY_COM
+u2 port2    0x2000    MISC
+            ...
+u31 common  0x3000    DIG_GLB
+            0x3100    PHYA_GLB
+u31 port0   0x3400    DIG_LN_TOP
+            0x3500    DIG_LN_TX0
+            0x3600    DIG_LN_RX0
+            0x3700    DIG_LN_DAIF
+            0x3800    PHYA_LN
+u31 port1   0x3a00    DIG_LN_TOP
+            0x3b00    DIG_LN_TX0
+            0x3c00    DIG_LN_RX0
+            0x3d00    DIG_LN_DAIF
+            0x3e00    PHYA_LN
+            ...
+
+DIG_GLB & PHYA_GLB are shared by U31 ports.
+
+Example:
+
+u3phy: usb-phy@11c40000 {
+	compatible = "mediatek,mt3611-xsphy", "mediatek,xsphy";
+	reg = <0 0x11c43000 0 0x0200>;
+	mediatek,src-ref-clk-mhz = <26>;
+	mediatek,src-coef = <17>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	u2port0: usb-phy@11c40000 {
+		reg = <0 0x11c40000 0 0x0400>;
+		clocks = <&clk48m>;
+		clock-names = "ref";
+		mediatek,eye-src = <4>;
+		#phy-cells = <1>;
+	};
+
+	u3port0: usb-phy@11c43000 {
+		reg = <0 0x11c43400 0 0x0500>;
+		clocks = <&clk26m>;
+		clock-names = "ref";
+		mediatek,efuse-intr = <28>;
+		#phy-cells = <1>;
+	};
+};
+
-- 
1.7.9.5

