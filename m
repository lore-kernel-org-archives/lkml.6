Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82337C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD2D2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IyvKZvBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD2D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeH2BCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47784 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeH2BCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hTdYlKGbZ17mcOK0t8F5/quv5zVccrlHt/ub9a4P5/g=; b=IyvKZvBFv8MS
        R03tkoBuRg9pieuDsv9P7lK4BAF7gtwi5lttiMRS9VlnRNv5vmER9kMzC1OAMZapk+/r8otgnzfIB
        0rpQzSZIFU2I6dT3svK2YHCdCzIpjXhRu1ZIaDw1LXWAX1dLXsMQRqDMHP0eP0utufz09QFYW/2Rf
        IRuHE=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE1-0007lk-1G; Tue, 28 Aug 2018 21:08:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1FF04440080; Tue, 28 Aug 2018 21:55:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: Remove duplicate assignment for n_voltages of LDO2" to the regulator tree
In-Reply-To: 
Message-Id: <20180828205503.1FF04440080@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:55:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: Remove duplicate assignment for n_voltages of LDO2

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

From 61b2e6741e81226c29a5ed92fd886f11efb78e98 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 24 Aug 2018 19:16:12 +0800
Subject: [PATCH] regulator: bd71837: Remove duplicate assignment for
 n_voltages of LDO2

Set it once is enough.
Also move n_voltages close to volt_table for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd71837-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 0f8ac8dec3e1..9b5e1297902f 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -388,10 +388,9 @@ static const struct regulator_desc bd71837_regulators[] = {
 		.ops = &bd71837_ldo_regulator_nolinear_ops,
 		.type = REGULATOR_VOLTAGE,
 		.volt_table = &ldo_2_volts[0],
+		.n_voltages = ARRAY_SIZE(ldo_2_volts),
 		.vsel_reg = BD71837_REG_LDO2_VOLT,
 		.vsel_mask = LDO2_MASK,
-		.n_voltages = ARRAY_SIZE(ldo_2_volts),
-		.n_voltages = BD71837_LDO2_VOLTAGE_NUM,
 		.enable_reg = BD71837_REG_LDO2_VOLT,
 		.enable_mask = BD71837_LDO_EN,
 		.owner = THIS_MODULE,
-- 
2.18.0

