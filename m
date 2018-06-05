Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFEGQr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:16:47 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37244 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeFEGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:44 -0400
From: Nishanth Menon <nm@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 8/8] arm64: dts: ti: k3-am6: Add Secure Proxy instance
Date: Tue, 5 Jun 2018 01:16:29 -0500
Message-ID: <20180605061629.4759-9-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Secure Proxy instances in AM6 family of SoCs.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am6.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
index cdfa12173aac..07e9cc05519c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
@@ -86,6 +86,17 @@
 			};
 		};
 
+		secure_proxy: secure_proxy@32c00000 {
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x0 0x32c00000 0x0 0x100000>,
+			      <0x0 0x32400000 0x0 0x100000>,
+			      <0x0 0x32800000 0x0 0x100000>;
+			interrupt-names = "rx_011";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		wkup_uart0: serial@42300000 {
 			compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
 			reg = <0x0 0x42300000 0x0 0x100>;
-- 
2.15.1
