Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72360C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359D821B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=asyring.de header.i=@asyring.de header.b="fuE2ZeES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfBKRYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:24:12 -0500
Received: from asyring.homeip.net ([37.120.161.147]:55598 "EHLO
        vserver.asyring.homeip.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbfBKRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:24:12 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 12:24:11 EST
Received: from localhost (localhost [127.0.0.1])
        by vserver.asyring.homeip.net (Postfix) with ESMTP id 0B8755F8F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 18:14:47 +0100 (CET)
Authentication-Results: mail.asyring.de (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=asyring.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asyring.de; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :date:subject:subject:to:from:from; s=dkim; t=1549905286; x=
        1550769287; bh=PxHmdGBIIavfe+FujuZeHhqR0BLJB3Zd/OO54oJLHsM=; b=f
        uE2ZeESdwGiMZ82Twbmqx63FNzxpda5s92rfQyB+Oa6nRQpE5eBtaJ8ngauSiA3M
        4Ul5WQIp8DdwJgNYjcn+YG6dLwPPk0KLqnAXPhgfsqjY2r+qZa3zknlvhcofiUUa
        REfw15dbuOlTMQbt3l8ujTXVQn7F22GBo5i1W5cqCE=
X-Virus-Scanned: Debian amavisd-new at asyring.homeip.net
Received: from vserver.asyring.homeip.net ([127.0.0.1])
        by localhost (mail.asyring.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e4IN7cHOcgDd for <linux-kernel@vger.kernel.org>;
        Mon, 11 Feb 2019 18:14:46 +0100 (CET)
Received: from Cubietruck.lan. (Cubietruck-Lan.lan [192.168.0.131])
        by vserver.asyring.homeip.net (Postfix) with ESMTPSA id 93F635F83B;
        Mon, 11 Feb 2019 18:14:39 +0100 (CET)
From:   Alexander Syring <alex@asyring.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Syring <alex@asyring.de>
Subject: [PATCH 1/2] arm64: dts: marvell: mcbin: Adding SPI-NOR Flash Config
Date:   Mon, 11 Feb 2019 18:14:01 +0100
Message-Id: <20190211171401.434-1-alex@asyring.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to U-Boot dts file enabling the SPI-NOR flash for use in
Linux

Signed-off-by: Alexander Syring <alex@asyring.de>
---
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 329f8ceeebea..83994ff46e2d 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -333,11 +333,24 @@
 	status = "okay";
 
 	spi-flash@0 {
-		compatible = "st,w25q32";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
+		compatible = "st,w25q32", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+
+			partition@0 {
+				label = "U-Boot";
+				reg = <0 0x200000>;
+			};
+			partition@400000 {
+				label = "U-Boot Env";
+				reg = <0x200000 0xce0000>;
+			};
+		};
+	};
+};
 
 &cp1_usb3_0 {
 	/* CPS Lane 2 - CON7 */
-- 
2.20.1

