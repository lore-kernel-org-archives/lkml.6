Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1523401-1525932684-2-15280141976907594811
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
    1525932659; b=O85DFYpI8ZAKZAo8K+Ca6eZ0MbHZm6e9u9ETo4ApmP3LwcrT/W
    wMkUn+wBXtqvCrE3Zd+DLqZGa7hKirc3lECF06DbX8/aDkajy/1NhGKuQXjz09cB
    a4VobNrR6r8/MGaO4sJpo9DhKgbC1Xw6MeC2k5ngdYgSsv9Zdou7kd8rU4X4xF7T
    PaxzX7zjHgnHYrLezVMJUTpPcAZbIzAL17iR6Cq6yVu68m0KrtOQu2McKXlwPimF
    O5o1yd8cl/DyP3RWxziU5tiSo8SG54xU3TKzZt873oZ51XRdSke2R6PcyO88gahu
    Iz+K//r0AKgBENW2z3ExnptO/ze41XkbK7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525932659; bh=48D9KPqmyKh17gqBmIf/13l1OF1s5T
    92HIMVaU4KsnU=; b=iarRihkLXx0PHjmAy2CtlX9AKTmqPJvCwzc7QQvPRuzDeR
    dnlO1ne12J6pcqKNrqz8IgLZkcCKV3cNdlNA30J6wiM1loVAY2BAtGhdQ1zD8eBi
    6hkZQQqHO+9wiSmlo4aJ2fhhupNBk1ukuHgM4xzHRg65xY8HVcXOBUkr1UsHdOpp
    +AyKtMiLF11ilotQFHUDJl6ANPioshFlO3o6fRukEIYhOM4IKrpQ0v1I8ACpD5YR
    otZrzZJIKimefFlfIEgJXjpUvuDywwnp1YGvBmtZC0TUe7ZaPlyg+oJrZTaVuwcS
    zsbVfZCd5Lh5av6ZjDf2gNhLcy+Vd3JQS9vbsOTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJQVoqQB6lMFF/9tjujWnZKZKwPie7DBMkDiapIidvkkKoqa8dd0AMJY3imvEgHm4x56tp47MyUk21Wijexb3aGNd1itjFrqYkrHjaZa1GODv2dlagpk
    9bp4SZdAMNL/xkiFmXD+aOE3JPaaO0KHFnsnPVQDEgXASswR1wXmI5QrezFszEW9s+JwHexgwboCcF19twI7RRwT9li4qzdII6jImheaP7j81Pp3p773RxKx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=oXkLC81caBgp6ArMsckA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=wlgJe4RvdvBY07QT:21 a=4b5qX6UJXwsoeZqN:21 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756572AbeEJGKr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 02:10:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11407 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756501AbeEJGKo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 02:10:44 -0400
X-UUID: 7a6cb7b1659544889430c5e7b134c90d-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: add MediaTek XS-PHY binding
Date: Thu, 10 May 2018 14:10:28 +0800
Message-ID: <1525932629-10603-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1525932629-10603-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1525932629-10603-1-git-send-email-chunfeng.yun@mediatek.com>
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
index 0000000..7f2b16f
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
+ 		  soc-model is the name of SoC, such as mt3611 etc;
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

