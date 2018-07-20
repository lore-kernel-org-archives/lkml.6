Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBA320673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeGTIwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:52:25 -0400
Received: from mout.perfora.net ([74.208.4.196]:43149 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbeGTIwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:52:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M0SMt-1g0yzf2D6r-00udhf; Fri, 20 Jul 2018 10:04:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/2] ASoC: tegra: improve goto error label
Date:   Fri, 20 Jul 2018 10:04:23 +0200
Message-Id: <20180720080424.31505-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:bxEoqQmibD/NUR4afCiYg8b5ZXqz8NK2vFQb3gMon70TjzZrHQ4
 +yQelCMZ3wo5BAsH0/v4oQFWUG+oDMZ1MQ1dLYoCQeM3/3CyybrtqVExDXBvbsggVD+7RUL
 s7pnV/JTnFG0BdkGNzayA9EuIQ1moVpLMPbKAmC0ZhLIAESY34IFTjCRWrQNAA8ILbdEXYB
 lJNGmv3rnj5hiMI1PJIfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+m9PrdckY8U=:67vIO9I0zDvCshXSs0uO05
 PIaXzTiKcr3ieip3050S7KGUHd8hSFRmaFFHKrtsoFVqDiottJcMi6FMPy4SjOHH98/i+K4Q7
 YOLZPFHvLIlPLvI8i2Rv/xesHxv6YiUXCfh4ly6ODqrc6Xbkubj64mApR9Omvnyk8mt/ivoYL
 Odt/tdiccxYmMltTv1WsFqsRLNJNI4FuUcAMxsda1C0/gqNeYns0yYepvAWjO9h3WlMV8agbh
 NX0WbxN0rBYl1hwgBs23Mbxb+AVJpDj2Dp8WlOE3xT24a7xBepa3a1qgJTMn1iEZlb49NRGfC
 Y3EHx/5zwitm5zoHAAu9xWp7DuUCaG45xWP7+2mjadusYjrV1BDx2y2ljX45V3RFCnayrXwzZ
 cEufQWOE19f40B2SAqtVMSXFiemU9/JDIp/4f6plTQd1VxNn71Z1F8xw19vPnDYua+6XRUamO
 lFk6nMSxE3X5ZPmlodtPCgMW8g1JtZPwNGwJ8x4d8ms7Odb0dpALPmcsYkVP7pgUPfsf2bOAL
 7ZFJR1pjjJWIUuoJTLVB2cck/LMEDsB7fFqzXQOXy50ZgwS4StTntWiWweiJvn5oxJARjrokU
 oRxGK76NtyWYBwFjvIXPtvHSh/EoPa42f98jTPOi6DaAfa84RZ1lL44857Z+xxihAkXvXmOFP
 pAIqcAIAwvi7+3cE6YUBrROfJRbAInBGuouKtZvVSDtmf/Pog2BYfwrp466pmmigHKOs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

While the two error labels "err" and "err_clk_put" goto the same place
it is rather confusing that the earlier one is certainly used later
again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

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
2.14.4

