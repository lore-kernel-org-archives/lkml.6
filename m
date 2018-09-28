Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB772C1B0E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D4721528
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bg11mzpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D4721528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeI1U3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:29:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeI1U3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=znFyqaDwowcPFDyiqT/iBrhBLePPdJk8XIH+DcPVCH0=; b=bg11mzpRDbot
        qjX+/i9vG5qbwJRnE1mP84tgrCVkMYmhZA9RXvfL8mGYGmkElXzI6HnX13DZdT0VSTHQvHTGDPd7H
        JzRi4l7EMUw+wJ/kywb2o5rGZjBRfJrZD8vZNzwNQ54HOAsW0DAiW68/mb94W55LJ7Co4G23BHp8x
        1ZMNU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5tOC-0008WV-4q; Fri, 28 Sep 2018 14:05:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A88E1440078; Fri, 28 Sep 2018 15:05:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: dt bindings: add BD71847 device-tree binding documentation" to the regulator tree
In-Reply-To: 
Message-Id: <20180928140503.A88E1440078@finisterre.ee.mobilebroadband>
Date:   Fri, 28 Sep 2018 15:05:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: dt bindings: add BD71847 device-tree binding documentation

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

From 12fc309a956b82e75db2a19fd36074266bff9413 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Fri, 14 Sep 2018 11:30:06 +0300
Subject: [PATCH] regulator: dt bindings: add BD71847 device-tree binding
 documentation

Add ROHM BD71847 Power Management IC regulator binding information to
device-tree binding documents.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/rohm,bd71837-regulator.txt    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 76ead07072b1..4b98ca26e61a 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -1,7 +1,9 @@
-ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
+ROHM BD71837 and BD71847 Power Management Integrated Circuit regulator bindings
 
 Required properties:
- - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
+ - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7" for
+                   BD71837. For BD71847 names should be "buck1", ..., "buck6"
+		   and "ldo1", ..., "ldo6"
 
 List of regulators provided by this controller. BD71837 regulators node
 should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
@@ -16,10 +18,14 @@ disabled by driver at startup. LDO5 and LDO6 are supplied by those and
 if they are disabled at startup the voltage monitoring for LDO5/LDO6 will
 cause PMIC to reset.
 
-The valid names for regulator nodes are:
+The valid names for BD71837 regulator nodes are:
 BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
 LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
 
+The valid names for BD71847 regulator nodes are:
+BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
+LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
+
 Optional properties:
 - Any optional property defined in bindings/regulator/regulator.txt
 
-- 
2.19.0

