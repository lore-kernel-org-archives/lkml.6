Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870844; cv=none;
        d=google.com; s=arc-20160816;
        b=jVDrIwXHOnpvsQwKHNeFXFqSC1zEU5Mf8nKO85Uvnm/tcsCHwxnLb2DxrDHm92fEa7
         VWZiY6UuP1htwTv0NPFDKDF5DkcLQ/B9Q9RUsSsUcx/3vmGXlzp78rV6AYeM/mTRP2jo
         g3pGvbfHOVcsbQ8lRaIyORnUjAHgo3n+m5XqxaYPzfUXfA/TRm0774jiW4bJ/YdoAVqr
         2jqgzcFkx34kPlzg/BFEOuCqaTAy74hF/O6yNd52u4qdTK17CpPNLGEXZISaIDAJE4u6
         hXWUMYNNylQjLC7rko+hwHc5Ue1lT03z0us9LuDsoMm4JmXLr+9saVdizHbgFZnub2A/
         Atdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=tY7RukcqLqht8CWrDAkJpg45GsDcbcOVEI8s/t/u01c=;
        b=xnjztTfWQCtDQQs3Y7RK9o9qEgQ7Q+0L00IzUkRaxlnrI1hQyYo2yjtzNCGrfb3C8e
         s9W93h21C7s5mJhGvCGR3gqGvXR0nj7khWE6LHrDAQFeI0qDlwhf0xJ+sHyxQCCDHdmD
         3JrzBs5uB+OKRnwmOd/lfElR0I/UqVxfWIvho+gLkA779vZl6GKzoeLaq4wsUK4wCt1z
         4pfQbutO1sd1W3/UOyfWMDVYBKDrNwLFdK7OfrTNUwLjs/KDCYnlMQRBM+mXuyLz9YM1
         BtMtFCEk1Tp01pXicOlhH/URIHoltgrXEwc7Au6dSV6CrPe5WaSN6qm+dcQrTiv6u6CM
         8MIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Us423h+S;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Us423h+S;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZofw7Et0grJX9O/QA4fwJdgx1g4wU75CY5KGkPdpC0x7aoqVncxfnmmWthA3yZ8Veobz2JWWw==
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
Subject: [PATCH v8 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Wed,  9 May 2018 13:56:16 +0100
Message-Id: <20180509125635.5653-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991546904743505?=
X-GMAIL-MSGID: =?utf-8?q?1599991546904743505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
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
