Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753AAC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEA120853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEA120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeJVVx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:53:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51062 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbeJVVxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:53:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4415A2090A; Mon, 22 Oct 2018 15:34:27 +0200 (CEST)
Received: from localhost.localdomain (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1BA49209DA;
        Mon, 22 Oct 2018 15:34:11 +0200 (CEST)
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
        Joe Perches <joe@perches.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v9 9/9] dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
Date:   Mon, 22 Oct 2018 15:34:04 +0200
Message-Id: <20181022133404.2061-10-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022133404.2061-1-boris.brezillon@bootlin.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Cadence I3C gpio expander bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v9:
- Add Linus R-b

Changes in v8:
- None

Changes in v7:
- None

Changes in v6:
- None

Changes in v5:
- Add Rob's R-b

Changes in v4:
- Use GPIO_ and IRQ_TYPE_ macros instead of raw numbers
- Fix the unit-address in the example
---
 .../bindings/gpio/gpio-cdns-i3c.txt           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
new file mode 100644
index 000000000000..d0155a9cea79
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
@@ -0,0 +1,39 @@
+* Cadence I3C GPIO expander
+
+The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
+This GPIOs can be configured in output or input mode and if they are in input
+mode they can generate IBIs (In Band Interrupts).
+
+Required properties for GPIO node:
+- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
+	Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
+	more details.
+	Should be <0x0 0x392 0x0>.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity (GPIO_ACTIVE_HIGH or
+  GPIO_ACTIVE_LOW)
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2. The first cell is the GPIO number.
+  The second cell is used to specify trigger type and level flags.
+  The following trigger types are accepted (see
+  <dt-bindings/interrupt-controller/irq.h> for their definition):
+	IRQ_TYPE_EDGE_RISING
+	IRQ_TYPE_EDGE_FALLING
+	IRQ_TYPE_EDGE_BOTH
+	IRQ_TYPE_LEVEL_HIGH
+	IRQ_TYPE_LEVEL_LOW
+
+Example:
+
+	i3c-master@xxx {
+		...
+		i3c_gpio_expander: gpio@0,39200000000 {
+			reg = <0 0x392 0x0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+		...
+	};
-- 
2.17.1

