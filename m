Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_24_48,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567E72075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfAIONs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:13:48 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:17688 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731338AbfAIONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:45 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 14/29-19156-391063C5; Wed, 09 Jan 2019 14:13:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42I5+MHzqO5kRrM
  Yg3vXuS1Otexht7hy8RCTxdSHT9gs9p7/yGzx7UoHk8XlXXPYLDp39bNabPi+ltGBw2PD5yY2
  j9ZLf9k8ds66y+6xYFOpx6ZVnWwe+94uY/NYv+Uqi8fnTXIBHFGsmXlJ+RUJrBlTbh5jLNgsV
  bHmaQNTA+MBsS5GLg4hgXWMEnPO3GTtYuQEciokHjy5DmbzCmRKLL8+jx3E5hRwl3jZeIQZos
  ZNYsruL0wgNpuAhcTkEw/Yuhg5OFgEVCT2XvIACQsLeEsc+/sbbIyIQBejxPmj3iC7mAUOMUr
  s2ryTHWK+oMTJmU9YQGxmAQmJgy9eQM03kDi9oBEsLiFgLzH9/VVmkPkSAvoSjcdiIcKGEt9n
  fYMqMZdY8XAB2wRGwVlIps5CMnUBI9MqRoukosz0jJLcxMwcXUMDA11DQyNdQ0sgtjDXS6zST
  dRLLdUtTy0u0TXUSywv1iuuzE3OSdHLSy3ZxAiMopSCA7t3ML7vSj/EKMnBpCTKu+W7aYwQX1
  J+SmVGYnFGfFFpTmrxIUYZDg4lCV4PBrMYIcGi1PTUirTMHGA8w6QlOHiURHj5gDEtxFtckJh
  bnJkOkTrFqCglzsv5C2imAEgiozQPrg2WQi4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuYt
  A9nOk5lXAjf9FdBiJqDFhxhNQBaXJCKkpBoYm/fwqBTferO1KK/uUhWbkvqEfyUmp+a9/3D7W
  PPpXez9i5LniHZ1JD9J+df848Sn60zSr7tUHsyTWTerb/Pm9ZNcCr47hiR1v51ZdnFSg/mdXS
  43JP9N8Ps0yb3lRe26l2zzp1cuSGL+Wnt0rZ/Sl3WhtRyNkXzP4zo+O7vxGjtIuTT0T7R6rMR
  SnJFoqMVcVJwIAMxexKgcAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-268.messagelabs.com!1547043218!1157657!3
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6222 invoked from network); 9 Jan 2019 14:13:39 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-4.tower-268.messagelabs.com with AES128-SHA256 encrypted SMTP; 9 Jan 2019 14:13:39 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 9 Jan 2019 14:13:37 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 EB3623FB28; Mon,  7 Jan 2019 16:11:46 +0000 (GMT)
Message-ID: <ac23ca274965f4c811c0bbbbfe953589a20610c2.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 7 Jan 2019 16:11:46 +0000
Subject: [PATCH 1/2] ASoC: da7219: MCLK should be enabled before DAI clocks
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 09/01/2019 12:09:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For platforms using the Common Clock Framework to control the
codec's DAI clocks, MCLK should be enabled prior to DAI clocks
being turned on. For some platforms the codec is already
provided with an MCLK reference and can therefore control MCLK
itself as it needs to.

To improve functionality MCLK is now added as a parent to the
DAI clocks, if MCLK was provided, so that if they are enabled MCLK
will automatically be enabled as a prerequisite by the CCF.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e46e9f4..66dd4c2 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1804,7 +1804,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	.is_prepared = da7219_dai_clks_is_prepared,
 };
 
-static void da7219_register_dai_clks(struct snd_soc_component *component)
+static int da7219_register_dai_clks(struct snd_soc_component *component)
 {
 	struct device *dev = component->dev;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
@@ -1812,9 +1812,17 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 	struct clk_init_data init = {};
 	struct clk *dai_clks;
 	struct clk_lookup *dai_clks_lookup;
+	const char *parent_name;
+
+	if (da7219->mclk) {
+		parent_name = __clk_get_name(da7219->mclk);
+		init.parent_names = &parent_name;
+		init.num_parents = 1;
+	} else {
+		init.parent_names = NULL;
+		init.num_parents = 0;
+	}
 
-	init.parent_names = NULL;
-	init.num_parents = 0;
 	init.name = pdata->dai_clks_name;
 	init.ops = &da7219_dai_clks_ops;
 	da7219->dai_clks_hw.init = &init;
@@ -1823,7 +1831,7 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 	if (IS_ERR(dai_clks)) {
 		dev_warn(dev, "Failed to register DAI clocks: %ld\n",
 			 PTR_ERR(dai_clks));
-		return;
+		return PTR_ERR(dai_clks);
 	}
 	da7219->dai_clks = dai_clks;
 
@@ -1835,13 +1843,18 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 		dai_clks_lookup = clkdev_create(dai_clks, pdata->dai_clks_name,
 						"%s", dev_name(dev));
 		if (!dai_clks_lookup)
-			dev_warn(dev, "Failed to create DAI clkdev");
+			return -ENOMEM;
 		else
 			da7219->dai_clks_lookup = dai_clks_lookup;
 	}
+
+	return 0;
 }
 #else
-static inline void da7219_register_dai_clks(struct snd_soc_component *component) {}
+static inline int da7219_register_dai_clks(struct snd_soc_component *component)
+{
+	return 0;
+}
 #endif /* CONFIG_COMMON_CLK */
 
 static void da7219_handle_pdata(struct snd_soc_component *component)
@@ -1854,8 +1867,6 @@ static void da7219_handle_pdata(struct snd_soc_component *component)
 
 		da7219->wakeup_source = pdata->wakeup_source;
 
-		da7219_register_dai_clks(component);
-
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
 		case DA7219_MICBIAS_1_6V:
@@ -1947,6 +1958,11 @@ static int da7219_probe(struct snd_soc_component *component)
 		}
 	}
 
+	/* Register CCF DAI clock control */
+	ret = da7219_register_dai_clks(component);
+	if (ret)
+		return ret;
+
 	/* Default PC counter to free-running */
 	snd_soc_component_update_bits(component, DA7219_PC_COUNT, DA7219_PC_FREERUN_MASK,
 			    DA7219_PC_FREERUN_MASK);
-- 
1.9.1

