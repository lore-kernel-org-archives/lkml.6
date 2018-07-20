Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5122ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F99C20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="onW7HWe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F99C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeGTNHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:07:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36990 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbeGTNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xKvCS492BAbyVCdSZqMnH8TCuND1hth3jM+zkFtL9Dk=; b=onW7HWe62Jtd
        5E7pn0P1mJH8cSiCBCidDnIjFdJnd8MHo9o2Q1Ld5v8vwPu78cs+S0juUx3vaq1pmibN/IrPF+ra7
        wt60n8T6qscedXNx/nJW6UzzPtqai5ddlP2ub497PVMX5BZ/iuYoAJ1g+j37U+CqLSKjdLindrMjK
        l5zCI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUNR-0008Le-4G; Fri, 20 Jul 2018 12:19:17 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUNQ-0006A3-Lc; Fri, 20 Jul 2018 13:19:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: tegra: improve goto error label" to the asoc tree
In-Reply-To:  <20180720080424.31505-1-marcel@ziswiler.com>
Message-Id: <E1fgUNQ-0006A3-Lc@debutante>
Date:   Fri, 20 Jul 2018 13:19:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tegra: improve goto error label

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

From 2ec42486358f63c4a426514c395d13f4b9de5da8 Mon Sep 17 00:00:00 2001
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Date: Fri, 20 Jul 2018 10:04:23 +0200
Subject: [PATCH] ASoC: tegra: improve goto error label

While the two error labels "err" and "err_clk_put" goto the same place
it is rather confusing that the earlier one is certainly used later
again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra20_ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index affad46bf188..682ef33afb5f 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -377,7 +377,7 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(ac97->clk_ac97);
 	if (ret) {
 		dev_err(&pdev->dev, "clk_enable failed: %d\n", ret);
-		goto err;
+		goto err_clk_put;
 	}
 
 	ret = snd_soc_set_ac97_ops(&tegra20_ac97_ops);
-- 
2.18.0

