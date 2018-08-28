Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204FEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5911205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="agZzP1rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5911205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeH2BCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47816 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eymZ8EhIu/XJuezQAOhRXS5xCGrKbWciHCChYikn2Go=; b=agZzP1rPrTxV
        /lCTKnHtgYzJbbd3UEhDjT955Fwd2FH1VCiIY4Zj44Wu47kyOm0ju/ypA/M4ERaxYKlvThtc76et/
        H1/0zHi4jwT7UEklRs43A5WYG5GtRJVeZ5c98C3oKt96UVkI/SNKXMY+ZfPtOZplFHV56Y4q/XrzK
        tMNg4=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE1-0007lp-5y; Tue, 28 Aug 2018 21:08:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CB08F440083; Tue, 28 Aug 2018 21:55:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: isl9305: Add missing .owner field in regulator_desc" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205504.CB08F440083@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:55:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: isl9305: Add missing .owner field in regulator_desc

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

From 46942b21a95ffd1476c82b3a8683a1caa58b6f40 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 27 Aug 2018 22:15:21 +0800
Subject: [PATCH] regulator: isl9305: Add missing .owner field in
 regulator_desc

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/isl9305.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index 257c1943e753..9c2607e912cf 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -84,6 +84,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_DCD1_EN,
 		.supply_name =	"VINDCD1",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 	[ISL9305_DCD2] = {
 		.name =		"DCD2",
@@ -98,6 +99,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_DCD2_EN,
 		.supply_name =	"VINDCD2",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 	[ISL9305_LDO1] = {
 		.name =		"LDO1",
@@ -112,6 +114,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_LDO1_EN,
 		.supply_name =	"VINLDO1",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 	[ISL9305_LDO2] = {
 		.name =		"LDO2",
@@ -126,6 +129,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_LDO2_EN,
 		.supply_name =	"VINLDO2",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 };
 
-- 
2.18.0

