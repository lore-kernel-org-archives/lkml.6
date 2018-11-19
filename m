Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CAEC04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBFF2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBFF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeKSLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:22:32 -0500
Received: from mx.socionext.com ([202.248.49.38]:40685 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbeKSLWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:22:31 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Nov 2018 10:00:35 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id D9125180111;
        Mon, 19 Nov 2018 10:00:35 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 19 Nov 2018 10:00:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 3620E40387;
        Mon, 19 Nov 2018 10:00:35 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 15805120455;
        Mon, 19 Nov 2018 10:00:35 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer description
Date:   Mon, 19 Nov 2018 10:01:09 +0900
Message-Id: <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Milbeaut M10V timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
new file mode 100644
index 0000000..ddb1b31
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
@@ -0,0 +1,17 @@
+Milbeaut SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "socionext,milbeaut-m10v-timer"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+- clocks: should be "rclk"
+
+Example:
+
+timer {
+	compatible = "socionext,milbeaut-m10v-timer";
+	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
+	interrupts = <0 91 4>;
+	clocks = <&rclk>;
+};
-- 
1.9.1

