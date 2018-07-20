Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0C820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbeGTIvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:51:54 -0400
Received: from mout.perfora.net ([74.208.4.196]:42739 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeGTIvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:51:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MRmud-1fZf4934tV-00SyRn; Fri, 20 Jul 2018 10:04:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Date:   Fri, 20 Jul 2018 10:04:24 +0200
Message-Id: <20180720080424.31505-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720080424.31505-1-marcel@ziswiler.com>
References: <20180720080424.31505-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ont/fEOq6Ti2cNWyJh7UAxOMsT+dtNakUjlzMR2TwzPf5d6Keaf
 MNU7ULd71P23UgBCXtQFW99AIASL5aPtzG1J2Fxb01yCQuixhQ1YQindQXJJkp5V7hn20uE
 /dOglQdf41A39yQjzuko97qf2bSo9g+yqiWRFlCDMaJCiRhrChICd9uaRVznDRjEXtjVM6U
 cKxM7SAWtvXwBZm0qTSgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r1pop4lALAk=:Nz1Wefe8hOC0/IeREgk3jw
 p6TRSqxpyC+tqMLkLAzCupYlyBbSqSj+8MrPxKogbF+AVyIIc9ohCOnh9hoXKwBF+UswQvMpx
 rGeHcn5dV4PdySauci4DxvXUJT2Q2WVmlVTy9+asrH5HcVGtQGKv6BnRtbhE0/DjGaW3e/S25
 OsN/dqd7ududsE7oO7FtBczdrU58ZIjpmo/EGxncpOLKCnFMRjBjmAlUTKNlsYu7eFn9tIySA
 K/4x9APQ3MR4OOcqAXD+eZyHY4i19tR7fl6XmAsI7giVyrz6wPBKsrPT+Vs7yddScSi7A1MXh
 J7kkSBQWZkXmR4hs/FOFMgEXbfbnQwzw3uYlMVmaNzZcyDss8Y3K5VTLqmQZvfB5L+UcX5ybh
 FMnV4xofTlgnxPK3ObzGR8J1zG9/wEWvpjMHLWbsekhatBj4T4DWbuHfZ3TALxIYG5r21An5a
 5Lh3CMHINqKcwsrHQCJ8LVUzvVSD/EytzBuFE8Ehsy6MxioZiLhI7J7jcxLAnf7jZyWFguZlI
 3qUFyjraUqT4RkMYKvgvis8KEm4Ev/29w23tuSks+Do0iXQNV9N7QROFO8rXLZtJap3pz0NDP
 fcMyLD5PFJi2RabZnptSnGUUruIM/Xbu4a3/QPRWeLYNkihSi3/PHaVGtFIs8RJ8IDwekvJ9k
 4DaV4E86tgf8e8p7D1jHQFiBO0n5N3US2PNJT/j6QZZp/Xmqebysve97o5xmYwbNKLVY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error codes from of_get_named_gpio() resp.
devm_gpio_request_one() upon trying to get the codec reset resp. sync
GPIOs which may as well just be a probe deferrals.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 sound/soc/tegra/tegra20_ac97.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 682ef33afb5f..4875512f0732 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -351,18 +351,21 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 		ret = devm_gpio_request_one(&pdev->dev, ac97->reset_gpio,
 					    GPIOF_OUT_INIT_HIGH, "codec-reset");
 		if (ret) {
-			dev_err(&pdev->dev, "could not get codec-reset GPIO\n");
+			dev_err(&pdev->dev, "could not get codec-reset GPIO: "
+					    "%d\n", ret);
 			goto err_clk_put;
 		}
 	} else {
-		dev_err(&pdev->dev, "no codec-reset GPIO supplied\n");
+		ret = ac97->reset_gpio;
+		dev_err(&pdev->dev, "no codec-reset GPIO supplied: %d\n", ret);
 		goto err_clk_put;
 	}
 
 	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
 					    "nvidia,codec-sync-gpio", 0);
 	if (!gpio_is_valid(ac97->sync_gpio)) {
-		dev_err(&pdev->dev, "no codec-sync GPIO supplied\n");
+		ret = ac97->sync_gpio;
+		dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n", ret);
 		goto err_clk_put;
 	}
 
-- 
2.14.4

