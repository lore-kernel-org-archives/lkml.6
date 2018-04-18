Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524065764; cv=none;
        d=google.com; s=arc-20160816;
        b=H8kE2poM2xsprIQQjsHJx3FaOIr6+vgxhkJ83wYXKsslsS11EDBeO+e7LVJU+2oLXV
         1YydpV0Yeg1cnG+/DBSgBVGDohWNR7xDBSXpgSqBds9OiAcFFgkEi2lfyNbG66A4rcND
         QES+Xvfc3rAGmqMZuIyFEzQ5ueuQID3qHHECKBHjIa3NHYRyFUslVVyRPZGukLJryZJ0
         PwgcQXFWlWQptpkIiVQeoWlgyX1u3+GeoiP6OOVjXz8hcrRESzrJSBpnRcCoiAH4uT73
         4bsyXyK2FYeXobg+pNWeZO8ajgXY4tssnN0gHjuSjgbIpvJIE0lYB3WP3YOpOxEivvfj
         C95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=srK3WK881wRnviBcqYl+xakrSYwlAXsGKUudauFC5hU=;
        b=PELnAiSxstGTvy0pGgLowoTGGS+GbiGVUHhh8je6MNGmDIosFb0y93KcXHIbWpp+0m
         M6pw2sInmU053B09onSL6e3n96doIYho0G8H4d80zh9lM/B+uYvdgF/L83wOaPUaT7s+
         z8LHw3KN3b1B4OcXMHw/v/MuglAclwNjGoye98F/RWUYtvugHRQi2lA1k1YQr8K6hljk
         c6AcKuROd6q8Em1WfaK4vlYui444I+mUE2KIZ0e+uxQgd23juiPFkpONhvSsStxw2i6L
         x90BeBONk3OFiDm47/auzQ2E4bz8MQE0XGD3ZMD3ujiDrNBghfE9adCdoHwhc0KG6d69
         fxkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=VKap5Bvh;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=VKap5Bvh;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48blIHBDcU67ho1CTB2APFJ2YXjNp69rQMWSFLXeH8RCWdaMY8UyqU772XTWD2H1+UfRTOJ+w==
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
Subject: [PATCH v5 06/23] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Date: Wed, 18 Apr 2018 16:31:40 +0100
Message-Id: <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098782482052461?=
X-GMAIL-MSGID: =?utf-8?q?1598098782482052461?=
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
index 000000000000..d034a50a202a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,33 @@
+Qualcomm Audio Stream Manager (Q6ASM) binding
+
+Q6ASM is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the coommon apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		    Or "qcom,asm" where the version number can be queried
+		    from DSP.
+		    example "qcom,asm-v2.0"
+
+= ASM DAIs (Digial Audio Interface)
+"dais" subnode of the ASM node represents dai specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 1
+
+= EXAMPLE
+
+q6asm {
+	compatible = "qcom,q6asm";
+	reg = <APR_SVC_ASM>;
+	q6asmdai: dais {
+		#sound-dai-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
new file mode 100644
index 000000000000..2e11b15d930d
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
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
