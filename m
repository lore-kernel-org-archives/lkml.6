Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A1EC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2022173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mNoL9o9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfAJNhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:37:14 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:51464 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfAJNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547127430; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=M5FERye9NHe7j0zYIe353rKH1QXqrc8+0iuUUl5qByY=;
        b=mNoL9o9uEe4OeztWj+ikwuauvk8ScvuFfF8XLh3McKuL0Xb9m4jvU/d5HFpFnXaa1VHrzd
        ehgEzFvz3c8v9KGhlMjZg9Pq+Ocvkw702vwcD3/mweiMGIMy8g4rP/0O2czDYivYCgv/2I
        IJs//34iGp/+3Xs4tQzw9POqH6FJxP0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/4] Documentation: dt: Add binding info for jz4740-musb driver
Date:   Thu, 10 Jan 2019 10:36:57 -0300
Message-Id: <20190110133700.4471-1-paul@crapouillou.net>
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

