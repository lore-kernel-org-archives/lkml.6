Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9560B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9560B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeILSaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:30:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39845 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728216AbeILSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:30:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1355494|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03272;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CpvWauz_1536758717;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CpvWauz_1536758717)
          by smtp.aliyun-inc.com(10.147.44.129);
          Wed, 12 Sep 2018 21:25:17 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V3 19/27] dt-bindings: timer: gx6605s SOC timer
Date:   Wed, 12 Sep 2018 21:24:53 +0800
Message-Id: <e70d9055806db229a07d02fc80d45b3cc5d12ef3.1536757532.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
References: <cover.1536757532.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..230a9ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
@@ -0,0 +1,42 @@
+=================
+gx6605s SOC Timer
+=================
+
+The timer is used in gx6605s soc as system timer and the driver
+contain clk event and clk source.
+
+==============================
+timer node bindings definition
+==============================
+
+        Description: Describes gx6605s SOC timer
+
+        PROPERTIES
+
+        - compatible
+                Usage: required
+                Value type: <string>
+                Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+        - interrupt
+                Usage: required
+                Value type: <u32>
+                Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer0: timer@20a000 {
+		compatible = "csky,gx6605s-timer";
+		reg = <0x0020a000 0x400>;
+		clocks = <&dummy_apb_clk>;
+		interrupts = <10>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

