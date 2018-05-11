Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoEYtlRuSTpmF7TQsr6va5IA9rHBMyYJCDjbA/ScP/CBa9YC4phBAG9JWJd5pG0e4ihz9dQ
ARC-Seal: i=1; a=rsa-sha256; t=1526008779; cv=none;
        d=google.com; s=arc-20160816;
        b=H0yPiZPGriCWLVkCOw6a/FWETsBkgtZFBNqUWTVMeb+uWO+KYHJwyt0azGbQmno20O
         PwMlk5qtjSBBlm8TljNOgvO0/IPBPIw3fpQcRTFwGKBPPnLPMgcg7uTW+BxTi2jfVzIX
         9SVHmFgD3kNtHk5DipEArvOBax+D3GxvKILwtFGE0ougTwL/WJ1xGHWX3UsJ4Ksm4UwU
         4QZABo/S7GQr/aRvy/vxU3G+FU2RxN0dxfmbnVsRTV6dlTYmJKPREP0MLnx3ifkgvwdg
         4gZSmXyYRwlPbUFfb+9eM6wdg0gWdsKHz3G2nfIgMNWTkmXWEXlqZd/HQg4tw3TaOZ4I
         gicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9nZGT0w9UYWOGtC/uP8/6qw12HaJtwpu2ymN6X9lkNo=;
        b=V/hZIh8kMxe167piY1HeJou7IwH1VprmWWMhM3vGxYdCKflY3kUtdGt0a/8Q+nodfm
         wP9ES2J8Lp75cukUQbTqF7/BcpmTU7Xr+TkAK5ShFIsAmtjrMAtqexKHXCfMB+l+pDq/
         JxKnsRlz+OJLNDrrg3gvtAcDnB5NH2+hf7dn0ZR52qb+vEEPTtjLLJc+Kg7vikNkQexS
         30KDVWOUyJD5juPFGeYSiod8gJG16HDF7ll+/yPen+/uKYEruZe0tgbbGyXFA7bEcTQp
         LESYnGPBeZUtVohs+p/YVj6kBb/IOwRli80ygi5F/9zeCbMVUz3iqsLyR8IyT6c+RndC
         60Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=iZxQDawg;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=iZxQDawg;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "soc: qcom dt-bindings: Add APR bus bindings" to the asoc tree
In-Reply-To: <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
Message-Id: <20180511031930.419CC44007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:19:30 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600136182276150208?=
X-GMAIL-MSGID: =?utf-8?q?1600136182276150208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   soc: qcom dt-bindings: Add APR bus bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8675e8d3d1b413dc0e6165d2ce09de4335f7f57a Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:12 +0100
Subject: [PATCH] soc: qcom dt-bindings: Add APR bus bindings

This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
bus driver. This bus is used for communicating with DSP which provides
audio and various other services to cpu.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.txt | 84 +++++++++++++++++++
 include/dt-bindings/soc/qcom,apr.h            | 28 +++++++
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
2.17.0
