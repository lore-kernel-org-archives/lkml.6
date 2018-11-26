Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50541C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0452089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0452089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeKZU6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:58:06 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53595 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:58:05 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433Mvr58TQz1qxl3;
        Mon, 26 Nov 2018 11:04:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433Mvq6tQpz1qrnK;
        Mon, 26 Nov 2018 11:04:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aiGLJ7jpUzTr; Mon, 26 Nov 2018 11:04:22 +0100 (CET)
X-Auth-Info: /v6QzJWtDJiTB7LYpRVnI6QDf2mH7ifJJ6VoC8U71Qw=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 11:04:22 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, thomas.liau@actions-semi.com,
        mp-cs@actions-semi.com, linux@cubietech.com,
        edgar.righi@lsitec.org.br, laisa.costa@lsitec.org.br,
        guilherme.simoes@lsitec.org.br, mkzuffo@lsi.usp.br,
        Parthiban Nallathambi <pn@denx.de>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: interrupt-controller: Actions external interrupt controller
Date:   Mon, 26 Nov 2018 11:03:53 +0100
Message-Id: <20181126100356.2840578-2-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126100356.2840578-1-pn@denx.de>
References: <20181126100356.2840578-1-pn@denx.de>
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
 .../interrupt-controller/actions,owl-sirq.txt | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
new file mode 100644
index 000000000000..b3adc4bddf40
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
@@ -0,0 +1,57 @@
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
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: specifies the number of cells needed to encode an interrupt
+  source, should be 2.
+- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
+  details are maintained at same offset/register.
+- actions,sirq-reg-offset: register offset for SIRQ interrupts. When registers are
+  shared, all the three offsets will be same (S500 and S700).
+- actions,ext-irq-range: Identifies external irq number range in different SoCs.
+
+Example for S900:
+
+sirq: interrupt-controller@e01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0x0 0xe01b0000 0x0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	actions,sirq-offset = <0x200 0x528 0x52c>;
+	actions,ext-irq-range = <13 15>;
+};
+
+Example for S700:
+
+sirq: interrupt-controller@e01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0x0 0xe01b0000 0x0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	actions,sirq-shared-reg;
+	actions,sirq-reg-offset = <0x200 0x200 0x200>;
+	actions,ext-irq-range = <13 15>;
+};
+
+Example for S500:
+
+sirq: interrupt-controller@b01b0000 {
+	compatible = "actions,owl-sirq";
+	reg = <0x0 0xb01b0000 0x0 0x1000>;
+	interrupt-controller;
+	#interrupt-cells = <3>;
+	actions,sirq-shared-reg;
+	actions,sirq-offset = <0x200 0x200 0x200>;
+	actions,ext-irq-range = <13 15>;
+};
-- 
2.17.2

