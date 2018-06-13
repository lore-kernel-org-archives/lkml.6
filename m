Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4ACAFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B27208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="hkMzT4/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B27208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935398AbeFMOi1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:38:27 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:40976 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935842AbeFMOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:38:19 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 415TrT5blSz1XLFsv;
        Wed, 13 Jun 2018 16:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528900697;
        bh=xKWvSJAExCFYwQPkF9cpeARYs1KgGM4+MQ0/Lt2hetU=; l=10;
        h=From:From:Reply-To:Sender;
        b=hkMzT4/Jcl+9EBh0ZdB3+S+M23K+QHsBdXbGWY8WrjYnMM4P/zEyUs5Ck3ceeVXq8
         5iOOYphx8uG89S8sSJvTWjvEJdsTMk6jFd3B8a4L0dQIFAad8l7TUKcd90BYac9R2I
         9Jo5pUvYP3lYWiTJWSqxKWmhhib7X78DXMWPRXAM=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 415TrT5DSQz1Cf;
        Wed, 13 Jun 2018 16:38:17 +0200 (CEST)
X-AuditID: 0a3aad10-40fff70000000ee7-11-5b212c676bd6
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id 2A.7E.03815.76C212B5; Wed, 13 Jun 2018 16:38:31 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 415TrT3c3rzBpBV;
        Wed, 13 Jun 2018 16:38:17 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.319.2; Wed, 13 Jun 2018 16:38:17 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <yi.zhu5@cn.bosch.com>, <petar.petrovic2@de.bosch.com>,
        <stephan.baetge@de.bosch.com>, <andy.shevchenko@gmail.com>,
        <socketcan@hartkopp.net>, <o.rempel@pengutronix.de>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 5/5] spi,can,char: add companion DT binding documentation
Date:   Wed, 13 Jun 2018 16:37:21 +0200
Message-ID: <1528900641-18677-6-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sb1BUVRjGOXuX3bsrtw53Ad+WWOQyTs2GCBVyldL65I4mWTM2ozTR3bjs
        brEL3buQ2J8xlEaQGbFQ2dVZCGgq/LOuhq0UUSsIVGMOxahhYkS2UM6E2Lg5unQvC+5+6MuZ
        c97n/Z3nnOcckqCH1HrS5nDygoMrY1RapXbV0bRllqyMopyvpzE72XgGsf7LYwTbeWsfwf7Y
        fUjFetualOzZ1hR24gpiL06F1exHV07HP6UxedyDStNp9y9q0/TwKDLtmO1Tm/bczTHNnDBs
        VG3RPlHCl9mqeGH56pe11iMnW4iKQOrWn2p96u3oWlI90pCAH4fg9/tRPdKSNG5WwEnXHiKy
        6EHQ/KdrXvkcQdNoj1JGVNgIlwb9hDxPwpvg4O/vKeUmAn+lgNGe3UgWdPgZuNx9c65JiZfC
        SMOguh6RJIXXwh+7H45YG+DSubq5Fg02QVe3Zw6lcS2Ckf4X5DmFE2HINTHnS2CAb4JBohHd
        746R3DFSK1J0ouRSPqfKnr8yl80WzLy4LSc3+5Vy+wkUCRr7kXvIHECYREwC5UrPKKLjuSqx
        2h5AeaSCSaYKG5cU0feZy0uqrZxoLRYqy3iR0VMoLi6O1t0ri5Vmu00UbeWOAAKSYJKowqDE
        USVc9TZeKI9gAZRKKpnFVEPJW1tobOGc/Gs8X8ELC2oBSTJAiY9IZ0gUeAu/tdRW5lyQmbSI
        Z0qsEmurIDUB9BiZIHlr5C0osYKzizbLPP5ABKcXqlH0W5SvX0ydNUoMllVrpeOeq/5Bqugz
        6SLJMUKUnEIXkZSbjnpHNkyQ/nDUDyi/7tBmOnG+GIUe7ZAY/MUi8NQI4PH/g2DvznECen01
        8fBz6Hg8nDn1sQpcrX+rYOdAiwYG3x/QwF/tuyjYFeiioGHyGIbQSGsiNNTV0jB8444Omtt7
        AcIdPj3MfPKbNHw4KQ3BrjTwhfoMEG761QB3Bo6nw9iOA0tgtubTDPBPDDMw8+91BoZvt2eC
        J3Q1E87XjGeCt3daWnb8sHRKylIhZdnfL7+j6OSc/5PlfDV6Of12VHwDXMdWrGWfdhttxeOh
        9tWBI1PG5yxj5pbbhaTSk9XzYt+bd5/32uPWhNcV3Ex+dXlb26lFeQWvb1hxYP91xrKeT/PO
        5vN09pfpF9ZsTCp99wPFQ9Pn6lKunb/q3bzPkvekUZO6bHKVwf+S40LW0bc7xsLfda5U3XpW
        XxFE1sNZvjcYpWjlco2EIHL/AdSBc1pcBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 .../devicetree/bindings/spi/bosch,companion.txt    | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt

