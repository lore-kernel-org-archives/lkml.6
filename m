Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9509BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F3B2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F3B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeKAQCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:02:12 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41776 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeKAQCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:02:12 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BBAB5BBA5CA35E5CD227;
        Thu,  1 Nov 2018 14:59:57 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA16xgim022537;
        Thu, 1 Nov 2018 14:59:42 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110115001230-7973457 ;
          Thu, 1 Nov 2018 15:00:12 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, andy@infradead.org,
        dvhart@infradead.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V5 8/8]  dt-bindings/misc/pvpanic :add document for pvpanic-mmio
Date:   Thu, 1 Nov 2018 23:10:02 +0800
Message-Id: <1541085002-42993-8-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-01 15:00:12,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-01 14:59:30,
        Serialize complete at 2018-11-01 14:59:30
X-MAIL: mse01.zte.com.cn wA16xgim022537
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

