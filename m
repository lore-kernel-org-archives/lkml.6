Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4FCECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B7B21523
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 18:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B7B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeIWAL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 20:11:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35147 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbeIWAL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 20:11:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F404A208B1; Sat, 22 Sep 2018 20:17:27 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id C438520618;
        Sat, 22 Sep 2018 20:17:17 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH 1/6] dt-bindings: ap806: add the cluster clock node in the syscon file
Date:   Sat, 22 Sep 2018 20:17:04 +0200
Message-Id: <20180922181709.13007-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180922181709.13007-1-gregory.clement@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device tree binding for the cluster clock controllers found
in the Armada 7K/8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 3fd21bb7cb37..8f281816a6b8 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -136,3 +136,25 @@ ap_syscon1: system-controller@6f8000 {
 		#thermal-sensor-cells = <1>;
 	};
 };
+
+Cluster clocks:
+---------------
+
+Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
+cluster contain up to 2 CPUs running at the same frequency.
+
+Required properties:
+- compatible: must be  "marvell,ap806-cpu-clock";
+- #clock-cells : should be set to 1.
+- clocks : shall be the input parents clock phandle for the clock.
+
+ap_syscon1: system-controller@6f8000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	cpu_clk: clock-cpu {
+		compatible = "marvell,ap806-cpu-clock";
+		clocks = <&ap_clk 0>, <&ap_clk 1>;
+		#clock-cells = <1>;
+	};
+};
-- 
2.19.0

