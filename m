Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-318979-1524642392-2-12806942838744179291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524642391; b=o3SZCKoxvWS5/pWt+Om2s9GUaTcSPLyhFLMKGk3lyX0CgLsC2y
    5bx2+fLtNXSsvO3myWSkuCRdVedGD4AgmIVqTwcTkaKdz607q1E45diSbJJ2IF5L
    gRSk6ccDDdT1ozVQwyk1KSmlB2GS02MloKojBTk0bkz6RFqQTBAd8M6xOjbkG34V
    Gbw8v1HjPeo5iv2Lc3Q01kv6ImbD8bGr41dP01yOzTuLFfr/kInyVmf1Xr5+HGvj
    AZXZvedWo5l/XBRiN2axZ1fj3RJxuLtekRA09JK6njE3t9/HksA2OY1gOMVr5aqr
    0lUic6KQek9Qh7kWHv0oThbsX1ulMwWVrUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524642391; bh=iI3igmyzLoT2L+UVA8m4nemJtOj33V
    rMNuh6D/TntTg=; b=e+5kRgVx1hns5HjCF5ntnDninzd4f4SJ8GSm7C+2pLYHbZ
    ipop9HesqyY3VsbnxytK/jIVXz+vVRhKQzHFUWbVzIQ+GJydSmZYRZW5mdh5IT4e
    EAK20ePYSGpeluWVNo0Q3ACajwPzUxH+GsPFfFQGDwe1nG/6XgwzYqLOFtiHYK2s
    wge77ZwVtzFlmgIfJ3TcK5mpJ7wdFQXRleJjFejRn9pAzRHn3tmAz4E0+jvUuCn2
    JfQlam87SWcEdsAfQSclf78pnGB+Eo48WBv8MC4eES/wlYhF2kKu5hswKFnQFSdE
    20mQCJt07xmSnqCcu77F5/pkn+Wn9wgLYOb4TKaA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCJU1eeyQK6KU17oXQaFC+6wimVXzYcjSG6C69lgrMl8BATI6ve/6re8zaCf1DXYYfUrP1TcAIQp4/pWzenx+n/hfboLUUrTJRMChQ+0m/mDfWjyFFDZ
    4NLLS6zJ97lhhEnJC2+d3/i4vmlQxxFKxxfO/06wU4cE6nd8sT9SDklyVQpFy+Y1EAv7Py2AblJbWDYkeS4UQplkK6Tf57L4x81znXSgkEerKluZYnv/nWJP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=oXkLC81caBgp6ArMsckA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=hHTU0fLzfrcxLkXg:21 a=iMfmmfDnEjkoqh0s:21 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDYHqM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 03:46:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10579 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750941AbeDYHpn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 03:45:43 -0400
X-UUID: 35be1802d49343069db366030e923b5c-20180425
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
Subject: [PATCH 1/2] dt-bindings: add MediaTek XS-PHY binding
Date: Wed, 25 Apr 2018 15:45:28 +0800
Message-ID: <1524642329-12255-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
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
 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  127 ++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
new file mode 100644
index 0000000..23c51a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
@@ -0,0 +1,127 @@
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
+		  ones in addition.
+
+Required nodes	: a sub-node is required for each port the controller
+		  provides. Address range information including the usual
+		  'reg' property is used inside these nodes to describe
+		  the controller's topology.
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
+Required properties (port (child) node):
+- reg		: address and length of the register set for the port.
+- clocks	: a list of phandle + clock-specifier pairs, one for each
+		  entry in clock-names
+- clock-names	: must contain
+		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
+			reference clock for SuperSpeedPlus analog phy, sometimes is
+			24M, 25M or 27M, depended on platform.
+- #phy-cells	: should be 1 (See second example)
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
+Example:
+
+u3phy: usb-phy@11c40000 {
+	compatible = "mediatek,mt36xx-xsphy", "mediatek,xsphy";
+	reg = <0 0x11c43000 0 0x0200>;
+	mediatek,src-ref-clk-mhz = <26>;
+	mediatek,src-coef = <17>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+	status = "disabled";
+
+	u2port0: usb-phy@11c40000 {
+		reg = <0 0x11c40000 0 0x0400>;
+		clocks = <&clk48m>;
+		clock-names = "ref";
+		mediatek,eye-src = <4>;
+		#phy-cells = <1>;
+		status = "okay";
+	};
+
+	u3port0: usb-phy@11c43000 {
+		reg = <0 0x11c43400 0 0x0500>;
+		clocks = <&clk26m>;
+		clock-names = "ref";
+		mediatek,efuse-intr = <28>;
+		#phy-cells = <1>;
+		status = "okay";
+	};
+};
+
+Specifying phy control of devices
+---------------------------------
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type;
+phy-names for each port are optional.
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+ssusb: usb@112a0000 {
+	...
+	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+	phy-names = "usb2-0", "usb3-0";
+	...
+};
+
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
-- 
1.7.9.5

