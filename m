Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176655; cv=none;
        d=google.com; s=arc-20160816;
        b=QqS2K7nmRj+oz4dBdwXY17B+6aPfon2/N8SvTWPSEoQAgCfMgYRAfvAcV84J9oZQNg
         vhs8OyDFA+F88gr0bXEhNTOZWqQMrsMscqam2/CmhIRHfO9ui89qFK4kD7ULYYhjCQON
         Z9lIvYqYpDIsousS9QQtsFnMVEQ5DyRN3xYmQ+Cz1WlvZSy2WFINkWhjyIHEyU9BQLC3
         hTXGWXHc/eYYLQRChcSJ+Kpj+DfZhhN/N+B3l4lvGRt0daYVfk+A3vjSzti2tV4INxST
         F/fzurJILUV21yKk9NVPfjDEFFGGqBNap/pYV/KIOaxu6hG4/WwA6AXVYzTT0A0hE46R
         syGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=esBgSZpLGS2jwYmdKDmOgrvvREEN8KClE16LSHAgf0I=;
        b=Mx5WIXbL8Bje96MT86czdfsFHZkfFbLRmDOxHXVg6yesrdQaPwjp8UxRJY9Eu9VSyA
         5uXjwy/B404uGJpjvkha89HGoNeuf4e2rLzVnUMDtouVn/bJiNYy/j4LLxnB7MEXXDyK
         flROWs9ewvtKEpYdifVe3QmVuNjXSVC/uf1sGMg0/0CuYbuOpmyBhibf/wG0r7zuxc02
         hAB+X/vCuDhnfDLLzP2yxQwAXuuOCaUOZxBKFip2r0ZV6Ux+4CjdL6wzpa0971me2UfA
         +iLkuoav1gAMge4VzYnC/9DReM+f/ikk7q7/ne6bZRGp0xx/rP9Qj2UP3sozo8elAGht
         XwZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GQBIBwZe;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GQBIBwZe;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoA7JjS9HLR8GMXJkxlaqUY4fTtvN1+vsBT7G+gHrpGprrHSd30KUqWQyxy157N7mJNOE6hOw==
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
Subject: [PATCH v7 22/24] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
Date: Tue,  1 May 2018 13:08:18 +0100
Message-Id: <20180501120820.11016-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263637622824757?=
X-GMAIL-MSGID: =?utf-8?q?1599263637622824757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
