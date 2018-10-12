Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2034C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A142086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A142086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeJLTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:44:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52600 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbeJLTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:44:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08127265|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.D16CbYn_1539346355;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D16CbYn_1539346355)
          by smtp.aliyun-inc.com(10.147.40.26);
          Fri, 12 Oct 2018 20:12:35 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, will.deacon@arm.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V12 4/8] dt-bindings: interrupt-controller: C-SKY APB intc
Date:   Fri, 12 Oct 2018 20:12:17 +0800
Message-Id: <d6a649276d1b5641f2b8518e55016501d69e6128.1539315341.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539315341.git.ren_guo@c-sky.com>
References: <cover.1539315341.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Dt-bindings doc about C-SKY apb bus interrupt controller.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/csky,apb-intc.txt         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
new file mode 100644
index 0000000..44286dc
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

