Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E865C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9621537
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cc3F/SvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED9621537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeHIKTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:19:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LxZSlKEq/mx5D+1Xs3CC/sZnU0qbqDvP20Nm53Om7pQ=; b=Cc3F/SvZ6NcKAox6i7/Suum9d
        CNs0vPMDnz8uWu47+/m2+1U3Y1DoBT2SiWbWLM4T6O1ybZe5Cc9pN9uvImfAuRoTvjhxhLqdGXMJW
        Ye4Kn92B4kEs5+wT8zcAbPFuTBaJg6nXOiFi+qRcUfEZE2Ug2HbDcha5RKbFzT35+azeySHiKaEmB
        yMaEQyHRZ6NLQZMIfxKbv4iV/bS8iZZP7CPEp+YtDtNMoSzqY86jr5+ZU8/3Hr5VXwTENCss0brSJ
        WvHDKcccaafcH2I0Z+Is+S/Xrb+IQZZnFLSUeW4dOf4XUUljl+NOnWiiPZ+lhD4U4WaGkpnq4gtyH
        W1cnUob4w==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnfnm-00085V-Kf; Thu, 09 Aug 2018 07:56:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 1/3] dt-bindings: interrupt-controller: RISC-V local interrupt controller
Date:   Thu,  9 Aug 2018 09:56:00 +0200
Message-Id: <20180809075602.989-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809075602.989-1-hch@lst.de>
References: <20180809075602.989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

Add documentation on the RISC-V local interrupt controller, which is a
per-hart interrupt controller that manages all interrupts entering a
RISC-V hart.  This interrupt controller is present on all RISC-V systems.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: minor cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../interrupt-controller/riscv,cpu-intc.txt   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
new file mode 100644
index 000000000000..b0a8af51c388
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
@@ -0,0 +1,44 @@
+RISC-V Hart-Level Interrupt Controller (HLIC)
+---------------------------------------------
+
+RISC-V cores include Control Status Registers (CSRs) which are local to each
+CPU core (HART in RISC-V terminology) and can be read or written by software.
+Some of these CSRs are used to control local interrupts connected to the core.
+Every interrupt is ultimately routed through a hart's HLIC before it
+interrupts that hart.
+
+The RISC-V supervisor ISA manual specifies three interrupt sources that are
+attached to every HLIC: software interrupts, the timer interrupt, and external
+interrupts.  Software interrupts are used to send IPIs between cores.  The
+timer interrupt comes from an architecturally mandated real-time timer that is
+controller via Supervisor Binary Interface (SBI) calls and CSR reads.  External
+interrupts connect all other device interrupts to the HLIC, which are routed
+via the platform-level interrupt controller (PLIC).
+
+All RISC-V systems that conform to the supervisor ISA specification are
+required to have a HLIC with these three interrupt sources present.  Since the
+interrupt map is defined by the ISA it's not listed in the HLIC's device tree
+entry, though external interrupt controllers (like the PLIC, for example) will
+need to define how their interrupts map to the relevant HLICs.  This means
+a PLIC interrupt property will typically list the HLICs for all present HARTs
+in the system.
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
+			compatible = "riscv,cpu-intc", "sifive,fu540-c000-cpu-intc";
+			interrupt-controller;
+		};
+	};
-- 
2.18.0

