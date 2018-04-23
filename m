Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4/aNUx0R2wt1/N56yjqmUex68HFrbb98Q3b/stTwVWhETgo180E636nBBEzdXtq0CL+5d0V
ARC-Seal: i=1; a=rsa-sha256; t=1524497541; cv=none;
        d=google.com; s=arc-20160816;
        b=damiNFGPa9C95p2uwDQL8bIzaEGX7ujLfl/bOGx6K/a4tpVn62f7PnqLHZe5PJXCJ4
         6Vdi5n9WEm+dwRDYCxbNpgbQp4MI15ekJOZwmSLW7KpEJ4tzd9TM0UvQthH2xQKmedHP
         wj59a2m7UckrF2vrJq2ugRvsidxv6JAwTPwtYXW8iX95iSi3irJScDZalf1ySTSDzD0Z
         96mtaQK/QZYUf7nLcSXAZVWIa/wduKpbEt+0Al52LS4bhQrxlj+ezN9UoxTHsYKb/O7U
         yyhsTiTN4Oo1+hDw5T9qr0W/MYXPoD9D7DRRjHrNlSUxSMqpLOIrQ9vAuLiiUKyMEIhc
         ZXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g6AgxHZ1zl69hgws8MkAuWnst7Vljjb20Qunm16rvPE=;
        b=Gn1omduYatrFFG+YX6w/FOpFTcBTOo+xCDcwfCZ+866F1RXXm30TyYRex0aWifODuj
         Tc66YfcHO47JaTIPXkDEuNEVcSwVa3jcvLrIYtri/BwLY69Hei+i9kF6++pZarj5s+mN
         d8bbNZ4A/L3rvRL7O6oHJmnSyy2x6P+ap6FoVD/fD6qkj7DqMQTX0yaWXAmSANIVoRfa
         dnOgoivWbXfESbd0Ev/hTO+eyKZMrEUYvfBAO4QaM0T2e3BsjSzdaIT+3mtw3my0yxy/
         ZxsSfMfQCwPG4qCvybiEwHx+P2XG6De+6vD1dygWyTNjPZi/cWPeMzo+AHSmNGsvdve1
         m7ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
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
Subject: [v2 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
Date: Mon, 23 Apr 2018 17:32:00 +0200
Message-Id: <64ca273429d92f581568a48f3efe6035af65f579.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551533740239589?=
X-GMAIL-MSGID: =?utf-8?q?1598551533740239589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
