Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80252C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09F21709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A09F21709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeHNBVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:21:25 -0400
Received: from mout.perfora.net ([74.208.4.194]:55955 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbeHNBVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:21:25 -0400
Received: from localhost.net ([89.217.215.226]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id 0MYMgJ-1fKwOX1pZp-00V9WK;
 Tue, 14 Aug 2018 00:36:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2] ASoC: wm9712: fix replace codec to component
Date:   Tue, 14 Aug 2018 00:35:56 +0200
Message-Id: <20180813223556.16262-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:2BXCIdTxo+UcBIg8O9t6EZ8sCSWIxvjYReX3+bjDPlY5tIR5JYH
 ATe72+0qDOOzg2TaioevmZPFqkJzJ1EDOUYnLHdM+QIiejoDbaoTxDGI8Yr+kopchNSSvDU
 WDKlmBbGmM2DmYH/8poYZ676S0jVL8tRtrwu0C9llv2clcFZCMD3kYW2ngJXOtfcGQ73WgM
 Dl3ZeIysIr6eU9R0zdCLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1i8ykMsYRe4=:cftUe7qJ1+d2z6DObgBFZY
 lT2bubXEbaftPID0jbY8PiSEkwGfDsL054e72neIx4jucdDwwhUenUqb7bp5DisXKpDBL+QYC
 tNhNubNtYLT5cCpB0GOZnT6ZyCLXOCtfV8XaQSa/uar5dxBFTkS6JbuID0fkcG99CebxCPPbn
 r0/rkO8vq/Hiv2RlvKF9PeoRgX7U6W+XEHFAf9tpfkrtUcjPRPsE9eZ7qPV8EFtrXLHiyPOk4
 5++rqSgl4md2wak1n1LdMm+NxUy26iEwvdsPR7paZJk9QzVO6n8lr8/WFxIoFbLLHo9yw7jlN
 50Igk3bVDALYJH8ATWOg0pcVRFmzqKQD1s8rglmtkv4EpyfxD7r/+0BGW9mi+EficjF0SwEHF
 gMbau22fvyfqKw7L0wq+nrjM+C+4JVCbjckcZzgdEkHrPKCKgaikpeFwVw89iqSkfvlxfr0uX
 YuW4zSS3z83nAicshhqIQ939QxJCoB1O5TxofGZv1ibV3HS9ZJAgSOQUMpIQkhSKsVkqHrULn
 hElOw0asgSsaSZf6eY+e9uYPhDiI4O2zDkQ2mfd2uEZctY5eJKtFtkeOQiRcqCztarcFvom1a
 1fVx7ogj8QlpjhRuUCCYvELW/afmoNjMcBCPVvEcIfJBQq44CeM+nVekgRO8AHUfuCLUaLTkI
 yxDVrzL0N/8SoyntJrjOXbYKRZcj6Z3QOHx+FG3HjvFRcbdcTCGTziLFN1hapKSO97P0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
"wm9712-codec" got renamed to "wm9712-component", however, this change
never got propagated down to the actual board/platform drivers. E.g. on
Colibri T20 this lead to the following spew upon boot with sound/touch
being broken:

[    2.214121] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.222137] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.344384] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.351885] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.668339] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.675811] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.208408] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.216312] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.235397] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.248938] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[   14.970443] ALSA device list:
[   14.996628]   No soundcards found.

This commit finally fixes this again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Simply rename "wm9712-component" back to "wm9712-codec" as suggested
  by Kuninori and Charles.

 sound/soc/codecs/wm9712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 953d94d50586..ade34c26ad2f 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -719,7 +719,7 @@ static int wm9712_probe(struct platform_device *pdev)
 
 static struct platform_driver wm9712_component_driver = {
 	.driver = {
-		.name = "wm9712-component",
+		.name = "wm9712-codec",
 	},
 
 	.probe = wm9712_probe,
-- 
2.14.4

