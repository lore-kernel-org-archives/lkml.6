Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526648335; cv=none;
        d=google.com; s=arc-20160816;
        b=HMpBngivNGdTpnJT1M8keTEWa4vmmaKUrn/GlndyVLun/tK3NYagSi7ey7isUdtw/L
         j7aLTAZSiJVqiTytCOMwUyQ+RtUIN2eqroVSzC9Gq58RFTzKzGcx/W8ZKOJoxaXQj3IV
         3eFvx+eeJauEeVOoDP9avPPcQQBIpZKJVSUej+FQyZAWi9ggYu307nRFfgiEAmlr+QjA
         gxKsm9Q0yEtHAcZkEYKHm/xZnpB6sKilu9TOzm0cfEA02aNXBa6EmRPRpzRFqOurfCOh
         m0WWGYRe0qUwGt7Ikx0Eb0hijHolb9PPzNoEaRDXrGDMk2WP90+2d9YRrd2n132CTwIO
         UDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=imnKv9jDQU2mTARRpMRZZCzAYAHZVTLw5zVbbDhLByk=;
        b=0rf9Cj2OTg+FYczzOGAFqiHyOf8tDEXujB74pdD4AJ7BvM6NdFQ6AbAcIzxN9sMXhT
         JfqP+J4WEkQJRL7g++AFfNKfcOd+BjcJnInxgDs+JnC92pKy72b+PEAjdpO/PMHGfCDu
         MVpGChylHPoyOOCjohf29Ly1UXN0IWfhQvruE5hZosBN9qEyXLCbDCp9rm2314RmO4U4
         bLFy8W6Ek+OFW1NMV7VvgKpjThTwV/7sCB5sQur18e1LKUxw/aD8irMxQ1NA2y0ACQiX
         h637dkFem13tq3/Zptpp9+Xf/NYMIE4zFr1G9R6pYevgqpFbb8+5X5L4bfhLAtA9AKp+
         NE8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TUX4TfmM;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TUX4TfmM;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpWirQzLd4iOVIv0HfCyEsLGBds/U8g9ksFBt5Gm1LEO+Ay99WhGBD5Lum09H7rgUcniFXF/g==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org
Cc: robh+dt@kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v9 14/15] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
Date: Fri, 18 May 2018 13:56:09 +0100
Message-Id: <20180518125610.26200-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
References: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600806804804321710?=
X-GMAIL-MSGID: =?utf-8?q?1600806804804321710?=
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
