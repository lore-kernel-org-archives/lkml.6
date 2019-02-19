Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68D421479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576872;
	bh=MQsCmNBECz9rqVFR/kCT4VeFtpl+VnO5lAf9vbGJ1KI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oQFS+7Soa60OctsC1I4X0R6XqR09utiQjl4oDKPIPL0vejwQM5ktl/+jiPEJ6sAo5
	 4d01PVHLDB8pMEnUTUe1UfIJX9y+LzMlK8Mfr+lM1dsFo7C2ylwquH3Lewz1fufz4s
	 JZUIzKX0CFCVLKn9z3viInNB2rmzGuOUkhhLopOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfBSLrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56600 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfBSLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gWrW107XXOcmZlPwv9dOaLOM6StImDOf61y2AC+glFU=; b=ZkmuSLQj8pcy
        +gDW8eB/sk7bOG/idkn8e8J1d8qb+QIJ/SNuhpyCUwTAgt5aKImv32RReR2QRU3EH2aNa8ehZyVel
        VxJ0jEcvQt/elKzQNApni6+5CmGBVLa0KTCQBoAaRbkQc/XY7SGWjZbWoGyPdSLX5oL3dAumB0bFO
        /b+wM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3rp-0008Sh-1Z; Tue, 19 Feb 2019 11:47:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6643D11284A6; Tue, 19 Feb 2019 11:47:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     pascal paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Change buck1 voltage range" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114716.6643D11284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Change buck1 voltage range

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

From 48593a99a1f6245000fa90606dd9ec5eb96b54a6 Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:34 +0000
Subject: [PATCH] regulator: stpmic1: Change buck1 voltage range

Change buck1 voltage range to be conform with the data-sheet.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 16ba0297f709..a1f88e996cae 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -75,9 +75,10 @@ enum {
 #define STPMIC1_BUCK_MODE_NORMAL 0
 #define STPMIC1_BUCK_MODE_LP BUCK_HPLP_ENABLE_MASK
 
-struct regulator_linear_range buck1_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000, 0, 30, 25000),
-	REGULATOR_LINEAR_RANGE(1350000, 31, 63, 0),
+static const struct regulator_linear_range buck1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(725000, 0, 4, 0),
+	REGULATOR_LINEAR_RANGE(725000, 5, 36, 25000),
+	REGULATOR_LINEAR_RANGE(1500000, 37, 63, 0),
 };
 
 struct regulator_linear_range buck2_ranges[] = {
-- 
2.20.1

