Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176633; cv=none;
        d=google.com; s=arc-20160816;
        b=lZHfDjixbB0r0y2w5xXl7JIQUwk7bshUfj40c9siCFbQIEPUOiOYqaoC4JhO7x7i7z
         LWQ2ueZihJ7vEDpr9CgIaT5wsuFgm9Bga7N5a9/zt6bfvcP6SpjT/DipHkbRgSKeckrS
         UYnWEMChO4vx8lEw1dgsqLbC+t63pmdqFoFFOy3oPXP/9q/+53cALi3PkpHj3wZ9EWCJ
         tNvB/qfL8ASqNrE2Wzye7j4gm0SKEPD7JVjWTW476MolflVCFWJ79/1H61lm9HbvQdJa
         yIoTadbP9r0aKb6PupQjV0KhUpTAgZbRyFrWb20RVCVCLADQQJ96qo8wt4P1ccc7vfdI
         iVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=R54vii1uQDSlVGkRjKg27a5xPMqIUQwaxaadpb+1MA4=;
        b=Qa8AXla4KRq4YwjVNF0vuA3cbfFdg01YFa6igFmWn3FNsN+xsAAcCFc+TD3fIs0DY2
         ZbKvcOyZ2ZLDBfmPjT/BozMOgWadPDNpjnj+4uni7tfG+xvPjZv8yGz7dj6NzReN6X/S
         RSKRWAIQQ63wibEDsyRUNFVymskWATWgy1UB8XmW+L4txvvAWy2Op0YKfoISOmpqxdJe
         aW/6NI6nArLC2LzEb4avl0LofS9FanAMMZX74fI6qMzB61ChsZnyf3GTBgyRfaOw8bCB
         rjjVhfKeznlA62Zd8UgcgzRiVkGPYR15XBqwsk7wYl1NjzBjFTkaxsUsKbwNNdgb5UwX
         xg5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PjkbwFXu;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PjkbwFXu;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo+7i9vvEfQsb17SCbdi1oe+YlIt3D6hv4/GZKocMlgBwr7DjGxNMyM3SoWiPVrpIMMw9kUXg==
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
Subject: [PATCH v7 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Date: Tue,  1 May 2018 13:08:02 +0100
Message-Id: <20180501120820.11016-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263613605397312?=
X-GMAIL-MSGID: =?utf-8?q?1599263613605397312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch add DT bindings for ASM (Audio Stream Manager) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
