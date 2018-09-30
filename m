Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA583C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AD120833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AD120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeI3WxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:53:07 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49020 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728469AbeI3WxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:53:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2454613|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CxwF8ay_1538324354;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CxwF8ay_1538324354)
          by smtp.aliyun-inc.com(10.147.41.199);
          Mon, 01 Oct 2018 00:19:14 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, f.fainelli@gmail.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 2/8] dt-bindings: interrupt-controller: C-SKY SMP intc
Date:   Mon,  1 Oct 2018 00:18:43 +0800
Message-Id: <4f6de4c6290c408d13902d8c1922514d06201bc2.1538323894.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <9d68bdd87a8c91f4ee35ff4311e273ea81ab9eb4.1538323894.git.ren_guo@c-sky.com>
References: <9d68bdd87a8c91f4ee35ff4311e273ea81ab9eb4.1538323894.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538323894.git.ren_guo@c-sky.com>
References: <cover.1538323894.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dt-bindings doc about C-SKY Multi-processors interrupt controller.

Changelog:
 - Should be: '#interrupt-cells' not 'interrupt-cells'

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
new file mode 100644
index 0000000..ab921f1
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
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,mpintc"
+	- #interrupt-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be <1>
+	- interrupt-controller:
+		Usage: required
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

