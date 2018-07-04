Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFB123E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Pdb4yHoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFB123E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeGDOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:42:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeGDOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=luMX18FR54deKDrH89ZohWTK0VlRTUB+RJ0dimfHURo=; b=Pdb4yHoaq/uX
        1wK+1p2tFrh0nj4rDWPw5dZHmAT5JvMUw7BDrGnBPN5UfelH2c3VHt9dgTnkQaIY2ZXfaC18Ltiw+
        FTqb+D95pBPXpOxfUXDyr0rfSB6iUQQuqUIaiXnBcXl/oZaj/MHXsduuxT4/+tHnSkWR9mlut+uQH
        7xpXw=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyp-00073h-3w; Wed, 04 Jul 2018 14:42:03 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyo-0003zj-L2; Wed, 04 Jul 2018 15:42:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe: Add missing slimbus capture ports" to the asoc tree
In-Reply-To:  <20180704094944.16440-2-srinivas.kandagatla@linaro.org>
Message-Id: <E1faiyo-0003zj-L2@debutante>
Date:   Wed, 04 Jul 2018 15:42:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe: Add missing slimbus capture ports

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

From 25090bc3f36cc3c171ec020dcc89c71db6bd0a67 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:39 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe: Add missing slimbus capture ports

Existing code already has support for SLIMbus TX and RX, only thing
that was missing from TX side was mapping between virtual to actual
DSP port ids.

This patch adds those mappings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 671743453fbb..000775b4bba8 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -514,6 +514,20 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				SLIMBUS_5_RX, 1, 1},
 	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
 				SLIMBUS_6_RX, 1, 1},
+	[SLIMBUS_0_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX,
+				SLIMBUS_0_TX, 0, 1},
+	[SLIMBUS_1_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX,
+				SLIMBUS_1_TX, 0, 1},
+	[SLIMBUS_2_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX,
+				SLIMBUS_2_TX, 0, 1},
+	[SLIMBUS_3_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX,
+				SLIMBUS_3_TX, 0, 1},
+	[SLIMBUS_4_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX,
+				SLIMBUS_4_TX, 0, 1},
+	[SLIMBUS_5_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX,
+				SLIMBUS_5_TX, 0, 1},
+	[SLIMBUS_6_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX,
+				SLIMBUS_6_TX, 0, 1},
 	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
 				PRIMARY_MI2S_RX, 1, 1},
 	[PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
@@ -1372,6 +1386,13 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX:
-- 
2.18.0.rc2