diff --git a/Documentation/devicetree/bindings/spi/bosch,companion.txt b/Documentation/devicetree/bindings/spi/bosch,companion.txt
new file mode 100644
index 0000000..5ded325
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/bosch,companion.txt
@@ -0,0 +1,82 @@
+Bosch Companion SPI slave device
+
+The functionality bases on an external peripheral chip named Companion.
+It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
+well as one receive FIFO. Besides CAN, undisclosed additional functions
+can be accessed through the char device.
+
+A standard SPI interface with two additional lines for flow control is
+used. The Companion chip is the SPI slave.
+
+The driver suite consists of three separate drivers. The following
+diagram illustrates the dependencies in layers.
+
+           /dev/companion       SocketCAN                User Space
+-------------------------------------------------------------------
+         +----------------+ +---------------+
+         | companion-char | | companion-can |
+         +----------------+ +---------------+
+         +----------------------------------+
+         |          companion-spi           |
+         +----------------------------------+
+         +----------------------------------+
+         |     standard SPI subsystem       |
+         +----------------------------------+          Linux Kernel
+-------------------------------------------------------------------
+               | | | |      | |                            Hardware
+            CS-+ | | |      | +-BUSY
+            CLK--+ | |      +---REQUEST
+            MOSI---+ |
+            MISO-----+
+
+Required properties:
+
+- compatible       : must be "bosch,companion-spi"
+- interrupt-parent : the phandle of the GPIO controller
+- interrupts       : (GPIO) interrupt to which 'request-gpios' is
+                     connected to
+- request-gpios    : GPIO pin to request SPI master to receive data
+- busy-gpios       : GPIO pin to indicate SPI slave is busy
+- cs-gpios         : GPIO pin to select SPI slave
+
+Optional properties:
+
+The controller supports at most 2 CAN and 1 char device subnodes. When
+optionally specify the subnodes, the following properties are required:
+
+- CAN subnode
+  - compatible     : must be "bosch,companion-can"
+  - clock-frequency: CAN device clock in Hz
+  - port           : must be 0 or 1
+
+- Char device subnode
+  - compatible     : must be "bosch,companion-char"
+
+Example:
+
+&ecspi1 {
+	companion-spi@0 {
+		compatible = "bosch,companion-spi";
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+		request-gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
+		busy-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+		cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+
+		companion-can0 {
+			compatible = "bosch,companion-can";
+			clock-frequency = <28000000>;
+			port = <0>;
+		};
+
+		companion-can1 {
+			compatible = "bosch,companion-can";
+			clock-frequency = <28000000>;
+			port = <1>;
+		};
+
+		companion-char {
+			compatible = "bosch,companion-char";
+		};
+	};
+};
-- 
2.7.4

