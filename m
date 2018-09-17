Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8982147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8982147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mxic.com.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeIQNHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:07:01 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:42594 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIQNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:07:00 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id w8H7H3fL078805
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:17:03 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id w8H7GmMb078541;
        Mon, 17 Sep 2018 15:16:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   masonccyang@mxic.com.tw
To:     broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
Subject: [PATCH 2/2] dt-binding: spi: Document Macronix controller bindings
Date:   Mon, 17 Sep 2018 15:16:19 +0800
Message-Id: <1537168579-31593-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com w8H7GmMb078541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Document the bindings used by the Macronix controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 Documentation/devicetree/bindings/spi/spi-mxic.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mxic.txt b/Documentation/devicetree/bindings/spi/spi-mxic.txt
new file mode 100644
index 0000000..529f2da
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mxic.txt
@@ -0,0 +1,34 @@
+Macronix SPI controller Device Tree Bindings
+--------------------------------------------
+
+Required properties:
+- compatible: should be "mxicy,mx25f0a-spi"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area
+- reg-names: should contain "regs" and "dirmap"
+- interrupts: interrupt line connected to the SPI controller
+- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
+- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
+	  "send_dly_clk" clocks
+
+Example:
+
+	spi@43c30000 {
+		compatible = "mxicy,mx25f0a-spi";
+		reg = <0x43c30000 0x10000>, <0xa0000000 0x20000000>;
+		reg-names = "regs", "dirmap";
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 18>;
+		clock-names = "send_clk", "send_dly_clk", "ps_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <25000000>;
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+		};
+	};
-- 
1.9.1

