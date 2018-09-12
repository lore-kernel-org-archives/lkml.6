Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFB7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4281020839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4281020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeILT7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:59:18 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37291 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbeILT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2198|-1;CH=blue;FP=7430821995823838641|2|2|12|0|-1|-1|-1;HT=e02c03306;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.Cpx.ayM_1536764005;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cpx.ayM_1536764005)
          by smtp.aliyun-inc.com(10.147.41.187);
          Wed, 12 Sep 2018 22:53:25 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V4 22/27] dt-bindings: interrupt-controller: C-SKY SMP intc
Date:   Wed, 12 Sep 2018 22:52:04 +0800
Message-Id: <edc5f67f157532bf002120b54bf75117a4d249a7.1536758961.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
new file mode 100644
index 0000000..49d1658
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -0,0 +1,40 @@
+===========================================
+C-SKY Multi-processors Interrupt Controller
+===========================================
+
+C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
+SMP soc, and it also could be used in non-SMP system.
+
+Interrupt number definition:
+
+  0-15  : software irq, and we use 15 as our IPI_IRQ.
+ 16-31  : private  irq, and we use 16 as the co-processor timer.
+ 31-1024: common irq for soc ip.
+
+=============================
+intc node bindings definition
+=============================
+
+	Description: Describes SMP interrupt controller
+
+	PROPERTIES
+
+        - compatible
+		Usage: required
+                Value type: <string>
+                Definition: must be "csky,mpintc"
+        - interrupt-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be <1>
+        - interrupt-controller:
+                Usage: required
+
+Examples:
+---------
+
+	intc: interrupt-controller {
+		compatible = "csky,mpintc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
-- 
2.7.4

