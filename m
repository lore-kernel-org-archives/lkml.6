Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968847AbeEXNNo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:13:44 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:48355 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968685AbeEXNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:13:38 -0400
From: Vitaly Andrianov <vitalya@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vitalya@ti.com>, <m-karicheri2@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/3] ARM: dts: k2l: add dts node for k2l hw_rng driver
Date: Thu, 24 May 2018 09:12:17 -0400
Message-ID: <1527167538-29837-3-git-send-email-vitalya@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527167538-29837-1-git-send-email-vitalya@ti.com>
References: <1527167538-29837-1-git-send-email-vitalya@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dts node for k2l hw_random generator driver

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
[t-kristo@ti.com: added missing addresses from node identifiers]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index 9ec8422..a2e47ba 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -208,3 +208,23 @@ netcp: netcp@26000000 {
 		};
 	};
 };
+
+sa_subsys: subsys@26080000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+	ranges = <0 0x26080000 0x40000>;
+
+	sa_config: subsys@0 {
+		compatible = "syscon";
+		reg = <0x0 0x100>;
+	};
+
+	rng@24000 {
+		compatible = "ti,keystone-rng";
+		reg = <0x24000 0x1000>;
+		ti,syscon-sa-cfg = <&sa_config>;
+		clocks = <&clksa>;
+		clock-names = "fck";
+	};
+};
-- 
2.7.4
