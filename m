Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx4+HrWtuIDtY4PQ66bLEHpfN3GryxxM7eWrqIoKyEKy89N4ff0LjFu5vw5WGC2a/lg0ZpG2T
ARC-Seal: i=1; a=rsa-sha256; t=1524563246; cv=none;
        d=google.com; s=arc-20160816;
        b=MRbQZh/h08JD8N9pdA/toWSvg1GCrNdmOhbZsqafT6zPIWD1f5dwnBRQjdHIAVtpXH
         0bAR/3a1K9BlojrFmNeyQ2vXxgNoLpTjCRnM7I1EvJNW/6vp7ETv7Wr340ZECFveUVsX
         /2HiGFI1MXbS4cTC4OKykL/qmv5oDNRCMrYB6ri/u9FNJ6iJDr6w8XmsMJE7TRuX5x2U
         dAfK6CLhw82TyVSna+NW3vmS6FawYW5S5B33EFIgG40en3bfoAIOytGhtZYvn1kguJYT
         R/9Fa7qP58RlPrE+l5UK3s6FQ3KxO7K3sYoQ8dOo8D5m9XMiBsRxr3Rw1oXzN31w6h0g
         C4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kLI6u4KSiyvGQAn3x27W8E6xfBDxk2P7Zr37uf9uMMs=;
        b=ZEsygacPbmWFDedDLqG6LVpTnd/ACxUtKSBOzk9bG932itklygHMGo6eB+guPV1MMH
         /dMXKSlKyZ8qTAB/+lBfIlwVijZ5KcAnSZvcgfwlUod6kEtSX2F7Akh9SU/4UTT8J+O+
         xxS7rPh50ZlLvHvvMtRSRtdN31DRe7cNP/SQ4iYRqbyzi8FKOO+4aa9iu3BUdNLl2/h4
         0MDdZv4i2CPG61Ehl5d039wtvgcOeJ6O81ILPvScA8Whpn/ypWKOUliNxFma9SqaYsQi
         dRAe9Zd/9+2eK5d0WbCdZgCzW1Z4x018nrD+J4JFfo3mGp/07vbWdmP4mJp4oLXigvLW
         ooIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6E7217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 resend 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
Date: Tue, 24 Apr 2018 11:46:58 +0200
Message-Id: <64ca273429d92f581568a48f3efe6035af65f579.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620431128515385?=
X-GMAIL-MSGID: =?utf-8?q?1598620431128515385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

Add binding description for the mmsys mfd for some Mediatek
devices. mmsys has some registers to control clock gates (which is
used in the clk driver) and some registers to set the routing and enable
the differnet blocks of the display subsystem.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 --
 .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
 .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 4eb8bbe15c01..4468345f8b1a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -6,10 +6,8 @@ The Mediatek mmsys controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
-	- "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt2712-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
-	- "mediatek,mt8173-mmsys", "syscon"
 - #clock-cells: Must be 1
 
 The mmsys controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 383183a89164..85a3b4ec06cd 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -9,7 +9,7 @@ function block.
 
 All DISP device tree nodes must be siblings to the central MMSYS_CONFIG node.
 For a description of the MMSYS_CONFIG binding, see
-Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt.
+Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
 
 DISP function blocks
 ====================
diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
new file mode 100644
index 000000000000..2331ae16917e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
@@ -0,0 +1,27 @@
+MediaTek MMSYS Multifunction Device Driver
+
+MMSYS is a multifunction device with the following sub modules:
+- clocks for the multi-media subsystem
+- central node for the DRM subsystem.
+
+This document describes the binding for MFD device. The MFD takes care to initailize
+the clock driver and the DRM driver. More info see
+Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+
+Required properties:
+- compatible: Should be one of:
+	- "mediatek,mt2701-mmsys", "syscon"
+	- "mediatek,mt8173-mmsys", "syscon"
+- #clock-cells: Must be 1
+
+Optional properties:
+- power-domains: list of powerdomains needed for the subsystem to work
+
+Example:
+
+mmsys: clock-controller@14000000 {
+	compatible = "mediatek,mt8173-mmsys", "syscon";
+	reg = <0 0x14000000 0 0x1000>;
+	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+	#clock-cells = <1>;
+};
-- 
2.16.3
