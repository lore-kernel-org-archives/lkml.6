Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF720C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E34217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfBSRCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:02:11 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50045 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfBSRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:02:09 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id CC8FB1BF20D;
        Tue, 19 Feb 2019 17:02:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/7] dt-bindings: clock: at91: new sckc bindings
Date:   Tue, 19 Feb 2019 18:01:54 +0100
Message-Id: <20190219170200.3608-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the need for child nodes in the sckc binding to be able to remove
dtc warnings and have a more modern binding.

Also document optional properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/clock/at91-clock.txt  | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index e9f70fcdfe80..cb838c1c4bdd 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -8,29 +8,23 @@ Slow Clock controller:
 
 Required properties:
 - compatible : shall be one of the following:
-	"atmel,at91sam9x5-sckc" or
+	"atmel,at91sam9x5-sckc",
+	"atmel,sama5d3-sckc" or
 	"atmel,sama5d4-sckc":
 		at91 SCKC (Slow Clock Controller)
-		This node contains the slow clock definitions.
-
-	"atmel,at91sam9x5-clk-slow-osc":
-		at91 slow oscillator
-
-	"atmel,at91sam9x5-clk-slow-rc-osc":
-		at91 internal slow RC oscillator
-- reg : defines the IO memory reserved for the SCKC.
-- #size-cells : shall be 0 (reg is used to encode clk id).
-- #address-cells : shall be 1 (reg is used to encode clk id).
+- #clock-cells : shall be 0.
+- clocks : shall be the input parent clock phandle for the clock.
 
+Optional properties:
+- atmel,osc-bypass : boolean property. Set this when a clock signal is directly
+  provided on XIN.
 
 For example:
-	sckc: sckc@fffffe50 {
-		compatible = "atmel,sama5d3-pmc";
-		reg = <0xfffffe50 0x4>
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		/* put at91 slow clocks here */
+	sckc@fffffe50 {
+		compatible = "atmel,at91sam9x5-sckc";
+		reg = <0xfffffe50 0x4>;
+		clocks = <&slow_xtal>;
+		#clock-cells = <0>;
 	};
 
 Power Management Controller (PMC):
-- 
2.20.1

