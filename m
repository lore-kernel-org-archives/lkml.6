Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4BBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B273D20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bPSK/ieK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B273D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeGYKsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:48:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbeGYKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tIXrVvq9OSoPk2KsHRsT/SmHJfZnosDj8UGX6gqpiOs=; b=bPSK/ieKzG6PryrnoXjwRwdrY
        720EloLSbs5fQToJO9I19CGJ9uRT3A47ugV01LmWqLGM6cYdGfTDbawsQ2sRPRXWiM5l4KVDuTcTc
        M0FnsTAVk0oS6wpa0vxg6AVh7No6LHWirfz2izDE6coZhPFmp5XN1Vdc830Xjb/NOWGeBRZ/QWFJU
        B9xFAdsYb+W2e51ZlfOovchC5LxDB/AYKWVNvzuLqpsWFMdi4Zgr3U0EzCRp5rQ2rL1+WX8pHGfXR
        Ce0PMIP/m6eS7CDEMtJl4OOYlV2M3t/9234f6Arvdop5wSmeQdTs6NGNi+KkfgUYMFsoLgYRR4+bs
        /tWRkIhIw==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGED-0005IV-R8; Wed, 25 Jul 2018 09:37:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/6] dt-bindings: interrupt-controller: RISC-V local interrupt controller docs
Date:   Wed, 25 Jul 2018 11:36:47 +0200
Message-Id: <20180725093649.32332-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
References: <20180725093649.32332-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

This patch adds documentation on the RISC-V local interrupt controller,
which is a per-hart interrupt controller that manages all interrupts
entering a RISC-V hart.  This interrupt controller is present on all
RISC-V systems.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 .../interrupt-controller/riscv,cpu-intc.txt   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
new file mode 100644
index 000000000000..61900e2e3868
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
@@ -0,0 +1,41 @@
+RISC-V Hart-Level Interrupt Controller (HLIC)
+---------------------------------------------
+
+RISC-V cores include Control Status Registers (CSRs) which are local to each
+hart and can be read or written by software. Some of these CSRs are used to
+control local interrupts connected to the core.  Every interrupt is ultimately
+routed through a hart's HLIC before it interrupts that hart.
+
+The RISC-V supervisor ISA manual specifies three interrupt sources that are
+attached to every HLIC: software interrupts, the timer interrupt, and external
+interrupts.  Software interrupts are used to send IPIs between cores.  The
+timer interrupt comes from an architecturally mandated real-time timer that is
+controller via SBI calls and CSR reads.  External interrupts connect all other
+device interrupts to the HLIC, which are routed via the platform-level
+interrupt controller (PLIC).
+
+All RISC-V systems that conform to the supervisor ISA specification are
+required to have a HLIC with these three interrupt sources present.  Since the
+interrupt map is defined by the ISA it's not listed in the HLIC's device tree
+entry, though external interrupt controllers (like the PLIC, for example) will
+need to define how their interrupts map to the relevant HLICs.
+
+Required properties:
+- compatible : "riscv,cpu-intc"
+- #interrupt-cells : should be <1>
+- interrupt-controller : Identifies the node as an interrupt controller
+
+Furthermore, this interrupt-controller MUST be embedded inside the cpu
+definition of the hart whose CSRs control these local interrupts.
+
+An example device tree entry for a HLIC is show below.
+
+	cpu1: cpu@1 {
+		compatible = "riscv";
+		...
+		cpu1-intc: interrupt-controller {
+			#interrupt-cells = <1>;
+			compatible = "riscv,cpu-intc";
+			interrupt-controller;
+		};
+	};
-- 
2.18.0

