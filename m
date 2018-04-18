Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524065762; cv=none;
        d=google.com; s=arc-20160816;
        b=PbijNebf1YZfeD7RW4sO5R+UCQorFgyaUm0lvsPurXMNgRb/E3Cz71raKZhjyEv070
         n/HDHfdqJJuGaZ5gVDM1cIuonQks6L0LhT81O0bU4jedpInKiS1kS+6gWPShnxbUYgst
         Ovs00yXnmg2AaT++12UddDlW4BXGt9ZCQaZq5dZKWQ4keoNhrtx6pR1vXXAmbBd4BqfD
         A9Uc7A7FtNbDKCk1bfi6XaujDL1mtI2Oq0h7BLexvItFO1CMm4yzn7xxbl3GmYnRhnAG
         WU0CRFuEfQvAdL62z2NAzLKAR4O0ybmNvLaA5alvFNEQzZhyWp7KQ56HSf3SpgQ5qTu9
         DWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=zDiIYZe9YgJwUztyp9RS8IzxicvfUrBoFsHgDcnHlNQ=;
        b=PXT+DFiFlCq3pyNQKiMrRV57ENheVypaXMn/2EdGO2q0hCiInin8LWptNLK1GUhlAk
         ybEiXNP8tkyF1hXMfbqpzl1UY7zJLQO2IUuLxJhPuO87n/dQZ9Up+/B5pAViO970azox
         lWP+T3GXl3h0ksQP3pvrNTk4i/slCz+4a/0BmzABDU3gvSfYvKxS4T9QCwTg2OfHwaB6
         ghTDghT5HAp4kOWpHgw/1d1dTN2ctGZPHjNyVx2u51C+uoM2ZpNOOV6jPBj4Qwueawgr
         F1S8k+d6Tvu4BMSUxMBCnrl58xJHdlKVcU7CCMOCYF1JH7Y/LVwVaBUYkIMh8xKA/7NS
         zSWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PO0yyAel;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PO0yyAel;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49Yu7BOf+J7iBta13yXJVgqhSJ2EDvz++6NR6bZ47gA7nrsFzrHoXBAlo/zvQuWUciQCCF0nQ==
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
Subject: [PATCH v5 05/23] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Date: Wed, 18 Apr 2018 16:31:39 +0100
Message-Id: <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098781495174847?=
X-GMAIL-MSGID: =?utf-8?q?1598098781495174847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add DT bindings for ADM (Audio Device Manager) DSP module.
This module implements mixer controls to setup the connections between
AFE ports and ASM streams.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
new file mode 100644
index 000000000000..f1e2df8d2ea8
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
+	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,adm" where the version number can be queried
+		   from DSP.
+		   example "qcom,adm-v2.0"
+
+
+= ADM routing
+"routing" subnode of the ADM node represents adm routing specific configuration
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Must be 0
+
+= EXAMPLE
+q6adm {
+	compatible = "qcom,q6adm";
+	reg = <APR_SVC_ADM>;
+	q6routing: routing {
+		#sound-dai-cells = <0>;
+	};
+};
-- 
2.16.2
