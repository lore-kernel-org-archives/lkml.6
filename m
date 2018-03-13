Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933244AbeCMMPA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:15:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932545AbeCMMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:14:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: rename qcom,pcie devices to pcie
Date: Tue, 13 Mar 2018 13:13:09 +0100
Message-Id: <20180313121345.2749183-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:OBr7e6QjaMLY3Wa9gQR9if9vr9DvweYAvk7VIV+JZyLm4g8rfck
 Lq80Op3px502DRrxqidhAecR68TrB+8MQ+sTI1ADP4uQlYblR5ow5B6DMqS+iYZo7BwHvoB
 SWh3cIlZTHkK0lLd6BhBont4jChDVDE3hC3qfeJ8uedzF5dNkQXKbN3Es0MtGt8tc+f3Tq1
 OlGPaaME2LXUu6DzAJj0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B8XmgY7R5ag=:G0XBUSbNEUiZAfRhWGhtta
 VkTnhx9KQkw8DDNBj+WD1oDXCkYy7nmdqOdmLhbu5zOYzLoeGdNbDvi8X+CCCCaIsf6b7tBsh
 J2/tR88LHgd5vVxgqPknq7XE9YaYJu1f8c1tvz6s4fgCiRiWb6CqHrzfWHY0df0SScdEbOz6G
 ZtMw5fi6b2y7Z5R4rh671ef0Naxx6FTpjsPvn/uLkzWGiIls2awcpG1T6ei9G3uke6rQ1pBWX
 2Wo+bCTu2s+1VK8Bl/qvk1vKCQdloS71e664v3ezTpco/DJuWbLE3nws2p+nihbkTTtbJJ6PE
 slu2DIsToiubWSwdbFshYl+K78pEvHtIbW0l+BdNl370MIRY+1iGMhtlRx6Wcpi4XbLE4q/FO
 RGAIqAe95nwIQEUuxYHgDPrKeAhB0N21vaJo3Jk0LtdfC+R4qYxXNuXA3G+y/Prkw6fyYD5SN
 dCVo5hzJgeZ08b/PxWoiZU+9+FWZAr13nCMK8pe4r3Gl5EAo+aRkNTLp7kzPuCdikyTyjD3/E
 FuLPV5SrBr/14s6nUaAVh6DHwPKJ4m7ReO3saTlOZxxqbFDA+p8CiFUDafu/+eMKKBYxuGAyB
 is1AIqM6VU5IK/QP40Mkx6FyYQGyt6uw881Dd3JPRWv0t5qPUFEhVR5oNwl6ymhwJPJjYyLpo
 y3GbvxBuQMxOSlvFgOLFbp9m/r7daF5oBRAgKSMSFrBy0GEtuHryBi3zxCZBJKFy71xlCbeu5
 W4czUPeTBGIY7p0NDoBYRB9UL8zp4sIPkkH94Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node name for a PCIe host bridge must be "pcie" as required by
the binging. dtc now warns about it:

arch/arm64/boot/dts/qcom/apq8096-db820c.dtb: Warning (pci_bridge): /soc/agnoc@0/qcom,pcie@610000: node name is not "pci" or "pcie"
arch/arm64/boot/dts/qcom/apq8096-db820c.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm64/boot/dts/qcom/msm8996-mtp.dtb: Warning (pci_bridge): /soc/agnoc@0/qcom,pcie@610000: node name is not "pci" or "pcie"
arch/arm64/boot/dts/qcom/msm8996-mtp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'

This renames the nodes as appropriate.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 1c8f1b86472d..e82f821a4e0e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -140,16 +140,16 @@
 		};
 
 		agnoc@0 {
-			qcom,pcie@600000 {
+			pcie@600000 {
 				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
 			};
 
-			qcom,pcie@608000 {
+			pcie@608000 {
 				status = "okay";
 				perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
 			};
 
-			qcom,pcie@610000 {
+			pcie@610000 {
 				status = "okay";
 				perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
 			};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 410ae787ebb4..cd08c8c5248e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -851,7 +851,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			pcie0: qcom,pcie@600000 {
+			pcie0: pcie@600000 {
 				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
 				status = "disabled";
 				power-domains = <&gcc PCIE0_GDSC>;
@@ -904,7 +904,7 @@
 
 			};
 
-			pcie1: qcom,pcie@608000 {
+			pcie1: pcie@608000 {
 				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
 				power-domains = <&gcc PCIE1_GDSC>;
 				bus-range = <0x00 0xff>;
@@ -957,7 +957,7 @@
 						"bus_slave";
 			};
 
-			pcie2: qcom,pcie@610000 {
+			pcie2: pcie@610000 {
 				compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
 				power-domains = <&gcc PCIE2_GDSC>;
 				bus-range = <0x00 0xff>;
-- 
2.9.0
