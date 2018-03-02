Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELshWWoXYICfUb1alZiys/ZemlvdT0qQPVCnkjPyJT3gkb41IQw5gI4Ti5dRSXL0TXjOPd8G
ARC-Seal: i=1; a=rsa-sha256; t=1519950211; cv=none;
        d=google.com; s=arc-20160816;
        b=Im0rGCe8pj2Y6cQbqE8gbe1Odkm8o7Vc6n+SJUXhqNccx4EL6oYqBoODDSmrOSBFmO
         KB2IoHlPKP+EC+zbiyByO5+rOw0io7KpCmgRNCuuV5SOOCQf56+LKGA5HzBkzcchug7V
         DXaFOCb03MvEpICFAXmeAzwqhGmdWdK3fEmAOzi9Ov0OyW0/GhJ/SrwJhuINblMFal1A
         AmXvUDjgYBwf04ulCuKMpNCskWBPVpiihSesV8pCQSIGXum9zZGYwjEG/CsPYk2xefcW
         jTkfBuFYRg8iikFE4BswGuDdqMQ+8yWSBkbhLWhvUqtD3q5jLx4UAqCoq1GqkrNGGToW
         1c3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8N/OLWTKftJ/vZ4D/EtTIC56SOJtghy+8/wvC8QE01M=;
        b=aqAT/54H9OGnkXOB8AcxMWinxOQ6/BS9NN69AV9fPU3inO3RUKoMAU9CEPEZbNMCfa
         Uqq3qW+HBUDBYaqYoPogsY/uxsPbkrUsgoVqZciV5/8E5mcyLSZO07F7AtDgXEsf57Kz
         6GiXTsySa62OFtMGin/Ub/cpqTtDF/49d6nScJAwRyOcWVM0ZkWJ8FM6kjN4ap5P758j
         W/MvSbkh3vatMd8GSWM/35yTRumi4BffHeUsYulzIFvLhsVDYJZWNTSs527TDzGDLdD4
         Df5GWB9CyE/b0k4ATgEumNusyNxcVjLoadv/0XDptlWI2a0DMcXfOXtHPQ56a66ZrAO2
         zAEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="35279662"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	dinguyen@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	atull@kernel.org,
	mdf@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	richard.gong@linux.intel.com
Subject: [PATCHv2 5/7] arm64: dts: stratix10: add fpga manager and region
Date: Thu,  1 Mar 2018 18:19:33 -0600
Message-Id: <1519949975-13548-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783313515947005?=
X-GMAIL-MSGID: =?utf-8?q?1593783313515947005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add the Stratix10 FPGA manager and a FPGA region to the
device tree.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 4395e76..2f0067e 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -107,6 +107,14 @@
 		interrupt-parent = <&intc>;
 		ranges = <0 0 0 0xffffffff>;
 
+		base_fpga_region {
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+
+			compatible = "fpga-region";
+			fpga-mgr = <&fpga_mgr>;
+		};
+
 		clkmgr: clock-controller@ffd10000 {
 			compatible = "intel,stratix10-clkmgr";
 			reg = <0xffd10000 0x1000>;
@@ -138,6 +146,10 @@
 			};
 		};
 
+		fpga_mgr: fpga-mgr@0 {
+			compatible = "intel,stratix10-soc-fpga-mgr";
+		};
+
 		gmac0: ethernet@ff800000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
 			reg = <0xff800000 0x2000>;
-- 
2.7.4
