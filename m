Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BECC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A2C20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A2C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeI3WxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:53:14 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55191 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728612AbeI3WxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:53:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1529636|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01546;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cxw3q4f_1538324360;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cxw3q4f_1538324360)
          by smtp.aliyun-inc.com(10.147.41.178);
          Mon, 01 Oct 2018 00:19:20 +0800
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
Subject: [PATCH V7 4/8] dt-bindings: timer: C-SKY Multi-processor timer
Date:   Mon,  1 Oct 2018 00:18:45 +0800
Message-Id: <0632f4d8a3e443dd4da5ae7980816ea5624ab789.1538323894.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <9d68bdd87a8c91f4ee35ff4311e273ea81ab9eb4.1538323894.git.ren_guo@c-sky.com>
References: <9d68bdd87a8c91f4ee35ff4311e273ea81ab9eb4.1538323894.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538323894.git.ren_guo@c-sky.com>
References: <cover.1538323894.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dt-bingdings doc for C-SKY SMP system setting.

Changelog:
 - Drop the interrupt-parent.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
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

