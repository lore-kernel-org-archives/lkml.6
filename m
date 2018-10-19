Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B15ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7312087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tpElYZsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7312087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJSUj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:39:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51464 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nh2kojcw2jaKby+BJCN49CIPjDIrukbxVKSOzGMgGOY=; b=tpElYZsKZoFo
        1ktbRMjeqDDNTcr0PFYtycULn29u8fb+3QHieHeSLb6UwH8e1DL3KjCLBQDX9kOpO2T1/VGdY7yWD
        f9Xmwqy6c/jHOlH4oS7YzrkCNKL5Eo6O5l9BXRp/RBW2fl+I6sAPvGwKKzVnXkWkygv5QmprrHF5F
        iKkfg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTyR-00006W-3g; Fri, 19 Oct 2018 12:33:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D34AD1122548; Fri, 19 Oct 2018 13:33:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: add mclk support" to the asoc tree
In-Reply-To:  <1539612216-12602-5-git-send-email-olivier.moysan@st.com>
Message-Id: <20181019123350.D34AD1122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:33:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add mclk support

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

From 5e8d63a726f8f2fef089515e9a501785cc67dcdc Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 15 Oct 2018 16:03:36 +0200
Subject: [PATCH] ASoC: cs42l51: add mclk support

Add MCLK dapm to allow configuration of cirrus CS42l51
codec as a master clock consumer.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 5080d7a3c279..eb40bff54cec 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -237,6 +237,10 @@ static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
 		&cs42l51_adcr_mux_controls),
 };
 
+static const struct snd_soc_dapm_widget cs42l51_dapm_mclk_widgets[] = {
+	SND_SOC_DAPM_CLOCK_SUPPLY("MCLK")
+};
+
 static const struct snd_soc_dapm_route cs42l51_routes[] = {
 	{"HPL", NULL, "Left DAC"},
 	{"HPR", NULL, "Right DAC"},
@@ -487,6 +491,10 @@ static struct snd_soc_dai_driver cs42l51_dai = {
 static int cs42l51_component_probe(struct snd_soc_component *component)
 {
 	int ret, reg;
+	struct snd_soc_dapm_context *dapm;
+
+	dapm = snd_soc_component_get_dapm(component);
+	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
 
 	/*
 	 * DAC configuration
-- 
2.19.0.rc2

