Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47BAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADAE208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADAE208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeHWAKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:53340 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeHWAKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 331D4B5BB7;
        Wed, 22 Aug 2018 22:43:43 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HBsFBq-qV94k; Wed, 22 Aug 2018 22:43:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6CDD7B5B97;
        Wed, 22 Aug 2018 22:43:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UG2cAdYFV3kr; Wed, 22 Aug 2018 22:43:16 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A1578B5B99;
        Wed, 22 Aug 2018 22:43:14 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 12/14] dt-bindings: ehci-mv: add bindings
Date:   Wed, 22 Aug 2018 22:43:05 +0200
Message-Id: <20180822204307.13251-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/usb/ehci-mv.txt       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-mv.txt

diff --git a/Documentation/devicetree/bindings/usb/ehci-mv.txt b/Documentation/devicetree/bindings/usb/ehci-mv.txt
new file mode 100644
index 000000000000..335589895763
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ehci-mv.txt
@@ -0,0 +1,23 @@
+* Marvell PXA/MMP EHCI controller.
+
+Required properties:
+
+- compatible: must be "marvell,pxau2o-ehci"
+- reg: physical base addresses of the controller and length of memory mapped region
+- interrupts: one EHCI controller interrupt should be described here
+- clocks: phandle list of usb clocks
+- clock-names: should be "USBCLK"
+- phys: phandle for the PHY device
+- phy-names: should be "usb"
+
+Example:
+
+	ehci0: usb-ehci@d4208000 {
+		compatible = "marvell,pxau2o-ehci";
+		reg = <0xd4208000 0x200>;
+		interrupts = <44>;
+		clocks = <&soc_clocks MMP2_CLK_USB>;
+		clock-names = "USBCLK";
+		phys = <&usb_otg_phy>;
+		phy-names = "usb";
+	};
-- 
2.17.1

