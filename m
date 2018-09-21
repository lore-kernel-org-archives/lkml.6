Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C37ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6FE21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MB/QCSwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6FE21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbeIUHpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:45:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47684 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w9Mvn5xDktEsZbF3s15rO5XAaHQNVxHqTZ38oAYifNw=; b=MB/QCSwjd9gF
        8Ef4U4vSbz8EkibUNZzeGIHsqAwAScM95Dx0hb1iB9EZNf+U/xhtBSKEOoZHytrrqJgGwIRRO8FSr
        yqr85RvLjW6FF+aBEQCJOXz8jkku4d03zouQIQ+43ZzHCXWzckqR+zHKbh0yUXzre3H2DRXoPrmNR
        +w37w=;
Received: from [209.82.80.116] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3AiT-0008HB-Bn; Fri, 21 Sep 2018 01:58:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BE321440078; Fri, 21 Sep 2018 02:58:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da905{2,5}: Remove unnecessary array check" to the regulator tree
In-Reply-To: 
Message-Id: <20180921015840.BE321440078@finisterre.ee.mobilebroadband>
Date:   Fri, 21 Sep 2018 02:58:40 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da905{2,5}: Remove unnecessary array check

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

From 5a7d7d0f9f791b1e13f26dbbb07c86482912ad62 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 20 Sep 2018 17:04:20 -0700
Subject: [PATCH] regulator: da905{2,5}: Remove unnecessary array check

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/regulator/da9052-regulator.c:423:22: warning: address of array
'pdata->regulators' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pdata && pdata->regulators) {
                  ~~ ~~~~~~~^~~~~~~~~~
drivers/regulator/da9055-regulator.c:615:22: warning: address of array
'pdata->regulators' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pdata && pdata->regulators) {
                  ~~ ~~~~~~~^~~~~~~~~~

Link: https://github.com/ClangBuiltLinux/linux/issues/142
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9052-regulator.c | 2 +-
 drivers/regulator/da9055-regulator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 9ececfef42d6..37e4025203e3 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -420,7 +420,7 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.driver_data = regulator;
 	config.regmap = da9052->regmap;
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[cell->id];
 	} else {
 #ifdef CONFIG_OF
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index f40c3b8644ae..588c3d2445cf 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -612,7 +612,7 @@ static int da9055_regulator_probe(struct platform_device *pdev)
 	config.driver_data = regulator;
 	config.regmap = da9055->regmap;
 
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[pdev->id];
 	} else {
 		ret = da9055_regulator_dt_init(pdev, regulator, &config,
-- 
2.19.0

