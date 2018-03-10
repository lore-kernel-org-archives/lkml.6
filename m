Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648864; cv=none;
        d=google.com; s=arc-20160816;
        b=scN25pdL29YGXOqW3cSRh8hKWatpPglEI2enK4iVxQEkHQIlq8Ys902ja3XCo50DzO
         b2YN89JYjZ+rJVspN/IY18YJXnGMWTi0N4oFO5NswEoIxUjqQGP8Hq6sSCrqfepOKQEw
         8uieTxubnljJGdSEzTkS0YSSuf7bLhjus5FMTlk5GeEnwFsEituq7S98tRV2tcP6etDB
         7m5EkLqYGiZos7YBCVu2Fm2tHxKg08AS7/13Xfw6tJmJAiz/G/lmtnWTKdtaqXhDXIzz
         +VDc1T4sKx65rEN78+H+nBt57gPch+Yi08vT+OUN4ucXHgs4rsbpQOvwcwudpq6tdiQU
         qXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qNkPjCX+uXERSiiJcnrRkyTt+6mEj36twYioni/4PQA=;
        b=Kg/mgerL67XjlPa5hOjVdVImFRhWpFlV8Eso0uPEUQCcx1PCP1BUBeXbYg5iKQPIiG
         h5YaZYT02ZNmYy4CRMqCm6oyMfGTDA3+RpA4O945542nvOB2b0ZktJgTnYNcEzULOXxp
         cqRr+UCx/98/HCkq+qOmfwbA1vukKEJjUPtUCey4YOBbm5oxZP8AwoHxl50RgT4mj2HN
         OnX0jCkSMCJTtXYU1PpS1ngo326vLi8Yi2y/nV9mqKJe8YjzBaW+9fJvoLmzRfjsq2Cv
         mqhxCxNYGUiuAHn3swLPiJkJ9BVzi93aSO9GljNLSfiZ0dKTQWUM/fGqCl26Q7h/o4R3
         rx2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EfuE7YIu;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EfuE7YIu;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvcHRPll3fB3NZpyqylGA1TtthgUW21M2//bM/3cxX35QqQAUXzLjHx5yTI9+C3Niek+F1MPQ==
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
Subject: [PATCH v4 01/24] soc: qcom dt-bindings: Add APR bus bindings
Date: Sat, 10 Mar 2018 02:24:33 +0000
Message-Id: <20180310022456.26739-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515903348456348?=
X-GMAIL-MSGID: =?utf-8?q?1594515903348456348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
bus driver. This bus is used for communicating with DSP which provides
audio and various other services to cpu.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 85 ++++++++++++++++++++++
 include/dt-bindings/soc/qcom,apr.h                 | 27 +++++++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 include/dt-bindings/soc/qcom,apr.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
new file mode 100644
index 000000000000..6071a9038b4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
@@ -0,0 +1,85 @@
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
+- qcom,apr-dest-domain-id
+	Usage: required
+	Value type: <prop-encoded-array>
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
+- qcom,apr-svc-id
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: APR Service ID, used for matching the service.
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
+- qcom,apr-svc-name
+	Usage: required
+	Value type: <stringlist>
+	Definition: User readable name of a APR service.
+
+= EXAMPLE
+The following example represents a QDSP based sound card on a MSM8996 device
+which uses apr as communication between Apps and QDSP.
+
+	apr {
+		compatible = "qcom,apr-v2";
+		qcom,smd-channels = "apr_audio_svc";
+		qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
+
+		q6core {
+			compatible = "qcom,q6core";
+			qcom,apr-svc-name = "CORE";
+			qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
+		};
+
+		q6afe {
+			compatible = "qcom,q6afe";
+			qcom,apr-svc-name = "AFE";
+			qcom,apr-svc-id = <APR_SVC_AFE>;
+		};
+
+		q6asm {
+			compatible = "qcom,q6asm";
+			qcom,apr-svc-name = "ASM";
+			qcom,apr-svc-id = <APR_SVC_ASM>;
+		};
+
+		q6adm {
+			compatible = "qcom,q6adm";
+			qcom,apr-svc-name = "ADM";
+			qcom,apr-svc-id = <APR_SVC_ADM>;
+		};
+	};
diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
new file mode 100644
index 000000000000..905503f81885
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,apr.h
@@ -0,0 +1,27 @@
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
2.15.1
