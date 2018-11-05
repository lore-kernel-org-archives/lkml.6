Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B723C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0451420854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ip8cK/wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0451420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeKEVQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:16:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeKEVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=o8MTLegWK+ElgG+wOkbg3lttm7lK/IuvB7lhcy2TAfQ=; b=Ip8cK/wB0kyQ
        FXpOwmcHZhF7wR0TCCS4VuDxPU5GazAmBi/oQsndMdGYuQI8P04Zv+7EFt6K/d2vLviWf/1Lse/A0
        gLC52Dp2SvUozJ2S2NQQSdruF7mmQ4SCxgtI7tF1PeCh7woizIS4o5ThycH4VC+jCoU2dPyBbWhZq
        6kDXc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdVK-0008HK-2v; Mon, 05 Nov 2018 11:57:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A86111124D98; Mon,  5 Nov 2018 11:57:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        niklas.cassel@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask" to the asoc tree
In-Reply-To:  <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
Message-Id: <20181105115713.A86111124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 11:57:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask

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

From 112b57fa737445b2361be332ce8cc0fd3e2b994e Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 1 Nov 2018 17:21:07 +0530
Subject: [PATCH] ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask

SD line mask for MI2S starts from BIT 0 instead of BIT 1.
Fix all bit mask for MI2S SD lines.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 000775b4bba8..829b5e987b2a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -49,14 +49,14 @@
 #define AFE_PORT_I2S_SD1		0x2
 #define AFE_PORT_I2S_SD2		0x3
 #define AFE_PORT_I2S_SD3		0x4
-#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
-#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
-#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
-#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
-#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
-#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
-#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
-#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
+#define AFE_PORT_I2S_SD0_MASK		BIT(0x0)
+#define AFE_PORT_I2S_SD1_MASK		BIT(0x1)
+#define AFE_PORT_I2S_SD2_MASK		BIT(0x2)
+#define AFE_PORT_I2S_SD3_MASK		BIT(0x3)
+#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(1, 0)
+#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(3, 2)
+#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(2, 0)
+#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
 #define AFE_PORT_I2S_QUAD01		0x5
 #define AFE_PORT_I2S_QUAD23		0x6
 #define AFE_PORT_I2S_6CHS		0x7
-- 
2.19.0.rc2

