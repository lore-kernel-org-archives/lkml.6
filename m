Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51DDC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749692082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749692082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arcx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJXXIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:08:50 -0400
Received: from mail.arcx.com ([184.94.50.18]:27680 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbeJXXIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:08:32 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 19:08:27 EDT
Received: from svens-asus.arcx.com (192.168.2.132) by WEBMAIL.arcx.com
 (192.168.2.64) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 24 Oct
 2018 10:26:18 -0400
From:   Sven Van Asbroeck <svendev@arcx.com>
To:     <svendev@arcx.com>, <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <afaerber@suse.de>, <treding@nvidia.com>,
        <david@lechnology.com>, <noralf@tronnes.org>, <johan@kernel.org>,
        <monstr@monstr.eu>, <michal.vokac@ysoft.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <john.garry@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <geert+renesas@glider.be>,
        <robin.murphy@arm.com>, <paul.gortmaker@windriver.com>,
        <sebastien.bourdelin@savoirfairelinux.com>, <icenowy@aosc.io>,
        <yuanzhichang@hisilicon.com>, <stuyoder@gmail.com>,
        <linus.walleij@linaro.org>, <maxime.ripard@bootlin.com>,
        <bogdan.purcareata@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document devicetree binding.
Date:   Wed, 24 Oct 2018 10:24:54 -0400
Message-ID: <20181024142456.10084-3-svendev@arcx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024142456.10084-1-svendev@arcx.com>
References: <20181024142456.10084-1-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.132]
X-ClientProxiedBy: webmail.arcx.com (192.168.2.64) To WEBMAIL.arcx.com
 (192.168.2.64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree binding documentation for the
Arcx anybus bridge.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../bindings/mfd/arcx,anybus-bridge.txt       | 37 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt

diff --git a/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt b/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
new file mode 100644
index 000000000000..3c0399c4ed45
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
@@ -0,0 +1,37 @@
+* Arcx anybus bridge
+
+This chip communicates with the SoC over the WEIM bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the WEIM bus used for communication.
+
+Required properties:
+
+  - compatible : The following chip-specific string:
+        "arcx,anybus-bridge"
+
+  - reg :
+	weim memory area where the cpld registers are located,	followed by:
+	weim memory area of the first  anybus-s slot,		followed by:
+	weim memory area of the second anybus-s slot.
+
+  - enable-gpios : the gpio connected to the bridge's 'enable gpio'.
+
+  - pwms : the pwm connected to the bridge's 'pwm input'.
+
+  - irq-gpios : the gpios connected to the bridge's interrupt lines.
+	note that there is no need to provide the 'interrupts' property here.
+
+Example of usage:
+
+&weim {
+	bridge@0,0 {
+		compatible = "arcx,anybus-bridge";
+		reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+		enable-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		pwms = <&pwm3 0 571>;
+		irq-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>,
+					<&gpio1 5 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..1bf07b20a8af 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	Arcx/Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

