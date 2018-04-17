Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523936673; cv=none;
        d=google.com; s=arc-20160816;
        b=k2ud979tZUfM4/pqOKl1lvh4zullokfSb0VluQkqbKJtdRS1u1ihQAJBjmwT3Qll3k
         mulIG2kYgaV9IWkck3shGnirtBWyeWGDLFqpv+HDXsZtG/WTcnfelo9VkV2thnOJVJ7l
         Et8MU5AzG89ZEmuZ6RFKF+WqaPoS3+E+fNtScDuMS0erZdXVSfZJfXTl6NzVt/3Q+VDY
         k8b2pL1eDbHHx1mTWAcTi97vDMNOf/osOofDJ0izbOBGbrVqSvWbPoD5mua4TaIYEwkC
         YTstXTgGZ1jx31pY8GDfcFHepU5W7DHNHhyhdzVEAIwXy5LofA010DZeKB8uUC0/Cksb
         qEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=eEDwFpf+d22NSlATwj98p3oHlhm5buFo6ft3FtCiemo=;
        b=t2aFCjzAf46sfrkDfCZS97IT2WzmwdwWvM8m6HKN/J/WIINBdARvko2n/rguHRpDSC
         B2gIVKCh1XrjelFUNxaHfyf7XBPpjaOwt3vOJPMBkOFPssr1EQeGCvm+jDk/BXcpEPUl
         HHwc8EObhwFMeE5mNGOZO5Lg6FOYPAfxfUOFXRLoGncKGzWD4aAGm7TPfF3/WkYa+rXv
         VsHTOu5uTEJFrqRjTRMBVJR2By+rWDGLKyp9RbayVnNBDJFTnaW/JVdhwF2wTHhuLZTs
         TUfSOwNpXKL+2QlmBR+Qnh9/ZbS6fgQLPPxNgl3ggVlwZK2VJW64yrzFKwcn4no3dSsl
         intg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx48MnwI5Z71el9Fe9qCxhggL1Szu+BVS1HbvmuWNQiX0hpwc14mdFZogSBmA0+oj4zkPseqR/Q==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linux-foundation.org
Cc: linux-fpga.vger@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atull@kernel.org,
	robh+dt@kernel.org,
	Paolo Pisati <p.pisati@gmail.com>,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/3] dt: bindings: fpga: add lattice machxo2 slave spi binding description
Date: Mon, 16 Apr 2018 20:43:35 -0700
Message-Id: <20180417034337.8855-2-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417034337.8855-1-mdf@kernel.org>
References: <20180417034337.8855-1-mdf@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597963421238496112?=
X-GMAIL-MSGID: =?utf-8?q?1597963421238496112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paolo Pisati <p.pisati@gmail.com>

Add dt binding documentation details for Lattice MachXO2 FPGA configuration
over Slave SPI interface.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../bindings/fpga/lattice-machxo2-spi.txt     | 29 +++++++++++++++++++
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
2.17.0
