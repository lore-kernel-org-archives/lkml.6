Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BA1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6FE272E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="L40RzVwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6FE272E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeF1Lq7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:46:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933910AbeF1Lq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+x5HeeJTw1ePis6/XHI6pqEVw42IvZSAGlBb+uwK7TA=; b=L40RzVwg/EH8
        XV0bZoio2Yrqqzm865KBt5C9KOz2kGCxey5JJZv3kP2aki8o1KrGgQSwMeF9qET1+bbs/2+upOnYH
        Ds4G53YpJ/75Lgl6JJXLi604/It1ytvfOchjzNMRuMiYBo3skmBMepJ8u66eeSI8Anv8WISaAg4Bz
        2Vppc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYVO0-0005PP-2Z; Thu, 28 Jun 2018 11:46:52 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYVNz-0006eT-DN; Thu, 28 Jun 2018 12:46:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.shevchenko@gmail.com, axel.lin@ingics.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: Remove duplicate description from DT bindings" to the regulator tree
In-Reply-To:  <b4d847919a7c72365478240f443debd2601a073e.1530184909.git.matti.vaittinen@fi.rohmeurope.com>
Message-Id: <E1fYVNz-0006eT-DN@debutante>
Date:   Thu, 28 Jun 2018 12:46:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: Remove duplicate description from DT bindings

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

From 312ae0ae7479d30f8876bafbc4cca24f0605c65f Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Thu, 28 Jun 2018 14:23:04 +0300
Subject: [PATCH] regulator: bd71837: Remove duplicate description from DT
 bindings

Same general chip description was written in MFD and Regulator
binding documents for ROHM bd71837 PMIC. Remove description from
regulator binding as suggested by Rob H.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/rohm,bd71837-regulator.txt         | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 4edf3137d9f7..76ead07072b1 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -1,13 +1,5 @@
 ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
 
-BD71837MWV is a programmable Power Management
-IC (PMIC) for powering single-core, dual-core, and
-quad-core SoC’s such as NXP-i.MX 8M. It is optimized
-for low BOM cost and compact solution footprint. It
-integrates 8 Buck regulators and 7 LDO’s to provide all
-the power rails required by the SoC and the commonly
-used peripherals.
-
 Required properties:
  - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
 
-- 
2.18.0.rc2

