Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965431AbeCPPyi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:54:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35770 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754224AbeCPPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:54:33 -0400
X-Google-Smtp-Source: AG47ELtQn1HYVDkA3eU5mHrXsTBJ/msUiU9eYNWYZ55aGU5Ux5DcaqBK6XrDqtp/bWyeb3Q8m8iSSg==
From: Paolo Pisati <p.pisati@gmail.com>
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt: bindings: fpga: add lattice machxo2 slave spi binding description
Date: Fri, 16 Mar 2018 16:54:28 +0100
Message-Id: <1521215669-23874-2-git-send-email-p.pisati@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
References: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding documentation details for Lattice MachXO2 FPGA configuration
over Slave SPI interface.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/fpga/lattice-machxo2-spi.txt          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt

diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
new file mode 100644
index 0000000..a8c362e
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
2.7.4
