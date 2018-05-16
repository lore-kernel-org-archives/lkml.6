Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526489647; cv=none;
        d=google.com; s=arc-20160816;
        b=ToHKKZkRsBhikFw092gUZLpNvtBUS1d4kXqQit5J/+YrBBaISDAxHvOYQTWftZ15jm
         N9so/lYymsE0li6eSOqM5DLJNClMIcFYGT/bwcBgBcWbcY9mHCk4NqnuMzedPy1IF3qh
         Xl5bCeoN4O2tTNKxg/CjL2a15yTAPth3PvEDLeRxBjwypSjG+HJsSDBedh6XjznHLCV6
         1P9Ht9aChRz9Prcq2f8umPSjEq+iSDQ7F3l5xLy45GPhEpyPkFkw+sP3f+CZkr90dbo3
         hkRPZZ63zI6a2ffBVFYwtAOIoBkIIkoHkFfr22TrR52zTbijbf4vkd6l5/GASb3B4iRu
         5VSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=E4lDnXLAr1lokfRTltHvC0OJOJ5rsLEbgIB6IjxX+Ow=;
        b=fkDLeM5ihuuGWI1C7X4se+ExeBnQJtZVhoKPColU5zc3kMyLrjRpMiOVeR1+NQpvTM
         /p1VBk1Iw4mothfVZI4ISmlZG4fHspXVPnvsBuAEuGX0sLK/SwfOkIgj0lAZkhxiS4jv
         WDscv0NfNhMiGnIbbJ0JLYYvYme4Nfweu20vjLVCJw9iFvSF2xbkvAOG8cuGRAZJs7O7
         Hd7u1bCW6t07qZtWCcXHfemb0PM0dfakIUCai95h7oqrViGEyZyjSwKts9sOnGwqRLCh
         0kZa7PCbjWfbnKo8I4d6HC7gjX0xErovMS7w05dR6T5Rnh2RnoSSoBasRCY1LsgifMZ7
         PVxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XA/uBrR3;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XA/uBrR3;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrBLjWftkCmH5UZJsQR3zVwrkETKCTM/4xbmjAE93mMKQTrrdhXxSdBVR/t8Fu0jsgDs6QDqQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org
Cc: kramasub@codeaurora.org,
	sdharia@quicinc.com,
	girishm@quicinc.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	bgoswami@codeaurora.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
Date: Wed, 16 May 2018 17:51:17 +0100
Message-Id: <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1600640408468818070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds bindings for Qualcomm SLIMBus NGD controller found in
all new SoCs starting from B family.
SLIMBus NGD controller is a light-weight driver responsible for
communicating with SLIMBus slaves directly over the bus using messaging
interface and communicating with master component residing on ADSP for
bandwidth and data-channel management

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
new file mode 100644
index 000000000000..c948fb098819
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -0,0 +1,70 @@
+Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
+
+SLIMBus NGD controller is a light-weight driver responsible for communicating
+with SLIMBus slaves directly over the bus using messaging interface and
+communicating with master component residing on ADSP for bandwidth and
+data-channel management
+
+Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,slim-ngd"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the controller
+		    register blocks.
+
+- reg-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "ctrl"
+
+- qcom,ngd-id
+	Usage: required
+	Value type: <u32>
+	Definition: ngd instance id in the controller
+- dmas
+	Usage: required
+	Value type: <array of phandles>
+	Definition: List of rx and tx dma channels
+
+- dma-names
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "rx" and "tx".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list controller IRQ.
+
+#address-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+#size-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+= EXAMPLE
+
+slim@91c0000 {
+	compatible = "qcom,slim-ngd";
+	reg = <0x91c0000 0x2C000>;
+	reg-names = "ctrl";
+	interrupts = <0 163 0>;
+	qcom,ngd-id = <1>;
+	dmas =	<&slimbam 3>, <&slimbam 4>;
+	dma-names = "rx", "tx";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+	codec@1 {
+		compatible = "slim217,1a0";
+		reg  = <1 0>;
+	};
+};
-- 
2.16.2
