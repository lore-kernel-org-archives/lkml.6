Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D15D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D15D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeGXQJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48407 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388717AbeGXQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41ZhS15sX8z1qymC;
        Tue, 24 Jul 2018 17:02:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41ZhS0465Fz1tLPC;
        Tue, 24 Jul 2018 17:02:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ws36ZnJC-HSs; Tue, 24 Jul 2018 17:02:55 +0200 (CEST)
X-Auth-Info: jSaA3PMZFbWs7WCRIQzxVX4UNzp6Nnl4dXpjPcZ+iWs=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Jul 2018 17:02:54 +0200 (CEST)
From:   Parthiban Nallathambi <pn@denx.de>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br, Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Actions external interrupt controller
Date:   Tue, 24 Jul 2018 17:02:17 +0200
Message-Id: <20180724150219.1807724-2-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724150219.1807724-1-pn@denx.de>
References: <20180724150219.1807724-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actions Semi OWL family SoC's provides support for external interrupt
controller to be connected and controlled using SIRQ pins. S500, S700
and S900 provides 3 SIRQ lines and works independently for 3 external
interrupt controllers.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../interrupt-controller/actions,owl-sirq.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
new file mode 100644
index 000000000000..c5f8a29573c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
@@ -0,0 +1,34 @@
+Actions Semi Owl SoCs SIRQ interrupt controller
+
+S500, S700 and S900 SoC's from Actions provides interface, in which external
+interrupt controller can be connected. It has the following properties:
+
+- inputs three interrupt signal from external interrupt controller
+
+Required properties:
+
+- compatible: should be one of the following
+	"actions,s700-sirq"
+	"actions,s900-sirq"
+- reg: physical base address of the controller and length of memory mapped.
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 2.
+- interrupts: specifies the interrupt line in the interrupt controller and
+  interrupt type (level or edge triggered)
+- sampling-rate-24m: this means the external controller's interrupts can be
+  sampled at 24MHz. Sampling can be specified for each SIRQ lines, as an array
+  element. By default, all lines are sampled at 32KHz.
+
+Example:
+
+sirq: interrupt-controller@e01b0000 {
+	compatible = "actions,s700-sirq";
+	reg = <0 0xe01b0000 0 0x1000>;
+	interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	sampling-rate-24m = <0 0 1>;
+};
-- 
2.14.4

