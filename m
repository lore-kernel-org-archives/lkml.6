Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648891; cv=none;
        d=google.com; s=arc-20160816;
        b=Ap4mN0QuuozlW7PytoeRRzc5D/8HnEPdBUzypyrI7NSnKUlOEwmTYzV1p1YS+tqe/X
         hfRrXlbyD1imJICqV3q0C1SfZVyjKYjB1xN73ygbW4W0/6WvhHflqfiGudZKu1l4fOH0
         iiLSyaCzC6Co9JoscQDVqoD9FCT/Vk71vNjJriAX7JKeJw3v31qlZ/UVR35V6ZQkIPeZ
         GwadupI41YZ9o+hhBgRlHZj53dwNWudLSm2oA6lESyrTHyXQEbjq9cJ6LecRD8DaWPIt
         sSBJXTY+gRMTskXfXnGt4vCpv6T6tP03GezwXiH8EIAwUI0IMzL8sk/sOtFziHFDqVQf
         8BdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TfEIPn5VX8C5OGKBAQhRZa9nBT59yJmePw+gYMW6h1Y=;
        b=kY8bDXkv+CNYfPh1/ywKBtRFKFhUQPUeDQ6q+we7yYDakQ3vOKNGwmmJ2dvbv1bnqj
         W1Os5MLPH8K5kefW/pAXT3FzqyPUnm+sAlZ8tDJSAxZWHfEhcmahXrdWGoL6uWW3bA8d
         uHSWGKpGI4wDVgFbcuSPx27u1hIv8dsp5zAUoOe3bQ3QSn2HkbxOlx5rGv704D7FVTUu
         PFMAoNiK8qPFW/Wj0TogIWv3VJ8z4IQS/xho7sLjyYOtd/OdW6cTjcAbVY7EGcTgdxcQ
         esve9FKGo/8hVroTuQ1SCytpe8UCBzSl/t3UUS9hGQWYxj9dzDGaNBGU3MFGiYKn9Xmb
         M3zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g3mfc5gF;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g3mfc5gF;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvFqr9HYFJ7VwpkK/2INqaTU/JzMg0cFsOy67YmpN+MQLjGXKFKu2a0r7lD7VMQnvwDdgUqkw==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	bgoswami@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	srinivas.kandagatla@linaro.org
Subject: [PATCH v4 23/24] arm64: dts: db820c: add sound card dt entry
Date: Sat, 10 Mar 2018 02:24:55 +0000
Message-Id: <20180310022456.26739-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515932060946930?=
X-GMAIL-MSGID: =?utf-8?q?1594515932060946930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds a sound card entry for basic hdmi playback using adsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 34 +++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 75 +++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 0be734be95f9..d69ffd042835 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -18,6 +18,8 @@
 #include "apq8096-db820c-pmic-pins.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 
 / {
 	aliases {
@@ -222,6 +224,7 @@
 
 				core-vdda-supply = <&pm8994_l12>;
 				core-vcc-supply = <&pm8994_s4>;
+				#sound-dai-cells = <1>;
 			};
 		};
 	};
@@ -397,3 +400,34 @@
 		};
 	};
 };
+
+&sound {
+	compatible = "qcom,apq8096-sndcard";
+	qcom,model = "DB820c";
+	qcom,audio-routing =
+		"RX_BIAS", "MCLK";
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+		platform {
+			sound-dai = <&q6asmdai>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afedai HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6e04827879c0..8fc9354e84c5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/soc/qcom,apr.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8996";
@@ -1560,6 +1561,37 @@
 					      "ref_clk";
 			};
 		};
+
+	        lpass_q6_smmu: arm,smmu-lpass_q6@1600000 {
+			compatible = "qcom,msm8996-smmu-v2";
+	                reg = <0x1600000 0x20000>;
+	                #iommu-cells = <1>;
+                        power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+		        interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>;
+			clock-names = "iface", "bus";
+                        status = "okay";
+		};
+	};
+
+	sound: sound {
+
 	};
 
 	adsp-pil {
@@ -1583,11 +1615,52 @@
 
 		smd-edge {
 			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
-
 			label = "lpass";
 			qcom,ipc = <&apcs 16 8>;
 			qcom,smd-edge = <1>;
 			qcom,remote-pid = <2>;
+
+			apr {
+				compatible = "qcom,apr-v2";
+				qcom,smd-channels = "apr_audio_svc";
+				qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
+
+				q6core {
+					qcom,apr-svc-name = "CORE";
+					qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
+					compatible = "qcom,q6core";
+				};
+
+				q6afe: q6afe {
+					compatible = "qcom,q6afe";
+					qcom,apr-svc-name = "AFE";
+					qcom,apr-svc-id = <APR_SVC_AFE>;
+					q6afedai: dais {
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6asm: q6asm {
+					compatible = "qcom,q6asm";
+					qcom,apr-svc-name = "ASM";
+					qcom,apr-svc-id = <APR_SVC_ASM>;
+					q6asmdai: dais {
+						#sound-dai-cells = <1>;
+						power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+						iommus = <&lpass_q6_smmu 1>;
+					};
+				};
+
+				q6adm: q6adm {
+					compatible = "qcom,q6adm";
+					qcom,apr-svc-name = "ADM";
+					qcom,apr-svc-id = <APR_SVC_ADM>;
+					q6routing: routing {
+						#sound-dai-cells = <0>;
+					};
+				};
+
+			};
 		};
 	};
 
-- 
2.15.1
