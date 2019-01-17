Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1732C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3FB20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VbkWgLjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAQWdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:33:44 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34074 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfAQWdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547764422; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=RfOtYXOSMZyb5tu5jZWvxUvUTLmxuUVYXiRBhS7dnA0=;
        b=VbkWgLjBntT3RdmdsnvBL4SSNMhUz6NsoXB+5FAZBlZDCCSP+dE/+i9J6/v6kbhOZgm9I3
        7eD4tyIzl6j0Q9gZnOk6Gv5Ea3AE1D1UnLls8cy5AaYZbF2nwEATfv0R6wdr1bF+918vL0
        a8Vn9lg2nHsYCiTXCbrmY7QhDz3zpSY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/4] Documentation: dt: Add binding info for jz4740-musb driver
Date:   Thu, 17 Jan 2019 19:33:27 -0300
Message-Id: <20190117223330.16631-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds documentation for the device-tree bindings of the
jz4740-musb driver, which provides support for the USB gadget mode
of the JZ4740 and similar SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v2: No change

v3: No change

 .../bindings/usb/ingenic,jz4740-musb.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
new file mode 100644
index 000000000000..620355cee63f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
@@ -0,0 +1,24 @@
+Ingenic JZ4740 MUSB driver
+
+Required properties:
+
+- compatible: Must be "ingenic,jz4740-musb"
+- reg: Address range of the UDC register set
+- interrupts: IRQ number related to the UDC hardware
+- interrupt-names: must be "mc"
+- clocks: phandle to the "udc" clock
+- clock-names: must be "udc"
+
+Example:
+
+udc: usb@13040000 {
+	compatible = "ingenic,jz4740-musb";
+	reg = <0x13040000 0x10000>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <24>;
+	interrupt-names = "mc";
+
+	clocks = <&cgu JZ4740_CLK_UDC>;
+	clock-names = "udc";
+};
-- 
2.11.0

