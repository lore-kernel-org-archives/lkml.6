Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E0FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081120838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeJaOXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:23:30 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:25490 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbeJaOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:23:29 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E2A6BDED23694E23EF8C;
        Wed, 31 Oct 2018 13:26:54 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9V5QmZa037582;
        Wed, 31 Oct 2018 13:26:48 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018103113270896-7767264 ;
          Wed, 31 Oct 2018 13:27:08 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V4 5/5]  dt-bindings/misc/pvpanic :add document for pvpanic-mmio
Date:   Wed, 31 Oct 2018 21:37:21 +0800
Message-Id: <1540993041-25611-5-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-31 13:27:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-31 13:26:39,
        Serialize complete at 2018-10-31 13:26:39
X-MAIL: mse01.zte.com.cn w9V5QmZa037582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Add dt-bindings document for "qemu:pvpanic-mmio".

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 .../devicetree/bindings/misc/pvpanic-mmio.txt      | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pvpanic-mmio.txt

diff --git a/Documentation/devicetree/bindings/misc/pvpanic-mmio.txt b/Documentation/devicetree/bindings/misc/pvpanic-mmio.txt
new file mode 100644
index 0000000..985e907
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/pvpanic-mmio.txt
@@ -0,0 +1,29 @@
+* QEMU PVPANIC MMIO Configuration bindings
+
+QEMU's emulation / virtualization targets provide the following PVPANIC
+MMIO Configuration interface on the "virt" machine.
+type:
+
+- a read-write, 16-bit wide data register.
+
+QEMU exposes the data register to guests as memory mapped registers.
+
+Required properties:
+
+- compatible: "qemu,pvpanic-mmio".
+- reg: the MMIO region used by the device.
+  * Bytes 0x0  Write panic event to the reg when guest OS panics.
+  * Bytes 0x1  Reserved.
+
+Example:
+
+/ {
+        #size-cells = <0x2>;
+        #address-cells = <0x2>;
+
+        pvpanic-mmio@9060000 {
+                compatible = "qemu,pvpanic-mmio";
+                reg = <0x0 0x9060000 0x0 0x2>;
+        };
+};
+
-- 
1.8.3.1

