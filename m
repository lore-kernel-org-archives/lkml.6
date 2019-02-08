Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E843C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC622086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfBHM0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:26:47 -0500
Received: from mx.socionext.com ([202.248.49.38]:27802 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfBHM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:26:47 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:26:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6C62F180D62;
        Fri,  8 Feb 2019 21:26:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:26:45 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4FAA31A04E1;
        Fri,  8 Feb 2019 21:26:45 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 380C51202F1;
        Fri,  8 Feb 2019 21:26:45 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver description
Date:   Fri,  8 Feb 2019 21:27:29 +0900
Message-Id: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Milbeaut serial driver.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
new file mode 100644
index 0000000..8f61c38
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
@@ -0,0 +1,21 @@
+Socionext Milbeaut UART controller
+
+Required properties:
+- compatible: should be "socionext,milbeaut-usio-uart".
+- reg: offset and length of the register set for the device.
+- interrupts: two interrupts specifier.
+- clocks: phandle to the input clock.
+- interrupt-names: should be "rx", "tx".
+
+Optional properties:
+- uart-flow-enable: flow control enable.
+
+Example:
+	usio1: usio_uart@1e700010 {
+		compatible = "socionext,milbeaut-usio-uart";
+		reg = <0x1e700010 0x10>;
+		interrupts = <0 141 0x4>, <0 149 0x4>;
+		interrupt-names = "rx", "tx";
+		clocks = <&clk 2>;
+		uart-flow-enable;
+	};
-- 
1.9.1

