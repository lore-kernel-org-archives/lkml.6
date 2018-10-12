Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85962086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85962086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeJLRgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:36:14 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43566 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbeJLRgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:36:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07924215|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.D13XTm5_1539338642;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D13XTm5_1539338642)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 12 Oct 2018 18:04:02 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org,
        robh@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 18/21] dt-bindings: csky CPU Bindings
Date:   Fri, 12 Oct 2018 12:42:53 +0800
Message-Id: <1c77e479a1dc0119912ac146b1038963b3653381.1539315391.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation to describe that how to add cpu nodes in
dts for SMP.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Rob Herring <robh@kernel.org>
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

