Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C78C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEE32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VEXJ/ypB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfBDOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43232 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfBDOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14EN8rd031778;
        Mon, 4 Feb 2019 08:23:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290188;
        bh=BybUACh2KOzPXi9WzljjTKIRZASeNQ0xo78WVaTHwO4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VEXJ/ypBN5PdLeyHE9uxiTLiFoo+dlDmCQ07qTTWIz8Z0YnwBUGkeiRRZ85PrQGej
         dsEQ1zgAr/HbDW3kaEPigXZBFacP1UfBSE86TkfvQMQ7PncJlBkAVKcFZCL5LCmvXL
         FpRgj4gXQtOYOv9zNwXvpFV2IKpfvYXpJ+U72kOk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14EN8df010126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:08 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:07 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:07 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKb012232;
        Mon, 4 Feb 2019 08:23:03 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>, "Andrew F. Davis" <afd@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 03/14] dt-binding: irqchip: Add pruss-intc-irq driver for PRUSS interrupts
Date:   Mon, 4 Feb 2019 16:22:36 +0200
Message-ID: <1549290167-876-4-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

The Programmable Real-Time Unit Subsystem (PRUSS) contains an
interrupt controller (INTC) that can handle various system input
events and post interrupts back to the device-level initiators.
The INTC can support upto 64 input events with individual control
configuration and hardware prioritization. These events are mapped
onto 10 interrupt signals through two levels of many-to-one mapping
support. Different interrupt signals are routed to the individual
PRU cores or to the host CPU.

The PRUSS INTC platform driver manages this PRUSS interrupt
controller and implements an irqchip driver to provide a Linux
standard way for the PRU client users to enable/disable/ack/
re-trigger a PRUSS system event. The system events to interrupt
channels and host interrupts relies on the mapping configuration
provided through a firmware resource table for now. This will be
revisited and enhanced in the future for a better interface. The
mappings will currently be programmed during the boot/shutdown
of the PRU.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../interrupt-controller/ti,pruss-intc-irq.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
new file mode 100644
index 0000000..c70221c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
@@ -0,0 +1,51 @@
+PRU ICSS INTC on TI SoCs
+========================
+
+Each PRUSS has a single interrupt controller instance that is common to both
+the PRU cores. Each interrupt controller can detect 64 input events which are
+then mapped to 10 possible output interrupts through two levels of mapping. The
+input events can be triggered by either the PRUs and/or various other PRUSS
+internal and external peripherals. The first 2 output interrupts are fed
+exclusively to the internal PRU cores, with the remaining 8 connected to
+external interrupt controllers including the MPU.
+
+Required Properties:
+--------------------
+- compatible           : should be one of,
+                             "ti,am3356-pruss-intc" for AM335x family of SoCs
+                             "ti,am4376-pruss-intc" for AM437x family of SoCs
+                             "ti,am5728-pruss-intc" for AM57xx family of SoCs
+                             "ti,k2g-pruss-intc" for 66AK2G family of SoCs
+- reg                  : base address and size for the PRUSS INTC sub-module
+- reg-names            : should contain the string "intc"
+- interrupts     : all the interrupts generated towards the main host
+                   processor in the SoC. The format depends on the
+                   interrupt specifier for the particular SoC's MPU
+                   parent interrupt controller
+- interrupt-names: should use one of the following names for each interrupt,
+                   the name should match the corresponding host interrupt
+                   number,
+                       "host2", "host3", "host4", "host5", "host6",
+                       "host7", "host8" or "host9"
+                   NOTE: AM437x and 66AK2G SoCs do not have "host7" interrupt
+                         connected to MPU
+- interrupt-controller : mark this node as an interrupt controller
+- #interrupt-cells     : should be 1. Client users shall use the PRU System
+                         event number (the interrupt source that the client
+                         is interested in) as the value of the interrupts
+                         property in their node
+
+Example:
+--------
+		pruss_intc: intc@20000 {
+			compatible = "ti,am3356-pruss-intc";
+			reg = <0x20000 0x2000>;
+			reg-names = "intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <20 21 22 23 24 25 26 27>;
+			interrupt-names = "host2", "host3", "host4",
+					  "host5", "host6", "host7",
+					  "host8", "host9";
+		};
+
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

