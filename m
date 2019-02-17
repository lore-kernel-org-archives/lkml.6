Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C08CC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7B121916
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfBQO2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:28:24 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38699 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfBQO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:28:22 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EC8621BF204;
        Sun, 17 Feb 2019 14:28:17 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 4/7] dt-bindings: power: supply: Add docs for Ingenic JZ47xx SoCs battery.
Date:   Sun, 17 Feb 2019 15:29:13 +0100
Message-Id: <20190217142914.17433-4-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217142914.17433-1-contact@artur-rojek.eu>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 .../bindings/power/supply/ingenic,battery.txt | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
new file mode 100644
index 000000000000..66430bf73815
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
@@ -0,0 +1,31 @@
+* Ingenic JZ47xx battery bindings
+
+Required properties:
+
+- compatible: Must be "ingenic,jz4740-battery".
+- io-channels: phandle and IIO specifier pair to the IIO device.
+  Format described in iio-bindings.txt.
+- monitored-battery: phandle to a "simple-battery" compatible node.
+
+The "monitored-battery" property must be a phandle to a node using the format
+described in battery.txt, with the following properties being required:
+
+- voltage-min-design-microvolt: Drained battery voltage.
+- voltage-max-design-microvolt: Fully charged battery voltage.
+
+Example:
+
+#include <dt-bindings/iio/adc/ingenic,adc.h>
+
+simple_battery: battery {
+	compatible = "simple-battery";
+	voltage-min-design-microvolt = <3600000>;
+	voltage-max-design-microvolt = <4200000>;
+};
+
+ingenic_battery {
+	compatible = "ingenic,jz4740-battery";
+	io-channels = <&adc INGENIC_ADC_BATTERY>;
+	io-channel-names = "battery";
+	monitored-battery = <&simple_battery>;
+};
-- 
2.20.1

