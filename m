Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30019C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB76820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791777;
	bh=+tzHGSmDIefTope3vig1jOcVe5BGwL8HWt5DZTLBsRo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0loP5TJiu+2LjC+2nJIgUNhK1tRTnju0fDxY8rRvkqHob43TekJqkQpWrpoFkeg3a
	 8oBq7/cRP3mZIYi3xZSo5bgI3Fw/BlEbpc7gwcMqpmMgrUjQKAli8vK09meyHxMAm6
	 O2weDyTvRzFdXWeNxK+beDZyaZAUVHSKGNXO/GNQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB76820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeLNMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:49:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbeLNMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0bB4PLckI1shwNpPODpD2dsxpFJc4ybc7gMArjJbnfo=; b=Re/MJ+Km/ebX
        LIV9b5B5eRjq56QgcJphWF79Tp5eeY8HwbxdngRAClwNmpIjiHMLX4HQXkEIUTr4W/duRkeqq8nIe
        6ha/KWE1WnZ1ncthZkIyRsebWsg9jH3gVGRiGsJvpsye5oXbLfsmmfKtPAGqGFEpAqam7ro+emmXe
        aFuq4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXmuB-0006mS-0x; Fri, 14 Dec 2018 12:49:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9B3BE11258A2; Fri, 14 Dec 2018 12:49:22 +0000 (GMT)
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
Subject: Applied "ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding" to the asoc tree
In-Reply-To:  <1544790569-10608-2-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20181214124922.9B3BE11258A2@debutante.sirena.org.uk>
Date:   Fri, 14 Dec 2018 12:49:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding

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

From 76119509d23cdd9fbc71585042b27b6511b44b4d Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 17:59:26 +0530
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding

This patch adds bindings required for DISPLAY_PORT_RX
port on AFE.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/dt-bindings/sound/qcom,q6afe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
index e2d3892240b8..1df06f8ad5c3 100644
--- a/include/dt-bindings/sound/qcom,q6afe.h
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -106,6 +106,7 @@
 #define QUINARY_TDM_TX_6	101
 #define QUINARY_TDM_RX_7	102
 #define QUINARY_TDM_TX_7	103
+#define DISPLAY_PORT_RX		104
 
 #endif /* __DT_BINDINGS_Q6_AFE_H__ */
 
-- 
2.19.0.rc2

