Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736174; cv=none;
        d=google.com; s=arc-20160816;
        b=PPHuFs68OBfdNr4jZpJqtKw33ZBnUqTuJ+73xjfKgiSyg56OdHH5HbiFlEfzJjzVsz
         66pVVTFgOy2+BR9kBbTe/sy+J+TeW8wxzXKpHARXU8p9pCpza0s4E48uIlnkRTGaEAqi
         FXieptDs0a4fx/lb7qiPiue3IzQ5kemd3gc2+9WfH5CqqzXlI+36Ao0sIrzsFx0WKNAF
         gMvC1e1VPU1xKgg18DtKUrDUJg3EDlOicNydCw13WtDLN562yxXhuU6VRmIangy6SvyH
         yyCydPoWq9m99gF1UaeKCFHYrLttjpeJe5OgJ5JmPVjrx7I9slWEFEbyHKmSlSGhTCe6
         cv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RftNHazO+oJuV+QbDpSvKUFtUjVQnvDW7snf2gfnja8=;
        b=W6BUdbbWDs5wtEa68tCLGdwsC+JWRuSzbRJSmMoYZwygnLH0Da1nEr08AlZ4f90IWK
         bUpPO44DkrTfL8GW54r4nZwbma+Kl633QQn7pkppgOra6MzCBRdWM74Q4kV78LNufWaT
         Dj9R7bnbMUqxISzgChf1Nj5kX+aK5W2WtRfKe8cV/DbSuNjrwe9YRLYFoChowR7B64uT
         yQs2ylTH6GdKloz2USPcmU8/m2Uuz6LCOyREY8YGVoF6WADxv58zSBoxR1BplkOj+nDc
         4vLb5nG4HmT0g2UxjosFIk1MVRfb21ZjNNT1A8hOUt1Gw/XuuemQxEpP5qj84uESYZUP
         Qu8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jTGzn8T+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jTGzn8T+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48LTYOaEho77YAgB1HcCGCvXa/mrngmTWfcnJP7gCaWW6Sjh/cJezg259lvulURWz9YxjUcqA==
From: srinivas.kandagatla@linaro.org
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
Subject: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Date: Thu, 26 Apr 2018 10:45:46 +0100
Message-Id: <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801759184316258?=
X-GMAIL-MSGID: =?utf-8?q?1598801759184316258?=
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
index 000000000000..05208a63dd3c
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
+	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
+		  Or "qcom,q6afe" where the version number can be queried
+		  from DSP.
+		  example "qcom,q6afe"
+
+= AFE DAIs (Digial Audio Interface)
+"dais" subnode of the AFE node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
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
