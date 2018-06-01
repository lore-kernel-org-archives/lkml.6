Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeFAJOa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:14:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40934 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeFAJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:14:00 -0400
X-Google-Smtp-Source: ADUXVKL/MM0f3GFa9ivskI/Sx3VRQiwAD1WtBUxsHatjQqXycRpw8c6hNQfT3kEXcuwTpUZdtqExnA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        girishm@quicinc.com, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, nicolas.dechesne@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
Date: Fri,  1 Jun 2018 10:11:40 +0100
Message-Id: <20180601091141.26108-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180601091141.26108-1-srinivas.kandagatla@linaro.org>
References: <20180601091141.26108-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Qualcomm SLIMBus NGD controller.
SLIMBus NGD controller is a light-weight driver responsible for
communicating with SLIMBus slaves directly over the bus using messaging
interface and communicating with master component residing on ADSP for
bandwidth and data-channel management

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Craig Tatlor <ctatlor97@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
new file mode 100644
index 000000000000..e94a2ad3a710
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -0,0 +1,84 @@
+Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
+
+SLIMBus NGD controller is a light-weight driver responsible for communicating
+with SLIMBus slaves directly over the bus using messaging interface and
+communicating with master component residing on ADSP for bandwidth and
+data-channel management
+
+Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,slim-ngd-v<MAJOR>.<MINOR>.<STEP>"
+	must be one of the following.
+	"qcom,slim-ngd-v1.5.0" for MSM8996
+	"qcom,slim-ngd-v2.1.0" for SDM845
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the controller
+		    register space.
+- dmas
+	Usage: required
+	Value type: <array of phandles>
+	Definition: List of rx and tx dma channels
+
+- dma-names
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "rx" and "tx".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list controller IRQ.
+
+#address-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 1, reflecting the instance id of ngd.
+
+#size-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 0
+
+= NGD Devices
+Each subnode represents an instance of NGD, must contain the following
+properties:
+
+- reg:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be instance id of ngd.
+
+#address-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+#size-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+= EXAMPLE
+
+slim@91c0000 {
+	compatible = "qcom,slim-ngd-v1.5.0";
+	reg = <0x91c0000 0x2c000>;
+	interrupts = <0 163 0>;
+	dmas =	<&slimbam 3>, <&slimbam 4>;
+	dma-names = "rx", "tx";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ngd@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		codec@1 {
+			compatible = "slim217,1a0";
+			reg  = <1 0>;
+		};
+	};
+};
-- 
2.16.2
