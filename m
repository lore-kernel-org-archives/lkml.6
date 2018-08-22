Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43721C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEA620C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEA620C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeHWAJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:09:52 -0400
Received: from shell.v3.sk ([90.176.6.54]:53230 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeHWAJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:09:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DE66AB5B0A;
        Wed, 22 Aug 2018 22:43:23 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9LU4HOdq9Z5F; Wed, 22 Aug 2018 22:43:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B8DDEB5AEE;
        Wed, 22 Aug 2018 22:43:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id antQhvyj8nfX; Wed, 22 Aug 2018 22:43:11 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D7B20B5B8B;
        Wed, 22 Aug 2018 22:43:10 +0200 (CEST)
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
Subject: [PATCH 02/14] dt-bindings: phy-pxa-usb: add bindings
Date:   Wed, 22 Aug 2018 22:42:55 +0200
Message-Id: <20180822204307.13251-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the PHY chip for USB OTG on PXA platforms.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/phy/phy-pxa-usb.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
new file mode 100644
index 000000000000..5b12ab44c9e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
@@ -0,0 +1,17 @@
+Marvell PXA USB PHY
+-------------------
+
+Required properties:
+- compatible: one of: "marvell,mmp2-usb-phy", "marvell,pxa910-usb-phy",
+	"marvell,pxa168-usb-phy",
+- #phy-cells: must be 0
+
+Example:
+	usb-phy: usbphy@d4207000 {
+		compatible = "marvell,mmp2-usb-phy";
+		reg = <0xd4207000 0x40>;
+		#phy-cells = <0>;
+		status = "okay";
+	};
+This document explains only the device tree data binding. For general
+information about PHY subsystem refer to Documentation/phy.txt
-- 
2.17.1

