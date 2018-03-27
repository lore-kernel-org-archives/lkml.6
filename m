Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+eFlxhb/Hwv6GpMV5hfeQ7RQkHvy1WJThyH5hC2iMdlyWnIAdt3js3BKtQl7CIh2xcRajx
ARC-Seal: i=1; a=rsa-sha256; t=1522182209; cv=none;
        d=google.com; s=arc-20160816;
        b=TjG3Ygk+LgklOcSR0r69zayETeEq3/SQjanrYfA4qVbZzU/yPu1c7MNxVT9xP+yP/i
         8aRUk/zFD6v0TYsi4nCY3G8Q8dLK6tCwXfmzZUMNeDmwSVnTiST7d/dRtWhKhA5zPVaW
         tl9f4tPWJALGeGZGlWLz9u/onRKevIiAO3AYLIHKaaw6PJ+srMrk4nVtjdM4o4766Mry
         FF/Xo7kUZmuwhC8lxIhKv0a+YnTJMoirXJhqzBMpO117Bn5jjyT3bSbT/WQw+pV8j3+1
         k66in4sD+rNmJ823J39CV5I63WFCTFPPzo1VVuclq28YyHPvwXdOTBiixCW83LTpDOu9
         zrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2kcOl85RgyISMbFfGpjIXSktPMv+JCebQYGLad0iTK4=;
        b=uu71dRVFrYNboJacYkzSGLo0lBbddteiCLfF5o+vXL9zki9DMnXcUnc0vN6NLEC7Tr
         LDgcJvktVR1zU9gifPAZZkdkApi8/WVYTdrTAopnEW7PSuw59TqwROSisSHOuksVbaxD
         c3NVFuIvQGQUe4o42vGcI8Yo/Ke/ooNcO/AN5WyawpUd39UvY8y7Zs61YbKFGMsMUnIB
         U+l0SRbkvTrf7BIVPQe5zA+9tV9c1xli5ZDgDUUX0GadsperlOqHpfEkAKOfwzG1BLKg
         GQSvYmX2sMCeVZjmeydv5cfNgFVytNskxfs/WJDQZ4vZwKBbSQTVwtFTaj4fhSmLsnNr
         laew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215401383"
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
	richard.gong@linux.intel.com,
	richard.gong@intel.com
Subject: [PATCHv3 2/7] arm64: dts: stratix10: add service driver binding to base dtsi
Date: Tue, 27 Mar 2018 15:20:09 -0500
Message-Id: <1522182014-7338-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123732920575356?=
X-GMAIL-MSGID: =?utf-8?q?1596123732920575356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add Intel Stratix10 service layer to the device tree

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: Change to put service layer driver node under the firmware node
    Change compatible to "intel, stratix10-svc"
v3: No change
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 5a6a699..4395e76 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -24,6 +24,20 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer@0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x1000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -433,5 +447,13 @@
 			resets = <&rst WATCHDOG3_RESET>;
 			status = "disabled";
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,stratix10-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+			};
+		};
 	};
 };
-- 
2.7.4
