Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176632; cv=none;
        d=google.com; s=arc-20160816;
        b=mRGpPgaYVZG20tysBre7uSIzGHJrpYuXnEoogLlyhWjKZyDoNFavhBK1zZ1OKtGLqR
         CtmLPtjhdQ//4+kUcKYflBH59jBNjpigqT3GxGFuOlU8aH8MONXYG7vsqY9ZtuKttupV
         BD9pclTQUl3bukH5rZtiX5biJDIcrkXCcyjXY6+kWYB97fRxglWERxBBC12uRHm1fNeZ
         BXskQrxbJnt11QnQdAnJFOZEvBEFh7+K/WxtNHptsZih4dzdQnvPz0m4YZIkXDNOqj29
         OsS/1jPQlbUN9PlUppcfPhFC8YCNHzCOfKAJ+DhmA11rIZFf3AeItxhfs9tN/4TpJ0NG
         D1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Rd4z0YBnbevtWdQ79Z+dgLQ3rLI/B1CbyPe1PeVn4tI=;
        b=bnnDysenAO1AOO2pnaaHuVQH3KjbTcDZ2zmwyqjD2o6JjHN1sRPmZhwyQx52QRvC7c
         pCuUvciVhGSrDj6mspRMWYbx1VFzDaY+1ucxIZG4+injuXhWzfjKG4yxAYiklpqvBmgJ
         PbERNjsoxS92oJcwsmxARu3eCxq+QoPeXKyD+RmTOvHtE6PtrhEJ8K/u3GyRj0DBc3Hw
         /rCXmVd+eJ2FbYgMSSm+oiw2vSFEjyJM3/NzPhiHyx68vAueUL83epSnQb+MxK2FKloB
         bOrevMPg69oiQPifxJB/Uf1tZXxYz5FZokoVf3dd3sJ/6LeGwHCvCDxeX8XTm7dP5bcx
         bk5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KcQcBmR8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KcQcBmR8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrI/5KmWSvInqYL51fvaeByz8Qr6V8DDJYqBqGynw3mfkixEWqn+H7+TlghLGDlAykQdV7BNA==
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
Subject: [PATCH v7 05/24] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Tue,  1 May 2018 13:08:01 +0100
Message-Id: <20180501120820.11016-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263612223089566?=
X-GMAIL-MSGID: =?utf-8?q?1599263612223089566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
