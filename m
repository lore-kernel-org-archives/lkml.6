Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648869; cv=none;
        d=google.com; s=arc-20160816;
        b=GSuMOQnbdK2rD8/YIT/nt44LgC9BIX55Ne/2lmr15BCkuBvkVnwv7GSg6Fqqe6sIoA
         dFtJlM1JfPx+HyKFEWtOMdxUHstW+w+QKJfqeSGUWa9E3xAu2lGF0go1fJCTyjk2SZsK
         2tXKoCwkGNC28HHmosG+z6MnQ/H1jn/zE6m82SZB9p4FcWWNzefbtdsIS4k7jjQBDWzo
         mUILmCKVb4f++xHySfTSOa80YfuACjSVD3Tw2LzLOBKPgDpqIsIqsBWneCIlUjOJu4ys
         OmOIpH2A35WmQdUyIy8FTJ7fhILLGIXmRW/HN+AFLL59tT/lw7xFEcG7T1ttxTiH6gsW
         b5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WlxlyTkOLwLXRt8sB2I1xqKKd2j4V9/sY8qBIz9W4yU=;
        b=sZFeNVP6Z2MJ1vPxr0v1dILTM+SY5bkw4tUw363A4b8SU1YLKH/4PYydHluksh/j5X
         V/eazwTMexZlDnvEFXoE17Kfb5FVfQr++R4rsIZq/4xLYeKKKt63FAZtp0LAv4jE7vCw
         p8jOvWdN5p9s66MzHfjZL9k6TGwF2Qccu5CCAEP9zGMt2UBfRv/ml4pTEnIR85BH6Hl9
         yUEdn8NIKcRknzPP2JuDSlKJJzDf4qUCylzSxrp5E62C7jItPXlCSQg5lbHYvYgKGoHE
         RLVx2/F/H/eZNIgZe+ueL3IY+yedzScL+cjJY9G6IzrNVy9pRqsy6wfm7vIqgNzAb0b7
         Ur3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e2RuYP9c;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=e2RuYP9c;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuEiv61prFlIlvaqFOg9EjkZwW55Gm1AVQ/7Funz83esLov0PaySf9Omc099FpkbeZHPduZ1Q==
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
Subject: [PATCH v4 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Sat, 10 Mar 2018 02:24:37 +0000
Message-Id: <20180310022456.26739-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515908508332196?=
X-GMAIL-MSGID: =?utf-8?q?1594515908508332196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..ddd93c80bd8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,34 @@
+Qualcomm Audio Device Manager (Q6ADM) binding
+
+Q6ADM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,adm" where the version number can be queried
+		   from DSP.
+		   example "qcom,adm-v2.0"
+
+
+= ADM routing
+"routing" subnode of the ADM node represents adm routing specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 0
+
+= EXAMPLE
+q6adm: q6adm {
+	compatible = "qcom,q6adm";
+	qcom,apr-svc-name = "ADM";
+	qcom,apr-svc-id = <APR_SVC_ADM>;
+	q6routing: routing {
+		#sound-dai-cells = <0>;
+	};
+};
-- 
2.15.1
