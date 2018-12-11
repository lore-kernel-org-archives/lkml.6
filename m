Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765D32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490959;
	bh=ulbXGNw0KnanQhvKmArLSxSv0/xrEyBrs6Uj8+HLV90=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Hy4aSn70gclQP1UQ1AdWNojq3nLz/8VplNHFl4OEg8RoLn4SEP0fto7LMEwa/1y31
	 ZRD1zhwuUKMYN5fFBdugCestPs2YnLf3s+WYLZPNWrstfCfUOnvXE/9aFjGGvgPZBl
	 i2X17o6RidCIH61QjgB0zHbbpWruiyYnaLqbTqsQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765D32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeLKBPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:15:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeLKBPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QmwAfIr1UKy9x9vNI6hLV2axH/xFpuziqznM7N1P1do=; b=ucsEkVpYS3x4
        bQtuvUcwVXbVrp+pnd0spfuR2m5l8Pmr9CGxise57HqAnaAyzORhWmP5oZDNEjM0tRzKSJWPMslSS
        QDy7mFpK/FFCSUYaEFen0A+9wEZGo6LNIp/agQWwzTkxi3tfrGLzDQGyIAn4woAQpzW9QGDAtlSE/
        oJ2+g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWeJ-0000KT-Vb; Tue, 11 Dec 2018 01:15:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9A1E311254C7; Tue, 11 Dec 2018 01:15:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: add rt5663 codec select" to the asoc tree
In-Reply-To:  <20181210204943.2581826-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20181211011547.9A1E311254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:15:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: add rt5663 codec select

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

From e9dc919043c56dccedce93fe402e6c94423a70b0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 21:49:28 +0100
Subject: [PATCH] ASoC: sdm845: add rt5663 codec select

Calling into the codec driver adds a dependency on that being reachable
from the module:

ERROR: "rt5663_sel_asrc_clk_src" [sound/soc/qcom/snd-soc-sdm845.ko]
undefined!

Add the corresponding select statement, as it is done in the other user
(Intel).

Fixes: f7485875a687 ("ASoC: sdm845: Add configuration for headset codec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2a4c912d1e48..1b9fc0665792 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -100,6 +100,7 @@ config SND_SOC_SDM845
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
+	select SND_SOC_RT5663
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.19.0.rc2

