Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47254C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0333D2098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0333D2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934487AbeGDJPq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:15:46 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34963 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932479AbeGDJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:15:08 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w649ESjK017181;
        Wed, 4 Jul 2018 12:14:28 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id E3B0C6307C; Wed,  4 Jul 2018 12:14:28 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arnd.de,
        gregkh@linuxfoundation.org, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: bmc: Add NPCM7xx LPC BPC documentation
Date:   Wed,  4 Jul 2018 12:14:26 +0300
Message-Id: <20180704091427.409971-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180704091427.409971-1-tmaimon77@gmail.com>
References: <20180704091427.409971-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM7xx BIOS Post Code (BPC).
The NPCM7xx BPC monitoring two configurable I/O addresses
written by the host on Low Pin Count (LPC) bus.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt

diff --git a/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt b/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
new file mode 100644
index 000000000000..0832c9cbea32
--- /dev/null
+++ b/Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
@@ -0,0 +1,26 @@
+Nuvoton NPCM7xx LPC BPC interface
+
+Nuvoton BMC NPCM7xx BIOS Post Code (BPC) monitoring two
+configurable I/O addresses written by the host on the
+Low Pin Count (LPC) bus, the capure data stored in 128-word FIFO.
+
+NPCM7xx BPC supports capture double words, when using capture
+double word only I/O address 1 is monitored.
+
+Required properties for lpc_bpc node
+- compatible	: "nuvoton,npcm750-lpc-bpc" for Poleg NPCM7XX.
+- reg 			: specifies physical base address and size of the registers.
+- interrupts	: contain the LPC BPC with flags for falling edge.
+- monitor-ports : contain monitor I/O addresses, at least one monitor I/O
+				  address required
+
+Optional property for lpc_bpc node
+- bpc-en-dwcapture : enable capture double words support.
+
+Example:
+	lpc_bpc: lpc-bpc@f0007040 {
+		compatible = "nuvoton,npcm7xx-lpc-bpc";
+		reg = <0xf0007040 0x14>;
+		monitor-ports = <0x80>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.14.1

