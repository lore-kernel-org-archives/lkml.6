Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965545AbeBMRCA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:02:00 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55589 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965521AbeBMRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:46 -0500
X-Google-Smtp-Source: AH8x2253SYxzHzL8KQ5KRUfyKKnpO/ghgpG/AGTDZyiwxTKFhrCE7Rjq26XTRmoSLVisxz6hb9PsWQ==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 23/25] dt-bindings: sound: qcom: Add devicetree bindings for apq8096
Date: Tue, 13 Feb 2018 16:58:35 +0000
Message-Id: <20180213165837.1620-24-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt     | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 000000000000..58cd506477c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,89 @@
+* Qualcomm Technologies APQ8096 ASoC sound card driver
+
+This binding describes the APQ8096 sound card, which uses qdsp for audio.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apq8096-sndcard"
+
+- qcom,audio-routing:
+	Usage: Optional
+	Value type: <stringlist>
+	Definition:  A list of the connections between audio components.
+		  Each entry is a pair of strings, the first being the
+		  connection's sink, the second being the connection's
+		  source. Valid names could be power supplies, MicBias
+		  of codec and the jacks on the board:
+
+= FRONTEND and BACKEND dailinks
+Each subnode of sndcard represents either frontend or backend dailink,
+and subnodes of each backend/frontend dailinks would be
+cpu/codec/platform dais.
+
+- link-name:
+	Usage: required
+	Value type: <string>
+	Definition: User friendly name for dai link
+
+- is-fe:
+	Usage: optional
+	Value type: <bool>
+	Definition: present if the dailink is frontend
+
+
+= CPU, PLATFORM, CODEC dais subnodes
+- cpu:
+	Usage: required
+	Value type: <subnode>
+	Definition: cpu dai sub-node
+
+- codec:
+	Usage: required
+	Value type: <subnode>
+	Definition: codec dai sub-node
+
+- platform:
+	Usage: opional
+	Value type: <subnode>
+	Definition: platform dai sub-node
+
+- sound-dai:
+	Usage: required
+	Value type: <phandle>
+	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
+
+Example:
+
+audio {
+	compatible = "qcom,apq8096-sndcard";
+	qcom,model = "DB820c";
+	qcom,audio-routing =
+		"RX_BIAS", "MCLK";
+
+	fedai1 {
+		is-fe;
+		link-name = "MultiMedia1 Playback";
+		cpu {
+			sound-dai = <&q6asm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+		platform {
+			sound-dai = <&q6asm  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	bedai1 {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afe AFE_PORT_HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6adm>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+};
-- 
2.15.1
