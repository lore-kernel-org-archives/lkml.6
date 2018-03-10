Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648867; cv=none;
        d=google.com; s=arc-20160816;
        b=y25dLduBw+bh/9ipfaU18l3meDQtKKz7jr4EduL5bAZLBhczcWfBVzm2B/KTq/kpbU
         HMux3sEOTGn394vxPiUnRwkbntFQfNlgFA5EPsuXCI9D15MTBwY09Bo3skJgE7Bji8uh
         4cikMQqZig2L8auL8FBn1ujny6cCBKK9YjL9cLKGsqClGIoL1ByjcteDVzAMpKJ55Qht
         uamL9JtJY/s1W6JcX3rfOkyxeaqE+q5mYEKkbCd6j+ijJL3Xp9R5B0k1t5HkppPN4WT6
         vlkhEvsN8uS5IyrRiQpajsV5wDo8m+sXHZHm4cRQ1APm4t6/JL4b8VsSQXx/zGrPU1qH
         dboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=X+bTrY5qCf93IxDIVamlPsHW+tZsoSfxM3TB4cHbFl8=;
        b=hu878FhMC0dgCgeQT/W26T3KuFiol6ODZYRE62cxDG2Y1Fd0XPpVgWE+0QH4wEes0B
         0ceseYYKtJUshR5v5pFriAP1yfp1xYs6v9hVhohrrrPMrd1LGXNX+W2VSl+dJKyZe3KT
         Xs7vniVc5BfOMHxbGEGk7fF5EyL2V/DDv5ksnGIgRekZyZaYWMNR15izUkvAPavefnXr
         eTu4I5on0BLrsKGEv34WNK3AleA+l7doTYLY2LOEFSYMLWqFznO8dxVt8XskWXwQe1fR
         hrqpb3us8M4XO6T3Up+GJ8abgniuoVNnG4EKXOxS9Nzw4YdCOHtQfJ7bfRuhHeMNy+uu
         6elw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NN3afkla;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NN3afkla;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELueofjTR03L3azXj+PA6m8eaONmpXUrxjx5mbL8TFW196HNGdaMUGH8uZxzRejhBau4fhBjQQ==
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
Subject: [PATCH v4 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Date: Sat, 10 Mar 2018 02:24:36 +0000
Message-Id: <20180310022456.26739-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515907497831256?=
X-GMAIL-MSGID: =?utf-8?q?1594515907497831256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for AFE (Audio Frontend) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       | 107 +++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
new file mode 100644
index 000000000000..1e4b82e7747a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -0,0 +1,107 @@
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
+- interface-type
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must be one of following
+	"mi2s"
+	"hdmi"
+	"pcm"
+	"slim"
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
+	qcom,apr-svc-name = "AFE";
+	qcom,apr-svc-id = <APR_SVC_AFE>;
+
+	q6asmdai: dais {
+		#sound-dai-cells = <1>;
+		hdmi@1 {
+			reg = <1>;
+			interface-type = "hdmi";
+		};
+
+		prim-mi2s-rx@16 {
+			reg = <16>;
+			qcom,sd-lines = <1 3>;
+			interface-type = "mi2s";
+		};
+
+		prim-mi2s-tx@17 {
+			reg = <17>;
+			qcom,sd-lines = <2>;
+			interface-type = "mi2s";
+		};
+
+		sec-mi2s-rx@18 {
+			reg = <18>;
+			qcom,sd-lines = <1 4>;
+			interface-type = "mi2s";
+		};
+
+		sec-mi2s-tx@19 {
+			reg = <19>;
+			qcom,sd-lines = <2>;
+			interface-type = "mi2s";
+		};
+
+		tert-mi2s-rx@20 {
+			reg = <20>;
+			qcom,sd-lines = <2 4>;
+			interface-type = "mi2s";
+		};
+
+		tert-mi2s-tx@21 {
+			reg = <21>;
+			qcom,sd-lines = <1>;
+			interface-type = "mi2s";
+		};
+
+		quat-mi2s-rx@22 {
+			reg = <22>;
+			qcom,sd-lines = <1>;
+			interface-type = "mi2s";
+		};
+
+		quat-mi2s-tx@23 {
+			reg = <23>;
+			qcom,sd-lines = <2>;
+			interface-type = "mi2s";
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
2.15.1
