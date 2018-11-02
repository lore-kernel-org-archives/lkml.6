Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8191E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8191E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeKCB72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:59:28 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40599 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbeKCB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:59:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1392245|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.DCM8vUH_1541177498;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DCM8vUH_1541177498)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sat, 03 Nov 2018 00:51:38 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V13 resend 2/4] dt-bindings: timer: C-SKY Multi-processor timer
Date:   Sat,  3 Nov 2018 00:51:29 +0800
Message-Id:
 <0f7cbde6462150c6ddb058d89d59ce35c3d6da9f.1539579760.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
References: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
In-Reply-To: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
References: <7becd836e1477d7ac2d3f8538a6d7f5b9651c389.1539579760.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20181102165129.azRsacV-ncL-tZtejHbbM5q1pdlSvzRgagTEFt3Yv1s@z>

Dt-bingdings doc for C-SKY SMP system setting.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changelog:
 - Drop the interrupt-parent.
---
---
 .../devicetree/bindings/timer/csky,mptimer.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
new file mode 100644
index 0000000..15cfec0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
@@ -0,0 +1,42 @@
+============================
+C-SKY Multi-processors Timer
+============================
+
+C-SKY multi-processors timer is designed for C-SKY SMP system and the
+regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
+
+ - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
+ - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
+ - PTIM_CCVR "cr<3, 14>" Current counter value reg.
+ - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
+
+==============================
+timer node bindings definition
+==============================
+
+	Description: Describes SMP timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,mptimer"
+	- clocks
+		Usage: required
+		Value type: <node>
+		Definition: must be input clk node
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer: timer {
+		compatible = "csky,mptimer";
+		clocks = <&dummy_apb_clk>;
+		interrupts = <16>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

