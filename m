Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B67C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9024F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9024F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeILSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:30:06 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45960 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727790AbeILSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:30:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08221229|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01546;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CpvjkjF_1536758716;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CpvjkjF_1536758716)
          by smtp.aliyun-inc.com(10.147.44.145);
          Wed, 12 Sep 2018 21:25:16 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V3 18/27] dt-bindings: csky CPU Bindings
Date:   Wed, 12 Sep 2018 21:24:52 +0800
Message-Id: <f14bfbce2d3c36fa620f9e5cb1805e82b150e76a.1536757532.git.ren_guo@c-sky.com>
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
 Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt

diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
new file mode 100644
index 0000000..ee3901d
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/cpus.txt
@@ -0,0 +1,70 @@
+==================
+C-SKY CPU Bindings
+==================
+
+The device tree allows to describe the layout of CPUs in a system through
+the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
+defining properties for every cpu.
+
+Only SMP system need to care about the cpus node and single processor
+needn't define cpus node at all.
+
+=====================================
+cpus and cpu node bindings definition
+=====================================
+
+- cpus node
+
+        Description: Container of cpu nodes
+
+        The node name must be "cpus".
+
+        A cpus node must define the following properties:
+
+        - #address-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be set to 1
+        - #size-cells
+                Usage: required
+                Value type: <u32>
+                Definition: must be set to 0
+
+- cpu node
+
+        Description: Describes one of SMP cores
+
+        PROPERTIES
+
+        - device_type
+                Usage: required
+                Value type: <string>
+                Definition: must be "cpu"
+        - reg
+                Usage: required
+                Value type: <u32>
+                Definition: CPU index
+        - status:
+                Usage: required
+                Value type: <string>
+                Definition: "ok"       means enable  the cpu-core
+                            "disabled" means disable the cpu-core
+
+Example:
+--------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			status = "ok";
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			reg = <1>;
+			status = "ok";
+		};
+	};
-- 
2.7.4

