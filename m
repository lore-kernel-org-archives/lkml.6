Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8ABC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3A7208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3A7208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbeHAJNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:13:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:31001 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387560AbeHAJNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:13:39 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 01 Aug 2018 16:29:20 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5B59260034;
        Wed,  1 Aug 2018 16:29:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 1 Aug 2018 16:29:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 911471A120D;
        Wed,  1 Aug 2018 16:29:19 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI controller
Date:   Wed,  1 Aug 2018 16:29:11 +0900
Message-Id: <1533108552-19878-2-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533108552-19878-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1533108552-19878-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add DT bindings for SPI controller implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-uniphier.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
new file mode 100644
index 0000000..504a4ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -0,0 +1,22 @@
+Socionext UniPhier SPI controller driver
+
+UniPhier SoCs have SCSSI which supports SPI single channel.
+
+Required properties:
+ - compatible: should be "socionext,uniphier-scssi"
+ - reg: address and length of the spi master registers
+ - #address-cells: must be <1>, see spi-bus.txt
+ - #size-cells: must be <0>, see spi-bus.txt
+ - clocks: A phandle to the clock for the device.
+ - resets: A phandle to the reset control for the device.
+
+Example:
+
+spi0: spi@54006000 {
+	compatible = "socionext,uniphier-scssi";
+	reg = <0x54006000 0x100>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&peri_clk 11>;
+	resets = <&peri_rst 11>;
+};
-- 
2.7.4

