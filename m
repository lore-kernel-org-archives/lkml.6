Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79C2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554F8208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BcWzwgag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554F8208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeHWSae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:30:34 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39072 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732888AbeHWSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:30:33 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CA77824E211F;
        Thu, 23 Aug 2018 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535036430; bh=Zu+VO24t76cGohiWONUfkPZiz3vmckx2AlPcPdKR490=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcWzwgagtmGd6h/0l9TSl1lSE3byuoxHOxLQUbc07kKWzesXlpV5Rk03AIL2Kxxt4
         DRtywGDuZmFyLwmDUhnsnCvn5e+cMXA+2n6tll4vJ8C/aSvCXTpHOyP0Zpq2/1Dcsq
         YgYUrPhtBhK8lgjCYDqS7TFkdgB7j5y9yLPDevAZ/0JKp7JZi7ocHYwZKX1mHiEPmV
         WMYZOreEdwwfx1MDI0qWPxpEmhqMWJg7Lq8zBGsH4FP8Mb9ufMAd14gtb18ruXUAr4
         dIUCUSnAfG3i8d51s7qrrT7XUeZ2FGDRuF9VnxG4+G2GxtDjSNw3IRfniq7AvwBuxi
         k99ARUur2bD+w==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.36])
        by mailhost.synopsys.com (Postfix) with ESMTP id F3F423FF7;
        Thu, 23 Aug 2018 08:00:27 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
Date:   Thu, 23 Aug 2018 18:00:13 +0300
Message-Id: <20180823150013.21837-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180823150013.21837-1-Eugeniy.Paltsev@synopsys.com>
References: <20180823150013.21837-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device tree bindings for the Synopsys
GPIO via CREG driver.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../devicetree/bindings/gpio/snps,creg-gpio.txt    | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
new file mode 100644
index 000000000000..2ab1b49eee7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
@@ -0,0 +1,48 @@
+GPIO via CREG (Control REGisers) driver
+
+To control such strangely mapped MMIO outputs:
+
+31            11        8         7        5         0   < bit number
+|              |        |         |        |         |
+[   not used   | gpio-1 | shift-1 | gpio-0 | shift-0 ]   < 32 bit MMIO register
+                   ^                  ^
+                   |                  |
+                   |           write 0x2 == set output to "1" (on)
+                   |           write 0x3 == set output to "0" (off)
+                   |
+            write 0x1 == set output to "1" (on)
+            write 0x4 == set output to "0" (off)
+
+
+Required properties:
+- compatible : "snps,creg-gpio"
+- reg : Exactly one register range with length 0x4.
+- #gpio-cells : Should be one - the pin number.
+- gpio-controller : Marks the device node as a GPIO controller.
+- snps,ngpios: Number of GPIO pins.
+- snps,bit-per-line: Number of bits per each gpio line (see picture).
+  Array the size of "snps,ngpios"
+- snps,shift: Shift (in bits) of the each GPIO field from the previous one in
+  register (see picture). Array the size of "snps,ngpios"
+- snps,on-val: Value should be set in corresponding field to set
+  output to "1" (see picture). Array the size of "snps,ngpios"
+- snps,off-val: Value should be set in corresponding field to set
+  output to "0" (see picture). Array the size of "snps,ngpios"
+
+Optional properties:
+- snps,default-val: default output field values. Array the size of "snps,ngpios"
+
+Example (see picture):
+
+gpio: gpio@f00014b0 {
+	compatible = "snps,creg-gpio";
+	reg = <0xf00014b0 0x4>;
+	gpio-controller;
+	#gpio-cells = <1>;
+	snps,ngpios = <2>;
+	snps,shift = <5 1>;
+	snps,bit-per-line = <2 3>;
+	snps,on-val = <2 1>;
+	snps,off-val = <3 4>;
+	snps,default-val = <2 1>;
+};
-- 
2.14.4

