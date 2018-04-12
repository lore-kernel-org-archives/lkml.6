Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeDLPOe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeDLPNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:13:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351D42183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
From: Alan Tull <atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v11 1/2] dt: bindings: fpga: add lattice machxo2 slave spi binding description
Date: Thu, 12 Apr 2018 10:13:47 -0500
Message-Id: <20180412151348.4584-2-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180412151348.4584-1-atull@kernel.org>
References: <20180412151348.4584-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Pisati <p.pisati@gmail.com>

Add dt binding documentation details for Lattice MachXO2 FPGA configuration
over Slave SPI interface.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 .../bindings/fpga/lattice-machxo2-spi.txt          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt

diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
new file mode 100644
index 000000000000..a8c362eb160c
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
@@ -0,0 +1,29 @@
+Lattice MachXO2 Slave SPI FPGA Manager
+
+Lattice MachXO2 FPGAs support a method of loading the bitstream over
+'slave SPI' interface.
+
+See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on www.latticesemi.com
+
+Required properties:
+- compatible: should contain "lattice,machxo2-slave-spi"
+- reg: spi chip select of the FPGA
+
+Example for full FPGA configuration:
+
+	fpga-region0 {
+		compatible = "fpga-region";
+		fpga-mgr = <&fpga_mgr_spi>;
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+	};
+
+	spi1: spi@2000 {
+        ...
+
+		fpga_mgr_spi: fpga-mgr@0 {
+			compatible = "lattice,machxo2-slave-spi";
+			spi-max-frequency = <8000000>;
+			reg = <0>;
+		};
+	};
-- 
2.16.2
