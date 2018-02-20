Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeBTMbG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:31:06 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45364 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBTMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:31:01 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: dmaengine@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] dt-bindings: Document the Synopsys DW AXI DMA bindings
Date: Tue, 20 Feb 2018 15:30:47 +0300
Message-Id: <20180220123047.24469-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180220123047.24469-1-Eugeniy.Paltsev@synopsys.com>
References: <20180220123047.24469-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the Synopsys
DesignWare AXI DMA controller.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
new file mode 100644
index 0000000..f237b79
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
@@ -0,0 +1,41 @@
+Synopsys DesignWare AXI DMA Controller
+
+Required properties:
+- compatible: "snps,axi-dma-1.01a"
+- reg: Address range of the DMAC registers. This should include
+  all of the per-channel registers.
+- interrupt: Should contain the DMAC interrupt number.
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device.
+- dma-channels: Number of channels supported by hardware.
+- snps,dma-masters: Number of AXI masters supported by the hardware.
+- snps,data-width: Maximum AXI data width supported by hardware.
+  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
+- snps,priority: Priority of channel. Array size is equal to the number of
+  dma-channels. Priority value must be programmed within [0:dma-channels-1]
+  range. (0 - minimum priority)
+- snps,block-size: Maximum block size supported by the controller channel.
+  Array size is equal to the number of dma-channels.
+
+Optional properties:
+- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
+  in this property. If this property is missing the maximum AXI burst length
+  supported by DMAC is used. [1:256]
+
+Example:
+
+dmac: dma-controller@80000 {
+	compatible = "snps,axi-dma-1.01a";
+	reg = <0x80000 0x400>;
+	clocks = <&core_clk>, <&cfgr_clk>;
+	clock-names = "core-clk", "cfgr-clk";
+	interrupt-parent = <&intc>;
+	interrupts = <27>;
+
+	dma-channels = <4>;
+	snps,dma-masters = <2>;
+	snps,data-width = <3>;
+	snps,block-size = <4096 4096 4096 4096>;
+	snps,priority = <0 1 2 3>;
+	snps,axi-max-burst-len = <16>;
+};
-- 
2.9.3
