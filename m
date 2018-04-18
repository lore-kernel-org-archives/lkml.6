Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524065761; cv=none;
        d=google.com; s=arc-20160816;
        b=q4JugYzTHR7r/cz4YIm7PjMVn2Bp4y6/f12njhXDIS55PPVoA5kv+YEcMGVv7n3vjx
         xyclEisfYYOzYMbR9ej/L/oHbTzKY9EAIODnP0F8x2nhzNbPNQwHGko2kpDbo9gMFDXj
         7/9qGiM8WJFaPFVZ6JiZbHvCX0jMelF3V805+nZfmnSpO5V2f3dPngCxqA8vGxG5gPTt
         9lH0rd6zzYx0I0ouNV8jkjMg2RGY38yc3D8OCKZFYiG7mBPmveYtI2BTtmAx/xgxiak3
         jOKb2kfrSt+b/Icfn+ug5FnI69YZv2qLh3X4VgVTthIG9aqfwxoWgnIrCx96E46vpHia
         iRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uWOPYaQGfbjAQXVVVC6kkZny6WY+Ma8pi7H5YCtdQWM=;
        b=gVGNKO9t93hoAr3B0GbytiX0qxi59HgEmmLH8oN0yrVKDhzj9v+9AQWRO2+gW+ncEi
         QIjOSbP+Nevlm4vd/Ke+iOBei5qEaGEB0EZhxgVYE4DK6Px++6iBR4BlhVan7m6BDiNO
         70KZ8w2NV3xmiIIfa2E0sRty30WvAYPLhefneLWFLuhypazbpy2N4CBDSMZa3CF2aG6u
         cX8EdQ5oHgadLFyr6p6VWrfKldEiIEqTBk0T3LAmqy/7wR651oLc90oXzlLzC4reZel6
         fSLGonvzJPbsYKJDWeAuKQiZm/q1l2YuYSG+qIxTcd7Y79hG3WUDOxCpF7orisIwtjRN
         CVig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jK8vVqOP;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jK8vVqOP;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49V323e7bkgYX2cueZp/CJWUczklz7mpGrzaJEI0gya9VTahhScX+ehVt6gFl4U3lIns2cBhw==
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 04/23] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Date: Wed, 18 Apr 2018 16:31:38 +0100
Message-Id: <20180418153157.1960-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098779871079963?=
X-GMAIL-MSGID: =?utf-8?q?1598098779871079963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for AFE (Audio Frontend) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       | 88 ++++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6afe.h             | 31 ++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
new file mode 100644
index 000000000000..3925726a3319
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -0,0 +1,88 @@
+Qualcomm Audio Front End (Q6AFE) binding
+
+AFE is one of the APR audio service on Q6DSP
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by all apr services.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
+		  Or "qcom,afe" where the version number can be queried
+		  from DSP.
+		  example "qcom,afe-v2.0"
+
+= AFE DAIs (Digial Audio Interface)
+"dais" subnode of the AFE node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 1
+
+- reg
+	Usage: required
+	Value type: <prop-encoded-array>
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
+q6afe {
+	compatible = "qcom,q6afe";
+	reg = <APR_SVC_AFE>;
+
+	dais {
+		#sound-dai-cells = <1>;
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
index 000000000000..3c7868394889
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
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
