Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA961C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8191A214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791769;
	bh=kXFGYBUZzVyyXnYEu1D8y9I4FrrH1CAYEoD+29MWjAs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Aw60J56B2rV0BYRM8m46dodQbyH/QEQD5cbcPckGVAgQ0I24Ehq3seTLRVEQuHzdC
	 wku+kd8iAo/kT8PhOXEFYqsHh2OSaAMwNzAMvu8JcLL4zWnOA6++vEzqdJpfBbfc74
	 4kMWFnjm13iKKvs0xocUgk50IQzMv5XptGvchlo8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8191A214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeLNMt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:49:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbeLNMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ha+ZMm8IZIDTfcM6dTNAfGqvUgj/YlPZmWGjQbF0vio=; b=TOAatDnjHgw3
        u3h5AyPIu2IHtyuebovrOeIq+u1DGwQjBWZ5sCPFhd+qX999ezwwoUjQEto1fB7RZjNfczJFNW4QY
        dygy76ojBV/UexT3d3WPpY0opEM3UtdJCbAwAB4eNZl0nhb1t/ptQ5xMmpvG4DiH5wD5+9OP4ZOux
        tjek4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXmu9-0006mF-4U; Fri, 14 Dec 2018 12:49:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BE0F911258A2; Fri, 14 Dec 2018 12:49:20 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org,
        asishb@codeaurora.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: qdafe: add support for display_port_rx" to the asoc tree
In-Reply-To:  <1544790569-10608-3-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20181214124920.BE0F911258A2@debutante.sirena.org.uk>
Date:   Fri, 14 Dec 2018 12:49:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: qdafe: add support for display_port_rx

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

From 3f6856a28f5eeb4fcaeb3ae25118171747354e51 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:27 +0530
Subject: [PATCH] ASoC: qdsp6: qdafe: add support for display_port_rx

This patch adds support for Display_Port_Rx
port in AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 829b5e987b2a..e0945f7a58c8 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -71,6 +71,7 @@
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+#define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
 
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
 /* Clock set API version */
@@ -704,6 +705,8 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				QUINARY_TDM_RX_7, 1, 1},
 	[QUINARY_TDM_TX_7] =  { AFE_PORT_ID_QUINARY_TDM_TX_7,
 				QUINARY_TDM_TX_7, 0, 1},
+	[DISPLAY_PORT_RX] = { AFE_PORT_ID_HDMI_OVER_DP_RX,
+				DISPLAY_PORT_RX, 1, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -1384,6 +1387,7 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 
 	switch (port_id) {
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
+	case AFE_PORT_ID_HDMI_OVER_DP_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
-- 
2.19.0.rc2

