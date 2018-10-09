Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F72ECDFDF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8F3214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SxrOQmHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8F3214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJJCJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:09:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38343 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeJJCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539111087; x=1570647087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TtsfGcDM3h5ap+H9kxy/xjXfnWIH0/v0qN2/iTEdC0c=;
  b=SxrOQmHxTv8mFcdkj5o0I8zamextg6M7ML3EtOL6pWEpwqCDPnIDClIS
   jlS+KumiLqyFAvCp2/obTs1DRSdiN/rvquT96mPOQUy5KUlQXgOckiAjD
   uSCZEqzCrc+OXGDQEQ6lggTwpa7ZKBxagXj2vpVLhXA+j7N9navtEPWUX
   gO3aYKvhAHWqZrULKY9HFORs662Fp+F8dFm6IzAhAs9cnIWcIUYwYMfS/
   fqZklGlplLUHSn7QVbJ5kor4zGIcU6u2WlUzbKzEBCSPpUFbEgLl8czzF
   U/YUoAGKT57uYdwAX3Z+5FNfw9w1xrhSu+S1uni7Y5iaKG7bhgCLzxmuu
   g==;
X-IronPort-AV: E=Sophos;i="5.54,361,1534780800"; 
   d="scan'208";a="195909237"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2018 02:51:26 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Oct 2018 11:36:36 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2018 11:51:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hch@infradead.org, atish.patra@wdc.com
Subject: [RFC 3/4] gpio: sifive: Add DT documentation for SiFive GPIO.
Date:   Tue,  9 Oct 2018 11:51:24 -0700
Message-Id: <1539111085-25502-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

DT documentation for GPIO added with updated compatible
string.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../devicetree/bindings/gpio/gpio-sifive.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sifive.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sifive.txt b/Documentation/devicetree/bindings/gpio/gpio-sifive.txt
new file mode 100644
index 00000000..781fe4ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sifive.txt
@@ -0,0 +1,28 @@
+SiFive GPIO controller bindings
+
+Required properties:
+- compatible: should be one of
+  	 "sifive,fu540-c000-gpio0","sifive,gpio0"
+- reg: Physical base address and length of the controller's registers.
+- #gpio-cells : Should be 2
+  - The first cell is the GPIO offset number.
+  - The second cell indicates the polarity of the GPIO
+- gpio-controller : Marks the device node as a GPIO controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2.
+  - The first cell is the GPIO offset number within the GPIO controller.
+  - The second cell is the edge/level to use for interrupt generation.
+- interrupts: Specify the interrupts, one per GPIO
+
+Example:
+
+gpio: gpio@10060000 {
+	compatible = "sifive,fu540-c000-gpio0","sifive,gpio0";
+	interrupt-parent = <&plic>;
+	interrupts = <7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22>;
+	reg = <0x0 0x10060000 0x0 0x1000>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
-- 
2.7.4

