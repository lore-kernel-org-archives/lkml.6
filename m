Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524736201; cv=none;
        d=google.com; s=arc-20160816;
        b=cnAAP1xQg0CEx0jq4S7QFJr4OuNAAw/bt5qrs/zvnwj5wNmU/wkUttRlwpSRNUvnDe
         dQOaYVEFfSy2OGDnAWJZnzoAuxQJGnsMiTe2FVLp3rTR1rCWHDRQkVua+sxETMnopHNP
         HudtpbHxIIASNZABVbsbDaOwH9aBXSek986GeYXK1VXGe3Nc680tYCh1CocQigyWKhBq
         ywkz3857cqUZRkmbKHCevUq0zTBcuUQ9sBgpN5m5MI2h/jSgUD6X7dn6gr6hj+HR6YMU
         fKISzU+IqHg7xpQTFtYTmFF1LPPuUGIJpPatJxyIXHny2hF32ONXl4EpqQZd8ZqZSIFy
         y7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Akk0CFdFzuBeUJ4EiX/zxUJWGT6AWy0ZdV3sw7FfXLw=;
        b=WfGuNZX0bzol7N+vENVC+t2dIZrCWBkHR/fFqT6eddKcfwPIwI/nFQg2ccZWyU2xMV
         I1tZ0WssbKCfhm9pbywVrtDndD70Ul4EBMVk6fowKokFKRyrXD2RAeL0WbfnVhxt5MxE
         Mjl+MXZvbn6bfiYlfBxqmAYKmfIvmZR5xQJQDKQfTF0PmwF6ujQ8BxZJajEZNERfz9VJ
         KUWSUD56ziaAgaEe2I4HQFzCWfV4o9lLalovAs68wIeqmxpK/ISAmc8K/MbXFdXjVWIM
         JW3TYvRfR6XUdHCq3sPJKS5IQWY0CBR1dbmGkjrDBp/PcjclRsAOYt5Yg2hP12M+/OaX
         eEWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cwbhRblL;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=cwbhRblL;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+zVcqrC6y6aM1kCUkNi4OVgjSAOaORapoomkYR9LI/9vPXSWYwX/bklC/4THo1qwu7bMiY4A==
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
Subject: [PATCH v6 22/24] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
Date: Thu, 26 Apr 2018 10:46:04 +0100
Message-Id: <20180426094606.4775-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801787140996997?=
X-GMAIL-MSGID: =?utf-8?q?1598801787140996997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
