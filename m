Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932353AbeBTBnx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 20:43:53 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35715 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeBTBnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 20:43:50 -0500
X-Google-Smtp-Source: AH8x225R6sZeYcIQzCQ6WEez1TQJuzcfHOzM4+pN/MPlpACR0n+go+0m7xbNS51I4Za7TdATctLYyg==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Add reset controller
Date: Tue, 20 Feb 2018 12:13:28 +1030
Message-Id: <20180220014330.23425-2-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220014330.23425-1-joel@jms.id.au>
References: <20180220014330.23425-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the reset controller present in the LPC address space.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
V2: Fix spelling mistakes
---
 .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 514d82ced95b..9bdd3e8c91ec 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -135,3 +135,24 @@ lhc: lhc@20 {
 	compatible = "aspeed,ast2500-lhc";
 	reg = <0x20 0x24 0x48 0x8>;
 };
+
+LPC reset control
+-----------------
+
+The UARTs present in the ASPEED SoC can have their resets tied to the reset
+state of the LPC bus. Some systems may chose to modify this configuration.
+
+Required properties:
+
+ - compatible:		"aspeed,ast2500-lpc-reset" or
+ 			"aspeed,ast2400-lpc-reset"
+ - reg:			offset and length of the IP in the LHC memory region
+ - #reset-controller	indicates the number of reset cells expected
+
+Example:
+
+lpc_reset: reset-controller@18 {
+        compatible = "aspeed,ast2500-lpc-reset";
+        reg = <0x18 0x4>;
+        #reset-cells = <1>;
+};
-- 
2.15.1
