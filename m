Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83992C65BD0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBEE2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZvewPSce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBEE2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJFObJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:31:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33948 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeJFObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:31:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w967SNG2029126;
        Sat, 6 Oct 2018 02:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538810903;
        bh=Q5QrwgguIRoNzmwtHN64jFoD2WrYsTOZoVlTXvAtYt8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZvewPSce93W/W5C6EhsdDDD9HYr3dIf617EA4aUw4x2yxhy7Z/roqg1Nd3RUlKEFy
         7B4vC1aTJaVFhNp23X2uo+t2ywTau0ORIBJB81cjVZVj89eqrNQAfktkrovQ9Qe/jL
         cpmiwn+Dt78GE+e1B31jyKG8AKer6SoqOqXU4qiQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w967SNPv013729;
        Sat, 6 Oct 2018 02:28:23 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 6 Oct
 2018 02:28:23 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 6 Oct 2018 02:28:23 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w967SFuD016164;
        Sat, 6 Oct 2018 02:28:19 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/2] dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
Date:   Sat, 6 Oct 2018 12:58:11 +0530
Message-ID: <20181006072812.15814-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181006072812.15814-1-lokeshvutla@ti.com>
References: <20181006072812.15814-1-lokeshvutla@ti.com>
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
 .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
new file mode 100644
index 000000000000..681ca53cc5fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -0,0 +1,83 @@
+Texas Instruments K3 Interrupt Router
+=====================================
+
+The Interrupt Router (INTR) module provides a mechanism to mux M
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
+        +-------+            |    .        |  0  |  |----->|  GIC  |
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
+track of GIC IRQs.
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
+			interrupt source. The value should be 3.
+			First cell should contain the TISCI device ID of source
+			Second cell should contain the interrupt source offset
+			within the device
+			Third cell specifies the trigger type as defined
+			in interrupts.txt in this directory.
+- interrupt-parent:	phandle of irq parent for TISCI intr. The parent must
+			use the same interrupt-cells format as GIC.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
+- ti,sci-rm-range-girq:	Tuple corresponding to unique TISCI resource type that
+			defines the dst host irq ranges assigned to this
+			interrupt router from this host context.
+			Tuple should be of format <type subtype>.
+
+Example:
+--------
+The following example demonstrates both interrupt router node and the consumer
+node(main gpio) on the AM654 SoC:
+
+main_intr: interrupt-controller@1 {
+	compatible = "ti,sci-intr";
+	interrupt-controller;
+	interrupt-parent = <&gic>;
+	#interrupt-cells = <3>;
+	ti,sci = <&dmsc>;
+	ti,sci-dst-id = <56>;
+	ti,sci-rm-range-girq = <0xb 0x1>;
+};
+
+main_gpio0:  main_gpio0@600000 {
+	...
+	interrupt-parent = <&main_intr>;
+	interrupts = <57 256 IRQ_TYPE_EDGE_RISING>,
+			<57 257 IRQ_TYPE_EDGE_RISING>,
+			<57 258 IRQ_TYPE_EDGE_RISING>,
+			<57 259 IRQ_TYPE_EDGE_RISING>,
+			<57 260 IRQ_TYPE_EDGE_RISING>,
+			<57 261 IRQ_TYPE_EDGE_RISING>;
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 29c08106bd22..a23778b68d74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14625,6 +14625,7 @@ F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.19.0

