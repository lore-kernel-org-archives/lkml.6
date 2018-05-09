Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870842; cv=none;
        d=google.com; s=arc-20160816;
        b=n3FYsrNR+0mddCtM4DerzkD22OuqmMUBbZqcB2wheyu6fprgpoapxsXhjUmHkzxyX/
         dAUoJPh5FbXIcjSt6D81FNgywmkTZHp/jjWZbP4i7r7dr5g5LbVJDabisF/Iog9oR6gB
         2doiHmPIevPBESKEtzxeO/P5MjFIHxXySTjoZd31aa2rQoIkF54duMP65yh2D9SNTuFD
         u6r7pWLmBG+Sih7pZruhi/5j02SmM4/hDKx07t4F8lxY8ASL4VcqGe5zWdNmoOn+s9SZ
         mUE5sMMV6HN1EEqDjGe3Wy+4LyjoFpknTDyM/B+xZGIm9+AA+X9LlO8JeoQYojwN5v6M
         LAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4f6YO5GHuZ0NuZbxLgAZ0h3DTM6BWNJ2ZQMExu7+H4M=;
        b=vIXzculuTxIqAbc2HsGP2axe1pddLOvRjXSXfSLz/s8oQif39ZQTOKpCGI1PUy3huE
         TFfyOS3SdroluMV9ht4Zvgm3G7mqWGOnaFfpPOd7gt0MY3Red3e6RwLIHb4mKwOuNIlQ
         IkRVmSl+Urz+dgYLWuzwTGgrbOPfNZIf/LEIncPr9YmpUYz/GkoiNLd6JXzR7z7ZwkI7
         TYIxy/bon+JXqOGE6C8WAAxGyWerAVWvREi7PvnKeAGk7w5rhU3TfXVI/M1R9jpxX46N
         EpC7pS7TMSpXLgcWViPYYQnGPDOcDwvAuhD4wMiyx4b2DUgXUKsS7uuTUjKga1rftin2
         yekg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HRBVs0Fw;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HRBVs0Fw;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrcB9/7Iiz5nsRzruBu1o4WpUqsqfgKFabshOf6PskdAPJJeVyE/7i7VW3Q9s1/IWpZLU3V6g==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v8 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Date: Wed,  9 May 2018 13:56:15 +0100
Message-Id: <20180509125635.5653-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991545126227809?=
X-GMAIL-MSGID: =?utf-8?q?1599991545126227809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add DT bindings for AFE (Audio Frontend) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       | 104 +++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
new file mode 100644
index 000000000000..14335a08b963
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -0,0 +1,104 @@
+Qualcomm Audio Front End (Q6AFE) binding
+
+AFE is one of the APR audio service on Q6DSP
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by all apr services. Must contain the following properties.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
+		  Or "qcom,q6afe" where the version number can be queried
+		  from DSP.
+		  example "qcom,q6afe"
+
+= AFE DAIs (Digial Audio Interface)
+"dais" subnode of the AFE node. It represents afe dais, each afe dai is a
+subnode of "dais" representing board specific dai setup.
+"dais" node should have following properties followed by dai children.
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+- #address-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+- #size-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 0
+
+== AFE DAI is subnode of "dais" and represent a dai, it includes board specific
+configuration of each dai. Must contain the following properties.
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Must be dai id
+
+- qcom,sd-lines
+	Usage: required for mi2s interface
+	Value type: <prop-encoded-array>
+	Definition: Must be list of serial data lines used by this dai.
+	should be one or more of the 1-4 sd lines.
+
+= EXAMPLE
+
+q6afe@4 {
+	compatible = "qcom,q6afe";
+	reg = <APR_SVC_AFE>;
+
+	dais {
+		#sound-dai-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hdmi@1 {
+			reg = <1>;
+		};
+
+		prim-mi2s-rx@16 {
+			reg = <16>;
+			qcom,sd-lines = <1 3>;
+		};
+
+		prim-mi2s-tx@17 {
+			reg = <17>;
+			qcom,sd-lines = <2>;
+		};
+
+		sec-mi2s-rx@18 {
+			reg = <18>;
+			qcom,sd-lines = <1 4>;
+		};
+
+		sec-mi2s-tx@19 {
+			reg = <19>;
+			qcom,sd-lines = <2>;
+		};
+
+		tert-mi2s-rx@20 {
+			reg = <20>;
+			qcom,sd-lines = <2 4>;
+		};
+
+		tert-mi2s-tx@21 {
+			reg = <21>;
+			qcom,sd-lines = <1>;
+		};
+
+		quat-mi2s-rx@22 {
+			reg = <22>;
+			qcom,sd-lines = <1>;
+		};
+
+		quat-mi2s-tx@23 {
+			reg = <23>;
+			qcom,sd-lines = <2>;
+		};
+	};
+};
diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
new file mode 100644
index 000000000000..e162045f5dc9
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_AFE_H__
+#define __DT_BINDINGS_Q6_AFE_H__
+
+/* Audio Front End (AFE) virtual ports IDs */
+#define HDMI_RX		1
+#define SLIMBUS_0_RX    2
+#define SLIMBUS_0_TX    3
+#define SLIMBUS_1_RX    4
+#define SLIMBUS_1_TX    5
+#define SLIMBUS_2_RX    6
+#define SLIMBUS_2_TX    7
+#define SLIMBUS_3_RX    8
+#define SLIMBUS_3_TX    9
+#define SLIMBUS_4_RX    10
+#define SLIMBUS_4_TX    11
+#define SLIMBUS_5_RX    12
+#define SLIMBUS_5_TX    13
+#define SLIMBUS_6_RX    14
+#define SLIMBUS_6_TX    15
+#define PRIMARY_MI2S_RX		16
+#define PRIMARY_MI2S_TX		17
+#define SECONDARY_MI2S_RX	18
+#define SECONDARY_MI2S_TX	19
+#define TERTIARY_MI2S_RX	20
+#define TERTIARY_MI2S_TX	21
+#define QUATERNARY_MI2S_RX	22
+#define QUATERNARY_MI2S_TX	23
+
+#endif /* __DT_BINDINGS_Q6_AFE_H__ */
+
-- 
2.16.2
