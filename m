Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552AEC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197E621773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rFoIeKdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfBLHnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:43:53 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37224 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfBLHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:43:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hKOF121681;
        Tue, 12 Feb 2019 01:43:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957400;
        bh=PCZDXzrI3r4zJ78dXFdpA4IA5K3nhIMINJiDou948hQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rFoIeKdMB0yjyMf+OEcZbepxpqbPV36P6INzlN10FQquk9TaRwc9JgWrcS8wjiSnf
         fSgH8yDy30Y8U7eRAsBffFTFuY4SDDYwueh5VWVb4DJUx4O+ioCpPJ2XPMp0O8svmr
         Hnil9H7oVY7ny5wZncDby8fw4ZIqXbUeSYUZS3MU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hKcL058043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:20 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:20 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:19 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss1000385;
        Tue, 12 Feb 2019 01:43:16 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
Date:   Tue, 12 Feb 2019 13:12:32 +0530
Message-ID: <20190212074237.2875-6-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212074237.2875-1-lokeshvutla@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for Interrupt router driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v4:
- None

 .../interrupt-controller/ti,sci-intr.txt      | 85 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
new file mode 100644
index 000000000000..4b0ca797fda1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -0,0 +1,85 @@
+Texas Instruments K3 Interrupt Router
+=====================================
+
+The Interrupt Router (INTR) module provides a mechanism to route M
+interrupt inputs to N interrupt outputs, where all M inputs are selectable
+to be driven per N output. There is one register per output (MUXCNTL_N) that
+controls the selection.
+
+
+                                 Interrupt Router
+                             +----------------------+
+                             |  Inputs     Outputs  |
+        +-------+            | +------+             |
+        | GPIO  |----------->| | irq0 |             |       Host IRQ
+        +-------+            | +------+             |      controller
+                             |    .        +-----+  |      +-------+
+        +-------+            |    .        |  0  |  |----->|  IRQ  |
+        | INTA  |----------->|    .        +-----+  |      +-------+
+        +-------+            |    .          .      |
+                             | +------+      .      |
+                             | | irqM |    +-----+  |
+                             | +------+    |  N  |  |
+                             |             +-----+  |
+                             +----------------------+
+
+Configuration of these MUXCNTL_N registers is done by a system controller
+(like the Device Memory and Security Controller on K3 AM654 SoC). System
+controller will keep track of the used and unused registers within the Router.
+Driver should request the system controller to get the range of GIC IRQs
+assigned to the requesting hosts. It is the drivers responsibility to keep
+track of Host IRQs.
+
+Communication between the host processor running an OS and the system
+controller happens through a protocol called TI System Control Interface
+(TISCI protocol). For more details refer:
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TISCI Interrupt Router Node:
+----------------------------
+- compatible:		Must be "ti,sci-intr".
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Specifies the number of cells needed to encode an
+			interrupt source. The value should be 4.
+			First cell should contain the TISCI device ID of source
+			Second cell should contain the interrupt source offset
+			within the device
+			Third cell specifies the trigger type as defined
+			in interrupts.txt in this directory.
+			Fourth cell should be 1 if the irq is coming from
+			interrupt aggregator else 0.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
+- ti,sci-rm-range-girq:	Array of TISCI subtype ids representing the host irqs
+			assigned to this interrupt router. Each subtype id
+			corresponds to a range of host irqs.
+
+For more details on TISCI IRQ resource management refer:
+http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
+
+Example:
+--------
+The following example demonstrates both interrupt router node and the consumer
+node(main gpio) on the AM654 SoC:
+
+main_intr: interrupt-controller0 {
+	compatible = "ti,sci-intr";
+	interrupt-controller;
+	interrupt-parent = <&gic500>;
+	#interrupt-cells = <4>;
+	ti,sci = <&dmsc>;
+	ti,sci-dst-id = <56>;
+	ti,sci-rm-range-girq = <0x1>;
+};
+
+main_gpio0: gpio@600000 {
+	...
+	interrupt-parent = <&main_intr>;
+	interrupts = <57 256 IRQ_TYPE_EDGE_RISING 0>,
+			<57 257 IRQ_TYPE_EDGE_RISING 0>,
+			<57 258 IRQ_TYPE_EDGE_RISING 0>,
+			<57 259 IRQ_TYPE_EDGE_RISING 0>,
+			<57 260 IRQ_TYPE_EDGE_RISING 0>,
+			<57 261 IRQ_TYPE_EDGE_RISING 0>;
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c68de3cfd80..c918d9b2ee18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15064,6 +15064,7 @@ F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 
 Texas Instruments ASoC drivers
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
-- 
2.19.2

