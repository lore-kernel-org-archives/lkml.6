Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C52C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEA420849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nruD8W6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEA420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeLMOqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:46:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43776 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeLMOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:46:04 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] Documentation: dt: Add binding info for jz4740-musb driver
Date:   Thu, 13 Dec 2018 15:45:52 +0100
Message-Id: <20181213144555.24031-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544712362; bh=4y2hxwsZG4mriJ47HHwLXXiR4ye2MNK5snwtkVum/UQ=; h=From:To:Cc:Subject:Date:Message-Id; b=nruD8W6n/Az0S/K+DFBi/ObT3qMWPgvHJRNpIXlY+LNwBSHxmNrs3y1CEfAKZy0VlxAQ5sDKcw1GnvgImRelayn374hRCzgTSbTj5YtEyQShOfta1ZIoe3Sd0gwRzbETG3xRtzGQehlQFIt4GWoyQG6qm8aDb1ejp7M3szT+vTw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds documentation for the device-tree bindings of the
jz4740-musb driver, which provides support for the USB gadget mode
of the JZ4740 and similar SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
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

