Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870871; cv=none;
        d=google.com; s=arc-20160816;
        b=xaS8t/Q7qUU61wVy5/bKLcuAYhk8shIKj5DtB2Vdjujc253LBq1+iKjG3AyrZeTlWQ
         lyw7vX3w8No7wGSG71VomE+3ZrPM2uwc73VigfoWoFrOof1UBe9s6OdxoS4C8cTch/yn
         kpsaEZq2DOkpGYhNnNHeKL6TkoKoDne1e44pLdEStTBwSu8GVmKXnjpyBjk7gEPx2/SO
         3LDwXT8j+lI/1I3yaM+vcKsoeqEKzAjhoWFUbtAFR3LM1WOK+XIXl3Y9A1GRGotyaJbE
         MHL+y/SfkWTshVnzfx/zDlxIgJFEJujY5oWcJ/v1Eod8L+lwA06IboziNBsqCTH4of/y
         97Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=imnKv9jDQU2mTARRpMRZZCzAYAHZVTLw5zVbbDhLByk=;
        b=batfNlvrnMO2pQO7QIq9QVfCnMP1bNIAvwzuQAC+6uyP0+vPwLWz9odIkp8dePdV5C
         vkSVlxAIimaLf6QjrJvZP+U0wTCyikcP8y+WtNRLbVk6g9Hj7kAnlfvs1o6bezffr6mR
         uHV1CsdnXjC0atC8jYHk8LeoMfwgwYCaYLR225M29o2WasiMMDRdBPS0mTm9AUw/TV86
         2ynMzdqexpUM22yuLh97rpVEEGwwpjz6zBIe/hDd9LmS11lQ4jeLkgSACQLv1LOjo93z
         7pe4wMFf6SNRcB+SgQ5wVRepBqcRhhQH73//94ldohfVW6jkY9KtZjv8x8TCuug40lOL
         Zrkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cqF/H6X8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cqF/H6X8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr7eHP2IH3X9CIeWMn7mhUPbQfoVXf6XH3o9w09T131LHnNPRRAJjmn/Q+PhD5P2To3MNMmnA==
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
Subject: [PATCH v8 22/24] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
Date: Wed,  9 May 2018 13:56:33 +0100
Message-Id: <20180509125635.5653-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599991575082816627?=
X-GMAIL-MSGID: =?utf-8?q?1599991575082816627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt     | 109 +++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 000000000000..aa54e49fc8a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,109 @@
+* Qualcomm Technologies APQ8096 ASoC sound card driver
+
+This binding describes the APQ8096 sound card, which uses qdsp for audio.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,apq8096-sndcard"
+
+- qcom,audio-routing:
+	Usage: Optional
+	Value type: <stringlist>
+	Definition:  A list of the connections between audio components.
+		  Each entry is a pair of strings, the first being the
+		  connection's sink, the second being the connection's
+		  source. Valid names could be power supplies, MicBias
+		  of codec and the jacks on the board:
+		  Valid names include:
+
+		Board Connectors:
+			"Headphone Left"
+			"Headphone Right"
+			"Earphone"
+			"Line Out1"
+			"Line Out2"
+			"Line Out3"
+			"Line Out4"
+			"Analog Mic1"
+			"Analog Mic2"
+			"Analog Mic3"
+			"Analog Mic4"
+			"Analog Mic5"
+			"Analog Mic6"
+			"Digital Mic2"
+			"Digital Mic3"
+
+		Audio pins and MicBias on WCD9335 Codec:
+			"MIC_BIAS1
+			"MIC_BIAS2"
+			"MIC_BIAS3"
+			"MIC_BIAS4"
+			"AMIC1"
+			"AMIC2"
+			"AMIC3"
+			"AMIC4"
+			"AMIC5"
+			"AMIC6"
+			"AMIC6"
+			"DMIC1"
+			"DMIC2"
+			"DMIC3"
+= dailinks
+Each subnode of sndcard represents either a dailink, and subnodes of each
+dailinks would be cpu/codec/platform dais.
+
+- link-name:
+	Usage: required
+	Value type: <string>
+	Definition: User friendly name for dai link
+
+= CPU, PLATFORM, CODEC dais subnodes
+- cpu:
+	Usage: required
+	Value type: <subnode>
+	Definition: cpu dai sub-node
+
+- codec:
+	Usage: Optional
+	Value type: <subnode>
+	Definition: codec dai sub-node
+
+- platform:
+	Usage: Optional
+	Value type: <subnode>
+	Definition: platform dai sub-node
+
+- sound-dai:
+	Usage: required
+	Value type: <phandle with arguments>
+	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
+
+Example:
+
+audio {
+	compatible = "qcom,apq8096-sndcard";
+	qcom,model = "DB820c";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afe HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6adm>;
+		};
+
+		codec {
+			sound-dai = <&hdmi 0>;
+		};
+	};
+};
-- 
2.16.2
