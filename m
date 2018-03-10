Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648870; cv=none;
        d=google.com; s=arc-20160816;
        b=HgS9tUudaWUZwZyf2JiGeOOzLwAkATBgT4IoCKTRniuXDiNJ5F6/dKgK2gwvRkFg+N
         F/H4u9xOMx4fzWgG7xSaUeL1Lxuk3rhMP3yfT8uTte/AqhtWRiJoTf6ugMyjFtiEJ7nn
         +PnS5RMLt13CKhrdDK2B4dsYrCckvTN6LXVmgpn+q/wIyxW9KT81Aot44IKXyh7E4+RE
         Lh3qjZ6S4l97eg8PpqxtYeLsctizAzM6kjcQboWCR6qwjJTuSBeWUFIAYnYKSJ1Uz1Fp
         V06BVeHtNirxv3Ckn3HADiVTQ2RG8vryec/iBlwHrhimCh7f8sq0DKY7oswG76ieVFJr
         aikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5RoroAqka1QiRkDT0H3/wN8yePmLtx+aMNSdBlanLuo=;
        b=myp2CUibF8ZIp4XEu6F22IvuIg3Y2ErkohpIciiR7dtdyC6eRvE4BGYVJel8d3vq/M
         Ax81htc2/lLYwtsJQx/3zAQGbQ7jqRj8DV7zt6lphLjnZ1gIS0i7xxkEqAX8f6A9NgZt
         GdKPTAJyfUk25KROhm6kBrhOFdMu7qmgRHRX2ut5zOql0/9wkWJF8kxUv98i8HDbcKxk
         ZbnjbdshJM4oboe4RM4pWEOaa9Lw51JXKhyZjyaKB30ETficuJIphvrb/8rCAGejEva9
         Ca/QqRerng7sx9fh+MBwZD9mc+P98frTH9U/FmrNPP+NsHhzZROMaSOW61UHFBbn6nyM
         rF/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=h8lWMzSG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=h8lWMzSG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuOouk8Lw4D4aMq+6RjqwQF4DCz/QNJ1YTvoNX9DNh0xheJO8YsQfQTMmZxhxGL6YgEvYIixQ==
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
Subject: [PATCH v4 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Date: Sat, 10 Mar 2018 02:24:38 +0000
Message-Id: <20180310022456.26739-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515909638765097?=
X-GMAIL-MSGID: =?utf-8?q?1594515909638765097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ASM (Audio Stream Manager) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt       | 34 ++++++++++++++++++++++
 include/dt-bindings/sound/qcom,q6asm.h             | 22 ++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
new file mode 100644
index 000000000000..84703747db3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -0,0 +1,34 @@
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
+q6asm: q6asm {
+	compatible = "qcom,q6asm";
+	qcom,apr-svc-name = "ASM";
+	qcom,apr-svc-id = <APR_SVC_ASM>;
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
2.15.1
