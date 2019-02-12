Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44DC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7078F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FX0z+zhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfBLHoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:44:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfBLHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:44:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7hSUa017854;
        Tue, 12 Feb 2019 01:43:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957409;
        bh=8PkE/JRhVH8yDMxuXQt13A16ub5lTk8UaNSN0j2XZ7k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FX0z+zhwG+iuUPGNWXKoy0oYprEDYTZKiPFdJvyzkLJ5qFW23TwzEf6uwGuI2A5T+
         8z7MG03OtPI53DPaQpSa5rU20Owr6yxAjiBlPhzAF/PSS7v2Hawb1OBKEmymGm27gA
         WJgqVCfZylOPpxjVWElLUPvE9OBsEvXtMDKDAdOU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7hSfi022681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:43:28 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:43:28 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:43:28 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7gss3000385;
        Tue, 12 Feb 2019 01:43:24 -0600
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
Subject: [PATCH v5 07/10] dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
Date:   Tue, 12 Feb 2019 13:12:34 +0530
Message-ID: <20190212074237.2875-8-lokeshvutla@ti.com>
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

Add the DT binding documentation for Interrupt Aggregator driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes sine v4:
- None

 .../interrupt-controller/ti,sci-inta.txt      | 74 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
new file mode 100644
index 000000000000..17b1fbd90312
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
@@ -0,0 +1,74 @@
+Texas Instruments K3 Interrupt Aggregator
+=========================================
+
+The Interrupt Aggregator (INTA) provides a centralized machine
+which handles the termination of system events to that they can
+be coherently processed by the host(s) in the system. A maximum
+of 64 events can be mapped to a single interrupt.
+
+
+                              Interrupt Aggregator
+                     +-----------------------------------------+
+                     |      Intmap            VINT             |
+                     | +--------------+  +------------+        |
+            m ------>| | vint  | bit  |  | 0 |.....|63| vint0  |
+               .     | +--------------+  +------------+        |       +------+
+               .     |         .               .               |       | HOST |
+Globalevents  ------>|         .               .               |------>| IRQ  |
+               .     |         .               .               |       | CTRL |
+               .     |         .               .               |       +------+
+            n ------>| +--------------+  +------------+        |
+                     | | vint  | bit  |  | 0 |.....|63| vintx  |
+                     | +--------------+  +------------+        |
+                     |                                         |
+                     +-----------------------------------------+
+
+Configuration of these Intmap registers that maps global events to vint is done
+by a system controller (like the Device Memory and Security Controller on K3
+AM654 SoC). Driver should request the system controller to get the range
+of global events and vints assigned to the requesting host. Management
+of these requested resources should be handled by driver and requests
+system controller to map specific global event to vint, bit pair.
+
+Communication between the host processor running an OS and the system
+controller happens through a protocol called TI System Control Interface
+(TISCI protocol). For more details refer:
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TISCI Interrupt Aggregator Node:
+-------------------------------
+- compatible:		Must be "ti,sci-inta".
+- reg:			Should contain registers location and length.
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Specifies the number of cells needed to encode an
+			interrupt source. The value should be 4.
+			First cell should contain the TISCI device ID of source
+			Second cell should contain the event source offset
+			within the device
+			Third cell specified the interrupt number(vint)
+			reaching Interrupt aggregator.
+			Fourth cell specifies the trigger type as defined
+			in interrupts.txt in this directory.
+- interrupt-parent:	phandle of irq parent for TISCI intr.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dev-id:	TISCI device ID of the Interrupt Aggregator.
+- ti,sci-rm-range-vint:	TISCI subtype id representing the virtual interrupts
+			(vints) range within this IA, assigned to the
+			requesting host context.
+- ti,sci-rm-range-global-event:	TISCI subtype id representing the global
+			events range reaching this IA and are assigned
+			to the requesting host context.
+
+Example:
+--------
+main_udmass_inta: interrupt-controller@33d00000 {
+	compatible = "ti,sci-inta";
+	reg = <0x0 0x33d00000 0x0 0x100000>;
+	interrupt-controller;
+	interrupt-parent = <&main_navss_intr>;
+	#interrupt-cells = <4>;
+	ti,sci = <&dmsc>;
+	ti,sci-dev-id = <179>;
+	ti,sci-rm-range-vint = <0x0>;
+	ti,sci-rm-range-global-event = <0x1>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 823eeb672cf0..970c732b7158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15065,6 +15065,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/irqchip/irq-ti-sci-common.c
 F:	drivers/irqchip/irq-ti-sci-common.h
-- 
2.19.2

