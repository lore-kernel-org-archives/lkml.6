Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524065784; cv=none;
        d=google.com; s=arc-20160816;
        b=TACX4WTdNV32n4J84cfyWwxrx6vmNKUC8pkV/AqAcMOUGuOEIsvYxUIsMjgytHp8FW
         T7mMaR057Kt5bpDDJlsi/158QmI3Ax4yCMHsSe+TsM4go0m3BHjDRxS/OEIGSBYv7cAP
         Jg7b+HzyN/t5NY6Skb00donMmKggfmkXDwtoPpg2owuOfrPPCNS2q2eLYVTjknNHwFjM
         RdElKXfnbgtRJNJbrHGJW7eZZe3VI1p6gD3IrP+Yk1gRiNci14/YbQwBVGmKpbo98x3K
         YYrjE/7TChrYkr4VYuYxI/rDWw5rMwzmFR6wJYTb3wmBeIY0YV4ZZrfKJ2qApnTP4JKd
         zBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=XaHBWgy3j0+Y7G9ortinpn5q73PgbiSR1+PZ2JymhGQ=;
        b=x65NR4pNBFmOrWFuR+LcbpiO0I/5Jk1QqNGEqyk30J6paIZX6OPkpfBxJ3wT1zdqXm
         gcp0PAM20D6SUMJ24ExSicdjOd9CKGQScR80IhCsuDQpVVLXD7o6f7pThCpeiyV/QFub
         ZKlbV1fZeRs48Ha8eLwPN4WmAqCwbAT1o1hpQ4T+VVr2bJsv0Nb+ZA6vmkgutaOpmDxg
         COW9UwCJbnXcXV20xz28OeS9DcTCgOcHinkdMPMNxvlU0gDhmeVLFtm0WLyi3rQr6KYH
         KMeAbXVg3mTjWpPTlPEs5HWVBYXiwH5KKm3XxrT2CdE7tlnLL/+sK3hNrFfikEeGmNZG
         pEAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hFVRCNeL;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hFVRCNeL;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx498V5D6Wa0yOPccgLoQ9GqHWJt0xfDrbL6FAVPbvX4iXMWNZ8JdCRO9R/dcZnzYte+ry9P7sA==
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
Subject: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
Date: Wed, 18 Apr 2018 16:31:55 +0100
Message-Id: <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098804369863616?=
X-GMAIL-MSGID: =?utf-8?q?1598098804369863616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add devicetree bindings documentation file for Qualcomm apq8096 sound card.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,apq8096.txt     | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
new file mode 100644
index 000000000000..37e23d926b95
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
@@ -0,0 +1,76 @@
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
+	Value type: <phandle>
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
