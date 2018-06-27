Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A95C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1A62609B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jtjjIGzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1A62609B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965498AbeF0PAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:00:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965406AbeF0PAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RjCWIS6Zu59RfObN3Wgkus/W6nOZjk8I0MLUZWF79EM=; b=jtjjIGzBZELm
        kTtCGl1h8GuIu2XcPNn4N0O+CO9rM8GbzyYQUK+o0RDRM/p9krW3SCu2uXU234+2bd5F2RWsdHTF4
        Qhq8wHJ6AXC7WtAIB8/FNoyq6gOPN6Ztzm3HBE8iwI6+df79xVopsxkHSuYTlujGYv62Eu90lCAkK
        cm6rw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYBw5-0003G6-0n; Wed, 27 Jun 2018 15:00:45 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fYBw4-00066z-Ji; Wed, 27 Jun 2018 16:00:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: Staticize ldo_2_volts" to the regulator tree
In-Reply-To:  <20180627124014.30615-1-axel.lin@ingics.com>
Message-Id: <E1fYBw4-00066z-Ji@debutante>
Date:   Wed, 27 Jun 2018 16:00:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: Staticize ldo_2_volts

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

From adb78a8e24bbfe19df0d4dd19ee78cec351a5f04 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 27 Jun 2018 20:40:13 +0800
Subject: [PATCH] regulator: bd71837: Staticize ldo_2_volts

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd71837-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 6eae4d0432a2..403b45de1262 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -195,7 +195,7 @@ static const struct regulator_linear_range bd71837_ldo1_voltage_ranges[] = {
  * LDO2
  * 0.8 or 0.9V
  */
-const unsigned int ldo_2_volts[] = {
+static const unsigned int ldo_2_volts[] = {
 	900000, 800000
 };
 
-- 
2.18.0.rc2

