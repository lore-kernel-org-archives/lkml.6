Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB962150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB962150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJKAqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:46:37 -0400
Received: from shell.v3.sk ([90.176.6.54]:54520 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbeJKAqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:46:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5DD85BCFB9;
        Wed, 10 Oct 2018 19:23:25 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ENU2YYY79_UT; Wed, 10 Oct 2018 19:23:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 15E2EBCFC1;
        Wed, 10 Oct 2018 19:23:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WODnu4ekLcZd; Wed, 10 Oct 2018 19:23:04 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 77C98BCFB5;
        Wed, 10 Oct 2018 19:23:03 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 03/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
Date:   Wed, 10 Oct 2018 19:22:48 +0200
Message-Id: <20181010172300.317643-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
signals for handshaking. It needs to know when is the slave (Linux)
side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
controller node) and when does it wish to respond with a command (the
cmd-gpio property).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec=
.txt

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/=
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
new file mode 100644
index 000000000000..14385fee65d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
@@ -0,0 +1,24 @@
+OLPC XO-1.75 Embedded Controller
+
+Required properties:
+- compatible: Should be "olpc,xo1.75-ec".
+- cmd-gpio: gpio specifier of the CMD pin
+
+The embedded controller requires the SPI controller driver to signal rea=
diness
+to receive a transfer (that is, when TX FIFO contains the response data)=
 by
+strobing the ACK pin with the ready signal. See the "ready-gpio" propert=
y of the
+SSP binding as documented in:
+<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
+
+Example:
+	&ssp3 {
+		spi-slave;
+		status =3D "okay";
+		ready-gpio =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+		slave {
+			compatible =3D "olpc,xo1.75-ec";
+			spi-cpha;
+			cmd-gpio =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
+		};
+	};
--=20
2.19.0

