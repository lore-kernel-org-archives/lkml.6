Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqtblBx/SN99pB3rx6n9UH3Z1kYBQjPd1wvmDPDA06n2oCJHD95XQk4A+0Dh7JnFXwFaPYy
ARC-Seal: i=1; a=rsa-sha256; t=1526008580; cv=none;
        d=google.com; s=arc-20160816;
        b=zKuQjhg1O+pnlAriPPWauhWqvJ+ieV+7bIL+TaF9Ki2cdu0b5+AL156zps5Vhsac0f
         CtHgNSRPFRmLv8O6MgAvzT+6+BgfbiyMsgZrfEhSdPN/d/ONdQekowh3Ya2cldVUFdEF
         T0jAyz1cw3ES2OVzrYqMNpKwjPl1zJDbx/tfraOBi9s7/sJJU/FUUwzdmyqxcmKWnH3u
         73CqCLyRdhvT3jKT5yy/eebnStqqz3VieaO/YxIvIedkLHX57L1mBDzKcvliPJr3k7Em
         xHSGtcSCFlwNHPmhjmvION59z6e+hHp8H/uO6+O5K6GDEkLI/hoBTtsHKINhtDYyRiNT
         D5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=OdDzdcyWbZed9DlKy/A9KgzlUdiSVRWBen0YWI6kUVI=;
        b=PmpFdoCbEKV9iTpxtI5sGNPMNQflEnr6QL0rH/nqaEQdFOd5+8wfIbIXJAwxl0iVaD
         2z6QFC6GkVoJg0EFuaRwRXGwCzepjV7XuTde+1+nfmGpKoTJieNy1E2HbtiC9SBCc/Xn
         pIaGrqdqsIBirBJzLPd21NMGwN2lB3W33RbMlckItsWJRgsD2JmzPqxqrknbnlfzK2AC
         phvb9cdvbbSb45H+1/Uhm2A/VW385GKAWxt+excGtCZ7v9oq8B6LQ15UxobNsdT5l8XU
         3TMWQzuQzv0Cgd6rimnkW3F20dT7qcpe7YGqFS4bcgRhCoulN1GLFzj1iosFIvwPvDCl
         zlTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=kaxaWclI;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=kaxaWclI;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: dt-bindings: Add q6asm dt bindings" to the asoc tree
In-Reply-To: <20180426094606.4775-7-srinivas.kandagatla@linaro.org>
Message-Id: <20180511031602.30B7C44007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:16:02 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600135972764991305?=
X-GMAIL-MSGID: =?utf-8?q?1600135972764991305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: dt-bindings: Add q6asm dt bindings

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

>From 0e17e9820319c012c80ebba0a6df07d6a3a03ab3 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:17 +0100
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings

This patch add DT bindings for ASM (Audio Stream Manager) DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt  | 33 +++++++++++++++++++
 include/dt-bindings/sound/qcom,q6asm.h        | 22 +++++++++++++
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
2.17.0
