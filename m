Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2311C20684
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2311C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeKMUUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:20:30 -0500
Received: from shell.v3.sk ([90.176.6.54]:38266 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbeKMUU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:20:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5778CC6B2B;
        Tue, 13 Nov 2018 11:22:58 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Acdg_hKNJEBN; Tue, 13 Nov 2018 11:22:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D28B7C6B20;
        Tue, 13 Nov 2018 11:22:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a9zPvshygPKE; Tue, 13 Nov 2018 11:22:42 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B8AA9C6B22;
        Tue, 13 Nov 2018 11:22:41 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 4/6] spi: pxa2xx: dt-bindings: Add ready GPIO signal
Date:   Tue, 13 Nov 2018 11:22:26 +0100
Message-Id: <20181113102228.820214-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This this is used to let the SPI master know that our FIFO is filled and
we're ready to service a transfer. Only useful in slave mode.

A signal like this is used by an embedded controller on a OLPC XO 1.75
machine, that happens to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- s/ready-gpio/ready-gpios/
- Updated the subject line to conform with subsystem customs

 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt b/Docum=
entation/devicetree/bindings/spi/spi-pxa2xx.txt
index 89b2832283e3..e30e0c2a4bce 100644
--- a/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
@@ -12,6 +12,8 @@ Optional properties:
 - cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
   Documentation/devicetree/bindings/spi/spi-bus.txt
 - spi-slave: Empty property indicating the SPI controller is used in sla=
ve mode.
+- ready-gpios: GPIO used to signal a SPI master that the FIFO is filled
+  and we're ready to service a transfer. Only useful in slave mode.
=20
 Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
--=20
2.19.1

