Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8632EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A23D20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="o7Hvbbp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A23D20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeGTRea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:34:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeGTRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oPz4/c6xGcoiPZZJs3nm3zNCFiO7d94tXeO0WGLc9/0=; b=o7Hvbbp/DA4t
        irTIxX7j5oxWwIAmhdYVAHK3sEZ/F3lGyYJb5gV89D1X0M8t4pM/ItuKZfA7qTf5Wc4jI1XCahZTq
        OeUBTEGykoGRTc3gThRzehHBTJrrBRj+3KQrPtq3+Sug1UH+pkv9aaKP42COa2EYInatb0QP67pkf
        Mva6A=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYWv-00006H-Pk; Fri, 20 Jul 2018 16:45:21 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYWv-00014q-CE; Fri, 20 Jul 2018 17:45:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: qcom_spmi: Do not initialise static to NULL" to the regulator tree
In-Reply-To:  <20180716113525.9335-4-niklas.cassel@linaro.org>
Message-Id: <E1fgYWv-00014q-CE@debutante>
Date:   Fri, 20 Jul 2018 17:45:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: qcom_spmi: Do not initialise static to NULL

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

From 9689ca0af345b82d06a02e45cc214c1b8bad9e8d Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Mon, 16 Jul 2018 15:32:53 +0200
Subject: [PATCH] regulator: qcom_spmi: Do not initialise static to NULL

Fix the following checkpatch error:

ERROR: do not initialise statics to NULL
+static struct regmap *saw_regmap = NULL;

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index ba3d5e63ada6..5246f5b870c2 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1060,7 +1060,7 @@ static irqreturn_t spmi_regulator_vs_ocp_isr(int irq, void *data)
 #define SAW3_AVS_CTL_TGGL_MASK	0x8000000
 #define SAW3_AVS_CTL_CLEAR_MASK	0x7efc00
 
-static struct regmap *saw_regmap = NULL;
+static struct regmap *saw_regmap;
 
 static void spmi_saw_set_vdd(void *data)
 {
-- 
2.18.0

