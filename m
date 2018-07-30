Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BEAFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F6020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mZ5Zx0d2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F6020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeG3MjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:39:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53250 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeG3MjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cNtGTNl8jrZeyl63llsUb7drF696+23vUyPsfsplRkk=; b=mZ5Zx0d2scqn
        gpwMv9lVNPna6ZSy3QLdLSRJW2i3Rz0cAam/fylUwr6ANAPqCN+10toMK4J3Rat6adpyNR1aTC6PF
        a5QP0+QvNyU4ccAeuU0KVgZQahIkuOyah5pt8s2n/o04A/x3XaF4Mn1UGWg7LoTdLqH9FYEnyAq61
        4a3uo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5yn-000553-KD; Mon, 30 Jul 2018 11:04:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5F46B1124216; Mon, 30 Jul 2018 12:04:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Edward Cragg <edward.cragg@codethink.co.uk>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@lists.codethink.co.uk,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tegra: i2s: Fix typo/broken macro" to the asoc tree
In-Reply-To:  <20180727125931.9794-2-jorge.sanjuan@codethink.co.uk>
Message-Id: <20180730110445.5F46B1124216@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 12:04:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tegra: i2s: Fix typo/broken macro

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

From 279fef50b607f9cee94f10bae84f6730e97ccd7c Mon Sep 17 00:00:00 2001
From: Edward Cragg <edward.cragg@codethink.co.uk>
Date: Fri, 27 Jul 2018 13:59:28 +0100
Subject: [PATCH] ASoC: tegra: i2s: Fix typo/broken macro

Fix typo in macro TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK.

Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra30_i2s.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra30_i2s.h b/sound/soc/tegra/tegra30_i2s.h
index 774fc6ad2026..2e561e946de2 100644
--- a/sound/soc/tegra/tegra30_i2s.h
+++ b/sound/soc/tegra/tegra30_i2s.h
@@ -173,7 +173,7 @@
 /* Number of slots in frame, minus 1 */
 #define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT		16
 #define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK_US	7
-#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK		(TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOT_MASK_US << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOT_SHIFT)
+#define TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK		(TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK_US << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT)
 
 /* TDM mode slot enable bitmask */
 #define TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT	8
-- 
2.18.0

