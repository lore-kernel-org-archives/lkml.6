Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC00A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC00A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeIJQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:53:47 -0400
Received: from shell.v3.sk ([90.176.6.54]:36033 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeIJQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:53:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2ED77B82E8;
        Mon, 10 Sep 2018 14:00:00 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mah41dGunB0T; Mon, 10 Sep 2018 13:59:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4B6ABB82D8;
        Mon, 10 Sep 2018 13:59:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C-irzjzSTWC9; Mon, 10 Sep 2018 13:59:49 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 39A87B8280;
        Mon, 10 Sep 2018 13:59:49 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI Controller
Date:   Mon, 10 Sep 2018 13:59:31 +0200
Message-Id: <20180910115935.163121-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910115935.163121-1-lkundrak@v3.sk>
References: <20180910115935.163121-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the SPI controller found on Marvel MMP2 and perhaps more
platforms.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/spi/spi-pxa2xx.txt    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
new file mode 100644
index 000000000000..75be87cf9909
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -0,0 +1,24 @@
+PXA2xx SSP SPI Controller
+
+Required properties:
+- compatible: Must be "marvell,mmp2-ssp".
+- reg: Offset and length of the device's register set.
+- interrupts: Should be the interrupt number.
+- clocks: Should contain a single entry describing the clock input.
+- #address-cells:  Number of cells required to define a chip select address.
+- #size-cells: Should be zero.
+
+Optional properties:
+- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
+  Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Child nodes represent devices on the SPI bus
+  See ../spi/spi-bus.txt
+
+Example:
+	ssp1: ssp@d4035000 {
+		compatible = "marvell,mmp2-ssp";
+		reg = <0xd4035000 0x1000>;
+		clocks = <&soc_clocks MMP2_CLK_SSP0>;
+		interrupts = <0>;
+	};
-- 
2.17.1

