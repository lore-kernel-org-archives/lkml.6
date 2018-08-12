Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5382C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7821A56
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7821A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeHLPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 11:00:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38139 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeHLPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 11:00:40 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41pJ0K5sNBz1qw0L;
        Sun, 12 Aug 2018 14:22:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41pJ0F4yrhz1qqlC;
        Sun, 12 Aug 2018 14:22:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id zO0_PMVjUjdA; Sun, 12 Aug 2018 14:22:36 +0200 (CEST)
X-Auth-Info: ziT/UQMC++VVoDzLAnscmMod9iRE01uTcv4cc55oAs8=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 12 Aug 2018 14:22:36 +0200 (CEST)
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
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions external interrupt controller
Date:   Sun, 12 Aug 2018 14:22:13 +0200
Message-Id: <20180812122215.1079590-2-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180812122215.1079590-1-pn@denx.de>
References: <20180812122215.1079590-1-pn@denx.de>
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
 .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
new file mode 100644
index 000000000000..4b8437751331
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
@@ -0,0 +1,46 @@
+Actions Semi Owl SoCs SIRQ interrupt controller
+
+S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
+in which external interrupt controller can be connected. 3 SPI's
+45, 46, 47 from GIC are directly exposed as SIRQ. It has
+the following properties:
+
+- inputs three interrupt signal from external interrupt controller
+
+Required properties:
+
+- compatible: should be "actions,owl-sirq"
+- reg: physical base address of the controller and length of memory mapped.
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 2.
+- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
+  details are maintained at same offset/register.
+- actions,sirq-offset: register offset for SIRQ interrupts. When registers are
+  shared, all the three offsets will be same (S500 and S700).
+- actions,sirq-clk-sel: external interrupt controller can be either
+  connected to 32Khz or 24Mhz external/internal clock. This needs
+  to be configured for per SIRQ line. Failing defaults to 32Khz clock.
+
+Example for S900:
+
+sirq: interrupt-controller@e01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0 0xe01b0000 0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	actions,sirq-clk-sel = <0 0 0>;
+	actions,sirq-offset = <0x200 0x528 0x52c>;
+};
+
+Example for S500 and S700:
+
+sirq: interrupt-controller@e01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0 0xe01b0000 0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	actions,sirq-shared-reg;
+	actions,sirq-clk-sel = <0 0 0>;
+	actions,sirq-offset = <0x200 0x200 0x200>;
+};
-- 
2.14.4

