Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736177; cv=none;
        d=google.com; s=arc-20160816;
        b=a4YCx2W69zcqXF/j1MviZVdiM6W4FS9q8+GL8Fr1lkqb2EoZ6LZ8rNJ1VSBsIvQMlq
         KpIdqpm7B5AU05rMMlr7F99ACperFMgvgoIUU5JxPwVlBet8E7QQhN3bZTIHZoilt81h
         yqE5HRmvjHMjkEKsyOC92NhM6gNfA1uLsJ5qSEJqzm0lVsZzII0FG6U/dSLiASu+XO3I
         N0PO5It+dTiFX9a0GAo/PN3yPwZIzTH22/X9USY7imkm/zUocMaSP/E3RKrcHQ5j957O
         /sEWYx8Qyq390qpl+bQBNYXqtgsc5GHgPdKxh8Lq5G+ivhKkhm5q8Q0kf00rEw+Z3wWY
         tUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GX016FpURezWDdIQhmz6SEGH/kMoinBWPVAzesWmgM0=;
        b=D7ml14pOKWO2e/qLRPMNPtL0vD/3p4N3L9fmo4v53z1rtoklYb5SYz3vm5vVVWTKCD
         s5PuhnFzLtoIQTxBxquENNHHRRVV0iOCLOcU81tzjTjzTB2WHwsLtRighJ6OLBESlxvw
         mbn9RJuXED9rb5+aP0iM5gxBx5K0mIa3BPMdi35YfNUCKV2ng+HcwA238kVrdEF1A01k
         w91keiO1bGkFbe7en8mVsmdzEg5iTiWZ5QRfi+VVx3ZtsXhLueSS2+UlcezeqbINd0+R
         MNpa3auMRrtpFFCFlASlYGt/kiE9XKieQ72h+947AbJVQLYf12TZtYUGpYx375ugaDJc
         T1bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CW2Dif87;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CW2Dif87;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZobB2mogLSV63zGz/JtGIKe/rDsb3vMCq5dAZyMaIIXEDumr7HofijrZgMSbf0qRmBVFVgnkA==
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
Subject: [PATCH v6 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Date: Thu, 26 Apr 2018 10:45:48 +0100
Message-Id: <20180426094606.4775-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801762059177131?=
X-GMAIL-MSGID: =?utf-8?q?1598801762059177131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ASM (Audio Stream Manager) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
new file mode 100644
index 000000000000..2178eb91146f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,33 @@
+Qualcomm Audio Stream Manager (Q6ASM) binding
+
+Q6ASM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    Or "qcom,q6asm" where the version number can be queried
+		    from DSP.
+		    example "qcom,q6asm-v2.0"
+
+= ASM DAIs (Digial Audio Interface)
+"dais" subnode of the ASM node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+= EXAMPLE
+
+q6asm@7 {
+	compatible = "qcom,q6asm";
+	reg = <APR_SVC_ASM>;
+	q6asmdai: dais {
+		#sound-dai-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
new file mode 100644
index 000000000000..1eb77d87c2e8
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_ASM_H__
+#define __DT_BINDINGS_Q6_ASM_H__
+
+#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
+#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
+#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
+#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
+#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
+#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
+#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
+#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
+
+#endif /* __DT_BINDINGS_Q6_ASM_H__ */
-- 
2.16.2
