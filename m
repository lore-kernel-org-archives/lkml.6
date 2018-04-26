Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736176; cv=none;
        d=google.com; s=arc-20160816;
        b=Lo9p6NOcXDYcTOv9QErGP5p13YfaKsrVZe4gxOO7xaIyWOtG6PkUZteEdy5jQ2aitc
         PBRVuXCCBqJdw+j0oNf6qp3N6KBktV36+q6QOfgKs4jh6tN7eChPTc66Xg90MLbBQZB3
         0XMTjLClPB/mIKVXAUBn9ej7IPTnmMBitMWQAfFCNk8WqtuzgXeDmvnvYS1o+zbSTsrd
         lxYyKUUVQ6EEQBJYuK13LpqOaycLz6kzOIBamhguM6zjuiCJVK4gvyq4SOQiVPDXDZMQ
         CwD+W18SirQoO96laPcbQAWCVpTh8TU7f19CbaACA60HIRqYkwgrkwHnmJZVIVLOOeOm
         7Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gFxHl/b4xPc4k/I9T4nhGgRwD+iK0fZQV08wPP9j78o=;
        b=0Mz/mOOCp6y+/z8+/Aan+8Pz5LfoWVFhnTiqQr8qb6qNT3/s6DJHNiIEz/eRWV2ynP
         tFybAJ8G8869kCZp3+4A+pEHXDZZqzdEJIDimiJJyNAoJE117aamS6g6y6BUWVGmzTAS
         E4SYvusKng2qoDA3IxODK3XJ6XUPhOv+2rsVCALIhOc7eKpgodfGHdgLCCXqG+JBxHVg
         NI5pa7phfMmk8NcSJy8fwlP0Y8bI8HSlzIUuwEDJHxw9GAUfClbjZyDbQoxFuT7MZzV0
         Otn2Y/trXlPx3JTAQWGCCiGAstNXe99goFg7S8L7mGtb0JWukz0r1ScRUdVk4CjV/OH6
         deCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Zx88rCQi;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Zx88rCQi;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48OcwlC0En3lzlCm+VBXuuFBjIuQgPpzwWNZ2fks/6LpPVUlL9F4U6Fd+FwtwB3q5wm++eXHQ==
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
Subject: [PATCH v6 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Thu, 26 Apr 2018 10:45:47 +0100
Message-Id: <20180426094606.4775-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801760840380734?=
X-GMAIL-MSGID: =?utf-8?q?1598801760840380734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..cb709e5dbc44
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
@@ -0,0 +1,33 @@
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
+	Definition: must be "qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6adm" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6adm-v2.0"
+
+
+= ADM routing
+"routing" subnode of the ADM node represents adm routing specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 0
+
+= EXAMPLE
+q6adm@8 {
+	compatible = "qcom,q6adm";
+	reg = <APR_SVC_ADM>;
+	q6routing: routing {
+		#sound-dai-cells = <0>;
+	};
+};
-- 
2.16.2
