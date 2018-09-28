Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9F52172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9F52172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeI1HO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:14:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60362 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728739AbeI1HNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:13:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1301114|-1;CH=blue;FP=16665462242522510713|1|1|12|0|-1|-1|-1;HT=e01l10423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CwkaOWs_1538095945;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkaOWs_1538095945)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 28 Sep 2018 08:52:26 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 29/33] dt-bindings: timer: gx6605s SOC timer
Date:   Fri, 28 Sep 2018 08:51:26 +0800
Message-Id: <881000bf5571e69a7eba718ce2c5e6bb3ffed920.1538058840.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Dt-bindings doc for gx6605s SOC's system timer.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..6b04344
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
+	Description: Describes gx6605s SOC timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+	- interrupt
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
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

