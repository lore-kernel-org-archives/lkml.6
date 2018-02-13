Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965282AbeBMRKS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:10:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35527 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965422AbeBMRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:21 -0500
X-Google-Smtp-Source: AH8x227w6TQA4ECT0wo2lFCtAHZwigoXzi4HPuUzk9FEnQ32MAH/iIR5dXSipDjmADYpTJT5KqPmNQ==
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
Subject: [PATCH v3 04/25] dt-bindings: sound: qcom: Add bindings for q6afe
Date: Tue, 13 Feb 2018 16:58:16 +0000
Message-Id: <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt       | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
new file mode 100644
index 000000000000..4b389124275c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -0,0 +1,38 @@
+Qualcomm Audio Front End (Q6AFE) binding
+
+AFE is one of the APR audio service on Q6DSP
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    example "qcom,afe-v2.0"
+
+- qcom,apr-svc-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 4 for Audio Front End Service.
+
+- qcom,apr-svc-name
+	Usage: required
+	Value type: <stringlist>
+	Definition: Must be "AFE"
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 1
+
+
+= EXAMPLE
+
+q6afe {
+	compatible = "qcom,q6afe";
+	qcom,apr-svc-name = "AFE";
+	qcom,apr-svc-id = <APR_SVC_AFE>;
+	#sound-dai-cells = <1>;
+};
-- 
2.15.1
