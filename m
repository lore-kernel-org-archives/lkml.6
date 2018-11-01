Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCE2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D6D205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D6D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemonage.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeKATFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:05:38 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:36997 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbeKATFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:05:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 7236323F486;
        Thu,  1 Nov 2018 11:03:18 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uc2vBCJeWG9w; Thu,  1 Nov 2018 11:03:17 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 44DD523F61D;
        Thu,  1 Nov 2018 11:03:17 +0100 (CET)
From:   Lars Poeschel <poeschel@lemonage.de>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "GitAuthor: Lars Poeschel" <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/6] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Date:   Thu,  1 Nov 2018 11:02:10 +0100
Message-Id: <20181101100216.613-2-poeschel@lemonage.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101100216.613-1-poeschel@lemonage.de>
References: <20181101100216.613-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple binding doc for the pn532.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v4:
- Add documentation about reg property in case of i2c

Changes in v3:
- seperate binding doc instead of entry in trivial-devices.txt

 .../devicetree/bindings/nfc/pn532.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nfc/pn532.txt

diff --git a/Documentation/devicetree/bindings/nfc/pn532.txt b/Documentation/devicetree/bindings/nfc/pn532.txt
new file mode 100644
index 000000000000..d5aaa588073d
--- /dev/null
+++ b/Documentation/devicetree/bindings/nfc/pn532.txt
@@ -0,0 +1,33 @@
+NXP PN532 NFC Chip
+
+Required properties:
+- compatible: Should be
+    - "nxp,pn532" Place a node with this inside the devicetree node of the bus
+                  where the NFC chip is connected to.
+                  Currently the kernel has phy bindings for uart and i2c.
+    - "nxp,pn532-i2c" (DEPRECATED) only works for the i2c binding.
+    - "nxp,pn533-i2c" (DEPRECATED) only works for the i2c binding.
+
+Required properties if connected on i2c:
+- reg: for the i2c bus address. This is fixed at 0x48 for the PN532.
+
+Example uart:
+
+uart4: serial@49042000 {
+        compatible = "ti,omap3-uart";
+
+        pn532: nfc {
+                compatible = "nxp,pn532";
+        };
+};
+
+Example i2c:
+
+i2c1: i2c@0 {
+        compatible = "ti,omap3-i2c";
+
+        pn532: nfc {
+                compatible = "nxp,pn532";
+                reg = <0x48>;
+        };
+};
-- 
2.19.1

