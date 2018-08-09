Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AACC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE70C21537
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLawjlTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE70C21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeHIKUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:20:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=83O1p2pBQ5HU3h4a92xOd08AI2lv4khVcY2Mj0+MNak=; b=JLawjlTqubDuoSKuoJdKors6N
        B5O0OkuQ3C8/tlQzxJoEYiPmpDUCtyYifsWy9fMDOhiu/xjRalrLZAHN/shyCKURxAwCYINbm4tTi
        e0n+I4pvGi6ds4N3KmWWd5wutd4glx7YryT6OlFrq51PvnRqBml3jJA3f7SkLpqkcHWMQr7rOcFRa
        6jXbquOyTFN7q0D738gSmuVq22IoHH7Enyb7MYtls5QJLJdCk5Bfs6rKZO60JcmH31jKWo8nfnNd9
        a8b2lGn3Zd3NLj2u6/p36OfXyMgIFqcEOLcMG4O4NiLnpos9nUjDPHY9uIINCNaWmTLtR6rRa/PVG
        0cUwJYghg==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnfnu-00089A-NZ; Thu, 09 Aug 2018 07:56:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 2/3] dt-bindings: interrupt-controller: SiFive Plaform Level Interrupt Controller
Date:   Thu,  9 Aug 2018 09:56:01 +0200
Message-Id: <20180809075602.989-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809075602.989-1-hch@lst.de>
References: <20180809075602.989-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

Add documentation for the SiFive implementation of the RISC-V Platform
Level Interrupt Controller (PLIC).  The PLIC connects global interrupt
sources to the local interrupt controller on each hart.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: various fixes and updates]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../interrupt-controller/sifive,plic.txt      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic.txt
new file mode 100644
index 000000000000..fe7ccd944c12
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic.txt
@@ -0,0 +1,58 @@
+SiFive Platform-Level Interrupt Controller (PLIC)
+-------------------------------------------------
+
+SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
+(PLIC) high-level specification in the RISC-V Privileged Architecture
+specification.  The PLIC connects all external interrupts in the system to all
+hart contexts in the system, via the external interrupt source in each hart.
+
+A hart context is a privilege mode in a hardware execution thread.  For example,
+in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
+privilege modes per hart; machine mode and supervisor mode.
+
+Each interrupt can be enabled on per-context basis.  Any context can claim
+a pending enabled interrupt and then release it once it has been handled.
+
+Each interrupt has a configurable priority.  Higher priority interrupts are
+serviced first.  Each context can specify a priority threshold. Interrupts
+with priority below this threshold will not cause the PLIC to raise its
+interrupt line leading to the context.
+
+While the PLIC supports both edge-triggered and level-triggered interrupts,
+interrupt handlers are oblivious to this distinction and therefore it is not
+specified in the PLIC device-tree binding.
+
+While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
+"sifive,plic" device is a concrete implementation of the PLIC that contains a
+specific memory layout, which is documented in chapter 8 of the SiFive U5
+Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
+
+Required properties:
+- compatible : "sifive,plic" and a string identifying the actual detailed
+  implementation in case that specific bugs need to be worked around.
+- #address-cells : should be <0> or more.
+- #interrupt-cells : should be <1> or more.
+- interrupt-controller : Identifies the node as an interrupt controller.
+- reg : Should contain 1 register range (address and length).
+- interrupts-extended : Specifies which contexts are connected to the PLIC,
+  with "-1" specifying that a context is not present.  Each node pointed
+  to should be a riscv,cpu-intc node, which has a riscv node as parent.
+- riscv,ndev: Specifies how many external interrupts are supported by
+  this controller.
+
+Example:
+
+	plic: interrupt-controller@c000000 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		compatible = "riscv,plic", "sifive,fu540-c000-plic";
+		interrupt-controller;
+		interrupts-extended = <
+			&cpu0-intc 11
+			&cpu1-intc 11 &cpu1-intc 9
+			&cpu2-intc 11 &cpu2-intc 9
+			&cpu3-intc 11 &cpu3-intc 9
+			&cpu4-intc 11 &cpu4-intc 9>;
+		reg = <0xc000000 0x4000000>;
+		riscv,ndev = <10>;
+	};
-- 
2.18.0

