Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeD3PTa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:19:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54115 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752382AbeD3PT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:19:26 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] arm64: dts: hisi: Enable Hisi LPC node for hip06
Date: Mon, 30 Apr 2018 23:15:41 +0800
Message-ID: <1525101342-27120-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
References: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch enables the HiSi LPC node for hip06, with
IPMI and UART child devices.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 ++++++++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
index 9af6330..8ea1335 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -25,6 +25,14 @@
 	chosen { };
 };
 
+&ipmi0 {
+	status = "ok";
+};
+
+&uart0 {
+        status = "ok";
+};
+
 &eth0 {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 35202eb..d78a6a7 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -350,6 +350,27 @@
 		#size-cells = <2>;
 		ranges;
 
+		isa@a01b0000 {
+			compatible = "hisilicon,hip06-lpc";
+			#size-cells = <1>;
+			#address-cells = <2>;
+			reg = <0x0 0xa01b0000 0x0 0x1000>;
+
+			ipmi0: bt@e4 {
+				compatible = "ipmi-bt";
+				device_type = "ipmi";
+				reg = <0x01 0xe4 0x04>;
+				status = "disabled";
+			};
+
+			uart0: lpc-uart@2f8 {
+				compatible = "ns16550a";
+				clock-frequency = <1843200>;
+				reg = <0x01 0x2f8 0x08>;
+				status = "disabled";
+			};
+		};
+
 		refclk: refclk {
 			compatible = "fixed-clock";
 			clock-frequency = <50000000>;
-- 
1.9.1
