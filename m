Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B04C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9321525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF9321525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbeITOH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:07:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59574 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbeITOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:07:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08243283|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03312;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CtLqLpG_1537431930;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CtLqLpG_1537431930)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 20 Sep 2018 16:25:30 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        c-sky_gcc_upstream@c-sky.com, green.hu@gmail.com, arnd@arndb.de,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 2/2] dt-bindings: interrupt-controller: C-SKY APB intc
Date:   Thu, 20 Sep 2018 16:25:20 +0800
Message-Id: <4ae33bd9112fc2da10b395391b2e72b80919aaa9.1537412037.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537412037.git.ren_guo@c-sky.com>
References: <cover.1537412037.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537412037.git.ren_guo@c-sky.com>
References: <cover.1537412037.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Dt-bindings doc about C-SKY apb bus interrupt controller.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../interrupt-controller/csky,apb-intc.txt         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
new file mode 100644
index 0000000..4aeac51
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -0,0 +1,62 @@
+==============================
+C-SKY APB Interrupt Controller
+==============================
+
+C-SKY APB Interrupt Controller is a simple soc interrupt controller
+on the apb bus and we only use it as root irq controller.
+
+ - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
+ - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
+ - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
+
+=============================
+intc node bindings definition
+=============================
+
+	Description: Describes APB interrupt controller
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,apb-intc"
+				    "csky,dual-apb-intc"
+				    "csky,gx6605s-intc"
+	- #interrupt-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be <1>
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- interrupt-controller:
+		Usage: required
+	- csky,support-pulse-signal:
+		Usage: select
+		Description: to support pulse signal flag
+
+Examples:
+---------
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,apb-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+	};
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,dual-apb-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+	};
+
+	intc: interrupt-controller@500000 {
+		compatible = "csky,gx6605s-intc";
+		#interrupt-cells = <1>;
+		reg = <0x00500000 0x400>;
+		interrupt-controller;
+	};
-- 
2.7.4

