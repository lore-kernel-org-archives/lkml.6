Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoOD0cxZibrcrwSOGX+K2eOJnA7wNvbkKZtc2wzMx7TIGscWTbUzB3wksDgu01pANdXk6ly
ARC-Seal: i=1; a=rsa-sha256; t=1526008641; cv=none;
        d=google.com; s=arc-20160816;
        b=uGrytcmtaPo38gECDv12kyGSMpZUDriMoaIdMTVjuUG2b9Q16hcwy/8xH45vPtjGHY
         2QvIi/ScfSMDrNx7O2R0uS/5WoY6kgRo9FNwmzRsdeeaoz1z63E7Kxq6NJLfnDYDwEKR
         XzLz6ibiap0SlHXZ2gO2AM6jI8VfUjfhBJgXUU8mnGXmd8WKlyyjWkiim8IrArU2rwBr
         KjNJbrE0906jE9EP3wPFjCAeaKQDqvBUI+MLMyjJqlEX1Bsp+QDGsoKdV5+l8vZqfyaa
         YuphY7z6fmMf9L0SZP6zP3lIVfm3hf7i79KNwth5HLHumwdhC02oieN2qPqZZDKLx8h5
         7wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=WGQ13cMLMO9YupYtNm2910y7/Ath/XXke1fr6g3OkQ0=;
        b=zEZXNdIbgPiQOk7axUNxP301rxsRcfOKaIsbmhGTd9vq16c3ZR0pBlopDf1mqDrtNf
         LPxaP+XpEUvNaEKiBQvhlNoYMe8fTFaMErU2JDKur6sj+sEkh27wIYBMY060AZqpQURt
         u0CMMMQrAKe2glVmbvAJYogJDMLpxmqnaf5Sncz0Frc9fwqeZmlrwRZT0M561iMC193h
         JF1RlEfKv4PakdbOLiLG753lK6DCLN/AnMP/WLVJ2r1U5UjW9qd3JzD/wQGbarfD2XyZ
         HqfE0U11cMJLrGn37zBMz49rbYFmTKMqUViX7jV7qE0YFUwXb2HQc636BrT0MFVVPyI7
         NQ4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RetknoEL;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RetknoEL;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: dt-bindings: Add q6adm dt bindings" to the asoc tree
In-Reply-To: <20180426094606.4775-6-srinivas.kandagatla@linaro.org>
Message-Id: <20180511031709.A3A1344007A@finisterre.ee.mobilebroadband>
Date: Fri, 11 May 2018 04:17:09 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600136037796609487?=
X-GMAIL-MSGID: =?utf-8?q?1600136037796609487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: dt-bindings: Add q6adm dt bindings

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

>From 364b8768182abc40603dca05cbe2bea0a0a851a0 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:16 +0100
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt  | 33 +++++++++++++++++++
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
2.17.0
