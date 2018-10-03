Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C27C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851082082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851082082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeJCULE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:11:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeJCULE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:11:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 755B820890; Wed,  3 Oct 2018 15:22:35 +0200 (CEST)
Received: from bbrezillon.fritz.box (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id AA16F208B5;
        Wed,  3 Oct 2018 15:22:18 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v8 08/10] dt-bindings: i3c: Document Cadence I3C master bindings
Date:   Wed,  3 Oct 2018 15:22:10 +0200
Message-Id: <20181003132212.12619-9-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181003132212.12619-1-boris.brezillon@bootlin.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Cadence I3C master DT bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v8:
- None

Changes in v7:
- None

Changes in v6:
- None

Changes in v5:
- Add Rob's R-b

Changes in v4:
- Fix example to match the new representation
---
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
new file mode 100644
index 000000000000..0e2b8b8770bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
@@ -0,0 +1,44 @@
+Bindings for cadence I3C master block
+=====================================
+
+Required properties:
+--------------------
+- compatible: shall be "cdns,i3c-master"
+- clocks: shall reference the pclk and sysclk
+- clock-names: shall contain "pclk" and "sysclk"
+- interrupts: the interrupt line connected to this I3C master
+- reg: I3C master registers
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 1
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-hz
+- i3c-scl-hz
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c-master@0d040000 {
+		compatible = "cdns,i3c-master";
+		clocks = <&coreclock>, <&i3csysclock>;
+		clock-names = "pclk", "sysclk";
+		interrupts = <3 0>;
+		reg = <0x0d040000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-scl-hz = <100000>;
+
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52 0x80000010 0>;
+		};
+	};
+
-- 
2.14.1

