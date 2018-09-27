Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B59C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08421710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D08421710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeI1Ers (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:47:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39779 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1Ers (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:47:48 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LqDh3fFdz1qxQD;
        Fri, 28 Sep 2018 00:27:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LqDh3DSRz1r44m;
        Fri, 28 Sep 2018 00:27:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id J-_DU1Npe2hq; Fri, 28 Sep 2018 00:27:15 +0200 (CEST)
X-Auth-Info: SGy/gdd56PQgQRptON0oU8vaxTWsGNhuWEzfdRxij00=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 28 Sep 2018 00:27:15 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] dt-bindings: misc: bk4: Add device tree binding for Liebherr's BK4 SPI bus
Date:   Fri, 28 Sep 2018 00:26:55 +0200
Message-Id: <20180927222655.24482-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree binding document for Liebherr's BK4 external SPI bus.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/misc/lwn-bk4.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt

diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
new file mode 100644
index 000000000000..d6a8c188c087
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
@@ -0,0 +1,26 @@
+* Liebherr's BK4 controller external SPI
+
+A device which handles data acquisition from compatible industrial
+peripherals.
+The SPI is used for data and management purposes in both master and
+slave modes.
+
+Required properties:
+
+- compatible : Should be "lwn,bk4"
+
+Required SPI properties:
+
+- reg : Should be address of the device chip select within
+  the controller.
+
+- spi-max-frequency : Maximum SPI clocking speed of device in Hz, should be
+  30MHz at most for the Liebherr's BK4 external bus.
+
+Example:
+
+spidev0: spi@0 {
+	compatible = "lwn,bk4";
+	spi-max-frequency = <30000000>;
+	reg = <0>;
+};
-- 
2.11.0

