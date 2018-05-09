Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870841; cv=none;
        d=google.com; s=arc-20160816;
        b=JG1GgVz7mUTgDO2Du2P7EiD4GDsilbIaXURkoh5JQE4quwJqeu1um6zVaf4x2U8n4W
         sH+JLH5vBoHG7/Kjs/spkjgTl2g8TB8c0tX6JTjLXbazlVmUqFx/CenfxRTblpsOfRC7
         H23+MVo7W/hWQCfFDyCd21lTT8LirJ9Z0wI+/rbUOHJNCVKSVpuExR8jeKt4OQ8YWsfO
         69mDPyfuEMYANihaUL+8I1VVtgnFlakxvfjUy3SCa+zI0H5tkp3JI+di2B1dQ2/ntc/8
         jWVUTc/NKYWFJIzWX0Itck9D0GSu84uuC0hjRt62fPW3mYhuQvOrf/Qr836HHIbcBTwH
         rOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=7QY0Jir7FHjo2znovGpIiqHvAm6kI7ZR8Aut4xTvvzU=;
        b=mklt+VEJOFz9FcALRJSbB3kJeDTboVR7hHb5iGVOd6/w1SnvS/dGZA6rfuZ5zp003z
         8GYgxWQBIW7S98wdFiZF56WQtf4qT64aBbLke5r4mQpbJnjEgWNbm8DksavOEnLJpMMl
         7Bq7VHpiXGV8lkWhbB1wJzDDZq6MI1vTPwWU+4ECQCaiiEH3pRPdus5GUVzIEbstLQXD
         YykXGUL0jYQxKp/Sb2lgOvY5h6/42VWC0c0KD3UbPhNwTtnHgdCEZrEKGsTFAwoNtVYP
         TckSkh5H5us1zufAcCcAyKT+yAMvqctfHsIZJ4AwP+DZg5db1DybvJyAij7fhJ6G+o4C
         p+rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jqJgakEL;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jqJgakEL;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqy+RuNT8LNJbWfRLvabAeJxa+bVLQlmo83dRY5eoBYZTXv9KS4TnFrwiSz2E4b4DC0EYqO2Q==
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
Subject: [PATCH v8 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
Date: Wed,  9 May 2018 13:56:14 +0100
Message-Id: <20180509125635.5653-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991543212419255?=
X-GMAIL-MSGID: =?utf-8?q?1599991543212419255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
new file mode 100644
index 000000000000..7f36ff8bec18
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
@@ -0,0 +1,21 @@
+Qualcomm ADSP Core service binding
+
+Q6CORE is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6core-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6core" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6core-v2.0"
+
+= EXAMPLE
+q6core@3 {
+	compatible = "qcom,q6core";
+	reg = <APR_SVC_ADSP_CORE>;
+};
-- 
2.16.2
