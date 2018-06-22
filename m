Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2367C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D9624407
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="a1fNsAMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D9624407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933794AbeFVOun (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:50:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeFVOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=p9yR7Hnp59+iNbFzzVTtC/DzyXL6g7B9mKW6ScId3eE=; b=a1fNsAMB+2CN
        ShtQCEi5iNLLWek99VD4OfJKAaeL6kEghOOs2psb0aWQB/01IfFizuWSDEN3lmENI2NuhR+VTXWN1
        36W7mYBS68Ma+9LtaewHCjMvIVMv3oD7iri6vJN0LFDBPIROmqvXR0bOk0u9q47GbwSusdMCWsGa7
        lgIMw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNOS-0003uh-MP; Fri, 22 Jun 2018 14:50:32 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNOS-0002fp-81; Fri, 22 Jun 2018 15:50:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: remove redundant check of PLL ID" to the asoc tree
In-Reply-To:  <20180621025628.4046-1-suzuki.katsuhiro@socionext.com>
Message-Id: <E1fWNOS-0002fp-81@debutante>
Date:   Fri, 22 Jun 2018 15:50:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: remove redundant check of PLL ID

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 366f074d047b2538cc5d7e4a820bb6c117a3ccec Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Thu, 21 Jun 2018 11:56:28 +0900
Subject: [PATCH] ASoC: uniphier: remove redundant check of PLL ID

This patch removes redudant check of PLL ID. struct uniphier_aio_pll
enable member has already been checked at is_valid_pll().

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 2d9b7dde2ffa..ee90e6c3937c 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -219,15 +219,10 @@ static int uniphier_aio_set_pll(struct snd_soc_dai *dai, int pll_id,
 				unsigned int freq_out)
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
-	struct device *dev = &aio->chip->pdev->dev;
 	int ret;
 
 	if (!is_valid_pll(aio->chip, pll_id))
 		return -EINVAL;
-	if (!aio->chip->plls[pll_id].enable) {
-		dev_err(dev, "PLL(%d) is not implemented\n", pll_id);
-		return -ENOTSUPP;
-	}
 
 	ret = aio_chip_set_pll(aio->chip, pll_id, freq_out);
 	if (ret < 0)
-- 
2.18.0.rc2

