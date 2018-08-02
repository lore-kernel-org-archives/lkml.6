Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FFFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D37A214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TYq5/JcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D37A214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeHBMBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:01:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbeHBMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lPJk0B3Ahmcgact7jdu8GpmzLOf8GHOa8xS5+zI6ndM=; b=TYq5/JcRsmBQ
        dBDoknvTseUFwinDE5xr0hseyVJRAbPb+GJjnzyp6XpJZfiRmjxB0CIHq2IzSBfIdwAQzaEykjXfw
        Y+q5QeN0CwwWojL0rKKy75NFIEeNZrUJsl1DgFgw4GjZTAeKuq0IJO1YCoJpe7T+6GqJCly7Rhshk
        KWPKE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flAYt-0001qD-69; Thu, 02 Aug 2018 10:10:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E72121124241; Thu,  2 Aug 2018 11:10:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, sfr@canb.auug.org.au, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845" to the asoc tree
In-Reply-To:  <1533193379-1125-1-git-send-email-rohitkr@codeaurora.org>
Message-Id: <20180802101026.E72121124241@debutante.sirena.org.uk>
Date:   Thu,  2 Aug 2018 11:10:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845

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

From 73edbe42582207ff8f47168f05124376394aa643 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 2 Aug 2018 12:32:59 +0530
Subject: [PATCH] ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845

Add DEPENDS_ON QCOM_APR for SND_SOC_SDM845 to fix the
warning: unmet direct dependencies detected for
SND_SOC_QDSP6.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 350730839c6f..5f03312ef007 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -93,6 +93,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
+	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
-- 
2.18.0

