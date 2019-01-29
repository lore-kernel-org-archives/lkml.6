Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E695C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782187;
	bh=8s8I6yjkfMBaufzG1UPJJ+3IdgD1cybCOesImetxX60=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=CyN45LKk/ZsahRYNw8OCA/cEQaG3oak3cNHtg369nZL2cy6uowN8jugwxdnx1BWfD
	 vst/08YJR3IiiUE4BD6MK7XiL50cY6BLs8TRAr1mnJdpHfjuCo+bprH3rQcnA8Vo3f
	 IcGC56bUaEr5dc22gJ5TjaZtmH4CraIno2TwV6ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfA2RQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:16:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50566 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfA2RQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v8jS2mn8ghD5ScY0ItsS8vxTaSjgzEDFgodpc+mFhdE=; b=V0ZEdJjtJYYV
        mSqvEn+evXZwd3G3yb4Yea52XT0dDCO1JWeUTbX72bEhdp/aMyQpA9K6KgGutArIVWkuTVWSBtudZ
        jDIUci284Sz+tExON3SmtAMsxPDLHJm9azscRiYde6ofcYa/YDp7eTiImekrmE/BAAOu3yx2rPWJP
        BiGAk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goWzm-0000jl-TQ; Tue, 29 Jan 2019 17:16:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 782691127D50; Tue, 29 Jan 2019 17:16:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: add DT bindings for max77650" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190129171622.782691127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 17:16:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: add DT bindings for max77650

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

From 0eca80bf07eb51cf7accf44dbf71547fd0bba5dd Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 29 Jan 2019 14:35:34 +0100
Subject: [PATCH] dt-bindings: regulator: add DT bindings for max77650

Add the DT binding document for max77650 regulators.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/max77650-regulator.txt | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/max77650-regulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
new file mode 100644
index 000000000000..f1cbe813c30f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.txt
@@ -0,0 +1,41 @@
+Regulator driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The regulator controller is represented as a sub-node of the PMIC node
+on the device tree.
+
+The device has a single LDO regulator and a SIMO buck-boost regulator with
+three independent power rails.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-regulator"
+
+Each rail must be instantiated under the regulators subnode of the top PMIC
+node. Up to four regulators can be defined. For standard regulator properties
+refer to Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sbb2".
+
+Example:
+--------
+
+	regulators {
+		compatible = "maxim,max77650-regulator";
+
+		max77650_ldo: regulator@0 {
+			regulator-compatible = "ldo";
+			regulator-name = "max77650-ldo";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <2937500>;
+		};
+
+		max77650_sbb0: regulator@1 {
+			regulator-compatible = "sbb0";
+			regulator-name = "max77650-sbb0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1587500>;
+		};
+	};
-- 
2.20.1

