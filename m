Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736170; cv=none;
        d=google.com; s=arc-20160816;
        b=uXeF/mzgVKLEMq5QG+JK4vV0r1gLfY6JeSS1VMP2MoBy9kQnuyqQbo6lkqpWwwwD1g
         k+bw7ptBVrXD2tCCpm9OtEPXigBsbJ3X6zXSk34xSbb0e02fMaf5JV5mtU/5ispuU+PZ
         TLBfBpdiuPy5SG+219r7jC3wVqPsFqZyHdNoylmsF/QH8UpY4U177viSFJIpro5db3w8
         fsX50Kb5gWb1Hc7EEx0V+KOo70tjybWyDr5uPnrOVc4vRnGzyPOAL+mVOE1KxcfwyGS4
         O6/xgONKtWZmNMiYfJmckyEprsAs8ekPH8bZmv42etDJwCHexQ512NeBvRnFyQcbgFV8
         kd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=kg6ap/7kMUbqFM2vIrzqNQ8PumxbdgrobwmgnUDcU8o=;
        b=oUtTQZUlaQ8nexmTdDDaNEVb3T9myXgFdExKCEEfoZwk56aSc7X8TzjGhGC+IO9pH3
         9RIOOPoc7+bWW0rOSgXesMUTClsNr2aE2yvakWEUta7GLaAk1afSPaVTfFBv8pSlRuvp
         07JDB5Kf4YFiRIhr/nXpNL6zIpNeSK01ZvXaZo9QD8QwrpIhE9Nu4nyhNemiTbMxc2KT
         YE0gTnADC+rO0MMFvy5XPCTqnBssiFBgXQt0AM7/+1GVK+A6hs6Tscyb33YRmp2CZJWe
         /Wlsl51Y2Ey9AhN8y+6LUCY6VtCloqwvF0pbjObtlZMeRFqNcsfwDjW9HByTqmzlOij6
         Nbgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Qf8kHbas;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Qf8kHbas;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+X41SwHpfTDL2egaML8+i5OSxdqm5/DdMXPEc+OP9WmX1MsljT6HC7zNzWYma2nCgMMGWJvQ==
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
Subject: [PATCH v6 01/24] soc: qcom dt-bindings: Add APR bus bindings
Date: Thu, 26 Apr 2018 10:45:43 +0100
Message-Id: <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801755012499070?=
X-GMAIL-MSGID: =?utf-8?q?1598801755012499070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
bus driver. This bus is used for communicating with DSP which provides
audio and various other services to cpu.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 84 ++++++++++++++++++++++
 include/dt-bindings/soc/qcom,apr.h                 | 28 ++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 include/dt-bindings/soc/qcom,apr.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
new file mode 100644
index 000000000000..bcc612cc7423
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -0,0 +1,84 @@
+Qualcomm APR (Asynchronous Packet Router) binding
+
+This binding describes the Qualcomm APR. APR is a IPC protocol for
+communication between Application processor and QDSP. APR is mainly
+used for audio/voice services on the QDSP.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Destination processor ID.
+	Possible values are :
+			1 - APR simulator
+			2 - PC
+			3 - MODEM
+			4 - ADSP
+			5 - APPS
+			6 - MODEM2
+			7 - APPS2
+
+= APR SERVICES
+Each subnode of the APR node represents service tied to this apr. The name
+of the nodes are not important. The properties of these nodes are defined
+by the individual bindings for the specific service
+- All APR services MUST contain the following property:
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: APR Service ID
+	Possible values are :
+			3 - DSP Core Service
+			4 - Audio Front End Service.
+			5 - Voice Stream Manager Service.
+			6 - Voice processing manager.
+			7 - Audio Stream Manager Service.
+			8 - Audio Device Manager Service.
+			9 - Multimode voice manager.
+			10 - Core voice stream.
+			11 - Core voice processor.
+			12 - Ultrasound stream manager.
+			13 - Listen stream manager.
+
+= EXAMPLE
+The following example represents a QDSP based sound card on a MSM8996 device
+which uses apr as communication between Apps and QDSP.
+
+	apr@4 {
+		compatible = "qcom,apr-v2";
+		reg = <APR_DOMAIN_ADSP>;
+
+		q6core@3 {
+			compatible = "qcom,q6core";
+			reg = <APR_SVC_ADSP_CORE>;
+		};
+
+		q6afe@4 {
+			compatible = "qcom,q6afe";
+			reg = <APR_SVC_AFE>;
+
+			dais {
+				#sound-dai-cells = <1>;
+				hdmi@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		q6asm@7 {
+			compatible = "qcom,q6asm";
+			reg = <APR_SVC_ASM>;
+			...
+		};
+
+		q6adm@8 {
+			compatible = "qcom,q6adm";
+			reg = <APR_SVC_ADM>;
+			...
+		};
+	};
diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
new file mode 100644
index 000000000000..006362400c0f
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,apr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_QCOM_APR_H
+#define __DT_BINDINGS_QCOM_APR_H
+
+/* Domain IDs */
+#define APR_DOMAIN_SIM		0x1
+#define APR_DOMAIN_PC		0x2
+#define APR_DOMAIN_MODEM	0x3
+#define APR_DOMAIN_ADSP		0x4
+#define APR_DOMAIN_APPS		0x5
+#define APR_DOMAIN_MAX		0x6
+
+/* ADSP service IDs */
+#define APR_SVC_ADSP_CORE	0x3
+#define APR_SVC_AFE		0x4
+#define APR_SVC_VSM		0x5
+#define APR_SVC_VPM		0x6
+#define APR_SVC_ASM		0x7
+#define APR_SVC_ADM		0x8
+#define APR_SVC_ADSP_MVM	0x09
+#define APR_SVC_ADSP_CVS	0x0A
+#define APR_SVC_ADSP_CVP	0x0B
+#define APR_SVC_USM		0x0C
+#define APR_SVC_LSM		0x0D
+#define APR_SVC_VIDC		0x16
+#define APR_SVC_MAX		0x17
+
+#endif /* __DT_BINDINGS_QCOM_APR_H */
-- 
2.16.2
