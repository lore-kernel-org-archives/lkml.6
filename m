Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C6C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D611218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfA3OgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:36:20 -0500
Received: from dd26836.kasserver.com ([85.13.145.193]:49006 "EHLO
        dd26836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731323AbfA3Ofz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:35:55 -0500
Received: from dayas.3.home (77.116.173.211.wireless.dyn.drei.com [77.116.173.211])
        by dd26836.kasserver.com (Postfix) with ESMTPSA id AFE393362C1F;
        Wed, 30 Jan 2019 15:26:03 +0100 (CET)
From:   Danny Milosavljevic <dannym@scratchpost.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Danny Milosavljevic <dannym@scratchpost.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 2/8] ASoC: sun4i-codec: Add Mic Playback Volume
Date:   Wed, 30 Jan 2019 11:39:38 +0100
Message-Id: <20190130103945.26692-3-dannym@scratchpost.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130103945.26692-1-dannym@scratchpost.org>
References: <20190130103945.26692-1-dannym@scratchpost.org>
MIME-Version: 1.0
Tags:   patch
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control "Mic Playback Volume" that allows the user to control the
MIC gain stage (common for Mic1 and Mic2) leading to the output mixer.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 7b965bc50..060a40b45 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -681,6 +681,9 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
+		       sun4i_codec_micin_loopback_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
