Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41956C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1946221872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266270;
	bh=WNOwBRd7Cg3ccUfi5eKKXS6k5rYfcwwrn5HBDhNzsZE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GS1WDIcF7223LaJ5Tq4tSRsWG9Wt7NDYrVXeCRmeXfjYXJg/7X3AWjNZbj59tNbbb
	 E9pDuhUIUtcU4oyuvRcdDF5UUpxlraNJrc4/pRaeWYFXUHY+Sx1bCxw/Cz0zuWHx4G
	 fBBr9W0pqXUcQYaSvheKJtEmbax0ccjRL4oI3Gvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfAWR5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:57:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfAWR5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=T6YxzP1LgQHgdegMGHZdS5wzUOUXXueEBQf/gO8791s=; b=d03UtRjA+SXx
        Nr+3Toqq+U4ECTcj4EUD1RVaSKTRd2V7hMUUZbFLudbS0itb+KUbouJ410f5GlNaEojFCZpGkz4TH
        uv/RH+lm5KrW1u6KAg9Ovs/gvjYMJfo59NFCbNuyAeYJ3n3gGGBCWsTqwTSxf9YZotnrnL6mBgZGx
        jpFro=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmV-0006qI-0V; Wed, 23 Jan 2019 17:57:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EE9D91127ABA; Wed, 23 Jan 2019 17:57:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bindings: ROHM bd70528 regulator bindings" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190123175741.EE9D91127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:57:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bindings: ROHM bd70528 regulator bindings

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

From 45b5d2b7a976309c31f13795ad63a9488d0d7bbd Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Tue, 22 Jan 2019 11:46:37 +0200
Subject: [PATCH] regulator: bindings: ROHM bd70528 regulator bindings

ROHM bd70528 is a ultra low power PMIC which includes
3 bucks, 3 LDOs and 2 LED drivers. Document the bindings
for them.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/rohm,bd70528-regulator.txt      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
new file mode 100644
index 000000000000..698cfc3bc3dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
@@ -0,0 +1,68 @@
+ROHM BD70528 Power Management Integrated Circuit regulator bindings
+
+Required properties:
+ - regulator-name: should be "buck1", "buck2", "buck3", "ldo1", "ldo2", "ldo3",
+		   "led_ldo1", "led_ldo2"
+
+List of regulators provided by this controller. BD70528 regulators node
+should be sub node of the BD70528 MFD node. See BD70528 MFD bindings at
+Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
+
+The valid names for BD70528 regulator nodes are:
+BUCK1, BUCK2, BUCK3, LDO1, LDO2, LDO3, LED_LDO1, LED_LDO2
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+regulators {
+	buck1: BUCK1 {
+		regulator-name = "buck1";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3400000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <125>;
+	};
+	buck2: BUCK2 {
+		regulator-name = "buck2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <125>;
+	};
+	buck3: BUCK3 {
+		regulator-name = "buck3";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-ramp-delay = <250>;
+	};
+	ldo1: LDO1 {
+		regulator-name = "ldo1";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+	ldo2: LDO2 {
+		regulator-name = "ldo2";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	ldo3: LDO3 {
+		regulator-name = "ldo3";
+		regulator-min-microvolt = <1650000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	led_ldo1: LED_LDO1 {
+		regulator-name = "led_ldo1";
+		regulator-min-microvolt = <200000>;
+		regulator-max-microvolt = <300000>;
+	};
+	led_ldo2: LED_LDO2 {
+		regulator-name = "led_ldo2";
+		regulator-min-microvolt = <200000>;
+		regulator-max-microvolt = <300000>;
+	};
+};
-- 
2.20.1

