Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702ADC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF32208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="H4qCb0gM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF32208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964811AbeFRMBP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:01:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47216 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeFRMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IIgG+v+w8iF85jgoOWKuHdgsJFeYxgcs3UHi9NI4R8g=; b=H4qCb0gMD16H
        G1oV/QBHL4juDa6wq6tq+RaN8bpjo+V5jIbyPk/Y03gR3PPc4QIt8qyS27Ca/xmCn3r/kfsQXZNXs
        1hLFFjsQXyYM6fP6vbZ6pQySLp/Aai8NDZ/ZHjKBHtiZi7zY5nBZM1G1o3f4Hktc6wm6cZTIiUR5r
        Dy48o=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsqJ-000818-VZ; Mon, 18 Jun 2018 12:01:08 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsqJ-0000ZX-Hp; Mon, 18 Jun 2018 13:01:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100: add pfuze3001 support" to the regulator tree
In-Reply-To:  <1529063093-19582-2-git-send-email-stefan.wahren@i2se.com>
Message-Id: <E1fUsqJ-0000ZX-Hp@debutante>
Date:   Mon, 18 Jun 2018 13:01:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100: add pfuze3001 support

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5986f83efab0435918e58416f89a5d82adc11f5d Mon Sep 17 00:00:00 2001
From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Fri, 15 Jun 2018 13:44:52 +0200
Subject: [PATCH] regulator: pfuze100: add pfuze3001 support

This patch extends binding according to support the pfuze3001 chip.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/pfuze100.txt           | 77 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index f0ada3b14d70..672c939045ff 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -1,7 +1,7 @@
 PFUZE100 family of regulators
 
 Required properties:
-- compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000"
+- compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
 - reg: I2C slave address
 
 Required child node:
@@ -16,6 +16,8 @@ Required child node:
   sw1ab,sw2,sw3a,sw3b,swbst,vsnvs,vrefddr,vgen1~vgen6,coin
   --PFUZE3000
   sw1a,sw1b,sw2,sw3,swbst,vsnvs,vrefddr,vldo1,vldo2,vccsd,v33,vldo3,vldo4
+  --PFUZE3001
+  sw1,sw2,sw3,vsnvs,vldo1,vldo2,vccsd,v33,vldo3,vldo4
 
 Each regulator is defined using the standard binding for regulators.
 
@@ -303,3 +305,76 @@ Example 3: PFUZE3000
 			};
 		};
 	};
+
+Example 4: PFUZE 3001
+
+	pfuze3001: pmic@8 {
+		compatible = "fsl,pfuze3001";
+		reg = <0x08>;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
-- 
2.17.1

