Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_24_48,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D6C21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfAIONp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:13:45 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:9050 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731138AbfAIONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:43 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 36/1C-21142-391063C5; Wed, 09 Jan 2019 14:13:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileJIrShJLcpLzFFi42I5+MHzqO5kRrM
  Yg+XztSxOtexht7hy8RCTxdSHT9gs9p7/yGzx7UoHk8XlXXPYLDp39bNabPi+ltGBw2PD5yY2
  j9ZLf9k8ds66y+6xYFOpx6ZVnWwe+94uY/NYv+Uqi8fnTXIBHFGsmXlJ+RUJrBn/P19gLzghX
  7F71i3mBsZ+6S5GLg4hgXWMEk8/dLB0MXICORUSk2deZgaxeQUyJT7enckOYnMKuEu8bDzCDF
  HjJjFl9xcmEJtNwEJi8okHbCA2i4CKxOHV7WBzhAVCJf4/fwdmiwh0MUqcP+oNsoxZ4BCjxK7
  NO9khFghKnJz5BKyIWUBC4uCLF1ALDCROL2gEi0sI2EtMf38VKM4BZOtLNB6LhQgbSnyf9Q2q
  xFxixcMFbBMYBWchmToLydQFjEyrGC2SijLTM0pyEzNzdA0NDHQNDY10DS2NdY1MDPQSq3QT9
  VJLdctTi0t0DfUSy4v1iitzk3NS9PJSSzYxAuMopeDghx2MC1vSDzFKcjApifJu+W4aI8SXlJ
  9SmZFYnBFfVJqTWnyIUYaDQ0mC14PBLEZIsCg1PbUiLTMHGNEwaQkOHiURXj5gVAvxFhck5hZ
  npkOkTjEqSonzcv4CmikAksgozYNrgyWRS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEectA
  tvNk5pXATX8FtJgJaPEhRhOQxSWJCCmpBsauojvTu+auODTr34buGdOF8256hHD11Eb+mLiWo
  StRu4eNdd3h5hsGxxJ2KH9V+nVyz5Z0rw65GcWaHhPun34w71zi3u1vD93u/nrioYP8Cfefdi
  cmM79nvOv6MPS0TKDQsitLZK99/uxwdLPw3Wk9nPO4a7f1/s5dMOGh+l5/x+JyHxXd6FuMSiz
  FGYmGWsxFxYkA2RVmeB0DAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-268.messagelabs.com!1547043218!1157657!6
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6274 invoked from network); 9 Jan 2019 14:13:39 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-4.tower-268.messagelabs.com with AES128-SHA256 encrypted SMTP; 9 Jan 2019 14:13:39 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 9 Jan 2019 14:13:39 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 EB8343FB36; Mon,  7 Jan 2019 16:11:47 +0000 (GMT)
Message-ID: <ef671ed1c4a5b86036da5b2adf5be7d79ec56c7d.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 7 Jan 2019 16:11:47 +0000
Subject: [PATCH 2/2] ASoC: da7219: Add recalc_rate function to return DAI
 clock rate
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

By making MCLK parent of DAI clocks, when querying the rate of the
clock the rate returned is now given from the parent clock so
gives the MCLK rate rather than 0 as previously returned. This is
a bit misleading, and actually there's no major reason why we can't
at least return the DAI WCLK rate, as set in HW, so that's what we
now do.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 66dd4c2..3a073ca 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1767,7 +1767,7 @@ static int da7219_dai_clks_prepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK,
@@ -1780,7 +1780,7 @@ static void da7219_dai_clks_unprepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK, 0);
@@ -1790,7 +1790,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 	u8 clk_reg;
 
 	clk_reg = snd_soc_component_read32(component, DA7219_DAI_CLK_MODE);
@@ -1798,10 +1798,47 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
 
+static unsigned long da7219_dai_clks_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv, dai_clks_hw);
+	struct snd_soc_component *component = da7219->component;
+	u8 fs = snd_soc_component_read32(component, DA7219_SR);
+
+	switch (fs & DA7219_SR_MASK) {
+	case DA7219_SR_8000:
+		return 8000;
+	case DA7219_SR_11025:
+		return 11025;
+	case DA7219_SR_12000:
+		return 12000;
+	case DA7219_SR_16000:
+		return 16000;
+	case DA7219_SR_22050:
+		return 22050;
+	case DA7219_SR_24000:
+		return 24000;
+	case DA7219_SR_32000:
+		return 32000;
+	case DA7219_SR_44100:
+		return 44100;
+	case DA7219_SR_48000:
+		return 48000;
+	case DA7219_SR_88200:
+		return 88200;
+	case DA7219_SR_96000:
+		return 96000;
+	default:
+		return 0;
+	}
+}
+
 static const struct clk_ops da7219_dai_clks_ops = {
 	.prepare = da7219_dai_clks_prepare,
 	.unprepare = da7219_dai_clks_unprepare,
 	.is_prepared = da7219_dai_clks_is_prepared,
+	.recalc_rate = da7219_dai_clks_recalc_rate,
 };
 
 static int da7219_register_dai_clks(struct snd_soc_component *component)
@@ -1825,6 +1862,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 
 	init.name = pdata->dai_clks_name;
 	init.ops = &da7219_dai_clks_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
 	da7219->dai_clks_hw.init = &init;
 
 	dai_clks = devm_clk_register(dev, &da7219->dai_clks_hw);
@@ -1912,6 +1950,7 @@ static int da7219_probe(struct snd_soc_component *component)
 	unsigned int rev;
 	int ret;
 
+	da7219->component = component;
 	mutex_init(&da7219->ctrl_lock);
 	mutex_init(&da7219->pll_lock);
 
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 3a00686..366cf46 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -809,6 +809,7 @@ enum da7219_supplies {
 
 /* Private data */
 struct da7219_priv {
+	struct snd_soc_component *component;
 	struct da7219_aad_priv *aad;
 	struct da7219_pdata *pdata;
 
-- 
1.9.1

