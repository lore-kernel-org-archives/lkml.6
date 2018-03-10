Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648889; cv=none;
        d=google.com; s=arc-20160816;
        b=ZwYLFKNz8qBaCoDn6kxbyqFaWRUxW/udU5t+uQy/Uagfoh6hwiZ7t2igdOhasevsO5
         B/oNZaDNtYqge3zcdxkaZ4QeTcJdQfvYIP0NhVPx/rlnjoz4QQREban2iLaS1/75a1PA
         2uR8PZCEql9tkgL7FHp+xoMILbaDjYqjlio6jQEfH24OTV6SMsnTqIn6nfASL1NxwFYN
         nHi3bWQVYYAEOBI2ScOqPCpUC+ngR/onVhmD8SY++Tz/oDscZ1+WyT7IDLfgXpPzDVp/
         Mhde+JYZDCFnefH5CAKOOultnTPFFJW5EnyJoRv4RnLaHeRte7iPgX+xYpeGp9rmDoCg
         dp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=i4Y916wk5L2VlZbsmuAzdRY5cI59LTGgrN2x6Srlrr8=;
        b=BeKLMRrSm99QFPfXklhUHkZGtwrbxY4ba1rdU6ZdejibyUeKODx0N2R+pRsAKeP+Td
         ezXFPTh7zRSPSTRDiIlSXEiYIrsjIFxJheiYGLUGeKzQ7gk3P9rq43ux+Di4RXFTqRUR
         eaKjFSuE1OlgbkA43kAmr9VwD/ldOTrnONYZq9ClTIH1LaCWnF4xXYaRtfonFyJWiCV0
         VenuPVMKOPxBSvwYFasy9eiy8QzYuKbKBbrpcuIZf9W9LHR7Y4MgXzJN6C7xH2yompZC
         4D6u0Pgl5hQP84gbTkpjDGqAeo711vMhPiKk4Snj8CUSCzAkacsSRiD7ZwxKT7KXKfKa
         D6ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=P6cws3LA;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=P6cws3LA;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuD+KxjPZ4pk6hrTZoFcy8dTIT9l0B7T8XWzLpWE2APvmgm8MB87V/HjTcromcaGt38QJAn1A==
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
Subject: [PATCH v4 21/24] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
Date: Sat, 10 Mar 2018 02:24:53 +0000
Message-Id: <20180310022456.26739-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515929588146643?=
X-GMAIL-MSGID: =?utf-8?q?1594515929588146643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt     | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 000000000000..fddc9f0ce3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,80 @@
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
+
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
+	Usage: required
+	Value type: <subnode>
+	Definition: codec dai sub-node
+
+- platform:
+	Usage: opional
+	Value type: <subnode>
+	Definition: platform dai sub-node
+
+- sound-dai:
+	Usage: required
+	Value type: <phandle>
+	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
+
+Example:
+
+audio {
+	compatible = "qcom,apq8096-sndcard";
+	qcom,model = "DB820c";
+	com,audio-routing = "RX_BIAS", "MCLK";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+		platform {
+			sound-dai = <&q6asmdai>;
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
2.15.1
